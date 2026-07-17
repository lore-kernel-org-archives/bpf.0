Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F37E737C0E7
	for <bpf@vger.kernel.org>; Fri, 17 Jul 2026 04:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784263247; cv=none; b=keIaKibOBC1ILT1mGprCUx8lzs1b2iyJYwda7gN0Io1YyZTFxAeO10jRFVReae2uF6DHQOzEAjmMc97AXkc6GJGBn9tySgaEsm/rma2dFFX6B50seReu4J5CjPSKQH+3YhpcjwqhJB92VrHeSVY58BsXMs3L6DKd9B4lCcoX4kY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784263247; c=relaxed/simple;
	bh=21qpONp5GiYMOsGB6QEeDD/jAVfYAtzReSx/0vCIy8E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ah02IPtY9re1Sy9+4iAC63kkaroQpjwTxq5j66H64CJHYiNdqeZWgDzUuCv00uLCZhVkxbFtSoTGij2b6J+OA9NDjfKXHfyIvT+p7StMo21OQxEpLEsqneBOMqVr7CZON4ZM/mzNc3iHt+k0e5FPlwK0CPhyY3VkayVM6bCGlKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=RZ04NSd/; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="RZ04NSd/"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-c15cb6f5c12so1284184066b.0
        for <bpf@vger.kernel.org>; Thu, 16 Jul 2026 21:40:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1784263241; x=1784868041; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Jl9U9nMuaI7f/0zWnVu/LVhBlsqXAL2CUYCsrYnW834=;
        b=RZ04NSd/pe/feP0nhFdulYNBS3HtFauyS7aNuYtVBPdt2IljDBEwEiNOZpW/63A8R5
         A7MevCA4GugbcuRCRTvkCNUxcyNjZrlZ+wmP9PQIdo3eDIrbUaC2FkmBmCuuYIYSgkJD
         jfSewHJsN/1DaGB/rBUvBIpM3c+E6LuXrOV1YanDdRC0Njxx+oWU2Dxe1+aFPY6teYjc
         NBOskozrWI9GkzbHzLxKRLV/k9shhG3SmbzvjTR4Ada0JaW/TuySZ+4j+BU1j9w/sq0G
         ZlI25TTqF4DAhSaZjrvqyBjd4GkWul/UVzUCPezLh1wcD1TzKrASDp0/FsoPMxnGYM6F
         YlbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784263241; x=1784868041;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Jl9U9nMuaI7f/0zWnVu/LVhBlsqXAL2CUYCsrYnW834=;
        b=XrPul3zSsFSg11hPLpY40QwjMXX/+7nKBD3hzV7uvVA7KJAmkvdsb6D1XTW7XZ9pnW
         itI1tK5Piof22pdFV1yaTUQJ7JjL/CfyDp+0X0XPQmT9kWN69Ta/jXCVp1OCIVcoUFQt
         OO762aMe1LR00BSrwXFrXebl9iysMJS3ki3+hYavW+/eQlSgygE7fxmxi0bLWo8DM3yP
         juARxYk8IzoXkSJaxTEXQU3jUb5Zyccxxc0suuxPv2NuVN1UH0Pn94MhkcPVsnMPTALE
         m/v240qmO/31eyNGqpDFo+i+aJLi5neG2HPvDE8phHPE5Qo9dy6btsGQsRJZf9RmFbBb
         KGsA==
X-Gm-Message-State: AOJu0Yyf/WtqTfgk2dSfR6v0ERp32U5OyF0sA78UBGImSOLHoW8Vsl4s
	hb3Lrw8mVrppUAgRtHKZR6Wzfh0wHlMk+VfEIR86LJObmC5uvP8gbyl7QE2JNju8qVE1wxNBtpk
	KIo4i
X-Gm-Gg: AfdE7cmRx7/ZHHVfk2uMeXRhF4HYPpdsTPBr2jCuZ1t+q6rNinUKXFkGkZu53N/RXUG
	CAQvYCQxlv4hjD6t3o92b5VkUN9ptmMM0FPt6cxBpu8mfODL5QPbVOkNqPlIIWzkNAQezdEzxxG
	0aGatqe+RyTASgrXM0t2T0Fq2oUQlgb5zybmy0ZKc4pEuPm5MTrCmaqagrB2oI8ou4Li3F6z0Z5
	ImjplwJiumrDHbbxwxj4IgLRFm2yV1YXX3JDsUy584MAvgLkwEODzc3aYLe6DKIV07Mh3Mc4YvZ
	x5qVRiQb9YayHUGMkNsHgkkkGztKcZORqZPdoz8GvLYmREc56LPYhs1FxadFVONrKAVklE5X/zJ
	v+PZscUtjst7qnW2KovOp3LqU5ejsv3LkiFm7DDYfaKT/Pq1tKREAjkpEGITav/7h3wI4cMBOhw
	z7AAUiab4FGFk8iBU0v78JZuVF60JrfF0=
X-Received: by 2002:a17:907:962a:b0:c16:4fc:2bc1 with SMTP id a640c23a62f3a-c16b48331d9mr32494766b.45.1784263240984;
        Thu, 16 Jul 2026 21:40:40 -0700 (PDT)
