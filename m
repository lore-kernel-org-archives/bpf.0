Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794842879;
	b=oNyJPNeQJ/IH1vIrUB11qmPDNo4xsgVTBzMmSoGMK9zvGgcZFwMdfMipgmYPFbevfJDE
	 alp42xFl4i+MC3aGoBwQ5dO/FiTA16MgIn8AM0LfWypJv3HunMpBxl30zqsN/yMwfAejS
	 fHvp7tW5AgLxtVg7L977NYB5WcRtOFTjBBs7MoKp7mgqoimVk4xKdO89s6Dq3Vfu1lV66
	 ZmPufUSXHm40oR3qDlrgJtQzXoFYv7MZLuURebA3Jr7yiY9hmqiLGixGMFB5DcaaKWhgs
	 5zva8kPCaFom/lS33D3wYPwE/zTks5a1tS0ChOVxaT2u1XijKVTcNezzZPG72jm3tQQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794842879;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=bzEzdrMBAdAn4aCN2ggNG0RHZSrLmZSSxRCjn/cbF2w=;
	b=nn2+Wy+5lmokvyyyrhJbJ6nTKci/F4KBOH2g1cFy0YMvdVKsKHvZFTYAcccajZOSi1dK
	 yj1Z07zi3PrG4xOMOBx0x8fxuDLILPHpDQA4PRZs4ebGv3xlXQ6KfkiFpoLuyexQiVUYr
	 JCJY3npT+xfcjY2cCepNGEAjlnvsoiZPJ1KTGvQhD817JljyAydg/KAbybGN782314jUl
	 hp6NKYM63AqK38LIfhHEABHsxRn23Bq3s+0ISPkkITNQejyEfb7onJmSE07ep4maKoV44
	 W6mkRJev47U1gkxfRT7ouV7IPBXIh9cuqQ/VdVRZMB2anpfZi+NMqBu3+M4lCPUCrbQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SGEkXi1K;
	arc=none smtp.remote-ip=209.85.210.173
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED672606A335
	for <bpf@vger.kernel.org>; Mon, 16 Nov 2026 15:27:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ED672606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SGEkXi1K
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-8b6399ebb41so4041221b3a.0
        for <bpf@vger.kernel.org>; Mon, 16 Nov 2026 07:27:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794842878; x=1795447678; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bzEzdrMBAdAn4aCN2ggNG0RHZSrLmZSSxRCjn/cbF2w=;
        b=SGEkXi1KUErKD/YxygEc2Pj+lci70xo/moO6GfaNrXLxf1Cd9M5GAGHnUPZ/4wMKEe
         dAgy/ihDBNMvM9aOT9q8m6+a3mMPH2VjwUF/TshR+ss22P4pVtxQUG1X4US02shudqMT
         6s4NyIpzvo+Yd471P5vrPttwo4hW6JR9Z4xKVfdZ8hSav2hEWyuzqkS8dUCbrXBLuBXe
         ZwJllxfzBP28fBgA2sypGgR3BtAFALQq8ntkkoZ5/cK2sX5yy07gDks+ap0bEtcYw6MW
         GxhMyeS15fESHskfelEhR8ljg1FShoejjeCBw3+pnrEpAIijXnC27ZpMUshtbIhW2IpS
         CgeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794842878; x=1795447678;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=bzEzdrMBAdAn4aCN2ggNG0RHZSrLmZSSxRCjn/cbF2w=;
        b=gXQvsKNXXIz1v2M/rarOeAYKmSWCljvLhiAoallKvYb8ehxnQWCytxdq8XvGQCdpMu
         Jzigt58IYcVThvOl6VOh52woI6iCu6UBJUJgQvTiDeNZDJXscMvsO/0+uJvDiJM882nd
         4yZFKx6SJ/4Qd7zQzPdo0mMx+fD1REwzo1dKV/3PedeY5Vbkp6TqsYuSf20GCxeehBg6
         APBird1s6UYUgqNhMaVxLyDAeRBK8wtfKpN3LLlYeulAF8RfaO3nJQUcWeaaOgA90ocL
         Ra/dAl99DzK9xqdcix4kBEMe18boJ5yvamitcrWq3c1WdRnOoZGCjVAh6UclvOLyYK1F
         HvuA==
X-Gm-Message-State: APuU4Z/vv7ZWaJsFoEilm20+dqfeor2W1YL0MXLWZdm3SWeGH/e4SsCY
	3/0dNxH1PEsb/j6yF0YAGmKCEjZciDbT3hO+bkJSpZqmkGuDWZ5JF2pdzKj42w==
X-Gm-Gg: AYBFou3CRl/TvdHnh4EaLUjIQzo8xrTHvHcf34h3649jk9yYTJAqiClfCKdbYIsTI1s
	Kkc9ryPkS5CxHUlsCZ4uNSxP4hxugu+iHzXB0gB6oLnEE31kSittH58063fe6cQGYevtLgDBZe9
	4KWL3ZNRTE7mnUqLAYodH2dbBq3YfQGPDSoy/NZ71TJUjF7ZzOOlqNkAvNEpUzVVog9takEqsZ3
	ViV7KDzsxP60kTKrf6NlAemT63tlM40IurkDAP0fVHK0bcQPtWTg3rV9QqVX4H+03VzH8nFOILg
	HZjtzcpR/hObbA7yee3pbNklCU6EZupugSiEd5C2nOy2XOS8TdPoYu2DL0yt5fMU91G5iVDoYJ9
	LE9exGM2gQ2owfpjxAkC1KUj00APqfWOygNlXsUqbq6eEYWdPBkYUUsa0wCwp7/CTUzjJkO/fDI
	AWVBLE8KNKU0e2pe7E2ClzIkf9CR48Wfypcpl/Raaac9REgndTnDYaOL44UbidzwwT15qJ507Oy
	zp3Jq4m4tPNk2Z5L3JIT1iROt86P1EuVTjAvvNGGdk280Zgv64DS4T2ImEoYYOpk2MT2zVLqLWW
	5eiAnnJVkzNJIIwQyAlO4O4If0AHA3Oy7/QvGKYifIwu3cLRqWX0JlJIsqVTotYRxPkCdkUbB/h
	kaXWMYXVdkhLnZTVjRBeVQMOF98PFiTPg0qgSA81PB0WpQK0FOCR1cK0zGPL1W9itt26BZxvlRg
	==
X-Received: by 2002:a05:6a21:7a43:b0:3f9:ceaa:90e with SMTP id adf61e73a8af0-3f9ceaa3c4amr6606934637.23.1794842877860;
        Mon, 16 Nov 2026 07:27:57 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.244])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8bececcca91sm3880769b3a.7.2026.11.16.07.27.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 07:27:56 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next v2 14/21] bpf: Find the effects of callees on the call graph
Date: Mon, 16 Nov 2026 15:26:19 +0000
Message-ID: <20261116152626.4032587-15-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261116152626.4032587-1-alexei.starovoitov@gmail.com>
References: <20261116152626.4032587-1-alexei.starovoitov@gmail.com>
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

