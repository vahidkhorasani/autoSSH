# hello-world
My first repository on GitHub
This is not any special project and is just for test

<h1>HTTP Request Types</h1>
- GET - retrieve resource
- POST - create new resource
- PUT - update existing resource
- DELETE - delete resource

<h2>HEAD Request</h2>
The HEAD method is identical to GET except that the server MUST NOT return a message-body in the response. The metainformation contained in the HTTP headers in response to a HEAD request SHOULD be identical to the information sent in response to a GET request. This method can be used for obtaining metainformation about the entity implied by the request without transferring the entity-body itself. This method is often used for testing hypertext links for validity, accessibility, and recent modification.
<h2>GET Request</h2>
The GET method means retrieve whatever information (in the form of an entity) is identified by the Request-URI
<h2>PUT Request</h2>
PUT puts a file or resource at a specific URI, and exactly at that URI. If there's already a file or resource at that URI, PUT replaces that file or resource. If there is no file or resource there, PUT creates one.
<h2>POST Request</h2>
POST sends data to a specific URI and expects the resource at that URI to handle the request.
An HTTP PUT is supposed to accept the body of the request, and then store that at the resource identified by the URI.
An HTTP POST is more general. It is supposed to initiate an action on the server. That action could be to store the request body at the resource identified by the URI, or it could be a different URI, or it could be a different action.</p>

<p>PUT is like a file upload. A put to a URI affects exactly that URI. A POST to a URI could have any effect at all.</p>

