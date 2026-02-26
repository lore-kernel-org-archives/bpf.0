Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14DAA425CF6
	for <bpf@vger.kernel.org>; Thu, 26 Feb 2026 16:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772122534; cv=none; b=JGAUtZVlpZG9hlF4QJnwQci9XINOfwL/O0iUfobUJE6EatveI3ppksy5fHotr0ddA6VRvvMW/E140tePRwz/8Z6JJBj1pt3uYudiMxi0C4hadkpad/mKdPnvBhoXcMrTBZ1rR94khZzfsCBQdLGJP9ok25IqMJfqg6ua5Vj6oPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772122534; c=relaxed/simple;
	bh=yTwnma+n/npJ+xFEgVJloTQt0eeuy2+PksRCGUU5K/Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o+CJZk/K9pkFMWcnKHeqtw235a9cVOWRDAt3bFqfeddQcNnrNIA40HlVhUxC7bPPqhKK41NOY8Fkno2s3/PMfUGx5Z9t/CEn1gIgyKr9zcZZt+8sVNuwBwQGtY/VzNSG+YZGCTNyDg1I64iFubXC+c/gY5FntkVwBR32Kkc6N6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bAgdhv7a; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bAgdhv7a"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4EF1C116C6;
	Thu, 26 Feb 2026 16:15:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772122534;
	bh=yTwnma+n/npJ+xFEgVJloTQt0eeuy2+PksRCGUU5K/Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bAgdhv7aZplwq7DdzIiOFzy5dnJxwqViqByZD5zm4jIE+ui70dTNgpz65TqMa1ffU
	 i0kaSwKEMH7cHDRFMESqAAjN3UQGtuigqt9GEGtGKPjAKRpOBTIJhduswVL8FfPZUF
	 CTeeFTl6CbwpgO586aPrO3Hcykc+7j9FyZ9AS0n0VjA6d0jogXFzqSUYvzkL03kE1w
	 2YAVfs0SbDm863ECbBbDWKH9ZsesH5dAJUXLyaaPCPHmNEcFLpc4yzTHBIJuvFca3B
	 sqICmxSoXv+0ANUFdnrc+pdBcnwIM5LcGPYlc0xJd7cwRrJJXZmbYalqRbctseotlZ
	 +/KOlQ7RaJ/lQ==
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
	kernel-team@meta.com
Subject: [PATCH bpf v5 4/8] bpf: consolidate sleepable checks in check_func_call()
Date: Thu, 26 Feb 2026 08:14:53 -0800
Message-ID: <20260226161500.775715-5-puranjay@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260226161500.775715-1-puranjay@kernel.org>
References: <20260226161500.775715-1-puranjay@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The sleepable context check for global function calls in
check_func_call() open-codes the same checks that in_sleepable_context()
already performs. Replace the open-coded check with a call to
in_sleepable_context() and use non_sleepable_context_description() for
the error message, consistent with check_helper_call() and
check_kfunc_call().

Note that in_sleepable_context() also checks active_locks, which
overlaps with the existing active_locks check above it. However, the two
checks serve different purposes: the active_locks check rejects all
global function calls while holding a lock (not just sleepable ones), so
it must remain as a separate guard.

Update the expected error messages in the irq and preempt_lock selftests
to match.

Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
---
 kernel/bpf/verifier.c                            | 11 +++++------
 tools/testing/selftests/bpf/progs/irq.c          |  4 ++--
 tools/testing/selftests/bpf/progs/preempt_lock.c |  6 +++---
 3 files changed, 10 insertions(+), 11 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 270d45b345a3..061f93d0c2c2 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -210,6 +210,8 @@ static bool in_rbtree_lock_required_cb(struct bpf_verifier_env *env);
 static int ref_set_non_owning(struct bpf_verifier_env *env,
 			      struct bpf_reg_state *reg);
 static bool is_trusted_reg(const struct bpf_reg_state *reg);
+static inline bool in_sleepable_context(struct bpf_verifier_env *env);
+static const char *non_sleepable_context_description(struct bpf_verifier_env *env);
 
 static bool bpf_map_ptr_poisoned(const struct bpf_insn_aux_data *aux)
 {
@@ -10865,12 +10867,9 @@ static int check_func_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 			return -EINVAL;
 		}
 
-		if (env->subprog_info[subprog].might_sleep &&
-		    (env->cur_state->active_rcu_locks || env->cur_state->active_preempt_locks ||
-		     env->cur_state->active_irq_id || !in_sleepable(env))) {
-			verbose(env, "global functions that may sleep are not allowed in non-sleepable context,\n"
-				     "i.e., in a RCU/IRQ/preempt-disabled section, or in\n"
-				     "a non-sleepable BPF program context\n");
+		if (env->subprog_info[subprog].might_sleep && !in_sleepable_context(env)) {
+			verbose(env, "sleepable global function %s() called in %s\n",
+				sub_name, non_sleepable_context_description(env));
 			return -EINVAL;
 		}
 
diff --git a/tools/testing/selftests/bpf/progs/irq.c b/tools/testing/selftests/bpf/progs/irq.c
index 74d912b22de9..e11e82d98904 100644
--- a/tools/testing/selftests/bpf/progs/irq.c
+++ b/tools/testing/selftests/bpf/progs/irq.c
@@ -490,7 +490,7 @@ int irq_non_sleepable_global_subprog(void *ctx)
 }
 
 SEC("?syscall")
-__failure __msg("global functions that may sleep are not allowed in non-sleepable context")
+__failure __msg("sleepable global function")
 int irq_sleepable_helper_global_subprog(void *ctx)
 {
 	unsigned long flags;
@@ -502,7 +502,7 @@ int irq_sleepable_helper_global_subprog(void *ctx)
 }
 
 SEC("?syscall")
-__failure __msg("global functions that may sleep are not allowed in non-sleepable context")
+__failure __msg("sleepable global function")
 int irq_sleepable_global_subprog_indirect(void *ctx)
 {
 	unsigned long flags;
diff --git a/tools/testing/selftests/bpf/progs/preempt_lock.c b/tools/testing/selftests/bpf/progs/preempt_lock.c
index 7d04254e61f1..6d5fce7e6ffc 100644
--- a/tools/testing/selftests/bpf/progs/preempt_lock.c
+++ b/tools/testing/selftests/bpf/progs/preempt_lock.c
@@ -177,7 +177,7 @@ global_subprog_calling_sleepable_global(int i)
 }
 
 SEC("?syscall")
-__failure __msg("global functions that may sleep are not allowed in non-sleepable context")
+__failure __msg("sleepable global function")
 int preempt_global_sleepable_helper_subprog(struct __sk_buff *ctx)
 {
 	preempt_disable();
@@ -188,7 +188,7 @@ int preempt_global_sleepable_helper_subprog(struct __sk_buff *ctx)
 }
 
 SEC("?syscall")
-__failure __msg("global functions that may sleep are not allowed in non-sleepable context")
+__failure __msg("sleepable global function")
 int preempt_global_sleepable_kfunc_subprog(struct __sk_buff *ctx)
 {
 	preempt_disable();
@@ -199,7 +199,7 @@ int preempt_global_sleepable_kfunc_subprog(struct __sk_buff *ctx)
 }
 
 SEC("?syscall")
-__failure __msg("global functions that may sleep are not allowed in non-sleepable context")
+__failure __msg("sleepable global function")
 int preempt_global_sleepable_subprog_indirect(struct __sk_buff *ctx)
 {
 	preempt_disable();
-- 
2.47.3

