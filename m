Received: from mail-ej2-f2.google.com (mail-ej2-f2.google.com [74.125.228.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A689E415B6B
	for <bpf@vger.kernel.org>; Fri, 21 Aug 2026 23:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787355324; cv=none; b=RUC4RjYNJ6Fe9B8/zjIo4eAyNmN7iUgAe69Djxl7zIOjTc1+Hq7eHw9i1T41oar95uzL3GgPUTXE6VH0eyTOs823FKefdUu1CbVTLk/burzLxwkgZEmCrUOuvx2UWrbp/Zq+rkCfbEGKC4idSz3LDJtMdxzRWKTD9Vaaz7QOGAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787355324; c=relaxed/simple;
	bh=p7Y4bEq0/hTyqNNb2Vk5KhzjwOByoEvgSRKCv1KKkOo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QErrQgn/Sp4LD6VLfKdnHcDlyK0rIFlM4AoQxCHaFc2VEM1+wOMDf1AeXmkcQnuQwuYuBRVxjqFpg15CXS9ATVGdlbqDsVbWp1HzP0vJi41bIbXsPbyG5M+/pspWWOE61XEWc63qU6vhcFf0xd/jC+byKD+DGxA1bl5dzw3gOq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nV0JcuUw; arc=none smtp.client-ip=74.125.228.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nV0JcuUw"
Received: by mail-ej2-f2.google.com with SMTP id a640c23a62f3a-c1c5cb0f9f1so67237766b.0
        for <bpf@vger.kernel.org>; Fri, 21 Aug 2026 16:35:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787355320; x=1787960120; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=QeXuIb62A7Y3Vu3YQ/zY8iFbFnHZEy+FLPBwoRMM2e8=;
        b=nV0JcuUwXNuboXRQODLGfbZtU2ZLOmLB3Os6F4xHEsOXIBkrOyIyr9e+3jxp3PYYt/
         NmZHduafoKxsya4t6877zaon7j3F5K44L724CJZjJFB4nLH5QqUW6Hd8WeU7mlSggmId
         virh7vCDp1HTt5zAWBjaZ46xLFgEQ9RPrGJdCn3zz4YRn49TStOKBcv13dkriyj1x0SH
         N4BmhtWAWd03fLxb322APcodKmIn1AWqo3rqOZu/cxHpAKvcJvK5GtS6fTboHfIqWENC
         nNfYxPzV/9DttRL1iM1Dqdn0j5MCqByipcyEXQOh/lZUq6MBojBrKJQI5kKC33QGKvXK
         Nvpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787355320; x=1787960120;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QeXuIb62A7Y3Vu3YQ/zY8iFbFnHZEy+FLPBwoRMM2e8=;
        b=cfrHwdFQwyIP1hWSxf2drFb5yBPJyCfpY5cqDDMGda00Lxqa6rVrKQ92dqvIjME9QY
         4N1R5BykEU5VVbiGLw1NmtMQam+nKv5yGqJENINZMfw4medn1lMXcVe8gDO4Qwvf55T5
         11gC24npvwTfuyM48h5+8byL+5yLdZB3I5+afyG1p4Py1fAtnIeaKqGD3IVJCK38aCRV
         dQ1O6Mz265y7WiiCcY7uWEufvrw9BpbuF02vuddiyyz/cPSbG83IAB+FIhxd/HWr8juU
         tJonzO5V5yzENhNKH3tU/YRKjYPpuTR3h5q77EfurkRHX5e/tnaTwefT4IeOvTXVnMtV
         u/6Q==
X-Gm-Message-State: AFuF++mHNtkdNwJ8fKZVa2KpY3wBFnW7EDLQy1Fj1EB6PcklHgLflZ6Y
	oBW6aSuWka2YRbTdXa37p/TVKGiNKaLhRU+qGfsqRjhgFY3Y9bpp/79KFPNsGmTa
X-Gm-Gg: AR+sD13u4u9XTNDu/99u1raCdgaBmrz8zttfRwFwpAw9LCRFSgWjGAtYgVCieJ1sJH1
	IINhoMrpQTe5Rb/OyBK6cypcgtqN17iPNr8Q7uBvCPTSL9wRhanxGg2SbWG7bs5GI58fWGcm36f
	qwYZjoi/pzrepWd5McRECabjE1JurtmeCbox9YZXqork/BjSu7lxHBr8h5suW1WKVqmctbTJjsK
	kKd7I7idoTedOcZJkqj64oRk/dJWdl9cYTvuBoRe0iAyoPCUpC66ZatUlkFoxr7zxH7v0LkSXMS
	WOdct+Kv7Hkyx6tW5N39VHqFvZMIThueOxWWGcev0SB1obZtz0msPTr2bFtgkDsTtghOrbKn8Rg
	0DNCFNFKs8U5RYJEkoRWGhLDJfrtjdCfrR3+D0yI8tRpmg2unk5qBKuIzAt6Rci262AhD4iLPtM
	lG+wdHQSdfn7N976AXyWtVe29sfNHX6oVihbE8jSnABURSLjf9Pt/TNqlwK5zcHR6h2x4ZweMJz
	O35s8o22N6b23QIlpWG2MtibAkHxxJlkI+Eoqs8/FXcelhoOMxE5NjWsB7NIoTFo/4qApIRvtR1
	iwtTmY3PcIhGkxy2xHZ7B69vZ5g=
X-Received: by 2002:a17:907:1c26:b0:c1f:29ce:76a1 with SMTP id a640c23a62f3a-c249272d9d8mr203829066b.19.1787355320282;
        Fri, 21 Aug 2026 16:35:20 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c249629a901sm42583966b.25.2026.08.21.16.35.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2026 16:35:19 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
	Pu Lehui <pulehui@huawei.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 02/14] bpf, riscv: Fix stack-passed arguments for indirect trampolines
Date: Sat, 22 Aug 2026 01:34:56 +0200
Message-ID: <20260821233516.3426127-3-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260821233516.3426127-1-memxor@gmail.com>
References: <20260821233516.3426127-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2801; i=memxor@gmail.com; h=from:subject; bh=p7Y4bEq0/hTyqNNb2Vk5KhzjwOByoEvgSRKCv1KKkOo=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIavjQU/rf6GvbMVr/Z/P4um9mpjylvGzmk+5brpp8SrLt TPM76ztKGVhEONikBVTZCn5v4/J+ETl70DbZdwwc1iZQIYwcHEKwEQm+DH8d2wuuFrD8nb/24yW q13Ns35NtrmeqHiU5eP8YpdnehKCDxh+Mf3cxy9SxhxUJ9v+/Gjj/MfPlzz/YvBJ1f/61r3Z/I3 cvAA=
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

store_args() reads stack-passed arguments relative to FP assuming the
trampoline was entered through the fentry call from a traced function. In
that path, the trampoline pushes the parent frame before establishing its
final FP, so the incoming stack arguments start at FP + 16.

An indirect trampoline for a struct_ops callback is called through a
function pointer. Its prologue allocates only the trampoline frame and sets
FP to the incoming SP. The RISC-V ABI places the first stack argument at
that incoming SP, so the arguments start at FP, not FP + 16. Every
stack-passed argument of a callback with more than eight argument slots is
therefore read two slots late.

Pass the prologue-dependent offset to store_args(), using zero for a direct
struct_ops trampoline and 16 for the fentry path.

Fixes: 6801b0aef79d ("riscv, bpf: Add 12-argument support for RV64 bpf trampoline")
Cc: Björn Töpel <bjorn@kernel.org>
Cc: Pu Lehui <pulehui@huawei.com>
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 arch/riscv/net/bpf_jit_comp64.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/arch/riscv/net/bpf_jit_comp64.c b/arch/riscv/net/bpf_jit_comp64.c
index 47c7bf431ba8..b1084f30f3ce 100644
--- a/arch/riscv/net/bpf_jit_comp64.c
+++ b/arch/riscv/net/bpf_jit_comp64.c
@@ -857,7 +857,8 @@ int bpf_arch_text_poke(void *ip, enum bpf_text_poke_type old_t,
 	return ret;
 }
 
-static void store_args(int nr_arg_slots, int args_off, struct rv_jit_context *ctx)
+static void store_args(int nr_arg_slots, int args_off, int stack_args_off,
+		       struct rv_jit_context *ctx)
 {
 	int i;
 
@@ -865,8 +866,8 @@ static void store_args(int nr_arg_slots, int args_off, struct rv_jit_context *ct
 		if (i < RV_MAX_REG_ARGS) {
 			emit_sd(RV_REG_FP, -args_off, RV_REG_A0 + i, ctx);
 		} else {
-			/* skip slots for T0 and FP of traced function */
-			emit_ld(RV_REG_T1, 16 + (i - RV_MAX_REG_ARGS) * 8, RV_REG_FP, ctx);
+			emit_ld(RV_REG_T1, stack_args_off +
+				(i - RV_MAX_REG_ARGS) * 8, RV_REG_FP, ctx);
 			emit_sd(RV_REG_FP, -args_off, RV_REG_T1, ctx);
 		}
 		args_off -= 8;
@@ -1152,7 +1153,12 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im,
 	func_meta = nr_arg_slots;
 	emit_store_stack_imm64(RV_REG_T1, -func_meta_off, func_meta, ctx);
 
-	store_args(nr_arg_slots, args_off, ctx);
+	/*
+	 * A direct struct_ops call has its first stack argument at the incoming
+	 * SP, which the trampoline keeps as FP. The fentry path pushes the
+	 * parent frame first, so its incoming stack arguments start at FP + 16.
+	 */
+	store_args(nr_arg_slots, args_off, is_struct_ops ? 0 : 16, ctx);
 
 	if (bpf_fsession_cnt(tnodes)) {
 		/* clear all session cookies' value */
-- 
2.53.0

