# Oh, Danny

## Target Difficulty: Medium (300 Points)

## Description

When using AES in CBC mode, Danny has a habit of leaving messages in his initialization vectors. Can you find his secret message?

Flag Format:
Wrap the IV in bronco{ }

```text
key = 73757065725f6b65795f73747265616d
pt1 = 4163636f7264696e6720746f20616c6c
pt2 = 206b6e6f776e206c617773206f662061
ct2 = 817ed4df4521cc2d6e746c45a834aa2d
```

# Flag
bronco{d0nt_l3@k_ur_k3y}