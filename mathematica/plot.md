# [How to plot a matrix with 3d style ](https://mathematica.stackexchange.com/questions/144443/how-to-plot-a-matrix-with-3d-style)

```mathematica
list = {{3, 0, 8, 4}, {2, 4, 5, 7}, {9, 2, 6, 3}, {0, 3, 1, 0}}
ListPlot3D[list, InterpolationOrder -> 0, ColorFunction -> Hue, 
 Mesh -> None, Filling -> Axis]
```

 
