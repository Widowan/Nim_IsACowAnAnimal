import unittest, is_a_cow_an_animal

suite "Animals":
  test "animal dead":
    var satanrabbit = Animal(energy: 666, name: "Satan",
                        alive: true, canEat: @[Carrot])
    expect Dead, FoodMismatch:
      satanrabbit.eat(satanrabbit.slaughter())

  test "animals dead twice":
    var satanrabbit = Animal(energy: 666, name: "Satan",
                        alive: true, canEat: @[Carrot]) 
    expect Dead:
      discard satanrabbit.slaughter()
      discard satanrabbit.slaughter()

  test "eat meat twice":
    var beef = Animal(energy: 666, alive: true).slaughter()
    var satanrabbiteatingmeat = Animal(energy: 666, name: "Satan",
                              alive: true, canEat: @[Meat])
    expect EatenAlready:
      satanrabbiteatingmeat.eat(beef)
      satanrabbiteatingmeat.eat(beef)
      