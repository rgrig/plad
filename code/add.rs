use std::io;
use std::io::Read;

#[derive(Debug)]
enum Error {
    Io(io::Error),
    Pie(std::num::ParseIntError),
    Eof(),
}

impl From<io::Error> for Error {
    fn from(e: io::Error) -> Self { Error::Io(e) }
}
impl From<std::num::ParseIntError> for Error {
    fn from(e: std::num::ParseIntError) -> Self { Error::Pie(e) }
}

fn main() -> Result<(),Error> {
    let mut input = String::new();
    io::stdin().read_to_string(&mut input)?;
    let mut iter = input.split_whitespace();
    let a = iter.next().ok_or(Error::Eof())?;
    let b = iter.next().ok_or(Error::Eof())?;
    let a : i64 = a.parse()?;
    let b : i64 = b.parse()?;
    println!("{}", a+b);
    Ok(())
}
