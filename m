Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83FD04AF681
	for <bpf@vger.kernel.org>; Fri, 25 Sep 2026 17:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790358781; cv=none; b=swUbOiq3gtywNOd6omL5nKWPB/E+xE6xYIDZ2ii9cFcv/QpMtAoRTDc7ZJeryt9KMIjcGbPT4hL2Zg1NiwEWSGcb94vYKS5+30f89mmRQGeUoeTnUS6MSujM3NzdP/X9YcPTH+eZhGxuiVNmZkb1EWvIFVeDWFheNKgmSiovCKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790358781; c=relaxed/simple;
	bh=37e9XsJsUcBc6il4EM/2x0YtlzG1vM6oXFVmyGw7xcc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EQ2JCoaP4NpCsqqK5t3JFbl/3VTZfGM35RcxxgEu3UN/HZCcka4dTrE9hSXBbhUu1CbkjOrz0hQBqfIfRYlAZD/9j75g64w3l9Ok6J6x5OphW+2XIyLnsS0+7Vw07lKlDwjWyYi10XHtTv+7OOiHRI4pDaIduAD9vvjv4jRWmvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=fS3WiWgD; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="fS3WiWgD"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=EqW9m1smMLvWMs68OryEl+qiR+0RqkveF6N6v9Us2Ks=; b=fS3WiWgDSSAvHVOu4ZJGTDPBRj
	AZgLqCpxkVMLbwDGNVF9HFKReIIaSbeTaKuPXq3Rx9mtzxT6/SP+8EN+VMlXasTTd1FXwwrOs9GR4
	srrGeLGOlPUfVWU+Wy84PTDAGkhkA7BVKwSFWrKvUuCk2fjH/pgCsjHc1RHFqObJex1+9ssARlBl5
	DNiP87GKzh/mlIXFUBeeFUb2DHo4wXKoFmLVUGLOnLx0XIOAOikUxrsqBQiR9QcJiaJJLUJ3O24eT
	YbD1eYybQtTsXmdXHMylVQPiQE8MWksNerDhty9adz3M+bA/udVqb95QU0TXD0RI+aTsIpaDnTlI/
	4iAF5pHw==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1xAA6K-000Jju-1i;
	Fri, 25 Sep 2026 19:52:48 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: alexei.starovoitov@gmail.com
Cc: eddyz87@gmail.com,
	john.fastabend@gmail.com,
	memxor@gmail.com,
	bpf@vger.kernel.org
Subject: [PATCH bpf-next v3 05/16] bpf: Cache the jump table of a subprogram during CFG discovery
Date: Fri, 25 Sep 2026 19:52:32 +0200
Message-ID: <20260925175244.1136329-6-daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260925175244.1136329-1-daniel@iogearbox.net>
References: <20260925175244.1136329-1-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/28134/Fri Sep 25 08:25:58 2026)

create_jt() builds the jump table of the subprogram containing a gotox by
copying out and sorting every insn_array map of the program, and it does
so once per gotox instruction. The cost is therefore the number of gotox
instructions times the number of entries in all of the maps. A program of
4003 instructions with 2000 gotox and one 500k entry map holding two
distinct targets has 4000 indirect jump edges, 0.4% of the limit, and
takes 343s to be rejected. The map costs next to nothing to prepare, as
an unset entry is already a valid target. At the insn limit, with a single
1M entry map, the same shape extrapolates to 41 hours.

All gotox instructions of a subprogram share the same jump table, so
build the table of every subprogram in a single pass over the maps and
let every gotox use it in place: bpf_insn_successors() resolves a gotox
through its containing subprogram, and the tables are kept until the
verifier environment is torn down, so nothing is copied into the
instruction aux data. The edge accounting in visit_gotox_insn() moves
to the first visit of the gotox, marked by the BRANCH bit of its CFG
state, and a revisit returns right away since the first one already
pushed every target that still needed exploring.

The only user left of insn_aux_data[].jt is then the table which
visit_abnormal_return_insn() allocates for tail_call and
ld_{abs,ind} insns, so that bpf_insn_successors() reports the hidden
exit from their subprogram. Both are recognisable by their opcode, so
derive that edge in bpf_insn_successors() from the exit_idx of the
containing subprogram instead, again leaving it out when the subprogram
has no exit, and drop the field along with bpf_clear_insn_aux_data().
The instruction aux data then owns no allocation, thus nothing needs to
be freed when insns are removed or the verifier environment is torn
down.

