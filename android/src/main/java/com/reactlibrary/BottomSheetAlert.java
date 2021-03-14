package com.reactlibrary;

import android.app.Activity;
import android.graphics.Color;
import android.view.View;
import android.widget.LinearLayout;

import androidx.annotation.Nullable;
import androidx.core.widget.NestedScrollView;

import com.facebook.react.bridge.Arguments;
import com.facebook.react.bridge.Callback;
import com.facebook.react.bridge.ReadableArray;
import com.facebook.react.bridge.ReadableMap;
import com.google.android.material.bottomsheet.BottomSheetDialog;

import java.util.ArrayList;
import java.util.Collections;
import java.util.HashSet;
import java.util.Set;

public class BottomSheetAlert {
    private final Activity context;
    private final ReadableMap options;
    private final float density;

    public BottomSheetAlert(Activity context, ReadableMap options) {
        this.context = context;
        this.options = options;
        density = context.getResources().getDisplayMetrics().density;
    }

    @Nullable
    BottomSheetDialog create(final Callback actionCallback) {
        final BottomSheetDialog dialog = new BottomSheetDialog(context);
        NestedScrollView nestedScrollView = new NestedScrollView(context);

        final LinearLayout baseLayout = new LinearLayout(context);
        baseLayout.setOrientation(LinearLayout.VERTICAL);

        final LinearLayout linearLayout = new LinearLayout(context);
        nestedScrollView.addView(linearLayout);
        linearLayout.setOrientation(LinearLayout.VERTICAL);
        ReadableArray buttons = options.getArray("buttons");
        if (buttons == null) return null;

        final boolean isMultiSelect = options.hasKey("multiselect") && options.getBoolean("multiselect");
        final boolean hasHeader = options.hasKey("title") || isMultiSelect;

        LinearLayout.LayoutParams layoutParams = new LinearLayout.LayoutParams(
                LinearLayout.LayoutParams.MATCH_PARENT,
                (int) (density * 56)
        );

        final Set<Integer> selected = new HashSet<>(buttons.size());


        if (hasHeader) {
            View.OnClickListener headerSaveClick = new View.OnClickListener() {
                public void onClick(View view) {
                    dialog.dismiss();
                    actionCallback.invoke(Arguments.fromList(new ArrayList<>(selected)));
                }
            };
            BottomSheetHeader header = new BottomSheetHeader(
                    context,
                    options.getString("title"),
                    isMultiSelect,
                    options.getString("saveButton"),
                    isMultiSelect ? headerSaveClick : null
            );
            baseLayout.addView(header, layoutParams);
        }


        View.OnClickListener clickListener = new View.OnClickListener() {
            public void onClick(View v) {
                Integer tag = (Integer)v.getTag();
                if (!isMultiSelect) {
                    dialog.dismiss();
                    actionCallback.invoke(Arguments.fromList(Collections.singletonList(tag)));
                    return;
                }
                boolean contains = selected.contains(tag);
                ((BottomSheetListItemView) v).setChecked(!contains);
                if (contains) selected.remove(tag);
                else selected.add(tag);
            }
        };

        int cancelButtonIndex = -1;
        for (int i = 0; i < buttons.size(); i++) {
            ReadableMap readableMap = buttons.getMap(i);
            String style = readableMap.getString("style");
            String text = readableMap.getString("text");
            boolean isChecked = readableMap.hasKey("checked") && readableMap.getBoolean("checked");

            boolean isCancel = style != null && style.equals("cancel");
            if (isCancel) {
                cancelButtonIndex = i;
                continue;
            }

            boolean isDestructive = style != null && style.equals("destructive");
            int color = isDestructive ? Color.RED : Color.BLACK;

            BottomSheetListItemView listItemView = new BottomSheetListItemView(context, i, text, color);
            listItemView.setOnClickListener(clickListener);
            linearLayout.addView(listItemView, layoutParams);
            listItemView.setChecked(isChecked);
            if (isChecked) selected.add(i);
        }
        if (cancelButtonIndex != -1) {
            ReadableMap readableMap = buttons.getMap(cancelButtonIndex);
            boolean isChecked = readableMap.hasKey("checked") && readableMap.getBoolean("checked");
            String text = readableMap.getString("text");
            BottomSheetListItemView listItemView = new BottomSheetListItemView(context, cancelButtonIndex, text, Color.BLACK);
            listItemView.setOnClickListener(clickListener);
            listItemView.setChecked(isChecked);
            linearLayout.addView(listItemView, layoutParams);
            if (isChecked) selected.add(cancelButtonIndex);
        }

        baseLayout.addView(nestedScrollView);
        dialog.setContentView(baseLayout);
        return dialog;
    }
}