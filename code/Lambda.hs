
import Data.List
import Data.Maybe

type Id = String

data Term = Var Id | Abs Id Term | App Term Term deriving Show

env_empty = []
env_lookup ((y, t) : env') x  = if x == y then t else env_lookup env' x
env_lookup [] x = Var x
env_add env x t = (x, t) : env
env_del env x = filter (\(y,_) -> x /= y) env

subst env (Var x) = env_lookup env x
subst env (Abs x t) = Abs x (subst (env_del env x) t)
subst env (App t1 t2) = App (subst env t1) (subst env t2)

eval env (App t1 t2) = reduce env (eval env t1) (eval env t2)
eval env t = subst env t

reduce env (Abs x t1) t2 = eval (env_add env x t2) t1
reduce env t1 t2 = App t1 t2

test1 = App (Abs "x" (App (Var "x") (Var "x"))) (Var "y")
test2 = App (App (Abs "x" (Abs "y" (Var "x"))) (Var "a")) (Var "b")
test3 = App (App (Abs "x" (Abs "y" (Var "y"))) (Var "a")) (Var "b")
test4 = App (Abs "x" (Abs "w" (Var "x"))) (Var "w")

main = do
  putStrLn $ show (eval [] test1)
  putStrLn $ show (eval [] test2)
  putStrLn $ show (eval [] test3)
  putStrLn $ show (eval [] test4) -- FIXME: this fails; the result should be not the identity function but a constant function returning "w"
