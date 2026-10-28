package com.ptit.quanlydanhba.activity;

import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.ListView;
import android.widget.TextView;

import androidx.appcompat.app.AppCompatActivity;

import com.ptit.quanlydanhba.R;
import com.ptit.quanlydanhba.adapter.ContactAdapter;
import com.ptit.quanlydanhba.repository.ContactRepository;

/**
 * Màn hình 2: Danh sách liên hệ (MainActivity).
 * Hiển thị khối thống kê, danh sách liên hệ qua ListView và nút Thêm liên hệ.
 */
public class MainActivity extends AppCompatActivity {

    public static final String EXTRA_CONTACT_INDEX = "EXTRA_CONTACT_INDEX";

    private TextView tvStats;
    private ListView lvContacts;
    private TextView tvEmpty;
    private Button btnAddContact;

    private ContactRepository repository;
    private ContactAdapter adapter;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        repository = ContactRepository.getInstance();

        initViews();
        setupListView();
        setupListeners();
    }

    private void initViews() {
        tvStats = findViewById(R.id.tvStats);
        lvContacts = findViewById(R.id.lvContacts);
        tvEmpty = findViewById(R.id.tvEmpty);
        btnAddContact = findViewById(R.id.btnAddContact);
    }

    private void setupListView() {
        adapter = new ContactAdapter(this, repository.getContacts());
        lvContacts.setAdapter(adapter);

        // Nhấn vào một dòng để mở màn hình chi tiết liên hệ
        lvContacts.setOnItemClickListener((parent, view, position, id) -> {
            Intent intent = new Intent(MainActivity.this, ContactDetailActivity.class);
            intent.putExtra(EXTRA_CONTACT_INDEX, position);
            startActivity(intent);
        });
    }

    private void setupListeners() {
        // Nút Thêm liên hệ: Mở AddContactActivity bằng Intent
        btnAddContact.setOnClickListener(v -> {
            Intent intent = new Intent(MainActivity.this, AddContactActivity.class);
            startActivity(intent);
        });
    }

    @Override
    protected void onResume() {
        super.onResume();
        updateUI();
    }

    /**
     * Cập nhật khối thống kê và danh sách mỗi khi thêm, xóa hoặc đổi trạng thái yêu thích.
     */
    private void updateUI() {
        int total = repository.getTotalCount();
        int favorite = repository.getFavoriteCount();

        // 1. Cập nhật khối thống kê
        tvStats.setText(getString(R.string.stats_format, total, favorite));

        // 2. Cập nhật trạng thái danh sách
        if (total == 0) {
            tvEmpty.setVisibility(View.VISIBLE);
            lvContacts.setVisibility(View.GONE);
        } else {
            tvEmpty.setVisibility(View.GONE);
            lvContacts.setVisibility(View.VISIBLE);
        }

        if (adapter != null) {
            adapter.notifyDataSetChanged();
        }
    }
}
