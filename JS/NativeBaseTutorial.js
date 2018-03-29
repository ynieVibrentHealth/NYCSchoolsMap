import React, { Component } from 'react';
import { Container, Header, Content,Title, Button, Left, Right, Body, Icon, Footer, Text } from 'native-base';

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
                </Content>
                <Footer />
            </Container>
        );
    }
}

