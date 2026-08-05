Received: from mail-wm2-f7.google.com (mail-wm2-f7.google.com [74.125.225.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 326AC3E168C
	for <bpf@vger.kernel.org>; Wed,  5 Aug 2026 21:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785963878; cv=none; b=kuu177GIThPVibFAX+niU1hvb1PipDqL2G+ipIATbRnO+KPqI9Eg3F+8oYV9scXsda1pKEq42rURPmdNvSAxPsr6BfFXAxbeEVNJqBeLJd4U+0nMP4cfH+GyjIeweaLeNdMG3BH0qG4sZffPpJjJAEH+yYWwDlRT/ZHc4iArSlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785963878; c=relaxed/simple;
	bh=rBg75DCfeS4PD6AuSG+UMX/3KjRh9LzZLahzkfBQoLg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aBPmNAnkKZhO0LkeDr+27glDx1OaZWyJJy3DJs2504p/iXJ1oJD88VFv1PLY/G33MvvL0TLI627ZS7ZDH/tgB347CHgkWEcX+72GqBwdHBN8poWvophRoq5eGUswp3ufAX7QtnvHsbCl8rnbQEoTRW1JKaP+AW1tN1hiqs9ccq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qsPobURI; arc=none smtp.client-ip=74.125.225.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qsPobURI"
Received: by mail-wm2-f7.google.com with SMTP id 5b1f17b1804b1-498079e98beso3537625e9.1
        for <bpf@vger.kernel.org>; Wed, 05 Aug 2026 14:04:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785963875; x=1786568675; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uwG0FfFtu55mgnNThO/RVtXLCKxh881AbBITe6eGfQM=;
        b=qsPobURIG7BQP8hJYEDuCpKa49kC/8u+OJNLBdq7nXIdZoprRQCrI59eX2AP42V+j/
         ZCeUP/lkbae6/o5dGnlf86GwCMU+bQNuwO0rqpDQEfPsFtyztiYGU1GdemQNM15uD6Cq
         zrAbHMxKYJJ4MM+H8jz0Jm9IJYN3N2oVXvzGOU+0UMG8thT8nijKvPVlITiqQ5xiD6hg
         Hmtq+AqTPM79te6jDaC7HFbUdvMTReA2Z4mrQ2jr2t1A2JFpvFhfXbS/6g0bc5XIIvAj
         JV1jJqb9aUvvjNsDa6sNbWPC6kY9OmyfZXqgg9H5+g3BdbKhP0jsojs4UQQBuZL/F2Cb
         dP+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785963875; x=1786568675;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=uwG0FfFtu55mgnNThO/RVtXLCKxh881AbBITe6eGfQM=;
        b=VQGnUJVCrtHWJzYVF8zmIj3pGOLabd8MnBGqjQzO1hcdhbapdink9Bt28UxuBH7+/6
         Zle1Uk4W6NE/ySLGqVdTH163fdN+qSpjomxm1rFi0VMR4nCHyM6wT/J7T+j0ed8Ccc7r
         2g5tE69mN5a47ygnZ8Hpjeob3yfCNUhtS6JcQFktB+T4exoVUkG31oWL6cseIyUIjyCM
         FoZkkq5AMRnZB8T+snxj7ljeDPFBN++Cfs7IVhOwJ+UgD1nXlf0XFo6JoKzTiaR5eli/
         4dQUeWdllbIflKkTwIylljiqT6lWXk8Pkwjz4xtUghL3MZisAiM1mO98am/OEMhE4VON
         JU5A==
X-Gm-Message-State: AOJu0YxRMi4onQqR73Op9EsaOgm51kSOrsW9lYgXZOGt33z2eNHQwJq0
	dWHQ8qKbXKbXEVFy5mSPRbnmmeuoOSRUoLnB7b/7K9nd/522HMB4w/htDA+oaUMw
X-Gm-Gg: AR+sD12grymgLlZjb+88sK14VrH1NRH39dpyj9WgD7dIuw/d3Z5uUiKaS9LD8y+Xo8A
	DZ/qChLv6LSVa628p1f5iivmFwlZNtwq7byq1nMYnQQd+BhjDY8clTTYCRaE8e0UFjhU5xfY7ss
	g2M/arc+kPSf+d5KdH435RwBM/wSCzf2G9EpaONqVwZDi/pgq/Qdefgw154Krz73umsza0/c0FX
	c3zlmp6w02aiUMPVbGqX5Om+v3A7fsnN579Txv1OZeo5ahqlNlIc+sGyfHN5oLwNW47LbwMGq3u
	16gcHWgYN5BcgHbz7uX+w8ExWxSokccuwivQm5p2gmUk1/nQfNKKsWTukWb3Gmbt3ubL5Q+5EdN
	x5vc6OFcQpZsOTmO7Vv0s2Zhy6vkdP5I88A2tL4lA+MnwuEn7/aHMEMDDiV+HjOQJugVUp2E5/g
	3b/PpKzpHp98ebqtzLlN2Y39+BiudhPPvibnpmbfNsPOC9qO/lHd47GucYxt4/squzBPjWYdsCW
	OfmeTdaeNmppneEDbODhUG5A8+z5XSBSoCPdqALDFlvUB4BcSHI3mQwjN7mySL/RhrF8QlucECj
	5IhMmeKfkAE260nVSOyNQxj0+74=
X-Received: by 2002:a05:600c:a47:b0:495:6e68:5df2 with SMTP id 5b1f17b1804b1-4994e7c0c62mr117655835e9.12.1785963875330;
        Wed, 05 Aug 2026 14:04:35 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4995421934asm8226595e9.5.2026.08.05.14.04.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2026 14:04:34 -0700 (PDT)
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
Subject: [PATCH bpf-next v4 06/13] bpf, x86: JIT __arena kfunc argument rebasing
Date: Wed,  5 Aug 2026 23:04:17 +0200
Message-ID: <20260805210427.3218326-7-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260805210427.3218326-1-memxor@gmail.com>
References: <20260805210427.3218326-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3268; i=memxor@gmail.com; h=from:subject; bh=Kgv67R9LtVDrUXotMuK92TyPOwMqCmFHYAf/MhvK1NQ=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIat40ZRzzBWHNjb0BF98fP5e/nkP+3WzJXi+X06btMvc5 2Pc3IJ3HaUsDGJcDLJiiiwl//cxGZ+o/B1ou4wbZg4rE8gQBi5OAZgI1zlGhifyKRwux7tWfpZp 3vfuyZ600+HnvTT+fAlUCJ95azOrcR3DT8ZZj/z+xZR+yjhgeOLdo6cBCxkcX/5TmHhpStYMZ57 aC8wA
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

