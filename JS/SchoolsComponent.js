import React from 'react';
import {AppRegistry, StyleSheet, Text, View, Image} from 'react-native';

export default class SchoolsComponent extends React.Component {
    render() {
        return (
            <View style={styles.container}>
                <Text style={styles.highScoresTitle}>Just another test view</Text>
                <Text style={styles.scores}>Holla</Text>
            </View>
        )
    }
}

AppRegistry.registerComponent('SchoolsComponent', () => SchoolsComponent);

const styles = StyleSheet.create({
    container: {
        flex: 1,
        justifyContent: 'center',
        alignItems: 'top',
        backgroundColor: '#FFFFFF',
    },
    highScoresTitle: {
        fontSize: 20,
        textAlign: 'center',
        margin: 10,
    },
    scores: {
        textAlign: 'center',
        color: '#333333',
        marginBottom: 5,
    },
});