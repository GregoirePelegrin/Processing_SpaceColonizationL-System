class Tree{
    ArrayList<Branch> branches;
    ArrayList<Leaf> leaves;
    Branch root;

    Tree(){
        PVector pos = new PVector(width/2, height);
        PVector dir = new PVector(0, -1);
        this.root = new Branch(null, pos, dir);

        this.branches = new ArrayList<Branch>();
        this.leaves = new ArrayList<Leaf>();

        this.branches.add(this.root);
        for(int i=0; i<1000; i++){
            // float y = random(random(0, height/4), height/2);
            // float latitude = map(y, 0, height/2, 0, width/2);
            // float x = random(width/2-latitude, width/2+latitude);
            float x = random(0, width);
            float y = random(0, 4*height/5);
            this.leaves.add(new Leaf(new PVector(x, y)));
        }

        Branch current = this.root;
        boolean found = false;
        while(!found){
            for(Leaf leaf : this.leaves){
                float distance = current.position.dist(leaf.position);
                if(distance < maxDist) found = true;
            }
            if(!found){
                Branch branch = current.next();
                this.branches.add(branch);
                current = branch;
            }
        }
    }

    void grow(){
        for(Leaf leaf : this.leaves){
            Branch closestBranch = null;
            for(Branch branch : this.branches){
                float distance = leaf.position.dist(branch.position);
                if(distance > maxDist) continue;
                else if(distance < minDist){
                    leaf.reached = true;
                    closestBranch = null;
                    break;
                } else if(closestBranch == null || distance < leaf.position.dist(closestBranch.position)){
                    closestBranch = branch;
                }
            }
            if(closestBranch != null){
                PVector direction = leaf.position.copy().sub(closestBranch.position);
                direction.normalize();
                closestBranch.direction.add(direction);
                closestBranch.count++;
            }
        }
        for(int i=this.leaves.size()-1; i>=0; i--){
            if(this.leaves.get(i).reached) this.leaves.remove(i);
        }
        int length = this.branches.size();
        for(int i=length-1; i>=0; i--){
            Branch branch = this.branches.get(i);
            if(branch.count > 0){
                branch.direction.normalize();
                PVector newPosition = branch.position.copy().add(branch.direction.copy());
                Branch newBranch = new Branch(branch, newPosition, branch.direction.copy());
                this.branches.add(newBranch);
            }
            branch.reset();
        }
    }
    void show(){
        for(Leaf leaf : this.leaves) leaf.show();
        for(Branch branch : this.branches) branch.show();
    }
}