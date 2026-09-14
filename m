Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46F8E48F85E
	for <bpf@vger.kernel.org>; Mon, 14 Sep 2026 17:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789405419; cv=none; b=oLHrmwC1CQB8si4kbPvINlIIKuP1r8lOAN4tD//nM2h/brNviDUo0wkqXUn7OL4qw+wkfetV9LNtGK+x2AUiAUENzio9R901b3HE1UOo905iOrokxZzy8rJTaTfHeCZrdKnFGYyTiYITAVYr6N/GMfWty6ys6KVMwea5n6IoDO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789405419; c=relaxed/simple;
	bh=+K79/tLgczm3wC1jXPzBkWKN0xJUWQBmEQEP3h+ILXI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zi9ZYdVCnr8gCZoMSxLzOrB6kZim+kJrIuPry1YJ9bB8uJMubo+vUl/K/ZDnXIkQOqGdea1aSRoOQZjpSTgAZtwqdDWrM6M3U8BNeekqzEaRSyslkag2v4XLEKofTjzzzfAPZh+XnHL9N+Zh9dC7acKQtY9aFKvIUG+elVAJs9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=O9FY0aw5; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="O9FY0aw5"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=DnM1emhxIHAzCkJ82C0HhM1sYblR20EYDibtvLqVRQw=; b=O9FY0aw5Za/LYYZ0Pdba6CQ/rq
	RjOmxN+GhKS7K7ja4/APe3PHtsbhmNagb+g08Zil3BMH56JDGApOha3Iqi+ZeCw2PKP0oX688ifoI
	9a3sYgsy0wu5v9srVopVX+RaGj40OL1LE8BO9Zdo4YGmQOQGM6mt3HPnXAkhoaga0tj3s+fRr6QRQ
	mJXZwM+JLFFwunKg3CKt2UdzT9rJ/zdV7ejUI7tBUSI2dR/X4WbklZ83c9DhjF1aSt2IdluTCg6xI
	slEzU7w2MH8MS0OdDJRoMeLqiOM3akpEqDXSoj1+66uDe9hG3hwd+ogf0EJbhIRaD5BWTa6jm4KLE
	Lyb1dZVw==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1x6A5a-000C8m-0L;
	Mon, 14 Sep 2026 19:03:30 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: ast@kernel.org
Cc: memxor@gmail.com,
	eddyz87@gmail.com,
	a.s.protopopov@gmail.com,
	info@starlabs.sg,
	bpf@vger.kernel.org,
	James Burton <jamesburton@meta.com>,
	Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>
Subject: [PATCH bpf v2 04/11] bpf: Reject indirect jumps that leave their subprogram
Date: Mon, 14 Sep 2026 19:03:19 +0200
Message-ID: <20260914170326.249953-5-daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260914170326.249953-1-daniel@iogearbox.net>
References: <20260914170326.249953-1-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/28123/Mon Sep 14 08:24:19 2026)

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
every map is confined to one subprog, and confine the resolved targets of
a gotox to its subprog in check_indirect_jump(). A target inside the
subprog is then always in the jump table the CFG walked, which is the
invariant that actually has to hold, and is kept as a verifier_bug_if().

Fixes: 493d9e0d6083 ("bpf, x86: add support for indirect jumps")
Reported-by: James Burton <jamesburton@meta.com>
Reported-by: Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Acked-by: Anton Protopopov <a.s.protopopov@gmail.com>
---
 kernel/bpf/cfg.c                              | 39 +++++--------
 kernel/bpf/verifier.c                         | 55 +++++++++++++++++++
 .../selftests/bpf/progs/verifier_gotox.c      |  2 +-
 3 files changed, 69 insertions(+), 27 deletions(-)

diff --git a/kernel/bpf/cfg.c b/kernel/bpf/cfg.c
index c38d33f0b0ba..5a91d73d3e3f 100644
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
@@ -310,15 +310,21 @@ static int compute_subprog_jts(struct bpf_verifier_env *env)
 		if (IS_ERR(jt_cur))
 			return PTR_ERR(jt_cur);
 
-		/*
-		 * This is enough to check one element. The full table is
-		 * checked to fit inside the subprog later in subprog_jt()
-		 */
 		subprog = bpf_find_containing_subprog(env, jt_cur->items[0]);
 		if (!subprog) {
 			kvfree(jt_cur);
 			continue;
 		}
