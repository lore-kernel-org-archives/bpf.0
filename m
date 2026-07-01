Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6F153FE652;
	Wed,  1 Jul 2026 10:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782900220; cv=none; b=cPxhxPvcGZm0doBSHfuBn3vTj1DUeGjnijbzPEju+4RJJfdxGfsmkSREF9yg1tVPmTHLdQ0bGSSuCRhLmForyv3ZmpCwwIpCbJ3LtV616EqpTukhAxgur1+IqR5NumM6QT5mfzc31bpJjwd9hXLvGe+Nv21g2OMD6EsLVjfnxfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782900220; c=relaxed/simple;
	bh=Cw1NIzXsR5cpqQgXuOWbygEYPzevBmu1+G98Uzn6twg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YAXwCM03iJZZQwrg3nxz7bYuxRfF6YqOfGkZvChyx632At9d4yczNIA7+PbMu6k6RUYuAdBnO37rJFeXVI6mnKQtG70zYuhmfDvj8UBgnfE55gvHmy8AHOYLt6lAxyzbOSANGCJnvq3aL9Nr2M35i0ogDH+RN0JWa/PgUpvqXvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=yk5c2aQR; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="yk5c2aQR"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 2C62F1A0DAE;
	Wed,  1 Jul 2026 10:03:31 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id EA904602B0;
	Wed,  1 Jul 2026 10:03:30 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 1CDC2104C9A80;
	Wed,  1 Jul 2026 12:03:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1782900208; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=B2Kjg+eBmD4qQRg0rKj3VkKgoWS74KMexFcamMsRZI4=;
	b=yk5c2aQROP6b5cs0c53UpbYKA+TPt9NJ9OhsHIB5DBLWtFqOgzC5wy5w6fviDra/AKuq0g
	QJjqbKHq2AdORFHmyzLRpEP/cihkFbEJzXXuGP7rOKtCpjvmYFhaZtiTtwxACA8/LBtvs7
	0au4fbfIEDVxNlTcWXsOfJ5HfOcKktisitzW4h/psUdZCOYGuFTt/GYqehGDmShx3fN4fn
	shv5yDgHweojsZVS+L2t/SIWEX0GmWPi9XXRWAj9gzoM/zNJ3SHdA8Lup/mqSUipnfzLFj
	quCq1kk2sK4XTWTnY7KpH2AkBqhwAStwgQfCiLTX97mUpGrQaTUv6PsERPM9zw==
From: =?utf-8?q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
Date: Wed, 01 Jul 2026 12:02:49 +0200
Subject: [PATCH bpf-next v3 01/10] bpf: propagate original instruction
 offset when patching program
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260701-kasan-v3-1-bd09bb942d86@bootlin.com>
References: <20260701-kasan-v3-0-bd09bb942d86@bootlin.com>
In-Reply-To: <20260701-kasan-v3-0-bd09bb942d86@bootlin.com>
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
load/store instruction that access non-stack memory, but updating this
new marking after a patch is not as straightforward as for indirect
calls: the original BPF_ST/BPF_STX/BPF_LDX can be at the beginning, at
the end or somewhere in the middle of the new patch: we then need some
additional info to properly update this marking.

Add a new parameter to bpf_patch_insn_data and adjust_insn_aux_data to
convey the info about the new location in the patch of the original
instruction. This info does not always make sense depending on the
generated patch (eg, some bpf helpers being inlined by the verifier, and
so turned into multiple new instructions without any BPF_CALL remaning),
the parameter can then be set to -1. It will be used in next patches to
properly handle insn_aux_data adjustment for the new KASAN
instrumentation

Signed-off-by: Alexis Lothoré (eBPF Foundation) <alexis.lothore@bootlin.com>
---
Changes in v3:
- new patch
---
 include/linux/filter.h |  10 +++--
 kernel/bpf/core.c      |   2 +-
 kernel/bpf/fixups.c    | 105 +++++++++++++++++++++++++++++++++----------------
 3 files changed, 79 insertions(+), 38 deletions(-)

