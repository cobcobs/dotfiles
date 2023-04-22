use std::io::stdin;

fn read_int() -> usize {
    let mut input = String::new();
    stdin().read_line(&mut input).unwrap();
    return input.trim().parse().unwrap();
}

fn read_vector() -> Vec<usize> {
    let mut input = String::new();
    stdin().read_line(&mut input).unwrap();
    let arr: Vec<usize> = input
        .trim()
        .split_whitespace()
        .map(|x| x.parse().unwrap())
        .collect();
    return arr;
}

fn read_string() -> Vec<char> {
    let mut input = String::new();
    stdin().read_line(&mut input).unwrap();
    let vec: Vec<char> = input.trim().chars().collect();
    return vec;
}

fn to_string(vec: Vec<char>) -> String {
    return vec.iter().collect::<String>();
}

fn solve() {
    
}

fn main() {
    let has_multiple_cases = false;

    if has_multiple_cases {
        let t = read_int();
        for _ in 0..t {
            solve();
        }
    } else {
        solve();
    }
}
