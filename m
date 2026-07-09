Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0125E3E4C9F;
	Thu,  9 Jul 2026 10:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783591400; cv=none; b=qAbbPvyECUEDTkkdadJSUXgzfhG1Vsnd9xUsGMPiDnMOJiaytTVYC5JkH+Zw3SgjBh4HVTkWTNXGMBNy2f36PlxLI5/h2NGw55J6KtK2Dd7r/yVBb/YY9UG2MUVuJAaFugg+PF2cWOYw0plRUVuB8TjLoToWCPykNfkCdPZQTc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783591400; c=relaxed/simple;
	bh=Prcy0pRLUQn1Bt/KGx9wGENLrQCegy2qQzsrnGwY78s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ci5kXdeMbT2FCW3X0pIHHIJq1Bh9I8rrrq5bfgtCbKwX5DEjDKgjbRNg0LWV0Xijxp97ZgGQDAqA5AeVOwN+xLZNGepFvymTZQBSssfC3LtdRuaDCaxtMpsIupizBTLjT1stJW4Nzl2T8+BX4AO9K+NbBX0mz6I5mGUPBKM9v1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=rjhWSASV; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="rjhWSASV"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id BEFBCC2F4C1;
	Thu,  9 Jul 2026 10:03:30 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 727915FF03;
	Thu,  9 Jul 2026 10:03:16 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 2F5C511BC3742;
	Thu,  9 Jul 2026 12:03:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1783591394; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=sG1gSEc/eXJq8S0cXK70OkcPm1x5huFZajjLKmolIKU=;
	b=rjhWSASVb3SHAW1P8WoiBH4MrBH5Q+HeDg6Fn4Rav7k6+2g/JNdXm7ljUXbehK8jsTRnpj
	haZK2/JYuD+BGWtIfg1vAaQKmWI1sZgBCu4xPJJ/b8/qOuJY2AKFus0fQ9/MkZ/HVJtTug
	iiKJEr6/p0QrsbRuKzZw9FXsMrtyBou6c5j6EbF8donTM5npZMl948jKeX0yrMagVtJYyg
	8Wdo2fDNW1+np2S74hNYYuoMKVSTWDmSdD1tqR/CqrSnmBbKpIq9qCp0+/hcg4E7JUOKIe
	26Fn75OmMjSQq9+nWv7zhNq7BEexRhmDVmCo4GX82jr3yppgwj9JK8X5/beElg==
From: =?utf-8?q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
Date: Thu, 09 Jul 2026 12:01:42 +0200
Subject: [PATCH bpf-next v5 01/10] bpf: propagate original instruction
 offset when patching program
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260709-kasan-v5-1-1c64af8e4e1e@bootlin.com>
References: <20260709-kasan-v5-0-1c64af8e4e1e@bootlin.com>
In-Reply-To: <20260709-kasan-v5-0-1c64af8e4e1e@bootlin.com>
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
 Thomas Gleixner <tglx@kernel.org>, Borislav Petkov <bp@alien8.de>, 
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
 "H. Peter Anvin" <hpa@zytor.com>, Shuah Khan <shuah@kernel.org>, 
 Ingo Molnar <mingo@redhat.com>, Andrey Konovalov <andreyknvl@gmail.com>
Cc: ebpf@linuxfoundation.org, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, bpf@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 =?utf-8?q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
X-Mailer: b4 0.15.2
X-Last-TLS-Session-Version: TLSv1.3

When the verifier patches an ebpf program with bpf_patch_insn_data, it
then calls adjust_insn_aux_data to make sure that insn_aux_data takes
into account the newly inserted patch. Some of the data offset is pretty
straightforward to deduce, it is for example the case for
indirect_target, as any patch affecting indirect calls will
systematically move the original instruction to the end of the new
patch.

In order to introduce KASAN support for eBPF JIT, we need to mark any
load/store instruction that accesses non-stack memory, but updating this
new marking after a patch is not as straightforward as for indirect
calls: the original BPF_ST/BPF_STX/BPF_LDX can be at the beginning, at
the end or somewhere in the middle of the new patch: we then need some
additional info to properly update this marking.

Add a new parameter to bpf_patch_insn_data and adjust_insn_aux_data to
convey the info about the new location in the patch of the original
instruction. This info does not always make sense depending on the
generated patch (eg, some bpf helpers being inlined by the verifier, and
so turned into multiple new instructions without any remaining BPF_CALL),
the parameter can then be set to -1. It will be used in next patches to
properly handle insn_aux_data adjustment for the new KASAN
instrumentation

