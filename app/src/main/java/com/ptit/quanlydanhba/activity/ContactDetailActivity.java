package com.ptit.quanlydanhba.activity;

import android.content.Intent;
import android.net.Uri;
import android.os.Bundle;
import android.widget.Button;
import android.widget.CheckBox;
import android.widget.ImageButton;
import android.widget.TextView;
import android.widget.Toast;

import androidx.appcompat.app.AlertDialog;
import androidx.appcompat.app.AppCompatActivity;

import com.ptit.quanlydanhba.R;
import com.ptit.quanlydanhba.model.Contact;
import com.ptit.quanlydanhba.repository.ContactRepository;

/**
 * Màn hình 4: Chi tiết liên hệ (ContactDetailActivity).
 * Hiển thị đầy đủ thông tin liên hệ, cho phép toggle yêu thích, gọi điện qua ACTION_DIAL hoặc xóa liên hệ.
 */
public class ContactDetailActivity extends AppCompatActivity {

    private TextView tvDetailAvatar;
    private TextView tvDetailName;
    private TextView tvDetailPhone;
    private TextView tvDetailGroup;
    private TextView tvDetailGender;
    private TextView tvDetailNote;
    private CheckBox cbDetailFavorite;
    private Button btnCall;
    private Button btnBack;
    private Button btnDelete;
    private ImageButton btnBackHeaderDetail;

    private ContactRepository repository;
    private int contactIndex = -1;
    private Contact currentContact;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_contact_detail);

        repository = ContactRepository.getInstance();

        // Nhận chỉ số liên hệ được gửi từ MainActivity qua Intent
        contactIndex = getIntent().getIntExtra(MainActivity.EXTRA_CONTACT_INDEX, -1);
        currentContact = repository.getContact(contactIndex);

        if (currentContact == null) {
            Toast.makeText(this, "Không tìm thấy thông tin liên hệ!", Toast.LENGTH_SHORT).show();
            finish();
            return;
        }

        initViews();
        displayContactData();
        setupListeners();
    }

    private void initViews() {
        tvDetailAvatar = findViewById(R.id.tvDetailAvatar);
        tvDetailName = findViewById(R.id.tvDetailName);
        tvDetailPhone = findViewById(R.id.tvDetailPhone);
        tvDetailGroup = findViewById(R.id.tvDetailGroup);
        tvDetailGender = findViewById(R.id.tvDetailGender);
        tvDetailNote = findViewById(R.id.tvDetailNote);
        cbDetailFavorite = findViewById(R.id.cbDetailFavorite);
        btnCall = findViewById(R.id.btnCall);
        btnBack = findViewById(R.id.btnBack);
        btnDelete = findViewById(R.id.btnDelete);
        btnBackHeaderDetail = findViewById(R.id.btnBackHeaderDetail);
    }

    private void displayContactData() {
        tvDetailAvatar.setText(currentContact.getInitialLetter());
        tvDetailName.setText(currentContact.getName());
        tvDetailPhone.setText(currentContact.getPhone());
        tvDetailGroup.setText(currentContact.getGroup());
        tvDetailGender.setText(currentContact.getGender());

        String note = currentContact.getNote();
        if (note == null || note.trim().isEmpty()) {
            tvDetailNote.setText("Không có ghi chú");
        } else {
            tvDetailNote.setText(note);
        }

        cbDetailFavorite.setChecked(currentContact.isFavorite());
    }

    private void setupListeners() {
        // Nút Header Back & Nút Quay lại: Đóng màn hình và trở về danh sách
        btnBackHeaderDetail.setOnClickListener(v -> finish());
        btnBack.setOnClickListener(v -> finish());

        // CheckBox Yêu thích: Cập nhật trực tiếp trạng thái yêu thích
        cbDetailFavorite.setOnCheckedChangeListener((buttonView, isChecked) -> {
            currentContact.setFavorite(isChecked);
        });

        // Nút Gọi điện: Dùng Intent ngầm định (ACTION_DIAL) mở màn hình quay số hệ thống
        btnCall.setOnClickListener(v -> handleCallContact());

        // Nút Xóa liên hệ: Hiển thị dialog xác nhận và xóa khỏi repository
        btnDelete.setOnClickListener(v -> showDeleteConfirmationDialog());
    }

    private void handleCallContact() {
        String phone = currentContact.getPhone();
        if (phone != null && !phone.isEmpty()) {
            Intent dialIntent = new Intent(Intent.ACTION_DIAL, Uri.parse("tel:" + phone));
            startActivity(dialIntent);
        } else {
            Toast.makeText(this, "Số điện thoại không hợp lệ!", Toast.LENGTH_SHORT).show();
        }
    }

    private void showDeleteConfirmationDialog() {
        new AlertDialog.Builder(this)
                .setTitle(R.string.dialog_delete_title)
                .setMessage(R.string.dialog_delete_msg)
                .setPositiveButton(R.string.action_yes, (dialog, which) -> {
                    // Xóa liên hệ khỏi ArrayList, quay lại danh sách và cập nhật thống kê
                    repository.removeContact(contactIndex);
                    Toast.makeText(this, R.string.msg_deleted_success, Toast.LENGTH_SHORT).show();
                    finish();
                })
                .setNegativeButton(R.string.action_no, (dialog, which) -> dialog.dismiss())
                .show();
    }
}
