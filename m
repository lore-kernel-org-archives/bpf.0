Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794808688;
	b=eudxXYd6NcU1f13hux3BgNND30AZgYiAPLxwBUcDQCXV4YSQTiIYazoJZTJyMbh6g2FQ
	 ABjdzanEA1EadsNYREoSP8QAxWxUn/GU04SADaaZBGhkq+XDJvmc+8LB/TXBLdoLtGIfv
	 rl/lU6nRfmC9fR/Whb+j5+mgCCzJNvWGHqAk1yZGsLMEZAFNebIpu1Ww1BR77YxwL+rlC
	 KeAv+L19g+ZbqijX4amUIrqyUkSSuBsJMVapKTJdf5pyI88qWnbATwYAHyiybXdoZWnyp
	 anU/rz26fEjKfOE6TERQ1bcpbtqcUto1+zqUhik8TNWHTznNFZAf1cf0jj8NLEzbDLQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794808688;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=bzEzdrMBAdAn4aCN2ggNG0RHZSrLmZSSxRCjn/cbF2w=;
	b=Otzsk2dUqhSlHAiOjgy3EVlC+iq7OuLPplR3uv/xDpXIWMaAjdkqF+3WhNaeAnbJxycL
	 U4WJ717QDD89cCdRg4opIwDZViMKC/RT0lW2/lBfdqQulV73n4cQvb8PvW3kDeJ3AlUEY
	 BxgVHMDVFcY+Vaa4iJD+4N1wLHLmSktf2VOJApi/XSRy6VZnTPOHCZH99iS6P/zGPRPuB
	 ovgR8cNWhS1XIXeLwhD/WBlNHPjLyvxIF5hED4uX43Bj8VSawVS6WcT3XSqt1roHz75d5
	 4fJ8MpcJUVUwt5SQ3N+xe4R8Dt/bHPEAk0ZMHeQaU9ZTzjA2Td+0BRP0GPVMVOmnfzQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OBYuKTmK;
	arc=none smtp.remote-ip=209.85.216.48
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60E72606A323
	for <bpf@vger.kernel.org>; Mon, 16 Nov 2026 05:58:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 60E72606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OBYuKTmK
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-3ae691283ecso1472744a91.0
        for <bpf@vger.kernel.org>; Sun, 15 Nov 2026 21:58:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794808688; x=1795413488; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bzEzdrMBAdAn4aCN2ggNG0RHZSrLmZSSxRCjn/cbF2w=;
        b=OBYuKTmKadzIQC2slzPLUQCSy8tkJT87njbHMQw9KyzHUsW7CTY0ilWBYXTIKnSvjA
         kUny4R1oQYJ1+dytC5apUqzNWuBfkJKh/rMc4DCqjXaxpJwkV65Ncrz563Inxhg2bwbo
         KtJa3qdjjsDJgLxtb/VVVeWjVw1d9Av7TbhXKev+TUx/KzfAJPCSNihNwthBFgZxZz6E
         jqtYEY8p4kldbPPCKh6flCfhBdg9diX06k9QR3UodjtEfbogPKD9CAwfnG6dw9mItc9L
         cmL5e/eHtddi3CyZT8Cc/fXvfh3bMNs0XWocsgattH7vmWzhVlIBdIiUrcWdU/dcN8mC
         KkuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794808688; x=1795413488;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=bzEzdrMBAdAn4aCN2ggNG0RHZSrLmZSSxRCjn/cbF2w=;
        b=RDcq/eqvSdSkHgEQqHDYns/ap+HMJ5sRar649tUOnB7ep3aKV387pJMxph+o6a3F90
         heWwt2el8/m3uWSCKYF4H6JP7JK2cN6JnUwLeykNDdMYBdWbTMY+G/Yq2ih82MwU1PcC
         +DUCIin/Uz3zRT1uKuVgqKsmZz1+fUM0dEzRnoixO0YB360SiaNyMyQikDwETcdeMyq3
         RfVY6CW3/rpvQre2ssgdKznykLuOx2axJbhgu4rU+sM1iIIQZKVmCrsToxDABtUl47nA
         r+2ymt8eNKr+GeJYc+kPvUJRFTU4AYJvTMCyMtoPmX+F/XtkYmSLTRGNFygTHwJPZyAp
         bm9w==
X-Gm-Message-State: APuU4Z+/ngAaiunfbW4G75lndlvdiDXj46RtaE6+7gBEiWIjZoH6JrXf
	AIwFV4VJ1l3nrrfsCQe1MwHnW+Vt1gcJqqb1ioMXb0o1Le+MLnUI17Coj4xXAg==
