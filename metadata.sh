#!/bin/bash
# ======================================================
# Script Name : metadata.sh
# Version     : 1.2
# Description : metadata (Artist, Title, Album via argumen)
# Author      : munons
# Created     : 2025-09-10
# Updated     : 2025-10-02
# License     : Free for personal use
# GitHub      : https://github.com/munons
# Copyright   : © 2025 by munons
# ======================================================

# Argumen input
arg_artist="$1"
arg_title="$2"
arg_album="$3"

# Default album kalau kosong
album="${arg_album:-Jepang}"

mkdir -p render
logfile="process.log"
: >"$logfile"

# cek cover
cover=$(ls cover.{jpg,jpeg,png,webp} 2>/dev/null | head -n 1)
if [ -z "$cover" ]; then
  echo "❌ Tidak ada cover (cover.jpg/png/jpeg/webp)"
  exit 1
else
  echo "✅ Pakai cover: $cover"
fi

for f in *.{mp3,MP3,m4a,M4A,flac,FLAC,wav,WAV,ogg,OGG}; do
  [ -e "$f" ] || continue
  filename="${f%.*}"
  ext="${f##*.}"

  # Metadata asli dari file
  artis_exist=$(ffprobe -v error -show_entries format_tags=artist -of default=noprint_wrappers=1:nokey=1 "$f")
  judul_exist=$(ffprobe -v error -show_entries format_tags=title  -of default=noprint_wrappers=1:nokey=1 "$f")

  # Tentukan Artist
  if [ -n "$arg_artist" ]; then
      artis="$arg_artist"
  elif [ -n "$artis_exist" ]; then
      artis="$artis_exist"
  else
      if [[ "$filename" == *" - "* ]]; then
          artis=$(echo "$filename" | cut -d '-' -f1 | sed 's/ *$//')
      else
          artis="$filename"
      fi
  fi

  # Tentukan Title
  if [ -n "$arg_title" ]; then
      judul="$arg_title"
  elif [ -n "$judul_exist" ]; then
      judul="$judul_exist"
  else
      if [[ "$filename" == *" - "* ]]; then
          judul=$(echo "$filename" | cut -d '-' -f2- | sed 's/^ *//')
      else
          judul="$filename"
      fi
  fi

  out="render/${filename}.${ext}"

  echo "➡️ Processing: $f"
  echo "   Artist: $artis"
  echo "   Title : $judul"
  echo "   Album : $album"

  ffmpeg -i "$f" -i "$cover" \
    -map 0 -map 1 \
    -c copy -c:v:1 mjpeg \
    -metadata artist="$(printf '%s' "$artis")" \
    -metadata title="$(printf '%s' "$judul")" \
    -metadata album="$(printf '%s' "$album")" \
    -metadata:s:v title="Cover Art" \
    -metadata:s:v comment="by munons" \
    -disposition:v:1 attached_pic \
    "$out" >>"$logfile" 2>&1

  if [ $? -eq 0 ]; then
    echo "✅ Success: $f → $out"
  else
    echo "❌ Failed: $f (lihat $logfile)"
  fi
done
