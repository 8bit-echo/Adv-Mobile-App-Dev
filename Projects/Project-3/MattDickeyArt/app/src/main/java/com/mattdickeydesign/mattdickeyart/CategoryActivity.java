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
    }

    Art angel = new Art("paintings", R.drawable.painting0 , "Angel");
    Art anne = new Art("paintings", R.drawable.painting1, "Anne R. Ekcia");
    Art barbie = new Art("paintings", R.drawable.painting2, "Barbia");
    Art jasmine = new Art("paintings", R.drawable.painting3, "Jasmine");
    Art myrtle = new Art("paintings", R.drawable.painting4, "Fertile Myrtle");
    Art octophant = new Art("paintings", R.drawable.painting5, "Octophant");

    Art[] paintings = {angel,anne,barbie,jasmine,myrtle,octophant};




    @Override
    public void onItemClick(AdapterView<?> parent, View view, int position, long id) {

    }


    class Art {
        String category;
        int imageID;
        String workTitle;


        // Constructor
        Art(String category, int imageID, String workTitle) {
            this.category = category;
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
        String[] tempArtNames = res.getStringArray(R.array.Paintings);
        int[] artCategoryImages = {R.drawable.painting0, R.drawable.painting1, R.drawable.painting2, R.drawable.painting3, R.drawable.painting4, R.drawable.painting5};

        for (int i = 0; i < 6; i++){
            Art tempArt = new Art("paintings", artCategoryImages[i], tempArtNames[i]);
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
        if (row == null){
            LayoutInflater inflater = (LayoutInflater) context.getSystemService(Context.LAYOUT_INFLATER_SERVICE);
            row = inflater.inflate(R.layout.category_grid_cell_layout, parent, false);
            holder = new ArtViewHolder(row);
            row.setTag(holder);
        } else {
            holder = (ArtViewHolder) row.getTag();
        }

        Art tempArt = list.get(position);
        holder.myArtImage.setImageResource(tempArt.imageID);

        return row;
    }
}
}