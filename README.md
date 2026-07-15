# Reporte Dealer — Proyecto Vercel (sitio estático)

Trang web tra cứu kết quả bán hàng & hoa hồng kênh Dealer (Bitel Lima3).

## Nội dung
- `index.html` — Trang PUBLICADO (đã nhúng sẵn dữ liệu, mở ra là xem/tra cứu ngay — cho kênh). Đây là trang chính khi truy cập link.
- `admin.html` — App quản trị (đăng nhập admin để import 4 file và bấm "Publicar"). Mật khẩu admin mặc định: `lima3admin` (đổi trong file, dòng `const ADMIN_PASSWORD`).
- `vercel.json` — Cấu hình sitio estático (không cache để cập nhật hiện ngay).

## Cách deploy lên Vercel

### Cách 1 — Vercel CLI (nhanh)
1. Cài Node.js, rồi chạy: `npm i -g vercel`
2. Mở terminal trong thư mục này, chạy: `vercel`  (lần đầu đăng nhập + tạo project)
3. Deploy chính thức: `vercel --prod`  → nhận link dạng `https://ten-project.vercel.app`
4. Cập nhật hằng ngày: thay `index.html` mới (từ nút "Publicar" trong admin.html), chạy lại `vercel --prod`.

### Cách 2 — GitHub + Vercel (link cố định, tự động)
1. Tạo repo GitHub, upload cả thư mục này.
2. Vào https://vercel.com → "Add New… → Project" → Import repo → Deploy (framework: Other).
3. Link cố định: `https://ten-project.vercel.app`.
4. Cập nhật: thay `index.html` trong repo → Vercel tự deploy lại.

## Đường dẫn
- `/` hoặc `/index.html` → Trang tra cứu (kênh dùng).
- `/admin` hoặc `/admin.html` → App quản trị (chỉ admin).

## Quy trình cập nhật số liệu hằng ngày
1. Mở `admin.html` (local hoặc trên `/admin`) → đăng nhập admin.
2. Import 4 file dữ liệu (QLIK, POST N, Register, Referidos).
3. Bấm "📤 Publicar" → tải file HTML có dữ liệu.
4. Đổi tên file đó thành `index.html`, thay vào project, deploy lại (Cách 1 hoặc 2).
   - Nếu chưa cập nhật, link vẫn giữ dữ liệu cũ.
