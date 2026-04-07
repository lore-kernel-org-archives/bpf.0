Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 334EE3358BF
	for <bpf@vger.kernel.org>; Tue,  7 Apr 2026 19:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775589869; cv=none; b=sBLuhVIVVvHkX/ww3bMViAa5vd94mIFa1EbPcRVMgtVOZtxKjaStOrf38f+bTNYX+GYTAhH/MH9Sa6KfxiKlc0C9gXHmrvFuJhSWuRBmpUt1sNVY9DhuUSAsLAz4bjr63k4zItiYwfCTL0E3FR3qEnyTwjgwWCWqgJExYz3c4EE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775589869; c=relaxed/simple;
	bh=hmME+MwQgYlc6kWeqGhmgmaoFRKDD1dOkUrqKkf1npw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qgLbUmPCQYs+WNddkUyREVYhS9nBAnLpKsXD7Y7ozC+fm0johL1cX1mqb9P8iJWmzNaSPl+fJMybgjKnHxvxogefOQKajAzV0jRNCyGBQBJwzHJPeBrqH7JL7dz+xtdPzBdGEKnPD5uBbHHmGEQXdssyKBHGowjSODfEYpPgTq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=hJ/TmuP8; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="hJ/TmuP8"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=/eLDnvs7nMT1afmcHUIAqeHm4TWJsBNg6OiWfi3ZIzU=; b=hJ/TmuP8UtGdjWf0Q1aZtsZloo
	mGAbZGShIAsP0HHJqXwbb6Z00FlggBAqNLvwY4VorB7VRZV37nz+6VqMVx7NoUZ4LBhLGsxXnIEKD
	g/kCJ9fNS/YFyhIfVqWJjm6f1pPoX+SAtcpO4q0CLeR3GeDA2Q6bFXrNIoCyfZPBvEoDVJspqWDUs
	vIDX3H0PM5k/Wc1isw5/HySjR73e52i67RPCNZdwUBOe26i/DrAmpaNvKlksFG4IXGYORJhfgg+L+
	r/MPHs3qBQuZ2HIxhwvvYqh7jm5CrS8sGGQv8LyYhjlr4GdLRYwfQqzqezJ0rLwqdMkyH2jSOUWyQ
	obbD4CpQ==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1wAC2B-0001v7-1b;
	Tue, 07 Apr 2026 21:24:23 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	puranjay@kernel.org,
	info@starlabs.sg
Subject: [PATCH bpf-next 2/4] bpf: Clear delta when clearing reg id for non-{add,sub} ops
Date: Tue,  7 Apr 2026 21:24:19 +0200
Message-ID: <20260407192421.508817-2-daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260407192421.508817-1-daniel@iogearbox.net>
References: <20260407192421.508817-1-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/27964/Tue Apr  7 08:24:40 2026)

When a non-{add,sub} alu op such as xor is performed on a scalar
register that previously had a BPF_ADD_CONST delta, the else path
in adjust_reg_min_max_vals() only clears dst_reg->id but leaves
dst_reg->delta unchanged.

This stale delta can propagate via assign_scalar_id_before_mov()
when the register is later used in a mov. It gets a fresh id but
keeps the stale delta from the old (now-cleared) BPF_ADD_CONST.
This stale delta can later propagate leading to a verifier-vs-
runtime value mismatch.

The clear_id label already correctly clears both delta and id.
Make the else path consistent by also zeroing the delta when id
is cleared. More generally, this introduces a helper clear_scalar_id()
which internally takes care of zeroing. There are various other
locations in the verifier where only the id is cleared. By using
the helper we catch all current and future locations.

Fixes: 98d7ca374ba4 ("bpf: Track delta between "linked" registers.")
Reported-by: STAR Labs SG <info@starlabs.sg>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 kernel/bpf/verifier.c | 56 +++++++++++++++++++++----------------------
 1 file changed, 28 insertions(+), 28 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index d83e17cccd38..40584ab48fb4 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -5257,27 +5257,30 @@ static bool __is_pointer_value(bool allow_ptr_leaks,
 	return reg->type != SCALAR_VALUE;
 }
 
