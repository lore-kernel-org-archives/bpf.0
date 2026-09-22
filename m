Received: from mail-pz2-f40.google.com (mail-pz2-f40.google.com [74.125.228.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05D3B3655F3
	for <bpf@vger.kernel.org>; Tue, 22 Sep 2026 01:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790039627; cv=none; b=c3O9EtCr57K2a7WbgjYJJ3kbx0uch+MaMBlSo09W7lkxBQ9vqKPd0aL6FgZGtOhYLSf6aS7Hh1s10xAa/nFoOayAss9EYeAMk3r2a8Ei9/OaoE5Uc575HladOtPpPKRgek46bRsyXxgN0OZgsgV92PdqDMdViX9AsLJ7+RobzbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790039627; c=relaxed/simple;
	bh=WR3Rk/MLaR0XnmR9QscenlEtaqb0wfsV/sv5C4UYoJE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pDn8139RNzwbPs+T765ET4uwpA8C0Ln5Szki5+FRw5WQBW9pKhNkHTOUfGQWeOtuQhT4o9e78erYJii99OMu8pN6wJcb+bVjm7KJsml87V9J9q9QBe/R/F4oEbj39U/dF/PJ+EutFxa6wHq5QM98uoG6UdIzd37hRVRToxeuARw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pyRvhY3J; arc=none smtp.client-ip=74.125.228.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pyRvhY3J"
Received: by mail-pz2-f40.google.com with SMTP id 41be03b00d2f7-cc5256c2a4bso2426950a12.1
        for <bpf@vger.kernel.org>; Mon, 21 Sep 2026 18:13:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790039625; x=1790644425; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6jmzJh2Ul8rMwmkCKKQq43f3T4R8TLIwMRzr1E1plxg=;
        b=pyRvhY3JLpldC4GZDVBQ2NFDJWp30JtyfygL9DsZ3949LwgWPeddbqNi+izhtYhCXv
         1DsWwjEMoEfsHmBWN7k/HyQ4rTjlDu7b7EIDSk1E1spwwLeVeEGJ8LOdZRyLlzY80j7o
         tSwR2a7/OLy7BxQ/BGT8UMOoQrR0hZJ3xDCejfAMlFHKAN6o9T1BUbxGdGvOilGGlPAO
         5MAdelJrSpn/liUpAxlUYIUM2K5i269iWEqnp0QB2aYv1gt/63IrA8NjUxRIxfJrk0hT
         n6sDQKcDWb3osNGInnd+QsT3+nio14gwwVRbgb+M7PR4m3rIKz7LcI6H6OE2Ahi0o6MG
         1TSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790039625; x=1790644425;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=6jmzJh2Ul8rMwmkCKKQq43f3T4R8TLIwMRzr1E1plxg=;
        b=ZV8lCV1SPVEnzCiWrvzhv/eUw3bIGVNdNf+MXpMhkQD2oHPh7125/AL+OdIWBVN1+/
         nFefhzlOgzRQjZNEolHvhG64EsOOn8rATJkUKxgD6LS1Y+E0u1gtNMWONfcgRUww4Okv
         9mmUmFpzIJe1HqqY76mkIWKn8Le1BkIwnPMQc/nAkFY9Wb0sYLHtr5jG8ewTy2IT1tS3
         jkaAVMmZG2LrrPNkU8lDkDzQu7MkuNj/8ea3cRsodS8Bde9fNMUbPG8vQPJTbNn19GCS
         b4RN46AXqa2B9voao7fxhgaTsE/AqmLmfq/tTYo8duYnsRtPBlKD3fPEEqewi10gkNF1
         Uxlw==
X-Gm-Message-State: AFuF++lmpzcKSRLh7sqH0vLYe/eDRcEUSqz9L3RU2Q3IJv6RmY7l/0+5
	qtkNeJBDodE0gEmSRaAJ31NsR/ysjDqvKv0ictGgrJxPnyjyU0FCZMK0ghwNCQ==
X-Gm-Gg: AYBFou3vj9WTDWCdYLUAe/LM5De0+OFb0TBeAn/kfe/nqzG15K1liQ84gTjjuF4neuI
	bIC9krH75/Bss2FN6MNxRhX9vkvvs+++p+MJorezbwrEOMou5yZF7giCxuRL+kIikt5go3sJpFZ
	o0WtS98M5q8SXfM0dauMJABiJUzNmA3dLO9bkjDqsHFhLzTTUPMTcKQJ+MMbJlBnCq+8Si8cKGT
	TnJkhgIY9uW2tdhAbQCQDJTJ8mboM9TLSD+7mBlu0dIYcgbCn7CS/NpRDMZD5Vh+Q5JF2lT6p4H
	KWmSF1RSREOPp35s4opuCmg5cxR+MAqQUSu/CUJdFiDlo6SxOBNfycMnXgbOi2I+ynhRD1KeyVu
	bgd3tPT4j8qPfCtQsFzO3WuOqTsIeY8Ey1NzL5VOzGoSihsizBHWRDFCmmGGpe05X06XBz7DFuq
	haxUC8Byh4vqVDN+1zqKfvtjpLXKHjy32722LILnFYY2uIXhuD0pGIQERhWmwcd8YQLS6p+CeO0
	qjaqm1FRUqfuoyWyvq2HHQWM1T5TekReN2j04HhSjWL58BM7uvRI5P7FyqvLZlZNdAZUZzkYT8m
	tu/R2F1v6w1W0kakLIH0n2CjUk1QvVdE8CE5H+cvks4=
X-Received: by 2002:a17:90b:2f8d:b0:39e:6c69:f475 with SMTP id 98e67ed59e1d1-39e6c69f4ddmr12907646a91.52.1790039625103;
        Mon, 21 Sep 2026 18:13:45 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.243])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a06e570d9esm236200a91.10.2026.09.21.18.13.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 18:13:44 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	a.s.protopopov@gmail.com
