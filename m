Received: from mail-oi1-f195.google.com (mail-oi1-f195.google.com [209.85.167.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 527D028468E
	for <bpf@vger.kernel.org>; Mon, 30 Mar 2026 14:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774881071; cv=none; b=U2lDzLiTacUVPUmN0Jf43pQtoPXhqdA/omyScloJtvhez310q4DyGc6UWBUjV0Hlt8MZjeCHSm7oIkugzW0MiyOGVpqYxTjqkZhpkvVm+GhwqMqcq9SCjpUuxoWk89sLnw8yS89gINM1w7YWxGRBWQTkMvfmJDOi0FSIUpiajt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774881071; c=relaxed/simple;
	bh=S330uuhwqGR6c5L5uynn8F321smj9Os3CMV8MGJyjV0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SuI+9ygmK2G/f1/aloxTPeLfHAs6pPawaq2cunGS+HKQABeUj8uzAlu7r6KtMxzMVLiWd/JWjEPehbEO2+CGCsGzxKsaephYBbSrrqfYvP7dq2mf+8WPVHoRSAtDjfcpZvT+d08/pYYBcm1bmCtitrmXnQ2dlAS9TS8hY2SjbPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QXc02aq+; arc=none smtp.client-ip=209.85.167.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QXc02aq+"
Received: by mail-oi1-f195.google.com with SMTP id 5614622812f47-466f1c3c627so2799427b6e.1
        for <bpf@vger.kernel.org>; Mon, 30 Mar 2026 07:31:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774881068; x=1775485868; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QIthRuOCwUQCxSqROdpcKtPB2dqjpNiztiyzPT+rVxo=;
        b=QXc02aq+vKNavfJeBSxWszVuji7aLPcl12+2Zhz9YJX9uiEDbzX7R42MjFgTWlbMmn
         T9PTFPJsb1/9U5EIuJqGuCwL/5w0u/BgrITS3t6ZRYg/h1R4wsqYh15cpDVg3unbL9wO
         W8MoeEwurGoqWlM1C66Cik7E8UqvWqX5dHkzYSH/ZYPN+R0kvQ3nY932AZGz34R4PNuC
         aZeaG6pS2Cj42UWP76vrMTqM73/Ou7e4Lzbe4gi6QUSykAHDn1Ej53P/hyUxOPtlVdsU
         YqbIDqioA45I/ga3zM8uzbYfcrHF0kOTSYx5UikG/PDF9ImA1pLbRHSPPcOE814cQr+l
         iSrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774881068; x=1775485868;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QIthRuOCwUQCxSqROdpcKtPB2dqjpNiztiyzPT+rVxo=;
        b=OvcKPL6Y621X1yhRC973TcMK0bVZosKRF/yB29PeHNeJZe/hGwjSnJLRs5ojTkLt2q
         bEvlERaisQN/8Vl7rRAsSFqeLBmJvm8a+34hRuXXVP0nIL0NG3jFM9e4LtM30+aoN8vm
         MmsRDomvBSBrA3sKPjujXwqE6HLNFTAN4Tx1xqaR41JcEVEdLGrAxQV5aE3eCl5MeeZO
         bHmB1GIpaCrxaN2AsY6YXNTVfSiEdr4knZpF9KAgI+QE5A6/z3Y5B9n3/csKFs9vlPMh
         vLwfNiygVjjMNHy0UtcSm8my5eM0ypf+wWkbvCL4NSgJe0hXSR8oJZKph3H2cIdNEhIw
         3z+w==
X-Gm-Message-State: AOJu0YxmzVwHJLRodEQHyM0WOZQJD0ZYogJirLe0eEkG1YrHmM73poC3
	6h9bNBhEoIhEKWgUW4JHa0VuAuvNVrcaawQPDPzdXbTGn67ELqatQqdkCrqGm2TeYgc=
X-Gm-Gg: ATEYQzy5d68iN3+e/1yASKa5WzbhInvqXxGtCLdDLjO78bPLlBJ1PiXhlbJnIZWozA/
	5aZYfya1ZiTmAbTEf6yLEOfDf2Yf+QHxlRM5uoC2W43wZV/JO9+qg/64ZTCC47Rp+eHHaQvFSZj
	rCSGn7gbdaJFgLz21N6nkVB9KOLPFNKzydAiliUEJZyCmaPKxjO4LxBbK4s8a7vDxOSCqnIcIie
	F/5TDB/OvadMp5musPjG09Dt/ySZtL+2uz2ryKr7j8rDGF7KmNCKSQvdtF8zsNW55XqILXhkYzo
	yywj9SpwoEsKFiqptM0jes4k9TpBu07qex9bbpvpfLCplvBj9bZXSDK4WlS4y47sPDPp2dwUB+J
	rOqnqi1KvsTq8sFppntD2Xbsj6bnUlC6A+DR/kapOtqLjB1xtUiYUVo/zTV/J+gC6OZ+weoaiea
	0x7dgeQg7lNeseyajz6P0WZDLYCz4CMDaKyO54csyDW7QH
X-Received: by 2002:a05:6808:199b:b0:467:f36d:a08a with SMTP id 5614622812f47-46a8a426d69mr5687580b6e.5.1774881067552;
        Mon, 30 Mar 2026 07:31:07 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:58::])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-46aa03d1d8asm4969750b6e.16.2026.03.30.07.31.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 07:31:06 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Puranjay Mohan <puranjay@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf v2 1/2] bpf: Fix grace period wait for tracepoint bpf_link
