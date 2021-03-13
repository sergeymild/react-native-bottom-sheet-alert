package com.reactlibrary;

import android.app.Activity;
import android.graphics.Color;
import android.util.TypedValue;
import android.view.Gravity;
import android.view.View;
import android.widget.LinearLayout;
import android.widget.TextView;

import androidx.core.widget.NestedScrollView;

import com.facebook.react.bridge.Callback;
import com.facebook.react.bridge.ReadableArray;
import com.facebook.react.bridge.ReadableMap;
import com.google.android.material.bottomsheet.BottomSheetDialog;

public class BottomSheetAlert {
    private final Activity context;
    private final ReadableMap options;
    private final TypedValue outValue = new TypedValue();
    private final float density;

    public BottomSheetAlert(Activity context, ReadableMap options) {
        this.context = context;
        this.options = options;
        context.getTheme().resolveAttribute(android.R.attr.selectableItemBackground, outValue, true);
        density = context.getResources().getDisplayMetrics().density;
    }

    BottomSheetDialog create(final Callback actionCallback) {
        final BottomSheetDialog dialog = new BottomSheetDialog(context);
        NestedScrollView nestedScrollView = new NestedScrollView(context);
        final LinearLayout linearLayout = new LinearLayout(context);
        nestedScrollView.addView(linearLayout);
        linearLayout.setOrientation(LinearLayout.VERTICAL);
        LinearLayout.LayoutParams layoutParams = new LinearLayout.LayoutParams(
                LinearLayout.LayoutParams.MATCH_PARENT,
                (int) (density * 56)
        );

        View.OnClickListener clickListener = new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                dialog.dismiss();
                actionCallback.invoke(v.getTag());
            }
        };

        if (options.hasKey("title")) {
            TextView title = createButton(options.getString("title"), Color.LTGRAY, -1);
            linearLayout.addView(title, layoutParams);
        }

        ReadableArray buttons = options.getArray("buttons");
        int cancelButtonIndex = -1;
        for (int i = 0; i < buttons.size(); i++) {
            ReadableMap readableMap = buttons.getMap(i);
            String style = readableMap.getString("style");
            String text = readableMap.getString("text");

            boolean isCancel = style != null && style.equals("cancel");
            if (isCancel) {
                cancelButtonIndex = i;
                continue;
            }

            boolean isDestructive = style != null && style.equals("destructive");
            int color = isDestructive ? Color.RED : Color.BLACK;
            TextView button = createButton(text, color, i);
            button.setOnClickListener(clickListener);
            linearLayout.addView(button, layoutParams);
        }
        if (cancelButtonIndex != -1) {
            ReadableMap readableMap = buttons.getMap(cancelButtonIndex);
            TextView button = createButton(readableMap.getString("text"), Color.BLACK, cancelButtonIndex);
            button.setOnClickListener(clickListener);
            linearLayout.addView(button, layoutParams);
        }

        dialog.setContentView(nestedScrollView);
        return dialog;
    }

    private TextView createButton(String text, int color, int tag) {
        TextView textView = new TextView(context);
        textView.setBackgroundResource(outValue.resourceId);
        textView.setGravity(Gravity.CENTER_VERTICAL);
        textView.setPadding((int)(density * 16), 0, (int)(density * 16), 0);
        textView.setText(text);
        textView.setTextSize(TypedValue.COMPLEX_UNIT_SP, 16);
        textView.setTextColor(color);
        textView.setTag(tag);
        return textView;
    }
}