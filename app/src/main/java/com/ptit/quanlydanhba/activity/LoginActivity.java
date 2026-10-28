package com.ptit.quanlydanhba.activity;

import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.TextView;
import android.widget.Toast;

import androidx.appcompat.app.AppCompatActivity;

import com.ptit.quanlydanhba.R;

/**
 * Màn hình 1: Đăng nhập (LoginActivity).
 * Kiểm tra tài khoản cố định admin / 123456 và chuyển sang MainActivity.
 */
public class LoginActivity extends AppCompatActivity {

    // Tài khoản cố định khai báo trong code
    private static final String HARDCODED_USERNAME = "admin";
    private static final String HARDCODED_PASSWORD = "123456";

    private EditText etUsername;
    private EditText etPassword;
    private TextView tvError;
    private Button btnLogin;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_login);

        initViews();
        setupListeners();
    }

    private void initViews() {
        etUsername = findViewById(R.id.etUsername);
        etPassword = findViewById(R.id.etPassword);
        tvError = findViewById(R.id.tvError);
        btnLogin = findViewById(R.id.btnLogin);
    }

    private void setupListeners() {
        btnLogin.setOnClickListener(v -> handleLogin());
    }

    private void handleLogin() {
        String username = etUsername.getText().toString().trim();
        String password = etPassword.getText().toString().trim();

        // 1. Kiểm tra không cho phép đăng nhập khi tên đăng nhập hoặc mật khẩu bị bỏ trống
        if (username.isEmpty() || password.isEmpty()) {
            tvError.setText(R.string.error_empty_credentials);
            tvError.setVisibility(View.VISIBLE);
            if (username.isEmpty()) {
                etUsername.setError(getString(R.string.error_empty_credentials));
                etUsername.requestFocus();
            } else {
                etPassword.setError(getString(R.string.error_empty_credentials));
                etPassword.requestFocus();
            }
            return;
        }

        // 2. So sánh thông tin nhập với tài khoản cố định
        if (HARDCODED_USERNAME.equals(username) && HARDCODED_PASSWORD.equals(password)) {
            tvError.setVisibility(View.GONE);
            Toast.makeText(this, "Đăng nhập thành công!", Toast.LENGTH_SHORT).show();

            // Đúng tài khoản: dùng Intent chuyển sang MainActivity và gọi finish()
            Intent intent = new Intent(LoginActivity.this, MainActivity.class);
            startActivity(intent);
            finish(); // Xóa LoginActivity khỏi backstack để nút Back không quay lại đăng nhập
        } else {
            // Sai tên đăng nhập hoặc mật khẩu: hiển thị thông báo lỗi và ở lại màn hình đăng nhập
            tvError.setText(R.string.error_invalid_credentials);
            tvError.setVisibility(View.VISIBLE);
            etPassword.setText("");
            etPassword.requestFocus();
            Toast.makeText(this, R.string.error_invalid_credentials, Toast.LENGTH_SHORT).show();
        }
    }
}
