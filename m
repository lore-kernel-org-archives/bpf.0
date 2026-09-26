Received: from mail-wm2-f10.google.com (mail-wm2-f10.google.com [74.125.225.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BBBE3A7F7C
	for <bpf@vger.kernel.org>; Sat, 26 Sep 2026 23:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790465726; cv=none; b=IjWJphHF11onNHrVhasqsom+GxBTXzJzRVGCTaxo/un4n0QDaf6ZWbAVcAKUEKUtPRVlm6LT9uI+VQe9P1TuPQZfxCkakkDVV53FE6b3kwGDqQaUyveb65tGphkb6cmb2rTSzFpNPJR7xVAaM3DjKBGd2P1dFARvuhyw5kEVS1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790465726; c=relaxed/simple;
	bh=Zt6GKFGiSHtvIgW2MT699YvjOF0HREKyOUXkqm6Qadg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BRz24VadYX/SSmCsyNNLxFwaZM4Vd28EQpdg8U5QPir+xZ1v+GznqgRkA4bVHHnpcM9fmNnOJkznvWC8kE/Op4mXXNZjMB6EMh+NuugSvkroHZ3PeGInGN2jsPa6FoQromKi8cv6MTNUZh8l+J5x6LCr1yitsxG/gLP3/oID0zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VyDaU7XO; arc=none smtp.client-ip=74.125.225.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VyDaU7XO"
Received: by mail-wm2-f10.google.com with SMTP id 5b1f17b1804b1-49ffd5111f2so3330515e9.1
        for <bpf@vger.kernel.org>; Sat, 26 Sep 2026 16:35:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790465723; x=1791070523; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LqMYsWJki1aSEgKbPdpJAmDFKxvkOARKEH1/43UO3Ug=;
        b=VyDaU7XO672ts9KlBjhtiynGMRgQ+IrGzjPMgWIDPaGzDZPY+x2cO1xLMPqgX/Rnmf
         94277UN4tChoTCTR4FXvyOoJfLnOLy/++n+SNyoVy9uoMd3vQBPsWf18sQsQBCZAqFv3
         xXdHH6/X1NjkO3aN7SWEhhQfxB656Z53DANJV0yKoWqpWZntrxRUMGI05JKmHGhcFD+t
         SY+MNXJJYG6qv+Yw88x8v2QyvhgXFXLF8G0KQfZu632NgdZeYR0xGeK6lLX/O6guG7UC
         VT/p3jN/Mm9EvuU4s881ApAe0cR0ye8ssjhG2VFwBMiLMAS8XXmZbfd8Eb5EMCOk1YA2
         jGnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790465723; x=1791070523;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=LqMYsWJki1aSEgKbPdpJAmDFKxvkOARKEH1/43UO3Ug=;
        b=aEzdcZIhq8+NTzFV9orRlB9II3INvDpHqvbl1CYQtat5/+mYestoxuhcehj+15veaj
         fPdcNy01mOiBl0kHHU/KGQNXaZzutMDb2TeQRGlwvNZShqG9VahhqYJlRNmGmPb7IBAe
         QoBngEOSP9D74/SWBqaMe6nt/RxEVW5ikxJYPMvbuCMYlvwo11cIpGYM8Lvzdc4Hd7bJ
         a4VawBw5jgJRv9cZLwUPfn6d9J9sbUVwbbrpOph/tcHwXQYgmFuou/h36kh1s1Uj3x+i
         kPNFyR8ugLnOHo1R19lR/T+OKl6XoUfVCMtt5letaWgHqXRsBay07F4BcuSOKKaVYy3C
         VCxw==
X-Gm-Message-State: AFuF++k+iPpXeKxzPNwQiadj4u29J5bX+GPHDAeZa2rhlCgbdBk7KZh/
	ErrqY2U+7hEkFJThhlcFwOJNoJ8B+/dzo7vathTNRlbI7IZWo9/IfrfZsIMNVrdK
X-Gm-Gg: AYBFou2lZszC9KvxDMG22oOjzGMwIZz/nRrIwfmZwGPtprX+JCGaPJPboKJckstud3T
	mKlE31kllayo1ZpuLeGdOkC6eMU1z7R5WBobRKLe6WpOEbJ1JGE9lAi6Wj0RXbeIr2fn46RZ2Ac
	5s7u9bUizIpcXKhdvzq7AspAmjgani0mWqn96xHBkE7qUDrFd2/lJLr9DDcDrjFGpXMhfNk2Uho
	0ZwfS6vxOcDLU/6xlDbQ66wAhx5y5EHUcWW5X2l/ZRtiDgvc+dtq8Bgv8LS50uPsvsg2qhWV+Oy
	buK1JOH4NiRbiVnRObx97nIhv+YzXhPu7q9b+0tjdlhoOoka75UsrgASAbuBy95Z79lH0UMDDz8
	u9yzHup5lgB8iEza3mrQT6PBeKtjcP2hjn3HYXnrm80a28+CUDUzdlbFD+NOHru+TmDC3FTTp6H
	uSyGxRsdYOBSjs1J9SwVmQEVLq83/c1QjrZQxdKZoio1I6oRTYzsbaTPM/pvF7gIIxwNh/I6oHv
	Ki3Gf8TKNXjrYRbFJxasyNCG9ySyt+9ltyBKWR9Hm7LZCmvMsi+ne2N6wlvNGwWwQrWnvVVKKlE
	nweGlU+k64hKlaS2CByy2Rkuj+PwO3zHpIDHUyk=
X-Received: by 2002:a05:600d:849b:20b0:49c:f4ff:e872 with SMTP id 5b1f17b1804b1-49fe66abd01mr121676555e9.5.1790465722712;
        Sat, 26 Sep 2026 16:35:22 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4887a34a314sm17290731f8f.6.2026.09.26.16.35.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2026 16:35:22 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [RFC PATCH bpf-next v1 10/16] bpf: Let typed_arena_cast copy pointers the verifier already trusts
Date: Sun, 27 Sep 2026 01:34:48 +0200
Message-ID: <20260926233503.3114147-11-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260926233503.3114147-1-memxor@gmail.com>
References: <20260926233503.3114147-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7336; i=memxor@gmail.com; h=from:subject; bh=Zt6GKFGiSHtvIgW2MT699YvjOF0HREKyOUXkqm6Qadg=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIWtHWHzIly3/HpUJdjVWtq1UPcnFy7bh27z3Jt57jzwyl mo7uCK+o5SFQYyLQVZMkaXk/z4m4xOVvwNtl3HDzGFlAhnCwMUpABM5+JjhJ2PuodXTZ6Ykuqxe tUzn13QZk7KksxvlFdg4OQ7W7++5cZWRYfJtVZ5vewVyte3CY1JTfq6M/re97dK2B0x34qoqTvx /zgcA
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

The compiler inserts the cast at every use of a pointer to a struct with
special fields, so that programs never write one, and it cannot tell what
the pointer is: the same struct lives in typed arenas, in allocated objects,
in map values and on the stack. So the verifier decides per path what the
cast takes. A scalar, a raw arena pointer, a typed arena pointer loaded from
a field and not yet sanitized, one of another struct, or one that
arithmetic moved inside its object is sanitized as before. A sanitized
pointer of the struct's own typed arena at offset zero is already what the
cast produces, so it is copied, and since the sequence is a no-op on it,
such a path may share the instruction with sanitizing ones. Any other
verified pointer, to an allocated object, a map value, the stack or
anything else, is copied with its state, offset and references: the cast
has nothing to add to what the verifier knows, so it needs neither an arena
map nor a registration, and a program that only allocates objects of the
struct loads as before. The lowering is per instruction and runs on every
path through it, so a path that copies such a pointer cannot share the
instruction with one that sanitizes, since the sequence would mask a
pointer that is not in the slice; that program is rejected. An instruction
that only copied lowers to a move, or to nothing when dst is src, which
takes removing the instruction, as the nop removal pass has already run.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/fixups.c   | 35 ++++++++++++++++++++++--------
 kernel/bpf/verifier.c | 50 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 76 insertions(+), 9 deletions(-)

diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
index fd0ba8376c1c..a0856bd18ac2 100644
--- a/kernel/bpf/fixups.c
+++ b/kernel/bpf/fixups.c
@@ -897,17 +897,34 @@ int bpf_lower_typed_arena_insns(struct bpf_verifier_env *env)
 	for (i = 0; i < insn_cnt; i++, insn++) {
 		aux = &env->insn_aux_data[i + delta];
 		cnt = 0;
-		if (aux->sanitize_needed)
-			cnt = bpf_typed_arena_cast_insns(aux->sanitize_arena, aux->sanitize_reg,
-							 aux->sanitize_reg, insn_buf);
 		if (insn_is_typed_arena_cast(insn)) {
-			if (!aux->typed_arena) {
-				verifier_bug(env, "typed_arena_cast at insn %d has no typed arena", i);
-				return -EFAULT;
+			/*
+			 * A cast that sanitized on some path lowers to the
+			 * sequence, a no-op on the paths that brought a sanitized
+			 * pointer of the same typed arena. One that only copied
+			 * verified pointers is a move, or nothing at all.
+			 */
+			if (aux->sanitize_needed) {
+				if (!aux->typed_arena) {
+					verifier_bug(env, "typed_arena_cast at insn %d has no typed arena", i);
+					return -EFAULT;
+				}
+				cnt = bpf_typed_arena_cast_insns(aux->typed_arena, insn->dst_reg,
+								 insn->src_reg, insn_buf);
+			} else if (insn->dst_reg != insn->src_reg) {
+				insn_buf[cnt++] = BPF_MOV64_REG(insn->dst_reg, insn->src_reg);
+			} else {
+				int err = verifier_remove_insns(env, i + delta, 1);
+
+				if (err)
+					return err;
+				delta--;
+				insn = env->prog->insnsi + i + delta;
+				continue;
 			}
-			cnt += bpf_typed_arena_cast_insns(aux->typed_arena, insn->dst_reg,
-							  insn->src_reg, insn_buf + cnt);
-		} else if (cnt) {
+		} else if (aux->sanitize_needed) {
+			cnt = bpf_typed_arena_cast_insns(aux->sanitize_arena, aux->sanitize_reg,
+							 aux->sanitize_reg, insn_buf);
 			insn_buf[cnt++] = *insn;
 		}
 		if (!cnt)
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index b85d99f81ef5..aceb17e62948 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -17299,13 +17299,51 @@ static struct bpf_typed_arena *typed_arena_register(struct bpf_verifier_env *env
  * of the instruction, so an instruction casts to one type on every path, and
  * the lowering can be chosen once.
  */
+/*
+ * dst = typed_arena_cast(src, imm) makes a trusted pointer to an object of the
+ * struct imm names out of the value in src. What that takes depends on the
+ * value, and the compiler that inserts the cast at every use of a pointer to
+ * the struct cannot tell, since the same struct lives in typed arenas, in
+ * allocated objects, in map values and on the stack. So the verifier decides
+ * per path. A scalar, a raw arena pointer, or a typed arena pointer that is
+ * unsanitized, of another struct, or moved inside its object is sanitized:
+ * dst becomes a pointer to the start of an object of the struct's typed
+ * arena, and the lowering masks and rebases the value. A sanitized pointer of
+ * that typed arena at offset zero is already what the cast makes, so dst is a
+ * copy of src; the sequence is a no-op on it, which lets such a path share
+ * the instruction with sanitizing ones. Any other verified pointer, to an
+ * allocated object, a map value, the stack, or anything else, is copied as it
+ * is, with its state, offset and references: the cast has nothing to add to
+ * what the verifier already knows, and needs no arena and no registration. A
+ * typed arena pointer that may be NULL, an allocation's result, is one of
+ * these: sanitizing it would turn a failed allocation into object 0, so it is
+ * copied and keeps its check.
+ *
+ * The lowering is per instruction and runs on every path through it, so a
+ * path that copies a verified pointer of another kind cannot share the
+ * instruction with a path that sanitizes: the sequence would mask a pointer
+ * that is not in the slice. Such a program is rejected.
+ */
 static int check_typed_arena_cast(struct bpf_verifier_env *env, struct bpf_insn *insn)
 {
 	struct bpf_insn_aux_data *aux = &env->insn_aux_data[env->insn_idx];
 	struct bpf_reg_state *regs = cur_regs(env);
+	struct bpf_reg_state *src = &regs[insn->src_reg];
 	struct bpf_reg_state *dst = &regs[insn->dst_reg];
 	struct bpf_typed_arena *ta;
 
+	if (src->type != SCALAR_VALUE && base_type(src->type) != PTR_TO_ARENA &&
+	    (!type_is_typed_arena_obj(src->type) || type_flag(src->type) & PTR_MAYBE_NULL)) {
+		if (aux->sanitize_needed) {
+			verbose(env, "insn %d casts values that need different treatment on different paths\n",
+				env->insn_idx);
+			return -EINVAL;
+		}
+		aux->sanitize_plain |= BIT(insn->src_reg);
+		*dst = *src;
+		return 0;
+	}
+
 	/* The arena itself needs CAP_PERFMON, so the leak rules already permit a kernel pointer. */
 	if (!env->prog->aux->arena) {
 		verbose(env, "typed_arena_cast insn can only be used in a program that has an associated arena\n");
@@ -17320,6 +17358,18 @@ static int check_typed_arena_cast(struct bpf_verifier_env *env, struct bpf_insn
 		return PTR_ERR(ta);
 	aux->typed_arena = ta;
 
+	if (src->type == (PTR_TO_BTF_ID | MEM_ARENA) && src->btf_id == ta->btf_id &&
+	    tnum_is_const(src->var_off) && !src->var_off.value) {
+		*dst = *src;
+		return 0;
+	}
+	if (aux->sanitize_plain) {
+		verbose(env, "insn %d casts values that need different treatment on different paths\n",
+			env->insn_idx);
+		return -EINVAL;
+	}
+	aux->sanitize_needed = true;
+
 	mark_reg_known_zero(env, regs, insn->dst_reg);
 	dst->type = PTR_TO_BTF_ID | MEM_ARENA;
 	dst->btf = env->prog->aux->btf;
-- 
2.53.0

