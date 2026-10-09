Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A4C34BFE6D
	for <bpf@vger.kernel.org>; Fri,  9 Oct 2026 10:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791542919; cv=none; b=V7yye9pd14czObQMDTsxJ0afHWgBF8WgZe+cUgdiSg0fCVr9jZzJzYSYUBI3mGBrvBkFqHaOYuo+kEgLJFJTkOrH3+w4+lNW3GcOl3zHf0FGCUhZd6v4WApj9G8IqHPBBJ7vFxN9A/fvtawAcqUbChljDjL23YmobSCgYdm/prA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791542919; c=relaxed/simple;
	bh=lajuIOesg/NeCpHdoi8lCw+w90Q1DU9PcBXZvItJroI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ETnCbMfS87BqXpkac6Q6BMrUJPlBU+XnqMttO+jrJJyh4jzj98sRTZxOsjTT2xMLtYbX7Qdf7hL3xthQJYm8uJE/V6OrpXMVm1cvaKwBIqEytTMbgXIzcEPz8keEjV+nDnu921fBSbBDuOenFyJYshMrGkO8hKUj/PTEkkbfUDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jaWhe749; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jaWhe749"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-398b3c37877so2540532a91.0
        for <bpf@vger.kernel.org>; Fri, 09 Oct 2026 03:48:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791542906; x=1792147706; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=koiJtZA94JanWVUMZ6UJcZjGKN8n+KIcDXfCyKy5XSY=;
        b=jaWhe749vgFDiK0Fmy391RPAg3GLDrTz8s438Ix8fZDIm2lOLZ7SCOy2m3L+Ed3Uwp
         /5OvkO2h87TdJ4LRb/Nn3fBP1bnBQn/uz1XUpuI/1dClcdFCGaNEMotJv0ZvhG00J9Ee
         Xqp049pdtjsR6c1G5So2RQM9FoA1sY4CGuQHgiWpzRx3MewN0fB99vLfAfN2591k4lb4
         P+afABucrBKgDc7MwRDrWwwm276GMS2es7RprluPdr82p18cpfRFgPl8pXc0anZCi7yd
         x5ddwivasa9N0Pacr+lffpHy3fCEC9L9gbD0wGdobaz8An8azvdJZsJKLZ2zFH01Hk74
         fbaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791542906; x=1792147706;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=koiJtZA94JanWVUMZ6UJcZjGKN8n+KIcDXfCyKy5XSY=;
        b=FFSgq/REOLuRgmarzlUvVrfJ+a5ILyGfBBiB9WbF8Ve89tmfR5cZZG/6uRMfJfQBnI
         jOxQknYsnekVf8lSUmgECoylXlRTeXonrYYdDpG9gm89cMYYSt7bBAuOwAnhnFdKna7T
         XBnllviun6Vp6WNF35Hh5Mx2Ru3eUo2824lvo9T1EhyArhZ7XBvcVU33bT5IWuQV5fia
         UJjzPriNYmSN3CyLt8+15Y0aPhLQw4T/pgPM2u9tXMGy0et6dxwuAx+CTofAo5caJqAF
         at0ue4PBYlOuQYJR43C6I+4y1uz2+1VLDYCdpjUZXt1f5lBkb2lFKG26tKC5ksL+EZ2C
         gq0Q==
X-Gm-Message-State: AFq9FYLqzOGM+g+utlG5NV8JfX4IK1499ZwtCaJjZAfCbkA0msWrmHzB
	0fKmkqdKMqttLRiufpMTogRSu+ApeeTLtOIYIsidvefYpVTy8sR1T8aj6xxupsQj
