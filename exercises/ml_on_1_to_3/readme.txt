Assignment
==========

Generate train/val/test sets
----------------------------

Generate circles, spheres, and toruses with different random seeds.
Add noise to them. This has already been done for spheres,
but add a and b in (a*cos(x),a*sin(x),b*cos(y),b*sin(y)) close to 1.
Also do something equivalent for circles.

Do topology
-----------

Calculate the distance matrices, and calculate the persistance diagrams (PDs).

Make PDs more ML-friendly
-------------------------

Pixelate PDs. There are different ways to do this: Move points into a grid. Read heat kernel values from a grid. Try to order points considering Wasserstein distances?

Maybe, use heat kernels. Betti curves and Wasserstein distances are other options.
Do we have software for heat kernels? Like HERA for Wasserstein?

Perform ML
----------

Use ConvNet to process pixelated images, but start with a single layer.

The idea is to use a neural network to classify these shapes.
Maybe, this would be easier to do with the things I have in MATLAB.
Could I use a SVM instead?