+static void clear_scalar_id(struct bpf_reg_state *reg)
+{
+	reg->id = 0;
+	reg->delta = 0;
+}
+
 static void assign_scalar_id_before_mov(struct bpf_verifier_env *env,
 					struct bpf_reg_state *src_reg)
 {
 	if (src_reg->type != SCALAR_VALUE)
 		return;
-
-	if (src_reg->id & BPF_ADD_CONST) {
-		/*
-		 * The verifier is processing rX = rY insn and
-		 * rY->id has special linked register already.
-		 * Cleared it, since multiple rX += const are not supported.
-		 */
-		src_reg->id = 0;
-		src_reg->delta = 0;
-	}
-
+	/*
+	 * The verifier is processing rX = rY insn and
+	 * rY->id has special linked register already.
+	 * Cleared it, since multiple rX += const are not supported.
+	 */
+	if (src_reg->id & BPF_ADD_CONST)
+		clear_scalar_id(src_reg);
+	/*
+	 * Ensure that src_reg has a valid ID that will be copied to
+	 * dst_reg and then will be used by sync_linked_regs() to
+	 * propagate min/max range.
+	 */
 	if (!src_reg->id && !tnum_is_const(src_reg->var_off))
-		/* Ensure that src_reg has a valid ID that will be copied to
-		 * dst_reg and then will be used by sync_linked_regs() to
-		 * propagate min/max range.
-		 */
 		src_reg->id = ++env->id_gen;
 }
 
@@ -5715,7 +5718,7 @@ static int check_stack_read_fixed_off(struct bpf_verifier_env *env,
 				 * coerce_reg_to_size will adjust the boundaries.
 				 */
 				if (get_reg_width(reg) > size * BITS_PER_BYTE)
-					state->regs[dst_regno].id = 0;
+					clear_scalar_id(&state->regs[dst_regno]);
 			} else {
 				int spill_cnt = 0, zero_cnt = 0;
 
@@ -16346,7 +16349,7 @@ static void scalar_byte_swap(struct bpf_reg_state *dst_reg, struct bpf_insn *ins
 	 * any existing ties and avoid incorrect bounds propagation.
 	 */
 	if (need_bswap || insn->imm == 16 || insn->imm == 32)
-		dst_reg->id = 0;
+		clear_scalar_id(dst_reg);
 
 	if (need_bswap) {
 		if (insn->imm == 16)
@@ -16748,8 +16751,7 @@ static int adjust_reg_min_max_vals(struct bpf_verifier_env *env,
 			 * we cannot accumulate another val into rx->off.
 			 */
 clear_id:
-			dst_reg->delta = 0;
-			dst_reg->id = 0;
+			clear_scalar_id(dst_reg);
 		} else {
 			if (alu32)
 				dst_reg->id |= BPF_ADD_CONST32;
@@ -16762,7 +16764,7 @@ static int adjust_reg_min_max_vals(struct bpf_verifier_env *env,
 		 * Make sure ID is cleared otherwise dst_reg min/max could be
 		 * incorrectly propagated into other registers by sync_linked_regs()
 		 */
-		dst_reg->id = 0;
+		clear_scalar_id(dst_reg);
 	}
 	return 0;
 }
@@ -16893,7 +16895,7 @@ static int check_alu_op(struct bpf_verifier_env *env, struct bpf_insn *insn)
 							assign_scalar_id_before_mov(env, src_reg);
 						copy_register_state(dst_reg, src_reg);
 						if (!no_sext)
-							dst_reg->id = 0;
+							clear_scalar_id(dst_reg);
 						coerce_reg_to_size_sx(dst_reg, insn->off >> 3);
 						dst_reg->subreg_def = DEF_NOT_SUBREG;
 					} else {
@@ -16919,7 +16921,7 @@ static int check_alu_op(struct bpf_verifier_env *env, struct bpf_insn *insn)
 						 * propagated into src_reg by sync_linked_regs()
 						 */
 						if (!is_src_reg_u32)
-							dst_reg->id = 0;
+							clear_scalar_id(dst_reg);
 						dst_reg->subreg_def = env->insn_idx + 1;
 					} else {
 						/* case: W1 = (s8, s16)W2 */
@@ -16929,7 +16931,7 @@ static int check_alu_op(struct bpf_verifier_env *env, struct bpf_insn *insn)
 							assign_scalar_id_before_mov(env, src_reg);
 						copy_register_state(dst_reg, src_reg);
 						if (!no_sext)
-							dst_reg->id = 0;
+							clear_scalar_id(dst_reg);
 						dst_reg->subreg_def = env->insn_idx + 1;
 						coerce_subreg_to_size_sx(dst_reg, insn->off >> 3);
 					}
@@ -17788,7 +17790,7 @@ static void __collect_linked_regs(struct linked_regs *reg_set, struct bpf_reg_st
 		e->is_reg = is_reg;
 		e->regno = spi_or_reg;
 	} else {
-		reg->id = 0;
+		clear_scalar_id(reg);
 	}
 }
 
@@ -20220,10 +20222,8 @@ static void clear_singular_ids(struct bpf_verifier_env *env,
 			continue;
 		if (!reg->id)
 			continue;
-		if (idset_cnt_get(idset, reg->id & ~BPF_ADD_CONST) == 1) {
-			reg->id = 0;
-			reg->delta = 0;
-		}
+		if (idset_cnt_get(idset, reg->id & ~BPF_ADD_CONST) == 1)
+			clear_scalar_id(reg);
 	}));
 }
 
-- 
2.43.0

