Received: from mta1.migadu.com (out-104.mta1.migadu.com [95.215.58.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D22FA47CC97
	for <bpf@vger.kernel.org>; Tue,  1 Sep 2026 14:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788271459; cv=none; b=usYl/wKYbgt+1uY9FTEFCiehCz6wb5/28RslDmtbf5VwYS55lnwSREIOKW7uqMe2xo/JY8WYXiwt8jGvOlGBJHFKbDqJt5mZo7+eu0Bf8Hi9Uhp6LnwUnkLKxSS7ND42LqBSOXsCccN+jBc27TZWNkq7W8z3sTLWIMWbQm2tqQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788271459; c=relaxed/simple;
	bh=+g8JFj6bSuPhOwWMaBi1S77p3N0JoJc+KMCCgtIXAqg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FI1+A9fnXAK3nrcFt16ayvjC38PwHbS+4C+fX6MnKGtNHaw4bgt4bTOmNJbEUEZ3LF0dfGyQlcfxVjJh4lC6PtDHk37kLNISZwaIU8LxLSg+5z8kqEJnrBdwgEWNTxGunqS2i+tK2/Dhfdua+DKdW1IFby9+dCItpB4dn50GsMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Jejn56f6; arc=none smtp.client-ip=95.215.58.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Jejn56f6"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=+g8JFj6bSuPhOwWMaBi1S77p3N0JoJc+KMCCgtIXAqg=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788271455; v=1; x=1788876255;
 b=Jejn56f6ODhMw5MKpSLRDETuBye73VE86kf2xJMUnYcyqPYhIZX1PDL1AA8v7Xbvz0Ux3ash
 Bt+MgC8aAVJwJ+L5SoR6+S08e/I7kKcE83s8cc6MUY8XPLh2NJl8nmbanTgb/8cfbqhphCr5YvQ
 qE0ckFsDWnPjcRZUcSRcmx/I=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 9b7d4af34d70514c;
	Tue, 01 Sep 2026 14:04:15 +0000
X-Mizu-Trace-ID: 9b7d4af34d70514c
X-Migadu-Flow: FLOW_OUT
From: Tao Cui <cui.tao@linux.dev>
To: tj@kernel.org,
	arighi@nvidia.com
Cc: void@manifault.com,
	changwoo@igalia.com,
	michalblk@google.com,
	liwanwu@kylinos.cn,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	cui.tao@linux.dev,
	Tao Cui <cuitao@kylinos.cn>,
	Sashiko <sashiko-bot@kernel.org>
Subject: [PATCH v2 2/2] sched_ext/scx_flatcg: make cgv_node_less() wraparound-safe
Date: Tue,  1 Sep 2026 22:03:43 +0800
Message-ID: <20260901140343.764080-3-cui.tao@linux.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260901140343.764080-1-cui.tao@linux.dev>
References: <20260901140343.764080-1-cui.tao@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tao Cui <cuitao@kylinos.cn>

cgv_node_less() compares cvtimes with a plain <, which breaks once
cvtime wraps. A weight-1 cgroup in a hierarchy summing to 10000
advances cvtime at up to 10000x wall time, so 2^64 ns of cvtime is
weeks of continuous saturation away -- unlikely but reachable on a
long-running host. At the wrap instant the plain comparison puts the
wrapped node behind everything else permanently.

Compare with (s64)(a - b) < 0 instead, as CFS does for vruntime. A
cyclic comparison is valid as an rbtree comparator only because
cgrp_cap_budget() clamps every node to within max_budget behind
cvtime_now, so any two nodes are far less than 2^63 apart and the
cyclic order agrees with the true order.

Compile-tested and smoke-tested in a VM: weight distribution and
dispatch unaffected.

Fixes: 7b742aa2c2c9 ("sched_ext: Add a cgroup scheduler which uses flattened hierarchy")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Link: https://lore.kernel.org/r/3f1ce004-e259-4e72-a5f7-14a5050053bd@linux.dev
Signed-off-by: Tao Cui <cuitao@kylinos.cn>
---
 tools/sched_ext/scx_flatcg.bpf.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/sched_ext/scx_flatcg.bpf.c b/tools/sched_ext/scx_flatcg.bpf.c
index 454ebb820c5e..be03b409db5e 100644
--- a/tools/sched_ext/scx_flatcg.bpf.c
+++ b/tools/sched_ext/scx_flatcg.bpf.c
@@ -144,7 +144,8 @@ static bool cgv_node_less(struct bpf_rb_node *a, const struct bpf_rb_node *b)
 	cgc_a = container_of(a, struct cgv_node, rb_node);
 	cgc_b = container_of(b, struct cgv_node, rb_node);
 
-	return cgc_a->cvtime < cgc_b->cvtime;
+	/* wrap-safe: cap_budget keeps nodes within 2^63 of each other */
+	return (s64)(cgc_a->cvtime - cgc_b->cvtime) < 0;
 }
 
 static struct fcg_cpu_ctx *find_cpu_ctx(void)
-- 
2.43.0