Signed-off-by: Alexis Lothoré (eBPF Foundation) <alexis.lothore@bootlin.com>
---
Changes in v5:
- fix a few incorrect offset values

Changes in v4:
- define insn_off_in_patch inside convert_ctx_accesses main loop to
  avoid old value leakage

Changes in v3:
- new patch
---
 include/linux/filter.h |  10 +++--
 kernel/bpf/core.c      |   2 +-
 kernel/bpf/fixups.c    | 100 ++++++++++++++++++++++++++++++++-----------------
 3 files changed, 74 insertions(+), 38 deletions(-)

diff --git a/include/linux/filter.h b/include/linux/filter.h
index 14acb2455746..1ebcd247ef4e 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -1210,13 +1210,17 @@ struct bpf_prog *bpf_patch_insn_single(struct bpf_prog *prog, u32 off,
 
 #ifdef CONFIG_BPF_SYSCALL
 struct bpf_prog *bpf_patch_insn_data(struct bpf_verifier_env *env, u32 off,
-				     const struct bpf_insn *patch, u32 len);
+				     const struct bpf_insn *patch, u32 len,
+				     s32 insn_off_in_patch);
 struct bpf_insn_aux_data *bpf_dup_insn_aux_data(struct bpf_verifier_env *env);
 void bpf_restore_insn_aux_data(struct bpf_verifier_env *env,
 			       struct bpf_insn_aux_data *orig_insn_aux);
 #else
-static inline struct bpf_prog *bpf_patch_insn_data(struct bpf_verifier_env *env, u32 off,
-						   const struct bpf_insn *patch, u32 len)
+static inline struct bpf_prog *bpf_patch_insn_data(struct bpf_verifier_env *env,
+						   u32 off,
+						   const struct bpf_insn *patch,
+						   u32 len,
+						   s32 insn_off_in_patch)
 {
 	return ERR_PTR(-ENOTSUPP);
 }
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 47fe047ad30b..cff0035f401a 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -1599,7 +1599,7 @@ struct bpf_prog *bpf_jit_blind_constants(struct bpf_verifier_env *env, struct bp
 			continue;
 
 		if (env)
-			tmp = bpf_patch_insn_data(env, i, insn_buff, rewritten);
+			tmp = bpf_patch_insn_data(env, i, insn_buff, rewritten, rewritten - 1);
 		else
 			tmp = bpf_patch_insn_single(clone, i, insn_buff, rewritten);
 
diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
index d3be972714b2..188ea6205d61 100644
--- a/kernel/bpf/fixups.c
+++ b/kernel/bpf/fixups.c
@@ -157,7 +157,8 @@ static int get_callee_stack_depth(struct bpf_verifier_env *env,
  * [0, off) and [off, end) to new locations, so the patched range stays zero
  */
 static void adjust_insn_aux_data(struct bpf_verifier_env *env,
-				 struct bpf_prog *new_prog, u32 off, u32 cnt)
+				 struct bpf_prog *new_prog, u32 off, u32 cnt,
+				 s32 insn_off_in_patch)
 {
 	struct bpf_insn_aux_data *data = env->insn_aux_data;
 	struct bpf_insn *insn = new_prog->insnsi;
@@ -245,7 +246,8 @@ static void adjust_poke_descs(struct bpf_prog *prog, u32 off, u32 len)
 }
 
 struct bpf_prog *bpf_patch_insn_data(struct bpf_verifier_env *env, u32 off,
-				     const struct bpf_insn *patch, u32 len)
+				     const struct bpf_insn *patch, u32 len,
+				     s32 insn_off_in_patch)
 {
 	struct bpf_prog *new_prog;
 	struct bpf_insn_aux_data *new_data = NULL;
@@ -269,7 +271,7 @@ struct bpf_prog *bpf_patch_insn_data(struct bpf_verifier_env *env, u32 off,
 				env->insn_aux_data[off].orig_idx);
 		return NULL;
 	}
-	adjust_insn_aux_data(env, new_prog, off, len);
+	adjust_insn_aux_data(env, new_prog, off, len, insn_off_in_patch);
 	adjust_subprog_starts(env, off, len);
 	adjust_insn_arrays(env, off, len);
 	adjust_poke_descs(new_prog, off, len);
