import {NativeModules} from 'react-native';

export type BottomSheetAlertButtonStyle = 'default' | 'destruction' | 'cancel'

export interface BottomSheetAlertButton {
  readonly text: string
  readonly style?: BottomSheetAlertButtonStyle
}

interface BottomSheetAlertProperties {
  readonly title?: string
  readonly buttons: Array<BottomSheetAlertButton>
}

type Callback = (button: BottomSheetAlertButton) => void

export class BottomSheetAlert {
  static show(properties: BottomSheetAlertProperties, callback: Callback) {
    NativeModules.BottomSheetAlert.show(properties, (index: number) => {
      callback(properties.buttons[index])
    })
  }
}
