# ỨNG DỤNG QUẢN LÝ DANH BẠ LIÊN HỆ (ANDROID NATIVE)

## 📌 THÔNG TIN SINH VIÊN & BÀI TẬP
- **Họ và tên**: Đỗ Quốc Khánh
- **Mã sinh viên (MSSV)**: B24DCCC157
- **Học viện**: Học viện Công nghệ Bưu chính Viễn thông (PTIT)
- **Học phần**: Lập trình ứng dụng di động Android
- **Tên Repository Git**: `B24DCCC157_Do_Quoc_Khanh_QuanLyDanhBa`
- **File Báo cáo đính kèm**: `B24DCCC157_Do_Quoc_Khanh_BaoCao.docx`

---

## 🚀 CÔNG NGHỆ & MÔ HÌNH KIẾN TRÚC
- **Ngôn ngữ**: Java 17
- **Giao diện**: Thuần XML với Color Palette hiện đại, CardView, Vector Drawables, đạt chuẩn WCAG AA contrast.
- **Hệ điều hành hỗ trợ**: Android 7.0 (API level 24) đến Android 15 (API level 35).
- **Kiến trúc quản lý dữ liệu**:
  - **Single Source of Truth (In-Memory)**: Sử dụng lớp `ContactRepository` dạng Singleton để quản lý tập trung danh sách `ArrayList<Contact>`.
  - Dữ liệu luôn đồng bộ tuyệt đối giữa 4 màn hình kể cả khi người dùng nhấn nút Back hệ thống/vật lý.
- **Điều hướng & Tương tác**:
  - **Explicit Intent**: Chuyển đổi giữa 4 Activity và truyền chỉ số `EXTRA_CONTACT_INDEX`.
  - **Implicit Intent**: Khởi chạy `ACTION_DIAL` (quay số hệ thống an toàn, không cần xin quyền runtime nguy hiểm).

---

## 📱 CẤU TRÚC 4 MÀN HÌNH CHÍNH

### 1. Màn hình Đăng nhập (`LoginActivity`)
- Tài khoản quản trị cố định: `admin` / `123456`.
- Kiểm tra hợp lệ: Báo lỗi cụ thể khi bỏ trống tên đăng nhập hoặc mật khẩu; báo lỗi đỏ khi sai thông tin.
- Khi đăng nhập thành công: Dùng `Intent` chuyển sang `MainActivity` và gọi `finish()` để xóa khỏi Backstack.

### 2. Màn hình Danh sách liên hệ (`MainActivity`)
- **Khối thống kê**: Hiển thị tổng số liên hệ và số liên hệ yêu thích (`Tổng số: X | Yêu thích: Y`), tự động cập nhật trong `onResume()`.
- **Danh sách liên hệ (`ListView`)**: Sử dụng `ContactAdapter` (ViewHolder pattern) hiển thị:
  - Avatar hình tròn chứa chữ cái đầu viết hoa của tên.
  - Họ và tên (chữ in đậm).
  - Số điện thoại và Badge phân loại nhóm (Gia đình, Bạn bè, Công việc, Khác).
  - Biểu tượng ngôi sao vàng nếu là liên hệ yêu thích.
- **3 liên hệ mẫu ban đầu**:
  1. Nguyễn Văn An - 0901234567 - Bạn bè - Không yêu thích
  2. Trần Thị Bình - 0912345678 - Gia đình - Có yêu thích
  3. Lê Minh Châu - 0987654321 - Công việc - Không yêu thích
- Nhấn vào một dòng để xem chi tiết; nhấn nút **[+ Thêm liên hệ]** để mở màn hình thêm mới.

### 3. Màn hình Thêm liên hệ (`AddContactActivity`)
- Form nhập liệu đầy đủ 7 trường:
  1. Họ và tên (`EditText`, bắt buộc, không được để trống).
  2. Số điện thoại (`EditText`, đúng 10 chữ số và bắt đầu bằng số `0`, kiểm tra regex `^0[0-9]{9}$`).
  3. Nhóm (`Spinner`: Gia đình, Bạn bè, Công việc, Khác).
  4. Giới tính (`RadioGroup`: Nam [mặc định], Nữ, Khác).
  5. Yêu thích (`CheckBox`).
  6. Ghi chú (`EditText` nhiều dòng).
  7. Nút Lưu liên hệ (`Button`).
- Kiểm tra chống trùng lặp số điện thoại trong danh bạ trước khi lưu.
- Lưu thành công -> Thêm vào `ContactRepository`, hiển thị Toast và đóng Activity.

### 4. Màn hình Chi tiết liên hệ (`ContactDetailActivity`)
- Card Profile lớn hiển thị Avatar và Họ tên liên hệ.
- Hiển thị đầy đủ Số điện thoại, Phân loại nhóm, Giới tính, Ghi chú.
- `CheckBox` Yêu thích: Tích/bỏ tích trực tiếp cập nhật trạng thái của liên hệ trong `ContactRepository`.
- **Nút Gọi điện**: Dùng Intent ngầm định `Intent.ACTION_DIAL` mở trình quay số điện thoại hệ thống.
- **Nút Quay lại**: Đóng màn hình quay về danh sách.
- **Nút Xóa liên hệ**: Hiển thị `AlertDialog` xác nhận để tránh bấm nhầm -> Xóa khỏi `ContactRepository` và đóng màn hình.

---

## 📂 CẤU TRÚC THƯ MỤC DỰ ÁN
```
B24DCCC157_Do_Quoc_Khanh_Quan_Ly_Danh_Ba/
├── .gitignore
├── README.md
├── B24DCCC157_Do_Quoc_Khanh_BaoCao.docx   <-- File báo cáo nộp bài
├── build.gradle.kts
├── settings.gradle.kts
├── gradle.properties
├── gradlew
├── gradlew.bat
├── gradle/wrapper/
└── app/
    ├── build.gradle.kts
    └── src/main/
        ├── AndroidManifest.xml
        ├── java/com/ptit/quanlydanhba/
        │   ├── model/
        │   │   └── Contact.java
        │   ├── repository/
        │   │   └── ContactRepository.java
        │   ├── adapter/
        │   │   └── ContactAdapter.java
        │   └── activity/
        │       ├── LoginActivity.java
        │       ├── MainActivity.java
        │       ├── AddContactActivity.java
        │       └── ContactDetailActivity.java
        └── res/
            ├── drawable/ (Vector icons & shapes)
            ├── layout/   (5 XML layout files)
            ├── values/   (colors.xml, strings.xml, themes.xml)
            └── mipmap/
```

---

## 🛠️ HƯỚNG DẪN CÀI ĐẶT & CHẠY
1. Mở **Android Studio** -> Chọn **Open...** và duyệt đến thư mục `B24DCCC157_Do_Quoc_Khanh_Quan_Ly_Danh_Ba`.
2. Đợi Gradle Sync hoàn tất (Project sử dụng JDK 17 và Android SDK 34).
3. Chọn thiết bị máy ảo (Emulator) hoặc máy thật (USB Debugging) chạy Android 7.0 trở lên.
4. Nhấn nút **Run 'app'** (phím tắt `Shift + F10`) để trải nghiệm ứng dụng.
