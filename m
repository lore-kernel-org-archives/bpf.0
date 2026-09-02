Received: from mta0.migadu.com (out-213.mta0.migadu.com [91.218.175.213])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE7E22571A0
	for <bpf@vger.kernel.org>; Wed,  2 Sep 2026 02:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.213
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788317319; cv=none; b=Kbe6BxffH3GtqSqvReagF2+PZV1O/vuWe2eWbKj3MI0JnStpHXAyp+Myd/0+F7waHdAvdD8vwNX38n3z2NhsnVHqKqsEzIQwLGQsmfSFHBTy1uCj2Wosqlw0XRYixFei7Oori0FfofN4eXaW+NlTnu1IBZTnm/R+C58rIz48YCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788317319; c=relaxed/simple;
	bh=7s1kUEuoRVkEalRuRbIfe8z8RfYoAvUaeXzHVf0DdbE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aoK59cvhOW/DQwcHuEOqCOFJfhxTzBpRNNw7alD0ofGoXZPNYtETPvnTot06+eqIhU+HNDqTnIqgLWQ33tZUSrPBjfAkvH9WngOCOFAc3nHIl7T6alBfru2VK24JzaCaYBEq4gnO/DRBgkfdPMUKDKwkF6u03hwpoNmbjLLgarE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=esQOwMBT; arc=none smtp.client-ip=91.218.175.213
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="esQOwMBT"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=7s1kUEuoRVkEalRuRbIfe8z8RfYoAvUaeXzHVf0DdbE=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788317315; v=1; x=1788922115;
 b=esQOwMBTh7qjWJGSjnTuwP9bQNyCk25/njVg+vJr+8/yjhIurscV60+KSNJTRsdk3nf8B9z+
 7SrNRVumNCFvF26t3Mhh+faWg8gsJOJyrcyf4zk+uFt3ghri9krz4EhC/T9EAzCRx/1B6Gwe7hY
 knOy6Dn8BvwU2xzzJOoR2to0=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id f1d819361e354e7d;
	Wed, 02 Sep 2026 02:48:35 +0000
X-Mizu-Trace-ID: f1d819361e354e7d
X-Migadu-Flow: FLOW_OUT
From: Tao Cui <cui.tao@linux.dev>
To: tj@kernel.org
Cc: void@manifault.com,
	arighi@nvidia.com,
	changwoo@igalia.com,
	michalblk@google.com,
	liwanwu@kylinos.cn,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	cui.tao@linux.dev,
	Tao Cui <cuitao@kylinos.cn>,
	Sashiko <sashiko-bot@kernel.org>
Subject: [PATCH v3 2/2] sched_ext/scx_flatcg: make cgv_node_less() wraparound-safe
Date: Wed,  2 Sep 2026 10:48:12 +0800
Message-ID: <20260902024812.794879-3-cui.tao@linux.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260902024812.794879-1-cui.tao@linux.dev>
References: <20260902024812.794879-1-cui.tao@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tao Cui <cuitao@kylinos.cn>

cgv_node_less() compares cvtimes with a plain <, which misorders once
cvtime wraps: the wrapped node lands at the front of the tree while
the unwrapped ones get stuck behind it. Each CPU picking a cgroup
charges it a full slice, making wrap occur earlier than a naive
estimate might suggest.

Use time_before() instead. cgrp_cap_budget() bounds the lag behind
cvtime_now, while the lead is bounded by the slice charge plus pending
cvtime_delta on re-insertion, so the cyclic ordering assumptions of
time_before() hold.

Fixes: a4103eacc2ab ("sched_ext: Add a cgroup scheduler which uses flattened hierarchy")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Link: https://lore.kernel.org/r/3f1ce004-e259-4e72-a5f7-14a5050053bd@linux.dev
Signed-off-by: Tao Cui <cuitao@kylinos.cn>
---
 tools/sched_ext/scx_flatcg.bpf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/sched_ext/scx_flatcg.bpf.c b/tools/sched_ext/scx_flatcg.bpf.c
index 454ebb820c5e..5e6abd0bccb3 100644
--- a/tools/sched_ext/scx_flatcg.bpf.c
+++ b/tools/sched_ext/scx_flatcg.bpf.c
@@ -144,7 +144,7 @@ static bool cgv_node_less(struct bpf_rb_node *a, const struct bpf_rb_node *b)
 	cgc_a = container_of(a, struct cgv_node, rb_node);
 	cgc_b = container_of(b, struct cgv_node, rb_node);
 
-	return cgc_a->cvtime < cgc_b->cvtime;
+	return time_before(cgc_a->cvtime, cgc_b->cvtime);
 }
 
 static struct fcg_cpu_ctx *find_cpu_ctx(void)
-- 
2.43.0

