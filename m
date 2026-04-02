Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D82443B3890
	for <bpf@vger.kernel.org>; Thu,  2 Apr 2026 21:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775165346; cv=none; b=jNOQPjrzDsMipu+rqptaZKr4tEhP5/adCEhfZliWmgshqM0T/EyXLIX0ZoT6UHsepYODCrT2IRnHvQ6XipHURlDwMtilaE2PJ1j8172QHWbw7c9xTCRq6hSvVtOZwwf7THTPpI0YyHk09qtNnkZ1/QAQX9cZLo2HrpNQDJxXOCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775165346; c=relaxed/simple;
	bh=fF2SvBNweieVKzFNSyDFLwntB2PUZznMxypRXU2g7OY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DwOE0c/Djnn9gyHVzinnZQGiAiKhdy/ySTy1yQDb7h5fE5MhdYEKmmUiwOes2axzkE5RKzW9vcc7TdtfO9E2j9wM8mpkmRDZQ2uIdBd8VDWlMNrGWs8qRTm0NYdp8EtZjC9tSiySxJHBcmFFKpSpjf1P9ZxZtbYp+4pfZsmwL5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VaOMzx+e; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VaOMzx+e"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2b24fcc2b5dso9086265ad.1
        for <bpf@vger.kernel.org>; Thu, 02 Apr 2026 14:29:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775165344; x=1775770144; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fGSBvNjfTMUK4NVyeeXp4oD83S1OCHEDTw4RNpenENw=;
        b=VaOMzx+easL42dgOLS9ZzEI/cv4Ies6S7pF36LkQ9Ai98nOjJZnF0Zz4dL4gjZfYJQ
         4/wEGT/jPzW4xm3knVdCy+30HW+ezhDt5wOJXj+QaCru9L4+WS8Z6VvlJfmdGUnAtim+
         G19vlhmLd2xpt4nxuv6e61UXb4SQd1fvzNXcwX9q7sldEa4BIKAjKcA453J4697Ehsue
         Rpm5vaaIGvYtzs/ueDfjRVIUnqCcJnUBS8gKDOAXJnYxHsyQ8pNNYPEZnOJ2ffuj0Fem
         dAkBYgcUNWAxKUELTrQqYjjAnoCSKvd+uaW0nQoP8wGruq4qUQqrqws3RRRDcaFGUb68
         /htQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775165344; x=1775770144;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fGSBvNjfTMUK4NVyeeXp4oD83S1OCHEDTw4RNpenENw=;
        b=HPkE7HPHNiln/sWSGmw2iw4875x8ZZlrNJS7PoRqXe+F80hHBka+7oemSzIH6PwAww
         ODf+SIo9Kqd2CMDEjYy0HOZHdeykEgH9BAL0wbZFaH15pbSKvD5iV9GSaPO689+rW4qg
         nn0rQsX7mgYpElFZG5n+s8D2hlCZnFBwwg7RCCfKmENv8n3H2/OWiuptPOsIQUgnqNwI
         WR4eBoDsNrhc3TKptPpTwyk2wmIc5ejDEKDVnDtqJnSsklJcryjTQWfwfjOya+aikEYx
         bF6MD2lyqGmvwgTbsZ5VdSbhpN0qyI0uzcjSYGtijXLCor90JdOLGMPCqmc6r2QB02tS
         MXIw==
X-Gm-Message-State: AOJu0Yz3+SWH1lRQcnlm6LGPLCGoRyeQe7BSa8SICi2r3vZ/Z/8RHbPZ
	rxZOxsFre8Q2/RHVBA+9ckWZ8ubMZMxKkProUj0OU6b9oxH73/QFmExKYCX8/A==
X-Gm-Gg: AeBDieveE6wfEKR6YE4QkOodXh0p2DOalSqmy0KAZJHbUPMnfgUq5ubW84QAc5kgRLl
	0kH8YrNHyW9V1u6O8eHmp0QwCysRLODdUVNqEGlfUbqJP2jPiU6hdo8rqsnBGBtMYOTxjiCHU2G
	sEmKk21BnGvh7fCrSMVlz4LFNyKCQztlr7HxXqw2zlFvn5QmRhyRbk4Xn67u3TkSMT23nZlJZX8
	14hehEExxFmE9u/ZogRh0dYYTOZLzHIl2CsoeWwItusyfFCJpEegzWK5E0McpdaD0dzr5QHiq0e
	l2LLWOd29h0ZjZhCrmIWjNkEmKsKIiarY7o7Mwzh8oNO6tLnJcZ+La0ON/nvdA1q+4V5dBpcLhK
	KclqPsVI8SGF98bBjxxTZfOZj8BBir7hm5/AeWAP7VIKQR0S/AgU5dj6Hs/59vH0qKB2uxWdhOT
	k4u/jHoW7rNecuK9dVskwTK0qrOGzPzbnx9BL2dRKgnMQU8pHvtjXOPVcvyf+2bM6/7DG66xgWz
	QeFKd/W5Y5WvGNbqaFPCMEfzw8h0IASUMLVEFsbtRxPDl0uei0zMi64KcdC6w==
X-Received: by 2002:a17:902:ccc9:b0:2b0:7e4d:f43f with SMTP id d9443c01a7336-2b281889829mr6697215ad.41.1775165343694;
        Thu, 02 Apr 2026 14:29:03 -0700 (PDT)
Received: from localhost.localdomain ([2601:600:837f:c470:1879:8422:922b:e5d3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2749cbd07sm35875685ad.72.2026.04.02.14.29.02
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 02 Apr 2026 14:29:03 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@kernel.org,
	memxor@gmail.com,
	eddyz87@gmail.com
Subject: [PATCH v3 bpf-next 2/6] bpf: Sort subprogs in topological order after check_cfg()
Date: Thu,  2 Apr 2026 14:28:52 -0700
Message-ID: <20260402212856.86606-3-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260402212856.86606-1-alexei.starovoitov@gmail.com>
References: <20260402212856.86606-1-alexei.starovoitov@gmail.com>
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
 kernel/bpf/verifier.c                         | 90 +++++++++++++++++++
 .../selftests/bpf/progs/verifier_loops1.c     |  3 +-
 3 files changed, 93 insertions(+), 2 deletions(-)

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
index 8234d80b892a..da7cf7c1a05b 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -3742,6 +3742,92 @@ static int check_subprogs(struct bpf_verifier_env *env)
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
@@ -26274,6 +26360,10 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr, __u3
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
-- 
2.52.0

