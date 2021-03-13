# react-native-bottom-sheet-alert

## Getting started


###### package.json
`"react-native-bottom-sheet-alert": "https://github.com/sergeymild/react-native-bottom-sheet-alert"`

`$ yarn`

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
