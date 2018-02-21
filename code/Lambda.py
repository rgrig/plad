#!/usr/bin/env python3

from types import SimpleNamespace

class Term(SimpleNamespace):
  pass

class Var(Term):
  def __init__(self, vname):
    self.name = vname

  def eval(self, context):
    return self.substitute(context)

  def substitute(self, context):
    return context[self.name] if self.name in context else self

class Abs(Term):
  def __init__(self, vname, term):
    self.vname = vname
    self.term = term

  def eval(self, context):
    return self.substitute(context)

  def substitute(self, context):
    old = None
    if self.vname in context:
      old = context[self.vname]
      del context[self.vname]
    result = Abs(self.vname, self.term.substitute(context))
    if old is not None:
      context[self.vname] = old
    return result

class App(Term):
  def __init__(self, term1, term2):
    self.term1 = term1
    self.term2 = term2

  def eval(self, context):
    term1 = self.term1.eval(context)
    term2 = self.term2.eval(context)
    if type(term1) == Abs:
      old = None
      if term1.vname in context:
        old = context[term1.vname]
      context[term1.vname] = term2
      result = term1.term.eval(context)
      if old is not None:
        context[term1.vname] = old
      else:
        del context[term1.vname]
      return result
    else:
      return App(term1, term2)

  def substitute(self, context):
    return App(self.term1.substitute(context), self.term2.substitute(context))

def main():
  tests = \
      [ App(Abs('x', App(Var('x'), Var('x'))), Var('y'))
      , App(App(Abs('x',Abs('y',Var('x'))), Var('a')), Var('b'))
      , App(App(Abs('x',Abs('y',Var('y'))), Var('a')), Var('b')) ]
  for t in tests:
    print('before',t)
    print('after',t.eval({}))
    print('---')

if __name__ == '__main__':
  main()
