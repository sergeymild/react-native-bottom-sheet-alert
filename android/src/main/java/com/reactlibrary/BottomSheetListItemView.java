package com.reactlibrary;

import android.content.Context;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.util.Base64;
import android.util.TypedValue;
import android.view.Gravity;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.TextView;

public class BottomSheetListItemView extends LinearLayout {
    private final float density;
    private final ImageView checkedImage = new ImageView(getContext());

    static Bitmap getCheckedIcon() {
        String base64Icon = "iVBORw0KGgoAAAANSUhEUgAAADAAAAAwCAQAAAD9CzEMAAAApklEQVRYhe3NOw6CUBhE4dPRSkHvAgyNK2EZ1jY+YXNWrMIeV6DGa0OUp4nhTkTyTz/fAZvNZpvWFuRcWKn4mAKH406k5EWBN+/Yavnsr/nU+J/xx9HxcwIdH3DCcSbW8JCU16InUeUP3/Ow5PEhMZgHSF9EM+GFB8g6E9747kSV3w/l2wnvfDMh4OsJCd9O7Hzz9YSEB9hw48paxQOEzJS8zWYb/54xPa/oTp4wKAAAAABJRU5ErkJggg==";
        byte[] decodedString = Base64.decode(base64Icon, Base64.DEFAULT);
        return BitmapFactory.decodeByteArray(decodedString, 0, decodedString.length);
    }

    public BottomSheetListItemView(Context context, int tag, String title, int textColor) {
        super(context);
        TypedValue outValue = new TypedValue();
        context.getTheme().resolveAttribute(android.R.attr.selectableItemBackground, outValue, true);
        density = getContext().getResources().getDisplayMetrics().density;
        setBackgroundResource(outValue.resourceId);
        setTag(tag);
        setOrientation(HORIZONTAL);

        int padding = (int) (16 * density);
        setPadding(padding, 0, padding, 0);

        createButton(title, textColor);
    }

    public void setChecked(boolean isChecked) {
        if (checkedImage.getParent() == null) {
            addCheckedImageView();
        }
        checkedImage.setVisibility(isChecked ? VISIBLE : GONE);
    }

    private void addCheckedImageView() {
        LayoutParams layoutParams = new LayoutParams(LayoutParams.WRAP_CONTENT, LayoutParams.WRAP_CONTENT);
        layoutParams.gravity = Gravity.CENTER_VERTICAL;
        checkedImage.setImageBitmap(getCheckedIcon());
        addView(checkedImage, layoutParams);
    }

    private void createButton(String text, int color) {
        TextView textView = new TextView(getContext());
        textView.setGravity(Gravity.CENTER_VERTICAL);
        textView.setText(text);
        textView.setTextSize(TypedValue.COMPLEX_UNIT_SP, 16);
        textView.setTextColor(color);
        LayoutParams layoutParams = new LayoutParams(LayoutParams.WRAP_CONTENT, (int) (density * 56));
        layoutParams.weight = 1;
        addView(textView, layoutParams);
    }
}
