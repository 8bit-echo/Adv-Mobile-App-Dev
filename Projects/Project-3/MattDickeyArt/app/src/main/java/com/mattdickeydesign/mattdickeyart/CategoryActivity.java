package com.mattdickeydesign.mattdickeyart;

import android.app.Activity;
import android.content.Context;
import android.content.Intent;
import android.content.res.Resources;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.view.View;
import android.view.ViewGroup;
import android.widget.AdapterView;
import android.widget.BaseAdapter;
import android.widget.GridView;
import android.widget.ImageView;
import android.widget.TextView;

import org.w3c.dom.Text;

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

    @Override
    public void onItemClick(AdapterView<?> parent, View view, int position, long id) {

    }


    class Art {
        int imageID;
        String workTitle;

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


            //SWITCH STATEMENT WILL GO HERE
            this.context = context;
            list = new ArrayList<>();
            Resources res = getResources();
            //int[] artCategoryImages = {R.drawable.};
        }

        @Override
        public int getCount() {
            return 0;
        }

        @Override
        public Object getItem(int position) {
            return null;
        }

        @Override
        public long getItemId(int position) {
            return 0;
        }

        @Override
        public View getView(int position, View convertView, ViewGroup parent) {
            return null;
        }
    }
}