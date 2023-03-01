import React, { useState, useEffect } from 'react';
import Cookies from 'js-cookie'

const CSRFToken = () => {

    const server = "http://10.147.178.:8000/"

    const [csrftoken, setcsrftoken] = useState('');

    const getCookie = (name) => {
        let cookieValue = null;
        if (document.cookie && document.cookie !== '') {
            let cookies = document.cookie.split(';');
            for (let i = 0; i < cookies.length; i++) {
                let cookie = cookies[i].trim();
                if (cookie.substring(0, name.length + 1) === (name + '=')) {
                    cookieValue = decodeURIComponent(cookie.substring(name.length + 1));
                    break;
                }
            }
        }
        return cookieValue;
    }

    useEffect(() => {

        var xhttp = new XMLHttpRequest();;
        xhttp.onreadystatechange = function() {
            if (this.readyState == 4 && this.status == 200) {
               // Typical action to be performed when the document is ready:
               setcsrftoken(JSON.parse(this.response).token);
            }
        };
        xhttp.withCredentials = true;
        xhttp.open("GET", server.concat("csrf_cookie/"));
        xhttp.send();

    }, []);

    return (
        <input type='hidden' name='csrfmiddlewaretoken' value={csrftoken} />
    );
};

export default CSRFToken;