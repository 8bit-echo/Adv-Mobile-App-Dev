package com.mattdickeydesign.mattdickeyart;

import android.app.Activity;
import android.content.Intent;
import android.media.Image;
import android.os.Bundle;
import android.widget.ImageView;
import android.widget.TextView;

public class ArtDetailActivity extends Activity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_art_detail);

        Intent intent = getIntent();
        String workTitle = intent.getStringExtra("workTitle");
        int imageID = intent.getIntExtra("imageID", R.drawable.digital0);

        ImageView detailImageView = (ImageView) findViewById(R.id.detailImageView);
        TextView detailTextView = (TextView) findViewById(R.id.detailWorkTitleView);

        detailImageView.setImageResource(imageID);
        detailTextView.setText(workTitle);
    }
}
