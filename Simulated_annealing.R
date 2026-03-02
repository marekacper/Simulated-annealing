simulated_annealing <- function(f, x0, d, t0, a, K = 100) {
    start_time <- Sys.time()
  n <- length(x0)
  
  results <- list(
    x_opt = x0,
    f_opt = f(x0),
    x_hist = matrix(NA, nrow = K, ncol = n),
    f_hist = rep(NA, K),
    A_k = rep(NA, K),
    t_k = rep(NA, K),
    t_eval = NA
  )
  
  results$x_hist[1, ] <- x0
  results$f_hist[1] <- f(x0)
  results$A_k[1] <- 1
  results$t_k[1] <- t0
  
  x <- x0
  t_k <- t0
  

  for (k in 2:K) {
    

    x_c <- x + runif(n, min = -d, max = d)
    
    f_old <- f(x)
    f_new <- f(x_c)
    

    A_k <- min(1, exp(-(f_new - f_old) / t_k))
    
    if (runif(1) < A_k) {
      x <- x_c      
      f_curr <- f_new
      
      if (f_curr < results$f_opt) {
        results$x_opt <- x
        results$f_opt <- f_curr
      }
    } else {
      f_curr <- f_old 
    }
    
    results$x_hist[k, ] <- x
    results$f_hist[k] <- f_curr
    results$A_k[k] <- A_k
    results$t_k[k] <- t_k
    

    t_k <- t_k * a
  }
  

  results$t_eval <- Sys.time() - start_time
  
  return(results)
}



funkcja_testowa <- function(x) { sum(x^2) }


wynik <- simulated_annealing(f = funkcja_testowa, x0 = c(10), d = 1, t0 = 10, a = 0.95, K = 500)

cat("Znaleziony punkt minimum:", wynik$x_opt, "\n")
cat("Wartość funkcji w tym punkcie:", wynik$f_opt, "\n")

plot(wynik$f_hist, type="l", col="blue", main="Jak algorytm schodził do minimum", ylab="Wartość funkcji", xlab="Krok")



# Schaffer function
schaffer_n2 <- function(x) {
  x1 <- x[1]
  x2 <- x[2]
  numerator <- (sin(x1^2 - x2^2))^2 - 0.5
  denominator <- (1 + 0.001 * (x1^2 + x2^2))^2
  return(0.5 + numerator / denominator)
}

wynik_schaffer <- simulated_annealing(
  f = schaffer_n2, 
  x0 = c(3.5, 3.5),
  d = 1.0, 
  t0 = 50, 
  a = 0.95, 
  K = 2000
)


grid_range <- seq(-5, 5, length.out = 100)
z_grid <- outer(grid_range, grid_range, Vectorize(function(a, b) schaffer_n2(c(a, b))))

moje_kolory <- colorRampPalette(c("#ffffff", "#d0d1e6", "#74a9cf", "#0570b0", "#023858"))(100)

image(grid_range, grid_range, z_grid, 
      col = moje_kolory, 
      xlab = "x1", ylab = "x2", 
      main = "Optymalizacja funkcji Schaffera (Symulowane Wyżarzanie)")

contour(grid_range, grid_range, z_grid, add = TRUE, nlevels = 15, col = "gray40", lwd = 0.8)

lines(wynik_schaffer$x_hist[,1], wynik_schaffer$x_hist[,2], 
      col = "magenta", lwd = 2) # lwd=2 pogrubia linię

points(wynik_schaffer$x_hist[1,1], wynik_schaffer$x_hist[1,2], 
       pch = 19, col = "chartreuse3", cex = 2)
text(wynik_schaffer$x_hist[1,1], wynik_schaffer$x_hist[1,2], 
     "START", pos = 3, col = "black", font = 2)

points(wynik_schaffer$x_opt[1], wynik_schaffer$x_opt[2], 
       pch = 13, col = "red", cex = 2, lwd = 3)

legend("topleft", 
       legend = c("Ścieżka", "Start", "Optimum"), 
       col = c("magenta", "chartreuse3", "red"), 
       lwd = c(2, NA, NA), pch = c(NA, 19, 13), 
       bg = "white", box.col = "gray")