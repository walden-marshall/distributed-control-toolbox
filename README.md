# Structured Realizations of SLS Controllers

Our objective is to create state-space realizations of SLS distributed state feedback controllers.

There are multiple space state models of a given linear-time-invariant (LTI) system. When the LTI system is a controller consisting of spatially distributed sub-controller units, it is necessary to find a realization that can be implemented on a network with some desired communication structure. This code base moves from structured System-Level-Synthesis (SLS) matrices $\Phi^u$ and $\Phi^x$ to a controller realization with the same structure.

The `structuredControllerRealization.m` function performs this task. The script `/demos/usage_demo.mlx` explains how to use this function.

The underlying algorithm for `structuredControllerRealization.m` consists of several intermediate steps, contained in `/intermediate functions/`. The script `/demos/ring_graph_demo.mlx` explains these steps for the "Consensus of First Order Subsystems" problem of [Jensen and Bamieh, 2022](https://arxiv.org/pdf/2012.04792).

The script `/demos/dam_example.mlx` generates the optimal SLS state feedback controller for a system of three river dams presented in [Rantzer, 2019](https://arxiv.org/pdf/1812.07748).

The `/other functions/` folder contains several auxiliary functions used for concise presentation in the demos.

## Files

* `structuredControllerRealization.m`
- `/demos/`
    - `usage_demo.mlx`
    - `ring_graph_example.mlx`
    - `dam_example.mlx'`
- `/intermediate functions`
    - `structuredRlztn.m`
    - `idxSet.m`
    - `unstructuredK.m`
    - `permutationT.m`
    - `structureK.m`
- `/other functions/`
    - `pltBlkSpsty.m`
    - `pltBlkSpstyRlztn.m`
    - `ltiEquiv.m`
    - `sym2tf.m`
