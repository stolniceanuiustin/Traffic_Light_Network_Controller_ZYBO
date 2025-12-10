#include "IntersectionWest.h"
#include "IntersectionGraph.h"

#define IDX(id) get_lane_index_by_id(intr, id)
#define conn(src, tgt)  add_connection(intr, IDX(src), IDX(tgt))

void init_tl_west(Intersection* intr)
{
    intersection_init(intr);
    printf("Configuring TL_WEST\n");
    for(int i=0; i<=16; i++)
    {
        add_lane(intr, i);
    }   

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
    add_phase(intr, p0_conns, 6, 15000);

    int p1_conns[] = {c_4_0, c_16_0, c_15_0, c_14_6};
    add_phase(intr, p1_conns, 4, 15000);
    
    int p2_conns[] = {c_7_1, c_8_2, c_9_13, c_10_11, c_10_12};
    add_phase(intr, p2_conns, 5, 10000);

    int p3_conns[] = {};
    add_phase(intr, p3_conns, 0, 5000);    
}