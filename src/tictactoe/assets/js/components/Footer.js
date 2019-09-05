import * as React from 'react'

class Footer extends React.Component {
    constructor(){
        super();
        this.state = {
            version:''
        }
    }

    componentDidMount() {
        fetch('api/version')
        .then(response => { return response.json();})
        .then(data => this.setState(
            {version: data.version}))
    }

    render() {
        return(
            <div>Version: {this.state.version}</div>
        );
      }
}

export default Footer;