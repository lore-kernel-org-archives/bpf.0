Received: from mail-ot1-f68.google.com (mail-ot1-f68.google.com [209.85.210.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 652803009D6
	for <bpf@vger.kernel.org>; Tue, 31 Mar 2026 00:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774918342; cv=none; b=g53I2921/j/ZSEVGApz8Oe5E29GA4QnDHLDKFLIQHGAe7m+0Kd3z3/QJKa/rcGmtoUfGeGWSxOq5640ncxvvdAOhLhogNrKCYAqsTbTglvtSzEW1f29yjLi0nzFD+0rPIDYGNNfF6A20OlDGMGT//mMKbvZEL9DxHsBIALfm7bM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774918342; c=relaxed/simple;
	bh=Ohrwh34MGlH3MkKieYTRWSxzQYEGgYusw3aquqHvEq8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TiwDb2YafCR26p0UnhKurQaHBJCvc4oBKBbRxJBo8oW7gEDelzxeGB6q7IBgkrKgzqUH1gJeDyVJ2QzvSpQ1EtDXdHevzt2JAuvukfk2XWr+BM3nRrGNKIJkGKAG3NdKi6eGsKR/Xj7e2Ps13hDRX9to47RVod691qRK5/seucU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sKoFbIxy; arc=none smtp.client-ip=209.85.210.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sKoFbIxy"
Received: by mail-ot1-f68.google.com with SMTP id 46e09a7af769-7d4c12ff3d5so4961384a34.2
        for <bpf@vger.kernel.org>; Mon, 30 Mar 2026 17:52:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774918340; x=1775523140; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HFdcCAzhEcnJnJdNxq3wgs+bDQsCJXUyvgcw/xpax8c=;
        b=sKoFbIxyq5AF5cGOlfdyguX9ZTS1mUGe8vqKY8ZAkKs5cAg6pA/Dzm2aXA3V8SRtNf
         XcWlX7tw/ViKvFTd2H7l/l7AB4rfNZ5jz0K+IcTEUJt6uzq9CZyuB6BZqUclr41/Ob+k
         0t9xr4qYtHfGiLIlJO7hp/Q2x+2RwH880jHBEKpEYIIVkR0VhjWd4SrIPu2fKc/3M2HT
         0hvV0tLWktKPGzUCeKQUTwqlb+y/NImrKWCOVhtD/8VNRWkplbSixVW9PhXTnmt+KO5v
         gPwQ0/ZfzKdIOpUgMy9fBj+XmHtx4gbZRZy1kQJXEycNHx2wbrU+yYXK/djxIhLE3ACc
         Y71Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774918340; x=1775523140;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HFdcCAzhEcnJnJdNxq3wgs+bDQsCJXUyvgcw/xpax8c=;
        b=bmD8sk8CtzpDQKyu+GI65z6tK1yV8blrKHGzIxkmbZRGCbKIAtBoW2251sQY+Td4F0
         DDfvGAU2l7Y0k+QFc7O7YMsJKwIXJxoCmbZygsFR+a9PvI8EK4RM/uPBfi2507MOpzw4
         Eki7QbzUnheJuP+v2tHsgi7dhgR8LXk/DAr+8eXNOPv2i616FnH07OC00C8655uLjyrS
         9NPEGl4RijmmKrvJaYvot6v+NMdQdix2Wi4BNLIDxvgcpVURNv1RvmzRF6scCZ/7k/Un
         d4GDRb+q6qoIu7Wh3cq85KYgL7cAyYUZgPOR4q7CR2JdVQAn/LNv4DhNH/CG934Gw/hq
         YaeA==
X-Gm-Message-State: AOJu0YxeY6nowC3HzvKCwY06A+Lnp+LQCIWdr8YywNWnX/llRiMmtYS9
	Q9aCCpFyOQqWW9BE2pZ1TOpiVFtdBKKLt4aAf0fJ75tgWz/uWvw92AZyy+g1f+fpAr0=
X-Gm-Gg: ATEYQzx5qtcIBpR6fS+eOvSIiZquXh3xvQLS7ZkS14OBpeW35Vxs6/y7XQ3rMYK9Blh
	yfnog1OnJDzqAxfeBV/zTKv+BpergfPphIqdwHmzvGTJDxE46C7noPNXrtabUfUfWyTrKxz9dks
	u33SYAH/De+AbU3PomXwkDSz2BE/QPev8bUsvNu+szXwgBIb6YHPfvErzVxWLY6EXY8z+9GeeUP
	KoKkQ0BmFHdezV53MFB3QPjy3K9V8apcURHOw6g3XP0EQgsA+SooZQZichDvA4+rhvJk7esm2sy
	GFls/Ed1SREKJJLOpiV6/6qtmQZFNV8+kUqFe/bs+N+Sg21ISIgWLG7ZsKVaHSLYpxezhB5mgdx
	OD3L6lvi9FajvJijUIA6SwDcl9EX15LcUPPX4N5hznnKScZsAbZjgx3o8tJWqq9ZV9flAikBBuM
	QQKh8NCkb/pYVjOsW3cFKCHrBTku5tkuF0UG/PxU2TtSWW3jSwL6oXcw==
X-Received: by 2002:a05:6830:6604:b0:7d7:fbe5:e9b3 with SMTP id 46e09a7af769-7d9fad72441mr8024831a34.3.1774918339860;
        Mon, 30 Mar 2026 17:52:19 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:3::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7da0a7edb42sm7253806a34.20.2026.03.30.17.52.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 17:52:19 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Puranjay Mohan <puranjay@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf v3 1/1] bpf: Fix grace period wait for tracepoint bpf_link
Date: Tue, 31 Mar 2026 02:52:14 +0200
Message-ID: <20260331005215.2813492-2-memxor@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260331005215.2813492-1-memxor@gmail.com>
References: <20260331005215.2813492-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5720; h=from:subject; bh=Ohrwh34MGlH3MkKieYTRWSxzQYEGgYusw3aquqHvEq8=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIfO0lNo2/Z29hyWLPlhdOxZReeYFg+jvDsbYqAmnORmlfPy/ WSzrKGVhEONikBVTZCn5v4/J+ETl70DbZdwwc1iZQIYwcHEKwEQMdRgZ1i7s8g0yZQp4dVHiCqPYek eDGaf/dW5foC657GDzgmqxWEaGSfVvr4YyLfyRZ7Dwx4tHzK93LRO6Hfs3k83456V1SzQXcwAA
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

Recently, tracepoints were switched from using disabled preemption
(which acts as RCU read section) to SRCU-fast when they are not
faultable. This means that to do a proper grace period wait for programs
running in such tracepoints, we must use SRCU's grace period wait.
This is only for non-faultable tracepoints, faultable ones continue
using RCU Tasks Trace.

However, bpf_link_free() currently does call_rcu() for all cases when
the link is non-sleepable (hence, for tracepoints, non-faultable). Fix
this by doing a call_srcu() grace period wait.

As far RCU Tasks Trace gp -> RCU gp chaining is concerned, it is deemed
unnecessary for tracepoint programs. The link and program are either
accessed under RCU Tasks Trace protection, or SRCU-fast protection now.

The earlier logic of chaining both RCU Tasks Trace and RCU gp waits was
to generalize the logic, even if it conceded an extra RCU gp wait,
however that is unnecessary for tracepoints even before this change.
In practice no cost was paid since rcu_trace_implies_rcu_gp() was always
true. Hence we need not chaing any RCU gp after the SRCU gp.

For instance, in the non-faultable raw tracepoint, the RCU read section
of the program in __bpf_trace_run() is enclosed in the SRCU gp, likewise
for faultable raw tracepoint, the program is under the RCU Tasks Trace
protection. Hence, the outermost scope can be waited upon to ensure
correctness.

Fixes: a46023d5616e ("tracing: Guard __DECLARE_TRACE() use of __DO_TRACE_CALL() with SRCU-fast")
Reviewed-by: Puranjay Mohan <puranjay@kernel.org>
Acked-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 include/linux/bpf.h        |  4 ++++
 include/linux/tracepoint.h |  8 ++++++++
 kernel/bpf/syscall.c       | 25 +++++++++++++++++++++++--
 3 files changed, 35 insertions(+), 2 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 05b34a6355b0..35b1e25bd104 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1854,6 +1854,10 @@ struct bpf_link_ops {
 	 * target hook is sleepable, we'll go through tasks trace RCU GP and
 	 * then "classic" RCU GP; this need for chaining tasks trace and
 	 * classic RCU GPs is designated by setting bpf_link->sleepable flag
+	 *
+	 * For non-sleepable tracepoint links we go through SRCU gp instead,
+	 * since RCU is not used in that case. Sleepable tracepoints still
+	 * follow the scheme above.
 	 */
 	void (*dealloc_deferred)(struct bpf_link *link);
 	int (*detach)(struct bpf_link *link);
diff --git a/include/linux/tracepoint.h b/include/linux/tracepoint.h
index 22ca1c8b54f3..8d6df1e7b5da 100644
--- a/include/linux/tracepoint.h
+++ b/include/linux/tracepoint.h
@@ -122,6 +122,11 @@ static inline bool tracepoint_is_faultable(struct tracepoint *tp)
 {
 	return tp->ext && tp->ext->faultable;
 }
+static inline void call_tracepoint_unregister_non_faultable(struct rcu_head *rcu,
+							    rcu_callback_t func)
+{
+	call_srcu(&tracepoint_srcu, rcu, func);
+}
 #else
 static inline void tracepoint_synchronize_unregister(void)
 { }
@@ -129,6 +134,9 @@ static inline bool tracepoint_is_faultable(struct tracepoint *tp)
 {
 	return false;
 }
+static inline void call_tracepoint_unregister_non_faultable(struct rcu_head *rcu,
+							    rcu_callback_t func)
+{  }
 #endif
 
 #ifdef CONFIG_HAVE_SYSCALL_TRACEPOINTS
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 274039e36465..96c3beebbf89 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -3261,6 +3261,18 @@ static void bpf_link_defer_dealloc_rcu_gp(struct rcu_head *rcu)
 	bpf_link_dealloc(link);
 }
 
+static bool bpf_link_is_tracepoint(struct bpf_link *link)
+{
+	/*
+	 * Only these combinations support a tracepoint bpf_link.
+	 * BPF_LINK_TYPE_TRACING raw_tp progs are hardcoded to use
+	 * bpf_raw_tp_link_lops and thus dealloc_deferred(), see
+	 * bpf_raw_tp_link_attach().
+	 */
+	return link->type == BPF_LINK_TYPE_RAW_TRACEPOINT ||
+	       (link->type == BPF_LINK_TYPE_TRACING && link->attach_type == BPF_TRACE_RAW_TP);
+}
+
 static void bpf_link_defer_dealloc_mult_rcu_gp(struct rcu_head *rcu)
 {
 	if (rcu_trace_implies_rcu_gp())
@@ -3279,16 +3291,25 @@ static void bpf_link_free(struct bpf_link *link)
 	if (link->prog)
 		ops->release(link);
 	if (ops->dealloc_deferred) {
-		/* Schedule BPF link deallocation, which will only then
+		/*
+		 * Schedule BPF link deallocation, which will only then
 		 * trigger putting BPF program refcount.
 		 * If underlying BPF program is sleepable or BPF link's target
 		 * attach hookpoint is sleepable or otherwise requires RCU GPs
 		 * to ensure link and its underlying BPF program is not
 		 * reachable anymore, we need to first wait for RCU tasks
-		 * trace sync, and then go through "classic" RCU grace period
+		 * trace sync, and then go through "classic" RCU grace period.
+		 *
+		 * For tracepoint BPF links, we need to go through SRCU grace
+		 * period wait instead when non-faultable tracepoint is used. We
+		 * don't need to chain SRCU grace period waits, however, for the
+		 * faultable case, since it exclusively uses RCU Tasks Trace.
 		 */
 		if (link->sleepable || (link->prog && link->prog->sleepable))
 			call_rcu_tasks_trace(&link->rcu, bpf_link_defer_dealloc_mult_rcu_gp);
+		/* We need to do a SRCU grace period wait for tracepoint-based BPF links. */
+		else if (bpf_link_is_tracepoint(link))
+			call_tracepoint_unregister_non_faultable(&link->rcu, bpf_link_defer_dealloc_rcu_gp);
 		else
 			call_rcu(&link->rcu, bpf_link_defer_dealloc_rcu_gp);
 	} else if (ops->dealloc) {
-- 
2.52.0

