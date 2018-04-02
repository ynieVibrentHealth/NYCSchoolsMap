import React, { Component } from 'react';
import MovieNameComponent from './MovieNameComponent'
import { Container, Content,Title, Button, Left, Right, Body, List, ListItem, Footer, Text } from 'native-base';

function buttonClick(event) {
    console.log("logging")
}

export default class HeaderExample extends Component {
    render() {
        return (
            <Container>
                <Content padder>
                    <Button light onPress={
                        buttonClick.bind(this)
                    }
                    onClick={
                        console.log("On click has been pressed")
                    }>
                        <Text>Press Me!</Text>
                    </Button>
                    <List>
                        <ListItem itemDivider>
                            <Text>A</Text>
                        </ListItem>
                        <ListItem >
                            <Text>Aaron Bennet</Text>
                        </ListItem>
                        <ListItem>
                            <Text>Ali Connors</Text>
                        </ListItem>
                        <ListItem itemDivider>
                            <Text>B</Text>
                        </ListItem>
                        <ListItem>
                            <Text>Bradley Horowitz</Text>
                        </ListItem>
                    </List>
                </Content>
            </Container>
        );
    }
}

