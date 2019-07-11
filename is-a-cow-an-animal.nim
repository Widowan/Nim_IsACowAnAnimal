from strutils import spaces

type
    FoodMismatch = object of Exception
    Dead = object of Exception


    Food = ref object of RootObj
        energy: int


    Animal = ref object of RootObj
        energy: int
        name:   string
        alive:  bool
        canEat: seq[Food]


method eat(this: Animal, food: Food): void {.base.} =
    if not (food in this.canEat):
        raise newException(FoodMismatch, "Mismatched food")
    if not this.alive:
        raise newException(Dead, "Animal is dead")
    this.energy += food.energy

method slaughter(this: Animal): Food {.base.} =
    if not this.alive:
        raise newException(Dead, "Animal is dead")
    this.alive = false
    result     = Food(energy: this.energy)

let
    grass  = Food(energy: 5)
    carrot = Food(energy: 10)

var
    rabbit = Animal(energy: 100,  name: "Rabbit", alive: true, canEat: @[carrot])
    cow    = Animal(energy: 1000, name: "Cow",    alive: true, canEat: @[grass])
    human  = Animal(energy: 300,  name: "Hooman", alive: true, canEat: @[carrot])
    ahuman = Animal(energy: 350,  name: "Another Hooman", alive: true, canEat: @[carrot])

for i in [rabbit, cow, human, ahuman]:
    echo i.name, spaces(15-i.name.len), "-> ", i.energy

rabbit.eat(carrot)
cow.eat(grass)

let
    deadRabbit = rabbit.slaughter()
    beef = cow.slaughter()

human.canEat.add(@[beef, deadRabbit])
human.eat(carrot)
human.eat(carrot)
human.eat(beef)

let
    deadHuman = ahuman.slaughter()

human.canEat.add(deadHuman)
human.eat(deadHuman)

assert(human.energy == 1675, "No, it's " & $human.energy)

