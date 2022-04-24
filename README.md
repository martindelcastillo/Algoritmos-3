# Algoritmos-3

## Sobre implementar funcionalidad

Los test no pasaron de una, sino que había que cambiar la implementación test por test hasta que los 3 pasen. Implementar la funcionalidad paso por paso, puede o no ser una buena idea dependiendo de la dificultad el problema, a veces ir paso por paso va a hacer las cosas mucho más simples, otras veces va a hacer todo más complicado si hay que cambiar toda la implementación por una falla nuestra al momento de querer modelar la realidad de manera incorrecta, es por esto que antes de arrancar paso por paso, sería mejor revisar todos los test para tener una idea general de cómo va a funcionar antes de comenzar, tampoco sería recomendable arrancar desde el final ya que podría generar una dificultad extra que no aparecería al hacer paso por paso.


## Sobre código repetido

El código repetido que aparece en nuestro código aparecen en los objetos AvispaOrnella y AvispaOriana, esto ocurre simplemente por ser objetos muy similares, la manera de arreglar esto sería que compartan sus mensajes y métodos, haciendo a una de las avispas hija de la otra. 
Por otro lado, acerca del suficiente alimento a la hora de dejar un huevo, el que guarda la cantidad de recursos y el que revisa si hay suficientes polillas u orugas para dejar un huevo es el hábitat, eso pasa ya que es la implementación que se nos ocurrió en el momento y las más simple aunque no es muy representativa de la realidad, lo que tendria mas sentido sería que los recursos se guarden en el hábitat y los insectos revisen los recursos antes de dejar un huevo en el hábitat.


## Sobre código repetido 2

Con lo visto en la clase del Jueves, utilizaremos la función de que un objeto sea hijo de otro para las Avispas Ornella y Oriana que son objetos muy similares.
Para guardar los huevos con diferente firma genética utilizamos colaboradores que guardan el número de huevos actuales y el número de firmas genéticas. No utilizamos diccionarios u otros métodos porque hacer que un colaborador guarde cada dato nos pareció la manera más simple y sencilla de resolver el problema, el cual funciona.
