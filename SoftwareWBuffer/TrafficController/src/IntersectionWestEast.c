#include "IntersectionWest.h"
#include "IntersectionGraph.h"
#include "IntersectionEast.h"


#define IDX(id) get_lane_index_by_id(intr, id)
#define conn(src, tgt)  add_connection(intr, IDX(src), IDX(tgt))

void init_tl_west(Intersection* intr)
{
    intersection_init(intr);
    // printf("Configuring TL_WEST\n");
    for(int i=0; i<=16; i++)
    {
        add_lane(intr, i);
    }   
    //  Two fictive lanes for pedestrians
    add_lane(intr, 17);
    add_lane(intr, 18);

    //PHASE 0
    int c_2_0 = add_connection(intr, IDX(2), IDX(13));
    int c_2_1 = add_connection(intr, IDX(2), IDX(12));
    int c_3_0 = add_connection(intr, IDX(3), IDX(11));
    int c_4_0 = add_connection(intr, IDX(4), IDX(5));
    int c_16_0 = conn(16, 0);
    int c_15_0 = conn(15, 0);

    //Phase 1
    int c_14_6 = conn(14, 6);

    //phase 2 
    int c_7_1 = conn(7, 1);
    int c_8_2 = conn(8, 2);
    int c_9_13 = conn(9, 13);
    int c_10_11 = conn(10, 11);
    int c_10_12 = conn(10, 12);

    int p0_conns[] = {c_2_0, c_2_1, c_3_0, c_4_0, c_16_0, c_15_0};
    add_phase(intr, p0_conns, 6, 5000);

    int p1_conns[] = {c_4_0, c_16_0, c_15_0, c_14_6};
    add_phase(intr, p1_conns, 4, 5000);
    
    int p2_conns[] = {c_7_1, c_8_2, c_9_13, c_10_11, c_10_12};
    add_phase(intr, p2_conns, 5, 5000);

    int c_17_18 = conn(17, 18);
    int p3_conns[] = {c_17_18};
    add_phase(intr, p3_conns, 1, 5000);    
}

void init_tl_east(Intersection* intr)
{
    intersection_init(intr);
    for(int i=0; i<=15; i++){
        add_lane(intr, i);
    }
    add_lane(intr, 16);
    add_lane(intr, 17);

    //phase 0
    int c_10_13 = conn(10, 13);
    int c_11_12 = conn(11, 12);
    int c_15_0 = conn(15, 0);
    int c_15_6 = conn(15, 6);
    int c_14_7 = conn(14, 7);
    int c_14_8 = conn(14, 8);

    //phase 1 
    int c_9_1 = conn(9, 1);

    //phase 2
    int c_5_6 = conn(5, 6);
    int c_5_7 = conn(5, 7);
    int c_4_8 = conn(4, 8);
    int c_3_12 = conn(3, 12);
    int c_2_13 = conn(2, 13);

    int p0_conns[] = {c_10_13, c_11_12, c_15_0, c_15_6, c_14_7, c_14_8};
    add_phase(intr, p0_conns, 6, 5000);

    int p1_conns[] = {c_9_1, c_10_13, c_11_12};
    add_phase(intr, p1_conns, 3, 5000);
    
    int p2_conns[] = {c_5_6, c_5_7, c_4_8, c_3_12, c_2_13};
    add_phase(intr, p2_conns, 5, 5000);

    int c_16_17 = conn(16, 17);
    int p3_conns[] = {c_16_17};
    add_phase(intr, p3_conns, 1, 5000);    
}