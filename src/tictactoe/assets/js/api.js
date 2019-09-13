
export function makePostRequest(url, body, successHandler){
    const settings = {
        method: 'POST',
        headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        },
        body: JSON.stringify(body)
    }
    return fetch(url, settings)
        .then(response => { return response.json(); })
        .then(data => successHandler(data))
}

export function makeGetRequest(url, successHandler){
    fetch(url)
        .then(response => { return response.json(); })
        .then(data => successHandler(data))
}