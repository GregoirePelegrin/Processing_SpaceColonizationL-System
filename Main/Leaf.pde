class Leaf{
    PVector position;
    boolean reached;

    Leaf(PVector _position){
        this.position = _position.copy();
        this.reached = false;
    }

    void show(){
        stroke(255);
        point(this.position.x, this.position.y);
    }
}