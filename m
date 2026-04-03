Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34E443164AA
	for <bpf@vger.kernel.org>; Fri,  3 Apr 2026 02:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775184271; cv=none; b=rd6KO4KY5cs6RB6tiN5eNXBc2WSAM07mQ8BRjZUFFgP2BNVZQF45/w4Z0upCY6qN501oXmrYvpheVjjvcPNHmqqqLwFRplilrwIs+cVcB+eIG3NvXrz/Z3Zr+dSAhsWmrKDMByEELMTYG7vZIOOri7dqmfkiyb7pIpf5TFoOeVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775184271; c=relaxed/simple;
	bh=JpXrdlZx+W+5HyaFpRkv5U56F9NlzESfi0aIOu8xBuc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OUhUr/X3362U3juPu7DZ/Neivjt91N4mawjLljyYaUPrfGcBPmAjt8KO5fwDYw7ESyU58wfHxg8+H1E45JwWBiE+s3CIXTurmcD3pBdgpGbjOnr8i9NXIhKaU58dnesdG4a0zwWwpYU+OHsx87u3MtBi7P3i2uTVLtR49t5aZz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F+FM3Aeu; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F+FM3Aeu"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2b23f90f53aso14112035ad.0
        for <bpf@vger.kernel.org>; Thu, 02 Apr 2026 19:44:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775184269; x=1775789069; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zmaNzU//TQjSUqmmMFPfHJa1USnPzTxj+LRXp7el8GU=;
        b=F+FM3Aeuc984ii4QW3jA6ZEMdJHE70t3bn055mURFXls17xOa0F48LOh329Gnx+d8U
         WwYPPJkUHXeS+DzmeBHhxtOqTv9LhnJing/N95RKBefnnOrQWHssyT5Fn07tRoUjwLKc
         7P5d1qjUpyUh+NvcswhlGcr3PAQavFY/4dmlALvWVcTrzbN11Mp46lpKBCMrejIZCTwh
         9nsByhoEpRnhhIk9u/97mJVl5gvdYWBY7mxR5jXq8DIyDuEknep91ww3SclnZyRo1z5E
         IQ7gmBqkTz29TFjlcyndDdWBJuFWQZ47rbvZkw4tQtCwbEpWgAs/S9A4xQtRBPIcXEp4
         8dbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775184269; x=1775789069;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zmaNzU//TQjSUqmmMFPfHJa1USnPzTxj+LRXp7el8GU=;
        b=n3JwT84Qoessti3cYZuNnJDdQfEOaIIT6xbB2oI5pAogcjpwO+m/J4YwDK1Gkyzjd7
         8gVNCQPoEF/X0qpCiPPcqnxx6aPmXoYnQe3EXQfFbHszXCvntbWe8qkwXFfHYvmXu7sV
         wyIPkLfOSUuHU25PM3FhfM41Oyhn8Xn57h4aBjw1ecoBK57rX0daIaa2rNlNVtb8DKwl
         RUCFuRu1WcR3jFH86/USoXp6xWSKRBzuK1crChrW8AZOmEGIA3vi+iK0Hk5w2zIHYm7Z
         ur9UWM7j2pXCEr37FxgnsHZ6nlkuk+RRwz/LRS/6p3Xni3lnVLfmC83yM12duO9EWyqc
         Nm8Q==
X-Gm-Message-State: AOJu0YycdFL/LlFUm0xReZeIDO5regnufeQLtqWVVo6/nTXHOQZ4wOiY
	fbKyhRJ55lG67Jsb5+NVSPQquE+40t1HNgtj7p6ep1vKl+vDG6pGi76d9SsnmQ==
