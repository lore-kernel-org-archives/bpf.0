Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com [209.85.128.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 822E33C141A
	for <bpf@vger.kernel.org>; Wed, 15 Jul 2026 22:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784152860; cv=none; b=Z5OTGxLMAN2FU+BMb2IDwNK+kEQr0MlUwP8lGaStsEAsq4bZr56wTFx/WHS0dyHDGdsGG9E0nDmcHlMwAlV+11a4qx+EpbmDi9YMlhQPPj3lmO3xGuostOe/L8ZHAVvhcnjpiOpNnmFZ5Z704dLJnUAh99xdEZ8JXAUxqfEUQL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784152860; c=relaxed/simple;
	bh=OUju9jYCMXiWFl1B8rRSy/N8vi8cNjArsuOqpd27BmM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QI9sX9YzSVSPejWdWQHVgiNlHVswkexKT9rQJjq16NxQtOXv31z7oy8LQS5BswQhQ82RELJDL/zDqNoswxD52pxId4qYM4NGuuszrv71pFQhLqLkxpRVkJXaL7ovOFtL/o+ahThqFNKYBJlURFJ6Q7U+Q4url1C73iLfu+VEr9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BPztf9lt; arc=none smtp.client-ip=209.85.128.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BPztf9lt"
Received: by mail-wm1-f67.google.com with SMTP id 5b1f17b1804b1-493f45e206dso7960435e9.1
        for <bpf@vger.kernel.org>; Wed, 15 Jul 2026 15:00:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784152857; x=1784757657; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/K10zbZZWD3bSjkQiJ6b6Q9D2C03Fvjk09tgt/dlG9w=;
        b=BPztf9ltOcvJV+xC9nMSMgfLJ0DVx7Q+mmVF9OXrlIp8D54Wfbr4YmihTrpOqDxIgI
         y7QthuUk3EgOpPbzNXqWy9sRswFu8ZpXlzt/SXlpoXz+xHZFEGBSj2bdpmWxU04NwY37
         t86cwVA7v4a2gZv+Y2YhMkAlnGYdSlZPn/gOPxrNgapm+ucoUIfEXau+jD+dywX4IbtF
         vVMxOwg9+KokrXn0XSLD+4+5T6FHDle78lCOJlbbhvLtarROq0yzuRalYuefK9QVyngL
         rHVc+n13ZuCzokkR5pBgEXcUWn5eKoByLu2FhWKuMNFJ5DLKE+VS1ofSIExy1qrde/Da
         61dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784152857; x=1784757657;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=/K10zbZZWD3bSjkQiJ6b6Q9D2C03Fvjk09tgt/dlG9w=;
        b=Y/q0KCaF98i7jQCfKw0i3ShzF2vZEHJr4R4BofwVqZo/ob6Ro7Y1CD3xLEJI8g3spM
         c8BVylFXdEgM77xKOjVs5m9yDKFihdnvbxC6M6hT3O/8K5kgru7IJdNtxxBpZFtQ3e4A
         /7yRrhLpRUjGeu7dGO5o7dPfs0RqMw6hdyCmP4DkxAJYgU1thbRJi2np+345laa5TbaB
         sl5iA5cdLinD4gIiIJ0pkxyKiiWmQ4fY9sVoF8opJCREYa38elLYZ/OqCphJ3zm/i924
         Ef3bxw9sAdvnCcqpwjaWjyk2Xpsic5smARETEP9qtHZVGIEeJ/nXSVGVLYS4OpcW7x0A
         /r5g==
X-Gm-Message-State: AOJu0Yxu2PssN/bHiwKJieAF8au91JSrsdFwKpr73mvXfzvjYef98St2
	w9LKcH+G6WjamwNL5hFPukfoz+zb3BSKtoJsy75WuBombndUkhn876yIKprxhIgy
X-Gm-Gg: AfdE7cmjEAQLvAVkMfWWafufa1tPRnhK6DU1IGB/432hWENSp2m/wMFcStUGU+UHHjD
	rIsYsCQBEa9HY8gpQFuV3rlfG1rx9L/yJTKntfMZDM3SLOLM8qRLyHyAs07Q4An2nfjpcQccbRm
	q0SDcv8XDyy60FvdRWqvSdw/8QQ4PPDC6ci9kw6CVPJM8FCY6l3+gZvYViBs77l8FuGbn4uAMzd
	YKvv86WXJ7uH3nt6OU07p/5iPmcdlKwbEYNoJFhD5AFAkFnD5xfbJ1YDgnrUqKGJ44uvhm/coMA
	O492/rmwWJgU6swxaa8U/Ra7K9zfH+DPaAUFWsf1MC7K6UdIpJNonvOuufDqls8GUOkYITGFEuL
	ws8tTGwR+RiTot3UTxzd6ur6yM9A7XaBsMGs3r7QrwVMe/uoqHFfTMl5o2tlJzSnx44w5hKkMzu
	6gIa90C1D077IZpXuVHcRILWfIl2T3M16t2CJScALrYEv2lQyR6I3N2hyyjWRzT7ROv2j4NIvjx
	rXHBssqjCWgM6ZRICSimpGldh+k3p/Ueoipxr2WzCNr
X-Received: by 2002:a05:600c:5489:b0:493:bd04:2cfb with SMTP id 5b1f17b1804b1-49540f03b6dmr10635245e9.13.1784152856693;
        Wed, 15 Jul 2026 15:00:56 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f4635ac2esm19913355f8f.13.2026.07.15.15.00.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 15:00:56 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 3/9] bpf, x86: JIT __arena kfunc argument rebasing
