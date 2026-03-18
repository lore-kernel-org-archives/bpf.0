Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B21572EC0B5
	for <bpf@vger.kernel.org>; Wed, 18 Mar 2026 17:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773855819; cv=none; b=e5fYJZLkBaWj3MHJ+wkNf2dG76C6HdukBS9W+fkgcBob/DKiGNVS+NzSJUiduEve6+bPRtpAX/b8GFwockAcVKwYi91ECUZ2SAvEEM0kv5tEv8ncD2+oIV7xpSCLqxrfwA+LNLlefm/Rdn4UMZYioKqHLkNWv0/6y059bJPe7Kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773855819; c=relaxed/simple;
	bh=Pnva7OPhe8RnZzadefuduiZMvAq8W7RRGibsbvdjFzg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jyxCx1YQ5jxaDCXOnWv7NHtgA9faRu5GQSJzWY04/5ZMO20oHlIuOcoTpqChMMIvrBibZODii+LU+r/Byc3OnszYvpBBlK7XTOIdzasPrl1N/G8Wx2fsG9yqabuhzWhSZdNFdIP+2FmQgO7g+zLZGaJgu7digS4SzHA92eHOF1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H4Uh27kp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H4Uh27kp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DAFEC19421;
	Wed, 18 Mar 2026 17:43:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773855819;
	bh=Pnva7OPhe8RnZzadefuduiZMvAq8W7RRGibsbvdjFzg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=H4Uh27kp0do2GHVD77KLifoqDxvlyWP6EJerWwwwtPF2MakfYdc5HmRB3EaNf7/6R
	 O3ZprPlx+oh53brpkIvMQk1a60N8mSeQEx/FxatNyXQGktlB9dWE3yLt5/OrQTvLB9
	 QxiuUC3M1RKN9KTQqZdXNCx3vDGySrokgp6j3E0C22wiHfIzULl8yYN62MEIKwsd87
	 AIh96TN426U6ihm7vOxzn/UCVCmpJep5cZgL97rPMv4Hs5gy4YFbK6WnOiiM4QXeEm
	 QLtROH+x98Bt6pyPaPjL1zGxf2Ysr0pNO0U1o5MthDx7krOHzIC8KU3dFDlEDx038p
	 fGolGcKOZwo4Q==
From: Puranjay Mohan <puranjay@kernel.org>
To: bpf@vger.kernel.org
Cc: Puranjay Mohan <puranjay@kernel.org>,
	Puranjay Mohan <puranjay12@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>,
	kernel-team@meta.com,
	Mykyta Yatsenko <yatsenko@meta.com>
Subject: [PATCH bpf-next 1/3] bpf: Consolidate sleepable checks in check_helper_call()
Date: Wed, 18 Mar 2026 10:43:24 -0700
Message-ID: <20260318174327.3151925-2-puranjay@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260318174327.3151925-1-puranjay@kernel.org>
References: <20260318174327.3151925-1-puranjay@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

check_helper_call() prints the error message for every
env->cur_state->active* element when calling a sleepable helper.
Consolidate all of them into a single print statement.

The check for env->cur_state->active_locks was not part of the removed
print statements and will not be triggered with the consolidated print
as well because it is checked in do_check() before check_helper_call()
is even reached.

Acked-by: Mykyta Yatsenko <yatsenko@meta.com>
Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
---
 kernel/bpf/verifier.c                         | 44 +++++++------------
 .../selftests/bpf/prog_tests/summarization.c  |  2 +-
 .../bpf/progs/verifier_async_cb_context.c     |  4 +-
 3 files changed, 20 insertions(+), 30 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 01c18f4268de..4e0f6be5d2d5 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -11678,6 +11678,19 @@ static inline bool in_sleepable_context(struct bpf_verifier_env *env)
 	       in_sleepable(env);
 }
 
