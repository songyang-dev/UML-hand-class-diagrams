# The hand-written UML class diagram data set
The hand-written class diagram data set comes from Song Yang, who is a master's student in computer science.

Inspirations include the [yuml examples page](https://yuml.me/diagram/scruffy/class/samples).

## Description
The train-test-validation split is 60-20-20. The data comes in pairs: `.txt` in English and class diagrams in [yuml](https://github.com/jaime-olivares/yuml-diagram/wiki) in `.yuml`. yUML is a textual representation of UML diagrams, e.g. the LaTex of UML.

### Sample: train/inheritance_person
The text is written in English.
> An employee is a person. A customer is a person.

There is the associated `.yuml`.
``` 
[Person]^-[Employee]
[Person]^-[Customer]
```

To visualize the `.yuml` files, you need the yuml command-line tool on [GitHub](https://github.com/wandernauta/yuml). After installing, you can simply call the `render.sh` script.

```bash
./render.sh train/inheritance_person.yml # generates last_render.png
```
![Example](uml_person.png)

> Note: Internet connection is required to generate pictures with yUML.