import React from 'react';
import HeaderExample from './JS/NativeBaseTutorial'
import {AppRegistry, StyleSheet, Text, View} from 'react-native';

export default class RootModule extends React.Component {
    render() {
        return (
            <HeaderExample></HeaderExample>
        )
    }
}

AppRegistry.registerComponent('RootModule', () => RootModule);