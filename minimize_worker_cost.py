import heapq

class Solution(object):
    def mincostToHireWorkers(self, quality, wage, K):
        from fractions import Fraction
        workers = sorted((Fraction(w, q), q, w)
                         for q, w in zip(quality, wage))
        
        ans = float('inf')
        pool = []
        sumq = 0
        import pdb; pdb.set_trace()
        for ratio, q1, w1 in workers:
            heapq.heappush(pool, -q1)
            sumq += q1
            if len(pool) > K:
                sumq += heapq.heappop(pool)

            if len(pool) == K:
                import pdb; pdb.set_trace()
                ans = min(ans, ratio * sumq)

        return float(ans)

s = Solution()
s.mincostToHireWorkers([10,20,5], [70,50,30], 2)