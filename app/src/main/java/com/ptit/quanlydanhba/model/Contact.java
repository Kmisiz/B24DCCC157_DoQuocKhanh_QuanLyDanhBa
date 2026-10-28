package com.ptit.quanlydanhba.model;

import java.io.Serializable;
import java.util.UUID;

/**
 * Model biểu diễn thông tin một liên hệ trong danh bạ.
 * Bao gồm: họ tên, số điện thoại, nhóm, giới tính, trạng thái yêu thích, ghi chú.
 */
public class Contact implements Serializable {
    private String id;
    private String name;
    private String phone;
    private String group;
    private String gender;
    private boolean isFavorite;
    private String note;

    public Contact() {
        this.id = UUID.randomUUID().toString();
    }

    public Contact(String name, String phone, String group, String gender, boolean isFavorite, String note) {
        this.id = UUID.randomUUID().toString();
        this.name = name;
        this.phone = phone;
        this.group = group;
        this.gender = gender;
        this.isFavorite = isFavorite;
        this.note = note != null ? note : "";
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getName() {
        return name != null ? name : "";
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getPhone() {
        return phone != null ? phone : "";
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getGroup() {
        return group != null ? group : "Khác";
    }

    public void setGroup(String group) {
        this.group = group;
    }

    public String getGender() {
        return gender != null ? gender : "Nam";
    }

    public void setGender(String gender) {
        this.gender = gender;
    }

    public boolean isFavorite() {
        return isFavorite;
    }

    public void setFavorite(boolean favorite) {
        isFavorite = favorite;
    }

    public String getNote() {
        return note != null ? note : "";
    }

    public void setNote(String note) {
        this.note = note;
    }

    /**
     * Lấy chữ cái đầu tiên của từ cuối cùng trong tên để làm Avatar hiển thị.
     * Ví dụ: "Nguyễn Văn An" -> "A", "Trần Thị Bình" -> "B"
     */
    public String getInitialLetter() {
        if (name == null || name.trim().isEmpty()) {
            return "?";
        }
        String trimmed = name.trim();
        String[] words = trimmed.split("\\s+");
        String lastWord = words[words.length - 1];
        if (lastWord.isEmpty()) {
            return "?";
        }
        return lastWord.substring(0, 1).toUpperCase();
    }
}
