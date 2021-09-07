int maxDist;
int minDist;
Tree tree;

void setup(){
    size(600, 600);
    frameRate(30);
    background(51);

    maxDist = 100;
    minDist = 10;
    tree = new Tree();
}

void draw(){
    background(51);
    tree.grow();
    tree.show();
}