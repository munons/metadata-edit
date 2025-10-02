# 🎵 metadata.sh

## 📌 Deskripsi
Script sederhana untuk menambahkan **metadata (Artist, Title, Album)** dan **cover art** (`cover.jpg/jpeg/png/webp`) ke file audio secara otomatis.  
Hasil proses akan tersimpan di folder `render/`.

---

## ✨ Fitur
- Support format: **MP3, M4A, FLAC, WAV, OGG** (case-insensitive)  
- Auto parse nama file `Artis - Judul.*` jika metadata kosong  
- Bisa override metadata lewat argumen  
- Menambahkan cover art permanen (terbaca di HP/PC lain)  
- Log proses tersimpan di `process.log`  

---

## ⚙️ Instalasi
1. Pastikan sudah install `ffmpeg` & `ffprobe`:
   - **Ubuntu/Debian**
     ```bash
     sudo apt install ffmpeg
     ```
   - **Arch Linux**
     ```bash
     sudo pacman -S ffmpeg
     ```
   - **Termux (Android)**
     ```bash
     pkg install ffmpeg
     ```

2. Simpan file script `metadata.sh` di folder, contoh:
   ```
   /sdcard/Music/edit
   ```

3. Buka Termux, lalu ubah direktori:
   ```bash
   cd /sdcard/Music/edit
   ```

4. Berikan izin eksekusi:
   ```bash
   chmod +x metadata.sh
   ```

5. Siapkan file cover dengan nama:
   - `cover.jpg` / `cover.jpeg` / `cover.png` / `cover.webp`

---

## 🚀 Cara Pemakaian
### 1) Tanpa argumen  
Auto parse dari nama file, album default **"Jepang"**  
```bash
./metadata.sh
```

### 2) Dengan argumen (Artist, Title, Album)  
```bash
./metadata.sh "LiSA" "Gurenge" "Demon Slayer OST"
```

### 3) Hanya album diganti (Artist & Title tetap auto)  
```bash
./metadata.sh "" "" "Naruto OP"
```

---

## 📂 Output
- File hasil akan tersimpan di folder `render/`
- Metadata permanen, tetap terbaca di semua device

---

## 📝 Catatan
- Jika file sudah punya metadata **Artist/Title**, script akan mempertahankan metadata tersebut (kecuali dipaksa dengan argumen).
- Default **Album = Jepang** jika tidak ada argumen album.
- Log proses otomatis tersimpan di **process.log**.

---

## 📜 Lisensi
- Free for personal use  
- © 2025 by **munons**  
- GitHub: [https://github.com/munons](https://github.com/munons)
