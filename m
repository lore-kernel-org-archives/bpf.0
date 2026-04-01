Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AC76317146
	for <bpf@vger.kernel.org>; Wed,  1 Apr 2026 02:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775009805; cv=none; b=HX9DwQh0NmZlN49jqoN7G7/vLlz7dQlVJHvHwwvpINM/Mlrx8zq/KNZhoH4pco6iHkDJYXEIo2djmKzIjc/f1ngx2bZqkw3cg3aQ/c0GCwrGhs14nc2rXCBvJe8Oj6mvavfnDBXcgLXTSLCESc3d6rt0QarjEUjwodDlkFokt5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775009805; c=relaxed/simple;
	bh=i8B9yIkS1W8tEM6jn3EmxPcfUM6ipKJr51YK9mxjZBw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s5yliLN1sW71QT5sT0HlCcTzpfpeHMcS3OwpkfXxobIV//9D/GUioVSVGOAFxHmCYPIRPpdcq/kibXLpipmERJI3VDDkSAtZY9SI4GZKNFMQcYYCWN4Qsm4Q7oj78EOcRc14IAViABosYioru1sKm+BRvMGjvvueKNbm5wv7QGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nCQZcS0s; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nCQZcS0s"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2b24fcc2b5dso20716525ad.1
        for <bpf@vger.kernel.org>; Tue, 31 Mar 2026 19:16:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775009803; x=1775614603; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qbVaNi9xipkI6fm1AC73pBoGGDwiX11ImiHcy2/jB0Q=;
        b=nCQZcS0skB5W2B7qhlWPLb12KghRuKVNgpkzTjDfT4Kxgj0stFWm40BFqSp7uf1cKC
         2ynEDdG7B9H7l7CNiJKRrUoj5tFSBHSQVwBFasYqsMLqpR6Rbs/5adbrcN3YCpOqo0TN
         3mBr4qdlr5ukKwWD/SXlnG5CwUl1WKqZr9PoGbHXUE1J4pumCXJxhEjRwfcNELDD+7gV
         CCBLYlf683VI8cRAHZXfgFG6qZF8S6aGzSnuCqvgnDLNDrYc0ETUrQTlOFmgGlD0bBqU
         4HCkC+UG8yk+Aq+PCgR7s2ThIvPkC3fmGtNQESbqjIMAl34F6sEGuD8ltqdFjNeD3p0g
         Hb1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775009803; x=1775614603;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qbVaNi9xipkI6fm1AC73pBoGGDwiX11ImiHcy2/jB0Q=;
        b=Rmon0itLuyfnK1sAuA19VbjhLkUn49zwS8l+nLjpR18ZJfz+GqvHBiVtpXWsvo5+JQ
         e9n8NxlXkIqw9zv4I0HjZhxgWYF+aaxbZuzfJrnHrIv2a9XV/qMLDCgi+N/N04x0ndcn
         JreO/GVZWu6d+MXXXt6qVmF1KqSYfq62L7Ftz3P8zxY/Z8wcC+r9WCDpHZdupvsE7+NY
         r55wTs2hd2Bt/KtvWP+po0SElek6g/pD1uBrRoUP6xAFi0ZWbZWh6PBGXAh8pscxG4ZB
         h1rrM6JV/zi+xm6q4YQ92BuRZWtjo5XpVrXUWu2jAMJ+QLOIx+T92ht/uJZlT7VsAsmJ
         cuXQ==
X-Gm-Message-State: AOJu0YzFgq9g1DT9BhU9BA7JpEQYG+tHvU3aFgEKhrYGnLQU79kyp1mz
	WF7Ht4064PVgV8pXlZ5RTHIj/bmdpHH6wnnHtHDwbhkb19Wy2jijAB9TMbpXag==
X-Gm-Gg: ATEYQzzmnMRb9D7VXW3rd/Ry4TG8TrqL+pwJrK5a2vAzgl1lWHQVsAoGbLKt4svWwlS
	H3lnNAoQ0ePfuUfvoos18vmZ/87WC6VO5F0vxVT/o0mKEIOW/IwMCTKUjYwOpXlp5eBMU5VbLWb
	99f4RF0hbpz7dhH6Fzqa9Jae39DUz9EiDQuB4cEBnDlhzE99mgCiMPC24poHZq22fUq+xSi7Aht
	6G+05PSJSoz6e7ZqcfIJ8l9BS/PlKUUiWwmxvUH32vi4wcM/nV4HvEh8NdzN87QYa8CZeZSECX+
	YMWZRfsOOSJ7u0xMpVYZaM3Od+msyrubTbdZu2aqscb9MFlhoNmQVk8gB+6UmQ5ALtXfAruOfxZ
	VQ10QBKnBBempr2xgVxYC41zoIoat8qLtBx218paQyT6frBBZv82LkEf26AYM2mUCvoOT05W4MQ
	wUjhN0Zo0ZbNJNxiQ+0jPuFW35vw7uuLQwB1TF6OTwrtNYEO4RztcBAu59oShDHVr66C4NEAk+r
	9evnpdyujdMxuS2D6+4eBzo3fHRzT/vyNsXj0Bsxo2BlrjhNg36peu3+JsMqhCJw2H9FqWq
X-Received: by 2002:a17:903:3c2b:b0:2b0:5968:a6d5 with SMTP id d9443c01a7336-2b269ab5ffamr15119315ad.18.1775009803344;
        Tue, 31 Mar 2026 19:16:43 -0700 (PDT)
Received: from localhost.localdomain ([2601:600:837f:c470:1879:8422:922b:e5d3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b24264292asm132158505ad.4.2026.03.31.19.16.42
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 31 Mar 2026 19:16:43 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@kernel.org,
	memxor@gmail.com,
	eddyz87@gmail.com
Subject: [PATCH bpf-next 2/6] bpf: Sort subprogs in topological order after check_cfg()
Date: Tue, 31 Mar 2026 19:16:31 -0700
Message-ID: <20260401021635.34636-3-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260401021635.34636-1-alexei.starovoitov@gmail.com>
References: <20260401021635.34636-1-alexei.starovoitov@gmail.com>
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
index 3ec786361698..432806011d47 100644
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
+	color = kcalloc(cnt, sizeof(*color), GFP_KERNEL);
+	dfs_stack = kmalloc_array(cnt, sizeof(*dfs_stack), GFP_KERNEL);
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
+	kfree(dfs_stack);
+	kfree(color);
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