Date: Thu, 16 Jul 2026 00:00:43 +0200
Message-ID: <20260715220052.1590783-4-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260715220052.1590783-1-memxor@gmail.com>
References: <20260715220052.1590783-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3239; i=memxor@gmail.com; h=from:subject; bh=9NjR5f8GXq0xVmpiUyam1ljQAHuTr18xnn6QKiHf4DE=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JISuC6XZN7W0dn8jT+3ZqvLBzK5YKvxgfIGkS1fzJaIuP2 MH7kjkdpSwMYlwMsmKKLCX/9zEZn6j8HWi7jBtmDisTyBAGLk4BmIiKAcP/AI387eo8k9/mTxFi DXmQ8fBEU0TmLwfD7P5ejctJ33ZPZ2TYZOYwYcvR/8/DtSw7Js/d8KD0Ha/vkVUGr+8/7Hgq9Y6 fBQA=
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

From: Tejun Heo <tj@kernel.org>

Implement arena argument rebasing for kfunc calls on x86. R12 already
holds kern_vm_start whenever the prog has an arena, so each tagged
argument costs two instructions emitted right before the call:

  movl %eN, %eN         /* truncate, clear the upper 32 bits */
  addq %r12, %rN

A nullable argument tests the truncated value and jumps over the add:

  movl  %eN, %eN
  testl %eN, %eN
  jz    1f
  addq  %r12, %rN
1:

addq carries a REX prefix for every argument register and is always
three bytes, so the jz displacement is constant. The sequence is native
code generated after constant blinding has run on the BPF instruction
stream, so blinding never sees the rebase and needs no special handling.

bpf_jit_supports_arena_args() is not flipped yet; that happens when the
struct_ops trampoline side is in place as well.

Signed-off-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 arch/x86/net/bpf_jit_comp.c | 49 +++++++++++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index de7515ea1bea..dd9009fcdc39 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -1678,6 +1678,49 @@ static int emit_spectre_bhb_barrier(u8 **pprog, u8 *ip,
 	return 0;
 }
 
+/*
+ * Rebase the __arena args of a kfunc call to arena kernel addresses,
+ * rN = kern_vm_start + (u32)rN, with R12 holding kern_vm_start. A nullable
+ * arg preserves NULL by skipping the add, tested on the truncated value as
+ * arena NULL is offset 0. Return the number of emitted bytes.
+ */
+static int emit_kfunc_arena_args(struct bpf_verifier_env *env, struct bpf_prog *bpf_prog,
+				 int insn_idx, u8 **pprog)
+{
+	struct bpf_jit_arena_args args;
+	unsigned long regs;
+	u8 *prog = *pprog;
+	u8 *start = prog;
+	int bit;
+
+	args = bpf_kfunc_arena_args(env, bpf_prog, insn_idx);
+	if (!args.regs)
+		return 0;
+	if (WARN_ON_ONCE(args.nullable_regs & ~args.regs) ||
+	    WARN_ON_ONCE(!bpf_prog->aux->arena))
+		return -EINVAL;
+
+	regs = args.regs;
+	for_each_set_bit(bit, &regs, MAX_BPF_FUNC_REG_ARGS) {
+		u32 reg = BPF_REG_1 + bit;
+
+		/* mov eN, eN: truncate and clear the upper 32 bits */
+		emit_mov_reg(&prog, false, reg, reg);
+		if (args.nullable_regs & BIT(bit)) {
+			/* test eN, eN; jz over the 3-byte add */
+			maybe_emit_mod(&prog, reg, reg, false);
+			EMIT2(0x85, add_2reg(0xC0, reg, reg));
+			EMIT2(X86_JE, 3);
+		}
+		/* add rN, r12 */
+		maybe_emit_mod(&prog, reg, X86_REG_R12, true);
+		EMIT2(0x01, add_2reg(0xC0, reg, X86_REG_R12));
+	}
+
+	*pprog = prog;
+	return prog - start;
+}
+
 static int do_jit(struct bpf_verifier_env *env, struct bpf_prog *bpf_prog, int *addrs, u8 *image,
 		  u8 *rw_image, int oldproglen, struct jit_context *ctx, bool jmp_padding)
 {
@@ -2583,6 +2626,12 @@ st:			insn_off = insn->off;
 			}
 			if (!imm32)
 				return -EINVAL;
+			if (src_reg == BPF_PSEUDO_KFUNC_CALL) {
+				err = emit_kfunc_arena_args(env, bpf_prog, i - 1, &prog);
+				if (err < 0)
+					return err;
+				ip += err;
+			}
 			if (priv_frame_ptr) {
 				push_r9(&prog);
 				ip += 2;
-- 
2.53.0

