Received: from mail-ej1-f67.google.com (mail-ej1-f67.google.com [209.85.218.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7DE6388873
	for <bpf@vger.kernel.org>; Fri, 21 Aug 2026 23:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787355325; cv=none; b=rJGZ7eoFwwz0xMWw9Q6LbbaniP7Ug3Jqn+vvBvqzYr2kzBA1QlDWVH1ziEJJXFj25+bRS8Ku7iJ83NL66wmUbN0dhKlytn0o2ppydggeQgmP1Hy1waXZlCDqas6aJl1kaegnlnnB+YJP7cAT5vGzPIwFN2XQsmnEEeetd/G/lLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787355325; c=relaxed/simple;
	bh=CHR4vu62waiMKk7n/r+/CMNqE/WyJ6VbVy8qU2EYouI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VR61vvNkorOx9i/cAYV/WXCbLnLzqWtIORLGIxcM4TcWiNr4G0HNMA4k/cq+dCac47R8u+cPPBEB/1/bZ43EgnKIIaYU4AdEbJnTrUzr7vRd4aWUDh1khshE6EiJ++vbcw98MwvLvsNDT1X3SeY6rjXckQFteUlD+sMJBG0giMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sSlreCeR; arc=none smtp.client-ip=209.85.218.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sSlreCeR"
Received: by mail-ej1-f67.google.com with SMTP id a640c23a62f3a-c1600d040e4so237972166b.1
        for <bpf@vger.kernel.org>; Fri, 21 Aug 2026 16:35:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787355322; x=1787960122; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=HF7ZbiPxmHwCPV3MXqkAHglmpkDT5Htnozv1WtxM/lA=;
        b=sSlreCeRRoU8pTrt5AywAi+XYU+hkjr65EoOX6oKsy3HAAh3aDrtO8FLhMnBgGwgqP
         AGNMwIVeoYIA4KjmbdoYtXXh/uah9AJujmGdHDHEuKmfx3VDEFLO5fRfDt7InSLuKSjq
         ynLa0AzN6h4Nt3Q0OYiSY1fgxU4RR/nDwf0ZDEmFfWuMPULGsNLfZD18dtBSMNqyoXpm
         g/FSV1dkpk1FdHKszLofmygn9+EMvyui8GLyGgMYQVNBOy02U3d8LEEeR/XEAxEHOz/O
         HZA2Fw4KZf+aViWmEd72M+gT4VeUi1x2WaGeEcGR5+48hYvl+dIeO4vmEi7c2dzLteyj
         j2pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787355322; x=1787960122;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HF7ZbiPxmHwCPV3MXqkAHglmpkDT5Htnozv1WtxM/lA=;
        b=PFcUhZziXxpRCezwidtQ1vD8o3E7taYUwCqp+X4IwjCwihTIfv7q/pVcfNaTTmBLZe
         OKSovomcxkWEhG9th5ZgrRH7KcKl3Ro5qinCD2Zm+JrhEK92Xdfhi3011EJbZJYFNK4B
         IfmhbVbDBvomsDdwMR+1LswV/yI16nBQ4h4WplgUA5elNGMFbdIIkZNur0iLROqcXcS1
         9xzUgn+014p4bonrtNy417ubFvdWGG/umjE/xkUl5ma5UiNcA8p0mgdfThdUE+dzYBYZ
         R/qZ6eYzo9Ww9UgqD24DXvcNHVVgR90oQuLLMEgY0dy7pSY2RzHl/1SPRvrFtszXE/De
         v72g==
X-Gm-Message-State: AFuF++kj9yVs8fZqVlGE3PEadJszfA0Xozg0TnekRrHo4suNgTjNhaLV
	T+6oOB7spphpiZ03gd/KZqquNG0yDgjbekgtd4mA5ozUjueUWYHP1Zp/AVfS60hm
X-Gm-Gg: AR+sD11QQP82il4+xuv7Ohp+Sx6sH2pYDZNnhfxc4/OcUZM2w3rDXwh3G6KYSnztOG+
	YV0mzvYS/Xd8pAh805VBlTQLXqxKyYntgqvoeXaiw4tN0kTwYRDg1ILIibh6/QaaXH/D60l6EXf
	j4oZ7i43sA1frY2LN0HOK5KNS95SNp0Q/wDXuaLjKOJLR8VhVrumdidCaGMzFQefpZHSBjp7yaH
	/1qUl7Og89hZNcDCnDDhdhnjFptT2NiMlAZnKTlwA/J/1rWMGhbkvhq18bnukZP0WIrnynle1a2
	3sepi9cSDqaBgfJlCs/VbOxqf40EGoM5Qksq4p7KMQeWstQ/IMum8CDsRXGPcVtA2H+1WzOLYhx
	s/NeRSIOmkOAfaaYODuETJXIIGAcnaTuysh/Rn8wrCasnH5dP3iL5UICdTc0B2vgUZ22NWUbsaz
	YEBxtF318T99uUkoM0xaOeIzK2gMuctx3m2uLfRoNsSYyXxXz5i72ZKU/lzKrVIfyli7z0ZEDJn
	cdi7YlDEIuZ4nUR+z8EjYjCKNfJgh1fPZtsjY8tiahJ11wqI440V9xX2B/DQj1MmqDA/UuHN7WX
	qmDyrrvyvmxJr+SHPdL0bfuPPFgBlqHQSfWpgg==
X-Received: by 2002:a17:907:5ce:b0:c1f:2cb2:c448 with SMTP id a640c23a62f3a-c244d672d37mr1466145866b.7.1787355321783;
        Fri, 21 Aug 2026 16:35:21 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a3ff1780c9sm8556175a12.28.2026.08.21.16.35.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2026 16:35:21 -0700 (PDT)
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
Subject: [PATCH bpf-next v1 03/14] bpf, riscv: JIT arena kfunc argument rebasing
Date: Sat, 22 Aug 2026 01:34:57 +0200
Message-ID: <20260821233516.3426127-4-memxor@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3177; i=memxor@gmail.com; h=from:subject; bh=CHR4vu62waiMKk7n/r+/CMNqE/WyJ6VbVy8qU2EYouI=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIavjQY9/bTSD6YIKtxXvqrV533u2765n+3Otctfqmpent oWlrFfpKGVhEONikBVTZCn5v4/J+ETl70DbZdwwc1iZQIYwcHEKwESUXzIy9K71ZSzYsVpA4J4Y T5ngwy+31ua9S8/mOp7wwDnkmfbOVIZ/dhIR8v3P65ZusJDbVtpfzZZSG7nxSEKMWLlzCre9bjQ PAA==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

A BPF arena pointer is represented as a zero-extended 32-bit offset while
a kfunc receives a kernel address. Kfuncs whose BTF argument names carry
the __arena suffix therefore need the JIT to rebase those offsets
immediately before the native call.

RV_REG_ARENA already holds kern_vm_start whenever the program uses an
arena. Zero-extend each tagged argument and add that base:

  zext.w aN, aN
  add    aN, s7, aN

For an __arena__nullable argument, branch over the fixed-width add when
the truncated offset is zero so that NULL remains NULL. An unconditionally
tagged zero is intentionally converted to the arena base.

The sequence is emitted as native code after the BPF instruction stream
has been blinded, and its size depends only on the function model and
enabled ISA extensions. Advertise the kfunc capability independently;
struct_ops argument conversion is not enabled by this change.

Cc: Björn Töpel <bjorn@kernel.org>
Cc: Pu Lehui <pulehui@huawei.com>
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 arch/riscv/net/bpf_jit_comp64.c | 40 +++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/arch/riscv/net/bpf_jit_comp64.c b/arch/riscv/net/bpf_jit_comp64.c
index b1084f30f3ce..c97d13a3eae4 100644
--- a/arch/riscv/net/bpf_jit_comp64.c
+++ b/arch/riscv/net/bpf_jit_comp64.c
@@ -714,6 +714,37 @@ static int sign_extend(u8 rd, u8 rs, u8 sz, bool sign, struct rv_jit_context *ct
 	return 0;
 }
 
+/*
+ * Rebase the __arena args of a kfunc call to arena kernel addresses,
+ * aN = kern_vm_start + (u32)aN, with RV_REG_ARENA holding kern_vm_start.
+ * A nullable arg preserves NULL by skipping the add, tested on the
+ * truncated value as arena NULL is offset 0.
+ */
+static int emit_kfunc_arena_args(struct rv_jit_context *ctx,
+				 const struct btf_func_model *fm)
+{
+	int i;
+
+	for (i = 0; i < min_t(int, fm->nr_args, MAX_BPF_FUNC_REG_ARGS); i++) {
+		u8 flags = fm->arg_flags[i];
+		u8 reg = bpf_to_rv_reg(BPF_REG_1 + i, ctx);
+
+		if (!(flags & BTF_FMODEL_ARENA_ARG))
+			continue;
+		if (WARN_ON_ONCE(!ctx->arena_vm_start))
+			return -EINVAL;
+
+		emit_zextw(reg, reg, ctx);
+		if (flags & BTF_FMODEL_NULLABLE_ARG) {
+			/* Skip the fixed-width add so that NULL stays NULL. */
+			emit(rv_beq(reg, RV_REG_ZERO, 4), ctx);
+		}
+		emit(rv_add(reg, RV_REG_ARENA, reg), ctx);
+	}
+
+	return 0;
+}
+
 #define BPF_FIXUP_OFFSET_MASK   GENMASK(26, 0)
 #define BPF_FIXUP_REG_MASK      GENMASK(31, 27)
 #define REG_DONT_CLEAR_MARKER	0	/* RV_REG_ZERO unused in pt_regmap */
@@ -1834,6 +1865,10 @@ int bpf_jit_emit_insn(const struct bpf_insn *insn, struct rv_jit_context *ctx,
 				if (sign_extend(reg, reg, fm->arg_size[idx], sign, ctx))
 					return -EINVAL;
 			}
+
+			ret = emit_kfunc_arena_args(ctx, fm);
+			if (ret)
+				return ret;
 		}
 
 		/* restore TCC to RV_REG_TCC before bpf2bpf call */
@@ -2132,6 +2167,11 @@ bool bpf_jit_supports_kfunc_ret_reg_pair(void)
 	return true;
 }
 
+bool bpf_jit_supports_arena_kfunc_args(void)
+{
+	return true;
+}
+
 bool bpf_jit_supports_ptr_xchg(void)
 {
 	return true;
-- 
2.53.0

