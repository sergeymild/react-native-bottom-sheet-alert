package com.reactlibrary;

import android.content.Context;
import android.graphics.Canvas;
import android.graphics.Color;
import android.graphics.Paint;
import android.util.TypedValue;
import android.view.Gravity;
import android.view.View;
import android.view.ViewGroup;
import android.widget.Button;
import android.widget.FrameLayout;
import android.widget.LinearLayout;
import android.widget.TextView;

import androidx.annotation.ColorInt;
import androidx.annotation.Nullable;

public class BottomSheetHeader extends FrameLayout {
    private final float density;
    private final Paint linePaint = new Paint(Paint.ANTI_ALIAS_FLAG);
    @Nullable
    private final View.OnClickListener saveButtonClickListener;

    public BottomSheetHeader(
            Context context,
            @Nullable String title,
            boolean isMultiSelect,
            @Nullable String saveButtonText,
            @Nullable View.OnClickListener saveButtonClickListener
    ) {
        super(context);
        this.saveButtonClickListener = saveButtonClickListener;
        density = getContext().getResources().getDisplayMetrics().density;
        linePaint.setColor(Color.LTGRAY);
        linePaint.setStyle(Paint.Style.FILL);
        setWillNotDraw(false);


        LinearLayout linearLayout = new LinearLayout(getContext());
        linearLayout.setOrientation(LinearLayout.HORIZONTAL);

        addTitle(title, Color.LTGRAY, linearLayout);

        if (isMultiSelect) {
            addSaveButton(saveButtonText != null ? saveButtonText : "Save", Color.BLACK, linearLayout);
        }

        int padding = (int)(density * 16);
        addView(linearLayout, new LayoutParams(ViewGroup.LayoutParams.MATCH_PARENT, ViewGroup.LayoutParams.MATCH_PARENT));
        linearLayout.setPadding(padding, 0, padding, 0);
    }

    private void addSaveButton(String text, @ColorInt int color, LinearLayout layout) {
        int padding = (int)(density * 8);
        final TypedValue outValue = new TypedValue();
        getContext().getTheme().resolveAttribute(android.R.attr.selectableItemBackground, outValue, true);
        TextView button = new TextView(getContext());
        button.setBackgroundResource(outValue.resourceId);
        button.setPadding(padding, 0, padding, 0);
        button.setGravity(Gravity.CENTER_VERTICAL);
        button.setText(text);
        button.setTextColor(color);
        button.setOnClickListener(saveButtonClickListener);
        layout.addView(button, new LinearLayout.LayoutParams(ViewGroup.LayoutParams.WRAP_CONTENT, (int) (density * 32)));
    }

    private void addTitle(String text, @ColorInt int color, LinearLayout layout) {

        TextView textView = new TextView(getContext());
        textView.setGravity(Gravity.CENTER_VERTICAL);
        textView.setPadding(0, 0, (int)(density * 16), 0);
        textView.setText(text);
        textView.setTextSize(TypedValue.COMPLEX_UNIT_SP, 16);
        textView.setTextColor(color);
        LinearLayout.LayoutParams layoutParams = new LinearLayout.LayoutParams(ViewGroup.LayoutParams.WRAP_CONTENT, (int) (density * 56));
        layoutParams.weight = 1f;
        layout.addView(textView, layoutParams);
    }

    @Override
    protected void onDraw(Canvas canvas) {
        super.onDraw(canvas);
        int lineHeight = (int) (density * 1);
        canvas.drawLine(0, getHeight() - lineHeight, getWidth(), getHeight(), linePaint);
    }
}
