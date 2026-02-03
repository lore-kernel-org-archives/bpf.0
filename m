Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73B6636680B
	for <bpf@vger.kernel.org>; Tue,  3 Feb 2026 22:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770157658; cv=none; b=o9WqSTefdnKZjevcVUUvpJZ7ZT70pgkcD9k6mFKS48DfIqtN1W1NFY4B/16xO4OXfgXXRMCEyEAs9iKXQShbVgBwtegyO8v5fxERZSqGIxQB5jhu+if8JgWt0bRTw2dMwBjCLs67+jykTeS80OUULUklnp+saiFauckA/en6bdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770157658; c=relaxed/simple;
	bh=d6q+fWBRhZhBrbM8oPNbowV+1k9cfHPpNOowg2e01Xo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r4REgvyJwzV7KXCwlM2W6jEBP/xeyQuAiAwLviOFxeynBhwMuk73SauK+Nawbs/BsBAIxx0k2zDOd4vurxB+Wl9UIXF7JPFOAsJiOhgm9CzGFoeVEkX9NifiLzPqqLXYIJ6FVLEh0Tb47MCJh16K2D1uoV/H2Qdcgwqggytxpwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PGWXwkwu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PGWXwkwu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E304EC116D0;
	Tue,  3 Feb 2026 22:27:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770157658;
	bh=d6q+fWBRhZhBrbM8oPNbowV+1k9cfHPpNOowg2e01Xo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PGWXwkwuUg66R2Al704EzOMMp9cwt2/xzZ4KK6aSTNaKGd5Bv7mDa6uZyVXGS2BND
	 gV3GDSesGFy58Ndglfk9GfpdxbMxmIXFyeSh2NGGej95EXWb545doSssgLNlSEFk86
	 7ak9VfvaW7Sa3ZzHew7yvlw73Mhbezk/iq/gp3mjx4Ecd/V1lQL03JpyJneyI+aYna
	 tMiXOsE+UWZtRLxeyzCXKTTiXrcSNPoTosMnlqhdzncLiL1jILebzHZNNjWKVCQXCf
	 SbReUo8BSngDJvYszFU0lxN+SpTzB29JeIsRmX/2u1Bw+K1qtNhtJbHhTjqufh7uxq
	 7R+YubkMwmt7w==
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
Subject: [PATCH bpf-next v3 1/2] bpf: Support negative offsets, BPF_SUB, and alu32 for linked register tracking
Date: Tue,  3 Feb 2026 14:26:17 -0800
Message-ID: <20260203222643.994713-2-puranjay@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260203222643.994713-1-puranjay@kernel.org>
References: <20260203222643.994713-1-puranjay@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Previously, the verifier only tracked positive constant deltas between
linked registers using BPF_ADD. This limitation meant patterns like:

  r1 = r0;
  r1 += -4;
  if r1 s>= 0 goto l0_%=;   // r1 >= 0 implies r0 >= 4
  // verifier couldn't propagate bounds back to r0
  if r0 != 0 goto l0_%=;
	r0 /= 0; // Verifier thinks this is reachable
  l0_%=:

Similar limitation exists for 32-bit registers.

With this change, the verifier can now track negative deltas in reg->off
enabling bound propagation for the above pattern.

