package com.ptit.quanlydanhba.adapter;

import android.content.Context;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.BaseAdapter;
import android.widget.ImageView;
import android.widget.TextView;

import com.ptit.quanlydanhba.R;
import com.ptit.quanlydanhba.model.Contact;

import java.util.ArrayList;

/**
 * Adapter tùy biến hiển thị danh sách liên hệ cho ListView.
 * Áp dụng ViewHolder pattern tối ưu tái sử dụng View.
 */
public class ContactAdapter extends BaseAdapter {
    private final Context context;
    private final ArrayList<Contact> contacts;
    private final LayoutInflater inflater;

    public ContactAdapter(Context context, ArrayList<Contact> contacts) {
        this.context = context;
        this.contacts = contacts;
        this.inflater = LayoutInflater.from(context);
    }

    @Override
    public int getCount() {
        return contacts != null ? contacts.size() : 0;
    }

    @Override
    public Object getItem(int position) {
        return contacts != null ? contacts.get(position) : null;
    }

    @Override
    public long getItemId(int position) {
        return position;
    }

    @Override
    public View getView(int position, View convertView, ViewGroup parent) {
        ViewHolder holder;
        if (convertView == null) {
            convertView = inflater.inflate(R.layout.item_contact, parent, false);
            holder = new ViewHolder();
            holder.tvAvatarLetter = convertView.findViewById(R.id.tvAvatarLetter);
            holder.tvContactName = convertView.findViewById(R.id.tvContactName);
            holder.tvContactPhone = convertView.findViewById(R.id.tvContactPhone);
            holder.tvContactGroup = convertView.findViewById(R.id.tvContactGroup);
            holder.ivFavoriteStar = convertView.findViewById(R.id.ivFavoriteStar);
            convertView.setTag(holder);
        } else {
            holder = (ViewHolder) convertView.getTag();
        }

        Contact contact = contacts.get(position);
        if (contact != null) {
            holder.tvAvatarLetter.setText(contact.getInitialLetter());
            holder.tvContactName.setText(contact.getName());
            holder.tvContactPhone.setText(contact.getPhone());
            holder.tvContactGroup.setText(contact.getGroup());

            if (contact.isFavorite()) {
                holder.ivFavoriteStar.setImageResource(R.drawable.ic_star_filled);
                holder.ivFavoriteStar.setColorFilter(null);
            } else {
                holder.ivFavoriteStar.setImageResource(R.drawable.ic_star_border);
            }
        }

        return convertView;
    }

    private static class ViewHolder {
        TextView tvAvatarLetter;
        TextView tvContactName;
        TextView tvContactPhone;
        TextView tvContactGroup;
        ImageView ivFavoriteStar;
    }
}
