import React, { useState, useEffect } from 'react';
import Cookies from 'js-cookie'

const CSRFToken = () => {

    const server = "http://127.0.0.1:8000/"

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
        // const fetchData = async () => {
        //     try {
        //         await axios.get(server.concat("csrf_cookie/"),{
        //             withCredentials: true
        //         }).then(response => {
        //             console.log(response.headers);
        //         });
        //     } catch (err) {

        //     }
        // };

        fetch(server.concat("csrf_cookie/"), {
            method: "GET",
            headers: {
                "Content-type": "application/json;",
            },
            credentials: "include"
        }).then(response => {
            console.log(response);
            console.log(document.cookie);
        })
        setcsrftoken(getCookie('csrftoken'));
    }, []);

    return (
        <input type='hidden' name='csrfmiddlewaretoken' value={csrftoken} />
    );
};

export default CSRFToken;