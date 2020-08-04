import Foundation
import SDL
import CSDL2
import GL

func main() throws {
    try SDLSystem.initialize(subSystems: [.video])

    let window = try SDLWindow(
        title: "Swift SDL2 OpenGL Demo",
        frame: (x: .centered, y: .centered, width: 800, height: 600),
        options: [.resizable, .opengl])

    let glContext = try SDLGLContext(window: window)

    var running = true

    var event = SDL_Event()

    while running {
        SDL_PollEvent(&event)
        let eventType = SDL_EventType(rawValue: event.type)

        switch eventType {
        case SDL_QUIT, SDL_APP_TERMINATING:
            running = false
        default:
            break
        }

        glClearColor(0.2, 0.3, 1.0, 1.0)
        glClear(GL.COLOR_BUFFER_BIT)

        window.glSwap()
    }

    SDLSystem.quit()
}

do {
    try main()
} catch let error as SDLError {
    print("SDL Error: \(error.debugDescription)")
    exit(EXIT_FAILURE)
} catch {
    print("Error: \(error)")
    exit(EXIT_FAILURE)
}