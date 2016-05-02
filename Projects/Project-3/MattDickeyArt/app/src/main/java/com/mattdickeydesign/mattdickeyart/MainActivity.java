package com.mattdickeydesign.mattdickeyart;

import android.app.Activity;
import android.content.Context;
import android.content.Intent;
import android.content.res.Resources;
import android.os.Bundle;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.AdapterView;
import android.widget.BaseAdapter;
import android.widget.GridView;
import android.widget.ImageView;
import android.widget.TextView;

import java.util.ArrayList;

public class MainActivity extends Activity implements AdapterView.OnItemClickListener {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        GridView mainGrid = (GridView) findViewById(R.id.gridView);
        mainGrid.setAdapter(new MyGridAdapter(this));
        mainGrid.setOnItemClickListener(this);


    }

    @Override
    public void onItemClick(AdapterView<?> parent, View view, int position, long id) {
        Intent intent = new Intent(this, CategoryActivity.class);
        ViewHolder holder = (ViewHolder) view.getTag();
        ArtCategory temp = (ArtCategory) holder.myCategoryText.getTag();

        intent.putExtra("categoryName", temp.categoryName);
        startActivity(intent);
    }

    class ArtCategory {
        int imageID;
        String categoryName;

        ArtCategory(int imageID, String categoryName) {
            this.imageID = imageID;
            this.categoryName = categoryName;
        }
    }
    class ViewHolder {

        ImageView myCategoryImage;
        TextView myCategoryText;

        ViewHolder(View v) {
            myCategoryImage = (ImageView) v.findViewById(R.id.imageView);
            myCategoryText = (TextView) v.findViewById(R.id.textView);
        }
    }

    class MyGridAdapter extends BaseAdapter {
        ArrayList<ArtCategory> list;
        Context context;

        MyGridAdapter(Context context) {
            this.context = context;
            list = new ArrayList<ArtCategory>();
            Resources res = getResources();
            String[] tempCatNames = res.getStringArray(R.array.Categories);
            int[] categoryImages = {R.drawable.paint, R.drawable.drawing, R.drawable.digital};

            for (int i = 0; i < 3; i++) {
                ArtCategory tempCategory = new ArtCategory(categoryImages[i], tempCatNames[i]);
                list.add(tempCategory);
            }
        }

        @Override
        public int getCount() {
            return list.size();
        }

        @Override
        public Object getItem(int position) {
            return list.get(position);
        }

        @Override
        public long getItemId(int position) {
            return position;
        }

        @Override
        public View getView(int position, View convertView, ViewGroup parent) {

            View row = convertView;
            ViewHolder holder = null;
            if (row == null) {
                LayoutInflater inflater = (LayoutInflater) context.getSystemService(Context.LAYOUT_INFLATER_SERVICE);
                 row = inflater.inflate(R.layout.main_grid_cell_layout, parent, false);
                holder = new ViewHolder(row);
                row.setTag(holder);

            } else {
                holder = (ViewHolder) row.getTag();
            }

            ArtCategory tempCat = list.get(position);
            holder.myCategoryImage.setImageResource(tempCat.imageID);
            holder.myCategoryText.setText(tempCat.categoryName);
            holder.myCategoryText.setTag(tempCat);
            return row;
        }
    }
}
