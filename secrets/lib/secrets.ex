defmodule Secrets do
  def secret_add(secret) do
    fn add_param ->
      secret + add_param
    end
  end

  def secret_subtract(secret) do
    fn subt_param ->
      subt_param - secret
    end
  end

  def secret_multiply(secret) do
    fn mult_param ->
      mult_param * secret
    end
  end

  def secret_divide(secret) do
    fn div_param ->
      div(div_param, secret)
    end
  end

  def secret_and(secret) do
    fn and_param ->
      Bitwise.band(secret, and_param)
    end
  end

  def secret_xor(secret) do
    fn xor_param ->
      Bitwise.bxor(secret, xor_param)
    end
  end

  def secret_combine(secret_function1, secret_function2) do
    fn comb_param ->
      res = secret_function1.(comb_param)
      secret_function2.(res)
    end
  end
end