@@ -668,7 +670,7 @@ int bpf_opt_subreg_zext_lo32_rnd_hi32(struct bpf_verifier_env *env,
 		patch = zext_patch;
 		patch_len = 2;
 apply_patch_buffer:
-		new_prog = bpf_patch_insn_data(env, adj_idx, patch, patch_len);
+		new_prog = bpf_patch_insn_data(env, adj_idx, patch, patch_len, 0);
 		if (!new_prog)
 			return -ENOMEM;
 		env->prog = new_prog;
@@ -713,7 +715,7 @@ int bpf_convert_ctx_accesses(struct bpf_verifier_env *env)
 			insn_buf[cnt++] = BPF_STX_MEM(BPF_DW, BPF_REG_FP, BPF_REG_1,
 						      -subprogs[0].stack_depth);
 			insn_buf[cnt++] = env->prog->insnsi[0];
-			new_prog = bpf_patch_insn_data(env, 0, insn_buf, cnt);
+			new_prog = bpf_patch_insn_data(env, 0, insn_buf, cnt, 1);
 			if (!new_prog)
 				return -ENOMEM;
 			env->prog = new_prog;
@@ -736,7 +738,8 @@ int bpf_convert_ctx_accesses(struct bpf_verifier_env *env)
 			verifier_bug(env, "prologue is too long");
 			return -EFAULT;
 		} else if (cnt) {
-			new_prog = bpf_patch_insn_data(env, 0, insn_buf, cnt);
+			new_prog = bpf_patch_insn_data(env, 0, insn_buf, cnt,
+						       cnt - 1);
 			if (!new_prog)
 				return -ENOMEM;
 
@@ -768,7 +771,8 @@ int bpf_convert_ctx_accesses(struct bpf_verifier_env *env)
 			*patch++ = BPF_ST_NOSPEC();
 			*patch++ = *insn;
 			cnt = patch - insn_buf;
-			new_prog = bpf_patch_insn_data(env, i + delta, insn_buf, cnt);
+			new_prog = bpf_patch_insn_data(env, i + delta, insn_buf,
+						       cnt, cnt - 1);
 			if (!new_prog)
 				return -ENOMEM;
 
@@ -841,7 +845,8 @@ int bpf_convert_ctx_accesses(struct bpf_verifier_env *env)
 			*patch++ = *insn;
 			*patch++ = BPF_ST_NOSPEC();
 			cnt = patch - insn_buf;
-			new_prog = bpf_patch_insn_data(env, i + delta, insn_buf, cnt);
+			new_prog = bpf_patch_insn_data(env, i + delta, insn_buf,
+						       cnt, 0);
 			if (!new_prog)
 				return -ENOMEM;
 
@@ -971,7 +976,8 @@ int bpf_convert_ctx_accesses(struct bpf_verifier_env *env)
 						       size * 8, 0);
 
 patch_insn_buf:
-		new_prog = bpf_patch_insn_data(env, i + delta, insn_buf, cnt);
+		new_prog =
+			bpf_patch_insn_data(env, i + delta, insn_buf, cnt, -1);
 		if (!new_prog)
 			return -ENOMEM;
 
