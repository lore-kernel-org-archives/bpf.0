Received: from mail-wm2-f9.google.com (mail-wm2-f9.google.com [74.125.225.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C58F542EEAB
	for <bpf@vger.kernel.org>; Tue,  4 Aug 2026 08:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785831080; cv=none; b=gP71rBZ8tA49mGTIsG+9crefMu1EM833idaRaTeJEjVc8qZtF/hH3Sw1dLxf8LwyBej39MaMzy6A2aOcYwaZNkWwld+aVxt5EsTRZVNZyIZjvPL0lKBtvy1HUfKSgXSoAOPRij770lSX2ysL29dse4AiGSLXzE/lMdkD2wEkocI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785831080; c=relaxed/simple;
	bh=hZGqtUYD9EhY2Q4ktvw1ITktgKCGcMeO4XAoDDvwr8M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a2Zls5YuxyXUjYDBO2RL8V5CH+fL2/ag1uzpx1QpQCJCXu3FXw0myQ7lTojIpEEAauCZvivaOg/8JjYOk7xWx1tix2WazUtPo44nW9wRBkdZiNuKtAX110/PI6BjC/W2soLyZ9i9BWjvfVz2aQAAlugdHBTDzwNqSnaqNDFXl6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D4HsRjzm; arc=none smtp.client-ip=74.125.225.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D4HsRjzm"
Received: by mail-wm2-f9.google.com with SMTP id 5b1f17b1804b1-49556ce3549so11562625e9.0
        for <bpf@vger.kernel.org>; Tue, 04 Aug 2026 01:11:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785831077; x=1786435877; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BibKR/izJpAfphXxuzQ8e5UnIO/qP9+2RsaQ0hgTNfE=;
        b=D4HsRjzmMB0lrdFWhYTXLjasEfIkNwMfbZYpkmrQ/qWAUA1yD+owOas7UAlr21frsM
         cg0+pQcSg247g+/TKUd8r5GxgUDJQk49Z3Sl0ACQFTvwqHkGGc7Nm9C63/j6/XvLzytJ
         6J3+ztxHqt2EfZKZUipga7X7g6sJAel6LQubjgrybpUhxyLNPubuGTECDXQ53vxOCtaY
         RA+0cwGDIujffhtDq6L/fmT7MJlPFXnSO4V2rOVzywYwRa/39tKfqZzOyoaCwF9kuLey
         RdVN8Di6cpGzCY9t/mGfpOMulTqUS0rCIdhKDmTs3fVrSFYWPwfYpoilS3HBxHzQHr7X
         DgKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785831077; x=1786435877;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=BibKR/izJpAfphXxuzQ8e5UnIO/qP9+2RsaQ0hgTNfE=;
        b=pn+PKJ4LVkXskc9J7kWCyuAkp8L/w01F7PWKyq1bJty7oIyA+cvo6EWFF/N8mTCpAV
         zFsprbqtTCrhGgd/e1J+FBewUkq51EnsR4/kLmjHSFnAy5/ZtgH9Ql3wD+huJFj/5aof
         Dsc2iEFwuHD0Q0aM39n0AGeiM+N1afoIBrZSOvrNleWIXYsgFvVFsTO2UODNhnppfC3o
         1AJrGTzFmw4uYXVr74AKGnA3TZK3PVRsaPkHMiljj0/eKYG7HJ8kx1zyizFNckaNx/B/
         4D2k3sQkqm/KpK5WMMx/cWgZ1mLbA97JRU1LkX1Z6BhAI4FpB1LZz9zuflUjj6idQkBB
         Taew==
X-Gm-Message-State: AOJu0YyMBshtylfMhscPgiFxbMbC3YUDrXVzJUTKHB10Un6Qw1t02Zj+
	TA1ZNUP9UbK87+tpLVMHZZghhdMyBJTae4AbpaklpfxuXpibJNg9fRCrIhUm2CmO
X-Gm-Gg: AR+sD11IuF3QB4bzPZnb5Cqa/4UVYx91g2bErTN9JmUV7kUIJCucp/lSE40+b2Mzcsn
	WunabIs5cVn9SxOAk3J7CDs4y9T/ml747NZ5m41Gk+Y/f/BHtjcQe66qz1OK36egMxTrY7r6iAc
	4utMtDHh+5BELBOuItK458wEt2srpN3SpatOwmTOMGViyoHEKlowi5F2vmruvg7fpbU7qnqbFKI
	eVrT0/L/i+R1GQ6R8a45nEnVXMWC2ykLQwVUgB3Xy6ewi2GT7EWn/g6dqevXlmxDGL9yhrun17x
	Cf9aIKebwT5CK67Fj+c7GXJq1VrsWb4cDYpBuiCXpMtcNBSvvG1LhKWm1oF9DW2jALs17DDmibI
	BEO6c33LBWXKcEhaBuNFygmPuLfHMDJHSK6EfVbUS7ZguZaYgvzgjUCgKFmWIwVLyUuckDjGSmJ
	JqxAzMivDLWZuqa8euyheEPaNnx+KAXhkP+ms0tM8NmHSq3bb2QQBVhm4I/VHQ2DP0NS7KTDuJ3
	Z5IxsnRsNSKT2Eu3kHTurAFbpGVKH8Up09NygHTXPAGLhI8DB2OVx181QvnRNnvdRCTBdPys5D/
	VWa+fjWFCSvX4vsESLcJPRf4n1g=
X-Received: by 2002:a05:600c:8b33:b0:495:779a:ed33 with SMTP id 5b1f17b1804b1-4980c66c798mr338477105e9.7.1785831076575;
        Tue, 04 Aug 2026 01:11:16 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fd458bb4esm39852179f8f.30.2026.08.04.01.11.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 01:11:16 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Andrii Nakryiko <andrii@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v5 1/3] bpf: Show more useful info in stack depth stats
Date: Tue,  4 Aug 2026 10:11:10 +0200
Message-ID: <20260804081114.3871564-2-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260804081114.3871564-1-memxor@gmail.com>
References: <20260804081114.3871564-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=10658; i=memxor@gmail.com; h=from:subject; bh=hZGqtUYD9EhY2Q4ktvw1ITktgKCGcMeO4XAoDDvwr8M=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIatwnq/5yitzTLTm3Fo/I/W4U1aC2fLjS1WnK391cDtnc CDPelFgRykLgxgXg6yYIkvJ/31MxicqfwfaLuOGmcPKBDKEgYtTACZizsnIMOFBZe1Ov/fuRywu nyjpf5l0haVs8zK7r2HWzm3vC8/wfWX4K2LNGbtd6hvThs5VJ5k0e3W59s4X3CuiyVjR8z5jiiw DAwA=
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

Stack depth statistics list captured depths in subprogram-number order,
while per-verification instruction counts are reported separately. Since
libbpf determines subprogram numbers, it is hard to associate either
statistic with its subprogram name or see where verifier work is spent.

Keep the combined maximum stack depth on its own line, then print a record
for the main program and each subprogram:

stack depth max <depth>
prog (<name>) insns <count> stack <depth>
subprog <number> (<name>) insns <count> stack <depth>

When no subprogram name is available, print <unknown>. Keep the existing
aggregate "processed ... insns" record unchanged for compatibility.

Suggested-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/verifier.c                         | 24 ++++++++++++-------
 .../bpf/progs/verifier_basic_stack.c          |  4 ++--
 .../bpf/progs/verifier_bpf_fastcall.c         | 23 +++++++++++-------
 .../bpf/progs/verifier_global_subprogs.c      |  2 +-
 .../bpf/progs/verifier_private_stack.c        | 15 +++++++++---
 .../selftests/bpf/progs/verifier_var_off.c    |  4 ++--
 6 files changed, 47 insertions(+), 25 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index b274004fccfd..80c249906fd3 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -18777,15 +18777,21 @@ static void print_verification_stats(struct bpf_verifier_env *env)
 	if (env->log.level & BPF_LOG_STATS) {
 		verbose(env, "verification time %lld usec\n",
 			div_u64(env->verification_time, 1000));
-		verbose(env, "stack depth %d", env->subprog_info[0].stack_depth);
-		for (i = 1; i < subprog_cnt; i++)
-			verbose(env, "+%d", env->subprog_info[i].stack_depth);
-		verbose(env, " max %d\n", env->max_stack_depth);
-		verbose(env, "insns processed %d", env->subprog_info[0].insn_processed);
-		for (i = 1; i < subprog_cnt; i++)
-			if (bpf_subprog_is_global(env, i))
-				verbose(env, "+%d", env->subprog_info[i].insn_processed);
-		verbose(env, "\n");
+		verbose(env, "stack depth max %d\n", env->max_stack_depth);
+		for (i = 0; i < subprog_cnt; i++) {
+			const char *name = env->subprog_info[i].name;
+
+			if (!name || !name[0])
+				name = "<unknown>";
+			if (i == 0)
+				verbose(env, "prog (%s) insns %d stack %d\n", name,
+					env->subprog_info[i].insn_processed,
+					env->subprog_info[i].stack_depth);
+			else
+				verbose(env, "subprog %d (%s) insns %d stack %d\n", i, name,
+					env->subprog_info[i].insn_processed,
+					env->subprog_info[i].stack_depth);
+		}
 	}
 	verbose(env, "processed %d insns (limit %d) max_states_per_insn %d "
 		"total_states %d peak_states %d mark_read %d\n",
diff --git a/tools/testing/selftests/bpf/progs/verifier_basic_stack.c b/tools/testing/selftests/bpf/progs/verifier_basic_stack.c
index fb62e09f2114..47b12c6f8efd 100644
--- a/tools/testing/selftests/bpf/progs/verifier_basic_stack.c
+++ b/tools/testing/selftests/bpf/progs/verifier_basic_stack.c
@@ -27,7 +27,7 @@ __naked void stack_out_of_bounds(void)
 
 SEC("socket")
 __description("uninitialized stack1")
-__success __log_level(4) __msg("stack depth 8")
+__success __log_level(4) __msg("prog (uninitialized_stack1) insns {{[0-9]+}} stack 8")
 __failure_unpriv __msg_unpriv("invalid read from stack")
 __naked void uninitialized_stack1(void)
 {
@@ -45,7 +45,7 @@ __naked void uninitialized_stack1(void)
 
 SEC("socket")
 __description("uninitialized stack2")
-__success __log_level(4) __msg("stack depth 8")
+__success __log_level(4) __msg("prog (uninitialized_stack2) insns {{[0-9]+}} stack 8")
 __failure_unpriv __msg_unpriv("invalid read from stack")
 __naked void uninitialized_stack2(void)
 {
diff --git a/tools/testing/selftests/bpf/progs/verifier_bpf_fastcall.c b/tools/testing/selftests/bpf/progs/verifier_bpf_fastcall.c
index 83707faea049..43ce0bd8e4eb 100644
--- a/tools/testing/selftests/bpf/progs/verifier_bpf_fastcall.c
+++ b/tools/testing/selftests/bpf/progs/verifier_bpf_fastcall.c
@@ -10,7 +10,7 @@
 
 SEC("raw_tp")
 __arch_x86_64
-__log_level(4) __msg("stack depth 8")
+__log_level(4) __msg("prog (simple) insns {{[0-9]+}} stack 8")
 __xlated("4: r5 = 5")
 __xlated("5: r0 = ")
 __xlated("6: r0 = &(void __percpu *)(r0)")
@@ -96,7 +96,7 @@ __naked void canary_zero_spills(void)
 
 SEC("raw_tp")
 __arch_x86_64
-__log_level(4) __msg("stack depth 16")
+__log_level(4) __msg("prog (wrong_reg_in_pattern1) insns {{[0-9]+}} stack 16")
 __xlated("1: *(u64 *)(r10 -16) = r1")
 __xlated("...")
 __xlated("3: r0 = &(void __percpu *)(r0)")
@@ -598,7 +598,7 @@ __naked static void subprogs_use_independent_offsets_aux(void)
 
 SEC("raw_tp")
 __arch_x86_64
-__log_level(4) __msg("stack depth 8")
+__log_level(4) __msg("prog (helper_call_does_not_prevent_bpf_fastcall) insns {{[0-9]+}} stack 8")
 __xlated("2: r0 = &(void __percpu *)(r0)")
 __success
 __naked void helper_call_does_not_prevent_bpf_fastcall(void)
@@ -620,7 +620,7 @@ __naked void helper_call_does_not_prevent_bpf_fastcall(void)
 
 SEC("raw_tp")
 __arch_x86_64
-__log_level(4) __msg("stack depth 24")
+__log_level(4) __msg("prog (may_goto_interaction_x86_64) insns {{[0-9]+}} stack 24")
 /* may_goto counter at -24 */
 __xlated("0: *(u64 *)(r10 -24) =")
 /* may_goto timestamp at -16 */
@@ -661,7 +661,7 @@ __naked void may_goto_interaction_x86_64(void)
 SEC("raw_tp")
 __arch_arm64
 __arch_riscv64
-__log_level(4) __msg("stack depth 24")
+__log_level(4) __msg("prog (may_goto_interaction) insns {{[0-9]+}} stack 24")
 /* may_goto counter at -24 */
 __xlated("0: *(u64 *)(r10 -24) =")
 /* may_goto timestamp at -16 */
@@ -708,7 +708,9 @@ __naked static void dummy_loop_callback(void)
 
 SEC("raw_tp")
 __arch_x86_64
-__log_level(4) __msg("stack depth 32+0")
+__log_level(4)
+__msg("prog (bpf_loop_interaction1) insns {{[0-9]+}} stack 32")
+__msg("subprog 1 (dummy_loop_callback) insns {{[0-9]+}} stack 0")
 __xlated("2: r1 = 1")
 __xlated("3: r0 =")
 __xlated("4: r0 = &(void __percpu *)(r0)")
@@ -756,7 +758,9 @@ __naked int bpf_loop_interaction1(void)
 
 SEC("raw_tp")
 __arch_x86_64
-__log_level(4) __msg("stack depth 40+0")
+__log_level(4)
+__msg("prog (bpf_loop_interaction2) insns {{[0-9]+}} stack 40")
+__msg("subprog 1 (dummy_loop_callback) insns {{[0-9]+}} stack 0")
 /* call bpf_get_smp_processor_id */
 __xlated("2: r1 = 42")
 __xlated("3: r0 =")
@@ -800,7 +804,10 @@ __naked int bpf_loop_interaction2(void)
 
 SEC("raw_tp")
 __arch_x86_64
-__log_level(4) __msg("stack depth 512+0 max 512")
+__log_level(4)
+__msg("stack depth max 512")
+__msg("prog (cumulative_stack_depth) insns {{[0-9]+}} stack 512")
+__msg("subprog 1 (cumulative_stack_depth_subprog) insns {{[0-9]+}} stack 0")
 /* just to print xlated version when debugging */
 __xlated("r0 = &(void __percpu *)(r0)")
 __success
diff --git a/tools/testing/selftests/bpf/progs/verifier_global_subprogs.c b/tools/testing/selftests/bpf/progs/verifier_global_subprogs.c
index 67dc352addfd..1755f133f020 100644
--- a/tools/testing/selftests/bpf/progs/verifier_global_subprogs.c
+++ b/tools/testing/selftests/bpf/progs/verifier_global_subprogs.c
@@ -52,7 +52,7 @@ __msg("('global_calls_good_only') is global and assumed valid.")
 /* eventually global_good() is transitively validated as well */
 __msg("Validating global_good() func")
 __msg("('global_good') is safe for any args that match its prototype")
-__msg("insns processed {{[0-9]+\\+[0-9]+\\+[0-9]+$}}")
+__msg("prog (chained_global_func_calls_success) insns {{[0-9]+}} stack")
 int chained_global_func_calls_success(void)
 {
 	int sum = 0;
diff --git a/tools/testing/selftests/bpf/progs/verifier_private_stack.c b/tools/testing/selftests/bpf/progs/verifier_private_stack.c
index bb8206e10880..ab5c53c30a0c 100644
--- a/tools/testing/selftests/bpf/progs/verifier_private_stack.c
+++ b/tools/testing/selftests/bpf/progs/verifier_private_stack.c
@@ -86,7 +86,9 @@ __naked static void cumulative_stack_depth_subprog(void)
 SEC("kprobe")
 __description("Private stack, subtree > MAX_BPF_STACK")
 __success
-__log_level(4) __msg("stack depth 512+32 max 512")
+__log_level(4) __msg("stack depth max 512")
+__msg("prog (private_stack_nested_1) insns {{[0-9]+}} stack 512")
+__msg("subprog 1 (cumulative_stack_depth_subprog) insns {{[0-9]+}} stack 32")
 __arch_x86_64
 /* private stack fp for the main prog */
 __jited("	movabsq	$0x{{.*}}, %r9")
@@ -331,7 +333,11 @@ SEC("fentry/bpf_fentry_test9")
 __description("Private stack, async callback, potential nesting")
 __success __retval(0)
 __load_if_JITed()
-__log_level(4) __msg("stack depth 8+0+256+0 max 272")
+__log_level(4) __msg("stack depth max 272")
+__msg("prog (private_stack_async_callback_2) insns {{[0-9]+}} stack 8")
+__msg("subprog 1 (timer_cb1) insns {{[0-9]+}} stack 0")
+__msg("subprog 2 (subprog1) insns {{[0-9]+}} stack 256")
+__msg("subprog 3 (subprog2) insns {{[0-9]+}} stack 0")
 __arch_x86_64
 __jited("	subq	$0x100, %rsp")
 __arch_arm64
@@ -355,7 +361,10 @@ int private_stack_async_callback_2(void)
 SEC("fentry/bpf_fentry_test9")
 __description("private stack, max stack depth is private stack")
 __success
-__log_level(4) __msg("stack depth 8+256+0 max 256")
+__log_level(4) __msg("stack depth max 256")
+__msg("prog (private_stack_max_depth) insns {{[0-9]+}} stack 8")
+__msg("subprog 1 (subprog1) insns {{[0-9]+}} stack 256")
+__msg("subprog 2 (subprog2) insns {{[0-9]+}} stack 0")
 int private_stack_max_depth(void)
 {
 	int x = 0;
diff --git a/tools/testing/selftests/bpf/progs/verifier_var_off.c b/tools/testing/selftests/bpf/progs/verifier_var_off.c
index 24cd0a763673..6eb7d3ae49e8 100644
--- a/tools/testing/selftests/bpf/progs/verifier_var_off.c
+++ b/tools/testing/selftests/bpf/progs/verifier_var_off.c
@@ -198,7 +198,7 @@ __success
 /* Check that the maximum stack depth is correctly maintained according to the
  * maximum possible variable offset.
  */
-__log_level(4) __msg("stack depth 16")
+__log_level(4) __msg("prog (stack_write_priv_vs_unpriv) insns {{[0-9]+}} stack 16")
 __failure_unpriv
 /* Variable stack access is rejected for unprivileged.
  */
@@ -238,7 +238,7 @@ __success
 /* Check that the maximum stack depth is correctly maintained according to the
  * maximum possible variable offset.
  */
-__log_level(4) __msg("stack depth 16")
+__log_level(4) __msg("prog (stack_write_followed_by_read) insns {{[0-9]+}} stack 16")
 __failure_unpriv
 __msg_unpriv("R2 variable stack access prohibited for !root")
 __retval(0)
-- 
2.53.0