X-Gm-Gg: AZFdTZeV9ipDvE21n//WXr2TOBZStBfjJUXF5wCeDNWgKL3KtRjdgIoHalpdEX0rw3x
	a7lnKMtpFxn4tPMxCZKuNCgZJ+AIKS4BOMUD6C4DBG9T/J1Ec5jPjf1KDFCur7JZLwCXf8px6RT
	eSdG8Bg//mzi0zCuihNyzKqQ+YLFUmYkaOQc9cQc0Oxy2RBBuq3+F8EMgK08wOD1TedY0WB/GjG
	cS8URWQCJyCK5gCcRorJe96bkmK7LKG2/nSKo9GV4SSBCm/98dVYKxykwjMRiflfDJpBsnVDubE
	F3SaNkq5qL+lWZMEP7Ch00mrA8QNzPKUIKcalMud6oq4jv9O70lGG/JmrJLBrErK56fdQzIOwcg
	KuAxlCqjbvKRu95Te0WSqj7j/Q0eAMRAKagXIpfjcqDlURax9ETywO2vEcRBZyJww4/rJLjifdU
	dnbLg9FMjsd5OCvQVbp+xtS+sneJslL1DeQZ+mi0sjau/AzPlff9S/EOjZi+NNiBoifsIf9k06w
	tpge3FoSd2S8FyQTbx63R9BMq1+BDT3bCZzid0+xmOl+M1Xy3WbCoR1ZFQRKgVsC/fENR7nUaqs
	Idfl/7RaHYyRdtXilmSLZoXzNa80iDf+Iw6riGnkdCa7ptiM/cmfgVCtpcWW/jfVliToA4fohev
	0Xu3axvbMwWVQ5l4Xqp/P6q7Y6tI1xD8CkHxhwr3NMkoheKMhJkd2/9CKsuyUHeNyacyRUYvaqm
	M5BEqWWGmQS4nJbVQHpo8=
X-Received: by 2002:a17:90b:33c4:b0:3ac:3cdc:49c3 with SMTP id 98e67ed59e1d1-3b197d547a6mr9310258a91.21.1794808687387;
        Sun, 15 Nov 2026 21:58:07 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.240])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cddc1889960sm3809023a12.15.2026.11.15.21.58.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Nov 2026 21:58:06 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next 14/21] bpf: Find the effects of callees on the call graph
Date: Mon, 16 Nov 2026 05:56:31 +0000
Message-ID: <20261116055638.4171529-15-alexei.starovoitov@gmail.com>
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

Each load of the address of a table of functions walks all its pointers,
again after each function that the walk finds, and again in each round
of close_callee_effects(). 1000 loads of a table of 128K pointers take
a minute.

Make the map one node of the call graph:

  f1: r1 = map ll  --+
                     +--> node of the map --> all functions in the map
  f2: r1 = map ll  --+

The functions that maps point to are roots of the walk of the cfg, like
the exception callback.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/cfg.c | 240 +++++++++++++++--------------------------------
 1 file changed, 75 insertions(+), 165 deletions(-)

diff --git a/kernel/bpf/cfg.c b/kernel/bpf/cfg.c
index 07412c0b9d30..6bab58797685 100644
--- a/kernel/bpf/cfg.c
+++ b/kernel/bpf/cfg.c
@@ -52,54 +52,6 @@ enum {
 	BRANCH = 2,
 };
 