@@ -1463,7 +1469,7 @@ static int add_hidden_subprog(struct bpf_verifier_env *env, struct bpf_insn *pat
 	 * ones for the hidden subprog. Hence all of the adjustment operations
 	 * in bpf_patch_insn_data are no-ops.
 	 */
-	prog = bpf_patch_insn_data(env, env->prog->len - 1, patch, len);
+	prog = bpf_patch_insn_data(env, env->prog->len - 1, patch, len, 0);
 	if (!prog)
 		return -ENOMEM;
 	env->prog = prog;
@@ -1548,7 +1554,8 @@ int bpf_do_misc_fixups(struct bpf_verifier_env *env)
 
 			cnt = patch - insn_buf;
 
-			new_prog = bpf_patch_insn_data(env, i + delta, insn_buf, cnt);
+			new_prog = bpf_patch_insn_data(env, i + delta, insn_buf,
+						       cnt, 0);
 			if (!new_prog)
 				return -ENOMEM;
 
@@ -1568,6 +1575,7 @@ int bpf_do_misc_fixups(struct bpf_verifier_env *env)
 			bool is_sdiv = isdiv && insn->off == 1;
 			bool is_smod = !isdiv && insn->off == 1;
 			struct bpf_insn *patch = insn_buf;
+			s32 insn_off_in_patch;
 
 			if (is_sdiv) {
 				/* [R,W]x sdiv 0 -> 0
@@ -1594,6 +1602,7 @@ int bpf_do_misc_fixups(struct bpf_verifier_env *env)
 				*patch++ = BPF_JMP_IMM(BPF_JA, 0, 0, 1);
 				*patch++ = *insn;
 				cnt = patch - insn_buf;
+				insn_off_in_patch = cnt - 1;
 			} else if (is_smod) {
 				/* [R,W]x mod 0 -> [R,W]x */
 				/* [R,W]x mod -1 -> 0 */
@@ -1610,6 +1619,7 @@ int bpf_do_misc_fixups(struct bpf_verifier_env *env)
 				*patch++ = BPF_MOV32_IMM(insn->dst_reg, 0);
 				*patch++ = BPF_JMP_IMM(BPF_JA, 0, 0, 1);
 				*patch++ = *insn;
+				insn_off_in_patch = patch - insn_buf - 1;
 
 				if (!is64) {
 					*patch++ = BPF_JMP_IMM(BPF_JA, 0, 0, 1);
@@ -1625,12 +1635,14 @@ int bpf_do_misc_fixups(struct bpf_verifier_env *env)
 				*patch++ = BPF_JMP_IMM(BPF_JA, 0, 0, 1);
 				*patch++ = *insn;
 				cnt = patch - insn_buf;
+				insn_off_in_patch = cnt - 1;
 			} else {
 				/* [R,W]x mod 0 -> [R,W]x */
 				*patch++ = BPF_RAW_INSN((is64 ? BPF_JMP : BPF_JMP32) |
 							BPF_JEQ | BPF_K, insn->src_reg,
 							0, 1 + (is64 ? 0 : 1), 0);
 				*patch++ = *insn;
+				insn_off_in_patch = patch - insn_buf - 1;
 
 				if (!is64) {
 					*patch++ = BPF_JMP_IMM(BPF_JA, 0, 0, 1);
@@ -1639,7 +1651,8 @@ int bpf_do_misc_fixups(struct bpf_verifier_env *env)
 				cnt = patch - insn_buf;
 			}
 
-			new_prog = bpf_patch_insn_data(env, i + delta, insn_buf, cnt);
+			new_prog = bpf_patch_insn_data(env, i + delta, insn_buf,
+						       cnt, insn_off_in_patch);
 			if (!new_prog)
 				return -ENOMEM;
 
@@ -1655,6 +1668,7 @@ int bpf_do_misc_fixups(struct bpf_verifier_env *env)
 		     BPF_MODE(insn->code) == BPF_PROBE_MEMSX)) {
 			struct bpf_insn *patch = insn_buf;
 			u64 uaddress_limit = bpf_arch_uaddress_limit();
+			s32 insn_off_in_patch;
 
 			if (!uaddress_limit)
 				goto next_insn;
@@ -1665,11 +1679,13 @@ int bpf_do_misc_fixups(struct bpf_verifier_env *env)
 			*patch++ = BPF_ALU64_IMM(BPF_RSH, BPF_REG_AX, 32);
 			*patch++ = BPF_JMP_IMM(BPF_JLE, BPF_REG_AX, uaddress_limit >> 32, 2);
 			*patch++ = *insn;
+			insn_off_in_patch = patch - insn_buf - 1;
 			*patch++ = BPF_JMP_IMM(BPF_JA, 0, 0, 1);
 			*patch++ = BPF_MOV64_IMM(insn->dst_reg, 0);
 
 			cnt = patch - insn_buf;
-			new_prog = bpf_patch_insn_data(env, i + delta, insn_buf, cnt);
+			new_prog = bpf_patch_insn_data(env, i + delta, insn_buf,
+						       cnt, insn_off_in_patch);
 			if (!new_prog)
 				return -ENOMEM;
 
@@ -1689,7 +1705,8 @@ int bpf_do_misc_fixups(struct bpf_verifier_env *env)
 				return -EFAULT;
 			}
 
-			new_prog = bpf_patch_insn_data(env, i + delta, insn_buf, cnt);
+			new_prog = bpf_patch_insn_data(env, i + delta, insn_buf,
+						       cnt, 0);
 			if (!new_prog)
 				return -ENOMEM;
 
@@ -1742,7 +1759,8 @@ int bpf_do_misc_fixups(struct bpf_verifier_env *env)
 				*patch++ = BPF_ALU64_IMM(BPF_MUL, off_reg, -1);
 			cnt = patch - insn_buf;
 
-			new_prog = bpf_patch_insn_data(env, i + delta, insn_buf, cnt);
+			new_prog = bpf_patch_insn_data(env, i + delta, insn_buf,
+						       cnt, cnt - 1);
 			if (!new_prog)
 				return -ENOMEM;
 
@@ -1787,7 +1805,8 @@ int bpf_do_misc_fixups(struct bpf_verifier_env *env)
 			insn_buf[6] = BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_AX, stack_off_cnt);
 			cnt = 7;
 
