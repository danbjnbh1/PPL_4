//Q1
export function all<T>(promises: Array<Promise<T>>): Promise<Array<T>> {
  return new Promise<T[]>((resolve, reject) => {
    if (!promises.length) {
      resolve([]);
      return;
    }
    const result: T[] = new Array(promises.length);
    let completedCount = 0;

    promises.forEach((promise, index) => {
      promise
        .then((value) => {
          result[index] = value;
          completedCount++;

          // Only resolve when all promises have completed
          if (completedCount === promises.length) {
            resolve(result);
          }
        })
        .catch((error) => {
          reject(error);
        });
    });
  });
}

// Q2
export function* Fib1() {
  let num1 = 1;
  let num2 = 1;
  yield num1;
  yield num2;
  while (true) {
    const next = num1 + num2;
    num1 = num2;
    num2 = next;
    yield next;
  }
}

export function* Fib2() {
  const C1 = (1 + Math.sqrt(5)) / 2;
  const C2 = (1 - Math.sqrt(5)) / 2;
  let n = 1;
  while (true) {
    yield Math.round((C1 ** n - C2 ** n) / Math.sqrt(5));
    n++;
  }
}

const equalTrees = (tree1: any, tree2: any, succ: any, fail: any): any => {
  if (!tree1.length && !tree2.length) {
    return succ([]);
  }

  if (!(tree1.length && tree2.length)){
    return fail([tree1, tree2])
  }

  if (!Array.isArray(tree1[0]) && !Array.isArray(tree2[0])) {
    return equalTrees(
      tree1.slice(1),
      tree2.slice(1),
      (res: any[][]) => succ([[tree1[0] || [], tree2[0] || []], ...res]),
      fail
    );
  }
  if (Array.isArray(tree1[0]) && Array.isArray(tree2[0])) {
    return equalTrees(
      tree1[0],
      tree2[0],
      (res_curr: any) =>
        equalTrees(
          tree1.slice(1),
          tree2.slice(1),
          (res_next: any) => succ([res_curr, ...res_next]),
          fail
        ),
      fail
    );
  }

  return fail([tree1[0], tree2[0]]);
};

const id = (x: any) => x;

console.log(equalTrees([1, [2], [3, 9]], [7, [2], [3, 5]], id, id));

console.log(equalTrees([1, [2], [3, 9]], [1, [2], [3, 9]], id, id));


console.log(equalTrees([1, 2, [3, 9]], [1, [2], [3, 9]], id, id));

console.log(equalTrees([1, 2, [3, 9]], [1, [3, 4]], id, id));

console.log(equalTrees([1, 2, 3], [1, 2], id, id));

console.log(equalTrees([1, 2, 3], [], id, id));

console.log(equalTrees([], [1], id, id));

console.log(equalTrees([1, [2, 3]], [1, [2]], id, id));

console.log(equalTrees([1, [2, 3]], [4, 5, 6], id, id));

