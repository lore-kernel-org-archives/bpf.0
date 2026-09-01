Received: from mta1.migadu.com (out-53.mta1.migadu.com [95.215.58.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09B0A430CD3
	for <bpf@vger.kernel.org>; Tue,  1 Sep 2026 02:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788230467; cv=none; b=Tv322PQVjpU4+LBTjyD3OcOhoEj3lIJqj+fp1cFWLc9V8VKMG+Ob5HxxDMp5ek8W638aFEJYxKR75Eg/YUZVfVMy69XUQYPcFrdi54C5Kh0P950BNQTKyXyjwI5bsUw0nTs4o4wVpmyfSboYvjos6NdlVyXjDneeT1imkJra5GE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788230467; c=relaxed/simple;
	bh=zGl9k2EKaQ/cypP2a3HZEV5eAmxgn5HG0stOMh5zxuc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AolJ9eJBRJNDNCujF3cTAgPvxNjCqj9gFwgYhDRrpt5TDJoKbzynWkTRXIZHx2pQuzZSpzd/RASb7etjH80X7ty0f5ppzDrmAZNuJscqQQ6iU9TvCfh6hxhbUvua8ZtD7i7SvZYdErkmhzqiSiHOwFw6HdcOiKcZA8Zhwynv/1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=HoiwX54D; arc=none smtp.client-ip=95.215.58.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="HoiwX54D"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=zGl9k2EKaQ/cypP2a3HZEV5eAmxgn5HG0stOMh5zxuc=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788230454; v=1; x=1788835254;
 b=HoiwX54DQrfYZJWKPMKZesULS90u1xJUpAMjWosCmIkwXCMLXkscriPhKHbeTBn2d3fCAXhC
 xmFdJfSo0UhBSd3njfcbaE/MECAdjAgAwp9cn0yH/UNwImWsnrgvq7EzlQGGjqpwDK+Qxyqiukz
 yQTTtetUoJomPe/KOMzrm0j0=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 8df81cf4b717920e;
	Tue, 01 Sep 2026 02:40:54 +0000
X-Mizu-Trace-ID: 8df81cf4b717920e
X-Migadu-Flow: FLOW_OUT
From: Tao Cui <cui.tao@linux.dev>
To: tj@kernel.org,
	void@manifault.com
Cc: arighi@nvidia.com,
	changwoo@igalia.com,
	michalblk@google.com,
	liwanwu@kylinos.cn,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	cui.tao@linux.dev,
	Tao Cui <cuitao@kylinos.cn>
Subject: [PATCH 1/2] sched_ext: fix vtime priority queue inversion on wide vtime spread
Date: Tue,  1 Sep 2026 10:40:37 +0800
Message-ID: <20260901024038.730424-2-cui.tao@linux.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260901024038.730424-1-cui.tao@linux.dev>
References: <20260901024038.730424-1-cui.tao@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tao Cui <cuitao@kylinos.cn>

scx_dsq_priq_less() compares dsq_vtime with time_before64(), a cyclic
comparison that is only valid when the values in the queue are less
than 2^63 apart. Unlike CFS, which enforces that invariant with
min_vruntime clamping, sched_ext takes dsq_vtime directly from the BPF
scheduler and cannot bound the spread. A scheduler that inserts tasks
with vtimes wider than 2^63 apart into one DSQ gets the order inverted:
the tasks it placed last run first and the rest starve. Reproduced with
a probe scheduler assigning half its tasks vtimes near 0 and the other
half vtimes above 2^63 -- four of eight busy tasks monopolized the CPU
while the other four starved.

Compare with plain u64 < instead, which is a total order and always
honors the order the scheduler asked for. The transient misordering
around the natural 2^64 wrap is the same class of anomaly the cyclic
comparison trades it for, but bounded.

Fixes: 06e51be3d5e7 ("sched_ext: Add vtime-ordered priority queue to dispatch_q's")
Signed-off-by: Tao Cui <cuitao@kylinos.cn>
---
 kernel/sched/ext/ext.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index 8041c87a3562..dd0ce01370d1 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -1417,7 +1417,8 @@ static bool scx_dsq_priq_less(struct rb_node *node_a,
 	const struct task_struct *b =
 		container_of(node_b, struct task_struct, scx.dsq_priq);
 
-	return time_before64(a->scx.dsq_vtime, b->scx.dsq_vtime);
+	/* dsq_vtime is arbitrary BPF input: keep a total order */
+	return a->scx.dsq_vtime < b->scx.dsq_vtime;
 }
 
 static void dsq_inc_nr(struct scx_dispatch_q *dsq, struct task_struct *p, u64 enq_flags)
-- 
2.43.0

