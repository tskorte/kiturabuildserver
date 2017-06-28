import Kitura
import HeliumLogger
import Foundation

HeliumLogger.use()
let router = Router()
let homePath = "/home/vaporizer/"
let buildPath = "/home/vaporizer/build"

func createGitProcess() -> Process {
    let process = Process()
    process.launchPath = "/usr/bin/env"
    process.arguments = ["sh", "\(homePath)/gitScript.sh"]
    return process
}

func createBuildProcess() -> Process{
    let process = Process()
    process.launchPath = "/usr/bin/env"
    process.arguments = ["sh", "\(homePath)/buildScript.sh"]
    return process
}

func createDeployProcess() -> Process{
    let process = Process()
    process.launchPath = "/usr/bin/env"
    process.arguments = ["sh", "/home/vaporizer/build/pull.sh"]
    return process
}

router.post("gitpush"){
    request, response, next in
    NSLog("GITPUSH")
    let processes: [Process] = [createGitProcess(), createBuildProcess()]
    processes.forEach{
        print("Running \(String(describing: $0.launchPath))")
        $0.launch()
        $0.waitUntilExit()
        print("Finished \($0.terminationStatus)")
    }
    response.send("OK")
}

Kitura.addHTTPServer(onPort: 8080, with: router)
Kitura.run()