Date: Mon, 30 Mar 2026 16:31:01 +0200
Message-ID: <20260330143102.1265391-2-memxor@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260330143102.1265391-1-memxor@gmail.com>
References: <20260330143102.1265391-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5006; h=from:subject; bh=S330uuhwqGR6c5L5uynn8F321smj9Os3CMV8MGJyjV0=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIfNUx07eXfyPhE9eMvvB9zFl7/bv1/NXaJZmv9oR6JS7d0OK H+eKjlIWBjEuBlkxRZaS//uYjE9U/g60XcYNM4eVCWQIAxenAExEU57hf1DGwxtNUQ8OBu28ploUv/ Wxiova1oPnUm1e35q2R1dm/0RGhlkrvTdu3JaqJecgJH7lot3Zz7NlqzQNee/vsxPZLOrYyQEA
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
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 include/linux/tracepoint.h |  8 ++++++++
 kernel/bpf/syscall.c       | 26 ++++++++++++++++++++++++--
 2 files changed, 32 insertions(+), 2 deletions(-)

diff --git a/include/linux/tracepoint.h b/include/linux/tracepoint.h
index 22ca1c8b54f3..8227102a771f 100644
--- a/include/linux/tracepoint.h
+++ b/include/linux/tracepoint.h
@@ -113,6 +113,10 @@ void for_each_tracepoint_in_module(struct module *mod,
  */
 #ifdef CONFIG_TRACEPOINTS
 extern struct srcu_struct tracepoint_srcu;
+static inline struct srcu_struct *tracepoint_srcu_ptr(void)
+{
+	return &tracepoint_srcu;
+}
 static inline void tracepoint_synchronize_unregister(void)
 {
 	synchronize_rcu_tasks_trace();
@@ -123,6 +127,10 @@ static inline bool tracepoint_is_faultable(struct tracepoint *tp)
 	return tp->ext && tp->ext->faultable;
 }
 #else
+static inline struct srcu_struct *tracepoint_srcu_ptr(void)
+{
+	return NULL;
+}
 static inline void tracepoint_synchronize_unregister(void)
 { }
 static inline bool tracepoint_is_faultable(struct tracepoint *tp)
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 274039e36465..89fa8f00adfa 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -3261,6 +3261,17 @@ static void bpf_link_defer_dealloc_rcu_gp(struct rcu_head *rcu)
 	bpf_link_dealloc(link);
 }
 
+static bool bpf_link_is_tracepoint(struct bpf_link *link)
+{
+	/*
+	 * Only these combinations support a tracepoint bpf_link.
+	 * BPF_LINK_TYPE_TRACING raw_tp progs are hardcoded to use
+	 * bpf_raw_tp_link_lops, see bpf_raw_tp_link_attach().
+	 */
+	return link->type == BPF_LINK_TYPE_RAW_TRACEPOINT ||
+	       (link->type == BPF_LINK_TYPE_TRACING && link->attach_type == BPF_TRACE_RAW_TP);
+}
+
 static void bpf_link_defer_dealloc_mult_rcu_gp(struct rcu_head *rcu)
 {
 	if (rcu_trace_implies_rcu_gp())
@@ -3279,16 +3290,27 @@ static void bpf_link_free(struct bpf_link *link)
 	if (link->prog)
 		ops->release(link);
 	if (ops->dealloc_deferred) {
-		/* Schedule BPF link deallocation, which will only then
+		struct srcu_struct *tp_srcu = tracepoint_srcu_ptr();
+
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
+		else if (bpf_link_is_tracepoint(link) && tp_srcu)
+			call_srcu(tp_srcu, &link->rcu, bpf_link_defer_dealloc_rcu_gp);
 		else
 			call_rcu(&link->rcu, bpf_link_defer_dealloc_rcu_gp);
 	} else if (ops->dealloc) {
-- 
2.52.0

