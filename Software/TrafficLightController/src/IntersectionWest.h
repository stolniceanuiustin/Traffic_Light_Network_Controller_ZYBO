#ifndef INTERSECTION_WEST_H
#define INTERSECTION_WEST_H
#include "IntersectionGraph.h"

enum TLWEST_LaneIDs {
    W_P0P1P2_Downstream_1 = 0,
    W_P0P1P2_Downstream_2 = 1,
    W_P0_UPSTREAM_3 = 2,
    W_P0_UPSTREAM_2 = 3,
    W_P0_UPSTREAM_1 = 4,
    E5_1 = 5,
    E5_2 = 6,
    S_P2_UPSTREAM_4 = 7,
    S_P2_UPSTREAM_3 = 8,
    S_P2_UPSTREAM_2 = 9,
    S_P2_UPSTREAM_1 = 10, 
    W_P0P2_Downstream_E_P0P1_Upstream_1 = 11,
    W_P0P2_Downstream_E_P0P1_Upstream_2 = 12,
    W_P0P2_Downstream_E_P0P1_Upstream_3 = 13,
    W_P0P1_Upstream_E_P0P2_Downstream_3 = 14,
    W_P0P1_Upstream_E_P0P2_Downstream_2 = 15,
    W_P0P1_Upstream_E_P0P2_Downstream_1 = 16
};
extern Intersection tl_west;

void init_tl_west(Intersection* intr);

#endif