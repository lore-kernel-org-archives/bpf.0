Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DACB43DAACD
	for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 03:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790219462; cv=none; b=C++VlQFN9Xzq0NcQHvsznohWUW5cCQj/A2Np9XjIOS8svfbLnalqOWH+3z7GbiUbE8453kDtBOcseb5UNVgv5U0vsD5CBfi+0GG9NVU+9ZyS1f/u5igRJPMDoRPeThcpPzMMQMQOT96jg1G4BnKf/YwkUAUoVc1HJDQhlvP48aA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790219462; c=relaxed/simple;
	bh=/axLqxdiyiY03R11EUBANtze31FUhFOP6mJlDbLGaiI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZIOGJnXI0XemAhiAlT4HMWIcbALjde+F6Rm7Rr3xKOnNFqWRobE05fmFmoZFTzHzEQ6DkyMpSqXaAHTEyvMtqbajqhW9JXZckwQAxdXleEJbYEhmlDga57BxpF4Sn1KA6rKnYEfWGrrIvMy1fHvQ8WagcttGu4GGLVAALTG067I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hxy94kSX; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hxy94kSX"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2dd68a16955so3537095ad.0
        for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 20:11:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790219460; x=1790824260; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tpV0nRwsMWHI368aehh3Qvvn+PoNc5DZP1+L2DgjrZE=;
        b=hxy94kSXqeKujSRrkA8M1UqT5h9m2Zvihx2F6D6rX4uEXthmmtA3ivmb/camM6Vf9Q
         NOtDAd7WMMUfdepZzFTVUeV7DfUrKpqV1vb4jjy/ooJug/NYqGBTw351H/LpryLDGwA5
         Y6kq23G/WQouv2jZykgp2sy4svOOL8SVvVu/U30jnWfHio/dB1tva2bRxLSXV4rvs8CZ
         TvkJwbONeb605un6kKHt3gmTLoCH6sZeCNNrDGi6AfkuZf77d9eGyhdr2yLAo48XNyXc
         yxIonTu7Q6vGe6qRYSXRX1NDYh9x3KjzxRsNffZMWkZEUrkeeoBkk+7NK4RgbJvIKXVz
         /8zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790219460; x=1790824260;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=tpV0nRwsMWHI368aehh3Qvvn+PoNc5DZP1+L2DgjrZE=;
        b=HSbFuwwfjB53aU/yMK8cTLhQTRBqPuvDtUVvHkcuYh/+z6Me91ZOhM17/at5Lhwv/U
         RsW+QfHOqmWJ5rRtbhcWMbLp0M52NSkxYWl2z7P8zOmKDFs6yXAZrmQw7Y3XQ0x03SUk
         GHx99zc7JHGrmS3QIc1LAiQUwcUUa5xHKRNdwBI8zQccVZCbVGy9cCLtqLvZQyze4UsZ
         n2EtMWLZcdBRKXWAlrIlrGNlmHqahcopbZ3mHr42eYTTdBMamVkVmFaE33/Q0jak4GyO
         zU/PbOG396acVVUII1lyf+panqtD2uc/x4PwxSCMq9IZhLTKKBhfOfYnzaV/YUvKj/Mc
         sAAQ==
X-Gm-Message-State: AFuF++nMoNkKWyirfzy1cgcgEDYyiCACdgCKP7CT4mquNBAxBrwKKzmq
	wV5HpHctB4UOOpEjImGXzc0X7mYctJIUSvEZhwMbklZeh8tn55sGLpjJzPtNgg==
X-Gm-Gg: AYBFou2xpi3n6P6B8CcaqQkBtp130cESNrAdpGdOY43IyBCa5ggny/oTF0Bt60xzeQC
	PUFLdKvxOnzYyhjTqSFoXhR3lYgutsfPgbJefObR0khEGSU2TFvIk4E+SwlJRbEbJk7QcNP/7c1
	5XqSJ09mrHRQPxQLz7uaKsD0jb4wwIWjGc1vtRfStMXz87gFKPLCHSD4oM3L035EutyUm0DVagM
	48avvi8sEuWRTGhO7c9GsFHDIxXpukIzOUJsy1r0t8Pp15X/aZPATT+YXSUZi+k7LHkVqRlfh2d
	NYVCMimphtuGKv9Rape4FbyZktpKbdoJ1Fqu+mZhGlsn/ELGaXKGJ+LpgKG2B99GRgQVdWMWpfl
	dsNjP9DrNycUMO0Jcj1mG3xdWRIxns8ZF/XQkKoG4KUGgpbS4na69b5P8T2PlVjpgYtmcMQSNZe
	Wb3xRCZmHZT2nR4ViBiDt8iyAR/ThV/LsZB1lnTD6+B4YL6rVkcgUd+V61sBvSzwyCZqtYEHz69
	qXwBVBxd5Gs23tP6Sx6V0TpLMyFX/vHJDM/uHBtZRjwaISv+8JA+9eO04FtVRkioTHpU5EEDbLu
	gKUHd5I//vDTwEgyd+iWOwqAdL8G8dOXodg2W4RIBpnF