Subprograms removed as dead code free their table in
adjust_subprog_starts_after_remove(), which also clears the slots that
the compaction of subprog_info vacates, as they still hold copies of the
moved entries and with them their table pointers.

check_cfg() is then linear in the number of map entries plus the number
of indirect jump edges, so what still scales now with the program is what
BPF_MAX_GOTOX_EDGES bounds:

  gotox  map entries  edges     before     after
  ----------------------------------------------
    500       250000   1000     35.34s     0.07s
   1000       250000   2000     82.00s     0.07s
   2000       250000   4000    148.62s     0.07s
   2000       125000   4000     74.54s     0.05s
   2000       500000   4000    342.71s     0.19s

Fixes: 493d9e0d6083 ("bpf, x86: add support for indirect jumps")
Suggested-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 include/linux/bpf_verifier.h |   5 +-
 kernel/bpf/cfg.c             | 190 ++++++++++++++++++-----------------
 kernel/bpf/fixups.c          |  30 ++----
 kernel/bpf/liveness.c        |  26 ++++-
 kernel/bpf/verifier.c        |   3 +-
 5 files changed, 134 insertions(+), 120 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 0b224498d307..c775bd757706 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -660,7 +660,6 @@ struct bpf_insn_aux_data {
 		/* remember the offset of node field within type to rewrite */
 		u64 insert_off;
 	};
-	struct bpf_iarray *jt;	/* jump table for gotox or bpf_tailcall call instruction */
 	struct btf_struct_meta *kptr_struct_meta;
 	u64 map_key_state; /* constant (32 bit) key tracking for maps */
 	int ctx_field_size; /* the ctx field size for load insn, maybe 0 */
@@ -820,6 +819,7 @@ struct bpf_subprog_info {
 	 * U32_MAX when it has none.
 	 */
 	u32 exit_idx;
+	struct bpf_iarray *jt; /* jump table shared by all gotox of this subprogram */
 	u16 stack_depth; /* max. stack depth used by this function */
 	u16 stack_extra;
 	u32 insns_total;
@@ -1009,6 +1009,7 @@ struct bpf_verifier_env {
 		/* current position in the insn_postorder vector */
 		int cur_postorder;
 		u32 gotox_edges;
+		bool subprog_jts_ready;
 	} cfg;
 	struct backtrack_state bt;
 	struct bpf_jmp_history_entry *cur_hist_ent;
@@ -1587,6 +1588,7 @@ bool bpf_is_throw_kfunc(struct bpf_insn *insn);
 int bpf_compute_const_regs(struct bpf_verifier_env *env);
 int bpf_prune_dead_branches(struct bpf_verifier_env *env);
 int bpf_check_cfg(struct bpf_verifier_env *env);
+void bpf_free_subprog_jts(struct bpf_verifier_env *env);
 int bpf_compute_postorder(struct bpf_verifier_env *env);
 int bpf_compute_scc(struct bpf_verifier_env *env);
 
@@ -1805,7 +1807,6 @@ struct bpf_kfunc_desc_tab {
 };
 
 /* Functions exported from verifier.c, used by fixups.c */
-void bpf_clear_insn_aux_data(struct bpf_verifier_env *env, int start, int len);
 void bpf_mark_subprog_exc_cb(struct bpf_verifier_env *env, int subprog);
 bool bpf_allow_tail_call_in_subprogs(struct bpf_verifier_env *env);
 bool bpf_verifier_inlines_helper_call(struct bpf_verifier_env *env, s32 imm);
diff --git a/kernel/bpf/cfg.c b/kernel/bpf/cfg.c
index f3f545c53264..ee89edd09d36 100644
--- a/kernel/bpf/cfg.c
+++ b/kernel/bpf/cfg.c
@@ -286,15 +286,17 @@ static struct bpf_iarray *jt_from_map(struct bpf_map *map)
 }
 
 /*
- * Find and collect all maps which fit in the subprog. Return the result as one
- * combined jump table in jt->items (allocated with kvcalloc)
+ * Collect the jump table of every subprogram that has one, as the combined
+ * table of all maps whose first target lands inside that subprogram. All gotox
+ * instructions of a subprogram share the same table, so this is done in a
+ * single pass over the maps rather than once per gotox.
  */
