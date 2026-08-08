Received: from mail-oi2-f2.google.com (mail-oi2-f2.google.com [74.125.231.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0B502BDC28
	for <bpf@vger.kernel.org>; Sat,  8 Aug 2026 00:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786149599; cv=none; b=aErKLdcMNA9e4zIRfB1G4FyIE8iffMlJcoGA9iTnww9ruzNIf9G6HDJOaPLWY0EYY4h6Q4rZJveKbeQFPvjt85O8f6GdBT1hpmbDJXpG4INa6T5PVqqaoZJzlfnWOq3QaHRVdJ2PFlZwRYAfSF1ulqUpwXaYGZMObDPJq/DPhHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786149599; c=relaxed/simple;
	bh=qz+kFplR3DX/V5K3f3YqT4dZrm+dF5gMAZrNGRg8urI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZfvN62LKZbbA1wVA4Y8OHkXqc4kTcdKPduml0z0DDNQzOBh566zRaAUy7WJZGUCtWD9nqj4NJxgZEqrG/QiZPe8r+dbpeGZYcgJPcuSOC+rgADgz1iGuHeMQrizxg4PB7qGFTRf4geLptUN3/Cn37v7Fq2aGzbw2Hk106U2G88Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cjFDvPBL; arc=none smtp.client-ip=74.125.231.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cjFDvPBL"
Received: by mail-oi2-f2.google.com with SMTP id 5614622812f47-495e058ca73so33453b6e.0
        for <bpf@vger.kernel.org>; Fri, 07 Aug 2026 17:39:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786149597; x=1786754397; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jTEyjjCJRtLJKMO783sxExrNTGO+vlMS/A14uJ/6yWk=;
        b=cjFDvPBLHFPmMuyOc0SrWuuyPlOoc3URg2HGgCPuZ9rQcYj5ST97jykAINsgadxMWi
         Rfbwvtfz3WH2Gd2Us+fod1IHR3FGj0NrO1FkoREBXii13q4FCVhX1JRz3/Cr0nJ9R4eA
         GdNRFZHMik3RnH71FfYo0WZq0nE9PQpO4KzttopfEpq/wpbESWtnKVi4bhe4j0MNzM0V
         SBcjFUuylp8SOkDUKaGxIe/9lysC0zFQMtqTxGh9sP+iT30LFNm0QOgZva5pteZtVj2J
         heZaWpTOwUW1H3WdRTzLE2VXcwtPboCkMt12BK717772CI0rM4mrKDfjnTYn0JQGHvyc
         FXXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786149597; x=1786754397;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=jTEyjjCJRtLJKMO783sxExrNTGO+vlMS/A14uJ/6yWk=;
        b=OhoRbfiBO+49Nlb06GOnERxXRM5mSkpOdTrN8yd4VtoOA2wD7H65QjwGLh+eWDvhNI
         CFyaegAGE92isZVE+N3/iBENZtm7IvxjZgKgyGjfOR8Wx/sprcZBp2JjXgLvrmClMPkp
         XmaeYXFoLIei21zSvy3ysBDbbgFN/Aseiuu2eBUGPPV5KPyq5HdZ3x2RBccnu4Q6Ge+w
         fOFuZC0W0UnfFefn3kXeoAXoq3iLUd+QUq/TvLoQIlpSM7dcSrRSpKNlS923+LCZHS4i
         d0CMlo+NlUCYMD93fVWtldOajNBsJovt7lFEFZ/wRm7eDDuym508I8J1nMT0wPyqFb4u
         Fbng==
X-Gm-Message-State: AOJu0YyFJDEL7JTtb0O/WeLvcUChBvd6ESwJa1AIi+zpE7s6d8v9uZYG
	oxTYC2ynTGUufarw6Kf72uXmJbqcdeHcE795r44dRmFaKbWFQ1XoNfhOmoYNO49VTIU=
X-Gm-Gg: AR+sD12x2RCK7Qwd6lgdhRcQbZM/aP10xXBGXpbQsduDMY4OGQk1/u+2Xj7jv+BMgzo
	+MzCKpd165Ysuyy4gSYDHEgdCYT7IzJ3tiu11j+dQW4krzI9s3VXYJ8LakzCoN8uv7zosMCP/K9
	XSZl+wpxX26kP3zWDCQh8YHieBaDlqsGZCBW9/l5b8bx6Ap/r2qXW5801KrE3jkI1RmhzDWyl3o
	mPd1fAp7uL7+Zit5epHlOzOycuVTj7VuO4AVg9foDawxElpPqya850mTYFONcv7RS1AU/dHFyTU
	8oSlrDaBauqQqc3gnpWkfC/fHhbUirm/uxVPeJ14/mgnPS5ahU6/K38S29n/N7n2ZpP8MVsK35q
	Oc5yPBkUIwu7y+ju+PDgafy02LQ+IEiTJQnYO4WSraH3WyWr2r/QNnTxlLRULyVURFapwNNoacx
	FQQ0qxhA8wWuFo67udYiVUEWJjbDxrBM+LOay9yGq5FdHcdcb7LRdKhC/Ld/hp2J2YuiTVND8oR
	pPgQN1y5s9vmF3KNPnZKiIHm3J9fPsJCGOdDTcAC2e6pjUz2P+/uaTX+Jt1HLnTkf/qYOiC6jmx
	PKFm
X-Received: by 2002:a05:6870:16e3:b0:456:cdfd:bcc5 with SMTP id 586e51a60fabf-45a0f3cc1e1mr2634441fac.21.1786149596635;
        Fri, 07 Aug 2026 17:39:56 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:a::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-459f1d77417sm3040852fac.12.2026.08.07.17.39.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 17:39:55 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v5 06/14] bpf, x86: JIT __arena kfunc argument rebasing
Date: Sat,  8 Aug 2026 02:39:26 +0200
Message-ID: <20260808003938.3486067-7-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260808003938.3486067-1-memxor@gmail.com>
References: <20260808003938.3486067-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3273; i=memxor@gmail.com; h=from:subject; bh=K01vFwrhvnFrplwzKlRAtT02lXQE/UnSBtMoogt0dY0=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIausqvLn4ye8irZB72+UX3i7jtuP8+TJtd8q+9/GPKu6f99G 86l8RykLgxgXg6yYIkvJ/31MxicqfwfaLuOGmcPKBDKEgYtTACYy5xHD/5wmVaPIPztcV1/8YtQRFt j88Hy/6iH1Sf+ezFjqyN6q+5mRYY/x5/5/Av+qTjDs3nF57qxVeb8c33a4zK/buPwij80zFUYA
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
Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 arch/x86/net/bpf_jit_comp.c | 50 +++++++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 88ed95b2eaa7..107b9901fba8 100644
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
@@ -2588,6 +2632,12 @@ st:			insn_off = insn->off;
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
2.53.0-Meta

