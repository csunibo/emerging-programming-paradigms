package main

import (
        "fmt"
)

type Perimetrable interface {
        Perimeter() float64
}

func PrintPerimeter(o Perimetrable) {
        fmt.Println(o.Perimeter())
}

type Square struct {
        length float64
}

func (o Square) Perimeter() float64 {
        return o.length*o.length
}

type Rectangle struct {
        width float64
        height float64
}

func (o Rectangle) Perimeter() float64 {
        return o.width*o.height
}

func main() {
        var s = Square{1}
        var r = Rectangle{2,3}
        PrintPerimeter(s)
        PrintPerimeter(r)
}
