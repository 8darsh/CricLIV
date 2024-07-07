import SwiftUI
struct MyIcon: Shape {
    var controlPoint = 0.0
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let width = rect.size.width
        let height = rect.size.height
        path.move(to: CGPoint(x: 0.88083*width, y: 0.34164*height))
        path.addCurve(to: CGPoint(x: 0.86879*width, y: 0.32714*height), control1: CGPoint(x: 0.88083*width, y: 0.33296*height), control2: CGPoint(x: 0.8751*width, y: 0.32668*height))
        path.addCurve(to: CGPoint(x: 0.8614*width, y: 0.3274*height), control1: CGPoint(x: 0.86635*width, y: 0.32731*height), control2: CGPoint(x: 0.86388*width, y: 0.3274*height))
        path.addCurve(to: CGPoint(x: 0.73575*width, y: 0.17082*height), control1: CGPoint(x: 0.79201*width, y: 0.3274*height), control2: CGPoint(x: 0.73575*width, y: 0.2573*height))
        path.addCurve(to: CGPoint(x: 0.73682*width, y: 0.15031*height), control1: CGPoint(x: 0.73575*width, y: 0.16387*height), control2: CGPoint(x: 0.73611*width, y: 0.15702*height))
        path.addCurve(to: CGPoint(x: 0.7228*width, y: 0.12456*height), control1: CGPoint(x: 0.73816*width, y: 0.13753*height), control2: CGPoint(x: 0.7322*width, y: 0.12456*height))
        path.addLine(to: CGPoint(x: 0.20466*width, y: 0.12456*height))
        path.addCurve(to: CGPoint(x: 0.04663*width, y: 0.34164*height), control1: CGPoint(x: 0.11738*width, y: 0.12456*height), control2: CGPoint(x: 0.04663*width, y: 0.22175*height))
        path.addLine(to: CGPoint(x: 0.04663*width, y: 0.65125*height))
        path.addCurve(to: CGPoint(x: 0.20466*width, y: 0.86833*height), control1: CGPoint(x: 0.04663*width, y: 0.77114*height), control2: CGPoint(x: 0.11738*width, y: 0.86833*height))
        path.addLine(to: CGPoint(x: 0.7228*width, y: 0.86833*height))
        path.addCurve(to: CGPoint(x: 0.88083*width, y: 0.65125*height), control1: CGPoint(x: 0.81008*width, y: 0.86833*height), control2: CGPoint(x: 0.88083*width, y: 0.77114*height))
        path.addLine(to: CGPoint(x: 0.88083*width, y: 0.34164*height))
        path.closeSubpath()
        path.addEllipse(in: CGRect(x: 0.76425*width, y: 0.0605*height, width: 0.17617*width, height: 0.22776*height))
        path.move(to: CGPoint(x: 0.87111*width, y: 0.1533*height))
        path.addCurve(to: CGPoint(x: 0.86808*width, y: 0.14859*height), control1: CGPoint(x: 0.87122*width, y: 0.15085*height), control2: CGPoint(x: 0.86986*width, y: 0.14874*height))
        path.addLine(to: CGPoint(x: 0.83899*width, y: 0.14609*height))
        path.addCurve(to: CGPoint(x: 0.83555*width, y: 0.15025*height), control1: CGPoint(x: 0.8372*width, y: 0.14593*height), control2: CGPoint(x: 0.83567*width, y: 0.1478*height))
        path.addCurve(to: CGPoint(x: 0.83859*width, y: 0.15497*height), control1: CGPoint(x: 0.83544*width, y: 0.1527*height), control2: CGPoint(x: 0.8368*width, y: 0.15481*height))
        path.addLine(to: CGPoint(x: 0.86444*width, y: 0.15719*height))
        path.addLine(to: CGPoint(x: 0.86283*width, y: 0.1927*height))
        path.addCurve(to: CGPoint(x: 0.86585*width, y: 0.19742*height), control1: CGPoint(x: 0.86272*width, y: 0.19516*height), control2: CGPoint(x: 0.86407*width, y: 0.19727*height))
        path.addCurve(to: CGPoint(x: 0.86929*width, y: 0.19326*height), control1: CGPoint(x: 0.86764*width, y: 0.19758*height), control2: CGPoint(x: 0.86918*width, y: 0.19571*height))
        path.addLine(to: CGPoint(x: 0.87111*width, y: 0.1533*height))
        path.closeSubpath()
        path.move(to: CGPoint(x: 0.82598*width, y: 0.20974*height))
        path.addLine(to: CGPoint(x: 0.87002*width, y: 0.15636*height))
        path.addLine(to: CGPoint(x: 0.86573*width, y: 0.14969*height))
        path.addLine(to: CGPoint(x: 0.82169*width, y: 0.20307*height))
        path.addLine(to: CGPoint(x: 0.82598*width, y: 0.20974*height))
        path.closeSubpath()
        return path
    }
}
