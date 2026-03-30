Received: from mail-oi1-f194.google.com (mail-oi1-f194.google.com [209.85.167.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1B5640DFB4
	for <bpf@vger.kernel.org>; Mon, 30 Mar 2026 03:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774840892; cv=none; b=u7jC+FS+HaClQKcece1nqFeMY2N+WjEJtbo4uaKAZztS/OuqqNWJZbcmzVPy2ZSE4NZYEtxc7ceTfFsjBAtSl7PRp94TvS/IBKWOMyPDHbdw3pHSf4VgLnNhaA4hOPDJdjZiZORHN3G/SreXwegI7Jqr2kaCrDqlHnPrIjYI/pI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774840892; c=relaxed/simple;
	bh=wWlz4+6NPJTVf4ZN53WxQ4EMXINCj/zcMltd23+PbEI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dTNcZU5PQmqkOjJFRWh5D4RLJq/35WH7FJBc/hx9oLZzgqDx185IYVoKVtmaHS1QpbZ6rVdFht2SHVN0HUDiZkPLYdyuE6Vx5qC5jKmWEOYt3dpN1BXLhd48W74RExc3YW6N6MiGKyjIromMUcjX4CSKSN7+cq8yT0BuN84uC8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ISW9G3DI; arc=none smtp.client-ip=209.85.167.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ISW9G3DI"
Received: by mail-oi1-f194.google.com with SMTP id 5614622812f47-46726528f1cso2568069b6e.0
        for <bpf@vger.kernel.org>; Sun, 29 Mar 2026 20:21:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774840889; x=1775445689; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=teba9RGAuhttQaHWRoZeN5u0JdvS0rfQ2vp1AlWhP/8=;
        b=ISW9G3DIXGLWeJ2PMqIwfT66QyYqAMIL2TBLXQrM6+BRHJR3cS0m4+l5b0pwXHGdyb
         3bAO5mtap5ZXMLAjB+nUapzdAE5Ft5NUcwvi14OWXvEzHESxXc0EbgJOVnmyiA4S75ch
         72ha+R3dqAr63xdV2gWLzHVj/98QchBr0BOITukDEg2jTFoUyWg1pT9vbZMxhYnA1wS/
         h9OmUAkdDSafABYBoo4NBdOKzdA/mMVb6Ngr3neOnFLkMs3NzlKe0viJNwghhKGyzoST
         EVQnzKMeTAS0twdRb+GvRWhM0XwHL2ArQFsAjulc6caTu5t4FKzfNhUdXgCo3/vwBI+s
         vn7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774840889; x=1775445689;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=teba9RGAuhttQaHWRoZeN5u0JdvS0rfQ2vp1AlWhP/8=;
        b=hK6jflsdXiycDPZXF0gN+10xttOOcLwElWtw+k+XVrvyKKUxQRZVXY9rtFQPeAJZea
         61ZVlzVWhsCiLY6z/sh4XvZDUxRRJn42dI+Dh0anO3okXI/mlasv/I5ZI709aGsIjtx4
         N88dNWgtMY8CQW1BQmP3Ax3ZY7WbyaXNszMATya1CWl2YJlwqNktWAGcCxji6DOFaRs5
         Hxl9MlVnH8a+pAQvKiIsSAKhTpFDeLh5DKanZIS+tXLJBrEVI11uZmQqWJeqIVaDsO+k
         bTAaNvDt8lS7A+VBui80cGj0hhVeZ3KoPQHY7x1rG04E6Ykk+9L7kqQeIUBdkf3tZMIw
         jgrA==
X-Gm-Message-State: AOJu0YyOt4FTsGTZMVpXIXASVPDuNxRzG9B6SbXIEY01mPI//sDYK8gK
	Q+RGxtRhJ0X0ug3ix9n85BAsrQj8zuoAvG0ZtpgVKEYXOwOCY67D0Zi3rNXazYtfexU=
X-Gm-Gg: ATEYQzwplTvhdUn3NdqeHvVckM9huhLG8Webwb8m4Vpwyiy/Dli70+3/CuvLHwBDX7z
	NFVb5Ekk2eybyxsOzMhHmS08ipV/zz85PBcQReIdyhDIqSHt0/sfom1UyX65OqMvtDa/D+VkZFw
	wB3tiaU2ZOLQXYm8yhraR4cmMQOf6qJY7dvIe6h4r0xD5xPL3knod0bkZH5OWroUrKZgyjZ4Fiu
	h+7+9JtX8VFrBw7v/f4fHHL3NIq3IGx/e+JjO9U8nUgnOJkfIWSyXPO8GIM9xBKVX+fUoO+qnTX
	4fYOhu1xS6Kn8cSn7jn75GKH/BsxWk+zRhlmjzWuK9TONPsZx3/GCfqB6H+a7zgwBffw7g027uN
	9x8rOjGWui3qYeKg8m0vL2Y+1SplMfBdk5SMbSrambnigeea2VHOx+Q7Trca7pSCE3aHHRDE6+i
	EggWqhexq0E8oCMkf77XhAba9xdpFlRcdYVqf+wq8sNGUHcr8TpCZ1Xb4=
X-Received: by 2002:a05:6808:5087:b0:468:b01:c28c with SMTP id 5614622812f47-46a8a5dc3efmr5745361b6e.46.1774840889261;
        Sun, 29 Mar 2026 20:21:29 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:56::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7da0a82760esm4942343a34.23.2026.03.29.20.21.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Mar 2026 20:21:28 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf v1 1/2] bpf: Fix grace period wait for tracepoint bpf_link
Date: Mon, 30 Mar 2026 05:21:22 +0200
Message-ID: <20260330032124.3141001-2-memxor@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260330032124.3141001-1-memxor@gmail.com>
References: <20260330032124.3141001-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4530; h=from:subject; bh=wWlz4+6NPJTVf4ZN53WxQ4EMXINCj/zcMltd23+PbEI=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIfPkG86dts+Wqy5f8uo1x6SbF9g4Iqx3rJPm2BpqdVr16vTZ JxYd7yhlYRDjYpAVU2Qp+b+PyfhE5e9A22XcMHNYmUCGMHBxCsBEXmoxMtxd2fk8UCp19wK7vX+1Lm 3e2rShwfNDXZf0goJ7S0Vm8UgyMhzT/W6x3mXeu90/bbwavkScuBLwftaDqxYGJVuuNvi1uvIDAA==
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
true.

Hence we need not chain any SRCU gp waits after RCU Tasks Trace.

Fixes: a46023d5616e ("tracing: Guard __DECLARE_TRACE() use of __DO_TRACE_CALL() with SRCU-fast")
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 include/linux/tracepoint.h |  8 ++++++++
 kernel/bpf/syscall.c       | 22 ++++++++++++++++++++--
 2 files changed, 28 insertions(+), 2 deletions(-)

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
index 274039e36465..ab61a5ce35af 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -3261,6 +3261,13 @@ static void bpf_link_defer_dealloc_rcu_gp(struct rcu_head *rcu)
 	bpf_link_dealloc(link);
 }
 
+static bool bpf_link_is_tracepoint(struct bpf_link *link)
+{
+	/* Only these combinations support a tracepoint bpf_link. */
+	return link->type == BPF_LINK_TYPE_RAW_TRACEPOINT ||
+	       (link->type == BPF_LINK_TYPE_TRACING && link->attach_type == BPF_TRACE_RAW_TP);
+}
+
 static void bpf_link_defer_dealloc_mult_rcu_gp(struct rcu_head *rcu)
 {
 	if (rcu_trace_implies_rcu_gp())
@@ -3279,16 +3286,27 @@ static void bpf_link_free(struct bpf_link *link)
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

