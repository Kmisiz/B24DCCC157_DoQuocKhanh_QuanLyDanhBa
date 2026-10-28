# ỨNG DỤNG QUẢN LÝ DANH BẠ LIÊN HỆ (FLUTTER)

## 📌 THÔNG TIN SINH VIÊN & BÀI TẬP
- **Họ và tên**: Đỗ Quốc Khánh
- **Mã sinh viên (MSSV)**: B24DCCC157
- **Học viện**: Học viện Công nghệ Bưu chính Viễn thông (PTIT)
- **Học phần**: Lập trình ứng dụng di động
- **Tên Repository Git**: `B24DCCC157_Do_Quoc_Khanh_QuanLyDanhBa`
- **File Báo cáo đính kèm**: `B24DCCC157_Do_Quoc_Khanh_BaoCao_Flutter.docx` (kèm đầy đủ 6 ảnh chụp thật từ ứng dụng Flutter)

---

## 🚀 CÔNG NGHỆ & MÔ HÌNH KIẾN TRÚC
- **Ngôn ngữ & Nền tảng**: Flutter 3.47 (Dart 3.13)
- **Thiết kế UI**: Tự code 100% bằng **Material 3**, tone màu chủ đạo Indigo / Emerald, bo góc 14-16dp, đổ bóng tinh tế, typography đạt chuẩn WCAG AA contrast.
- **Hỗ trợ đa nền tảng**: Android (từ Android 7.0 đến Android 15), Windows, Web, iOS.
- **Kiến trúc dữ liệu (In-Memory)**:
  - Áp dụng mô hình **Single Source of Truth** với `ContactRepository` dạng Singleton quản lý `List<Contact>`.
  - Mọi thao tác thêm mới, xóa và đổi trạng thái yêu thích được cập nhật tức thì và đồng bộ xuyên suốt ứng dụng.
- **Điều hướng & Tương tác**:
  - `Navigator.pushReplacement`: Hủy route Login sau khi đăng nhập thành công (ngăn nút Back quay lại đăng nhập).
  - `Navigator.push` & `Navigator.pop`: Điều hướng mượt mà giữa các màn hình Danh sách, Thêm mới và Chi tiết.
  - `url_launcher`: Gọi điện thoại an toàn thông qua URI scheme `tel:<số_điện_thoại>`.

---

## 📱 CẤU TRÚC 4 MÀN HÌNH CHÍNH

### 1. Màn hình Đăng nhập (`LoginScreen`)
- Tài khoản quản trị cố định: `admin` / `123456`.
- Kiểm tra tính hợp lệ: Báo lỗi cảnh báo đỏ khi bỏ trống hoặc nhập sai tài khoản; có nút toggle ẩn/hiện mật khẩu.
- Khi đăng nhập thành công: Dùng `Navigator.pushReplacement` chuyển sang màn hình chính.

### 2. Màn hình Danh sách liên hệ (`MainScreen`)
- **Banner thống kê**: Hiển thị tổng số liên hệ và số liên hệ yêu thích (`Tổng số: X | Yêu thích: Y`), tự động cập nhật mỗi khi có thay đổi.
- **Danh sách liên hệ (`ListView.builder`)**: Sử dụng component `ContactItem` hiển thị:
  - Avatar tròn tự động sinh màu và chữ cái đầu viết hoa từ họ tên (VD: An -> `A`, Bình -> `B`).
  - Họ và tên (chữ in đậm).
  - Số điện thoại và Tag Badge phân loại nhóm (Gia đình, Bạn bè, Công việc, Khác).
  - Biểu tượng ngôi sao vàng nếu là liên hệ yêu thích.
- **3 liên hệ mẫu ban đầu theo đề bài**:
  1. Nguyễn Văn An - 0901234567 - Bạn bè - Không yêu thích
  2. Trần Thị Bình - 0912345678 - Gia đình - Có yêu thích
  3. Lê Minh Châu - 0987654321 - Công việc - Không yêu thích
- Nhấn vào một dòng để xem chi tiết; nhấn nút **THÊM LIÊN HỆ** ở đáy để mở màn hình thêm mới.