diff --git a/include/linux/filter.h b/include/linux/filter.h
index 67d337ede91b..912b91c65e0c 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -1209,13 +1209,17 @@ struct bpf_prog *bpf_patch_insn_single(struct bpf_prog *prog, u32 off,
 
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
index 649cce41e13f..20dd3dd17225 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -1542,7 +1542,7 @@ struct bpf_prog *bpf_jit_blind_constants(struct bpf_verifier_env *env, struct bp
 			continue;
 
 		if (env)
-			tmp = bpf_patch_insn_data(env, i, insn_buff, rewritten);
+			tmp = bpf_patch_insn_data(env, i, insn_buff, rewritten, rewritten - 1);
 		else
 			tmp = bpf_patch_insn_single(clone, i, insn_buff, rewritten);
 
diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
index 3cf2cc6e3ab6..1f340211b65c 100644
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
@@ -695,6 +697,7 @@ int bpf_convert_ctx_accesses(struct bpf_verifier_env *env)
 	struct bpf_insn *insn_buf = env->insn_buf;
 	struct bpf_insn *insn;
 	u32 target_size, size_default, off;
+	s32 insn_off_in_patch = -1;
 	struct bpf_prog *new_prog;
 	enum bpf_access_type type;
 	bool is_narrower_load;
@@ -713,7 +716,7 @@ int bpf_convert_ctx_accesses(struct bpf_verifier_env *env)
 			insn_buf[cnt++] = BPF_STX_MEM(BPF_DW, BPF_REG_FP, BPF_REG_1,
 						      -subprogs[0].stack_depth);
 			insn_buf[cnt++] = env->prog->insnsi[0];
-			new_prog = bpf_patch_insn_data(env, 0, insn_buf, cnt);
+			new_prog = bpf_patch_insn_data(env, 0, insn_buf, cnt, 1);
 			if (!new_prog)
 				return -ENOMEM;
 			env->prog = new_prog;
@@ -736,7 +739,8 @@ int bpf_convert_ctx_accesses(struct bpf_verifier_env *env)
 			verifier_bug(env, "prologue is too long");
 			return -EFAULT;
 		} else if (cnt) {
-			new_prog = bpf_patch_insn_data(env, 0, insn_buf, cnt);
+			new_prog = bpf_patch_insn_data(env, 0, insn_buf, cnt,
+						       cnt - 1);
 			if (!new_prog)
 				return -ENOMEM;
 
@@ -768,7 +772,8 @@ int bpf_convert_ctx_accesses(struct bpf_verifier_env *env)
 			*patch++ = BPF_ST_NOSPEC();
 			*patch++ = *insn;
 			cnt = patch - insn_buf;
-			new_prog = bpf_patch_insn_data(env, i + delta, insn_buf, cnt);
+			new_prog = bpf_patch_insn_data(env, i + delta, insn_buf,
+						       cnt, cnt - 1);
 			if (!new_prog)
 				return -ENOMEM;
 
@@ -841,7 +846,8 @@ int bpf_convert_ctx_accesses(struct bpf_verifier_env *env)
 			*patch++ = *insn;
 			*patch++ = BPF_ST_NOSPEC();
 			cnt = patch - insn_buf;
-			new_prog = bpf_patch_insn_data(env, i + delta, insn_buf, cnt);
+			new_prog = bpf_patch_insn_data(env, i + delta, insn_buf,
+						       cnt, 0);
 			if (!new_prog)
 				return -ENOMEM;
 
@@ -856,16 +862,20 @@ int bpf_convert_ctx_accesses(struct bpf_verifier_env *env)
 			if (!ops->convert_ctx_access)
 				continue;
 			convert_ctx_access = ops->convert_ctx_access;
+			insn_off_in_patch = 0;
 			break;
 		case PTR_TO_SOCKET:
 		case PTR_TO_SOCK_COMMON:
 			convert_ctx_access = bpf_sock_convert_ctx_access;
+			insn_off_in_patch = 0;
 			break;
 		case PTR_TO_TCP_SOCK:
 			convert_ctx_access = bpf_tcp_sock_convert_ctx_access;
+			insn_off_in_patch = 0;
 			break;
 		case PTR_TO_XDP_SOCK:
 			convert_ctx_access = bpf_xdp_sock_convert_ctx_access;
+			insn_off_in_patch = 0;
 			break;
 		case PTR_TO_BTF_ID:
 		case PTR_TO_BTF_ID | PTR_UNTRUSTED:
@@ -971,7 +981,8 @@ int bpf_convert_ctx_accesses(struct bpf_verifier_env *env)
 						       size * 8, 0);
 
 patch_insn_buf:
-		new_prog = bpf_patch_insn_data(env, i + delta, insn_buf, cnt);
+		new_prog = bpf_patch_insn_data(env, i + delta, insn_buf, cnt,
+					       insn_off_in_patch);
 		if (!new_prog)
 			return -ENOMEM;
 
@@ -1464,7 +1475,7 @@ static int add_hidden_subprog(struct bpf_verifier_env *env, struct bpf_insn *pat
 	 * ones for the hidden subprog. Hence all of the adjustment operations
 	 * in bpf_patch_insn_data are no-ops.
 	 */
-	prog = bpf_patch_insn_data(env, env->prog->len - 1, patch, len);
+	prog = bpf_patch_insn_data(env, env->prog->len - 1, patch, len, -1);
 	if (!prog)
 		return -ENOMEM;
 	env->prog = prog;
@@ -1549,7 +1560,8 @@ int bpf_do_misc_fixups(struct bpf_verifier_env *env)
 
 			cnt = patch - insn_buf;
 
-			new_prog = bpf_patch_insn_data(env, i + delta, insn_buf, cnt);
+			new_prog = bpf_patch_insn_data(env, i + delta, insn_buf,
+						       cnt, 0);
 			if (!new_prog)
 				return -ENOMEM;
 
@@ -1569,6 +1581,7 @@ int bpf_do_misc_fixups(struct bpf_verifier_env *env)
 			bool is_sdiv = isdiv && insn->off == 1;
 			bool is_smod = !isdiv && insn->off == 1;
 			struct bpf_insn *patch = insn_buf;
+			s32 insn_off_in_patch;
 
 			if (is_sdiv) {
 				/* [R,W]x sdiv 0 -> 0
@@ -1595,6 +1608,7 @@ int bpf_do_misc_fixups(struct bpf_verifier_env *env)
 				*patch++ = BPF_JMP_IMM(BPF_JA, 0, 0, 1);
 				*patch++ = *insn;
 				cnt = patch - insn_buf;
+				insn_off_in_patch = cnt - 1;
 			} else if (is_smod) {
 				/* [R,W]x mod 0 -> [R,W]x */
 				/* [R,W]x mod -1 -> 0 */
@@ -1611,6 +1625,7 @@ int bpf_do_misc_fixups(struct bpf_verifier_env *env)
 				*patch++ = BPF_MOV32_IMM(insn->dst_reg, 0);
 				*patch++ = BPF_JMP_IMM(BPF_JA, 0, 0, 1);
 				*patch++ = *insn;
+				insn_off_in_patch = patch - insn_buf - 1;
 
 				if (!is64) {
 					*patch++ = BPF_JMP_IMM(BPF_JA, 0, 0, 1);
@@ -1626,12 +1641,14 @@ int bpf_do_misc_fixups(struct bpf_verifier_env *env)
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
@@ -1640,7 +1657,8 @@ int bpf_do_misc_fixups(struct bpf_verifier_env *env)
 				cnt = patch - insn_buf;
 			}
 
-			new_prog = bpf_patch_insn_data(env, i + delta, insn_buf, cnt);
+			new_prog = bpf_patch_insn_data(env, i + delta, insn_buf,
+						       cnt, insn_off_in_patch);
 			if (!new_prog)
 				return -ENOMEM;
 
@@ -1656,6 +1674,7 @@ int bpf_do_misc_fixups(struct bpf_verifier_env *env)
 		     BPF_MODE(insn->code) == BPF_PROBE_MEMSX)) {
 			struct bpf_insn *patch = insn_buf;
 			u64 uaddress_limit = bpf_arch_uaddress_limit();
+			s32 insn_off_in_patch;
 
 			if (!uaddress_limit)
 				goto next_insn;
@@ -1666,11 +1685,13 @@ int bpf_do_misc_fixups(struct bpf_verifier_env *env)
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
 
@@ -1690,7 +1711,8 @@ int bpf_do_misc_fixups(struct bpf_verifier_env *env)
 				return -EFAULT;
 			}
 
-			new_prog = bpf_patch_insn_data(env, i + delta, insn_buf, cnt);
+			new_prog = bpf_patch_insn_data(env, i + delta, insn_buf,
+						       cnt, 0);
 			if (!new_prog)
 				return -ENOMEM;
 
@@ -1743,7 +1765,8 @@ int bpf_do_misc_fixups(struct bpf_verifier_env *env)
 				*patch++ = BPF_ALU64_IMM(BPF_MUL, off_reg, -1);
 			cnt = patch - insn_buf;
 
-			new_prog = bpf_patch_insn_data(env, i + delta, insn_buf, cnt);
+			new_prog = bpf_patch_insn_data(env, i + delta, insn_buf,
+						       cnt, -1);
 			if (!new_prog)
 				return -ENOMEM;
 
@@ -1788,7 +1811,8 @@ int bpf_do_misc_fixups(struct bpf_verifier_env *env)
 			insn_buf[6] = BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_AX, stack_off_cnt);
 			cnt = 7;
 
