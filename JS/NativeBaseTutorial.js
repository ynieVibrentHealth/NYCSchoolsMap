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
                    <Title>
                    </Title>
                    <Text>
                        This is Content Section
                    </Text>

                    <Button light onPress={
                        buttonClick.bind(this)
                    }
                    onClick={
                        console.log("On click has been pressed")
                    }>
                        <Text>Press Me!</Text>
                    </Button>
                    <List>
                        <ListItem itemHeader first>
                            <Text>COMEDY</Text>
                        </ListItem>
                        <ListItem >
                            <MovieNameComponent movieName="Thor" imageURL={"http://nintendoenthusiast.com/wp-content/uploads/2018/01/Fortnite.jpg"}/>
                        </ListItem>
                        <ListItem>
                            <Text>Horrible Bosses</Text>
                        </ListItem>
                        <ListItem last>
                            <Text>Conjuring</Text>
                        </ListItem>
                        <ListItem itemHeader>
                            <Text>ACTION</Text>
                        </ListItem>
                        <ListItem>
                            <Text>Terminator Genesis</Text>
                        </ListItem>
                    </List>
                </Content>
                <Footer />
            </Container>
        );
    }
}

