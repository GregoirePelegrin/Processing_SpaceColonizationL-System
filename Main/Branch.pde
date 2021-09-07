class Branch{
    int count;
    Branch parent;
    PVector position;
    PVector direction;
    PVector originalDirection;

    Branch(Branch _parent, PVector _position, PVector _direction){
        this.parent = _parent;
        this.position = _position.copy();
        this.direction = _direction.copy();
        this.originalDirection = _direction.copy();

        this.count = 0;
    }

    Branch next(){
        return new Branch(this, this.position.copy().add(this.direction.copy()), this.direction.copy());
    }
    void reset(){
        this.direction = this.originalDirection.copy();
        this.count = 0;
    }
    void show(){
        if(this.parent != null){
            strokeWeight(2);
            stroke(255, 150);
            line(this.position.x, this.position.y, this.parent.position.x, this.parent.position.y);
        }
    }
}