-			new_prog = bpf_patch_insn_data(env, i + delta, insn_buf, cnt);
+			new_prog = bpf_patch_insn_data(env, i + delta, insn_buf,
+						       cnt, 3);
 			if (!new_prog)
 				return -ENOMEM;
 
@@ -1809,7 +1833,8 @@ int bpf_do_misc_fixups(struct bpf_verifier_env *env)
 			insn_buf[3] = BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_AX, stack_off);
 			cnt = 4;
 
-			new_prog = bpf_patch_insn_data(env, i + delta, insn_buf, cnt);
+			new_prog = bpf_patch_insn_data(env, i + delta, insn_buf,
+						       cnt, 2);
 			if (!new_prog)
 				return -ENOMEM;
 
@@ -1830,7 +1855,8 @@ int bpf_do_misc_fixups(struct bpf_verifier_env *env)
 			if (cnt == 0)
 				goto next_insn;
 
-			new_prog = bpf_patch_insn_data(env, i + delta, insn_buf, cnt);
+			new_prog = bpf_patch_insn_data(env, i + delta, insn_buf,
+						       cnt, cnt - 1);
 			if (!new_prog)
 				return -ENOMEM;
 
@@ -1915,7 +1941,8 @@ int bpf_do_misc_fixups(struct bpf_verifier_env *env)
 								 map)->index_mask);
 			insn_buf[2] = *insn;
 			cnt = 3;