-static void mark_subprog_changes_pkt_data(struct bpf_verifier_env *env, int off)
-{
-	struct bpf_subprog_info *subprog;
-
-	subprog = bpf_find_containing_subprog(env, off);
-	subprog->changes_pkt_data = true;
-}
-
-static void mark_subprog_might_sleep(struct bpf_verifier_env *env, int off)
-{
-	struct bpf_subprog_info *subprog;
-
-	subprog = bpf_find_containing_subprog(env, off);
-	subprog->might_sleep = true;
-}
-
-static void mark_subprog_might_throw(struct bpf_verifier_env *env, int off)
-{
-	struct bpf_subprog_info *subprog;
-
-	subprog = bpf_find_containing_subprog(env, off);
-	subprog->might_throw = true;
-}
-
-/*
- * 't' is an index of a call-site.
- * 'w' is a callee entry point.
- * Eventually this function would be called when env->cfg.insn_state[w] == EXPLORED.
- * DFS traversal order guarantees that callee's effect marks are correct at that
- * moment, unless the callee calls one of its callers: see close_callee_effects().
- * Returns true if the marks of the caller changed.
- */
-static bool merge_callee_effects(struct bpf_verifier_env *env, int t, int w)
-{
-	struct bpf_subprog_info *caller, *callee;
-
-	caller = bpf_find_containing_subprog(env, t);
-	callee = bpf_find_containing_subprog(env, w);
-	if (caller->changes_pkt_data >= callee->changes_pkt_data &&
-	    caller->might_sleep >= callee->might_sleep &&
-	    caller->might_throw >= callee->might_throw)
-		return false;
-	caller->changes_pkt_data |= callee->changes_pkt_data;
-	caller->might_sleep |= callee->might_sleep;
-	caller->might_throw |= callee->might_throw;
-	return true;
-}
-
 enum {
 	DONE_EXPLORING = 0,
 	KEEP_EXPLORING = 1,
@@ -169,19 +121,13 @@ static int visit_func_call_insn(int t, struct bpf_insn *insns,
 				bool visit_callee)
 {
 	int ret, insn_sz;
-	int w;
 
 	insn_sz = bpf_is_ldimm64(&insns[t]) ? 2 : 1;
 	ret = push_insn(t, t + insn_sz, FALLTHROUGH, env);
 	if (ret)
 		return ret;
 
-	if (visit_callee) {
-		w = t + insns[t].imm + 1;
-		merge_callee_effects(env, t, w);
-		ret = push_insn(t, w, BRANCH, env);
-	}
-	return ret;
+	return visit_callee ? push_insn(t, t + insns[t].imm + 1, BRANCH, env) : 0;
 }
 
 struct bpf_iarray *bpf_iarray_realloc(struct bpf_iarray *old, size_t n_elem)
@@ -628,98 +574,63 @@ static int visit_gotox_insn(int t, struct bpf_verifier_env *env)
 	return keep_exploring ? KEEP_EXPLORING : DONE_EXPLORING;
 }
 
-/*
- * Return pointers to functions in the read-only map that ld_imm64 instruction
- * 't' loads the address of, or of its value, if there are any.
- */
-static struct bpf_func_ptr *insn_func_ptrs(struct bpf_verifier_env *env, int t, u32 *cnt)
-{
-	struct bpf_insn *insn = &env->prog->insnsi[t];
-
-	*cnt = 0;
-	if (!env->func_ptr_cnt || !bpf_is_ldimm64(insn))
-		return NULL;
-	if (insn->src_reg != BPF_PSEUDO_MAP_VALUE &&
-	    insn->src_reg != BPF_PSEUDO_MAP_IDX_VALUE &&
-	    insn->src_reg != BPF_PSEUDO_MAP_FD &&
-	    insn->src_reg != BPF_PSEUDO_MAP_IDX)
-		return NULL;
-
-	return bpf_map_func_ptrs(env, env->used_maps[env->insn_aux_data[t].map_index], cnt);
-}
-
-/*
- * ld_imm64 that loads the address of a map that has pointers to functions
- * is similar to ld_imm64 with BPF_PSEUDO_FUNC that loads the address of one
- * function: any of them may be read from the map and called via callx later.
- * Treat it as a call of all of them.
- */
-static int visit_func_ptrs_insn(int t, struct bpf_verifier_env *env,
-				struct bpf_func_ptr *ptrs, u32 cnt)
-{
-	int *insn_stack = env->cfg.insn_stack;
-	int *insn_state = env->cfg.insn_state;
-	int ret, w;
-	u32 i;
-
-	ret = push_insn(t, t + 2, FALLTHROUGH, env);
-	if (ret)
-		return ret;
-
-	/*
-	 * Explore one function at a time like push_insn() does, so that
-	 * DISCOVERED function is a caller of 't' and not the one that waits in
-	 * insn_stack[], which merge_callee_effects() relies on.
-	 */
-	for (i = 0; i < cnt; i++) {
-		w = ptrs[i].xlated_off;
-		if (insn_state[w])
-			continue;
-
-		if (env->cfg.cur_stack >= env->prog->len)
-			return -E2BIG;
-
-		insn_stack[env->cfg.cur_stack++] = w;
-		insn_state[w] = DISCOVERED;
-		return KEEP_EXPLORING;
-	}
-
-	/* all functions are explored, their effects are known */
-	for (i = 0; i < cnt; i++) {
-		w = ptrs[i].xlated_off;
-		merge_callee_effects(env, t, w);
-
-		/* the same mark as push_insn() leaves on a branch target */
-		mark_jump_target(env, w);
-	}
-	return DONE_EXPLORING;
-}
+enum {
+	CHANGES_PKT_DATA = BIT(0),
+	MIGHT_SLEEP	 = BIT(1),
+	MIGHT_THROW	 = BIT(2),
+};
 
 /*
- * A subprog that calls one of its callers is EXPLORED before that caller is: it
- * took the marks that the caller had so far, and so did everybody who called it
- * since. Merge again at every call until nothing changes.
+ * A subprog does what its callees do. The load of the address of a function counts as a call.
+ * So does the load of the address of a map with pointers to functions:
+ *
+ *   f1: r1 = map ll  --+
+ *                      +--> node of the map --> all functions in the map
+ *   f2: r1 = map ll  --+
  */
