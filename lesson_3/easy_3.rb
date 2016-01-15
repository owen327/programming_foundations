1) flintstones = %w(Fred Barney Wilma Betty BamBam Pebbles)
2) flintstones << "Dino"
3) flintstones.insert(5, "Dino", "Hoppy")
flintstones.push("Dino").push("Hoppy")
flintstones.concat(%w(Dino Hoppy))
4) advice.slice!(0, advice.index('house'))
slice leabes original string intact
5) statement.count("t")
statement.scan('t').count
6) title.center(40)
