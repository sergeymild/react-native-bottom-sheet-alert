# react-native-bottom-sheet-alert

## Getting started


######package.json
`"react-native-bottom-sheet-alert": "https://github.com/sergeymild/react-native-bottom-sheet-alert"`

`$ yarn`

## Usage
```typescript
import {BottomSheetAlert} from 'react-native-bottom-sheet-alert';

BottomSheetAlert.show({
  title?: string, // title can be optional
  multiselect?: boolean,
  saveButton?: string,
  buttons: [
    {text: string, style?: 'cancel' | 'destructive' | 'default', checked?: boolean, data?: any}
  ]},
  (selected: Array<BottomSheetAlertButton>) => console.log('ButtonPressed', selected)
)
```