-			new_prog = bpf_patch_insn_data(env, i + delta, insn_buf, cnt);
+			new_prog = bpf_patch_insn_data(env, i + delta, insn_buf,
+						       cnt, cnt - 1);
 			if (!new_prog)
 				return -ENOMEM;
 
@@ -1948,7 +1975,8 @@ int bpf_do_misc_fixups(struct bpf_verifier_env *env)
 			insn_buf[2] = *insn;
 			cnt = 3;
 
-			new_prog = bpf_patch_insn_data(env, i + delta, insn_buf, cnt);
+			new_prog = bpf_patch_insn_data(env, i + delta, insn_buf,
+						       cnt, cnt - 1);
 			if (!new_prog)
 				return -ENOMEM;
 
@@ -1967,7 +1995,8 @@ int bpf_do_misc_fixups(struct bpf_verifier_env *env)
 			insn_buf[1] = *insn;
 			cnt = 2;
 
-			new_prog = bpf_patch_insn_data(env, i + delta, insn_buf, cnt);
+			new_prog = bpf_patch_insn_data(env, i + delta, insn_buf,
+						       cnt, cnt - 1);
 			if (!new_prog)
 				return -ENOMEM;
 
@@ -2007,8 +2036,8 @@ int bpf_do_misc_fixups(struct bpf_verifier_env *env)
 					return -EFAULT;
 				}
 
-				new_prog = bpf_patch_insn_data(env, i + delta,
-							       insn_buf, cnt);
+				new_prog = bpf_patch_insn_data(
+					env, i + delta, insn_buf, cnt, -1);
 				if (!new_prog)
 					return -ENOMEM;
 
@@ -2091,7 +2120,7 @@ int bpf_do_misc_fixups(struct bpf_verifier_env *env)
 			cnt = 3;
 
 			new_prog = bpf_patch_insn_data(env, i + delta, insn_buf,
-						       cnt);
+						       cnt, -1);
 			if (!new_prog)
 				return -ENOMEM;
 
@@ -2119,7 +2148,8 @@ int bpf_do_misc_fixups(struct bpf_verifier_env *env)
 			insn_buf[0] = BPF_ALU32_REG(BPF_XOR, BPF_REG_0, BPF_REG_0);
 			cnt = 1;
 #endif
-			new_prog = bpf_patch_insn_data(env, i + delta, insn_buf, cnt);
+			new_prog = bpf_patch_insn_data(env, i + delta, insn_buf,
+						       cnt, -1);
 			if (!new_prog)
 				return -ENOMEM;
 
@@ -2137,7 +2167,8 @@ int bpf_do_misc_fixups(struct bpf_verifier_env *env)
 			insn_buf[2] = BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_0, 0);
 			cnt = 3;
 
