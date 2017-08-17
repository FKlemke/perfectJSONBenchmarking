

#if os(Linux)
    import Glibc
#else
    import Darwin
#endif

import PerfectLib
import PerfectHTTP
import PerfectHTTPServer

// Create HTTP server.
let server = HTTPServer()

// Create the container variable for routes to be added to.
var routes = Routes()

func getJSON() -> [String: Int] {
    var rndJSON = [String: Int]()
    for i in 1...1000 {
        let randomNumber = Int(arc4random_uniform(UInt32(10)))
        rndJSON["Index \(i)"] = randomNumber
    }
    return rndJSON
}


routes.add(method: .get, uri: "/plaintextPerfect", handler: {
    request, response in
    response.setHeader(.contentType, value: "text/html")
    response.appendBody(string: "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet.")
    
    response.completed()
})

// Adding a route to handle the GET people list URL
routes.add(method: .get, uri: "/jsonPerfect", handler: {
    request, response in

    let rndJSON = getJSON()
    
    do{
    // Setting the response content type explicitly to application/json
    response.setHeader(.contentType, value: "application/json; charset=utf-8")
    try response.setBody(json: rndJSON)
    }catch {
    // Setting the body response to the JSON list generated
    response.appendBody(string: "JSON Failed")
    }
    // Signalling that the request is completed
    response.completed()
})

// Add the routes to the server.
server.addRoutes(routes)

// Set a listen port of 8080
server.serverPort = 8080

do {
	// Launch the HTTP server.
	try server.start()
} catch PerfectError.networkError(let err, let msg) {
	print("Network error thrown: \(err) \(msg)")
}
