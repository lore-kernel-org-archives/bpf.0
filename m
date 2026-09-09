Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01DF33BFE33
	for <bpf@vger.kernel.org>; Wed,  9 Sep 2026 20:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788986452; cv=none; b=ehY2craVnneT/QjeANPq0hS+2pSuKI9jPXrW9ddtgVfxsk8F55jqdh58o5EwMNuFRbSIDYNNkEA9SO0V/7ERQbsOMbMOe1XZQYPWxUfVr+1g79O0Ty9Cg8Sq+nRegR2QTvH3N+kpfJ2LC6sIocR8SqJM6qb3ahECc15KnEzxqRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788986452; c=relaxed/simple;
	bh=IGO3bXK44/rTmyO5S4b8mM8CPgqljbkBo86Ini2Duks=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t0ELFAtRXlz2Ro9WcgItDytKsou5RrHDvjzHnRhkZmoQ3IB8Eh/Nu4Wao4Qtk5p328qvaZcd0F8sxPR8vuaWbmadMrl4ua649KSqsR2H5AUEXSzv51Xzp+4OKgQbgApSNZP1zJ4u8YOWyP0xG+7HMnkxC81oEZluPuGU6CU3lqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=n+n8/VgX; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="n+n8/VgX"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=8GZk+siUK3jDLrnZXPLoUcKwKDfbqR6gWi3wpO+hejs=; b=n+n8/VgXerE+53JSerNv4xQTTp
	3POWgIHo9B936YSTRZ0OkdHwD6sRKm6MRiP2escQA7jKKws82zdqkiM44dGZgTei8m+Ffb4Ir2l+S
	c5ymhPLYZ4v8M6bNu9Z4xsl2p409U5sLki5BThnIN6qYibLrmwWn/34348Jhf3E+7ANsobXEAxV1D
	tApWMyccvOn7gqWUc1gsAYNUQcOmoLiNVpSmiDiqF1pX49nBDZKlT4MIO5CGJVdU36vfL7cJebO5a
	RVhySFMpvXYODox/QxrxtKc8/est+EtAGOlU4YQePaEA9GYF92mWcnlrSwC9futnQjJePdTVQXlxD
	YSp2W7iQ==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1x4P5y-000F75-1i;
	Wed, 09 Sep 2026 22:40:38 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: ast@kernel.org
Cc: memxor@gmail.com,
	eddyz87@gmail.com,
	a.s.protopopov@gmail.com,
	info@starlabs.sg,
	bpf@vger.kernel.org
Subject: [PATCH bpf 3/6] bpf: Cache the jump table of a subprogram during CFG discovery
Date: Wed,  9 Sep 2026 22:40:32 +0200
Message-ID: <20260909204035.24289-3-daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260909204035.24289-1-daniel@iogearbox.net>
References: <20260909204035.24289-1-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/28118/Wed Sep  9 08:24:03 2026)

create_jt() builds the jump table of the subprogram containing a gotox by
copying out and sorting every insn_array map of the program, and it does
so once per gotox instruction. The cost is therefore the number of gotox
instructions times the number of entries in all of the maps. A program of
4003 instructions with 2000 gotox and one 500k entry map holding two
distinct targets has 4000 indirect jump edges, 0.4% of the limit, and
takes 351s to be rejected. The map costs next to nothing to prepare, as
an unset entry is already a valid target. At the insn limit, with a single
1M entry map, the same shape extrapolates to 43 hours.

All gotox instructions of a subprogram share the same jump table, so
build the table of every subprogram in a single pass over the maps and
hand each gotox a copy of it. Instruction aux data owns its jump table,
see bpf_clear_insn_aux_data(), hence the copy; the copies add up to the
number of indirect jump edges, which visit_gotox_insn() already bounds.

check_cfg() is then linear in the number of map entries plus the number
of indirect jump edges, so what still scales now with the program is what
BPF_MAX_GOTOX_EDGES bounds:

  gotox  map entries  edges     before     after
  ----------------------------------------------
    500       250000   1000     36.55s     0.07s
   1000       250000   2000     75.65s     0.07s
   2000       250000   4000    153.44s     0.07s
   2000       125000   4000     69.61s     0.04s
   2000       500000   4000    351.27s     0.15s