X-Gm-Gg: AeBDiespY5X3E1FpRBXNfBQ2rs7lq99N3i+B+0n0WZOPMskhrN4bW7fAHAQg466Ip6D
	7ftLscoEnUZ3dahGMDLnVsRnAZOy9eDgNLjpId94kHWqrKjWatPLYrQO8iR49Af3rR5773EEiXY
	6v9HGShhH0+yrktbpFEhmBy7oNaKGIWqPbH7TNdbPIPZz+0DpAwynw8+F93fbIPkfXk499l4RoF
	kXh60k1kb1rFwDmjNuLf/2R+ciPtCW3A/oeDrWnjq02npAXp8kyRONEUjFsL8uVwqbWD9rAei/2
	hE2KRfIydDa63yOonhd0c6J46mJOcpRAeNn8w48dtjW3saAfETs2Dgwp9ygv9pSyH+krJYYQ6Ht
	Zv0KohWvlhzfMiIDJKFbeVvZw9rKQby++oJ1WMcxemlXa8p/mq3OBaSaP9hdl+POyiPcZ4pbjUW
	3gp0Co31a571hZx4klxTqFSAYc5My3X1HYUm5LPS6OFsfrC0wg+/9HxremZg+lKQbCU0xoZMLZ/
	n2Qtdo95zqxah4lsdh2q7+XCQUsC7EiQlExnvE3kYdIKGdo/0kdJQzEl9KiMg==
X-Received: by 2002:a17:902:cece:b0:2ae:5223:59ac with SMTP id d9443c01a7336-2b2816ca700mr15453275ad.13.1775184269134;
        Thu, 02 Apr 2026 19:44:29 -0700 (PDT)
