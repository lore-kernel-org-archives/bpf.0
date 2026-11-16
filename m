Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794808683;
	b=R6yBfzmMKsEr5vbeHJR6NVgbjJ2H5ytgogKRv/0sZb3QcS5iGFtbNJkoN8tXMafmlVoU
	 4viFfT4nQzSSTUpT7387bRZ1hF1rwt7xnK+iDdNOJmNkewqQyun19zWWA6aJ4oPlt3Loq
	 pt24AVZPmkjPnoUfKRAKFPiAG+5SPEc9lKL7kN9DxJHg9cdJkLl4SjVBju9AJQXHP8ZES
	 muCYogDYJqiuR2t3A3fqDjlDqTQch59xi2iouHImi8Y8yMOQziTjMVtV/JQKIa8IM0HmS
	 EYisyRrL0IVaSjejtOZjabNKTR8tn84HyTAA7dmvNGfrSB/6d7W3HGfiRQGLre6gn7A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794808683;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=RYiVhWtnBs14OEzZoGAdZ11Lz4Jxo1ymudf2sMzgYUc=;
	b=bPYG13swSpoMzzzk3hcN8uZHT46i2cMiFtZH2y2MbzWQbkRVn4EkH1GhGP43kedYx8pe
	 lJett0XdEJc3wFRgMhV3SUIujjhVw6mDur/5kpHc5k5keT4XtokpPhn5Hzolv0N86+Ki7
	 gEBAKFUf7bv/jnkPh9ocZZ0FBK/x2oGbcGAX5ALC18PT5tR9V6uSfJa/1/0F66mg0WDhU
	 Ywd49rrgQoryrHhJatby47hg5ultYZrgjG15y8dW2FfkGapTjDybGbW3pgHAPW9soonAd
	 Rm8yGk53c5d7KO/NXrTMhkA6diOB2Tz0jFwIszNnUUvBCqo7ztxzV4ZcnC6Vpz5OJCw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=iqdyqtQ5;
	arc=none smtp.remote-ip=209.85.216.52
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E88B606A323
	for <bpf@vger.kernel.org>; Mon, 16 Nov 2026 05:58:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9E88B606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=iqdyqtQ5
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-3b37951a397so1013269a91.0
        for <bpf@vger.kernel.org>; Sun, 15 Nov 2026 21:58:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794808682; x=1795413482; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RYiVhWtnBs14OEzZoGAdZ11Lz4Jxo1ymudf2sMzgYUc=;
        b=iqdyqtQ5O/VxWRTT6rf0LtpAD69cU6v89u/NanuzLv6/5zUYhqW+FtDukgE5kfcULx
         obUP/yUsc6u9ML/uuEP/ZH2AhNdo8YMxGlmvoT6dv5vuWE27nqDzODUfrwRl71CdGm5D
         +X1dbrUxp+GV3u/H65dduSjwSuBxW1xT2pM2Ww6x8BV3LnFEvXzMJF9vIUGF8+Xi566e
         5rHIAiRNaYwb/AyJWl4ZQW/IwxQOi0A560FuaNHt2ioAC0yxx1vZvQPbo8hhtYdeVasW
         /3PGIvn+wnQVqBObxqsUYsc9FoWeh/ULScKdLVlIrNCCD7qJfma6JbmiPBBg0VUdCs28
         N2Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794808682; x=1795413482;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=RYiVhWtnBs14OEzZoGAdZ11Lz4Jxo1ymudf2sMzgYUc=;
        b=ak3aqQ3rbDqplveYddytKTXo8Oxd4TGYWXYU/erJ71WEXb2L4FjOvAoosmx2rUSqji
         pDWnQZHqoLkvS5UJL2w3zCH7KUW534nTqXj0Tn6tADGbhQNykBGl2sw0ELFZp1+Cb3Ps
         BUNrpqBPCFz6+OE2G3aHFyAEhJ7M6z8Bhy+6oT+P+PEj2c9CSQfIMvl540wGzLq/x/rj
         7dlp9LDzGG9p0k0ZQ3WA6VPVrY+86aXu7NauFxgtlmRfYRJJ0yQNwJK9bx6UHGiQWbv+
         63UO1pTK4Tk44BBBHF/gE66oFFiEz38Hg4jdNIOrLTUIy0LIzX6fsZgUtC+SjHWC4krN
         Tu5A==
X-Gm-Message-State: APuU4Z/wM5cxlB5EDnb/xkrLbAb74XhP3N2QribdBNIg5A0W7iaUsTGE
	N6h0lRLcorsWXgIDPVyLBIm9mBcBwmF8UZm4XMaCFANl06+312/npPLPpAw2vQ==
X-Gm-Gg: AYBFou3EFdjN/nvGsB6vE1GVN+nSktRUZ6Mmtin8y53siZtcdHtdB3juFODdpisBeWZ
	lO0jpwafw8AA7tydYJ+IUodQN5R0s/efqWkHwk3NBjMhNF6bJTiCcab96axX2L5FX7XhDjUDDSN
	u7lLDKI1v8wCl/aSnOqqa24sJ1V5litWy+T4G5Sglxq+/XdzrNUu3CFt4K1mZFW3yRD9K5TZl/v
	efcZnkBGlaGSy6A9BDbtGMgEfLxCJv4qaY3bx9SGwI5kgm0YsBVNxgSUYTIgBzH1kidMuQ++vgf
	WWQoBGFCgwdXoqd6CRW7NKSwha2zseTfaKoSzM+C+IfBuXWqcH+fVX2pycWZynV2lhWNdOHMwwo
	hBNSHo14jqwyBeERSQi2g4XaNNWJQ5t3Zm8v9/5LN6Z2SxSFHyB0qH+GtfZW+eV8ReVkadzixEJ
	Zv4UhTUK/cYOKgrbg+YBvQIUQgMTdZoImkjDA2w9D5K/3vtgr6KMa8aZiUZNFyHRNKctJU491A9
	qI/dbN9zFIzXj4jHClRRd5PMO7HIrKaCo8tvtWZUC4MaRnwrIQd+lI6nxQpk+E9VoS3lfXIMECU
	adekvUN3bLtzeizK8fG4Do3HXjWpW3FgOPMI8hHZzp5Ay5M2Tnclqw2DeA1jH30NTLe68g6nbiX
	Z+O5a51nsd427Z3YX5OqkZoDeGCjpiJj4mvc18C0knTInNerIPsTv7Cf4q3JsrjCcGN206HdAsA
	==
X-Received: by 2002:a17:90a:e7ca:b0:3ab:1285:dfd6 with SMTP id 98e67ed59e1d1-3b1b0ca64a7mr11127241a91.38.1794808681376;
        Sun, 15 Nov 2026 21:58:01 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.252])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b1b3a21769sm8233004a91.4.2026.11.15.21.58.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Nov 2026 21:58:00 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next 13/21] bpf: Keep the call graph in lists of edges
Date: Mon, 16 Nov 2026 05:56:30 +0000
Message-ID: <20261116055638.4171529-14-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261116055638.4171529-1-alexei.starovoitov@gmail.com>
References: <20261116055638.4171529-1-alexei.starovoitov@gmail.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