Subject: [PATCH bpf-next 04/17] bpf: Prepare static analysis passes for callx instruction
Date: Tue, 22 Sep 2026 01:13:10 +0000
Message-ID: <20260922011323.1298619-5-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260922011323.1298619-1-alexei.starovoitov@gmail.com>
References: <20260922011323.1298619-1-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

BPF_JMP | BPF_CALL | BPF_X (callx) will be an indirect call of static
subprog with address in dst_reg. The passes that run before the main
verifier pass don't know which subprog callx calls.
Teach them to treat callx as a call with unknown callee:

- const_fold: callx clobbers R0-R5 like any other call. Otherwise
  bpf_prune_dead_branches() could rewrite a live conditional jump.

- live regs: callx uses R1-R5 and dst_reg, defines R0-R5.

- stack liveness: func instances are keyed by (callsite, depth) and
  cannot describe a callsite with multiple callees. Don't create
  instances for callees of callx. If any callx argument is derived
  from fp mark stack of all frames as read at callx insn and keep slots
  of outer frames alive 'before' the callsite while the callee is
  verified. Same as for callbacks that are not known statically.
  The callee is analyzed as standalone instance.

- backtracking: treat callx as a call of static subprog, same as
  BPF_PSEUDO_CALL.

callx is still rejected as unknown opcode. No functional change.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 include/linux/bpf_verifier.h |  6 ++++++
 kernel/bpf/backtrack.c       | 20 ++++++++++++--------
 kernel/bpf/const_fold.c      |  3 ++-
 kernel/bpf/liveness.c        | 35 ++++++++++++++++++++++++++++++-----
 4 files changed, 50 insertions(+), 14 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 92f528c45605..6380c851ed24 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -1089,6 +1089,12 @@ static inline bool bpf_pseudo_kfunc_call(const struct bpf_insn *insn)
 	       insn->src_reg == BPF_PSEUDO_KFUNC_CALL;
 }
 
