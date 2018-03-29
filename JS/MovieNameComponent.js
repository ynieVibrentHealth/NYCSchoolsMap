import React, { Component } from 'react';
import { Image } from 'react-native';
import { Container, Content,Title, Button, Left, Right, Body, List, ListItem, Footer, Text } from 'native-base';

export default class MovieNameComponent extends React.Component {
    render() {
        return (
            <Content>
                <Image source={{uri: this.props.imageURL}} style={{height: 200, width: null, flex: 1}}/>
                <Text>
                    {this.props.movieName}
                </Text>
            </Content>
        )
    }
}