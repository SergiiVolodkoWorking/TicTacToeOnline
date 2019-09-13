import * as React from 'react'
import { makeGetRequest } from '../api'

class Footer extends React.Component {
    constructor() {
        super();
        this.state = {
            version: ''
        }
    }

    componentDidMount() {
        makeGetRequest(
            'api/version',
            data => this.setState({ version: data.version }))
    }

    render() {
        return(
            <div>Version: <span id='version'>{this.state.version}</span></div>
        );
    }
}

export default Footer;