declare module "purs/Topology" {
    export const allPositions: (instance: unknown) => (ctx: unknown) => Array<number[]>;
    export const mkNowrapSquareGridContext: (xlen: number) => (ylen: number) => {xlen: number, ylen: number};
    export const nowrapSquareTopology: unknown
}