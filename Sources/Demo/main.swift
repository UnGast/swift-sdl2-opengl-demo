import Foundation
import CSDL2
import GL

var vertexShaderSource = """
#version 330 core
layout (location = 0) in vec3 inPos;
void main() {
    gl_Position = vec4(inPos, 1);
}
"""

let fragmentShaderSource = """
#version 330 core
out vec4 FragColor;
void main() {
    FragColor = vec4(0.5, 1.0, 0.5, 1.0);
}
"""

let vertices: [GL.Float] = [
    0, 1.0, 0,
    1.0, -1.0, 0,
    -1.0, -1.0, 0
]

func main() {
    SDL_Init(SDL_INIT_VIDEO)
    
    let window = SDL_CreateWindow(
        "Swift SDL2 OpenGL Demo", // title
        Int32(SDL_WINDOWPOS_CENTERED_MASK), // x
        Int32(SDL_WINDOWPOS_CENTERED_MASK), // y
        800, // width
        600, // height
        UInt32(SDL_WINDOW_RESIZABLE.rawValue | SDL_WINDOW_OPENGL.rawValue)) // flags
    
    SDL_GL_SetAttribute(SDL_GL_CONTEXT_MAJOR_VERSION, 3)
    SDL_GL_SetAttribute(SDL_GL_CONTEXT_MINOR_VERSION, 3)
    SDL_GL_SetAttribute(SDL_GL_CONTEXT_PROFILE_MASK, Int32(SDL_GL_CONTEXT_PROFILE_CORE.rawValue))
    let glContext = SDL_GL_CreateContext(window)

    var infoLogLength = GL.Int()
    var infoLog = [GL.Char]()

    let vertexShader = glCreateShader(GL.VERTEX_SHADER)
    withUnsafePointer(to: vertexShaderSource) { glShaderSource(vertexShader, 1, $0, nil) }
    glCompileShader(vertexShader)
    glGetShaderiv(vertexShader, GL.INFO_LOG_LENGTH, &infoLogLength)
    if infoLogLength > 0 {
        infoLog = [GL.Char](repeating: GL.Char(0), count: Int(infoLogLength))
        withUnsafeMutablePointer(to: &infoLog[0]) { glGetShaderInfoLog(vertexShader, infoLogLength, nil, $0) }
        print("Vertex shader info log:", String(cString: infoLog))
    }

    let fragmentShader = glCreateShader(GL.FRAGMENT_SHADER)
    withUnsafePointer(to: fragmentShaderSource) { glShaderSource(fragmentShader, 1, $0, nil) }
    glCompileShader(fragmentShader)
    glGetShaderiv(fragmentShader, GL.INFO_LOG_LENGTH, &infoLogLength)
    if infoLogLength > 0 {
        infoLog = [GL.Char](repeating: GL.Char(0), count: Int(infoLogLength))
        withUnsafeMutablePointer(to: &infoLog[0]) { glGetShaderInfoLog(fragmentShader, infoLogLength, nil, $0) }
        print("Fragment shader info log:", String(cString: infoLog))
    }

    let shaderProgram = glCreateProgram()
    glAttachShader(shaderProgram, vertexShader)
    glAttachShader(shaderProgram, fragmentShader)
    glLinkProgram(shaderProgram)
    glGetProgramiv(shaderProgram, GL.INFO_LOG_LENGTH, &infoLogLength)
    if infoLogLength > 0 {
        infoLog = [GL.Char](repeating: GL.Char(0), count: Int(infoLogLength))
        withUnsafeMutablePointer(to: &infoLog[0]) { glGetProgramInfoLog(shaderProgram, infoLogLength, nil, $0) }
        print("Program info log:", String(cString: infoLog))
    }

    glDeleteShader(vertexShader)
    glDeleteShader(fragmentShader)

    var VAO = GL.UInt()
    glGenVertexArrays(1, &VAO)
    glBindVertexArray(VAO)

    var VBO = GL.UInt()
    glGenBuffers(1, &VBO)
    glBindBuffer(GL.ARRAY_BUFFER, VBO)
    glBufferData(GL.ARRAY_BUFFER, vertices.count * MemoryLayout<GL.Float>.size, vertices, GL.STATIC_DRAW)

    glVertexAttribPointer(0, 3, GL.FLOAT, false, GL.Size(MemoryLayout<GL.Float>.size * 3), nil)
    glEnableVertexAttribArray(0)

    glUseProgram(shaderProgram)


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
        glClear(GL.DEPTH_BUFFER_BIT | GL.COLOR_BUFFER_BIT | GL.STENCIL_BUFFER_BIT)
        glBindVertexArray(VAO)
        glUseProgram(shaderProgram)
        glDrawArrays(GL.TRIANGLES, 0, 3)
        SDL_GL_SwapWindow(window)
    }

    // cleanup before exit
    SDL_DestroyWindow(window)
    SDL_VideoQuit()
    SDL_Quit()
}

do {
    try main()
} catch {
    print("Error: \(error)")
    exit(EXIT_FAILURE)
}