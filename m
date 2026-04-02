Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FC4A2AE8D
	for <bpf@vger.kernel.org>; Thu,  2 Apr 2026 06:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775110673; cv=none; b=igECPTpyO8iwh9+3k74wbJPXwxXcy16gqOy6tG5sqVsiLwYsR2IDk+lHzjgrYXxnCrbFkLbq0e8zyO9+mprgSevRaipbFo2BeL3e7h6eGF8kLk5Taz2361DNF7W1/dxUZ9vdmsG8TpkaDqX8M/aQLSH44C5E1YcZ3aZpRmRP+WI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775110673; c=relaxed/simple;
	bh=tvuoPlNS8Hw3grwWZHpVFxJKs+BN1c1ZdROyyYSE3R0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=csBLDqKb/cgoJoudrNEckvNr1tjOfi+uGnnLphboVq1vHJyU80ynVKbCAVbV9wgL5pIwrPI41P9evyFILRPg/fxpK2JoRmEJqsEhj2CMlJ+n0yYDRZZxhS5I2qq9p8XCmupVRwU3Hw8YGx22E3mViMQM9Bmp6qqRoJbVCNA4Lb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VKgvUWom; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VKgvUWom"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-35d99bae2ebso446737a91.3
        for <bpf@vger.kernel.org>; Wed, 01 Apr 2026 23:17:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775110671; x=1775715471; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0fcglLQuhyOVzoRirBpv1zuHG2MTwN9r4fczEVp3gww=;
        b=VKgvUWomnyoC0PiUDA44HTrXWSVnaGSsO4ltddQMvZCpVDJKLYsD0hKH1jt3NK7PYc
         l3es/pIj6axGb8RXKg/zBsj1YKNJpHISjZwGDRhwQIw4gtADOhOF5d+CS3KXwv1H8cpb
         jTpJZ7n7VJj1QMTo7uj852c9PLybGK+8qCCrUEK5yJoHdCSh99D0qFB3lt4qX7GaySfE
         0y6xDsqWGBxZeZ4g7J7FbdXmamc8fzCeQWEGbHAkMhfZobG9NAYgNR3gUlNh7KjS+NUz
         pwBv8AJ61iC/eMhzaWa1Zi7OYJYDaF/LHvcS8mlMHwXpHkfRlSTwJbXZXHHvEm2J330t
         qLdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775110671; x=1775715471;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0fcglLQuhyOVzoRirBpv1zuHG2MTwN9r4fczEVp3gww=;
        b=OqZiYN+BP6We4p/WY0bDVLFn7cKpza4oTaZKxk1DLes5O3ti1yKTsvtlqRc0h5EYlW
         DC652tpJZHXhf57Ja4wmdceK0TVY3I+FhQh01EE9MBSCjTIyj9K8t8sNEURGQ8TPPz0o
         F8lqrwN7wSGKIgLFLZSRxezOuc0oE2lM2U2Eo9ZEvZH7kL52VZCRRdl+0i7NhXBeHypD
         wOUTtJFrCtjl9Wlz6SeD7n9YtCUYMiiPKY4AtytHitf7r2Zod2WdjaVP6XhiaDbXWZN8
         9vvPDxKoRWQjVlzZn9N6PjxhtltBp0LnzBToN05RGFvywoy/3UBZbdkXrAKeKNz/MuAU
         FzCw==
X-Gm-Message-State: AOJu0Yy+QDow9aSM2kA/7t4Ul2BW2Ylx4WOBq2qdxh19bkx1hy1qAXUk
	uV+NOknJDPPIbFESVNkpgM0UqOxjvoUMMu6nNRcpxP957hcP/VlWhXTk6mDP3g==
X-Gm-Gg: AeBDietmpP6DrpGS+XQp6twyVg6UBDtd1/eqSPdMidfmVeZ50Xjysv5SBvZ2/hT4XNq
	lIvMDJRbG09u2OsbwyoTqw3cdMKnd+5ePpblfJ5MqmYtHxaa7QT8vXf/WTXCEH4ikZ6N9xno7iA
	efj0u1EF3IXQyoedeTE9g9dBptqQgZOfUOugUPx/N3MReNuPoQkRNaIvf3m7yjOhQOU/pi17wOW
	xwd+Fw22tkdRAV4cvUgc5Llh1lmFYVsVe0QWsv6g0fopQNBiWZ407OHzbTjTdYFwnvodDSAOflL
	TZwHSKHnLZm6ANb1+uu/OanzmzbvG8OQVy9GU8BMzj7f/zoalSL4KcpnhoQfb4eJVrx/4w9qiBl
	jsdb/7lsqLFClDCyFcPZALv08tFDRrKQuAZcKZRKglt3EJUF+7+jysoWKKGObyY2DOdGvBP/o8e
	8AYAteSbKmeHBK/d+RRI+DJR07FmKwgdGdVhBFd1+w2BiDG0NTxTyVBsts53KasSSlvL/iZ5tyl
	se1A0nrOmRJI3ZgaPyWY22DumwL8RQKwyfGzUG02Y2EJFwTrjYlI7Qcd4cDyw==
X-Received: by 2002:a17:902:d509:b0:2b0:62dd:3a80 with SMTP id d9443c01a7336-2b2758b4263mr22674685ad.17.1775110671320;
        Wed, 01 Apr 2026 23:17:51 -0700 (PDT)
Received: from localhost.localdomain ([2601:600:837f:c470:1879:8422:922b:e5d3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b27472d1a2sm17905365ad.7.2026.04.01.23.17.50
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 01 Apr 2026 23:17:50 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@kernel.org,
	memxor@gmail.com,
	eddyz87@gmail.com
Subject: [PATCH v2 bpf-next 2/6] bpf: Sort subprogs in topological order after check_cfg()
Date: Wed,  1 Apr 2026 23:17:40 -0700
Message-ID: <20260402061744.10885-3-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260402061744.10885-1-alexei.starovoitov@gmail.com>
References: <20260402061744.10885-1-alexei.starovoitov@gmail.com>
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

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 include/linux/bpf_verifier.h |  2 +
 kernel/bpf/verifier.c        | 83 ++++++++++++++++++++++++++++++++++++
 2 files changed, 85 insertions(+)

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
index 8234d80b892a..c0630691c32d 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -3742,6 +3742,85 @@ static int check_subprogs(struct bpf_verifier_env *env)
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
+				if (color[callee])
+					continue;
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
@@ -26274,6 +26353,10 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr, __u3
 	if (ret)
 		goto skip_full_check;
 
+	ret = sort_subprogs_topo(env);
+	if (ret < 0)
+		goto skip_full_check;
+
 	ret = compute_scc(env);
 	if (ret < 0)
 		goto skip_full_check;
-- 
2.52.0

