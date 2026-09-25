Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5AA1413791
	for <bpf@vger.kernel.org>; Fri, 25 Sep 2026 17:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790358784; cv=none; b=qiGYhnUrm8K+12r49FbDEXUh4oyx++IEB9d6B5euXG4MwapqkUAUBOGGxLPtXwG8j9Ar3l2sxVlv+M/3FC/zI0bMoXBGTZnE3gma3ps8JngQnVQums7cAQqLrRHQUsHDOcpq0Pr6PQPCNDvIaY40kVQ4atXGOMGPur9Qxc6J5fM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790358784; c=relaxed/simple;
	bh=XjMpuAyE4zEWCvkFPc/mxpgZnBNp6i7WeC5mAkbgntU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jrx1R5mAITItmnzvUzZPc/nFb01GPaBSBCfjqau4f9A20gHdSLR5/UZzTD9zK5+uOvRaoWRZOo9YPzn28MBd48dtHQuLUfaeF7Hp2L6Lh60oJqd5D4ehxtDhRuMfaitFUVcgh+HUDiYPwUt9aJ2ZGw0nIRJvGCrOc2jtflYQ+8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=cu8U37a4; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="cu8U37a4"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=+JLRiLGI7cX06taP4/DW9vNw58LdwObbZ6Tpnoo9EoI=; b=cu8U37a44Qd0Ouc3C+31IkOC/T
	S59iVvDmJQ2UWFWsVQhvzLSsx2+Dm8RUJirW7LsMJ4tHVeS0Nbw/NmlUacU7OIsXfu9V5lRY0/610
	M1CfCQ9mLGWEbaIMWq8KZCCsHdHneEpj9C+vqNHyDd6/IzwfAtB/7IXNG/c3teGGu96b9jWqc+oNl
	GDmfbX6jF0T0H/l4JZruT/qwOrSRTLxyy+bTT/pCewvgPeiSIE1MebllqVJD3o5AG49xrhb4q3bT/
	ijQMXy+n460SX7Kmu9nGKusu19TMOZNZz6mjunZn67N+fBq3mF37MVRZg5GvMSHFlB5JLKV6rTsok
	oxq6vbhw==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1xAA6L-000Jk0-0g;
	Fri, 25 Sep 2026 19:52:49 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: alexei.starovoitov@gmail.com
Cc: eddyz87@gmail.com,
	john.fastabend@gmail.com,
	memxor@gmail.com,
	bpf@vger.kernel.org,
	James Burton <jamesburton@meta.com>,
	Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>,
	Anton Protopopov <a.s.protopopov@gmail.com>
Subject: [PATCH bpf-next v3 06/16] bpf: Reject indirect jumps that leave their subprogram
Date: Fri, 25 Sep 2026 19:52:33 +0200
Message-ID: <20260925175244.1136329-7-daniel@iogearbox.net>
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

The jump table of a subprog is collected in compute_subprog_jts() from the
insn_array maps of the program, and a map is attributed to the subprog that
contains its first entry. check_indirect_jump() instead resolves the targets
from the map the gotox register actually points to, bounded only by the
index range of that register, and never relates them back to the subprog
of the gotox.

The two disagree, so bpf_insn_successors() reports a subset of the edges the
BPF program can take and a gotox can enter a subprog the CFG never walked.

Close both ends: reject a map that reaches past the subprog holding its
first entry right when it is collected in compute_subprog_jts(), so that
every map of a program with a gotox is confined to one subprog, and
confine the resolved targets of a gotox to its subprog in
check_indirect_jump(). A target inside the subprog is then always in the
jump table the CFG walked, which is the invariant that actually has to
hold. The out-of-range check in visit_gotox_insn() cannot fire any more
once every table is confined and becomes a verifier_bug_if().

Fixes: 493d9e0d6083 ("bpf, x86: add support for indirect jumps")
Reported-by: James Burton <jamesburton@meta.com>
Reported-by: Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Acked-by: Anton Protopopov <a.s.protopopov@gmail.com>
Acked-by: Eduard Zingerman <eddyz87@gmail.com>
---
 kernel/bpf/cfg.c                              | 52 ++++++-------------
 kernel/bpf/verifier.c                         | 33 ++++++++++++
 .../selftests/bpf/progs/verifier_gotox.c      |  2 +-
 3 files changed, 51 insertions(+), 36 deletions(-)