X-Gm-Gg: AYBFou3+2l/XCkWDiAEboEBHiUve2uxSfG8sct8Ccxae8TsAaxyYlcHtDb6wwuyX8cf
	i9vClfhbn3Bvbdp60Q7g57HZrllMPmv58ZXNzWj5zffHe67EmQrSwFAOmwG0FbPeMM+mbX9nChW
	PRRNAXeKhOCjltJfAxH6GbCYOaYy18uGTHtdEhy+n7P7Af0ALUu2kwwjo9Oukm7Gu6J146i+lxw
	QA5kbHJIbuYGVyNNCnxK7VlJSET0nosP9cIholh/05MpKD3W5J3Gm1bvQjOBVIgLMQPyAGPvbeP
	H/ibuLuOdguBvSBvsUOS93jO5SGQym4dwwq3Fhxjrh5jMtpEZsYWGZv9xVE51zqYgJRxYg9NzHc
	77C70CDSYGajuekt7maYekd8DbmhoASznoqgq+fx7nXdlIRvOdT3quXKzkNay1e93DhpCaOvy73
	dRNnds++dAz5C19nD7zLPawoNoGHLZ0Fy1wu6EAYLZGAqadAjL0TN0nYmKb3dJImO5V3yYViU81
	MzfJt0NnKtYf7k=
X-Received: by 2002:a17:90b:3d89:b0:3ab:c6d:2bf9 with SMTP id 98e67ed59e1d1-3ab3afdaaacmr1557200a91.57.1791542905701;
        Fri, 09 Oct 2026 03:48:25 -0700 (PDT)
Received: from badger ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ab36ed053csm3050107a91.4.2026.10.09.03.48.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 03:48:25 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v3 11/51] bpf: compute parameters liveness in bpf_compute_live_registers()
Date: Fri,  9 Oct 2026 03:47:29 -0700
Message-ID: <20261009-scev-minimal-rebase-v3-11-bcba9bc53ac9@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261009-scev-minimal-rebase-v3-0-bcba9bc53ac9@gmail.com>
References: <20261009-scev-minimal-rebase-v3-0-bcba9bc53ac9@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

This computes exact liveness for the arguments of a call to a
subprogram instead of assuming that r1..r5 are read:
- For static subprograms compute use registers at the
  bpf_compute_live_registers() fixpoint phase.
- For global subprograms use BTF information.

Add a separate pass doing try_btf_prepare_func_args() in order for
bpf_subprog_info->arg_slot_cnt to be available during
bpf_compute_live_registers().

The conservative liveness marks hindered SCEV widening logic on a set
of production programs.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 kernel/bpf/liveness.c                              | 31 ++++++++++++++++++++--
 kernel/bpf/verifier.c                              | 24 +++++++++++++++++
 .../testing/selftests/bpf/prog_tests/exceptions.c  |  2 +-
 .../selftests/bpf/progs/compute_live_registers.c   | 12 ++++-----
 .../selftests/bpf/progs/verifier_live_stack.c      |  2 +-
 5 files changed, 61 insertions(+), 10 deletions(-)

diff --git a/kernel/bpf/liveness.c b/kernel/bpf/liveness.c
index a359e457e6c0..8d8428ccc505 100644
--- a/kernel/bpf/liveness.c
+++ b/kernel/bpf/liveness.c
@@ -2472,6 +2472,12 @@ static inline u32 mask_widen(u32 m) { return m | (m << 16); }
 static inline u16 mask_lo(u32 m) { return (u16)m; }
 static inline u16 mask_hi(u32 m) { return (u16)(m >> 16); }
 
