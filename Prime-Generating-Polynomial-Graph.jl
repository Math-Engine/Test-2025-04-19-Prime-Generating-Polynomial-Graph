using Plots
using Base64
using Polynomials

param_n = parse(Int, ARGS[1])

function is_prime(n::Int)
  if n <= 1
      return false
  elseif n <= 3
      return true
  end
  if n % 2 == 0 || n % 3 == 0
      return false
  end
  i = 5
  while i * i <= n
      if n % i == 0 || n % (i + 2) == 0
          return false
      end
      i = i + 6
  end
  return true
end

if (param_n < 2)
  println("중간고사 5일 남음")
end

Prime_Array = []

prime = 2
while (prime <= param_n)
  # local Prime_Array
  # local prime
  if (is_prime(prime) == true)
    push!(Prime_Array, prime)
  end
  prime = prime + 1
end

Prime_Generating_Polynomial = fromroots(Prime_Array)

x_min = minimum(Prime_Array) - 1
x_max = maximum(Prime_Array) + 1
xs = range(x_min, x_max, length=500)
ys = Prime_Generating_Polynomial.(xs)

plt = plot(xs, ys;
    xlabel = "x-(primes)",
    ylabel = "Prime_Generating_Polynomial",
    title = "Prime-Generating-Polynomial Function",
    legend = false,
    grid = true,
    linewidth = 2,
    linecolor = :blue
)


buf = IOBuffer()
png(plt, buf)
seek(buf, 0)
bin = take!(buf)
b64 = base64encode(bin)
data_uri = "data:image/png;base64,$b64"
println(data_uri)