diff --git a/kernel/bpf/cfg.c b/kernel/bpf/cfg.c
index ee89edd09d36..b0bd9ba951df 100644
--- a/kernel/bpf/cfg.c
+++ b/kernel/bpf/cfg.c
@@ -287,7 +287,7 @@ static struct bpf_iarray *jt_from_map(struct bpf_map *map)
 
 /*
  * Collect the jump table of every subprogram that has one, as the combined
- * table of all maps whose first target lands inside that subprogram. All gotox
+ * table of all maps whose targets land inside that subprogram. All gotox
  * instructions of a subprogram share the same table, so this is done in a
  * single pass over the maps rather than once per gotox.
  */
@@ -310,16 +310,23 @@ static int __compute_subprog_jts(struct bpf_verifier_env *env)
 		if (IS_ERR(jt_cur))
 			return PTR_ERR(jt_cur);
 
-		/*
-		 * This is enough to check one element. The full table is
-		 * checked to fit inside the subprog later in subprog_jt()
-		 */
 		subprog = bpf_find_containing_subprog(env, jt_cur->items[0]);
 		if (verifier_bug_if(!subprog, env, "no subprog contains insn %u of an insn array map",
 				    jt_cur->items[0])) {
 			kvfree(jt_cur);
 			return -EFAULT;
 		}
+		if (jt_cur->items[jt_cur->cnt - 1] >= (subprog + 1)->start) {
+			verbose(env, "jump table of subprog starting at %u spans multiple subprogs, map id=%d\n",
+				subprog->start, map->id);
+			bpf_diag_program_structure(
+				env, subprog->start, "jump table spans subprograms",
+				"Keep every entry of a jump table inside one subprogram.",
+				"The jump table in map id %d for the subprogram that starts at instruction %u reaches past its end at instruction %u.",
+				map->id, subprog->start, (subprog + 1)->start);
+			kvfree(jt_cur);
+			return -EINVAL;
+		}
 
 		old_cnt = subprog->jt ? subprog->jt->cnt : 0;
 		jt = bpf_iarray_realloc(subprog->jt, old_cnt + jt_cur->cnt);
