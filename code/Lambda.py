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
    if type(self.term1) == Abs:
      new_term2 = self.term2.eval(context)
      old = None
      if self.term1.vname in context:
        old = context[self.term1.vname]
      context[self.term1.vname] = new_term2
      result = self.term1.term.eval(context)
      if old is not None:
        context[self.term1.vname] = old
      else:
        del context[self.term1.vname]
      return result
    else:
      return self.substitute(context)

  def substitute(self, context):
    return App(self.term1.substitute(context), self.term2.substitute(context))

def main():
  t = App(Abs('x', App(Var('x'), Var('x'))), Var('y'))
  print('before',t)
  print('after',t.eval({}))

if __name__ == '__main__':
  main()
