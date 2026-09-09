Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C3A03D1709
	for <bpf@vger.kernel.org>; Wed,  9 Sep 2026 20:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788986463; cv=none; b=XOUVCHsFjH6+3iy5zQobe4ehj7rFl8JUjFvn348wWm10CnyjgF6NlM0EHMl6h+d6yePLQ/vx1ZuE1+Dw6FxUS8XfBm5W3TVfvYm5sjOVUcVD9MQI7+gQe6HABmImlT4noEFOo9YgNslFtU6JbKC2bDKucTE96NTk3+eGLobCePM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788986463; c=relaxed/simple;
	bh=c2sZOdGh4+WWKLVZeiLMnBGhJuxuqZYkGzJDmt/HQoc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DoOla3pVpYHnta0u97FH5ehHEsiMa2j4WFRirVGQWqM2bpKkyIOs8qjQn67l50DAUQZuHWd42KNUm9BqdLpD19+Fzq0vOXgcBsVv6syfyMXm9Bgia/L6k8SteQBesy7eZ4iPLW8RPR2CX8letYzX5Y+y0vrXSIBvUkveNsgCC2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=OBxOAkdQ; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="OBxOAkdQ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=N6PrFAgf0nQY66eJJyT3OsvVul2hz9EeqBbrp5tuM7Q=; b=OBxOAkdQ0ZhFhxBvweMMoVutvW
	2HQOL6c+aL8Mx/RQWW1Lee43HhmDrYjdNtKxtszQ6J0k5t7xvC7h80OjEv83/giyTQV9DGCAVSzK7
	2G2lOARX0M1zT/f5WyJs3abIpcsoI3wqOQgNi6aPi322eZ+HDZrboHXCZbe9fWby2iuAa1jQrWcN+
	K2R6rmWpaqquDLJBnE5IGGZVFJxq8yYcsuR70X8Pkj691lSPsTeFgjzd5uBjct1kZvSR5OFcF283e
	ktFB0nWup3hWsIFn0V0/9pPwdTdVC+gDLjfxbNo5RdjpBYFx7XmYxGjxqnRYp91xBrjgD8Bgm2P/c
	8o5Vk4QA==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1x4P5z-000F7N-12;
	Wed, 09 Sep 2026 22:40:39 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: ast@kernel.org
Cc: memxor@gmail.com,
	eddyz87@gmail.com,
	a.s.protopopov@gmail.com,
	info@starlabs.sg,
	bpf@vger.kernel.org,
	James Burton <jamesburton@meta.com>,
	Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>
Subject: [PATCH bpf 4/6] bpf: Reject indirect jumps that leave their subprogram
Date: Wed,  9 Sep 2026 22:40:33 +0200
Message-ID: <20260909204035.24289-4-daniel@iogearbox.net>
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

The jump table of a subprog is collected in compute_subprog_jts() from the
insn_array maps of the program, and a map is attributed to the subprog that
contains its first entry. check_indirect_jump() instead resolves the targets
from the map the gotox register actually points to, bounded only by the
index range of that register, and never relates them back to the subprog
of the gotox.

The two disagree, so bpf_insn_successors() reports a subset of the edges the
BPF program can take and a gotox can enter a subprog the CFG never walked.
The x86 epilogue there pops the callee saved registers of its own subprog and
leaves the ones pushed by the current prologue unrestored, handing rbx, r13,
r14 and r15 to the kernel with the values the BPF program left in them.

Close both ends in check_indirect_jump(): confine the resolved targets to the
subprog of the gotox, and require each of them to be present in the jump table
the CFG walked, that is, in the successor set bpf_insn_successors() reported
for this instruction. The latter is the invariant that actually has to hold,
the former is kept because it names the problem the BPF program has.

Fixes: 493d9e0d6083 ("bpf, x86: add support for indirect jumps")
Reported-by: James Burton <jamesburton@meta.com>
Reported-by: Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 include/linux/bpf_verifier.h                  |  1 +
 kernel/bpf/cfg.c                              | 35 +++++-----
 kernel/bpf/verifier.c                         | 65 +++++++++++++++++++
 .../selftests/bpf/progs/verifier_gotox.c      |  2 +-
 4 files changed, 85 insertions(+), 18 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 301a47d2b272..baf2e17d7019 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -826,6 +826,7 @@ struct bpf_subprog_info {
 	bool keep_fastcall_stack: 1;
 	bool changes_pkt_data: 1;
 	bool might_sleep: 1;
+	bool jt_spans_subprogs: 1;
 	u8 arg_cnt:4;
 
 	enum priv_stack_mode priv_stack_mode;
diff --git a/kernel/bpf/cfg.c b/kernel/bpf/cfg.c
index 8aee94689229..879587af8d08 100644
--- a/kernel/bpf/cfg.c
+++ b/kernel/bpf/cfg.c
@@ -315,6 +315,11 @@ static int compute_subprog_jts(struct bpf_verifier_env *env)
 			kvfree(jt_cur);
 			continue;
 		}
+		if (jt_cur->items[jt_cur->cnt - 1] >= (subprog + 1)->start) {
+			subprog->jt_spans_subprogs = true;
+			kvfree(jt_cur);
+			continue;
+		}
 
 		old_cnt = subprog->jt ? subprog->jt->cnt : 0;
 		jt = bpf_iarray_realloc(subprog->jt, old_cnt + jt_cur->cnt);
@@ -346,6 +351,7 @@ static void free_subprog_jts(struct bpf_verifier_env *env)
 	for (i = 0; i < ARRAY_SIZE(env->subprog_info); i++) {
 		kvfree(env->subprog_info[i].jt);
 		env->subprog_info[i].jt = NULL;
+		env->subprog_info[i].jt_spans_subprogs = false;
 	}
 	env->cfg.subprog_jts_ready = false;
 }
