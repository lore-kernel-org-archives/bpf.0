Received: from mail-oa1-f66.google.com (mail-oa1-f66.google.com [209.85.160.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBDC03F787D
	for <bpf@vger.kernel.org>; Tue, 31 Mar 2026 21:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774991428; cv=none; b=S3avL1TNV3/Mcu48m93z+Dsv7Vefh3nfdhZqxkkpCME9nfFC+5aa/JlWXvVdwyoVr1Gp9+sNi3aWXF6WoFo8J1Vz9MnUiwQ2/QYkaJ2E/qGYdtV8q0gYbg480h1l3ZAo72t3lZelovuHztjPi3RwnQOnBLbkXPRzIl8MK8BIIGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774991428; c=relaxed/simple;
	bh=XuCntg8YxUUan8+4frWWEpkRcJIEkNIzFVoBXtaQBvw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q6/wRR1T2WoqaKHkUp65ZQxQyBgq/CZFPyNVaBAjPNnM2HwQYJEMzOj0PPlP9/n6AUUrO8Dz074gHC2OeB4S0R7sLM8pULGzDJp2XLdkajfXMTfkLL9gGtKRNM4n6n6tGtouNl/Hm8M75u1SVeCH1La6mFtydV/xzIOpmVIINec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UNMzaxhT; arc=none smtp.client-ip=209.85.160.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UNMzaxhT"
Received: by mail-oa1-f66.google.com with SMTP id 586e51a60fabf-40974bf7781so294733fac.0
        for <bpf@vger.kernel.org>; Tue, 31 Mar 2026 14:10:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774991425; x=1775596225; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9Nzim5jrwjGwapqjrIf5YDXmtPC0fqy/mvx9SJYvg5I=;
        b=UNMzaxhTZcaDDqgLbF22AYBgwQVKwM+FwgHzYDGrStQwjN5GBsxJTBMh30jlZ9lcUL
         CVG0bNWgYTFMyU8g4DA6plCDoeidUCnx7E43u/DKyYaqN7xFJDVeNkJHCOkNjzj9DT4I
         mKbLSwu7tJeoAjkPU69g+AwTqdb6MyKqKfMtoyrtnPjfyFmRd7IiNQHVHYJPOmAwlDza
         +nzs1KePjaEiZ9xCScOZTv6wVLJ0YuKf0F2BOBlEfsi/qFuxO+/+issuzWCKOiW8hSS/
         wNCx+jSe8v2sObpSjyyNSWMKn5HQ8mr+jQZ6H+2n+FQ6hhRGPKgqcPEA5bNjOz6zkKEQ
         ++gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774991425; x=1775596225;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9Nzim5jrwjGwapqjrIf5YDXmtPC0fqy/mvx9SJYvg5I=;
        b=acnX6unjLN5R72259kLYpmMvqpJ9ofaB3OBn3XHa81oR1o9dr2ElhFRLfg+uIhuhIJ
         2Na4qfyXssJd4kqWSG0N1iZ5aKA+f4pscpDW94Kfp1cuxRE2lO3tcfyU9ubGUNLW1+uE
         k86JiF4X5QrqQ3ga/GPRoea55ytLcSTviiPDuMC4lqBUhf8uRiKXuELiADQNvMv2PdiQ
         jlzKW/LaOgjSXztid/2wNt/pSWRvjbheCBDbb8stYor8JKQBqL/4EDKI2eWBUqmEshO+
         0gQHp4M6+HCp1P3yQeJv9dk7+4Bt8+PQbJoPGtIy5z2CAs2JZTSUliAuRQXiuPxNsXju
         H+Yg==
X-Gm-Message-State: AOJu0YxOFJ40Q/jUHlI+tCtI6LN7wx2xLMLzqEUTrScFk8J+K53ISFns
	SRGYZta0kSCD8id4+vT4uoLBs5FImnh0cunHtUD6k6YV0ygHc2oYT+vlOSJm55oY
X-Gm-Gg: ATEYQzziYv1K1FJOdKVCboASdqQ4w811pQJFHMT1ARmPfGYpoRJt23TVs1smVyN9tmo
	EP4hdEjliINJ90yGluckSB+EyadH2vLxLyY8ApdgfdEQ2jekN+RAKJ2374Yus1TFG++zJZlG6yJ
	ScqHHN4o2W1KfkrrRR8kdI21xPkqJGHFd/FZBobxzNf9ip8qBCjWH3TOkQMHNHEMzoi0myKQSSM
	SGIqqmfUOK+MDRe3Dj8yXKw1TiYng1O1QuNdXyQcl0sPy4mtsCKjCWwX0IcvfburAnvjO0zDb7K
	gQR+ryDINuezsw6wq1xYur4A3h77SjLfV8nVE+lq8+L0eE99PHBe8vdQt70+1G7aKqdx/FoGHBz
	5BjjljT89INkJy7QERBU8ngKBDm4x9uTumNiMXP+f2GwoENEU1U0IDEGeBSUy66UUNM2s+KJqUs
	A/yGUPn1nlGYRKGcL7PYZxGyY74vLMrFHrFoFkj6mpzY8=
X-Received: by 2002:a05:6870:176f:b0:40a:5870:98bb with SMTP id 586e51a60fabf-422a55c2c37mr3078814fac.21.1774991425215;
        Tue, 31 Mar 2026 14:10:25 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:6::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-41d04c889fesm7293603fac.9.2026.03.31.14.10.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2026 14:10:23 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Sun Jian <sun.jian.kdev@gmail.com>,
	Puranjay Mohan <puranjay@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf v4 1/1] bpf: Fix grace period wait for tracepoint bpf_link
Date: Tue, 31 Mar 2026 23:10:20 +0200
Message-ID: <20260331211021.1632902-2-memxor@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260331211021.1632902-1-memxor@gmail.com>
References: <20260331211021.1632902-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6469; h=from:subject; bh=XuCntg8YxUUan8+4frWWEpkRcJIEkNIzFVoBXtaQBvw=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIfOMBdPtH4J5h7M63b8Wf9p3dmH/nxvhs7Pu6k+wb+z7mJGr xifTUcrCIMbFICumyFLyfx+T8YnK34G2y7hh5rAygQxh4OIUgIk48TD8M9465ezfL1tDv7oVs+jU3D hRza8Us7Bw2sdJ/xR7Zp5dsJrhf13LUwk7T11ea++fIj88m+eVu2UvUT4ulT3nae/5txeXswAA
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
true. Hence we need not chaining any RCU gp after the SRCU gp.

For instance, in the non-faultable raw tracepoint, the RCU read section
of the program in __bpf_trace_run() is enclosed in the SRCU gp, likewise
for faultable raw tracepoint, the program is under the RCU Tasks Trace
protection. Hence, the outermost scope can be waited upon to ensure
correctness.

Also, sleepable programs cannot be attached to non-faultable
tracepoints, so whenever program or link is sleepable, only RCU Tasks
Trace protection is being used for the link and prog.

Fixes: a46023d5616e ("tracing: Guard __DECLARE_TRACE() use of __DO_TRACE_CALL() with SRCU-fast")
Reviewed-by: Sun Jian <sun.jian.kdev@gmail.com>
Reviewed-by: Puranjay Mohan <puranjay@kernel.org>
Acked-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 include/linux/bpf.h        |  4 ++++
 include/linux/tracepoint.h | 20 ++++++++++++++++++++
 kernel/bpf/syscall.c       | 25 +++++++++++++++++++++++--
 3 files changed, 47 insertions(+), 2 deletions(-)

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
index 22ca1c8b54f3..1d7f29f5e901 100644
--- a/include/linux/tracepoint.h
+++ b/include/linux/tracepoint.h
@@ -122,6 +122,22 @@ static inline bool tracepoint_is_faultable(struct tracepoint *tp)
 {
 	return tp->ext && tp->ext->faultable;
 }
+/*
+ * Run RCU callback with the appropriate grace period wait for non-faultable
+ * tracepoints, e.g., those used in atomic context.
+ */
+static inline void call_tracepoint_unregister_atomic(struct rcu_head *rcu, rcu_callback_t func)
+{
+	call_srcu(&tracepoint_srcu, rcu, func);
+}
+/*
+ * Run RCU callback with the appropriate grace period wait for faultable
+ * tracepoints, e.g., those used in syscall context.
+ */
+static inline void call_tracepoint_unregister_syscall(struct rcu_head *rcu, rcu_callback_t func)
+{
+	call_rcu_tasks_trace(rcu, func);
+}
 #else
 static inline void tracepoint_synchronize_unregister(void)
 { }
@@ -129,6 +145,10 @@ static inline bool tracepoint_is_faultable(struct tracepoint *tp)
 {
 	return false;
 }
+static inline void call_tracepoint_unregister_atomic(struct rcu_head *rcu, rcu_callback_t func)
+{  }
+static inline void call_tracepoint_unregister_syscall(struct rcu_head *rcu, rcu_callback_t func)
+{  }
 #endif
 
 #ifdef CONFIG_HAVE_SYSCALL_TRACEPOINTS
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 274039e36465..700938782bed 100644
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
+		/* We need to do a SRCU grace period wait for non-faultable tracepoint BPF links. */
+		else if (bpf_link_is_tracepoint(link))
+			call_tracepoint_unregister_atomic(&link->rcu, bpf_link_defer_dealloc_rcu_gp);
 		else
 			call_rcu(&link->rcu, bpf_link_defer_dealloc_rcu_gp);
 	} else if (ops->dealloc) {
-- 
2.52.0