-static struct bpf_iarray *jt_from_subprog(struct bpf_verifier_env *env,
-					  int subprog_start, int subprog_end)
+static int __compute_subprog_jts(struct bpf_verifier_env *env)
 {
-	struct bpf_iarray *jt = NULL;
+	struct bpf_subprog_info *subprog;
+	struct bpf_iarray *jt, *jt_cur;
 	struct bpf_map *map;
-	struct bpf_iarray *jt_cur;
+	u32 old_cnt;
 	int i;
 
 	for (i = 0; i < env->insn_array_map_cnt; i++) {
@@ -305,56 +307,96 @@ static struct bpf_iarray *jt_from_subprog(struct bpf_verifier_env *env,
 		map = env->insn_array_maps[i];
 
 		jt_cur = jt_from_map(map);
-		if (IS_ERR(jt_cur)) {
-			kvfree(jt);
-			return jt_cur;
-		}
+		if (IS_ERR(jt_cur))
+			return PTR_ERR(jt_cur);
 
 		/*
 		 * This is enough to check one element. The full table is
-		 * checked to fit inside the subprog later in create_jt()
+		 * checked to fit inside the subprog later in subprog_jt()
 		 */
-		if (jt_cur->items[0] >= subprog_start && jt_cur->items[0] < subprog_end) {
-			u32 old_cnt = jt ? jt->cnt : 0;
-			jt = bpf_iarray_realloc(jt, old_cnt + jt_cur->cnt);
-			if (!jt) {
-				kvfree(jt_cur);
-				return ERR_PTR(-ENOMEM);
-			}
-			memcpy(jt->items + old_cnt, jt_cur->items, jt_cur->cnt << 2);
+		subprog = bpf_find_containing_subprog(env, jt_cur->items[0]);
+		if (verifier_bug_if(!subprog, env, "no subprog contains insn %u of an insn array map",
+				    jt_cur->items[0])) {
+			kvfree(jt_cur);
+			return -EFAULT;
+		}
+
+		old_cnt = subprog->jt ? subprog->jt->cnt : 0;
+		jt = bpf_iarray_realloc(subprog->jt, old_cnt + jt_cur->cnt);
+		if (!jt) {
+			subprog->jt = NULL;
+			kvfree(jt_cur);
+			return -ENOMEM;
 		}
+		memcpy(jt->items + old_cnt, jt_cur->items, jt_cur->cnt << 2);
+		subprog->jt = jt;
 
 		kvfree(jt_cur);
 	}
 
-	if (!jt) {
-		verbose(env, "no jump tables found for subprog starting at %u\n", subprog_start);
-		bpf_diag_program_structure(
-			env, subprog_start, "missing jump table",
-			"Make sure subprograms containing gotox instructions are accompanied by jump tables referencing these subprograms.",
-			"No jump table was found for the subprogram that starts at instruction %u.",
-			subprog_start);
-		return ERR_PTR(-EINVAL);
+	for (i = 0; i < env->subprog_cnt; i++) {
+		jt = env->subprog_info[i].jt;
+		if (jt)
+			jt->cnt = sort_insn_array_uniq(jt->items, jt->cnt);
 	}
 
-	jt->cnt = sort_insn_array_uniq(jt->items, jt->cnt);
-	return jt;
+	env->cfg.subprog_jts_ready = true;
+	return 0;
+}
+
+/* Leave nothing behind on failure. */
+static int compute_subprog_jts(struct bpf_verifier_env *env)
+{
+	int err;
+
+	err = __compute_subprog_jts(env);
+	if (err)
+		bpf_free_subprog_jts(env);
+	return err;
+}
+
+void bpf_free_subprog_jts(struct bpf_verifier_env *env)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(env->subprog_info); i++) {
+		kvfree(env->subprog_info[i].jt);
+		env->subprog_info[i].jt = NULL;
+	}
+	env->cfg.subprog_jts_ready = false;
 }
 
 static struct bpf_iarray *
-create_jt(int t, struct bpf_verifier_env *env)
+subprog_jt(int t, struct bpf_verifier_env *env)
 {
 	struct bpf_subprog_info *subprog;
 	int subprog_start, subprog_end;
 	struct bpf_iarray *jt;
-	int i;
+	int i, err;
+
+	if (!env->cfg.subprog_jts_ready) {
+		err = compute_subprog_jts(env);
+		if (err)
+			return ERR_PTR(err);
+	}
 
 	subprog = bpf_find_containing_subprog(env, t);
+	if (verifier_bug_if(!subprog, env, "no subprog contains insn %d", t))
+		return ERR_PTR(-EFAULT);
 	subprog_start = subprog->start;
 	subprog_end = (subprog + 1)->start;
-	jt = jt_from_subprog(env, subprog_start, subprog_end);
-	if (IS_ERR(jt))
-		return jt;
+
+	if (!subprog->jt) {
+		verbose(env, "no jump tables found for subprog starting at %u\n", subprog_start);
+		bpf_diag_program_structure(
+			env, subprog_start, "missing jump table",
+			"Make sure subprograms containing gotox instructions are accompanied by jump tables referencing these subprograms.",
+			"No jump table was found for the subprogram that starts at instruction %u.",
+			subprog_start);
+		return ERR_PTR(-EINVAL);
+	}
+
+	jt = subprog->jt;
 
 	/* Check that the every element of the jump table fits within the given subprogram */
 	for (i = 0; i < jt->cnt; i++) {
@@ -366,7 +408,6 @@ create_jt(int t, struct bpf_verifier_env *env)
 				"Keep every jump-table target inside the same subprogram.",
 				"The jump table for instruction %d points outside subprogram range [%u,%u).",
 				t, subprog_start, subprog_end);
-			kvfree(jt);
 			return ERR_PTR(-EINVAL);
 		}
 	}
