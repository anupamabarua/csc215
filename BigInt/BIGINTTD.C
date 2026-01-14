#include "BIGINT.H"
#include "BDSCTEST.H"

main()
{
    struct bigint bi;
    struct bigint bi1;
    struct bigint bi2;
    struct bigint result;

    START_TESTING("BIGINTTD.C");

    TEST_CASE("Read and write bigint 1234567");
        set_bigint("1234567", &bi);
        ASSERT_STR(get_bigint(&bi), "1234567");

    TEST_CASE("add single digit 1+5");
        set_bigint("1", &bi1);
        set_bigint("5", &bi2);
        add_bigints(&bi1, &bi2, &result);
        ASSERT_STR(get_bigint(&result), "6");

    TEST_CASE("add double digit 10+18");
        set_bigint("10", &bi1);
        set_bigint("18", &bi2);
        add_bigints(&bi1, &bi2, &result);
        ASSERT_STR(get_bigint(&result), "28");

    TEST_CASE("add ten digit 3333333333+3333333333");
        set_bigint("3333333333", &bi1);
        set_bigint("3333333333", &bi2);
        add_bigints(&bi1, &bi2, &result);
        ASSERT_STR(get_bigint(&result), "6666666666");

    TEST_CASE("sub: 9 - 4 = 5");
        set_bigint("9", &bi1);
        set_bigint("4", &bi2);
        sub_bigints(&bi1, &bi2, &result);
        ASSERT_STR(get_bigint(&result), "5");


    END_TESTING();
}