declare namespace httpclient="http://exist-db.org/xquery/httpclient";

(: should check for POST with request:we should not allow a get to redirect to a put 

	it takes the data from a post and performs a put 
	
	we'll need to encode the actual uri to post to in the form submitted with a post.
	
	:)

let $data := request:get-request-data()
let $method := request:get-method() (: fail if it's a get :)
let $url := $data/url (: grab the url to put too :)

(: perform the put :)
let $data := httpclient:put($url,  $data)

return $data