Received: from out-175.mta1.migadu.com (out-175.mta1.migadu.com [95.215.58.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83B0940B397
	for <bpf@vger.kernel.org>; Tue, 11 Aug 2026 08:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786435219; cv=none; b=ljI8/h23xU8CEhW2iNqkrE8rtAW5KrxXrmV8wKcI1RXCL/nMtACGMnO4Ej+cC/0GFcftUTA4xovq1srOu/0w296SD1AzSdle7Vd5BuPtkB5zBZCgRPcQJRD3qLx569F+QpycAIXA2Fn7nVYxh+MiNmykRv+d/4L6Kp/+fca7zzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786435219; c=relaxed/simple;
	bh=O2wK6TNJCUQ27oS5RMJ+n4uSWvaBZEstDq3wqjsYBGM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TuGAgjstX5vF0wouZcUjdqcS/PGrIelV4XsL2s/w/T55UmOKUZFSwH4jzYImunBZkxf+xoQkRBTWXmy3qbGcvJjwH7w2NpcwbIu124/ipoXHS2Qz2q30wvK9RqRIWFc7t5idWvZUoYtNVemtkuW7H8TJztv95hNjgF0h1cipEnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=lo/W+TYP; arc=none smtp.client-ip=95.215.58.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="lo/W+TYP"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1786435205;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=lqGW+YYQquEv1JA4YJdG3wyj6xCfkvvGSCfJkPKsEs4=;
	b=lo/W+TYPaIWH84nxdibI8bKQAU0eTZv2Z5LmobRWSUv//LYrCXQpboWHl1MWivunmrbQEO
	raho6ejgw9PtVBaoCl01YBiMMHaJXJc5aGwv4jQI2/Nc8fpvpCt0rrKuwu2yXV4hFka9GR
	MXR01lrmQ4jWDa7T7MQX8ODaEshEVAo=
From: Tao Cui <cui.tao@linux.dev>
To: tj@kernel.org
Cc: void@manifault.com,
	arighi@nvidia.com,
	changwoo@igalia.com,
	mingo@redhat.com,
	peterz@infradead.org,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	cui.tao@linux.dev,
	Tao Cui <cuitao@kylinos.cn>
Subject: [PATCH] sched_ext: don't BUG_ON a destroyed DSQ in process_deferred_reenq_users
Date: Tue, 11 Aug 2026 15:59:12 +0800
Message-ID: <20260811075913.344033-1-cui.tao@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Tao Cui <cuitao@kylinos.cn>

scx_bpf_dsq_reenq() queues a deferred reenq (dru) that runs from
run_deferred(), not ops.dispatch(). If the DSQ is destroyed before the dru
runs, process_deferred_reenq_users() sees dsq->id == SCX_DSQ_INVALID and
hits the BUG_ON. destroy_dsq() doesn't flush pending drus, so just skip.

Fixes: 84b1a0ea0b7c ("sched_ext: Implement scx_bpf_dsq_reenq() for user DSQs")

Signed-off-by: Tao Cui <cuitao@kylinos.cn>
---
 kernel/sched/ext/ext.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index 0bbe144c9811..604a05da41b9 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -4531,7 +4531,9 @@ static void process_deferred_reenq_users(struct rq *rq)
 		/* see schedule_dsq_reenq() */
 		smp_mb();
 
-		BUG_ON(dsq->id & SCX_DSQ_FLAG_BUILTIN);
+		/* destroy_dsq() may race and invalidate @dsq; skip */
+		if (unlikely(dsq->id & SCX_DSQ_FLAG_BUILTIN))
+			continue;
 		reenq_user(rq, dsq, reenq_flags);
 	}
 }
-- 
2.43.0