-			new_prog = bpf_patch_insn_data(env, i + delta, insn_buf, cnt);
+			new_prog = bpf_patch_insn_data(env, i + delta, insn_buf,
+						       cnt, 3);
 			if (!new_prog)
 				return -ENOMEM;
 
@@ -1808,7 +1827,8 @@ int bpf_do_misc_fixups(struct bpf_verifier_env *env)
 			insn_buf[3] = BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_AX, stack_off);
 			cnt = 4;
 
-			new_prog = bpf_patch_insn_data(env, i + delta, insn_buf, cnt);
+			new_prog = bpf_patch_insn_data(env, i + delta, insn_buf,
+						       cnt, 2);
 			if (!new_prog)
 				return -ENOMEM;
 
@@ -1829,7 +1849,8 @@ int bpf_do_misc_fixups(struct bpf_verifier_env *env)
 			if (cnt == 0)
 				goto next_insn;
 
-			new_prog = bpf_patch_insn_data(env, i + delta, insn_buf, cnt);
+			new_prog = bpf_patch_insn_data(env, i + delta, insn_buf,
+						       cnt, cnt - 1);
 			if (!new_prog)
 				return -ENOMEM;
 
@@ -1916,7 +1937,8 @@ int bpf_do_misc_fixups(struct bpf_verifier_env *env)
 								 map)->index_mask);
 			insn_buf[2] = *insn;
 			cnt = 3;
-			new_prog = bpf_patch_insn_data(env, i + delta, insn_buf, cnt);
+			new_prog = bpf_patch_insn_data(env, i + delta, insn_buf,
+						       cnt, cnt - 1);
 			if (!new_prog)
 				return -ENOMEM;
 
@@ -1949,7 +1971,8 @@ int bpf_do_misc_fixups(struct bpf_verifier_env *env)
 			insn_buf[2] = *insn;
 			cnt = 3;
 
-			new_prog = bpf_patch_insn_data(env, i + delta, insn_buf, cnt);
+			new_prog = bpf_patch_insn_data(env, i + delta, insn_buf,
+						       cnt, cnt - 1);
 			if (!new_prog)
 				return -ENOMEM;
 
@@ -1968,7 +1991,8 @@ int bpf_do_misc_fixups(struct bpf_verifier_env *env)
 			insn_buf[1] = *insn;
 			cnt = 2;
 
-			new_prog = bpf_patch_insn_data(env, i + delta, insn_buf, cnt);
+			new_prog = bpf_patch_insn_data(env, i + delta, insn_buf,
+						       cnt, cnt - 1);
 			if (!new_prog)
 				return -ENOMEM;
 
@@ -2008,8 +2032,8 @@ int bpf_do_misc_fixups(struct bpf_verifier_env *env)
 					return -EFAULT;
 				}
 
-				new_prog = bpf_patch_insn_data(env, i + delta,
-							       insn_buf, cnt);
+				new_prog = bpf_patch_insn_data(
+					env, i + delta, insn_buf, cnt, -1);
 				if (!new_prog)
 					return -ENOMEM;
 
@@ -2092,7 +2116,7 @@ int bpf_do_misc_fixups(struct bpf_verifier_env *env)
 			cnt = 3;
 
 			new_prog = bpf_patch_insn_data(env, i + delta, insn_buf,
-						       cnt);
+						       cnt, -1);
 			if (!new_prog)
 				return -ENOMEM;
 
@@ -2120,7 +2144,8 @@ int bpf_do_misc_fixups(struct bpf_verifier_env *env)
 			insn_buf[0] = BPF_ALU32_REG(BPF_XOR, BPF_REG_0, BPF_REG_0);
 			cnt = 1;
 #endif
-			new_prog = bpf_patch_insn_data(env, i + delta, insn_buf, cnt);
+			new_prog = bpf_patch_insn_data(env, i + delta, insn_buf,
+						       cnt, -1);
 			if (!new_prog)
 				return -ENOMEM;
 
@@ -2138,7 +2163,8 @@ int bpf_do_misc_fixups(struct bpf_verifier_env *env)
 			insn_buf[2] = BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_0, 0);
 			cnt = 3;
 