X-Received: by 2002:a05:6a21:111:b0:3db:4bf:53fc with SMTP id adf61e73a8af0-3de0e72a4b1mr788199637.9.1790219459959;
        Wed, 23 Sep 2026 20:10:59 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.240])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc75f3b7240sm1871385a12.7.2026.09.23.20.10.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 20:10:59 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next v2 04/17] bpf: Prepare static analysis passes for callx instruction
Date: Thu, 24 Sep 2026 03:10:29 +0000
Message-ID: <20260924031042.1690890-5-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260924031042.1690890-1-alexei.starovoitov@gmail.com>
References: <20260924031042.1690890-1-alexei.starovoitov@gmail.com>
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
 kernel/bpf/backtrack.c       | 20 +++++++++++--------
 kernel/bpf/const_fold.c      |  3 ++-
 kernel/bpf/liveness.c        | 38 +++++++++++++++++++++++++++++++-----
 4 files changed, 53 insertions(+), 14 deletions(-)

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
index 7f1b30059cc8..28dec733e596 100644
--- a/kernel/bpf/const_fold.c
+++ b/kernel/bpf/const_fold.c
@@ -191,7 +191,8 @@ static void const_reg_xfer(struct bpf_verifier_env *env, struct const_arg_info *
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
index 44ecdc5b4ec2..a204b492acc8 100644
--- a/kernel/bpf/liveness.c
+++ b/kernel/bpf/liveness.c
@@ -356,12 +356,29 @@ int bpf_live_stack_query_init(struct bpf_verifier_env *env, struct bpf_verifier_
 	return 0;
 }
 
+/*
+ * Stack slots of outer frames that the callee may read are accounted as read
+ * by the @callsite insn itself, i.e. they are live before @callsite and may be
+ * dead after it, when:
+ * - @callsite calls a callback, which may be called several times;
+ * - @callsite is callx. Its callee is not known when stack liveness is
+ *   computed, so there is no func instance for it at @callsite. While
+ *   the verifier is in the callee lookup_instance() finds its standalone
+ *   instance that knows nothing about outer frames. What the callee may read
+ *   there is recorded by record_call_access().
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
@@ -394,7 +411,7 @@ bool bpf_stack_slot_alive(struct bpf_verifier_env *env, u32 frameno, u32 half_sp
 		/* Get callsite from verifier state, not from instance callchain */
 		callsite = q->callsites[i];
 
-		alive = bpf_calls_callback(env, callsite)
+		alive = callee_stack_access_at_callsite(env, callsite)
 			? is_live_before(instance, callsite, rel, half_spi)
 			: is_live_before(instance, callsite + 1, rel, half_spi);
 		if (alive)
@@ -1439,7 +1456,15 @@ static int record_call_access(struct bpf_verifier_env *env,
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
@@ -1533,7 +1558,7 @@ static void print_subprog_arg_access(struct bpf_verifier_env *env,
 		bool has_extra = false;
 		u8 cls = BPF_CLASS(insns[idx].code);
 		bool is_ldx_stx_call = cls == BPF_LDX || cls == BPF_STX ||
-				       insns[idx].code == (BPF_JMP | BPF_CALL);
+				       (cls == BPF_JMP && BPF_OP(insns[idx].code) == BPF_CALL);
 
 		verbose(env, "%3d: ", idx);
 		bpf_verbose_insn(env, &insns[idx]);
@@ -1722,7 +1747,7 @@ static int compute_subprog_args(struct bpf_verifier_env *env,
 		if (err)
 			goto err_free;
 
-		if (insn->code == (BPF_JMP | BPF_CALL)) {
+		if (BPF_CLASS(insn->code) == BPF_JMP && BPF_OP(insn->code) == BPF_CALL) {
 			err = record_call_access(env, instance, at_in[i], idx);
 			if (err)
 				goto err_free;
@@ -2202,6 +2227,9 @@ static void compute_insn_live_regs(struct bpf_verifier_env *env,
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

