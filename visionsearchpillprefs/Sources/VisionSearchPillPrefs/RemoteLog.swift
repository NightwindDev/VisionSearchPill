import VisionSearchPillPrefsC

func remLog(_ objs: Any...) {
    let string = objs.map { String(describing: $0) }.joined(separator: "; ")
    let args: [CVarArg] = [ "[VisionSearchPill-\(Date().description)] \(string)" ]
    withVaList(args) { RLogv("%@", $0) }
}