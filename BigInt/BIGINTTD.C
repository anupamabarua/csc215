#include "BIGINT.H"
#include "BDSCTEST.H"

main() {
    START_TESTING("BIGINTTD.C");

    TEST_CASE("Read and write bigint 1234567") {
        struct bigint bi;
        set_bigint("1234567", &bi);
        ASSERT_STR(get_bigint(bi), "1234567");
    } 

    TEST_CASE("add big int 1+5") {
        struct bigint bi1, bi2, result;
        set_bigint("1", &bi1);
        set_bigint("5", &bi2);
        add_bigints(&bi1, &bi2, &result);
        ASSERT_STR(get_bigint(&result), "6");
    }

    END_TESTING();
}