+/* callx: indirect call of a bpf subprog whose address is in insn->dst_reg */
+static inline bool bpf_is_callx(const struct bpf_insn *insn)
+{
+	return insn->code == (BPF_JMP | BPF_CALL | BPF_X);
+}
+
 __printf(2, 0) void bpf_verifier_vlog(struct bpf_verifier_log *log,
 				      const char *fmt, va_list args);
 __printf(2, 3) void bpf_verifier_log_write(struct bpf_verifier_env *env,
diff --git a/kernel/bpf/backtrack.c b/kernel/bpf/backtrack.c
index 507a366dffa4..4da99dec0818 100644
--- a/kernel/bpf/backtrack.c
+++ b/kernel/bpf/backtrack.c
@@ -406,15 +406,18 @@ static int backtrack_insn(struct bpf_verifier_env *env, int idx, int subseq_idx,
 		if (class == BPF_STX)
 			bt_set_reg(bt, sreg);
 	} else if (class == BPF_JMP || class == BPF_JMP32) {
-		if (bpf_pseudo_call(insn)) {
-			int subprog_insn_idx, subprog;
+		if (bpf_pseudo_call(insn) || bpf_is_callx(insn)) {
+			int subprog_insn_idx, subprog = -1;
 
-			subprog_insn_idx = idx + insn->imm + 1;
-			subprog = bpf_find_subprog(env, subprog_insn_idx);
-			if (subprog < 0)
-				return -EFAULT;
+			if (bpf_pseudo_call(insn)) {
+				subprog_insn_idx = idx + insn->imm + 1;
+				subprog = bpf_find_subprog(env, subprog_insn_idx);
+				if (subprog < 0)
+					return -EFAULT;
+			}
 
-			if (bpf_subprog_is_global(env, subprog)) {
+			/* callx calls static subprogs only */
+			if (subprog >= 0 && bpf_subprog_is_global(env, subprog)) {
 				/* check that jump history doesn't have any
 				 * extra instructions from subprog; the next
 				 * instruction after call to global subprog
@@ -536,7 +539,8 @@ static int backtrack_insn(struct bpf_verifier_env *env, int idx, int subseq_idx,
 			 * never do that.
 			 */
 			from_subprog_call = subseq_idx - 1 >= 0 &&
-					    bpf_pseudo_call(&env->prog->insnsi[subseq_idx - 1]);
+					    (bpf_pseudo_call(&env->prog->insnsi[subseq_idx - 1]) ||
+					     bpf_is_callx(&env->prog->insnsi[subseq_idx - 1]));
 
 			r0_precise = from_subprog_call && bt_is_reg_set(bt, BPF_REG_0);
 			r2_precise = from_subprog_call && bt_is_reg_set(bt, BPF_REG_2);
diff --git a/kernel/bpf/const_fold.c b/kernel/bpf/const_fold.c
index 982125026eaf..f44ae8487ec6 100644
--- a/kernel/bpf/const_fold.c
+++ b/kernel/bpf/const_fold.c
@@ -196,7 +196,8 @@ static void const_reg_xfer(struct bpf_verifier_env *env, struct const_arg_info *
 		dst->val = val;
 		break;
 	case BPF_JMP:
-		if (opcode != BPF_CALL)
+		/* both 'call imm' and 'callx reg' clobber caller saved registers */
+		if (BPF_OP(insn->code) != BPF_CALL)
 			break;
 process_call:
 		for (r = BPF_REG_0; r <= BPF_REG_5; r++)
diff --git a/kernel/bpf/liveness.c b/kernel/bpf/liveness.c
index 44ecdc5b4ec2..5aa2f68d92b3 100644
--- a/kernel/bpf/liveness.c
+++ b/kernel/bpf/liveness.c
@@ -356,12 +356,25 @@ int bpf_live_stack_query_init(struct bpf_verifier_env *env, struct bpf_verifier_
 	return 0;
 }
 
+/*
+ * Stack accesses of callbacks and of callx callees are not tracked by
+ * func instances keyed by the @callsite. Callbacks might be called several
+ * times and the callee of callx is not known when stack liveness is computed.
+ * In both cases stack slots of the outer frames that might be read by the
+ * callee are accounted as read by the @callsite instruction itself.
+ */
+static bool callee_stack_access_at_callsite(struct bpf_verifier_env *env, u32 callsite)
+{
+	return bpf_calls_callback(env, callsite) ||
+	       bpf_is_callx(&env->prog->insnsi[callsite]);
+}
+
 bool bpf_stack_slot_alive(struct bpf_verifier_env *env, u32 frameno, u32 half_spi)
 {
 	/*
 	 * Slot is alive if it is read before q->insn_idx in current func instance,
 	 * or if for some outer func instance:
-	 * - alive before callsite if callsite calls callback, otherwise
+	 * - alive before callsite if callsite calls callback or is callx, otherwise
 	 * - alive after callsite
 	 */
 	struct live_stack_query *q = &env->liveness->live_stack_query;
@@ -394,7 +407,7 @@ bool bpf_stack_slot_alive(struct bpf_verifier_env *env, u32 frameno, u32 half_sp
 		/* Get callsite from verifier state, not from instance callchain */
 		callsite = q->callsites[i];
 
-		alive = bpf_calls_callback(env, callsite)
+		alive = callee_stack_access_at_callsite(env, callsite)
 			? is_live_before(instance, callsite, rel, half_spi)
 			: is_live_before(instance, callsite + 1, rel, half_spi);
 		if (alive)
@@ -1439,7 +1452,15 @@ static int record_call_access(struct bpf_verifier_env *env,
 	if (bpf_pseudo_call(insn))
 		return 0;
 
-	if (bpf_get_call_summary(env, insn, &cs))
+	if (bpf_is_callx(insn))
+		/*
+		 * The callee is not known statically. Assume that all arg
+		 * slots are passed and let record_arg_access() conservatively
+		 * mark the stack of all frames as read if any of them is
+		 * derived from a frame pointer.
+		 */
+		arg_slot_cnt = MAX_BPF_FUNC_REG_ARGS + MAX_STACK_ARG_SLOTS;
+	else if (bpf_get_call_summary(env, insn, &cs))
 		arg_slot_cnt = cs.arg_slot_cnt;
 
 	for (r = BPF_REG_1; r < BPF_REG_1 + min(arg_slot_cnt, MAX_BPF_FUNC_REG_ARGS); r++) {
@@ -1533,7 +1554,8 @@ static void print_subprog_arg_access(struct bpf_verifier_env *env,
 		bool has_extra = false;
 		u8 cls = BPF_CLASS(insns[idx].code);
 		bool is_ldx_stx_call = cls == BPF_LDX || cls == BPF_STX ||
-				       insns[idx].code == (BPF_JMP | BPF_CALL);
+				       insns[idx].code == (BPF_JMP | BPF_CALL) ||
+				       bpf_is_callx(&insns[idx]);
 
 		verbose(env, "%3d: ", idx);
 		bpf_verbose_insn(env, &insns[idx]);
@@ -1722,7 +1744,7 @@ static int compute_subprog_args(struct bpf_verifier_env *env,
 		if (err)
 			goto err_free;
 
-		if (insn->code == (BPF_JMP | BPF_CALL)) {
+		if (insn->code == (BPF_JMP | BPF_CALL) || bpf_is_callx(insn)) {
 			err = record_call_access(env, instance, at_in[i], idx);
 			if (err)
 				goto err_free;
@@ -2202,6 +2224,9 @@ static void compute_insn_live_regs(struct bpf_verifier_env *env,
 				use = GENMASK(min_t(u8, cs.arg_slot_cnt, MAX_BPF_FUNC_REG_ARGS), 1);
 			def = mask_widen(def);
 			use = mask_widen(use);
+			/* callx reads the address of the callee from dst_reg */
+			if (bpf_is_callx(insn))
+				use |= dst;
 			break;
 		default:
 			def = 0;
-- 
2.55.0

