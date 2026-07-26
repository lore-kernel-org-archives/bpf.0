Received: from mail-wm2-f10.google.com (mail-wm2-f10.google.com [74.125.225.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 249BD30AD1A
	for <bpf@vger.kernel.org>; Sun, 26 Jul 2026 01:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785029472; cv=none; b=sWqtgl2AKBm+0mxxAZ01ejsCE9Vr8L5KC1kGQMIc0cwfSv1GwO3gS6w+tFxwvPOevCWOUlOOuem3JoWWC/qv9zfHVB1cqswQSj9DiYVZmWkzOZAAkJjnAkZiqjQ3FCd3i3624aBqMKn9gCUBS3Uor8WJBhi4zT9lfC1syJvrwbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785029472; c=relaxed/simple;
	bh=11VUkwvXqAKjz733+4bvuv6e5xKmf+rbUdz4iFoxjLg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qYTVTWBOt1OnQ31VltmOpayuMtsNDaQVdAlFenkLOkodb+cVMaH63Pj0mo4Iub/NvIy32Cq4mfycx/+WuTBeNCJINi/UkMsFRYW2mtJyaygeXiB5KAKihwHpkzFsUGVs1WrG34XrTfccmJVZb5XUuHtZ+IMJNe3GSF4CLl6E0Bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sBPSXgQf; arc=none smtp.client-ip=74.125.225.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sBPSXgQf"
Received: by mail-wm2-f10.google.com with SMTP id 5b1f17b1804b1-495459712d2so4793475e9.1
        for <bpf@vger.kernel.org>; Sat, 25 Jul 2026 18:31:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785029469; x=1785634269; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Y5atURPdvpBzNIRvsmvptFHkheSFttivNMlp914DsUw=;
        b=sBPSXgQfKd9D05QPDyGDDXktgAlZew9+120JaA/gVf3eNjsUQ45DUgRkwKfOJsVm35
         g8JfDhl3VWwVOI6tLsAUh1taBgUILBOdfbhFx7AQqbbFUJ/JJknk5e0kR2GWKjn5B0EZ
         Ga+QIzlH9eJwGGOg1Ni1E2h0hRIUqLDa+HZKfou58MKaxYvgh9VLKWeDJr0GcR3GBPjZ
         9e07E4BCek/qlV1rH+4kqpIzA3b/kfdx5WhIHuZzPux0agOwqM5ZMKVCANawa0b0XIeS
         HsdMXS1RkVxV7M7v/8kyf2fwkfiAfZaFioqegmeClTIz1dbPNZrO5XnLYJhcn4o39Mk9
         YA9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785029469; x=1785634269;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Y5atURPdvpBzNIRvsmvptFHkheSFttivNMlp914DsUw=;
        b=YN1aTPS6VKVFrhu6OYbZaELkNX4lyAscQjZPcUhSp499QlxfGBtRMuT1wK9EePYmMw
         0hnJ4D4JfENHtbYI+PimbatBCOeIczdWr7UgUk0DuNv1MH9chqwGnfuZ2aoERqxqTVmg
         EL6CAP+x3A6imDRen9fVqK9xPx0JEVWsZ8exGW0JrAaaqeCMf3pWbP0Ccq8pA8LX2Dyg
         me082r9qb82gKvT3j9CMesL23d9LK3+nKOjoMPYxE0o12AokZc2HjOB0gGAF1gjyiIZi
         ZRiadcr5ClJ2L2tUzsHjrmMi8pWrhC6WhSmgLk88Le6XJr18GqR7oDYUafSJpB6HBaIE
         p1gQ==
X-Gm-Message-State: AOJu0YzuBWc7uljtHqqdA678uLgoRNneiGzeyFZsKwTeCZDX2tN5u33p
	1wKroCqPY1zq4xAHpidCr+md8CHDwEbXMSZR3W+GNuLw/spVP1ge2Xdj5xXIQsKQ
X-Gm-Gg: AR+sD13Ml+67Y4QEb9r/YURxxW65ggvpj5WBQ6EbH93ZFxZ0uRzNeuYhuaW7SCSApmw
	nug+LyWh8YXlFUVQ4lFHB2XUEDjeXbch2QM4foynJmD7cPu6G5etHPRZ8p+o/44dC4N4Flb2a6h
	egpkOgPyWRZQQ0sCmUfNaF9UJEjTjLvbxL/1Z11yewl1rXLID4SXsMB9KyIdAizkNgbKq+i+N5V
	Uqbg3cYE4Sy74vm/x4AZUCkh6f24xbzQWZN+L6oWl4mXBS5ctuLJS9wZl186/9aQKQZy+UjcRV0
	K8d/RoYYvT45dqdF6t0huQuq9Lv6q9fxaoKArwxfvTF1ECNysJyOFXpn0NtbhAv4A0tjnLzm+RS
	HZYGk/aV0PUWx+KyYOMt9OuGiX9884ezMc4cpmUpAq2k4+cfuDkFk7Ge77AJoqegIcXss6uqeC3
	MIQUh0/29vmVfJuKWxDVdeusRtIw3kR2rgvdaeDHaug0MmQyFBVTmS7/qVP1cvfzEuexVnxgDGn
	Lsn6na2u9G+HGR5r/FINYEGHkgvo/H4f9c4LSJ2v1C8
X-Received: by 2002:a05:600c:6986:b0:495:4dea:f7f5 with SMTP id 5b1f17b1804b1-496b5726cccmr52296795e9.29.1785029469280;
        Sat, 25 Jul 2026 18:31:09 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4957b5ed646sm139907875e9.0.2026.07.25.18.31.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Jul 2026 18:31:08 -0700 (PDT)
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
Subject: [PATCH bpf-next v2 3/9] bpf, x86: JIT __arena kfunc argument rebasing
Date: Sun, 26 Jul 2026 03:30:56 +0200
Message-ID: <20260726013105.3689867-4-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260726013105.3689867-1-memxor@gmail.com>
References: <20260726013105.3689867-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3220; i=memxor@gmail.com; h=from:subject; bh=m+vyfYTnnqfoysylxu9Pwvq1bz91Io/dHuCzPMlKZgY=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JISs12fLJImmpOcoXTq978COwcWkAx9PsfPUwN/HPz19GB zxNPWfdUcrCIMbFICumyFLyfx+T8YnK34G2y7hh5rAygQxh4OIUgIn4lTEyHLT6xLnly5JPnmef JH3dH3FUc8G7q894ve863Ni34t3XEHeGf6q/22a0KH4xsGF7p3bx+Cwrp3Ufn2a8qG/LVz2SzP0 tkhsA
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
index b2feec81e231..08013c2fcfaa 100644
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