-			new_prog = bpf_patch_insn_data(env, i + delta, insn_buf, cnt);
+			new_prog = bpf_patch_insn_data(env, i + delta, insn_buf,
+						       cnt, -1);
 			if (!new_prog)
 				return -ENOMEM;
 
@@ -2172,7 +2198,8 @@ int bpf_do_misc_fixups(struct bpf_verifier_env *env)
 			insn_buf[cnt++] = BPF_JMP_A(1);
 			insn_buf[cnt++] = BPF_MOV64_IMM(BPF_REG_0, -EINVAL);
 
-			new_prog = bpf_patch_insn_data(env, i + delta, insn_buf, cnt);
+			new_prog = bpf_patch_insn_data(env, i + delta, insn_buf,
+						       cnt, -1);
 			if (!new_prog)
 				return -ENOMEM;
 
@@ -2204,7 +2231,8 @@ int bpf_do_misc_fixups(struct bpf_verifier_env *env)
 				cnt = 1;
 			}
 
-			new_prog = bpf_patch_insn_data(env, i + delta, insn_buf, cnt);
+			new_prog = bpf_patch_insn_data(env, i + delta, insn_buf,
+						       cnt, -1);
 			if (!new_prog)
 				return -ENOMEM;
 
@@ -2230,7 +2258,8 @@ int bpf_do_misc_fixups(struct bpf_verifier_env *env)
 				cnt = 2;
 			}
 
-			new_prog = bpf_patch_insn_data(env, i + delta, insn_buf, cnt);
+			new_prog = bpf_patch_insn_data(env, i + delta, insn_buf,
+						       cnt, -1);
 			if (!new_prog)
 				return -ENOMEM;
 
@@ -2246,7 +2275,8 @@ int bpf_do_misc_fixups(struct bpf_verifier_env *env)
 			/* Load IP address from ctx - 16 */
 			insn_buf[0] = BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_1, -16);
 
-			new_prog = bpf_patch_insn_data(env, i + delta, insn_buf, 1);
+			new_prog = bpf_patch_insn_data(env, i + delta, insn_buf,
+						       1, -1);
 			if (!new_prog)
 				return -ENOMEM;
 
@@ -2301,7 +2331,8 @@ int bpf_do_misc_fixups(struct bpf_verifier_env *env)
 			insn_buf[10] = BPF_MOV64_IMM(BPF_REG_0, -ENOENT);
 			cnt = 11;
 
-			new_prog = bpf_patch_insn_data(env, i + delta, insn_buf, cnt);
+			new_prog = bpf_patch_insn_data(env, i + delta, insn_buf,
+						       cnt, -1);
 			if (!new_prog)
 				return -ENOMEM;
 
@@ -2319,7 +2350,8 @@ int bpf_do_misc_fixups(struct bpf_verifier_env *env)
 			insn_buf[1] = BPF_ATOMIC_OP(BPF_DW, BPF_XCHG, BPF_REG_1, BPF_REG_0, 0);
 			cnt = 2;
 
-			new_prog = bpf_patch_insn_data(env, i + delta, insn_buf, cnt);
+			new_prog = bpf_patch_insn_data(env, i + delta, insn_buf,
+						       cnt, -1);
 			if (!new_prog)
 				return -ENOMEM;
 
@@ -2387,7 +2419,7 @@ int bpf_do_misc_fixups(struct bpf_verifier_env *env)
 		/* Copy first actual insn to preserve it */
 		insn_buf[cnt++] = env->prog->insnsi[subprog_start];
 
-		new_prog = bpf_patch_insn_data(env, subprog_start, insn_buf, cnt);
+		new_prog = bpf_patch_insn_data(env, subprog_start, insn_buf, cnt, cnt - 1);
 		if (!new_prog)
 			return -ENOMEM;
 		env->prog = prog = new_prog;
@@ -2486,7 +2518,7 @@ static struct bpf_prog *inline_bpf_loop(struct bpf_verifier_env *env,
 	insn_buf[cnt++] = BPF_LDX_MEM(BPF_DW, BPF_REG_8, BPF_REG_10, r8_offset);
 
 	*total_cnt = cnt;
-	new_prog = bpf_patch_insn_data(env, position, insn_buf, cnt);
+	new_prog = bpf_patch_insn_data(env, position, insn_buf, cnt, -1);
 	if (!new_prog)
 		return new_prog;
 

-- 
2.54.0