Received: from localhost.localdomain ([2601:600:837f:c470:1879:8422:922b:e5d3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2749cbce2sm42336405ad.79.2026.04.02.19.44.28
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 02 Apr 2026 19:44:28 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@kernel.org,
	memxor@gmail.com,
	eddyz87@gmail.com
Subject: [PATCH v5 bpf-next 2/6] bpf: Sort subprogs in topological order after check_cfg()
Date: Thu,  2 Apr 2026 19:44:17 -0700
Message-ID: <20260403024422.87231-3-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260403024422.87231-1-alexei.starovoitov@gmail.com>
References: <20260403024422.87231-1-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

Add a pass that sorts subprogs in topological order so that iterating
subprog_topo_order[] walks leaf subprogs first, then their callers.
This is computed as a DFS post-order traversal of the CFG.

The pass runs after check_cfg() to ensure the CFG has been validated
before traversing and after postorder has been computed to avoid
walking dead code.

Reviewed-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 include/linux/bpf_verifier.h                  |  2 +
 kernel/bpf/verifier.c                         | 92 +++++++++++++++++++
 .../selftests/bpf/progs/verifier_loops1.c     |  3 +-
 tools/testing/selftests/bpf/verifier/calls.c  |  6 +-
 4 files changed, 98 insertions(+), 5 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 090aa26d1c98..4f492eaad5c2 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -787,6 +787,8 @@ struct bpf_verifier_env {
 	const struct bpf_line_info *prev_linfo;
 	struct bpf_verifier_log log;
 	struct bpf_subprog_info subprog_info[BPF_MAX_SUBPROGS + 2]; /* max + 2 for the fake and exception subprogs */
+	/* subprog indices sorted in topological order: leaves first, callers last */
+	int subprog_topo_order[BPF_MAX_SUBPROGS + 2];
 	union {
 		struct bpf_idmap idmap_scratch;
 		struct bpf_idset idset_scratch;
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 8234d80b892a..0afabc3567dd 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -3742,6 +3742,94 @@ static int check_subprogs(struct bpf_verifier_env *env)
 	return 0;
 }
 
+/*
+ * Sort subprogs in topological order so that leaf subprogs come first and
+ * their callers come later. This is a DFS post-order traversal of the call
+ * graph. Scan only reachable instructions (those in the computed postorder) of
+ * the current subprog to discover callees (direct subprogs and sync
+ * callbacks).
+ */
+static int sort_subprogs_topo(struct bpf_verifier_env *env)
+{
+	struct bpf_subprog_info *si = env->subprog_info;
+	int *insn_postorder = env->cfg.insn_postorder;
+	struct bpf_insn *insn = env->prog->insnsi;
+	int cnt = env->subprog_cnt;
+	int *dfs_stack = NULL;
+	int top = 0, order = 0;
+	int i, ret = 0;
+	u8 *color = NULL;
+
+	color = kvzalloc_objs(*color, cnt, GFP_KERNEL_ACCOUNT);
+	dfs_stack = kvmalloc_objs(*dfs_stack, cnt, GFP_KERNEL_ACCOUNT);
+	if (!color || !dfs_stack) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	/*
+	 * DFS post-order traversal.
+	 * Color values: 0 = unvisited, 1 = on stack, 2 = done.
+	 */
+	for (i = 0; i < cnt; i++) {
+		if (color[i])
+			continue;
+		color[i] = 1;
+		dfs_stack[top++] = i;
+
+		while (top > 0) {
+			int cur = dfs_stack[top - 1];
+			int po_start = si[cur].postorder_start;
+			int po_end = si[cur + 1].postorder_start;
+			bool pushed = false;
+			int j;
+
+			for (j = po_start; j < po_end; j++) {
+				int idx = insn_postorder[j];
+				int callee;
+
+				if (!bpf_pseudo_call(&insn[idx]) && !bpf_pseudo_func(&insn[idx]))
+					continue;
+				callee = find_subprog(env, idx + insn[idx].imm + 1);
+				if (callee < 0) {
+					ret = -EFAULT;
+					goto out;
+				}
+				if (color[callee] == 2)
+					continue;
+				if (color[callee] == 1) {
+					if (bpf_pseudo_func(&insn[idx]))
+						continue;
+					verbose(env, "recursive call from %s() to %s()\n",
+						subprog_name(env, cur),
+						subprog_name(env, callee));
+					ret = -EINVAL;
+					goto out;
+				}
+				color[callee] = 1;
+				dfs_stack[top++] = callee;
+				pushed = true;
+				break;
+			}
+
+			if (!pushed) {
+				color[cur] = 2;
+				env->subprog_topo_order[order++] = cur;
+				top--;
+			}
+		}
+	}
+
+	if (env->log.level & BPF_LOG_LEVEL2)
+		for (i = 0; i < cnt; i++)
+			verbose(env, "topo_order[%d] = %s\n",
+				i, subprog_name(env, env->subprog_topo_order[i]));
+out:
+	kvfree(dfs_stack);
+	kvfree(color);
+	return ret;
+}
+
 static int mark_stack_slot_obj_read(struct bpf_verifier_env *env, struct bpf_reg_state *reg,
 				    int spi, int nr_slots)
 {
@@ -26274,6 +26362,10 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr, __u3
 	if (ret)
 		goto skip_full_check;
 
+	ret = sort_subprogs_topo(env);
+	if (ret < 0)
+		goto skip_full_check;
+
 	ret = compute_scc(env);
 	if (ret < 0)
 		goto skip_full_check;
diff --git a/tools/testing/selftests/bpf/progs/verifier_loops1.c b/tools/testing/selftests/bpf/progs/verifier_loops1.c
index fbdde80e7b90..d248ce877f14 100644
--- a/tools/testing/selftests/bpf/progs/verifier_loops1.c
+++ b/tools/testing/selftests/bpf/progs/verifier_loops1.c
@@ -138,8 +138,7 @@ l0_%=:	exit;						\
 SEC("tracepoint")
 __description("bounded recursion")
 __failure
-/* verifier limitation in detecting max stack depth */
-__msg("the call stack of 8 frames is too deep !")
+__msg("recursive call from")
 __naked void bounded_recursion(void)
 {
 	asm volatile ("					\
diff --git a/tools/testing/selftests/bpf/verifier/calls.c b/tools/testing/selftests/bpf/verifier/calls.c
index 29e57f0e56c3..c3164b9b2be5 100644
--- a/tools/testing/selftests/bpf/verifier/calls.c
+++ b/tools/testing/selftests/bpf/verifier/calls.c
@@ -455,7 +455,7 @@
 	BPF_EXIT_INSN(),
 	},
 	.prog_type = BPF_PROG_TYPE_TRACEPOINT,
-	.errstr = "the call stack of 9 frames is too deep",
+	.errstr = "recursive call",
 	.result = REJECT,
 },
 {
@@ -812,7 +812,7 @@
 	BPF_EXIT_INSN(),
 	},
 	.prog_type = BPF_PROG_TYPE_TRACEPOINT,
-	.errstr = "the call stack of 9 frames is too deep",
+	.errstr = "recursive call",
 	.result = REJECT,
 },
 {
@@ -824,7 +824,7 @@
 	BPF_EXIT_INSN(),
 	},
 	.prog_type = BPF_PROG_TYPE_TRACEPOINT,
-	.errstr = "the call stack of 9 frames is too deep",
+	.errstr = "recursive call",
 	.result = REJECT,
 },
 {
-- 
2.52.0

