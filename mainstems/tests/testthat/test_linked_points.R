test_that("headwater terminals discriminate correctly", {
  load("data/disciminate_outlets.rda")
  lp <- get_lp_points(hu_joiner_sub, hr_net_sub, wbd_sub, wbd_exclusions_sub)
  
  expect_equal(lp$lp[lp$lp$hu12 == "170501030205", ]$lp, 55000700010254)
  expect_equal(lp$na[lp$na$hu12 == "170501030202", ]$lp,   55000700000702)

})