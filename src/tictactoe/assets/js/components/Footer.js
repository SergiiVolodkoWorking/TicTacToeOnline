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
        $(function () {
            $('#version').tooltip()
        })

        fetch('api/version')
            .then(response => { return response.json(); })
            .then(data => this.setState({ version: data.version }))
    }

    render() {
        return(
            <div>Version: <span id='version' data-toggle="tooltip" data-placement="top" title="Tooltip works!">{this.state.version}</span></div>
        );
    }
}

export default Footer;