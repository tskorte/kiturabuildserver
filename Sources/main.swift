import Kitura
import HeliumLogger
HeliumLogger.use()
let router = Router()

router.post("gitpush"){
    request, response, next in
    print("GITPUSH MOFO")
    response.send("OK")
}

Kitura.addHTTPServer(onPort: 8080, with: router)
Kitura.run()

func deploy(){
    
}