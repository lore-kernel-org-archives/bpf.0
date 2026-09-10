Received: from mta0.migadu.com (out-53.mta0.migadu.com [91.218.175.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CBCD511188
	for <bpf@vger.kernel.org>; Thu, 10 Sep 2026 16:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789058874; cv=none; b=rChZ/grJRbWsNZyGzHnYyN8hWrpYrGeAD+MFqse3A/uBDcyrBamvLrp97aWV+W6z2Wx6jOeteT0PgqkZ1pskOrCA2d5XxXbJtlHhM7LyWeVlu36rFwGxs/O5CzjwWlCVf78iic1eMFgDp+mOZLdAIlvhYp45E3Nzyf2NeXSIVog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789058874; c=relaxed/simple;
	bh=mq7GOoQK30iIGJJGlQCVwVgC5MxtIYTjkgeg/GW2OnI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DrTvWSdV7lo1+7xaJECpKc7lpGONF9rB1DS2oAK32JMPlJGtMs542T6zGFwRL+JFmSILmkV6EG4BODhZ2cNOoSph2TR7S8RawLnzea3tUgs+sRjCEskzqBfrlFg2nS9AcOEbPDPCeVkwzGlVI2spS16NEV8MRvh2aEO17n5odlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=kg5Vg68y; arc=none smtp.client-ip=91.218.175.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="kg5Vg68y"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=mq7GOoQK30iIGJJGlQCVwVgC5MxtIYTjkgeg/GW2OnI=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789058864; v=1; x=1789663664;
 b=kg5Vg68yP6kF3dtU/xcNm+rhdyYFY1ZPNkCuLEA80pBnSiU/LBHMcN/PKayXR8RO3xnV7yZ8
 56pkrassfA9rAyfTHqQcPR/3NEYEQfIe+PbURiRI99TtAAVNMRh6a+8FKZ86/l3luhMYYk06cYd
 j9jSs6cskuVb3lx6B/visEgw=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 100b8265b6c2deba;
	Thu, 10 Sep 2026 16:47:44 +0000
X-Mizu-Trace-ID: 100b8265b6c2deba
X-Migadu-Flow: FLOW_OUT
From: Vineet Gupta <vineet.gupta@linux.dev>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Cc: martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	emil@etsalapatis.com,
	ihor.solodrai@linux.dev,
	john.fastabend@gmail.com,
	shuah@kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Vineet Gupta <vineet.gupta@linux.dev>
Subject: [PATCH bpf-next v2 11/13] bpf: record what a narrowing spill actually stores
Date: Thu, 10 Sep 2026 22:16:33 +0530
Message-ID: <20260910164635.459558-12-vineet.gupta@linux.dev>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260910164635.459558-1-vineet.gupta@linux.dev>
References: <20260910164635.459558-1-vineet.gupta@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A spill narrower than its source saves the register state untruncated:
save_register_state() does

	state->stack[spi].spilled_ptr = *reg;

and marks only @size bytes STACK_SPILL. So after

	r6 = ...			/* full 64-bit unknown */
	*(u32 *)(r10 - 8) = r6;		/* four bytes reach memory */

the slot claims to hold all of r6 while memory holds its low half. That is
sound and the fill truncates later, but stacksafe() compares the slot
through regsafe(), so the imprecision reaches state comparison.

Truncate the recorded state to the bytes stored. Nothing reads the slot as
wider: the remaining bytes are STACK_MISC, so a larger access fails the
size <= spill_size test and never takes the register-fill path.

This is independent of linking -- it applies whether or not the source
carries an id -- hence a patch of its own.

coerce_reg_to_size() moves up to be visible at the spill site, otherwise
unchanged.

spill_subregs_preserve_stack_zero pins the old state and moves with it. It
checks that STACK_ZERO bytes survive a subreg spill, which is unaffected;
only the recorded scalar tightens.

Signed-off-by: Vineet Gupta <vineet.gupta@linux.dev>
---
v2: new.

 kernel/bpf/verifier.c                         | 60 +++++++++++--------
 .../selftests/bpf/progs/verifier_spill_fill.c | 10 +++-
 2 files changed, 41 insertions(+), 29 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 89be1240c99a..6cb35fc0d0fb 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -3509,6 +3509,31 @@ static void assign_scalar_id_before_mov(struct bpf_verifier_env *env,
 		src_reg->id = ++env->id_gen;
 }
 
+static void coerce_reg_to_size(struct bpf_reg_state *reg, int size)
+{
+	u64 mask;
+
+	/* clear high bits in bit representation */
+	reg->var_off = tnum_cast(reg->var_off, size);
+
+	/* fix arithmetic bounds */
+	mask = ((u64)1 << (size * 8)) - 1;
+	if ((reg_umin(reg) & ~mask) == (reg_umax(reg) & ~mask))
+		reg_set_urange64(reg, reg_umin(reg) & mask, reg_umax(reg) & mask);
+	else
+		reg_set_urange64(reg, 0, mask);
+
+	/*
+	 * If size is smaller than 32bit register the 32bit register
+	 * values are also truncated so we push 64-bit bounds into
+	 * 32-bit bounds. Above were truncated < 32-bits already.
+	 */
+	if (size < 4)
+		__mark_reg32_unbounded(reg);
+
+	reg_bounds_sync(reg);
+}
+
 static void save_register_state(struct bpf_verifier_env *env,
 				struct bpf_func_state *state,
 				int spi, struct bpf_reg_state *reg,
@@ -3646,9 +3671,16 @@ static int check_stack_write_fixed_off(struct bpf_verifier_env *env,
 		if (reg_value_fits)
 			assign_scalar_id_before_mov(env, reg);
 		save_register_state(env, state, spi, reg, size);
-		/* Break the relation on a narrowing spill. */
-		if (!reg_value_fits)
+		if (!reg_value_fits) {
+			/*
+			 * Only the low @size bytes reach memory, so record
+			 * what the slot holds rather than the wider source
+			 * it came from.
+			 */
+			coerce_reg_to_size(&state->stack[spi].spilled_ptr, size);
+			/* Break the relation on a narrowing spill. */
 			clear_scalar_id(&state->stack[spi].spilled_ptr);
+		}
 	} else if (!reg && !(off % BPF_REG_SIZE) && is_bpf_st_mem(insn) &&
 		   env->bpf_capable) {
 		struct bpf_reg_state *tmp_reg = &env->fake_reg[0];
@@ -5738,30 +5770,6 @@ static void sext_32_to_64(struct bpf_reg_state *reg)
 /* truncate register to smaller size (in bytes)
  * must be called with size < BPF_REG_SIZE
  */
-static void coerce_reg_to_size(struct bpf_reg_state *reg, int size)
-{
-	u64 mask;
-
-	/* clear high bits in bit representation */
-	reg->var_off = tnum_cast(reg->var_off, size);
-
-	/* fix arithmetic bounds */
-	mask = ((u64)1 << (size * 8)) - 1;
-	if ((reg_umin(reg) & ~mask) == (reg_umax(reg) & ~mask))
-		reg_set_urange64(reg, reg_umin(reg) & mask, reg_umax(reg) & mask);
-	else
-		reg_set_urange64(reg, 0, mask);
-
-	/* If size is smaller than 32bit register the 32bit register
-	 * values are also truncated so we push 64-bit bounds into
-	 * 32-bit bounds. Above were truncated < 32-bits already.
-	 */
-	if (size < 4)
-		__mark_reg32_unbounded(reg);
-
-	reg_bounds_sync(reg);
-}
-
 static void set_sext64_default_val(struct bpf_reg_state *reg, int size)
 {
 	if (size == 1) {
diff --git a/tools/testing/selftests/bpf/progs/verifier_spill_fill.c b/tools/testing/selftests/bpf/progs/verifier_spill_fill.c
index 39a1766dae3f..487e0a1f395c 100644
--- a/tools/testing/selftests/bpf/progs/verifier_spill_fill.c
+++ b/tools/testing/selftests/bpf/progs/verifier_spill_fill.c
@@ -464,9 +464,13 @@ l0_%=:	r1 >>= 16;					\
 SEC("raw_tp")
 __log_level(2)
 __success
-__msg("fp-8=0m??scalar()")
-__msg("fp-16=00mm??scalar()")
-__msg("fp-24=00mm???scalar()")
+/*
+ * The slot records what the store put there, not the wider source it came
+ * from, so each scalar is bounded by the size of its spill.
+ */
+__msg("fp-8=0m??scalar(smin=0,smax=umax=0xffffffff,var_off=(0x0; 0xffffffff))")
+__msg("fp-16=00mm??scalar(smin=smin32=0,smax=umax=smax32=umax32=0xffff,var_off=(0x0; 0xffff))")
+__msg("fp-24=00mm???scalar(smin=smin32=0,smax=umax=smax32=umax32=255,var_off=(0x0; 0xff))")
 __naked void spill_subregs_preserve_stack_zero(void)
 {
 	asm volatile (
-- 
2.53.0-Meta