@@ -383,26 +424,31 @@ static int visit_gotox_insn(int t, struct bpf_verifier_env *env)
 	struct bpf_iarray *jt;
 	int i, w;
 
-	jt = env->insn_aux_data[t].jt;
-	if (!jt) {
-		jt = create_jt(t, env);
-		if (IS_ERR(jt))
-			return PTR_ERR(jt);
+	/*
+	 * The first visit pushes every target that still needs exploring, and
+	 * those are all done by the time this insn is revisited, so there is
+	 * nothing left to walk the jump table for.
+	 */
+	if (insn_state[t] & BRANCH)
+		return DONE_EXPLORING;
 
-		env->insn_aux_data[t].jt = jt;
+	jt = subprog_jt(t, env);
+	if (IS_ERR(jt))
+		return PTR_ERR(jt);
 
-		if (check_add_overflow(env->cfg.gotox_edges, jt->cnt,
-				       &env->cfg.gotox_edges) ||
-		    env->cfg.gotox_edges > BPF_MAX_GOTOX_EDGES) {
-			verbose(env, "number of indirect jump edges in the program exceeds %u\n",
-				BPF_MAX_GOTOX_EDGES);
-			bpf_diag_program_structure(
+	insn_state[t] |= BRANCH;
+
+	if (check_add_overflow(env->cfg.gotox_edges, jt->cnt,
+			       &env->cfg.gotox_edges) ||
+	    env->cfg.gotox_edges > BPF_MAX_GOTOX_EDGES) {
+		verbose(env, "number of indirect jump edges in the program exceeds %u\n",
+			BPF_MAX_GOTOX_EDGES);
+		bpf_diag_program_structure(
 			env, t, "too many indirect jump edges",
-				"Reduce the number of indirect jumps, or the number of distinct targets they can reach.",
-				"The program has more than %u indirect jump edges in total, counted over every gotox instruction.",
-				BPF_MAX_GOTOX_EDGES);
-			return -E2BIG;
-		}
+			"Reduce the number of indirect jumps, or the number of distinct targets they can reach.",
+			"The program has more than %u indirect jump edges in total, counted over every gotox instruction.",
+			BPF_MAX_GOTOX_EDGES);
+		return -E2BIG;
 	}
 
 	mark_prune_point(env, t);
@@ -506,34 +552,6 @@ static int visit_func_ptrs_insn(int t, struct bpf_verifier_env *env,
 	return DONE_EXPLORING;
 }
 
-/*
- * Instructions that can abnormally return from a subprog (tail_call
- * upon success, ld_{abs,ind} upon load failure) have a hidden exit
- * that the verifier must account for.
- */
-static int visit_abnormal_return_insn(struct bpf_verifier_env *env, int t)
-{
-	struct bpf_subprog_info *subprog;
-	struct bpf_iarray *jt;
-	u32 n;
-
-	if (env->insn_aux_data[t].jt)
-		return 0;
-
-	/* A subprogram without an exit has no hidden exit edge to take. */
-	subprog = bpf_find_containing_subprog(env, t);
-	n = subprog->exit_idx == U32_MAX ? 1 : 2;
-	jt = bpf_iarray_realloc(NULL, n);
-	if (!jt)
-		return -ENOMEM;
-
-	jt->items[0] = t + 1;
-	if (n == 2)
-		jt->items[1] = subprog->exit_idx;
-	env->insn_aux_data[t].jt = jt;
-	return 0;
-}
-
 /* Visits the instruction at index t and returns one of the following:
  *  < 0 - an error occurred
  *  DONE_EXPLORING - the instruction was fully explored
@@ -556,13 +574,6 @@ static int visit_insn(int t, struct bpf_verifier_env *env)
 	/* All non-branch instructions have a single fall-through edge. */
 	if (BPF_CLASS(insn->code) != BPF_JMP &&
 	    BPF_CLASS(insn->code) != BPF_JMP32) {
-		if (BPF_CLASS(insn->code) == BPF_LD &&
-		    (BPF_MODE(insn->code) == BPF_ABS ||
-		     BPF_MODE(insn->code) == BPF_IND)) {
-			ret = visit_abnormal_return_insn(env, t);
-			if (ret)
-				return ret;
-		}
 		insn_sz = bpf_is_ldimm64(insn) ? 2 : 1;
 		return push_insn(t, t + insn_sz, FALLTHROUGH, env);
 	}
@@ -607,11 +618,6 @@ static int visit_insn(int t, struct bpf_verifier_env *env)
 				mark_subprog_might_sleep(env, t);
 			if (bpf_helper_changes_pkt_data(insn->imm))
 				mark_subprog_changes_pkt_data(env, t);
-			if (insn->imm == BPF_FUNC_tail_call) {
-				ret = visit_abnormal_return_insn(env, t);
-				if (ret)
-					return ret;
-			}
 		} else if (insn->src_reg == BPF_PSEUDO_KFUNC_CALL) {
 			struct bpf_call_arg_meta meta;
 
diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
index d49c50dae20a..adc254b1a646 100644
--- a/kernel/bpf/fixups.c
+++ b/kernel/bpf/fixups.c
@@ -480,7 +480,11 @@ static int adjust_subprog_starts_after_remove(struct bpf_verifier_env *env,
 
 	if (j > i) {
 		struct bpf_prog_aux *aux = env->prog->aux;
-		int move;
+		int move, k;
+
+		/* The removed subprogs own their jump tables. */
+		for (k = i; k < j; k++)
+			kvfree(env->subprog_info[k].jt);
 
 		/* move fake 'exit' subprog as well */
 		move = env->subprog_cnt + 1 - j;
@@ -488,6 +492,9 @@ static int adjust_subprog_starts_after_remove(struct bpf_verifier_env *env,
 		memmove(env->subprog_info + i,
 			env->subprog_info + j,
 			sizeof(*env->subprog_info) * move);
+		/* The vacated tail still holds copies of the moved entries. */
+		memset(env->subprog_info + i + move, 0,
+		       sizeof(*env->subprog_info) * (j - i));
 		env->subprog_cnt -= j - i;
 
 		/* remove func_info and its aux */
@@ -586,23 +593,6 @@ static int bpf_adj_linfo_after_remove(struct bpf_verifier_env *env, u32 off,
 	return 0;
 }
 
-/*
- * Clean up dynamically allocated fields of aux data for instructions [start, ...]
- */
-void bpf_clear_insn_aux_data(struct bpf_verifier_env *env, int start, int len)
-{
-	struct bpf_insn_aux_data *aux_data = env->insn_aux_data;
-	int end = start + len;
-	int i;
-
-	for (i = start; i < end; i++) {
-		if (aux_data[i].jt) {
-			kvfree(aux_data[i].jt);
-			aux_data[i].jt = NULL;
-		}
-	}
-}
-
 static int verifier_remove_insns(struct bpf_verifier_env *env, u32 off, u32 cnt)
 {
 	struct bpf_insn_aux_data *aux_data = env->insn_aux_data;
@@ -615,8 +605,6 @@ static int verifier_remove_insns(struct bpf_verifier_env *env, u32 off, u32 cnt)
 	if (bpf_prog_is_offloaded(env->prog->aux))
 		bpf_prog_offload_remove_insns(env, off, cnt);
 
-	bpf_clear_insn_aux_data(env, off, cnt);
-
 	err = bpf_remove_insns(env->prog, off, cnt);
 	if (err)
 		return err;
@@ -1688,6 +1676,8 @@ static int add_hidden_subprog(struct bpf_verifier_env *env, struct bpf_insn *pat
 	env->prog = prog;
 	info[cnt + 1].start = info[cnt].start;
 	info[cnt].start = prog->len - len + 1;
+	/* The patch ends with the exit. */
+	info[cnt].exit_idx = prog->len - 1;
 	env->subprog_cnt++;
 	env->hidden_subprog_cnt++;
 	return 0;
diff --git a/kernel/bpf/liveness.c b/kernel/bpf/liveness.c
index 16fb7dc43726..cd9523f69298 100644
--- a/kernel/bpf/liveness.c
+++ b/kernel/bpf/liveness.c
@@ -350,14 +350,18 @@ bpf_insn_successors(struct bpf_verifier_env *env, u32 idx)
 	struct bpf_iarray *succ, *jt;
 	int insn_sz;
 
-	jt = env->insn_aux_data[idx].jt;
-	if (unlikely(jt))
-		return jt;
-
 	/* pre-allocated array of size up to 2; reset cnt, as it may have been used already */
 	succ = env->succ;
 	succ->cnt = 0;
 
+	/* All gotox of a subprogram share its jump table, see compute_subprog_jts() */
+	if (unlikely(insn_is_gotox(insn))) {
+		jt = bpf_find_containing_subprog(env, idx)->jt;
+		if (verifier_bug_if(!jt, env, "no jump table for gotox insn %u", idx))
+			return succ;
+		return jt;
+	}
+
 	opcode_info = &opcode_info_tbl[BPF_CLASS(insn->code) | BPF_OP(insn->code)];
 	insn_sz = bpf_is_ldimm64(insn) ? 2 : 1;
 	if (opcode_info->can_fallthrough)
@@ -366,6 +370,20 @@ bpf_insn_successors(struct bpf_verifier_env *env, u32 idx)
 	if (opcode_info->can_jump)
 		succ->items[succ->cnt++] = idx + bpf_jmp_offset(insn) + 1;
 
+	/*
+	 * tail_call upon success and ld_{abs,ind} upon load failure return
+	 * from the subprogram, which is a hidden edge to its exit. A subprogram
+	 * without an exit insn has no exit to model.
+	 */
+	if (unlikely((bpf_helper_call(insn) && insn->imm == BPF_FUNC_tail_call) ||
+		     (BPF_CLASS(insn->code) == BPF_LD &&
+		      (BPF_MODE(insn->code) == BPF_ABS || BPF_MODE(insn->code) == BPF_IND)))) {
+		u32 exit_idx = bpf_find_containing_subprog(env, idx)->exit_idx;
+
+		if (exit_idx != U32_MAX)
+			succ->items[succ->cnt++] = exit_idx;
+	}
+
 	return succ;
 }
 
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 015909fe6843..80a3d15525b5 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -22751,8 +22751,7 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr,
 	release_maps(env);
 	release_btfs(env);
 err_free_env:
-	if (env->insn_aux_data)
-		bpf_clear_insn_aux_data(env, 0, env->insn_aux_data_len);
+	bpf_free_subprog_jts(env);
 	vfree(env->insn_aux_data);
 	kvfree(env->fd_array);
 	bpf_stack_liveness_free(env);
-- 
2.43.0