### 3. Màn hình Thêm liên hệ (`AddContactScreen`)
- Form nhập liệu đầy đủ 7 trường:
  1. Họ và tên (`TextField`, bắt buộc, không được để trống).
  2. Số điện thoại (`TextField`, bàn phím số, đúng 10 số bắt đầu bằng số `0`, kiểm tra regex `^0[0-9]{9}$`).
  3. Nhóm (`DropdownButtonFormField`: Gia đình, Bạn bè, Công việc, Khác).
  4. Giới tính (`SegmentedButton` hiện đại với icon: Nam [mặc định], Nữ, Khác).
  5. Yêu thích (`CheckboxListTile` màu vàng).
  6. Ghi chú (`TextField` nhiều dòng).
  7. Nút **LƯU LIÊN HỆ**.
- Kiểm tra chống trùng lặp số điện thoại trong danh bạ trước khi lưu.
- Lưu thành công -> Thêm vào `ContactRepository`, hiển thị SnackBar và đóng màn hình.

### 4. Màn hình Chi tiết liên hệ (`ContactDetailScreen`)
- Card Profile lớn hiển thị Avatar và Họ tên liên hệ.
- Hiển thị đầy đủ Số điện thoại, Phân loại nhóm, Giới tính, Ghi chú.
- `Checkbox` Yêu thích: Tích/bỏ tích trực tiếp cập nhật trạng thái của liên hệ trong `ContactRepository`.
- **Nút Gọi điện**: Dùng `url_launcher` mở trình quay số điện thoại hệ thống.
- **Nút Quay lại**: Đóng màn hình quay về danh sách.
- **Nút Xóa liên hệ**: Hiển thị `AlertDialog` xác nhận để tránh bấm nhầm -> Xóa khỏi `ContactRepository` và đóng màn hình.

---

## 📂 CẤU TRÚC THƯ MỤC DỰ ÁN
```
B24DCCC157_Do_Quoc_Khanh_Quan_Ly_Danh_Ba/
├── .gitignore                          # Đã loại trừ tệp build, .dart_tool, .gradle
├── README.md                           # Giới thiệu đồ án chi tiết
├── pubspec.yaml                        # Quản lý thư viện phụ thuộc (url_launcher)
├── B24DCCC157_Do_Quoc_Khanh_BaoCao_Flutter.docx # File báo cáo Word hoàn chỉnh có ảnh thật
├── screenshots/                        # 6 ảnh chụp thật từ ứng dụng Flutter
│   ├── screenshot_login.png
│   ├── screenshot_login_error.png
│   ├── screenshot_main.png
│   ├── screenshot_add_contact.png
│   ├── screenshot_add_error.png
│   └── screenshot_detail.png
├── lib/
│   ├── main.dart                       # Entry point, Theme Material 3
│   ├── models/
│   │   └── contact.dart                # Model Contact + get initialLetter
│   ├── repositories/
│   │   └── contact_repository.dart     # Singleton In-memory data store
│   ├── widgets/
│   │   └── contact_item.dart           # Custom Contact Card
│   └── screens/
│       ├── login_screen.dart           # Màn hình đăng nhập admin/123456
│       ├── main_screen.dart            # Màn hình danh sách & thống kê
│       ├── add_contact_screen.dart     # Màn hình thêm mới & validation
│       └── contact_detail_screen.dart  # Màn hình chi tiết & gọi điện, xóa
└── test/
    ├── widget_test.dart                # Smoke test
    └── golden_screenshots_test.dart   # Bộ test kết xuất ảnh thật từ ứng dụng
```

---

## 🛠️ HƯỚNG DẪN CÀI ĐẶT & CHẠY ỨNG DỤNG
1. Cài đặt các thư viện phụ thuộc:
   ```bash
   flutter pub get
   ```
2. Kiểm tra chất lượng mã nguồn:
   ```bash
   flutter analyze
   ```
3. Chạy ứng dụng trên thiết bị (Windows, Android Emulator hoặc Web):
   ```bash
   # Chạy trên Windows Desktop:
   flutter run -d windows

   # Chạy trên máy ảo Android (Pixel_6a):
   flutter run -d emulator-5554

   # Chạy trên Trình duyệt Web (Edge):
   flutter run -d edge
   ```