@@ -354,9 +360,8 @@ static struct bpf_iarray *
 create_jt(int t, struct bpf_verifier_env *env)
 {
 	struct bpf_subprog_info *subprog;
-	int subprog_start, subprog_end;
 	struct bpf_iarray *jt;
-	int i, err;
+	int subprog_start, err;
 
 	if (!env->cfg.subprog_jts_ready) {
 		err = compute_subprog_jts(env);
@@ -366,7 +371,17 @@ create_jt(int t, struct bpf_verifier_env *env)
 
 	subprog = bpf_find_containing_subprog(env, t);
 	subprog_start = subprog->start;
-	subprog_end = (subprog + 1)->start;
+
+	if (subprog->jt_spans_subprogs) {
+		verbose(env, "jump table of subprog starting at %u spans multiple subprogs\n",
+			subprog_start);
+		bpf_diag_program_structure(
+			env, subprog_start, "jump table spans subprograms",
+			"Keep every entry of a jump table inside one subprogram.",
+			"A jump table found for the subprogram that starts at instruction %u reaches past its end at instruction %u.",
+			subprog_start, (subprog + 1)->start);
+		return ERR_PTR(-EINVAL);
+	}
 
 	if (!subprog->jt) {
 		verbose(env, "no jump tables found for subprog starting at %u\n", subprog_start);
@@ -383,20 +398,6 @@ create_jt(int t, struct bpf_verifier_env *env)
 		return ERR_PTR(-ENOMEM);
 	memcpy(jt->items, subprog->jt->items, subprog->jt->cnt << 2);
 
-	for (i = 0; i < jt->cnt; i++) {
-		if (jt->items[i] < subprog_start || jt->items[i] >= subprog_end) {
-			verbose(env, "jump table for insn %d points outside of the subprog [%u,%u]\n",
-					t, subprog_start, subprog_end);
-			bpf_diag_program_structure(
-				env, t, "jump table target out of range",
-				"Keep every jump-table target inside the same subprogram.",
-				"The jump table for instruction %d points outside subprogram range [%u,%u).",
-				t, subprog_start, subprog_end);
-			kvfree(jt);
-			return ERR_PTR(-EINVAL);
-		}
-	}
-
 	return jt;
 }
 
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 72a3f5998dd2..45234e2fbee6 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -18165,11 +18165,56 @@ static int indirect_jump_min_max_index(struct bpf_verifier_env *env,
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
+	bpf_diag_program_structure(
+		env, env->insn_idx, "indirect jump leaves subprogram",
+		"Keep every reachable jump-table target inside the subprogram of the indirect jump.",
+		"Instruction %d can jump indirectly to instruction %u, which is outside its own subprogram [%u,%u).",
+		env->insn_idx, target, subprog_start, subprog_end);
+	return -EINVAL;
+}
+
+static int reject_gotox_without_cfg_edge(struct bpf_verifier_env *env, u32 target)
+{
+	verbose(env, "indirect jump from insn %d to %u is not in the jump table of the subprog\n",
+		     env->insn_idx, target);
+	bpf_diag_program_structure(
+		env, env->insn_idx, "indirect jump target without CFG edge",
+		"Resolve indirect jumps through a jump table whose entries all fall inside the subprogram of the jump.",
+		"Instruction %d can jump indirectly to instruction %u, which is not part of the jump table of its subprogram.",
+		env->insn_idx, target);
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
@@ -18212,6 +18257,26 @@ static int check_indirect_jump(struct bpf_verifier_env *env, struct bpf_insn *in
 		return -EINVAL;
 	}
 
+	subprog = bpf_find_containing_subprog(env, env->insn_idx);
+	if (verifier_bug_if(!subprog, env, "no subprog contains insn %d", env->insn_idx))
+		return -EFAULT;
+	subprog_start = subprog->start;
+	subprog_end = (subprog + 1)->start;
+
+	jt = env->insn_aux_data[env->insn_idx].jt;
+	if (verifier_bug_if(!jt, env, "no jump table for insn %d", env->insn_idx))
+		return -EFAULT;
+
+	for (i = 0; i < n; i++) {
+		u32 target = env->gotox_tmp_buf->items[i];
+
+		if (target < subprog_start || target >= subprog_end)
+			return reject_gotox_out_of_subprog(env, target, subprog_start,
+							   subprog_end);
+		if (!jt_contains(jt, target))
+			return reject_gotox_without_cfg_edge(env, target);
+	}
+
 	for (i = 0; i < n - 1; i++) {
 		mark_indirect_target(env, env->gotox_tmp_buf->items[i]);
 		other_branch = push_stack(env, env->gotox_tmp_buf->items[i],
diff --git a/tools/testing/selftests/bpf/progs/verifier_gotox.c b/tools/testing/selftests/bpf/progs/verifier_gotox.c
index 5b18c9a27717..3567b29e2378 100644
--- a/tools/testing/selftests/bpf/progs/verifier_gotox.c
+++ b/tools/testing/selftests/bpf/progs/verifier_gotox.c
@@ -318,7 +318,7 @@ __used static int test_subprog(void)
 }
 
 SEC("socket")
-__failure __msg("jump table for insn 4 points outside of the subprog [0,10]")
+__failure __msg("jump table of subprog starting at 0 spans multiple subprogs")
 __naked void jump_table_outside_subprog(void)
 {
 	asm volatile ("						\
-- 
2.43.0