The call graph is a matrix of bits. Its closure takes O(n^3 / 64) and
runs twice. The passes over it repeat until nothing changes.

Keep the edges in lists and sort the graph once, with cycles in a row:

  main -> f1 -> f2 -> f3       order:  f3 | f2 f1 | main
          ^     |
          +-----+

Marks go to callers or to callees in one pass over that order. callx
calls one extra node, which calls all functions whose address is taken.

After the main pass only the insns that were seen count. A call, a tail
call, LD_ABS or bpf_throw() in dead code rejects nothing. The load of
an address is not a call: the main pass records who calls a callback.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 include/linux/bpf_verifier.h                  |  40 +-
 kernel/bpf/cfg.c                              | 128 +++++
 kernel/bpf/verifier.c                         | 485 +++++++-----------
 .../bpf/progs/test_global_func_deep_stack.c   |  12 +-
 .../selftests/bpf/progs/verifier_tailcall.c   |   4 +-
 tools/testing/selftests/bpf/verifier/calls.c  |   3 +-
 6 files changed, 357 insertions(+), 315 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 28104dae5f08..7bea740eeaee 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -769,6 +769,32 @@ struct bpf_index {
 int bpf_index_find(const struct bpf_index *index, u64 key);
 int bpf_index_add(struct bpf_index *index, u64 key, u32 val);
 
+/* A graph of calls. The nodes are subprogs, and behind them what stands for a set of subprogs. */
+struct bpf_call_graph {
+	u32 cnt;	/* nodes */
+	u32 edge_cnt;
+	u32 *callee;	/* node s calls callee[first[s]] .. callee[first[s + 1] - 1] */
+	u32 *first;
+	/* see bpf_call_graph_sort() */
+	u32 *postorder;
+	u32 *order;
+	u32 *cycle;
+	u16 *marks;	/* of the user of the graph */
+	u32 next;	/* nodes that have 'first' */
+};
+
+#define bpf_for_each_callee(cg, s, j)							\
+	for (u32 ___e = (cg)->first[s];							\
+	     ___e < (cg)->first[(s) + 1] && ({ j = (cg)->callee[___e]; 1; }); ___e++)
+
+int bpf_call_graph_init(struct bpf_call_graph *cg, u32 cnt);
+int bpf_call_graph_add(struct bpf_call_graph *cg, u32 caller, u32 callee);
+void bpf_call_graph_sort(struct bpf_call_graph *cg, u16 skip);
+bool bpf_call_graph_recursive(const struct bpf_call_graph *cg, u32 s);
+void bpf_call_graph_mark_callees(struct bpf_call_graph *cg, u16 mask);
+void bpf_call_graph_mark_callers(struct bpf_call_graph *cg, u16 mask, u16 skip);
+void bpf_call_graph_free(struct bpf_call_graph *cg);
+
 #define iarray_for_each(item, arr)						\
 	for (int ___idx = 0;							\
 	     ___idx < (arr)->cnt && ({ item = (arr)->items[___idx]; 1; });	\
@@ -1088,6 +1114,7 @@ struct bpf_subprog_info {
 	 * U32_MAX when it has none.
 	 */
 	u32 exit_idx;
+	u32 callx_edge; /* 1 + the first of its env->callx_edges, 0 if none */
 	struct bpf_iarray *jt; /* jump table shared by all gotox of this subprogram */
 	u16 stack_depth; /* max. stack depth used by this function */
 	u16 stack_extra;
@@ -1341,13 +1368,12 @@ struct bpf_verifier_env {
 	u32 func_set_cnt;
 	struct bpf_index func_set_index;
 	bool has_callx;
-	/*
-	 * Call graph edges created by callx instructions. A bitmap of
-	 * subprog_cnt * subprog_cnt bits, where bit (caller * subprog_cnt + callee)
-	 * is set when the main verification pass sees 'caller' calling 'callee'
-	 * via callx. Allocated when the first such edge is recorded.
-	 */
-	unsigned long *callx_edges;
+	/* What callx and helpers call, a list for each caller, see record_callx_edge() */
+	struct bpf_callx_edge {
+		u32 callee;
+		u32 next;	/* 1 + the next edge of the caller, 0 if none */
+	} *callx_edges;
+	struct bpf_index callx_index;
 	struct bpf_idmap idmap_scratch;
 	struct {
 		int *insn_state;
diff --git a/kernel/bpf/cfg.c b/kernel/bpf/cfg.c
index 92dc8d0dc22a..07412c0b9d30 100644
--- a/kernel/bpf/cfg.c
+++ b/kernel/bpf/cfg.c
@@ -238,6 +238,134 @@ int bpf_index_add(struct bpf_index *index, u64 key, u32 val)
 	return 0;
 }
 
+int bpf_call_graph_init(struct bpf_call_graph *cg, u32 cnt)
+{
+	*cg = (struct bpf_call_graph){ .cnt = cnt };
+	/* the last 4 parts are for bpf_call_graph_sort() */
+	cg->first = kvcalloc(8 * (size_t)cnt + 1, sizeof(u32), BPF_VERIFIER_GFP);
+	cg->marks = kvcalloc(cnt, sizeof(u16), BPF_VERIFIER_GFP);
+	if (!cg->first || !cg->marks)
+		return -ENOMEM;
+	cg->postorder = cg->first + cnt + 1;
+	cg->order = cg->postorder + cnt;
+	cg->cycle = cg->order + cnt;
+	return 0;
+}
+
+void bpf_call_graph_free(struct bpf_call_graph *cg)
+{
+	kvfree(cg->first);
+	kvfree(cg->callee);
+	kvfree(cg->marks);
+}
+
+/* Callers come in increasing order */
+int bpf_call_graph_add(struct bpf_call_graph *cg, u32 caller, u32 callee)
+{
+	if (WARN_ON_ONCE(callee >= cg->cnt))
+		return -EFAULT;
+	if (!bpf_table_next(cg->callee, cg->edge_cnt))
+		return -ENOMEM;
+	while (cg->next <= caller)
+		cg->first[cg->next++] = cg->edge_cnt;
+	cg->callee[cg->edge_cnt++] = callee;
+	return 0;
+}
+
+/*
+ * Tarjan's algorithm. Calls of the nodes that have a mark in 'skip' do not count.
+ *
+ *   main -> f1 -> f2 -> f3      postorder:  f3 f2 f1 main
+ *           ^     |             order:      f3 f2 f1 main    callees first, a cycle in a row
+ *           +-----+             cycle:      0  1  1  3       where the cycle starts in 'order'
+ */
+void bpf_call_graph_sort(struct bpf_call_graph *cg, u16 skip)
+{
+	u32 cnt = cg->cnt, *low = cg->cycle + cnt, *edge = low + cnt, *path = edge + cnt;
+	u32 *open = path + cnt, depth = 0, top = 0, num = 0, done = 0, post = 0, i, s, j;
+
+	while (cg->next <= cnt)
+		cg->first[cg->next++] = cg->edge_cnt;
+	/* low: 0 - not visited, U32_MAX - is in 'order' */
+	memset(low, 0, cnt * sizeof(*low));
+	for (i = 0; i < cnt; i++) {
+		if (!low[i])
+			path[depth++] = i;
+		while (depth) {
+			s = path[depth - 1];
+			if (!low[s]) {
+				/* until the node is in 'order': its number */
+				low[s] = cg->cycle[s] = ++num;
+				edge[s] = cg->first[s];
+				open[top++] = s;
+			}
+			if (edge[s] < cg->first[s + 1]) {
+				j = cg->callee[edge[s]];
+				if (cg->marks[j] & skip) {
+					edge[s]++;
+				} else if (!low[j]) {
+					path[depth++] = j;
+				} else {
+					low[s] = min(low[s], low[j]);
+					edge[s]++;
+				}
+				continue;
+			}
+			depth--;
+			cg->postorder[post++] = s;
+			if (low[s] != cg->cycle[s])
+				continue;
+			for (j = done; low[s] != U32_MAX; done++) {
+				cg->order[done] = open[--top];
+				cg->cycle[open[top]] = j;
+				low[open[top]] = U32_MAX;
+			}
+		}
+	}
+}
+
+bool bpf_call_graph_recursive(const struct bpf_call_graph *cg, u32 s)
+{
+	u32 j;
+
+	bpf_for_each_callee(cg, s, j)
+		if (cg->cycle[j] == cg->cycle[s])
+			return true;
+	return false;
+}
+
+/* What a node has of 'mask', all nodes that it gets to have */
+void bpf_call_graph_mark_callees(struct bpf_call_graph *cg, u16 mask)
+{
+	u32 start, end, i, j;
+	u16 m;
+
+	for (end = cg->cnt; end; end = start) {
+		start = cg->cycle[cg->order[end - 1]];
+		for (i = start, m = 0; i < end; i++)
+			m |= cg->marks[cg->order[i]] & mask;
+		for (i = start; i < end; i++)
+			bpf_for_each_callee(cg, cg->order[i], j)
+				cg->marks[j] |= m;
+	}
+}
+
+/* What a node has of 'mask', all nodes that get to it have. 'skip' is that of the sort. */
+void bpf_call_graph_mark_callers(struct bpf_call_graph *cg, u16 mask, u16 skip)
+{
+	u32 start, end, j;
+	u16 m;
+
+	for (start = 0; start < cg->cnt; start = end) {
+		for (end = start, m = 0; end < cg->cnt && cg->cycle[cg->order[end]] == start; end++)
+			bpf_for_each_callee(cg, cg->order[end], j)
+				if (!(cg->marks[j] & skip))
+					m |= cg->marks[j] & mask;
+		for (j = start; j < end; j++)
+			cg->marks[cg->order[j]] |= m;
+	}
+}
+
 static int copy_insn_array(struct bpf_map *map, u32 start, u32 end, u32 *items)
 {
 	struct bpf_insn_array_value *value;
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index e29eb7d7162b..35b94ab7ba97 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -3213,7 +3213,8 @@ static int add_kfuncs(struct bpf_verifier_env *env)
 	return 0;
 }
 
-static void find_subprog_properties(struct bpf_verifier_env *env)
+/* Before the main pass all insns count, after it those that were 'seen' */
+static void find_subprog_properties(struct bpf_verifier_env *env, bool seen)
 {
 	struct bpf_subprog_info *subprog = env->subprog_info;
 	struct bpf_insn *insn = env->prog->insnsi;
@@ -3222,10 +3223,15 @@ static void find_subprog_properties(struct bpf_verifier_env *env)
 	for (cur_subprog = 0; cur_subprog < env->subprog_cnt; cur_subprog++) {
 		int i;
 
+		subprog[cur_subprog].has_tail_call = false;
+		subprog[cur_subprog].tail_call_reachable = false;
+		subprog[cur_subprog].has_ld_abs = false;
 		for (i = subprog[cur_subprog].start;
 		     i < subprog[cur_subprog + 1].start; i++) {
 			u8 code = insn[i].code;
 
+			if (seen && !env->insn_aux_data[i].seen)
+				continue;
 			if (code == (BPF_JMP | BPF_CALL) &&
 			    insn[i].src_reg == 0 &&
 			    insn[i].imm == BPF_FUNC_tail_call) {
@@ -3310,33 +3316,18 @@ static int check_subprogs(struct bpf_verifier_env *env)
  */
 static int record_callx_edge(struct bpf_verifier_env *env, int caller, int callee)
 {
-	u32 cnt = env->subprog_cnt;
+	u32 *first = &env->subprog_info[caller].callx_edge, cnt = env->callx_index.cnt;
+	u64 key = (u64)caller << 32 | callee;
 
-	if (!env->callx_edges) {
-		env->callx_edges = kvcalloc(BITS_TO_LONGS(cnt * cnt), sizeof(long),
-					    BPF_VERIFIER_GFP);
-		if (!env->callx_edges)
-			return -ENOMEM;
-	}
-	__set_bit(caller * cnt + callee, env->callx_edges);
+	if (bpf_index_find(&env->callx_index, key) >= 0)
+		return 0;
+	if (!bpf_table_next(env->callx_edges, cnt) || bpf_index_add(&env->callx_index, key, cnt))
+		return -ENOMEM;
+	env->callx_edges[cnt] = (struct bpf_callx_edge){ callee, *first };
+	*first = cnt + 1;
 	return 0;
 }
 
-/*
- * Return the first subprog with the number >= 'from' that 'caller' calls
- * via callx, or -1 when there is none.
- */
-static int next_callx_callee(struct bpf_verifier_env *env, int caller, int from)
-{
-	u32 cnt = env->subprog_cnt;
-	unsigned long bit, end = (caller + 1) * cnt;
-
-	if (!env->callx_edges || from >= cnt)
-		return -1;
-	bit = find_next_bit(env->callx_edges, end, caller * cnt + from);
-	return bit < end ? bit - caller * cnt : -1;
-}
-
 /*
  * 'call foo; unwind_goto pad' goes to the pad when foo left with unwind_exit.
  * JITs don't emit a branch for it. unwind_exit finds the pad by its return
@@ -3403,93 +3394,40 @@ static int sort_subprogs_topo(struct bpf_verifier_env *env)
 	struct bpf_subprog_info *si = env->subprog_info;
 	int *insn_postorder = env->cfg.insn_postorder;
 	struct bpf_insn *insn = env->prog->insnsi;
-	int cnt = env->subprog_cnt;
-	int *dfs_stack = NULL;
-	int top = 0, order = 0;
-	int i, ret = 0;
-	u8 *color = NULL;
-
-	color = kvzalloc_objs(*color, cnt, BPF_VERIFIER_GFP);
-	dfs_stack = kvmalloc_objs(*dfs_stack, cnt, BPF_VERIFIER_GFP);
-	if (!color || !dfs_stack) {
-		ret = -ENOMEM;
-		goto out;
-	}
+	int cnt = env->subprog_cnt, i, j, idx, ret;
+	struct bpf_call_graph cg;
 
-	/*
-	 * DFS post-order traversal.
-	 * Color values: 0 = unvisited, 1 = on stack, 2 = done.
-	 */
+	ret = bpf_call_graph_init(&cg, cnt);
 	for (i = 0; i < cnt; i++) {
-		if (color[i])
-			continue;
-		color[i] = 1;
-		dfs_stack[top++] = i;
-
-		while (top > 0) {
-			int cur = dfs_stack[top - 1];
-			int po_start = si[cur].postorder_start;
-			int po_end = si[cur + 1].postorder_start;
-			bool pushed = false;
-			int j;
-
-			for (j = po_start; j < po_end; j++) {
-				int idx = insn_postorder[j];
-				int callee;
-
-				if (bpf_is_callx(&insn[idx])) {
-					/* find a callee that is not explored yet */
-					callee = -1;
-					do {
-						callee = next_callx_callee(env, cur, callee + 1);
-					} while (callee >= 0 && color[callee] == 2);
-					if (callee < 0)
-						continue;
-				} else if (bpf_pseudo_call(&insn[idx]) || bpf_pseudo_func(&insn[idx])) {
-					callee = bpf_find_subprog(env, idx + insn[idx].imm + 1);
-					if (callee < 0) {
-						ret = -EFAULT;
-						goto out;
-					}
-				} else {
-					continue;
-				}
-				if (color[callee] == 2)
-					continue;
-				/*
-				 * The call that is its own target never returns. It is
-				 * also what libbpf leaves in place of a call that it
-				 * could not resolve.
-				 */
-				if (bpf_pseudo_call(&insn[idx]) && insn[idx].imm == -1) {
-					verbose(env, "call at insn %d calls itself\n", idx);
-					ret = -EINVAL;
-					goto out;
-				}
-				/* recursion: the order within the cycle is arbitrary */
-				if (color[callee] == 1)
-					continue;
-				color[callee] = 1;
-				dfs_stack[top++] = callee;
-				pushed = true;
+		for (j = si[i].postorder_start; j < si[i + 1].postorder_start && !ret; j++) {
+			idx = insn_postorder[j];
+			if (!bpf_pseudo_call(&insn[idx]) && !bpf_pseudo_func(&insn[idx]))
+				continue;
+			/*
+			 * The call that is its own target never returns. It is
+			 * also what libbpf leaves in place of a call that it
+			 * could not resolve.
+			 */
+			if (bpf_pseudo_call(&insn[idx]) && insn[idx].imm == -1) {
+				verbose(env, "call at insn %d calls itself\n", idx);
+				ret = -EINVAL;
 				break;
 			}
-
-			if (!pushed) {
-				color[cur] = 2;
-				env->subprog_topo_order[order++] = cur;
-				top--;
-			}
+			ret = bpf_call_graph_add(&cg, i,
+						 bpf_find_subprog(env, idx + insn[idx].imm + 1));
 		}
 	}
+	if (ret)
+		goto out;
+	bpf_call_graph_sort(&cg, 0);
+	memcpy(env->subprog_topo_order, cg.postorder, cnt * sizeof(u32));
 
 	if (env->log.level & BPF_LOG_LEVEL2)
 		for (i = 0; i < cnt; i++)
 			verbose(env, "topo_order[%d] = %s\n",
 				i, bpf_subprog_name(env, env->subprog_topo_order[i]));
 out:
-	kvfree(dfs_stack);
-	kvfree(color);
+	bpf_call_graph_free(&cg);
 	return ret;
 }
 
@@ -5447,122 +5385,75 @@ static int round_up_stack_depth(struct bpf_verifier_env *env, int stack_depth)
 	return round_up(max_t(u32, stack_depth, 1), 32);
 }
 
-/*
- * A set of subprogs is a bitmap. The call graph has a set for every subprog:
- * calls + s * BITS_TO_LONGS(cnt) are the subprogs that s calls. Make it
- * the subprogs that s gets to, through any number of calls.
- */
-static void close_call_graph(unsigned long *calls, int cnt)
-{
-	int words = BITS_TO_LONGS(cnt);
-	int j, s;
+enum {
+	CG_LIVE		= BIT(0), /* what the kernel calls and what that gets to */
+	CG_IN_CB	= BIT(1), /* callbacks and what they get to */
+	CG_IN_ASYNC_CB	= BIT(2), /* async callbacks and what they get to */
+	CG_IN_RECURSION	= BIT(3), /* recursive subprogs and what they get to */
+	CG_TAIL_CALL	= BIT(4), /* subprogs that get to a tail call */
+	CG_ARENA_SP	= BIT(5), /* subprogs that get to r12 */
+	CG_CB		= BIT(6),
+	CG_GLOBAL	= BIT(7),
+};
 
-	for (j = 0; j < cnt; j++)
-		for (s = 0; s < cnt; s++)
-			if (test_bit(j, calls + s * words))
-				bitmap_or(calls + s * words, calls + s * words,
-					  calls + j * words, cnt);
-}
+#define for_each_marked_subprog(cg, s, mark) \
+	for (s = 0; s < (cg)->cnt; s++) if (!((cg)->marks[s] & (mark))) {} else
 
 /*
  * Who calls whom. It's known after the main verification pass, which finds out
- * what callx and the helpers that take callbacks call.
+ * what callx and the helpers that take callbacks call, and what is dead code.
  *
  * What follows for a subprog from its callers, or from what it calls, is computed
  * over this graph and not by a walk of one chain of calls after another: the
  * number of chains grows exponentially, and there is no end to them when subprogs
  * call themselves.
  */
-struct bpf_call_graph {
-	int cnt; /* subprogs */
-	int words; /* longs in a set of subprogs */
-	unsigned long *calls; /* calls + s * words: the subprogs that s calls */
-	unsigned long *reach; /* reach + s * words: the subprogs that s gets to */
-	unsigned long *live; /* what the kernel calls and what that gets to */
-	unsigned long *in_cb; /* callbacks and what they get to */
-	unsigned long *in_async_cb; /* async callbacks and what they get to */
-	unsigned long *in_recursion; /* recursive subprogs and what they get to */
-	unsigned long *tail_calls; /* subprogs that have a tail call */
-	unsigned long *arena_sp; /* subprogs that count on r12 of the caller */
-};
-
-static unsigned long *subprog_calls(struct bpf_call_graph *cg, int s)
-{
-	return cg->calls + s * cg->words;
-}
-
-static unsigned long *subprog_reach(struct bpf_call_graph *cg, int s)
-{
-	return cg->reach + s * cg->words;
-}
-
-/* add the subprog and what it gets to */
-static void add_reach(struct bpf_call_graph *cg, unsigned long *set, int s)
-{
-	__set_bit(s, set);
-	bitmap_or(set, set, subprog_reach(cg, s), cg->cnt);
-}
-
 static int build_call_graph(struct bpf_verifier_env *env, struct bpf_call_graph *cg)
 {
 	struct bpf_subprog_info *si = env->subprog_info;
 	struct bpf_insn *insn = env->prog->insnsi;
-	int cnt = env->subprog_cnt, words = BITS_TO_LONGS(cnt);
-	int i, j, s;
-
-	cg->cnt = cnt;
-	cg->words = words;
-	cg->calls = kvcalloc((2 * cnt + 6) * words, sizeof(long), BPF_VERIFIER_GFP);
-	if (!cg->calls)
-		return -ENOMEM;
-	cg->reach = cg->calls + cnt * words;
-	cg->live = cg->reach + cnt * words;
-	cg->in_cb = cg->live + words;
-	cg->in_async_cb = cg->in_cb + words;
-	cg->in_recursion = cg->in_async_cb + words;
-	cg->tail_calls = cg->in_recursion + words;
-	cg->arena_sp = cg->tail_calls + words;
+	int cnt = env->subprog_cnt, i, s, err;
 
+	err = bpf_call_graph_init(cg, cnt);
 	for (s = 0; s < cnt; s++) {
-		for (i = si[s].start; i < si[s + 1].start; i++) {
-			/* the subprog that takes the address of a subprog counts as its caller */
-			if (!bpf_pseudo_call(insn + i) && !bpf_pseudo_func(insn + i))
-				continue;
-			j = bpf_find_subprog(env, i + insn[i].imm + 1);
-			if (verifier_bug_if(j < 0, env, "callee not found at insn %d",
-					    i + insn[i].imm + 1))
-				return -EFAULT;
-			/*
-			 * async callbacks don't increase bpf prog stack size
-			 * unless called directly
-			 */
-			if (si[j].is_async_cb && !bpf_pseudo_call(insn + i))
-				continue;
-			__set_bit(j, subprog_calls(cg, s));
-		}
-		/* the callees of callx and the callbacks of helpers, see record_callx_edge() */
-		for (j = next_callx_callee(env, s, 0); j >= 0; j = next_callx_callee(env, s, j + 1))
-			__set_bit(j, subprog_calls(cg, s));
+		for (i = si[s].start; i < si[s + 1].start && !err; i++)
+			if (bpf_pseudo_call(insn + i) && env->insn_aux_data[i].seen)
+				err = bpf_call_graph_add(cg, s, bpf_find_subprog(env,
+							 i + insn[i].imm + 1));
+		/* the callees of callx and the callbacks of helpers */
+		for (i = si[s].callx_edge; i && !err; i = env->callx_edges[i - 1].next)
+			err = bpf_call_graph_add(cg, s, env->callx_edges[i - 1].callee);
 	}
-	memcpy(cg->reach, cg->calls, cnt * words * sizeof(long));
-	close_call_graph(cg->reach, cnt);
+	if (err)
+		return err;
+	bpf_call_graph_sort(cg, 0);
 
 	for (s = 0; s < cnt; s++)
 		if (!s || si[s].is_async_cb)
-			add_reach(cg, cg->live, s);
-	for_each_set_bit(s, cg->live, cnt) {
-		if (si[s].is_cb)
-			add_reach(cg, cg->in_cb, s);
-		if (si[s].is_async_cb)
-			add_reach(cg, cg->in_async_cb, s);
-		if (test_bit(s, subprog_reach(cg, s)))
-			add_reach(cg, cg->in_recursion, s);
-		if (si[s].has_tail_call)
-			__set_bit(s, cg->tail_calls);
-	}
+			cg->marks[s] = CG_LIVE;
+	bpf_call_graph_mark_callees(cg, CG_LIVE);
+	for_each_marked_subprog(cg, s, CG_LIVE)
+		cg->marks[s] |= (si[s].is_cb ? CG_CB | CG_IN_CB : 0) |
+				(si[s].is_async_cb ? CG_IN_ASYNC_CB : 0) |
+				(bpf_call_graph_recursive(cg, s) ? CG_IN_RECURSION : 0) |
+				(si[s].has_tail_call ? CG_TAIL_CALL : 0) |
+				(si[s].uses_arena_sp ? CG_ARENA_SP : 0) |
+				(bpf_subprog_is_global(env, s) ? CG_GLOBAL : 0);
+	bpf_call_graph_mark_callees(cg, CG_IN_CB | CG_IN_ASYNC_CB | CG_IN_RECURSION);
+	bpf_call_graph_mark_callers(cg, CG_TAIL_CALL, 0);
 	return 0;
 }
 
+static bool subprog_calls(struct bpf_call_graph *cg, u32 caller, u32 callee)
+{
+	u32 j;
+
+	bpf_for_each_callee(cg, caller, j)
+		if (j == callee)
+			return true;
+	return false;
+}
+
 /* the insn of subprog 'caller' that is the edge to subprog 'callee' */
 static int find_call_insn(struct bpf_verifier_env *env, int caller, int callee)
 {
@@ -5570,13 +5461,9 @@ static int find_call_insn(struct bpf_verifier_env *env, int caller, int callee)
 	struct bpf_insn *insn = env->prog->insnsi;
 	int i, end = si[caller + 1].start;
 
-	for (i = si[caller].start; i < end; i++) {
-		if (!bpf_pseudo_call(insn + i) &&
-		    (!bpf_pseudo_func(insn + i) || si[callee].is_async_cb))
-			continue;
-		if (i + insn[i].imm + 1 == si[callee].start)
+	for (i = si[caller].start; i < end; i++)
+		if (bpf_pseudo_call(insn + i) && i + insn[i].imm + 1 == si[callee].start)
 			return i;
-	}
 	/* It's not recorded which callx or helper calls what. Take the first one. */
 	for (i = si[caller].start; i < end - 1; i++)
 		if (bpf_is_callx(insn + i) || bpf_calls_callback(env, i))
@@ -5589,8 +5476,8 @@ static int check_exception_cb(struct bpf_verifier_env *env, struct bpf_call_grap
 {
 	int cb = env->exception_callback_subprog, s;
 
-	for_each_set_bit(s, cg->live, cg->cnt) {
-		if (!cb || !test_bit(cb, subprog_calls(cg, s)))
+	for_each_marked_subprog(cg, s, CG_LIVE) {
+		if (!cb || !subprog_calls(cg, s, cb))
 			continue;
 		verbose(env, "insn %d cannot call exception cb directly\n",
 			find_call_insn(env, s, cb));
@@ -5611,8 +5498,8 @@ static int check_recursion(struct bpf_verifier_env *env, struct bpf_call_graph *
 {
 	int j, s;
 
-	for_each_set_bit(s, cg->live, cg->cnt) {
-		if (!test_bit(s, subprog_reach(cg, s))) {
+	for_each_marked_subprog(cg, s, CG_LIVE) {
+		if (!bpf_call_graph_recursive(cg, s)) {
 			env->subprog_info[s].recursive = false;
 			continue;
 		}
@@ -5641,9 +5528,8 @@ static int check_recursion(struct bpf_verifier_env *env, struct bpf_call_graph *
 			return -EOPNOTSUPP;
 		}
 		/* the last call of the cycle */
-		for_each_set_bit(j, subprog_reach(cg, s), cg->cnt)
-			if (test_bit(s, subprog_calls(cg, j)))
-				break;
+		for (j = 0; cg->cycle[j] != cg->cycle[s] || !subprog_calls(cg, j, s); j++)
+			;
 		verbose(env, "recursive call from %s() to %s()\n",
 			bpf_subprog_name(env, j), bpf_subprog_name(env, s));
 		bpf_diag_program_structure(
@@ -5662,13 +5548,13 @@ static int check_callbacks(struct bpf_verifier_env *env, struct bpf_call_graph *
 	struct bpf_insn *insn = env->prog->insnsi;
 	int i, s;
 
-	for_each_set_bit(s, cg->in_cb, cg->cnt) {
+	for_each_marked_subprog(cg, s, CG_IN_CB) {
 		if (si[s].has_ld_abs) {
 			verbose(env, "cannot use BPF_LD_[ABS|IND] within callback\n");
 			return -EINVAL;
 		}
 		for (i = si[s].start; i < si[s + 1].start; i++) {
-			if (!bpf_is_throw_kfunc(insn + i))
+			if (!bpf_is_throw_kfunc(insn + i) || !env->insn_aux_data[i].seen)
 				continue;
 			verbose(env,
 				"bpf_throw kfunc (insn %d) cannot be called from callback subprog %d\n",
@@ -5689,9 +5575,8 @@ static int check_tail_calls(struct bpf_verifier_env *env, struct bpf_call_graph
 	struct bpf_subprog_info *si = env->subprog_info;
 	int s;
 
-	for_each_set_bit(s, cg->live, cg->cnt) {
-		if (!si[s].has_tail_call &&
-		    !bitmap_intersects(subprog_reach(cg, s), cg->tail_calls, cg->cnt))
+	for_each_marked_subprog(cg, s, CG_LIVE) {
+		if (!(cg->marks[s] & CG_TAIL_CALL))
 			continue;
 		if (si[s].is_cb) {
 			verbose(env, "cannot tail call within callback\n");
@@ -5723,32 +5608,18 @@ static int check_tail_calls(struct bpf_verifier_env *env, struct bpf_call_graph
  */
 static void mark_arena_stack_entries(struct bpf_verifier_env *env, struct bpf_call_graph *cg)
 {
-	struct bpf_subprog_info *si = env->subprog_info;
-	bool changed;
 	int s;
 
-	do {
-		changed = false;
-		for_each_set_bit(s, cg->live, cg->cnt) {
-			if (test_bit(s, cg->arena_sp) || si[s].arena_stack_entry)
-				continue;
-			if (!si[s].uses_arena_sp &&
-			    !bitmap_intersects(subprog_calls(cg, s), cg->arena_sp, cg->cnt))
-				continue;
-			if (si[s].is_cb) {
-				si[s].arena_stack_entry = true;
-				continue;
-			}
-			__set_bit(s, cg->arena_sp);
-			changed = true;
-		}
-	} while (changed);
+	bpf_call_graph_sort(cg, CG_CB);
+	bpf_call_graph_mark_callers(cg, CG_ARENA_SP, CG_CB);
+	for_each_marked_subprog(cg, s, CG_CB)
+		env->subprog_info[s].arena_stack_entry = cg->marks[s] & CG_ARENA_SP;
 }
 
 /* temporary state used for call frame depth calculation */
 struct bpf_subprog_call_depth_info {
-	int caller; /* the caller that has the most on the stack. -1: the kernel */
-	int depth; /* the most that the frames of the callers take. -1: not known yet */
+	int calls; /* the number of frames that take the most on the stack */
+	int depth; /* the most that the frames of the callers take */
 	int arena_depth; /* the same in the stack in arena */
 	int frame; /* the most consecutive static call stack frames on top of stack */
 };
@@ -5763,53 +5634,67 @@ static int subprog_stack_size(struct bpf_verifier_env *env, int s)
 	return round_up_stack_depth(env, sub->stack_depth);
 }
 
+static void max_call_depth(struct bpf_subprog_call_depth_info *to,
+			   const struct bpf_subprog_call_depth_info *from)
+{
+	if (from->depth > to->depth || !to->calls) {
+		to->depth = max(to->depth, from->depth);
+		to->calls = from->calls;
+	}
+	to->arena_depth = max(to->arena_depth, from->arena_depth);
+}
+
 /*
  * A subprog is entered with no more than what one of its callers is entered with plus
  * the frame of that caller. Not when both are recursive: the callee checks the stack at run
- * time. A cycle adds nothing, so this comes to an end.
+ * time. A cycle adds nothing: all subprogs on it have the same.
+ * The count of frames starts anew in a global subprog.
  */
 static void compute_call_depth(struct bpf_verifier_env *env, struct bpf_call_graph *cg,
 			       struct bpf_subprog_call_depth_info *dinfo)
 {
+	struct bpf_subprog_call_depth_info in, out, *callee;
 	struct bpf_subprog_info *si = env->subprog_info;
-	struct bpf_subprog_call_depth_info *callee;
-	int depth, arena_depth, frame, j, s;
-	bool changed;
-
-	for (s = 0; s < cg->cnt; s++) {
-		dinfo[s].caller = -1;
-		dinfo[s].depth = !s || si[s].is_async_cb ? 0 : -1;
-	}
-	do {
-		cond_resched();
-		changed = false;
-		for_each_set_bit(s, cg->live, cg->cnt) {
-			if (dinfo[s].depth < 0)
+	u32 start, end, i, j, s;
+	int frame;
+
+	memset(dinfo, 0, cg->cnt * sizeof(*dinfo));
+	bpf_call_graph_sort(cg, 0);
+	for (end = cg->cnt; end; end = start) {
+		start = cg->cycle[cg->order[end - 1]];
+		for (i = start, in = dinfo[cg->order[i]]; i < end; i++)
+			max_call_depth(&in, &dinfo[cg->order[i]]);
+		for (i = start; i < end; i++) {
+			s = cg->order[i];
+			if (!(cg->marks[s] & CG_LIVE))
 				continue;
-			for_each_set_bit(j, subprog_calls(cg, s), cg->cnt) {
-				callee = &dinfo[j];
-				depth = dinfo[s].depth;
-				arena_depth = dinfo[s].arena_depth;
+			bpf_for_each_callee(cg, s, j) {
+				out = in;
+				out.calls++;
 				if (!si[s].recursive || !si[j].recursive) {
-					depth += subprog_stack_size(env, s);
-					arena_depth += si[s].arena_stack_depth;
+					out.depth += subprog_stack_size(env, s);
+					out.arena_depth += si[s].arena_stack_depth;
 				}
-				frame = dinfo[s].frame + !si[j].recursive;
-				if (bpf_subprog_is_global(env, j))
-					frame = 0;
-				if (depth <= callee->depth && arena_depth <= callee->arena_depth &&
-				    frame <= callee->frame)
+				max_call_depth(&dinfo[j], &out);
+			}
+		}
+	}
+
+	bpf_call_graph_sort(cg, CG_GLOBAL);
+	for (end = cg->cnt; end; end = start) {
+		start = cg->cycle[cg->order[end - 1]];
+		for (i = start, frame = 0; i < end; i++)
+			frame = max(frame, dinfo[cg->order[i]].frame);
+		for (i = start; i < end; i++) {
+			bpf_for_each_callee(cg, cg->order[i], j) {
+				callee = &dinfo[j];
+				if (!(cg->marks[cg->order[i]] & CG_LIVE) ||
+				    (cg->marks[j] & CG_GLOBAL))
 					continue;
-				if (depth > callee->depth) {
-					callee->depth = depth;
-					callee->caller = s;
-				}
-				callee->arena_depth = max(callee->arena_depth, arena_depth);
-				callee->frame = max(callee->frame, frame);
-				changed = true;
+				callee->frame = max(callee->frame, frame + !si[j].recursive);
 			}
 		}
-	} while (changed);
+	}
 }
 
 /*
@@ -5827,7 +5712,7 @@ static int pad_recursive_frames(struct bpf_verifier_env *env, struct bpf_call_gr
 	u32 arena_frame = 0, depth = 0, room, frame;
 	int s;
 
-	for_each_set_bit(s, cg->live, cg->cnt) {
+	for_each_marked_subprog(cg, s, CG_LIVE) {
 		depth = max_t(u32, depth, dinfo[s].arena_depth + si[s].arena_stack_depth);
 		if (si[s].recursive)
 			arena_frame = max(arena_frame, si[s].arena_stack_depth);
@@ -5839,7 +5724,7 @@ static int pad_recursive_frames(struct bpf_verifier_env *env, struct bpf_call_gr
 	room = BPF_ARENA_STACK_MAX - depth - 2 * arena_frame;
 	env->max_arena_stack_depth = BPF_ARENA_STACK_MAX;
 
-	for_each_set_bit(s, cg->live, cg->cnt) {
+	for_each_marked_subprog(cg, s, CG_LIVE) {
 		if (!si[s].recursive)
 			continue;
 		frame = DIV_ROUND_UP(si[s].arena_stack_depth * (THREAD_SIZE / 2), room);
@@ -5857,7 +5742,7 @@ static int check_call_depth(struct bpf_verifier_env *env, struct bpf_call_graph
 {
 	struct bpf_subprog_info *si = env->subprog_info;
 	struct bpf_subprog_call_depth_info *dinfo;
-	int depth, total, tmp, s, err;
+	int depth, s, err;
 
 	dinfo = kvzalloc_objs(*dinfo, cg->cnt, BPF_VERIFIER_GFP);
 	if (!dinfo)
@@ -5869,7 +5754,7 @@ static int check_call_depth(struct bpf_verifier_env *env, struct bpf_call_graph
 	if (err)
 		compute_call_depth(env, cg, dinfo);
 
-	for_each_set_bit(s, cg->live, cg->cnt) {
+	for_each_marked_subprog(cg, s, CG_LIVE) {
 		/* A caller of it is over a limit. That one is reported, not what it calls. */
 		if (dinfo[s].frame > MAX_CALL_FRAMES || dinfo[s].depth > env->stack_limit ||
 		    dinfo[s].arena_depth > BPF_ARENA_STACK_MAX)
@@ -5924,7 +5809,7 @@ static int check_call_depth(struct bpf_verifier_env *env, struct bpf_call_graph
 		 */
 		depth = dinfo[s].depth;
 		/* nor of the frames of recursive subprogs, see bpf_insert_recursion_checks() */
-		si[s].in_recursion = test_bit(s, cg->in_recursion);
+		si[s].in_recursion = cg->marks[s] & CG_IN_RECURSION;
 		if (si[s].in_recursion)
 			depth += THREAD_SIZE / 2;
 		if (s && si[s].has_tail_call && depth >= 256) {
@@ -5949,12 +5834,8 @@ static int check_call_depth(struct bpf_verifier_env *env, struct bpf_call_graph
 		if (depth > env->max_stack_depth)
 			env->max_stack_depth = depth;
 		if (depth > env->stack_limit) {
-			total = 0;
-			for (tmp = s; tmp >= 0; tmp = dinfo[tmp].caller)
-				total++;
-
 			verbose(env, "combined stack size of %d calls is %d. Too large\n",
-				total, depth);
+				dinfo[s].calls + 1, depth);
 			goto out;
 		}
 	}
@@ -5999,22 +5880,16 @@ static int mark_recursive_subprogs(struct bpf_verifier_env *env)
 {
 	struct bpf_subprog_info *si = env->subprog_info;
 	struct bpf_insn *insn = env->prog->insnsi;
-	int cnt = env->subprog_cnt, words = BITS_TO_LONGS(cnt);
-	unsigned long *calls, *taken, *callx;
+	int cnt = env->subprog_cnt, i, j, s, err;
+	struct bpf_call_graph cg;
 	bool plain_callx = false;
-	int i, j, s, err = 0;
-
-	/* calls + s * words: the subprogs that s calls */
-	calls = kvcalloc((cnt + 2) * words, sizeof(long), BPF_VERIFIER_GFP);
-	if (!calls)
-		return -ENOMEM;
-	taken = calls + cnt * words;
-	callx = taken + words;
 
+	/* callx calls node 'cnt', which calls each subprog whose address is taken */
+	err = bpf_call_graph_init(&cg, cnt + 1);
 	for (s = 0; s < cnt; s++) {
-		for (i = si[s].start; i < si[s + 1].start; i++) {
+		for (i = si[s].start; i < si[s + 1].start && !err; i++) {
 			if (bpf_is_callx(&insn[i])) {
-				__set_bit(s, callx);
+				err = bpf_call_graph_add(&cg, s, cnt);
 				if (!bpf_is_unwind_goto(&insn[i + 1]))
 					plain_callx = true;
 			}
@@ -6028,8 +5903,8 @@ static int mark_recursive_subprogs(struct bpf_verifier_env *env)
 				 */
 				if (!j && bpf_pseudo_call(&insn[i])) {
 					verbose(env, "recursive call of the main program\n");
-					kvfree(calls);
-					return -EINVAL;
+					err = -EINVAL;
+					goto out;
 				}
 				/* the helper that calls a callback doesn't expect it to unwind */
 				if (bpf_pseudo_func(&insn[i]) || !bpf_is_unwind_goto(&insn[i + 1]))
@@ -6040,9 +5915,9 @@ static int mark_recursive_subprogs(struct bpf_verifier_env *env)
 				 */
 				if (bpf_pseudo_call(&insn[i]) ||
 				    !func_is_kept_for_later(env, i, si[s + 1].start))
-					__set_bit(j, calls + s * words);
+					err = bpf_call_graph_add(&cg, s, j);
 				if (bpf_pseudo_func(&insn[i]))
-					__set_bit(j, taken);
+					si[j].addr_taken = true;
 			}
 			if (bpf_is_ldimm64(&insn[i]))
 				i++;
@@ -6051,19 +5926,20 @@ static int mark_recursive_subprogs(struct bpf_verifier_env *env)
 	for (i = 0; i < env->func_ptr_cnt; i++) {
 		j = bpf_find_subprog(env, env->func_ptrs[i].xlated_off);
 		if (j >= 0)
-			__set_bit(j, taken);
+			si[j].addr_taken = true;
 	}
-	for_each_set_bit(s, callx, cnt)
-		bitmap_or(calls + s * words, calls + s * words, taken, cnt);
-	for_each_set_bit(s, taken, cnt)
-		si[s].addr_taken = true;
+	for (s = 0; s < cnt && !err; s++)
+		if (si[s].addr_taken)
+			err = bpf_call_graph_add(&cg, cnt, s);
+	if (err)
+		goto out;
 
 	/*
 	 * Callers of a global subprog look at can_unwind before the subprog is verified.
 	 * The main prog returns to the kernel.
 	 */
 	for (s = 0; s < cnt; s++) {
-		if (plain_callx && test_bit(s, taken))
+		if (plain_callx && si[s].addr_taken)
 			si[s].plain_call = true;
 		si[s].bail_unwinds = si[s].can_unwind ||
 				     (s && !si[s].plain_call && !bpf_subprog_is_global(env, s) &&
@@ -6071,10 +5947,10 @@ static int mark_recursive_subprogs(struct bpf_verifier_env *env)
 				      !bpf_prog_is_offloaded(env->prog->aux));
 	}
 
-	close_call_graph(calls, cnt);
+	bpf_call_graph_sort(&cg, 0);
 
 	for (s = 0; s < cnt; s++) {
-		if (!test_bit(s, calls + s * words))
+		if (!bpf_call_graph_recursive(&cg, s))
 			continue;
 		err = -EINVAL;
 		if (!s) {
@@ -6107,7 +5983,8 @@ static int mark_recursive_subprogs(struct bpf_verifier_env *env)
 		si[s].recursive = true;
 		err = 0;
 	}
-	kvfree(calls);
+out:
+	bpf_call_graph_free(&cg);
 	return err;
 }
 
@@ -6115,9 +5992,10 @@ static int check_max_stack_depth(struct bpf_verifier_env *env)
 {
 	enum priv_stack_mode priv_stack_mode = PRIV_STACK_UNKNOWN;
 	struct bpf_subprog_info *si = env->subprog_info;
-	struct bpf_call_graph cg = {};
+	struct bpf_call_graph cg;
 	int s, ret;
 
+	find_subprog_properties(env, true);
 	for (int i = 0; i < env->subprog_cnt; i++) {
 		if (si[i].has_tail_call) {
 			/* the stack in arena wouldn't be returned */
@@ -6146,7 +6024,7 @@ static int check_max_stack_depth(struct bpf_verifier_env *env)
 		goto out;
 	mark_arena_stack_entries(env, &cg);
 
-	for_each_set_bit(s, cg.live, cg.cnt) {
+	for_each_marked_subprog(&cg, s, CG_LIVE) {
 		/*
 		 * All async_cb subprogs use normal kernel stack. If a particular
 		 * subprog appears in both main prog and async_cb subtree, that
@@ -6154,7 +6032,7 @@ static int check_max_stack_depth(struct bpf_verifier_env *env)
 		 * The private stack has room for one frame of a subprog.
 		 * x86-64 uses R9 for both private stack frame pointer and arg6.
 		 */
-		if (priv_stack_mode != PRIV_STACK_ADAPTIVE || test_bit(s, cg.in_async_cb) ||
+		if (priv_stack_mode != PRIV_STACK_ADAPTIVE || (cg.marks[s] & CG_IN_ASYNC_CB) ||
 		    si[s].recursive || (IS_ENABLED(CONFIG_X86_64) && si[s].stack_arg_cnt)) {
 			si[s].priv_stack_mode = NO_PRIV_STACK;
 			continue;
@@ -6172,7 +6050,7 @@ static int check_max_stack_depth(struct bpf_verifier_env *env)
 
 	ret = check_call_depth(env, &cg);
 out:
-	kvfree(cg.calls);
+	bpf_call_graph_free(&cg);
 	return ret;
 }
 
@@ -25199,7 +25077,7 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr,
 	if (ret < 0)
 		goto skip_full_check;
 
-	find_subprog_properties(env);
+	find_subprog_properties(env, false);
 
 	/* Validate BTF before reporting subprogram layout errors. */
 	ret = bpf_check_btf_info(env, attr, uattr);
@@ -25478,6 +25356,7 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr,
 	kvfree(env->succ);
 	kvfree(env->gotox_tmp_buf);
 	kvfree(env->callx_edges);
+	kvfree(env->callx_index.slots);
 	kvfree(env->func_ptrs);
 	for (i = 0; i < env->func_set_cnt; i++)
 		kvfree(env->func_sets[i]);
diff --git a/tools/testing/selftests/bpf/progs/test_global_func_deep_stack.c b/tools/testing/selftests/bpf/progs/test_global_func_deep_stack.c
index 11af79aa2ced..2a763f6db693 100644
--- a/tools/testing/selftests/bpf/progs/test_global_func_deep_stack.c
+++ b/tools/testing/selftests/bpf/progs/test_global_func_deep_stack.c
@@ -125,7 +125,8 @@ int global_func_many_chains(void *ctx)
 
 /*
  * r1 is the number of calls that follow, so main -> fs15 .. fs0 and main -> fs31 .. fs16
- * are executed: 17 frames each. main -> fs31 .. fs0 is in the call graph: 33 frames.
+ * are executed: 17 frames each. With main -> fs16 -> fs15 no call is dead code, and
+ * main -> fs31 .. fs0 is in the call graph: 33 frames.
  * libbpf puts fs15() .. fs0() in front of their second caller fs16().
  */
 #undef F_0
@@ -138,6 +139,15 @@ SEC("syscall")
 __failure __msg("the call stack of 32 frames is too deep !")
 __load_if_JITed()
 __naked int static_func_deep_stack_second_caller(void)
+{
+	asm volatile ("r1 = 15; call fs15; r1 = 15; call fs31; r1 = 1; call fs16; exit;"
+		      ::: __clobber_all);
+}
+
+SEC("syscall")
+__success
+__load_if_JITed()
+__naked int static_func_deep_stack_dead_call(void)
 {
 	asm volatile ("r1 = 15; call fs15; r1 = 15; call fs31; exit;" ::: __clobber_all);
 }
diff --git a/tools/testing/selftests/bpf/progs/verifier_tailcall.c b/tools/testing/selftests/bpf/progs/verifier_tailcall.c
index 81be4ef8c321..a272795781e4 100644
--- a/tools/testing/selftests/bpf/progs/verifier_tailcall.c
+++ b/tools/testing/selftests/bpf/progs/verifier_tailcall.c
@@ -137,8 +137,8 @@ int exception_cb_tail_call(__u64 cookie)
 }
 
 SEC("tc")
-__description("tail call in an async callback that calls nothing")
-__failure __msg("cannot tail call within callback")
+__description("dead tail call in an async callback")
+__success
 __attribute__((btf_decl_tag("exception_callback:exception_cb_tail_call")))
 __naked void tail_call_in_async_callback(void)
 {
diff --git a/tools/testing/selftests/bpf/verifier/calls.c b/tools/testing/selftests/bpf/verifier/calls.c
index bb2b9e8c71df..5357d667fa04 100644
--- a/tools/testing/selftests/bpf/verifier/calls.c
+++ b/tools/testing/selftests/bpf/verifier/calls.c
@@ -1526,8 +1526,7 @@
 	},
 	.prog_type = BPF_PROG_TYPE_XDP,
 	.flags = F_NEEDS_JIT_ENABLED,
-	.errstr = "call stack",
-	.result = REJECT,
+	.result = ACCEPT,
 },
 {
 	"calls: spill into caller stack frame",
-- 
2.55.0

