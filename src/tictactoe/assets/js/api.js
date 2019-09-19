export function makePostRequest(url, body, onSuccess) {
    const settings = {
        method: 'POST',
        headers: {
            'Accept': 'application/json',
            'Content-Type': 'application/json',
        },
        body: JSON.stringify(body)
    }
    return fetch(url, settings)
        .then(response => response.json())
        .then(data => onSuccess(data))
}

export function makePutRequest(url, body, onSuccess) {
    const settings = {
        method: 'PUT',
        headers: {
            'Accept': 'application/json',
            'Content-Type': 'application/json',
        },
        body: JSON.stringify(body)
    }
    return fetch(url, settings)
        .then(response => response.json())
        .then(data => onSuccess(data))
}

export function makeGetRequest(url, onSuccess) {
    fetch(url)
        .then(response => response.json())
        .then(data => onSuccess(data))
}