For alu32, we make sure the destination register has the upper 32 bits
as 0s before creating the link. BPF_ADD_CONST is split into
BPF_ADD_CONST64 and BPF_ADD_CONST32, the latter is used in case of alu32
and sync_linked_regs uses this to zext the result if known_reg has this
flag.

Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
---
 include/linux/bpf_verifier.h                  |  6 ++-
 kernel/bpf/verifier.c                         | 49 ++++++++++++++-----
 .../selftests/bpf/progs/verifier_bounds.c     |  2 +-
 3 files changed, 44 insertions(+), 13 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 746025df82c8..ef8e45a362d9 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -147,8 +147,12 @@ struct bpf_reg_state {
 	 * registers. Example:
 	 * r1 = r2;    both will have r1->id == r2->id == N
 	 * r1 += 10;   r1->id == N | BPF_ADD_CONST and r1->off == 10
+	 * r3 = r2;    both will have r3->id == r2->id == N
+	 * w3 += 10;   r3->id == N | BPF_ADD_CONST32 and r3->off == 10
 	 */
-#define BPF_ADD_CONST (1U << 31)
+#define BPF_ADD_CONST64 (1U << 31)
+#define BPF_ADD_CONST32 (1U << 30)
+#define BPF_ADD_CONST (BPF_ADD_CONST64 | BPF_ADD_CONST32)
 	u32 id;
 	/* PTR_TO_SOCKET and PTR_TO_TCP_SOCK could be a ptr returned
 	 * from a pointer-cast helper, bpf_sk_fullsock() and
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 6a616dc4dc54..7f73f73adfe0 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -16122,6 +16122,13 @@ static int adjust_reg_min_max_vals(struct bpf_verifier_env *env,
 		verbose(env, "verifier internal error: no src_reg\n");
 		return -EFAULT;
 	}
+	/*
+	 * For alu32 linked register tracking, we need to check dst_reg's
+	 * umax_value before the ALU operation. After adjust_scalar_min_max_vals(),
+	 * alu32 ops will have zero-extended the result, making umax_value <= U32_MAX.
+	 */
+	u64 dst_umax = dst_reg->umax_value;
+
 	err = adjust_scalar_min_max_vals(env, insn, dst_reg, *src_reg);
 	if (err)
 		return err;
@@ -16131,26 +16138,44 @@ static int adjust_reg_min_max_vals(struct bpf_verifier_env *env,
 	 * r1 += 0x1
 	 * if r2 < 1000 goto ...
 	 * use r1 in memory access
-	 * So for 64-bit alu remember constant delta between r2 and r1 and
-	 * update r1 after 'if' condition.
+	 * So remember constant delta between r2 and r1 and update r1 after
+	 * 'if' condition.
 	 */
 	if (env->bpf_capable &&
-	    BPF_OP(insn->code) == BPF_ADD && !alu32 &&
-	    dst_reg->id && is_reg_const(src_reg, false)) {
-		u64 val = reg_const_value(src_reg, false);
+	    (BPF_OP(insn->code) == BPF_ADD || BPF_OP(insn->code) == BPF_SUB) &&
+	    dst_reg->id && is_reg_const(src_reg, alu32)) {
+		u64 val = reg_const_value(src_reg, alu32);
+		s32 off;
+
+		if (!alu32 && ((s64)val < S32_MIN || (s64)val > S32_MAX))
+			goto clear_id;
+
+		if (alu32 && (dst_umax > U32_MAX))
+			goto clear_id;
 
-		if ((dst_reg->id & BPF_ADD_CONST) ||
-		    /* prevent overflow in sync_linked_regs() later */
-		    val > (u32)S32_MAX) {
+		off = (s32)val;
+
+		if (BPF_OP(insn->code) == BPF_SUB) {
+			/* Negating S32_MIN would overflow */
+			if (off == S32_MIN)
+				goto clear_id;
+			off = -off;
+		}
+
+		if (dst_reg->id & BPF_ADD_CONST) {
 			/*
 			 * If the register already went through rX += val
 			 * we cannot accumulate another val into rx->off.
 			 */
+clear_id:
 			dst_reg->off = 0;
 			dst_reg->id = 0;
 		} else {
-			dst_reg->id |= BPF_ADD_CONST;
-			dst_reg->off = val;
+			if (alu32)
+				dst_reg->id |= BPF_ADD_CONST32;
+			else
+				dst_reg->id |= BPF_ADD_CONST64;
+			dst_reg->off = off;
 		}
 	} else {
 		/*
@@ -17247,7 +17272,7 @@ static void sync_linked_regs(struct bpf_verifier_env *env, struct bpf_verifier_s
 			u32 saved_id = reg->id;
 
 			fake_reg.type = SCALAR_VALUE;
-			__mark_reg_known(&fake_reg, (s32)reg->off - (s32)known_reg->off);
+			__mark_reg_known(&fake_reg, (s64)reg->off - (s64)known_reg->off);
 
 			/* reg = known_reg; reg += delta */
 			copy_register_state(reg, known_reg);
@@ -17262,6 +17287,8 @@ static void sync_linked_regs(struct bpf_verifier_env *env, struct bpf_verifier_s
 			scalar32_min_max_add(reg, &fake_reg);
 			scalar_min_max_add(reg, &fake_reg);
 			reg->var_off = tnum_add(reg->var_off, fake_reg.var_off);
+			if (known_reg->id & BPF_ADD_CONST32)
+				zext_32_to_64(reg);
 		}
 		if (e->is_reg)
 			mark_reg_scratched(env, e->regno);
diff --git a/tools/testing/selftests/bpf/progs/verifier_bounds.c b/tools/testing/selftests/bpf/progs/verifier_bounds.c
index 411a18437d7e..560531404bce 100644
--- a/tools/testing/selftests/bpf/progs/verifier_bounds.c
+++ b/tools/testing/selftests/bpf/progs/verifier_bounds.c
@@ -1477,7 +1477,7 @@ __naked void sub64_full_overflow(void)
 SEC("socket")
 __description("64-bit subtraction, partial overflow, result in unbounded reg")
 __success __log_level(2)
-__msg("3: (1f) r3 -= r2 {{.*}} R3=scalar()")
+__msg("3: (1f) r3 -= r2 {{.*}} R3=scalar(id=1-1)")
 __retval(0)
 __naked void sub64_partial_overflow(void)
 {
-- 
2.47.3

