# Goliath Currency Changer

This project is the result of a technical test.

## Set up 🚀

The project uses CocoaPods to manage its dependencies. Therefore, once downloaded you will have to execute the following command in the project folder:

```
pod install
```


### Decisions made 📋

The project has been built under two assumptions:
* Although it is a small project, it has been developed as if it will be extended to be much larger.
* Although there has been only one developer, it has been considered that in the future several people could work on the project at the same time.

During the development of the project the following design decisions have been made based on these assumptions:
* The architecture has been separated into different modules. The reason is that doing so reduces build times and more clearly separates the responsibilities of each layer. In addition, the architecture is designed so that each module has independent tests, manages its own dependencies and has access only to the layers that it must according to the [dependency rule](https://blog.cleancoder.com/uncle-bob/2012/08/13/the-clean-architecture.html).
* It has been decided that the View should have an interface and this interface should be the only one known to the Presenter. Although there are people who defend that the Presenter can know the view, it has been considered that creating an interface is not a disadvantage and allows to add a separation between the Presenter and the UIKit.
* For navigation it has been decided to use Coordinators, for several reasons: it eliminates that responsibility of the Presenter and other components, it avoids dependencies between Views and, having used dependency inversion, it also avoids dependencies between the Presenter and the Coordinator.
* It has been decided to use .Xibs instead of .Storyboards. The reason is that, with a large team working on the project, this system allows several people to work on different parts of the user interface at the same time. On the contrary, if .Storyboards had been used, it would most likely cause conflicts in the version management system.
* It has been decided to separate the constants by layers, one file in each module. The reason is that the same constants are most likely to be used several times within a module and not known outside. Still, if needed, a constants file would have been created in the common module of the project.
* It has been decided to create a common module. Although in general the code of each layer is radically different, there are small functions and helpers that can be reused throughout the project, and the easiest way to avoid repeating code is to share it all between modules.
* It has been decided to create an interface to abstract the Logger. The reason for this is that it made possible to replace one logger by another, such as the system logger by the Firebase logger, without having to replace the individual code of each log (which will be in all the layers of the project).
* It has been decided to calculate conversions once per application session. The reason was that, without having more information, it was considered that the currency changes are too volatile to store them between sessions, but it was not deemed necessary to calculate them each time. If needed, the application code can easily be varied to recalculate them with each access to a product.
* It has been decided to use Decimal as the class for storing money-related values, since Float and Double introduce inaccuracies in the way they are stored.

### Pending issues 🔧
Here are some of the things I would have liked to do if I had had more time:
* I would have used generics in the lists, at least in the first one, so that they could accept different cell types without having to change or expand the code. Thus, if different product types had been accepted later on, the extension of the application would have been simple.
* I would have done UI Testing. In this case, the vast majority of the app relies on data obtained from the internet and I haven't had time to create Mocks to replace that data and be able to create a fixed environment in which to test.
* I would have done more unit tests, specifically on the data layer and perhaps also on the Presenter.
* I would have created some integration test to test how several components work at the same time, specifically in the part of calculating the total transaction value of a product.
* I would have made the calculation of each possible currency conversion more optimal, perhaps by applying Dijkstra's shortest path algorithm.
