import XcodeOpenCore

let tool = XcodeOpen()

do {
    try tool.execute()
} catch {
    print("Error... \(error)")
}
