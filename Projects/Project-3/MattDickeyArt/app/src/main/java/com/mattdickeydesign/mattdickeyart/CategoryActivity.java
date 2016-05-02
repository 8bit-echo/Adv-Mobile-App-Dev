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

public class CategoryActivity extends Activity implements AdapterView.OnItemClickListener {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_category);

        Intent intent = getIntent();
        String categoryName = intent.getStringExtra("categoryName");

        TextView catName = (TextView) findViewById(R.id.categoryNameText);
        catName.setText(categoryName);


        GridView categoryGrid = (GridView) findViewById(R.id.categoryGrid);
        categoryGrid.setAdapter(new ArtGridAdapter(this));
        categoryGrid.setOnItemClickListener(this);
    }


    @Override
    public void onItemClick(AdapterView<?> parent, View view, int position, long id) {
        Intent intent = new Intent(this, ArtDetailActivity.class);

        ArtViewHolder holder = (ArtViewHolder) view.getTag();
        Art temp = (Art) holder.myArtImage.getTag();

        intent.putExtra("imageID", temp.imageID);
        intent.putExtra("workTitle", temp.workTitle);

        startActivity(intent);

    }


    class Art {

        int imageID;
        String workTitle;
        String medium;

        // Constructor
        Art(int imageID, String workTitle) {

            this.imageID = imageID;
            this.workTitle = workTitle;
        }
    }

    class ArtViewHolder {
        ImageView myArtImage;

        ArtViewHolder(View v) {
            myArtImage = (ImageView) v.findViewById(R.id.gategory_grid_ImageView);
        }
    }

    class ArtGridAdapter extends BaseAdapter {
        ArrayList<Art> list;
        Context context;

        ArtGridAdapter(Context context) {
            this.context = context;
            list = new ArrayList<>();
            Resources res = getResources();

            //Image resource Arrays
            int[] paintingIDs = {R.drawable.painting0, R.drawable.painting1, R.drawable.painting2, R.drawable.painting3, R.drawable.painting4, R.drawable.painting5};
            int[] drawingIDs = {R.drawable.drawing0, R.drawable.drawing1, R.drawable.drawing2, R.drawable.drawing3, R.drawable.drawing4, R.drawable.drawing5};
            int[] digitalIDs = {R.drawable.digital0, R.drawable.digital1, R.drawable.digital2, R.drawable.digital3, R.drawable.digital4, R.drawable.digital5};

            //String Array Resources
            String[] paintingNames = res.getStringArray(R.array.Paintings);
            String[] drawingNames = res.getStringArray(R.array.Drawings);
            String[] digitalNames = res.getStringArray(R.array.Digital);

            //Assignment destinations
            String[] tempArtNames;
            int[] artCategoryImages;


            TextView currentCategoryTextView = (TextView) findViewById(R.id.categoryNameText);
            String currentCategory = (String) currentCategoryTextView.getText();

            System.out.println("Grid Adapter returns this as the currentCategory: " + currentCategory);

            switch (currentCategory) {

                case "Paintings":
                    tempArtNames = paintingNames;
                    artCategoryImages = paintingIDs;
                    break;
                case "Drawings":
                    tempArtNames = drawingNames;
                    artCategoryImages = drawingIDs;
                    break;
                case "Digital":
                    tempArtNames = digitalNames;
                    artCategoryImages = digitalIDs;
                    break;
                default:
                    tempArtNames = paintingNames;
                    artCategoryImages = paintingIDs;
                    break;
            }


            for (int i = 0; i < 6; i++) {
                Art tempArt = new Art(artCategoryImages[i], tempArtNames[i]);
                list.add(tempArt);
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
            ArtViewHolder holder = null;
            if (row == null) {
                LayoutInflater inflater = (LayoutInflater) context.getSystemService(Context.LAYOUT_INFLATER_SERVICE);
                row = inflater.inflate(R.layout.category_grid_cell_layout, parent, false);
                holder = new ArtViewHolder(row);
                row.setTag(holder);
            } else {
                holder = (ArtViewHolder) row.getTag();
            }

            Art tempArt = list.get(position);
            holder.myArtImage.setImageResource(tempArt.imageID);
            holder.myArtImage.setTag(tempArt);

            return row;
        }
    }
}