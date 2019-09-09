import * as React from 'react'
import 'bootstrap'

class Footer extends React.Component {
    constructor() {
        super();
        this.state = {
            version: ''
        }
    }

    componentDidMount() {
        fetch('api/version')
            .then(response => { return response.json(); })
            .then(data => this.setState({ version: data.version }))
    }

    render() {
        return(
            <div>Version: <span id='version'>{this.state.version}</span></div>
        );
    }
}

export default Footer;