+static const char *non_sleepable_context_description(struct bpf_verifier_env *env)
+{
+	if (env->cur_state->active_rcu_locks)
+		return "rcu_read_lock region";
+	if (env->cur_state->active_preempt_locks)
+		return "non-preemptible region";
+	if (env->cur_state->active_irq_id)
+		return "IRQ-disabled region";
+	if (env->cur_state->active_locks)
+		return "lock region";
+	return "non-sleepable prog";
+}
+
 static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 			     int *insn_idx_p)
 {
@@ -11717,11 +11730,6 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
 		return -EINVAL;
 	}
 
-	if (!in_sleepable(env) && fn->might_sleep) {
-		verbose(env, "helper call might sleep in a non-sleepable prog\n");
-		return -EINVAL;
-	}
-
 	/* With LD_ABS/IND some JITs save/restore skb from r1. */
 	changes_data = bpf_helper_changes_pkt_data(func_id);
 	if (changes_data && fn->arg1_type != ARG_PTR_TO_CTX) {
@@ -11738,28 +11746,10 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
 		return err;
 	}
 
-	if (env->cur_state->active_rcu_locks) {
-		if (fn->might_sleep) {
-			verbose(env, "sleepable helper %s#%d in rcu_read_lock region\n",
-				func_id_name(func_id), func_id);
-			return -EINVAL;
-		}
-	}
-
-	if (env->cur_state->active_preempt_locks) {
-		if (fn->might_sleep) {
-			verbose(env, "sleepable helper %s#%d in non-preemptible region\n",
-				func_id_name(func_id), func_id);
-			return -EINVAL;
-		}
-	}
-
-	if (env->cur_state->active_irq_id) {
-		if (fn->might_sleep) {
-			verbose(env, "sleepable helper %s#%d in IRQ-disabled region\n",
-				func_id_name(func_id), func_id);
-			return -EINVAL;
-		}
+	if (fn->might_sleep && !in_sleepable_context(env)) {
+		verbose(env, "sleepable helper %s#%d in %s\n", func_id_name(func_id), func_id,
+			non_sleepable_context_description(env));
+		return -EINVAL;
 	}
 
 	/* Track non-sleepable context for helpers. */
diff --git a/tools/testing/selftests/bpf/prog_tests/summarization.c b/tools/testing/selftests/bpf/prog_tests/summarization.c
index 5dd6c120a838..6951786044ca 100644
--- a/tools/testing/selftests/bpf/prog_tests/summarization.c
+++ b/tools/testing/selftests/bpf/prog_tests/summarization.c
@@ -58,7 +58,7 @@ static void test_aux(const char *main_prog_name,
 	 * this particular combination can be enabled.
 	 */
 	if (!strcmp("might_sleep", replacement) && err) {
-		ASSERT_HAS_SUBSTR(log, "helper call might sleep in a non-sleepable prog", "error log");
+		ASSERT_HAS_SUBSTR(log, "sleepable helper bpf_copy_from_user#", "error log");
 		ASSERT_EQ(err, -EINVAL, "err");
 		test__skip();
 		goto out;
diff --git a/tools/testing/selftests/bpf/progs/verifier_async_cb_context.c b/tools/testing/selftests/bpf/progs/verifier_async_cb_context.c
index 39aff82549c9..6bf95550a024 100644
--- a/tools/testing/selftests/bpf/progs/verifier_async_cb_context.c
+++ b/tools/testing/selftests/bpf/progs/verifier_async_cb_context.c
@@ -31,7 +31,7 @@ static int timer_cb(void *map, int *key, struct bpf_timer *timer)
 }
 
 SEC("fentry/bpf_fentry_test1")
-__failure __msg("helper call might sleep in a non-sleepable prog")
+__failure __msg("sleepable helper bpf_copy_from_user#{{[0-9]+}} in non-sleepable prog")
 int timer_non_sleepable_prog(void *ctx)
 {
 	struct timer_elem *val;
@@ -47,7 +47,7 @@ int timer_non_sleepable_prog(void *ctx)
 }
 
 SEC("lsm.s/file_open")
-__failure __msg("helper call might sleep in a non-sleepable prog")
+__failure __msg("sleepable helper bpf_copy_from_user#{{[0-9]+}} in non-sleepable prog")
 int timer_sleepable_prog(void *ctx)
 {
 	struct timer_elem *val;
-- 
2.52.0