Received: from localhost (106-64-25-226.adsl.fetnet.net. [106.64.25.226])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf344b1ef8sm3628355ad.21.2026.07.16.21.40.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2026 21:40:39 -0700 (PDT)
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: bpf@vger.kernel.org
Cc: Shung-Hsi Yu <shung-hsi.yu@suse.com>,
	STAR Labs SG <info@starlabs.sg>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Alexei Starovoitov <ast@kernel.org>
Subject: [PATCH stable 6.18 4/6] bpf: Clear delta when clearing reg id for non-{add,sub} ops
Date: Fri, 17 Jul 2026 12:40:03 +0800
Message-ID: <20260717044009.120224-5-shung-hsi.yu@suse.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260717044009.120224-1-shung-hsi.yu@suse.com>
References: <20260717044009.120224-1-shung-hsi.yu@suse.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Daniel Borkmann <daniel@iogearbox.net>

commit 1b327732c84640c1e3da487eefe9d00cc9f2dd34 upstream.

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
Link: https://lore.kernel.org/r/20260407192421.508817-2-daniel@iogearbox.net
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
[shung-hsi.yu: `delta` field was called `off` before commit 3d91c618aca4 ("bpf:
rename bpf_reg_state->off to bpf_reg_state->delta"), and clear_singular_ids()
does not exists before commit b2a0aa3a8739 ("bpf: Clear singular ids for
scalars in is_state_visited()")]
Signed-off-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
---
 kernel/bpf/verifier.c | 50 ++++++++++++++++++++++---------------------
 1 file changed, 26 insertions(+), 24 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 3dcf591acd50..bf8cadd19593 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -5013,27 +5013,30 @@ static bool __is_pointer_value(bool allow_ptr_leaks,
 	return reg->type != SCALAR_VALUE;
 }
 
+static void clear_scalar_id(struct bpf_reg_state *reg)
+{
+	reg->id = 0;
+	reg->off = 0;
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
-		src_reg->off = 0;
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
 
@@ -5466,7 +5469,7 @@ static int check_stack_read_fixed_off(struct bpf_verifier_env *env,
 				 * coerce_reg_to_size will adjust the boundaries.
 				 */
 				if (get_reg_width(reg) > size * BITS_PER_BYTE)
-					state->regs[dst_regno].id = 0;
+					clear_scalar_id(&state->regs[dst_regno]);
 			} else {
 				int spill_cnt = 0, zero_cnt = 0;
 
@@ -15476,7 +15479,7 @@ static void scalar_byte_swap(struct bpf_reg_state *dst_reg, struct bpf_insn *ins
 	 * any existing ties and avoid incorrect bounds propagation.
 	 */
 	if (need_bswap || insn->imm == 16 || insn->imm == 32)
-		dst_reg->id = 0;
+		clear_scalar_id(dst_reg);
 
 	if (need_bswap) {
 		if (insn->imm == 16)
@@ -15845,8 +15848,7 @@ static int adjust_reg_min_max_vals(struct bpf_verifier_env *env,
 			 * we cannot accumulate another val into rx->off.
 			 */
 clear_id:
-			dst_reg->off = 0;
-			dst_reg->id = 0;
+			clear_scalar_id(dst_reg);
 		} else {
 			if (alu32)
 				dst_reg->id |= BPF_ADD_CONST32;
@@ -15859,7 +15861,7 @@ static int adjust_reg_min_max_vals(struct bpf_verifier_env *env,
 		 * Make sure ID is cleared otherwise dst_reg min/max could be
 		 * incorrectly propagated into other registers by sync_linked_regs()
 		 */
-		dst_reg->id = 0;
+		clear_scalar_id(dst_reg);
 	}
 	return 0;
 }
@@ -15990,7 +15992,7 @@ static int check_alu_op(struct bpf_verifier_env *env, struct bpf_insn *insn)
 							assign_scalar_id_before_mov(env, src_reg);
 						copy_register_state(dst_reg, src_reg);
 						if (!no_sext)
-							dst_reg->id = 0;
+							clear_scalar_id(dst_reg);
 						coerce_reg_to_size_sx(dst_reg, insn->off >> 3);
 						dst_reg->subreg_def = DEF_NOT_SUBREG;
 					} else {
@@ -16016,7 +16018,7 @@ static int check_alu_op(struct bpf_verifier_env *env, struct bpf_insn *insn)
 						 * propagated into src_reg by sync_linked_regs()
 						 */
 						if (!is_src_reg_u32)
-							dst_reg->id = 0;
+							clear_scalar_id(dst_reg);
 						dst_reg->subreg_def = env->insn_idx + 1;
 					} else {
 						/* case: W1 = (s8, s16)W2 */
@@ -16026,7 +16028,7 @@ static int check_alu_op(struct bpf_verifier_env *env, struct bpf_insn *insn)
 							assign_scalar_id_before_mov(env, src_reg);
 						copy_register_state(dst_reg, src_reg);
 						if (!no_sext)
-							dst_reg->id = 0;
+							clear_scalar_id(dst_reg);
 						dst_reg->subreg_def = env->insn_idx + 1;
 						coerce_subreg_to_size_sx(dst_reg, insn->off >> 3);
 					}
@@ -16856,7 +16858,7 @@ static void __collect_linked_regs(struct linked_regs *reg_set, struct bpf_reg_st
 		e->is_reg = is_reg;
 		e->regno = spi_or_reg;
 	} else {
-		reg->id = 0;
+		clear_scalar_id(reg);
 	}
 }
 
-- 
2.54.0