@@ -370,9 +377,7 @@ static struct bpf_iarray *
 subprog_jt(int t, struct bpf_verifier_env *env)
 {
 	struct bpf_subprog_info *subprog;
-	int subprog_start, subprog_end;
-	struct bpf_iarray *jt;
-	int i, err;
+	int subprog_start, err;
 
 	if (!env->cfg.subprog_jts_ready) {
 		err = compute_subprog_jts(env);
@@ -384,7 +389,6 @@ subprog_jt(int t, struct bpf_verifier_env *env)
 	if (verifier_bug_if(!subprog, env, "no subprog contains insn %d", t))
 		return ERR_PTR(-EFAULT);
 	subprog_start = subprog->start;
-	subprog_end = (subprog + 1)->start;
 
 	if (!subprog->jt) {
 		verbose(env, "no jump tables found for subprog starting at %u\n", subprog_start);
@@ -396,23 +400,7 @@ subprog_jt(int t, struct bpf_verifier_env *env)
 		return ERR_PTR(-EINVAL);
 	}
 
-	jt = subprog->jt;
-
-	/* Check that the every element of the jump table fits within the given subprogram */
-	for (i = 0; i < jt->cnt; i++) {
-		if (jt->items[i] < subprog_start || jt->items[i] >= subprog_end) {
-			verbose(env, "jump table for insn %d points outside of the subprog [%u,%u]\n",
-					t, subprog_start, subprog_end);
-			bpf_diag_program_structure(
-				env, t, "jump table target out of range",
-				"Keep every jump-table target inside the same subprogram.",
-				"The jump table for instruction %d points outside subprogram range [%u,%u).",
-				t, subprog_start, subprog_end);
-			return ERR_PTR(-EINVAL);
-		}
-	}
-
-	return jt;
+	return subprog->jt;
 }
 
 /* "conditional jump with N edges" */
@@ -454,15 +442,9 @@ static int visit_gotox_insn(int t, struct bpf_verifier_env *env)
 	mark_prune_point(env, t);
 	for (i = 0; i < jt->cnt; i++) {
 		w = jt->items[i];
-		if (w < 0 || w >= env->prog->len) {
-			verbose(env, "indirect jump out of range from insn %d to %d\n", t, w);
-			bpf_diag_program_structure(
-				env, t, "indirect jump out of range",
-				"Keep indirect jump targets inside the program.",
-				"Instruction %d can jump indirectly to instruction %d, but the program only contains instructions 0 through %d.",
-				t, w, env->prog->len - 1);
-			return -EINVAL;
-		}
+		if (verifier_bug_if(w < 0 || w >= env->prog->len, env,
+				    "indirect jump from insn %d to %d out of range", t, w))
+			return -EFAULT;
 
 		mark_jmp_point(env, w);
 		mark_jump_target(env, w);
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 80a3d15525b5..c1d6d217e0e8 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -19253,10 +19253,25 @@ static int indirect_jump_min_max_index(struct bpf_verifier_env *env,
 	return 0;
 }
 
+static int reject_gotox_out_of_subprog(struct bpf_verifier_env *env, u32 target,
+				       u32 subprog_start, u32 subprog_end)
+{
+	verbose(env, "indirect jump from insn %d to %u leaves the subprog [%u,%u)\n",
+		env->insn_idx, target, subprog_start, subprog_end);
+	bpf_diag_program_structure(
+		env, env->insn_idx, "indirect jump leaves subprogram",
+		"Keep every reachable jump-table target inside the subprogram of the indirect jump.",
+		"Instruction %d can jump indirectly to instruction %u, which is outside its own subprogram [%u,%u).",
+		env->insn_idx, target, subprog_start, subprog_end);
+	return -EINVAL;
+}
+
 /* gotox *dst_reg */
 static int check_indirect_jump(struct bpf_verifier_env *env, struct bpf_insn *insn)
 {
 	struct bpf_verifier_state *other_branch;
+	struct bpf_subprog_info *subprog;
+	u32 subprog_start, subprog_end;
 	struct bpf_reg_state *dst_reg;
 	struct bpf_map *map;
 	u32 min_index, max_index;
@@ -19300,6 +19315,24 @@ static int check_indirect_jump(struct bpf_verifier_env *env, struct bpf_insn *in
 		return -EINVAL;
 	}
 
+	subprog = bpf_find_containing_subprog(env, env->insn_idx);
+	if (verifier_bug_if(!subprog, env, "no subprog contains insn %d", env->insn_idx))
+		return -EFAULT;
+	subprog_start = subprog->start;
+	subprog_end = (subprog + 1)->start;
+
+	/*
+	 * Maps are confined to a subprog, see compute_subprog_jts(), and the
+	 * targets are sorted and free of duplicates, see sort_insn_array_uniq(),
+	 * so either all of them belong to this subprog or none of them does.
+	 */
+	if (env->gotox_tmp_buf->items[0] < subprog_start)
+		return reject_gotox_out_of_subprog(env, env->gotox_tmp_buf->items[0],
+						   subprog_start, subprog_end);
+	if (env->gotox_tmp_buf->items[n - 1] >= subprog_end)
+		return reject_gotox_out_of_subprog(env, env->gotox_tmp_buf->items[n - 1],
+						   subprog_start, subprog_end);
+
 	for (i = 0; i < n - 1; i++) {
 		mark_indirect_target(env, env->gotox_tmp_buf->items[i]);
 		other_branch = push_stack(env, env->gotox_tmp_buf->items[i],
diff --git a/tools/testing/selftests/bpf/progs/verifier_gotox.c b/tools/testing/selftests/bpf/progs/verifier_gotox.c
index 0e27c2c79c57..4931a77ba0b2 100644
--- a/tools/testing/selftests/bpf/progs/verifier_gotox.c
+++ b/tools/testing/selftests/bpf/progs/verifier_gotox.c
@@ -366,7 +366,7 @@ __used static int test_subprog(void)
 }
 
 SEC("socket")
-__failure __msg("jump table for insn 4 points outside of the subprog [0,10]")
+__failure __msg("jump table of subprog starting at 0 spans multiple subprogs")
 __naked void jump_table_outside_subprog(void)
 {
 	asm volatile ("						\
-- 
2.43.0

