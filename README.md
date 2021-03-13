# react-native-bottom-sheet-alert

## Getting started

`$ yarn add react-native-bottom-sheet-alert`

## Usage
```typescript
import {BottomSheetAlert} from 'react-native-bottom-sheet-alert';

BottomSheetAlert.show({
  title: 'Dialog title', // title can be optional
  buttons: [
    {text: 'Button title', style: 'cancel' | 'destruction' | 'default'}, // style can be optional (default)
  ]},
  (pressed: BottomSheetAlertButton) => console.log('ButtonPressed', pressed)
)
```
