# fastapi-rest-api — cara run & deploy (Railway)

Repository ini berisi contoh kecil FastAPI dan Dockerfile siap deploy ke Railway.

Ringkasan singkat
- Aplikasi FastAPI ada di `app/main.py` (endpoint: `/`, `/ping`, `/bmi`).
- Dependensi ada di `requirements.txt`.
- `Dockerfile` siap untuk digunakan Railway (atau build lokal).

1) Menjalankan lokal (tanpa Docker)

- Disarankan pakai virtual environment:

```powershell
python -m venv .venv
.\.venv\Scripts\Activate.ps1
pip install -r requirements.txt
uvicorn app.main:app --reload --port 8000
```

Lalu buka http://127.0.0.1:8000

2) Menjalankan dengan Docker (lokal)

- Build image:

```powershell
docker build -t my-fastapi .
```

- Run (port 8000 lokal -> container ${PORT}):

```powershell
docker run -e PORT=8000 -p 8000:8000 my-fastapi
```

Kemudian buka http://127.0.0.1:8000

3) Deploy ke Railway via Dashboard (GitHub repo)

Langkah singkat (Dashboard):

- Push seluruh repo ke GitHub (pastikan `Dockerfile`, `requirements.txt`, dan `app/` ada di repo).
- Buka https://railway.app → login → New Project → Deploy from GitHub.
- Pilih repository Anda.
- Railway akan mendeteksi `Dockerfile` dan menjalankan build otomatis. Setelah build selesai, Anda akan mendapatkan URL publik.

Catatan penting untuk Dashboard & Auto-deploy:
- Jika Anda menghubungkan Railway ke GitHub, ada opsi untuk "Auto-Deploy" / "Deploy on Push" (biasanya pada halaman Project → Settings atau Deployments). Jika diaktifkan, setiap push ke branch yang dipilih (mis. `main`) akan memicu build & deploy otomatis.
- Jika Auto-Deploy tidak diaktifkan, Anda perlu men-trigger deploy manual dari halaman Deployments di dashboard (klik "Deploy latest" atau sejenisnya).
- Jika Anda menggunakan Dockerfile di repo, Railway akan membuild image dari Dockerfile setiap kali auto-deploy berjalan.

4) Perubahan di repo — apakah Railway sync otomatis?

- Jika Anda sudah menghubungkan repo GitHub ke Railway dan mengaktifkan Auto-Deploy, Railway akan otomatis membuild & deploy setiap kali Anda push commit ke branch yang dikonfigurasi.
- Jika Anda hanya menggunakan dashboard tanpa menghubungkan ke GitHub (mis. membuat file/commit via web editor Railway atau upload manual), perubahan itu *tidak akan otomatis* mengambil update dari GitHub — Anda harus trigger deploy secara manual atau menghubungkan repo.
- Perubahan pada environment variables di Railway dashboard: setelah mengubah variabel, Anda biasanya perlu menjalankan redeploy manual (ada tombol "Redeploy" atau build trigger) agar container baru terbentuk dengan variabel terbaru.

5) Hal-hal yang perlu diperhatikan
- Free plan Railway membatasi RAM/CPU/ephemeral storage — cocok untuk prototipe/POC kecil, bukan untuk produksi trafik tinggi.
- Jangan simpan data penting di filesystem container (ephemeral) — gunakan managed DB atau storage.
- Jika butuh WebSocket/long-lived connections, container-based deploy (Docker on Railway/Fly) lebih cocok daripada function-based serverless.

6) Troubleshooting singkat
- Build gagal karena dependency: pastikan `requirements.txt` up-to-date dan pip install berhasil lokal.
- Aplikasi muncul 502/timeout di Railway: cek logs (Railway Dashboard → Logs) untuk pesan error. Pastikan service tidak crash dan `PORT` environment diisi (Railway biasanya memberi `PORT`).

7) Next steps yang saya bisa bantu
- Jika mau, saya bisa:
  - Push README ini ke repo (sudah saya tambahkan).
  - Membuat GitHub Actions minimal untuk auto-build dan push image (opsional).
  - Tunjukkan langkah detail di Dashboard Railway (dengan screenshot / langkah lebih rinci jika perlu).

Jika mau saya bantu langsung setup di dashboard Railway, beri tahu: 1) repo sudah di-push ke GitHub? 2) mau saya pandu langkah "Enable Auto-Deploy" atau hanya manual deploy saja?
# fastapi-rest-api
