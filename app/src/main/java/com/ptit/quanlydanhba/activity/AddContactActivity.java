package com.ptit.quanlydanhba.activity;

import android.os.Bundle;
import android.widget.ArrayAdapter;
import android.widget.Button;
import android.widget.CheckBox;
import android.widget.EditText;
import android.widget.ImageButton;
import android.widget.RadioButton;
import android.widget.RadioGroup;
import android.widget.Spinner;
import android.widget.Toast;

import androidx.appcompat.app.AppCompatActivity;

import com.ptit.quanlydanhba.R;
import com.ptit.quanlydanhba.model.Contact;
import com.ptit.quanlydanhba.repository.ContactRepository;

/**
 * Màn hình 3: Thêm liên hệ (AddContactActivity).
 * Nhập liệu, kiểm tra hợp lệ, thêm Contact mới vào kho dữ liệu và trở về MainActivity.
 */
public class AddContactActivity extends AppCompatActivity {

    private EditText etName;
    private EditText etPhone;
    private Spinner spGroup;
    private RadioGroup rgGender;
    private RadioButton rbMale;
    private RadioButton rbFemale;
    private RadioButton rbOther;
    private CheckBox cbFavorite;
    private EditText etNote;
    private Button btnSave;
    private ImageButton btnBackHeader;

    private ContactRepository repository;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_add_contact);

        repository = ContactRepository.getInstance();

        initViews();
        setupSpinner();
        setupListeners();
    }

    private void initViews() {
        etName = findViewById(R.id.etName);
        etPhone = findViewById(R.id.etPhone);
        spGroup = findViewById(R.id.spGroup);
        rgGender = findViewById(R.id.rgGender);
        rbMale = findViewById(R.id.rbMale);
        rbFemale = findViewById(R.id.rbFemale);
        rbOther = findViewById(R.id.rbOther);
        cbFavorite = findViewById(R.id.cbFavorite);
        etNote = findViewById(R.id.etNote);
        btnSave = findViewById(R.id.btnSave);
        btnBackHeader = findViewById(R.id.btnBackHeader);
    }

    private void setupSpinner() {
        ArrayAdapter<CharSequence> adapter = ArrayAdapter.createFromResource(
                this,
                R.array.contact_groups,
                android.R.layout.simple_spinner_item
        );
        adapter.setDropDownViewResource(android.R.layout.simple_spinner_dropdown_item);
        spGroup.setAdapter(adapter);
    }

    private void setupListeners() {
        btnBackHeader.setOnClickListener(v -> finish());
        btnSave.setOnClickListener(v -> handleSaveContact());
    }

    private void handleSaveContact() {
        String name = etName.getText().toString().trim();
        String phone = etPhone.getText().toString().trim();
        String group = spGroup.getSelectedItem().toString();
        String note = etNote.getText().toString().trim();
        boolean isFavorite = cbFavorite.isChecked();

        // Xác định giới tính từ RadioGroup
        String gender = getString(R.string.gender_male);
        int selectedGenderId = rgGender.getCheckedRadioButtonId();
        if (selectedGenderId == R.id.rbFemale) {
            gender = getString(R.string.gender_female);
        } else if (selectedGenderId == R.id.rbOther) {
            gender = getString(R.string.gender_other);
        }

        // 1. Kiểm tra không được để trống họ tên
        if (name.isEmpty()) {
            etName.setError(getString(R.string.err_empty_name));
            etName.requestFocus();
            Toast.makeText(this, R.string.err_empty_name, Toast.LENGTH_SHORT).show();
            return;
        }

        // 2. Kiểm tra số điện thoại: đúng 10 chữ số và bắt đầu bằng số 0
        if (!phone.matches("^0[0-9]{9}$")) {
            etPhone.setError(getString(R.string.err_invalid_phone));
            etPhone.requestFocus();
            Toast.makeText(this, R.string.err_invalid_phone, Toast.LENGTH_SHORT).show();
            return;
        }

        // 3. Kiểm tra số điện thoại không được trùng lặp trong danh bạ
        if (repository.isPhoneExists(phone)) {
            etPhone.setError(getString(R.string.err_duplicate_phone));
            etPhone.requestFocus();
            Toast.makeText(this, R.string.err_duplicate_phone, Toast.LENGTH_SHORT).show();
            return;
        }

        // Tạo đối tượng Contact và lưu vào kho dữ liệu
        Contact newContact = new Contact(name, phone, group, gender, isFavorite, note);
        repository.addContact(newContact);

        Toast.makeText(this, R.string.msg_added_success, Toast.LENGTH_SHORT).show();

        // Chuyển về màn hình danh sách (MainActivity cập nhật ở onResume)
        finish();
    }
}
