import AppKit

let output = "/private/tmp/Focumi_Reddit_Feedback_Showcase_2026-08-18/Focumi_Reddit_Feedback_Showcase.png"
let sources = [
  "/Users/USER/Documents/app/自律宠物-iOS/Evidence/iOS17Runtime-2026-08-18/screenshots/ios17-onboarding.png",
  "/Users/USER/Documents/app/自律宠物-iOS/Evidence/iOS17Runtime-2026-08-18/screenshots/ios17-setup.png",
  "/Users/USER/Documents/app/自律宠物-iOS/Evidence/iOS17Runtime-2026-08-18/screenshots/ios17-focusing-milo.png",
  "/Users/USER/Documents/app/自律宠物-iOS/Evidence/CharacterLifePhase1-2026-08-16/milo-waiting-preview-frame.png",
  "/Users/USER/Documents/app/自律宠物-iOS/Evidence/CharacterLifePhase1-2026-08-16/milo-final-completion.png"
]
let steps = [
  ("CHOOSE", "Pick a companion"),
  ("COMMIT", "Choose one thing to finish"),
  ("FOCUS", "Stay together while you work"),
  ("RETURN", "Come back and continue"),
  ("COMPLETE", "Finish the session together")
]

let size = NSSize(width: 3000, height: 1700)
let image = NSImage(size: size)
image.lockFocus()
let context = NSGraphicsContext.current!.cgContext
context.setFillColor(NSColor(calibratedRed: 0.985, green: 0.949, blue: 0.875, alpha: 1).cgColor)
context.fill(CGRect(origin: .zero, size: size))

func attrs(_ font: NSFont, _ color: NSColor, _ kern: CGFloat = 0) -> [NSAttributedString.Key: Any] {
  [.font: font, .foregroundColor: color, .kern: kern]
}
func centered(_ text: String, rect: CGRect, font: NSFont, color: NSColor, kern: CGFloat = 0) {
  let p = NSMutableParagraphStyle(); p.alignment = .center
  var a = attrs(font, color, kern); a[.paragraphStyle] = p
  NSAttributedString(string: text, attributes: a).draw(in: rect)
}
func rounded(_ rect: CGRect, radius: CGFloat, fill: NSColor, stroke: NSColor? = nil, width: CGFloat = 1) {
  let path = NSBezierPath(roundedRect: rect, xRadius: radius, yRadius: radius)
  fill.setFill(); path.fill()
  if let stroke { stroke.setStroke(); path.lineWidth = width; path.stroke() }
}
func drawFitted(_ source: NSImage, in target: CGRect) {
  let ratio = source.size.width / source.size.height
  let targetRatio = target.width / target.height
  var draw = target
  if ratio > targetRatio {
    draw.size.width = target.height * ratio
    draw.origin.x = target.midX - draw.width / 2
  } else {
    draw.size.height = target.width / ratio
    draw.origin.y = target.midY - draw.height / 2
  }
  source.draw(in: draw, from: NSRect(origin: .zero, size: source.size), operation: .sourceOver, fraction: 1)
}

let brown = NSColor(calibratedRed: 0.27, green: 0.16, blue: 0.13, alpha: 1)
let muted = NSColor(calibratedRed: 0.43, green: 0.34, blue: 0.30, alpha: 1)
let coral = NSColor(calibratedRed: 0.80, green: 0.39, blue: 0.30, alpha: 1)
let blue = NSColor(calibratedRed: 0.39, green: 0.56, blue: 0.65, alpha: 1)

// Quiet editorial header
rounded(CGRect(x: 112, y: 1514, width: 134, height: 38), radius: 19, fill: coral)
centered("FOCUMI", rect: CGRect(x: 102, y: 1517, width: 154, height: 28), font: .systemFont(ofSize: 18, weight: .bold), color: .white, kern: 1.8)
centered("A companion-led focus flow", rect: CGRect(x: 290, y: 1511, width: 1050, height: 48), font: .systemFont(ofSize: 35, weight: .semibold), color: brown)
centered("What feels confusing, unnecessary, or worth keeping?", rect: CGRect(x: 1280, y: 1517, width: 1600, height: 34), font: .systemFont(ofSize: 23, weight: .medium), color: muted)

let startX: CGFloat = 112
let colWidth: CGFloat = 550
let gap: CGFloat = 22
let phoneWidth: CGFloat = 390
let phoneHeight: CGFloat = 846
let phoneY: CGFloat = 270

for i in 0..<5 {
  let x = startX + CGFloat(i) * (colWidth + gap)
  let step = steps[i]
  centered(step.0, rect: CGRect(x: x, y: 1340, width: colWidth, height: 58), font: .systemFont(ofSize: 48, weight: .heavy), color: i == 3 ? blue : coral, kern: 1.5)
  centered(step.1, rect: CGRect(x: x + 18, y: 1282, width: colWidth - 36, height: 42), font: .systemFont(ofSize: 25, weight: .medium), color: muted)
  let phone = CGRect(x: x + (colWidth - phoneWidth) / 2, y: phoneY, width: phoneWidth, height: phoneHeight)
  context.saveGState()
  rounded(phone.insetBy(dx: -9, dy: -9), radius: 55, fill: NSColor(calibratedWhite: 0.10, alpha: 1))
  let clip = NSBezierPath(roundedRect: phone, xRadius: 45, yRadius: 45); clip.addClip()
  if let source = NSImage(contentsOfFile: sources[i]) { drawFitted(source, in: phone) }
  context.restoreGState()
  let bezel = NSBezierPath(roundedRect: phone, xRadius: 45, yRadius: 45); NSColor(calibratedWhite: 0.10, alpha: 1).setStroke(); bezel.lineWidth = 4; bezel.stroke()
  if i < 4 {
    let lineY = phoneY + phoneHeight / 2
    let arrowStart = x + colWidth + 1
    coral.withAlphaComponent(0.55).setStroke()
    let p = NSBezierPath(); p.move(to: NSPoint(x: arrowStart, y: lineY)); p.line(to: NSPoint(x: arrowStart + 14, y: lineY)); p.lineWidth = 2.5; p.stroke()
    let a = NSBezierPath(); a.move(to: NSPoint(x: arrowStart + 9, y: lineY + 5)); a.line(to: NSPoint(x: arrowStart + 15, y: lineY)); a.line(to: NSPoint(x: arrowStart + 9, y: lineY - 5)); a.lineWidth = 2.5; a.stroke()
  }
}

NSColor(calibratedRed: 0.90, green: 0.80, blue: 0.62, alpha: 1).setStroke()
let base = NSBezierPath(); base.move(to: NSPoint(x: 112, y: 150)); base.line(to: NSPoint(x: 2888, y: 150)); base.lineWidth = 1; base.stroke()
centered("Early visual prototype — asking for honest feedback", rect: CGRect(x: 112, y: 78, width: 2776, height: 34), font: .systemFont(ofSize: 22, weight: .medium), color: muted)

image.unlockFocus()
let data = image.tiffRepresentation!
let bitmap = NSBitmapImageRep(data: data)!
guard let png = bitmap.representation(using: .png, properties: [:]) else { fatalError("PNG encoding failed") }
try png.write(to: URL(fileURLWithPath: output))