Fixes: 493d9e0d6083 ("bpf, x86: add support for indirect jumps")
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 include/linux/bpf_verifier.h |  2 +
 kernel/bpf/cfg.c             | 99 +++++++++++++++++++++++-------------
 2 files changed, 65 insertions(+), 36 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 04bb8f71cabe..301a47d2b272 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -805,6 +805,7 @@ struct bpf_subprog_info {
 	u32 linfo_idx; /* The idx to the main_prog->aux->linfo */
 	u32 postorder_start; /* The idx to the env->cfg.insn_postorder */
 	u32 exit_idx; /* Index of one of the BPF_EXIT instructions in this subprogram */
+	struct bpf_iarray *jt; /* jump table shared by all gotox of this subprogram */
 	u16 stack_depth; /* max. stack depth used by this function */
 	u16 stack_extra;
 	u32 insns_total;
@@ -978,6 +979,7 @@ struct bpf_verifier_env {
 		/* current position in the insn_postorder vector */
 		int cur_postorder;
 		u32 gotox_edges;
+		bool subprog_jts_ready;
 	} cfg;
 	struct backtrack_state bt;
 	struct bpf_jmp_history_entry *cur_hist_ent;
diff --git a/kernel/bpf/cfg.c b/kernel/bpf/cfg.c
index e9910228da58..8aee94689229 100644
--- a/kernel/bpf/cfg.c
+++ b/kernel/bpf/cfg.c
@@ -286,15 +286,17 @@ static struct bpf_iarray *jt_from_map(struct bpf_map *map)
 }
 
 /*
- * Find and collect all maps which fit in the subprog. Return the result as one
- * combined jump table in jt->items (allocated with kvcalloc)
+ * Collect the jump table of every subprogram that has one, as the combined
+ * table of all maps whose targets land inside that subprogram. All gotox
+ * instructions of a subprogram share the same table, so this is done in a
+ * single pass over the maps rather than once per gotox.
  */
-static struct bpf_iarray *jt_from_subprog(struct bpf_verifier_env *env,
-					  int subprog_start, int subprog_end)
+static int compute_subprog_jts(struct bpf_verifier_env *env)
 {
-	struct bpf_iarray *jt = NULL;
+	struct bpf_subprog_info *subprog;
+	struct bpf_iarray *jt, *jt_cur;
 	struct bpf_map *map;
-	struct bpf_iarray *jt_cur;
+	u32 old_cnt;
 	int i;
 
 	for (i = 0; i < env->insn_array_map_cnt; i++) {
@@ -305,40 +307,47 @@ static struct bpf_iarray *jt_from_subprog(struct bpf_verifier_env *env,
 		map = env->insn_array_maps[i];
 
 		jt_cur = jt_from_map(map);
-		if (IS_ERR(jt_cur)) {
-			kvfree(jt);
-			return jt_cur;
+		if (IS_ERR(jt_cur))
+			return PTR_ERR(jt_cur);
+
+		subprog = bpf_find_containing_subprog(env, jt_cur->items[0]);
+		if (!subprog) {
+			kvfree(jt_cur);
+			continue;
 		}
 
-		/*
-		 * This is enough to check one element. The full table is
-		 * checked to fit inside the subprog later in create_jt()
-		 */
-		if (jt_cur->items[0] >= subprog_start && jt_cur->items[0] < subprog_end) {
-			u32 old_cnt = jt ? jt->cnt : 0;
-			jt = bpf_iarray_realloc(jt, old_cnt + jt_cur->cnt);
-			if (!jt) {
-				kvfree(jt_cur);
-				return ERR_PTR(-ENOMEM);
-			}
-			memcpy(jt->items + old_cnt, jt_cur->items, jt_cur->cnt << 2);
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
+static void free_subprog_jts(struct bpf_verifier_env *env)
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
@@ -347,16 +356,33 @@ create_jt(int t, struct bpf_verifier_env *env)
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
 	subprog_start = subprog->start;
 	subprog_end = (subprog + 1)->start;
-	jt = jt_from_subprog(env, subprog_start, subprog_end);
-	if (IS_ERR(jt))
-		return jt;
 
-	/* Check that the every element of the jump table fits within the given subprogram */
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
+	jt = bpf_iarray_realloc(NULL, subprog->jt->cnt);
+	if (!jt)
+		return ERR_PTR(-ENOMEM);
+	memcpy(jt->items, subprog->jt->items, subprog->jt->cnt << 2);
+
 	for (i = 0; i < jt->cnt; i++) {
 		if (jt->items[i] < subprog_start || jt->items[i] >= subprog_end) {
 			verbose(env, "jump table for insn %d points outside of the subprog [%u,%u]\n",
@@ -693,6 +719,7 @@ int bpf_check_cfg(struct bpf_verifier_env *env)
 	env->prog->aux->might_sleep = env->subprog_info[0].might_sleep;
 
 err_free:
+	free_subprog_jts(env);
 	kvfree(insn_state);
 	kvfree(insn_stack);
 	env->cfg.insn_state = env->cfg.insn_stack = NULL;
-- 
2.43.0