+		if (jt_cur->items[jt_cur->cnt - 1] >= (subprog + 1)->start) {
+			verbose(env, "jump table of subprog starting at %u spans multiple subprogs\n",
+				subprog->start);
+			bpf_diag_program_structure(env, subprog->start, "jump table spans subprograms",
+				"Keep every entry of a jump table inside one subprogram.",
+				"A jump table found for the subprogram that starts at instruction %u reaches past its end at instruction %u.",
+				subprog->start, (subprog + 1)->start);
+			kvfree(jt_cur);
+			return -EINVAL;
+		}
 
 		old_cnt = subprog->jt ? subprog->jt->cnt : 0;
 		jt = bpf_iarray_realloc(subprog->jt, old_cnt + jt_cur->cnt);
@@ -358,9 +364,7 @@ static struct bpf_iarray *
 subprog_jt(int t, struct bpf_verifier_env *env)
 {
 	struct bpf_subprog_info *subprog;
-	int subprog_start, subprog_end;
-	struct bpf_iarray *jt;
-	int i, err;
+	int subprog_start, err;
 
 	if (!env->cfg.subprog_jts_ready) {
 		err = compute_subprog_jts(env);
@@ -370,7 +374,6 @@ subprog_jt(int t, struct bpf_verifier_env *env)
 
 	subprog = bpf_find_containing_subprog(env, t);
 	subprog_start = subprog->start;
-	subprog_end = (subprog + 1)->start;
 
 	if (!subprog->jt) {
 		verbose(env, "no jump tables found for subprog starting at %u\n", subprog_start);
@@ -381,23 +384,7 @@ subprog_jt(int t, struct bpf_verifier_env *env)
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
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 32157d145a60..dc3375fcfab9 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -18191,11 +18191,43 @@ static int indirect_jump_min_max_index(struct bpf_verifier_env *env,
 	return 0;
 }
 
+/* 'jt' is sorted and free of duplicates, see sort_insn_array_uniq() */
+static bool jt_contains(const struct bpf_iarray *jt, u32 target)
+{
+	int l = 0, r = jt->cnt - 1, m;
+
+	while (l <= r) {
+		m = l + (r - l) / 2;
+		if (jt->items[m] == target)
+			return true;
+		if (jt->items[m] < target)
+			l = m + 1;
+		else
+			r = m - 1;
+	}
+	return false;
+}
+
+static int reject_gotox_out_of_subprog(struct bpf_verifier_env *env, u32 target,
+				       u32 subprog_start, u32 subprog_end)
+{
+	verbose(env, "indirect jump from insn %d to %u leaves the subprog [%u,%u)\n",
+		     env->insn_idx, target, subprog_start, subprog_end);
+	bpf_diag_program_structure(env, env->insn_idx, "indirect jump leaves subprogram",
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
+	struct bpf_iarray *jt;
 	struct bpf_map *map;
 	u32 min_index, max_index;
 	int err = 0;
@@ -18238,6 +18270,29 @@ static int check_indirect_jump(struct bpf_verifier_env *env, struct bpf_insn *in
 		return -EINVAL;
 	}
 
+	subprog = bpf_find_containing_subprog(env, env->insn_idx);
+	if (verifier_bug_if(!subprog, env, "no subprog contains insn %d", env->insn_idx))
+		return -EFAULT;
+	subprog_start = subprog->start;
+	subprog_end = (subprog + 1)->start;
+
+	jt = subprog->jt;
+	if (verifier_bug_if(!jt, env, "no jump table for insn %d", env->insn_idx))
+		return -EFAULT;
+
+	for (i = 0; i < n; i++) {
+		u32 target = env->gotox_tmp_buf->items[i];
+
+		if (target < subprog_start || target >= subprog_end)
+			return reject_gotox_out_of_subprog(env, target, subprog_start,
+							   subprog_end);
+		/* Maps are confined to a subprog, see compute_subprog_jts() */
+		if (verifier_bug_if(!jt_contains(jt, target), env,
+				    "insn %d target %u is not in the jump table of its subprog",
+				    env->insn_idx, target))
+			return -EFAULT;
+	}
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