+/* Index of the subprogram called by pseudo call @insn */
+static int callee_subprog(struct bpf_verifier_env *env, const struct bpf_insn *insn)
+{
+	return bpf_find_subprog(env, insn - env->prog->insnsi + insn->imm + 1);
+}
+
 /* Compute info->{use,def} fields for the instruction */
 static void compute_insn_live_regs(struct bpf_verifier_env *env,
 				   struct bpf_insn *insn,
@@ -2489,6 +2495,7 @@ static void compute_insn_live_regs(struct bpf_verifier_env *env,
 	const u32 dst32 = mask_lo(dst);
 	const u32 r0  = reg64_mask(0);
 	const u32 r2  = reg64_mask(BPF_REG_2);
+	int subprog, reg_args;
 	u32 def = 0;
 	u32 use = U32_MAX;
 
@@ -2613,8 +2620,18 @@ static void compute_insn_live_regs(struct bpf_verifier_env *env,
 		case BPF_CALL:
 			def = ALL_CALLER_SAVED_REGS;
 			use = def & ~BIT(BPF_REG_0);
-			if (bpf_get_call_summary(env, insn, &cs))
+			if (bpf_get_call_summary(env, insn, &cs)) {
 				use = GENMASK(min_t(u8, cs.arg_slot_cnt, MAX_BPF_FUNC_REG_ARGS), 1);
+			} else if (bpf_pseudo_call(insn)) {
+				/* a static callee's reads are added in bpf_compute_live_registers() */
+				subprog = callee_subprog(env, insn);
+				if (bpf_subprog_is_global(env, subprog)) {
+					reg_args = min_t(u8, env->subprog_info[subprog].arg_slot_cnt, MAX_BPF_FUNC_REG_ARGS);
+					use = GENMASK(reg_args, 1);
+				} else {
+					use = 0;
+				}
+			}
 			def = mask_widen(def);
 			use = mask_widen(use);
 			/* callx reads the address of the callee from dst_reg */
@@ -2699,11 +2716,21 @@ int bpf_compute_live_registers(struct bpf_verifier_env *env)
 			struct bpf_iarray *succ;
 			u32 new_out = 0;
 			u32 new_in = 0;
+			u32 use;
 
 			succ = bpf_insn_successors(env, insn_idx);
 			for (int s = 0; s < succ->cnt; ++s)
 				new_out |= state[succ->items[s]].in;
-			new_in = (new_out & ~live->def) | live->use;
+			use = live->use;
+			/*
+			 * For a call to a static subprogram include the callee's
+			 * entry 'in' as computed so far.
+			 */
+			if (bpf_pseudo_call(&insns[insn_idx]) &&
+			    !bpf_subprog_is_global(env, callee_subprog(env, &insns[insn_idx])))
+				use |= state[insn_idx + insns[insn_idx].imm + 1].in &
+				       mask_widen(GENMASK(BPF_REG_5, BPF_REG_1));
+			new_in = (new_out & ~live->def) | use;
 			if (new_out != live->out || new_in != live->in) {
 				live->in = new_in;
 				live->out = new_out;
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index a5456a6e2694..50cb564be9f7 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -10913,6 +10913,7 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env, int subprog, s
 	struct bpf_call_arg_meta meta;
 	struct bpf_func_proto *fn;
 	int ret, err;
+	u32 i;
 
 	memset(&meta, 0, sizeof(meta));
 	meta.btf = btf;
@@ -10939,6 +10940,15 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env, int subprog, s
 	meta.fn = fn;
 	meta.func_proto = func_proto;
 
+	/*
+	 * Check if all register arguments declared in BTF are initialized.
+	 * If they aren't the BTF is unreliable.
+	 */
+	if (!bpf_subprog_is_global(env, subprog)) {
+		for (i = 0; i < min_t(u32, sub->arg_slot_cnt, MAX_BPF_FUNC_REG_ARGS); i++)
+			if (caller->regs[BPF_REG_1 + i].type == NOT_INIT)
+				return -EINVAL;
+	}
 	return check_func_args(env, &meta, env->insn_idx);
 }
 
@@ -14591,6 +14601,18 @@ static bool try_btf_prepare_func_args(struct bpf_verifier_env *env, int subprog)
 	return !err;
 }
 
+/* Prepare argument metadata for liveness; the main program is handled separately. */
+static void prepare_subprog_args(struct bpf_verifier_env *env)
+{
+	int i;
+
+	for (i = 1; i < env->subprog_cnt; i++) {
+		if (!try_btf_prepare_func_args(env, i) && bpf_subprog_is_global(env, i))
+			/* Keep all argument registers live if the prototype is unavailable. */
+			env->subprog_info[i].arg_slot_cnt = MAX_BPF_FUNC_REG_ARGS;
+	}
+}
+
 /*
  * Derive stack effects for a global subprog's argument slot @arg (0-based)
  * from its declared type, matching the main pass's argument checks.
@@ -22836,6 +22858,8 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr,
 	if (ret < 0)
 		goto skip_full_check;
 
+	prepare_subprog_args(env);
+
 	ret = bpf_compute_live_registers(env);
 	if (ret < 0)
 		goto skip_full_check;
diff --git a/tools/testing/selftests/bpf/prog_tests/exceptions.c b/tools/testing/selftests/bpf/prog_tests/exceptions.c
index 3705db18c1bb..cea01d638f6f 100644
--- a/tools/testing/selftests/bpf/prog_tests/exceptions.c
+++ b/tools/testing/selftests/bpf/prog_tests/exceptions.c
@@ -322,7 +322,7 @@ static void test_exceptions_success(void)
 				       bpf_program__fd(skel->progs.exception_throw_subprog),
 				       "subprog"), "set_attach_target"))
 				goto done;
-		}), "subprog() is not a global function", 0);
+		}), "Cannot replace static functions", 0);
 
 	if (test__start_subtest("non-throwing extension -> throwing subprog"))
 		/* non-throwing extension -> throwing subprog : BAD (!global) */
diff --git a/tools/testing/selftests/bpf/progs/compute_live_registers.c b/tools/testing/selftests/bpf/progs/compute_live_registers.c
index 941b65fe7c07..b274a20ed7bd 100644
--- a/tools/testing/selftests/bpf/progs/compute_live_registers.c
+++ b/tools/testing/selftests/bpf/progs/compute_live_registers.c
@@ -416,11 +416,11 @@ static __used __naked int aux1(void)
 
 SEC("socket")
 __log_level(2)
-__msg("0: ....45.... (b7) r1 = 1")
-__msg("1: .1..45.... (b7) r2 = 2")
-__msg("2: .12.45.... (b7) r3 = 3")
-/* Conservative liveness for subprog parameters. */
-__msg("3: .12345.... (85) call pc+2")
+__msg("0: .......... (b7) r1 = 1")
+__msg("1: .1........ (b7) r2 = 2")
+__msg("2: .12....... (b7) r3 = 3")
+/* A static callee reads what its code reads: aux1 reads r1 and r2. */
+__msg("3: .12....... (85) call pc+2")
 __msg("4: .......... (b7) r0 = 0")
 __msg("5: 0......... (95) exit")
 __msg("6: .12....... (bf) r0 = r1")
@@ -452,7 +452,7 @@ SEC("socket")
 /* A program observing the pair needs the JIT; see bpf_compute_subprog_ret_regs(). */
 __load_if_JITed()
 __log_level(2)
-__msg("0: .12345.... (85) call pc+2")
+__msg("0: .......... (85) call pc+2")
 __msg("1: ..2....... (bf) r0 = r2")
 __msg("2: 0......... (95) exit")
 __msg("3: .......... (b7) r0 = 1")
diff --git a/tools/testing/selftests/bpf/progs/verifier_live_stack.c b/tools/testing/selftests/bpf/progs/verifier_live_stack.c
index 3ba21430bb75..3abe08cc6595 100644
--- a/tools/testing/selftests/bpf/progs/verifier_live_stack.c
+++ b/tools/testing/selftests/bpf/progs/verifier_live_stack.c
@@ -1470,7 +1470,7 @@ static __used __naked void inner_reader(void)
 SEC("socket")
 __log_level(2)
 /* fp-8 NOT live at call: callee writes before reading (parent_def kills it) */
-__msg("2: .12345.... (85) call pc+")
+__msg("2: .1........ (85) call pc+")
 __naked void callee_must_write_before_read(void)
 {
 	asm volatile (

-- 
2.53.0
