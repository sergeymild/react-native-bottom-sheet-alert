import {NativeModules} from 'react-native';

export type BottomSheetAlertButtonStyle = 'default' | 'destructive' | 'cancel'

export interface BottomSheetAlertButton {
  readonly text: string
  readonly style?: BottomSheetAlertButtonStyle
  readonly checked?: boolean
  readonly data?: any
}

interface BottomSheetAlertProperties {
  readonly title?: string
  readonly multiselect?: boolean
  readonly saveButton?: string
  readonly buttons: Array<BottomSheetAlertButton>
}

type Callback = (selected: Array<BottomSheetAlertButton>) => void

export class BottomSheetAlert {
  static show(properties: BottomSheetAlertProperties, callback: Callback) {
    NativeModules.BottomSheetAlert.show(properties, (indices: Array<number>) => {
      const selected = properties.buttons.filter((b, i) => indices.indexOf(i) !== -1)
      callback(selected)
    })
  }
}