-static void close_callee_effects(struct bpf_verifier_env *env)
+static int merge_callee_effects(struct bpf_verifier_env *env)
 {
+	struct bpf_subprog_info *si = env->subprog_info;
 	struct bpf_insn *insn = env->prog->insnsi;
-	struct bpf_func_ptr *ptrs;
-	bool changed;
-	u32 cnt, j;
-	int t;
-
-	do {
-		changed = false;
-		for (t = 0; t < env->prog->len; t++) {
+	u32 cnt = env->subprog_cnt, n, s, t;
+	struct bpf_call_graph cg;
+	struct bpf_func_ptr *ptr;
+	int err;
+
+	err = bpf_call_graph_init(&cg, cnt + env->used_map_cnt);
+	for (s = 0; s < cnt && !err; s++) {
+		cg.marks[s] = (si[s].changes_pkt_data ? CHANGES_PKT_DATA : 0) |
+			      (si[s].might_sleep ? MIGHT_SLEEP : 0) |
+			      (si[s].might_throw ? MIGHT_THROW : 0);
+		for (t = si[s].start; t < si[s + 1].start && !err; t++) {
 			if (bpf_pseudo_call(&insn[t]) || bpf_pseudo_func(&insn[t]))
-				changed |= merge_callee_effects(env, t, t + insn[t].imm + 1);
-			ptrs = insn_func_ptrs(env, t, &cnt);
-			for (j = 0; j < cnt; j++)
-				changed |= merge_callee_effects(env, t, ptrs[j].xlated_off);
-			if (bpf_is_ldimm64(&insn[t]))
-				t++;
+				err = bpf_call_graph_add(&cg, s, bpf_find_subprog(env,
+							 t + insn[t].imm + 1));
+			else if (bpf_is_ldimm64(&insn[t]) && insn[t].src_reg &&
+				 insn[t].src_reg != BPF_PSEUDO_BTF_ID)
+				err = bpf_call_graph_add(&cg, s,
+							 cnt + env->insn_aux_data[t].map_index);
 		}
-	} while (changed);
+	}
+	for (s = 0; s < env->used_map_cnt; s++) {
+		ptr = bpf_map_func_ptrs(env, env->used_maps[s], &n);
+		for (; n-- && !err; ptr++)
+			err = bpf_must_abort() ? -EINTR :
+			      bpf_call_graph_add(&cg, cnt + s,
+						 bpf_find_subprog(env, ptr->xlated_off));
+	}
+	if (err)
+		goto out;
+	bpf_call_graph_sort(&cg, 0);
+	bpf_call_graph_mark_callers(&cg, U16_MAX, 0);
+	for (s = 0; s < cnt; s++) {
+		si[s].changes_pkt_data = cg.marks[s] & CHANGES_PKT_DATA;
+		si[s].might_sleep = cg.marks[s] & MIGHT_SLEEP;
+		si[s].might_throw = cg.marks[s] & MIGHT_THROW;
+	}
+out:
+	bpf_call_graph_free(&cg);
+	return err;
 }
 
 /* Visits the instruction at index t and returns one of the following:
@@ -730,17 +641,12 @@ static void close_callee_effects(struct bpf_verifier_env *env)
 static int visit_insn(int t, struct bpf_verifier_env *env)
 {
 	struct bpf_insn *insns = env->prog->insnsi, *insn = &insns[t];
-	struct bpf_func_ptr *ptrs;
+	struct bpf_subprog_info *sub;
 	int ret, off, insn_sz;
-	u32 cnt;
 
 	if (bpf_pseudo_func(insn))
 		return visit_func_call_insn(t, insns, env, true);
 
-	ptrs = insn_func_ptrs(env, t, &cnt);
-	if (ptrs)
-		return visit_func_ptrs_insn(t, env, ptrs, cnt);
-
 	/* All non-branch instructions have a single fall-through edge. */
 	if (BPF_CLASS(insn->code) != BPF_JMP &&
 	    BPF_CLASS(insn->code) != BPF_JMP32) {
@@ -760,6 +666,7 @@ static int visit_insn(int t, struct bpf_verifier_env *env)
 		 */
 		if (bpf_is_sync_callback_calling_insn(insn))
 			mark_calls_callback(env, t);
+		sub = bpf_find_containing_subprog(env, t);
 		if (bpf_helper_call(insn)) {
 			const struct bpf_func_proto *fp;
 
@@ -770,11 +677,11 @@ static int visit_insn(int t, struct bpf_verifier_env *env)
 			 * elimination.
 			 */
 			if (ret == 0 && fp->might_sleep)
-				mark_subprog_might_sleep(env, t);
+				sub->might_sleep = true;
 			/* nobody knows yet whether the dynptr is that of an skb */
 			if (bpf_helper_changes_pkt_data(insn->imm) ||
 			    insn->imm == BPF_FUNC_dynptr_write)
-				mark_subprog_changes_pkt_data(env, t);
+				sub->changes_pkt_data = true;
 		} else if (insn->src_reg == BPF_PSEUDO_KFUNC_CALL) {
 			struct bpf_call_arg_meta meta;
 
@@ -785,11 +692,11 @@ static int visit_insn(int t, struct bpf_verifier_env *env)
 			 * dead code elimination.
 			 */
 			if (ret == 0 && bpf_is_kfunc_sleepable(&meta))
-				mark_subprog_might_sleep(env, t);
+				sub->might_sleep = true;
 			if (ret == 0 && bpf_is_kfunc_pkt_changing(&meta))
-				mark_subprog_changes_pkt_data(env, t);
+				sub->changes_pkt_data = true;
 			if (ret == 0 && bpf_is_throw_kfunc(insn))
-				mark_subprog_might_throw(env, t);
+				sub->might_throw = true;
 		}
 		return visit_func_call_insn(t, insns, env, insn->src_reg == BPF_PSEUDO_CALL);
 
@@ -828,7 +735,8 @@ int bpf_check_cfg(struct bpf_verifier_env *env)
 {
 	int insn_cnt = env->prog->len;
 	int *insn_stack, *insn_state;
-	int ex_insn_beg, i, ret = 0;
+	int i, root, ret = 0;
+	u32 ptr = 0;
 
 	insn_state = env->cfg.insn_state = kvzalloc_objs(int, insn_cnt,
 							 BPF_VERIFIER_GFP);
@@ -842,15 +750,12 @@ int bpf_check_cfg(struct bpf_verifier_env *env)
 		return -ENOMEM;
 	}
 
-	ex_insn_beg = env->exception_callback_subprog
-		      ? env->subprog_info[env->exception_callback_subprog].start
-		      : 0;
-
-	insn_state[0] = DISCOVERED; /* mark 1st insn as discovered */
-	insn_stack[0] = 0; /* 0 is the first instruction */
+	root = 0; /* 0 is the first instruction */
+walk_cfg:
+	insn_state[root] = DISCOVERED;
+	insn_stack[0] = root;
 	env->cfg.cur_stack = 1;
 
-walk_cfg:
 	while (env->cfg.cur_stack > 0) {
 		int t = insn_stack[env->cfg.cur_stack - 1];
 
@@ -877,11 +782,16 @@ int bpf_check_cfg(struct bpf_verifier_env *env)
 		goto err_free;
 	}
 
-	if (ex_insn_beg && insn_state[ex_insn_beg] != EXPLORED) {
-		insn_state[ex_insn_beg] = DISCOVERED;
-		insn_stack[0] = ex_insn_beg;
-		env->cfg.cur_stack = 1;
+	root = env->subprog_info[env->exception_callback_subprog].start;
+	if (insn_state[root] != EXPLORED)
 		goto walk_cfg;
+
+	/* callx can call what the maps point to */
+	while (ptr < env->func_ptr_cnt) {
+		root = env->func_ptrs[ptr++].xlated_off;
+		mark_jump_target(env, root);
+		if (insn_state[root] != EXPLORED)
+			goto walk_cfg;
 	}
 
 	for (i = 0; i < insn_cnt; i++) {
@@ -910,8 +820,8 @@ int bpf_check_cfg(struct bpf_verifier_env *env)
 			i++; /* skip second half of ldimm64 */
 		}
 	}
-	ret = 0; /* cfg looks good */
-	close_callee_effects(env);
+	/* cfg looks good */
+	ret = merge_callee_effects(env);
 	env->prog->aux->changes_pkt_data = env->subprog_info[0].changes_pkt_data;
 	env->prog->aux->might_sleep = env->subprog_info[0].might_sleep;
 
-- 
2.55.0

