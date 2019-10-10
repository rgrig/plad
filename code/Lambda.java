interface Env {
  Term get(String id);
  void del(String id);
  void add(String id, Term t);
}

interface Term {
  Term eval(Env env);
  Term subst(Env env);
}

class Var implements Term {
  String id;
  Var(String id) {this.id = id;}
  @Override public Term eval(Env env) { return subst(env); }
  @Override public Term subst(Env env) {
    Term r = env.get(id);
    return r == null? this : r;
  }
}

class Abs implements Term {
  String vname;
  Term body;
  Abs(String vname, Term body) {
    this.vname = vname;
    this.body = body;
  }
  @Override public Term eval(Env env) { return subst(env); }
  @Override public Term subst(Env env) {
    Term old = env.get(vname);
    if (old != null) env.del(vname);
    Term result = new Abs(vname, body.subst(env));
    if (old != null) env.add(vname, old);
    return result;
  }
}

class App implements Term {
  Term t1, t2;
  App(Term t1, Term t2) { this.t1 = t1; this.t2 = t2; }
  @Override public Term eval(Env env) {
    Term t1e = t1.eval(env);
    Term t2e = t2.eval(env);
    if (t1e instanceof Abs) {
      Term old = env.get(t1e.vname);
      //if (old != null) env.del(t1e.vname);
      env.add(t1e.vname, t2e);
      Term result = t1e.body.eval(env);
      if (old != null) {
        env.add(t1e.vname, old);
      } else {
        env.del(t1e.vname);
      }
      return result;
    } else {
      return new App(t1e, t2e);
    }
  }

  @Override public Term subst(Env env) {
    return null;
  }
}

public class Lambda {
}
