package com.mattdickeydesign.mattdickeyart;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.view.MotionEvent;
import android.view.ScaleGestureDetector;
import android.widget.ImageView;
import android.widget.TextView;

public class ArtDetailActivity extends Activity {

    ImageView detailImageView;
    android.graphics.Matrix matrix = new android.graphics.Matrix();
    Float scale = 1f;
    ScaleGestureDetector sgd;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_art_detail);

        Intent intent = getIntent();
        String workTitle = intent.getStringExtra("workTitle");
        int imageID = intent.getIntExtra("imageID", R.drawable.digital0);

//        ImageView detailImageView = (ImageView) findViewById(R.id.detailImageView);


        detailImageView = (ImageView) findViewById(R.id.detailImageView);
        sgd = new ScaleGestureDetector(this, new ScaleListener());


        TextView detailTextView = (TextView) findViewById(R.id.detailWorkTitleView);

        detailImageView.setImageResource(imageID);
        detailTextView.setText(workTitle);

        TextView detailDesc = (TextView) findViewById(R.id.detailDesc);

        String y2012 = "(2012) ";
        String y2013 = "(2013) ";
        String y2014 = "(2014) ";
        String y2015 = "(2015) ";


        String wcop = " Watercolor on Paper.";
        String ooc = "Oil on Canvas";
        String aop = "Acrylic on Paper";

        String cpop = "Colored Pencil on Paper";
        String gop = "Graphite on Paper";
        String chop = "Charcoal on Paper";
        String d = "Procreate for iPad";

        switch (workTitle) {
            case "Angel":
                detailDesc.setText(y2015 + wcop);
                break;
            case "Anne":
                detailDesc.setText(y2015 + wcop);
                break;
            case "Barbie":
                detailDesc.setText(y2014 + ooc);
                break;
            case "Jasmine":
                detailDesc.setText(y2015 + wcop);
                break;
            case "Myrtle":
                detailDesc.setText(y2013 + "Acrylic on Plexiglass");
                break;
            case "Octophant":
                detailDesc.setText(y2013 + aop);
                break;
            case "22 Self portrait":
                detailDesc.setText(y2013 + cpop);
                break;
            case "Chirophobia":
                detailDesc.setText(y2012 + chop);
                break;
            case "Dead Girl":
                detailDesc.setText(y2013 + gop);
                break;
            case "Lacee as Maleficent":
                detailDesc.setText(y2013 + gop);
                break;
            case "Teeth":
                detailDesc.setText(y2015 + gop);
                break;
            case "New School Owl":
                detailDesc.setText(y2015 + cpop);
                break;
            case "23":
                detailDesc.setText(y2014 + d);
                break;
            case "Atlas of the Mind":
                detailDesc.setText(y2014 + d);
                break;
            case "One Man Band":
                detailDesc.setText(y2015 + d);
                break;
            case "Owl":
                detailDesc.setText(y2015 + d);
                break;
            case "Hand Study":
                detailDesc.setText(y2015 + d);
                break;
            case "Girlface Helmet":
                detailDesc.setText(y2015 + d);
                break;
            default:
                detailDesc.setText("");
                break;

        }
    }

    private class ScaleListener extends ScaleGestureDetector.SimpleOnScaleGestureListener{
        @Override
        public boolean onScale(ScaleGestureDetector detector){
            scale = scale * detector.getScaleFactor();
            scale = Math.max(.5f, Math.min(scale,5f));
            matrix.setScale(scale, scale);
            detailImageView.setImageMatrix(matrix);
            return  true;

        }
    }

    @Override
    public boolean onTouchEvent(MotionEvent event){
        sgd.onTouchEvent(event);
        return true;
    }

}