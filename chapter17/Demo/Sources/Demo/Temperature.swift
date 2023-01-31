public struct Temperature: Equatable {
    public var celsius: Double
    
    public var fahrenheit: Double {
        return (9.0/5.0) * celsius + 32.0
    }
    
    public init(celsius: Double) {
        self.celsius = celsius
    }
}
