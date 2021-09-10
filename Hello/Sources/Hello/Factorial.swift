func Factorial(n: Int) -> Int {
	if n <= 1 { return n }
	return n*Factorial(n: n - 1)
}

let number = 4
print("\(number)! is equal to \(Factorial(n: number))")