-			new_prog = bpf_patch_insn_data(env, i + delta, insn_buf, cnt);
+			new_prog = bpf_patch_insn_data(env, i + delta, insn_buf,
+						       cnt, -1);
 			if (!new_prog)
 				return -ENOMEM;
 
@@ -2171,7 +2202,8 @@ int bpf_do_misc_fixups(struct bpf_verifier_env *env)
 			insn_buf[cnt++] = BPF_JMP_A(1);
 			insn_buf[cnt++] = BPF_MOV64_IMM(BPF_REG_0, -EINVAL);
 
-			new_prog = bpf_patch_insn_data(env, i + delta, insn_buf, cnt);
+			new_prog = bpf_patch_insn_data(env, i + delta, insn_buf,
+						       cnt, -1);
 			if (!new_prog)
 				return -ENOMEM;
 
@@ -2203,7 +2235,8 @@ int bpf_do_misc_fixups(struct bpf_verifier_env *env)
 				cnt = 1;
 			}
 
-			new_prog = bpf_patch_insn_data(env, i + delta, insn_buf, cnt);
+			new_prog = bpf_patch_insn_data(env, i + delta, insn_buf,
+						       cnt, -1);
 			if (!new_prog)
 				return -ENOMEM;
 
@@ -2229,7 +2262,8 @@ int bpf_do_misc_fixups(struct bpf_verifier_env *env)
 				cnt = 2;
 			}
 
-			new_prog = bpf_patch_insn_data(env, i + delta, insn_buf, cnt);
+			new_prog = bpf_patch_insn_data(env, i + delta, insn_buf,
+						       cnt, -1);
 			if (!new_prog)
 				return -ENOMEM;
 
@@ -2245,7 +2279,8 @@ int bpf_do_misc_fixups(struct bpf_verifier_env *env)
 			/* Load IP address from ctx - 16 */
 			insn_buf[0] = BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_1, -16);
 
-			new_prog = bpf_patch_insn_data(env, i + delta, insn_buf, 1);
+			new_prog = bpf_patch_insn_data(env, i + delta, insn_buf,
+						       1, -1);
 			if (!new_prog)
 				return -ENOMEM;
 
@@ -2300,7 +2335,8 @@ int bpf_do_misc_fixups(struct bpf_verifier_env *env)
 			insn_buf[10] = BPF_MOV64_IMM(BPF_REG_0, -ENOENT);
 			cnt = 11;
 
-			new_prog = bpf_patch_insn_data(env, i + delta, insn_buf, cnt);
+			new_prog = bpf_patch_insn_data(env, i + delta, insn_buf,
+						       cnt, -1);
 			if (!new_prog)
 				return -ENOMEM;
 
@@ -2318,7 +2354,8 @@ int bpf_do_misc_fixups(struct bpf_verifier_env *env)
 			insn_buf[1] = BPF_ATOMIC_OP(BPF_DW, BPF_XCHG, BPF_REG_1, BPF_REG_0, 0);
 			cnt = 2;
 
-			new_prog = bpf_patch_insn_data(env, i + delta, insn_buf, cnt);
+			new_prog = bpf_patch_insn_data(env, i + delta, insn_buf,
+						       cnt, -1);
 			if (!new_prog)
 				return -ENOMEM;
 
@@ -2386,7 +2423,7 @@ int bpf_do_misc_fixups(struct bpf_verifier_env *env)
 		/* Copy first actual insn to preserve it */
 		insn_buf[cnt++] = env->prog->insnsi[subprog_start];
 
-		new_prog = bpf_patch_insn_data(env, subprog_start, insn_buf, cnt);
+		new_prog = bpf_patch_insn_data(env, subprog_start, insn_buf, cnt, cnt - 1);
 		if (!new_prog)
 			return -ENOMEM;
 		env->prog = prog = new_prog;
@@ -2485,7 +2522,7 @@ static struct bpf_prog *inline_bpf_loop(struct bpf_verifier_env *env,
 	insn_buf[cnt++] = BPF_LDX_MEM(BPF_DW, BPF_REG_8, BPF_REG_10, r8_offset);
 
 	*total_cnt = cnt;
-	new_prog = bpf_patch_insn_data(env, position, insn_buf, cnt);
+	new_prog = bpf_patch_insn_data(env, position, insn_buf, cnt, -1);
 	if (!new_prog)
 		return new_prog;
 

-- 
2.54.0

