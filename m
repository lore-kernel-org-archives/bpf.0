Received: from mail-wm2-f9.google.com (mail-wm2-f9.google.com [74.125.225.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 826F637CD53
	for <bpf@vger.kernel.org>; Mon,  3 Aug 2026 12:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785761483; cv=none; b=a5u0DegTi9Dv2hZ8uQHT9iA3xRcqhrO6aD/DCCtYc2xuhMc6z8pZJF4soaWSkZPnYsu/zkP93U8psozmCzASJEwyn3qODG/HFHirUnBlUQYo1s/HebI53y+c1H8uENuP1Ax9BVeHzzMMGU6A9C4XmQFZ84B916PUznEAqXh3eqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785761483; c=relaxed/simple;
	bh=uQsI9UdYSXdpdkyK7jI+SVmE/XBxQpd/0qUMuztBIVE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rjSfqFsCj5n2zC2wIxmoMIU9eLh+RcDhjtCH+JwB+b5zP2fyxCJ/0WhbNsZgndnAdUDBwNuzzzfdONSVqnqextTF4545kUDC51lXVIVEqW4xKz6zqzK/NsfBuKTnt38vCaYyb48BepZ55FR70E3Aem8YWWr6zlvR1waQsz2Zt0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YO6BXvkp; arc=none smtp.client-ip=74.125.225.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YO6BXvkp"
Received: by mail-wm2-f9.google.com with SMTP id 5b1f17b1804b1-49553da76dcso7943725e9.1
        for <bpf@vger.kernel.org>; Mon, 03 Aug 2026 05:51:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785761480; x=1786366280; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HSs0UZVlfUo+dBGhomlhZ14vvWyn405aT3/6sKn0QxU=;
        b=YO6BXvkpz5B8fqbMmI9cTCars9OETrRxt1/nSp21zP3+vOUPkJfkYlf2WqYuLz5DuC
         DyOfgsaiBvbHJSSorxhesn4vcO5kavq2Jm3q5+DRZod5t1IVfo+GAHebgtPjSKG9hGyj
         efQYIW6d8auKngUnW24CW/NPuBB+RMHyme7P44ic/DjH69/PmJ9urqnOwRAOVHiNFXYb
         vPWVdC4rGdv43HhMCLhTAxN8UKFNH2rhavG8WDlkI6hTISdjc5qH4u7v2A/gkr3UgGzt
         4WnS8IEYXP+xmklkYIvh+OcfIuUi9JYk0PAnwW/Hc64w+3GfQfvSHyb4izNh70bF0RIl
         JoJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785761480; x=1786366280;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=HSs0UZVlfUo+dBGhomlhZ14vvWyn405aT3/6sKn0QxU=;
        b=XhXqgbYD08KBm07Go94Z3FZqqLXNVsf6gmosKg0rb46PH25ZA+xnDs4A+jXfNPdlK9
         kv/gQmAY1BtXkXUMeMEWJpMnF6ugx1LeISrYMjT5tqqdOkm2cEMduS6FXwY2iuYOu24m
         MwQmeZZ9B0Licy0HE1Picx2o9A7mi1nNxPeroF/kckg0pgBIg67SC33BVJChPUfxooyw
         hx4pTt4FDvzB4I4DaESVXfMu5/dklBfJRX/saEcfBW1D+9u5SYvEAZ2IQlR1xJQ0L/d/
         vVUw1qTYx3giLR2mHuYKBuY9Pl1cx9BGlgiuzSGLC0IDXD9oL2nLEbovPpSBuaPIqNnZ
         2G/g==
X-Gm-Message-State: AOJu0YxBD6e1fU9a5vcl2fL0GRy6mRRxTqR11JprxmNbUYDTWzJpHIP1
	hucfzGR4jqbsgfiliuW9hf1yp174RxpopTFBsDM3Xx2iXWs6AQyvca9lXKnmCzYW
X-Gm-Gg: AR+sD12tDdrAsXl04um0u2aQnL9aDIFo91ol1jRQrRUGXBf4nHuf590XafQrUdk0CXF
	2kAK2STSrXs1W/VqRBStTYUUyQEidCWqQQCx4gqMSghw1uwoqQdMLjfiyJtCT/WPMTkV5aSD7cA
	ATxhflwBxyo/5/RNIsFuXML5NFmqeZameW3Itrky9x5zzKQQq0Rq5yhhkR7AW6eGPKzRTDXF880
	W5B2GftF7rDfMEU7lTXOCeNEebVLQA6iPVwg/Rnkr0jeKBV+kW3LpYTJVd+WWTAS5CvhEUQ7rtT
	GJmieXXwG8+Q4vm1oFGVTTLS9LqRvnMGb1OmYSMQU+B0aD5LPLUBCrJS7nPMyWHFPq3WfeycBFf
	/3z1mN5QZ6YNkA6oxZjhTnbAPojmQFWHsDLuhp4gJ4Eu3sHyzYnmexMZNFLm9/UrEVjb+2wIhUi
	mHxY1j/E+LKfYkC8fQHIBVKzsKDBLp3mC7IpdmYkv2gas1fSL/fQEip8aOJV0LvKNRoBQOw9Jn+
	ilvPr0IS5/moANmOyh74UDdxncFvwP2QcuNWnY638I72I5L5/Qs2r6dva4nzo5wYGh2FSxYSuan
	f1wo6mLLXiFPudtPCUu0u64QgnsIrqZlAb7Xug==
X-Received: by 2002:a05:600c:1908:b0:495:7838:7e25 with SMTP id 5b1f17b1804b1-4980ee9f00fmr210767515e9.15.1785761479641;
        Mon, 03 Aug 2026 05:51:19 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fd45a0c8bsm31593495f8f.34.2026.08.03.05.51.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 05:51:19 -0700 (PDT)
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
Subject: [PATCH bpf-next v3 3/9] bpf, x86: JIT __arena kfunc argument rebasing
Date: Mon,  3 Aug 2026 14:51:04 +0200
Message-ID: <20260803125115.2264733-4-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260803125115.2264733-1-memxor@gmail.com>
References: <20260803125115.2264733-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3220; i=memxor@gmail.com; h=from:subject; bh=04nCEc2L4dNBPksq4FzCMuoXTPw0fjGBcfENGkfOCUw=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIaugb5NFU+nr+8uC59t9iteKyZkbUfS46f2EL1vPB0/a/ +W60k6FjlIWBjEuBlkxRZaS//uYjE9U/g60XcYNM4eVCWQIAxenAEwk5xfD/+Jpy/f8S9h86EyG bJbr0/O92tefJOdld9TN238np/aWMjvDf7876xbdT30vee7ei9X/CqJ3/Svzq3k6ZemnH608q2/ d3M0MAA==
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
 arch/x86/net/bpf_jit_comp.c | 50 +++++++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 01e7ce569c1e..817977797e59 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -1678,6 +1678,50 @@ static int emit_spectre_bhb_barrier(u8 **pprog, u8 *ip,
 	return 0;
 }
 
+/*
+ * Rebase the __arena args of a kfunc call to arena kernel addresses,
+ * rN = kern_vm_start + (u32)rN, with R12 holding kern_vm_start. A nullable
+ * arg preserves NULL by skipping the add, tested on the truncated value as
+ * arena NULL is offset 0. Return the number of emitted bytes.
+ */
+static int emit_kfunc_arena_args(struct bpf_prog *bpf_prog,
+				 const struct bpf_insn *insn, u8 **pprog)
+{
+	const struct btf_func_model *fm;
+	u8 *prog = *pprog;
+	u8 *start = prog;
+	int i;
+
+	fm = bpf_jit_find_kfunc_model(bpf_prog, insn);
+	if (!fm)
+		return -EINVAL;
+
+	for (i = 0; i < min_t(int, fm->nr_args, MAX_BPF_FUNC_REG_ARGS); i++) {
+		u8 flags = fm->arg_flags[i];
+		u32 reg = BPF_REG_1 + i;
+
+		if (!(flags & BTF_FMODEL_ARENA_ARG))
+			continue;
+		if (WARN_ON_ONCE(!bpf_prog->aux->arena))
+			return -EINVAL;
+
+		/* mov eN, eN: truncate and clear the upper 32 bits */
+		emit_mov_reg(&prog, false, reg, reg);
+		if (flags & BTF_FMODEL_NULLABLE_ARG) {
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
@@ -2583,6 +2627,12 @@ st:			insn_off = insn->off;
 			}
 			if (!imm32)
 				return -EINVAL;
+			if (src_reg == BPF_PSEUDO_KFUNC_CALL) {
+				err = emit_kfunc_arena_args(bpf_prog, insn, &prog);
+				if (err < 0)
+					return err;
+				ip += err;
+			}
 			if (priv_frame_ptr) {
 				push_r9(&prog);
 				ip += 2;
-- 
2.53.0

