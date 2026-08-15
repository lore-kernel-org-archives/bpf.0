Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FCFD1A8F84;
	Sat, 15 Aug 2026 05:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786772991; cv=none; b=MVmvS7S6lNMDIXliuL6eUDnzZ9+bT+n0GxsCBqQg7hqNXGiAdSrHbcfe3+DIohuX5yHs+hSqMN9kApZ4xrACQwSQrSLYVEvDUgjdLEPckvgXEPjKrPLbhx8gUDrG7Pw8IvlWt6rSayhf6B515PKAL9U1JJesf7e5JBbkwsJvf6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786772991; c=relaxed/simple;
	bh=J1MWVH5RK6vRxskSFDUNgT3J6ij+8tdqEFWRcMcQUl8=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=OlDb4JNPkACCxQJ+bLw+fwEIHmbgihorebNLhP1zg4RDyBnt50xw5yX2pkiedmfHcUhY0zwG0n5tpkA+rJkXD2PZe3AHrNAe8uxEfVifubyX7ry8NAvjdSIbaj5i2fJEXfNBae9KP2nQAjIbz5YND3zGBAFestKGuSWxRnxXAOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MvsQutVn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MvsQutVn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7D141F000E9;
	Sat, 15 Aug 2026 05:49:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786772990;
	bh=+1yiqvF0jmLUMR5aBc8lvPbI5lc1bhriYyFQTvXczFw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=MvsQutVn7WiYX9OV3Du44I68dS+1yZfkYOe5rtyo+iBtBXMYlePf0qwk7PU+o7FRt
	 qSgqV/q2B6cnJ0rvsFsCbo8ynn6V5TBj7DR0bEYPaunRXZEn/BAqntxvGxvhprhDAH
	 TmVWFKF67wcZCqM8MrizuPjWe0DMD2+3lIQ7G6g8/0LwyKC1mO4sA2vuGV0kSIXfW5
	 e6YobQt2B3iV5uyO57pXes6AbL8Rt/RZpzTYNj2wV7dBvbtJUvjDqA0SPI63YFkpop
	 roSjwjcl65BXAWChMry2NOC4GYf3y/QN46B4MRStndbrmvm44j7C8Bf1q1rWDqFFR+
	 K+zztmdif7w0A==
Date: Fri, 14 Aug 2026 19:49:49 -1000
Message-ID: <964c74253ebb44beb12b5e981616df8c@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Tao Cui <cui.tao@linux.dev>
Cc: cuitao@kylinos.cn, void@manifault.com, arighi@nvidia.com,
 changwoo@igalia.com, mingo@redhat.com, peterz@infradead.org,
 sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org
Subject: Re: [PATCH v2] sched_ext: Don't BUG_ON a destroyed DSQ in
 process_deferred_reenq_users
In-Reply-To: <20260815022017.3305427-1-cui.tao@linux.dev>
References: <20260815022017.3305427-1-cui.tao@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Hello,

Applied the following to sched_ext/for-7.3. Thanks.

-- 8< --
From: Tao Cui <cuitao@kylinos.cn>
Date: Sat, 15 Aug 2026 10:20:17 +0800
Subject: [PATCH] sched_ext: Don't BUG_ON a destroyed DSQ in
 process_deferred_reenq_users

scx_bpf_dsq_reenq() queues a deferred reenq (dru) that runs from
run_deferred(), not ops.dispatch(). If the DSQ is destroyed before the dru
runs, process_deferred_reenq_users() sees dsq->id == SCX_DSQ_INVALID and
hits the BUG_ON. destroy_dsq() doesn't flush pending drus, so just skip.

tj: Read dsq->id once with READ_ONCE(). Reading it separately in the INVALID
    check and the BUG_ON would leave a window where destroy_dsq() can
    invalidate the id between the two reads and still trigger the BUG_ON.

Fixes: 84b1a0ea0b7c ("sched_ext: Implement scx_bpf_dsq_reenq() for user DSQs")
Cc: stable@vger.kernel.org # v7.1+
Signed-off-by: Tao Cui <cuitao@kylinos.cn>
Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext/ext.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index b9060c318c3c..7620ebf02790 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -4613,7 +4613,7 @@ static void process_deferred_reenq_users(struct rq *rq)
 
 	while (true) {
 		struct scx_dispatch_q *dsq;
-		u64 reenq_flags;
+		u64 dsq_id, reenq_flags;
 
 		scoped_guard (raw_spinlock, &rq->scx.deferred_reenq_lock) {
 			struct scx_deferred_reenq_user *dru =
@@ -4636,7 +4636,12 @@ static void process_deferred_reenq_users(struct rq *rq)
 		/* see schedule_dsq_reenq() */
 		smp_mb();
 
-		BUG_ON(dsq->id & SCX_DSQ_FLAG_BUILTIN);
+		/* destroy_dsq() may have raced and invalidated @dsq, nothing to reenq */
+		dsq_id = READ_ONCE(dsq->id);
+		if (unlikely(dsq_id == SCX_DSQ_INVALID))
+			continue;
+
+		BUG_ON(dsq_id & SCX_DSQ_FLAG_BUILTIN);
 		reenq_user(rq, dsq, reenq_flags);
 	}
 }
-- 
2.55.0

