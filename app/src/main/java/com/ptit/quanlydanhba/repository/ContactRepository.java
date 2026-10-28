package com.ptit.quanlydanhba.repository;

import com.ptit.quanlydanhba.model.Contact;

import java.util.ArrayList;

/**
 * Kho dữ liệu tập trung (Single Source of Truth) trong bộ nhớ (In-memory).
 * Đảm bảo tính nhất quán dữ liệu giữa các Activity và khi sử dụng phím Back.
 */
public class ContactRepository {
    private static ContactRepository instance;
    private final ArrayList<Contact> contacts;

    private ContactRepository() {
        contacts = new ArrayList<>();
        initSampleData();
    }

    public static synchronized ContactRepository getInstance() {
        if (instance == null) {
            instance = new ContactRepository();
        }
        return instance;
    }

    /**
     * Khởi tạo dữ liệu mẫu theo đúng yêu cầu đề bài:
     * 1. Nguyễn Văn An | 0901234567 | Bạn bè | Không
     * 2. Trần Thị Bình | 0912345678 | Gia đình | Có
     * 3. Lê Minh Châu | 0987654321 | Công việc | Không
     */
    private void initSampleData() {
        contacts.add(new Contact("Nguyễn Văn An", "0901234567", "Bạn bè", "Nam", false, "Bạn thời đại học"));
        contacts.add(new Contact("Trần Thị Bình", "0912345678", "Gia đình", "Nữ", true, "Chị gái ruột"));
        contacts.add(new Contact("Lê Minh Châu", "0987654321", "Công việc", "Khác", false, "Đồng nghiệp cùng phòng"));
    }

    public ArrayList<Contact> getContacts() {
        return contacts;
    }

    public void addContact(Contact contact) {
        if (contact != null) {
            contacts.add(contact);
        }
    }

    public void removeContact(int index) {
        if (index >= 0 && index < contacts.size()) {
            contacts.remove(index);
        }
    }

    public Contact getContact(int index) {
        if (index >= 0 && index < contacts.size()) {
            return contacts.get(index);
        }
        return null;
    }

    public int getTotalCount() {
        return contacts.size();
    }

    public int getFavoriteCount() {
        int count = 0;
        for (Contact contact : contacts) {
            if (contact.isFavorite()) {
                count++;
            }
        }
        return count;
    }

    /**
     * Kiểm tra xem số điện thoại đã tồn tại trong danh bạ chưa.
     */
    public boolean isPhoneExists(String phone) {
        if (phone == null) return false;
        String cleanPhone = phone.trim();
        for (Contact contact : contacts) {
            if (contact.getPhone().trim().equals(cleanPhone)) {
                return true;
            }
        }
        return false;
    }
}
