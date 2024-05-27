class Array2D extends Array {
    __new(x, y) {
        this.Length := x * y
        this.Width := x
        this.Height := y
    }
    __Item[x, y] {
        get => super.Has(this.i[x, y]) ? super[this.i[x, y]] : false
        set => super[this.i[x, y]] := value
    }
    i[x, y] => this.Width * (y - 1) + x
}