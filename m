Received: from mail-wr2-f10.google.com (mail-wr2-f10.google.com [74.125.225.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9252D3A16B9
	for <bpf@vger.kernel.org>; Sat, 26 Sep 2026 23:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790465723; cv=none; b=bI73M5aTeQTl3Ael//61UMx4VSod9wJgFWE4U952wZy3vsnVrNjxvrVWif1WHp8OciYLzH+INzrwtuhrKn2XG1/fkzMec4rEUf5JC3NFheFGpdsAimRLld6ikj1fxqhGIMhGlZn+CN6wFjPbZpi7M+JdIZm6sdb7h0MQ6hqVDkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790465723; c=relaxed/simple;
	bh=wd5/4gJP8RTe0AViW83QlQ1hQstjiMVwK3UIGK3ozC8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=etu7xUK9oBgd0OZuhkrPnzEgGAu+HalvkdstkaHsWjOUyLu9diG3bTAxxmn3XLpKMVpqiwQLXeLkITdc4rRt4fCLqrY9r+/sIxNg2ky8yt8V0+BK11zHsSgE40I7GHSh0WEMC4jiWFbDOxViCIptQRes0R4k76boTT7WjPjUIww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AyNPZrWe; arc=none smtp.client-ip=74.125.225.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AyNPZrWe"
Received: by mail-wr2-f10.google.com with SMTP id ffacd0b85a97d-484372811e5so588649f8f.0
        for <bpf@vger.kernel.org>; Sat, 26 Sep 2026 16:35:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790465719; x=1791070519; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=do5ZDVvxmmN+614CpafluJsI1iW8B4+p2QLfPJNdRAU=;
        b=AyNPZrWesO3g9fE2Ln5F1NQCrJYmmiaftq+kkLADVGhHsGaxXdfZeyrc/meJti9xEP
         tdLdaMN44rSzp1Qq4gBNJz8Lo0grdvFXfA+yoVcHYH3RwBCqACL8MM1WuG7OJ9R480i1
         9tuIaTP/06U6f196Cufu1okzlDeKSk1QhY80+CghbiQv7okE2aLTZjVkkOVSisJNC9bY
         Lpy5wi106+9lB2BHdEMIw05DZ4n3JniUnOC5aIwHkD42zJfcZVRd8E6bH9Nnqj9PWGhO
         VoGMZDkcmZb84+N8Kei7r/rq9g0eweVsFusQCJKCeXnQmwNi0Bum7iBPJAFcT+fQTlA1
         QP2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790465719; x=1791070519;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=do5ZDVvxmmN+614CpafluJsI1iW8B4+p2QLfPJNdRAU=;
        b=kxJEo6ntm8dxJdikTKSZkMwEI3+XH/gDzDgmB1vwOl6RfCVYc0/idcno1x8FTG80XU
         tbDphG82FCI9K69Ly/JUNJHpRNm5ufC06+4lqxiOOC10dZb0jrHAovaEZmXOlIxEJXk+
         Q5ec27dtKtFcXxeESZUVGgGujorIos4ibOSYnK2rl51ewICUucXFJLLlZuD476ixVNfp
         7NxpTW9eXxhZ0lyTjTAd1aqMkw4dDlK5hUckJzSeumBPUY7zFcLOBihVKFrAChjkI03M
         KQqWoj1md4IWx2ih7YAR4CIB24JBKDLFWMfNwC8GMGezFRHCC5lQUfyZw8jul1I/WGQX
         8OZg==
X-Gm-Message-State: AFuF++m2b2ynKZv4AjfBwDwB0rI5d5AKad6HfB+sPhbEWEj9rynzI2lx
	Fc+NlKYIRql2EseEmuz2Hm+TLeEb6LQiTWdLkTKhth+bAtbKRYA9QTg+h2FggSqS
X-Gm-Gg: AYBFou1tV+YGFLmQcBsKw48i1mpO/J33Kf/X4d5AQVcKuJzZwAG41oYKAanJZ3h8SAw
	bKy3xzVoq2ZLu/O5FB+nuoHcfqLsVgtp+lI2jn6xi11MwJsJ3ooWn85LApoaK9Zoa/Ld/y3SG35
	KCt5qDR/1YCl/L8Yzv57Kf+0nv3exS3eWNeDu0+I5s4Ex/4eHA8/OtAQrmX1YrjUTe9FVURebIz
	bZwoJqqSLynoilDTsbCiXubWyv0tEQU/mVjTx4BD4JEsA4wRUrajyrpLCRsEySTN8sQbxbnO62N
	e2zYsED/9TO71un23cumMvXTF5OVZ9MGJGhoHM6bA7y9Hb5rO8m1YRtDSUP3bfagYzfvyBxuMSF
	zavTocGaQ1JR+kguUr9StfmTzYEuQgoIz3jl+dnUDU2jpojUjR7ZKWpz5A1Iijbj2/xDKxrBRgU
	lArZOd0ZjNXvpc+az0pKK1PDuuNKRzRkXI4QqlMRuxvBhExLGeDvCBuUcwAOL9db5PYDxK+iK6/
	9HbWAXqPZNOvG6kXTA22oFTO2LlYZyZXV2yq8nPhFSp1TcTL5MZSxCCdov5ePh7aN89R7+SmEDE
	3RSRQcvPf9andR/HEKPD2L4fctPe46gQT2rnQg==
X-Received: by 2002:a05:600d:486:20b0:49f:e8bf:221a with SMTP id 5b1f17b1804b1-49fe8bf24fbmr118351675e9.22.1790465719344;
        Sat, 26 Sep 2026 16:35:19 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fef60cc72sm103921155e9.3.2026.09.26.16.35.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2026 16:35:18 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [RFC PATCH bpf-next v1 08/16] bpf: Canonicalize loaded typed arena pointers where they are used
Date: Sun, 27 Sep 2026 01:34:46 +0200
Message-ID: <20260926233503.3114147-9-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260926233503.3114147-1-memxor@gmail.com>
References: <20260926233503.3114147-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=10548; i=memxor@gmail.com; h=from:subject; bh=wd5/4gJP8RTe0AViW83QlQ1hQstjiMVwK3UIGK3ozC8=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIWtHWJzpL/WJD2d4hq7q2VFz6yVrIN+hdDOvQysnyjKu8 xY6domzo5SFQYyLQVZMkaXk/z4m4xOVvwNtl3HDzGFlAhnCwMUpABPZ/YqR4UbLuYO3lzBE6iQ4 n0lTKk/vjik6O3H2usL4fzsa5c+G2jP8T6ho8/MXWsNcFnTIXO+l3sKZK+++NQ6yOqj/0vkP2z8 7HgA=
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

A typed arena pointer loaded from a typed pointer field is an object of its
type or 0, but it is not canonical: nothing masked it into its slot, and it
may be 0. The previous patch refused to use it as an address. Sanitize it
instead where it is used, in place: when an instruction loads or stores
through such a pointer, or an atomic runs on it, when arithmetic moves it,
or when it goes to a helper or kfunc, the lowering prepends the typed
arena's cast sequence to that instruction, on that register, and on that
path the register is canonical from then on. Compares, copies, spills and
stores of the value as a value need nothing, so a list is walked with plain
loads and ends with the usual test against 0, and a pointer that is only
passed along is never touched.

This is the whole of the NULL question. The field's discipline says the
value is an object or 0. A program that tests for 0 sees the raw value and
takes its branch. A program that does not test, or tests wrongly, uses the
value as an address, the sequence maps 0 to object 0 of the slice, and the
access lands on a whole object of the type, the same outcome as feeding 0
to a cast. Nothing the program does with the value can reach outside the
slice, so the verifier asks for no annotation and no check: the SFI scheme
decides the result, not the type system, and a NULL check is a matter of
program logic alone. The alternative, a maybe-NULL pointer type that must
be checked before every use, would put a check on every hop of a
traversal that the sanitization makes unnecessary.

The sequence is lowered once per instruction and runs on every path through
it, so it must be harmless on every path. It is idempotent on a canonical
pointer of the same typed arena at offset zero, which is what a path that
got its pointer from a cast or from an earlier sanitization brings. It is
wrong on a pointer with an offset into its object, since the mask rounds to
the object base, on a pointer of another typed arena, whose base and mask
differ, and on any other value. So the verifier records the register and
its typed arena in the instruction's aux data when a path needs the
sequence, and rejects the program when another path brings that register
in a form the sequence would corrupt, or when a second register needs it at
the same instruction, which no compiler-generated code does. Arithmetic
sanitizes before it moves the pointer for the same reason: the offset must
be added to the object base, not masked away later.

The later optimization phase builds on the unsanitized form: a load through
such a pointer that nothing writes to can be a probed load instead of a
sanitized one, and a chain of reads then costs nothing beyond the loads. A
store of a typed pointer into a typed object always sanitizes its
destination, since the field's discipline depends on the store landing in a
real object.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 include/linux/bpf_verifier.h | 10 +++++
 kernel/bpf/fixups.c          | 38 +++++++++++++------
 kernel/bpf/verifier.c        | 71 ++++++++++++++++++++++++++++++++----
 3 files changed, 99 insertions(+), 20 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 77e7c4b45a1f..bf0f23929671 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -662,6 +662,16 @@ struct bpf_insn_aux_data {
 	};
 	struct btf_struct_meta *kptr_struct_meta;
 	struct bpf_typed_arena *typed_arena; /* named by a cast or a typed arena kfunc call */
+	/*
+	 * Lazy sanitization of a typed arena pointer used as an address here:
+	 * the register and its typed arena, whether a path brought the pointer
+	 * unsanitized, and the registers some path brought in a form the
+	 * sanitizing sequence would corrupt.
+	 */
+	struct bpf_typed_arena *sanitize_arena;
+	u16 sanitize_plain;
+	u8 sanitize_reg;
+	bool sanitize_needed;
 	u64 map_key_state; /* constant (32 bit) key tracking for maps */
 	int ctx_field_size; /* the ctx field size for load insn, maybe 0 */
 	u32 seen; /* this insn was processed by the verifier at env->pass_cnt */
diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
index 0b4636498ddc..fd0ba8376c1c 100644
--- a/kernel/bpf/fixups.c
+++ b/kernel/bpf/fixups.c
@@ -877,27 +877,41 @@ int bpf_opt_subreg_zext_lo32_rnd_hi32(struct bpf_verifier_env *env,
  *     struct bpf_sock_ops -> struct sock
  */
 /*
- * Replace every typed_arena_cast with the sanitizing sequence of the typed
- * arena the verifier registered for it. The type is part of the instruction,
- * so a cast has exactly one typed arena by the time it gets here.
+ * Lower the instructions the verifier tied to a typed arena. A typed_arena_cast
+ * becomes the sanitizing sequence of the typed arena the verifier registered
+ * for it; the type is part of the instruction, so a cast has exactly one. An
+ * instruction that uses a typed pointer loaded from a typed pointer field as
+ * an address gets the same sequence prepended, in place on that register: the
+ * verifier checked that every path brings that register here as an
+ * unsanitized pointer of that typed arena, or as a canonical one at offset
+ * zero, on which the sequence is a no-op.
  */
 int bpf_lower_typed_arena_insns(struct bpf_verifier_env *env)
 {
 	struct bpf_insn *insn = env->prog->insnsi;
 	int i, cnt, delta = 0, insn_cnt = env->prog->len;
-	const struct bpf_typed_arena *ta;
-	struct bpf_insn insn_buf[8];
+	struct bpf_insn insn_buf[16];
+	struct bpf_insn_aux_data *aux;
 	struct bpf_prog *new_prog;
 
 	for (i = 0; i < insn_cnt; i++, insn++) {
-		if (!insn_is_typed_arena_cast(insn))
-			continue;
-		ta = env->insn_aux_data[i + delta].typed_arena;
-		if (!ta) {
-			verifier_bug(env, "typed_arena_cast at insn %d has no typed arena", i);
-			return -EFAULT;
+		aux = &env->insn_aux_data[i + delta];
+		cnt = 0;
+		if (aux->sanitize_needed)
+			cnt = bpf_typed_arena_cast_insns(aux->sanitize_arena, aux->sanitize_reg,
+							 aux->sanitize_reg, insn_buf);
+		if (insn_is_typed_arena_cast(insn)) {
+			if (!aux->typed_arena) {
+				verifier_bug(env, "typed_arena_cast at insn %d has no typed arena", i);
+				return -EFAULT;
+			}
+			cnt += bpf_typed_arena_cast_insns(aux->typed_arena, insn->dst_reg,
+							  insn->src_reg, insn_buf + cnt);
+		} else if (cnt) {
+			insn_buf[cnt++] = *insn;
 		}
-		cnt = bpf_typed_arena_cast_insns(ta, insn->dst_reg, insn->src_reg, insn_buf);
+		if (!cnt)
+			continue;
 		new_prog = bpf_patch_insn_data(env, i + delta, insn_buf, cnt);
 		if (!new_prog)
 			return -ENOMEM;
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 5ca5fc4696d9..2d406034556e 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -383,20 +383,75 @@ static bool reg_not_null(struct bpf_verifier_env *env, const struct bpf_reg_stat
 }
 
 /*
- * @regno is about to serve as an address, or go to a call. A typed arena
- * pointer loaded from a typed pointer field is not canonical yet: its slice
- * and slot are what the field's discipline promises, not what the lowering has
- * masked, and until the lowering learns to sanitize it in place such a use is
- * refused.
+ * @regno is about to serve as an address, be moved by arithmetic, or go to a
+ * call. A typed arena pointer loaded from a typed pointer field is not
+ * canonical: it is an object of its type or 0, as the field's discipline
+ * promises, but nothing masked it into its slot. Sanitize it here, in place:
+ * the lowering prepends the typed arena's cast sequence to this instruction,
+ * and on this path the register is canonical from here on. The sequence maps
+ * 0 to object 0 of the slice, as the cast maps any value, so a NULL the
+ * program did not test costs no more than a stray cast would.
+ *
+ * The sequence is lowered once per instruction and runs on every path through
+ * it, so it must be harmless on every path. It is a no-op on a canonical
+ * pointer of the same typed arena at offset zero, and wrong on anything else:
+ * a path that brings another typed arena, a pointer with an offset into its
+ * object, or a value of another kind to this register here is rejected, and
+ * so is a second register in need of the sequence at the same instruction.
+ * Where nothing brings an unsanitized pointer, nothing is lowered.
  */
 static int typed_arena_use(struct bpf_verifier_env *env, int regno)
 {
+	struct bpf_insn_aux_data *aux = &env->insn_aux_data[env->insn_idx];
 	struct bpf_reg_state *reg = &cur_regs(env)[regno];
+	struct bpf_typed_arena *ta;
+	bool canonical;
+
+	canonical = !(type_flag(reg->type) & PTR_UNSANITIZED);
+	if (!type_is_typed_arena_obj(reg->type) ||
+	    (canonical && (!tnum_is_const(reg->var_off) || reg->var_off.value))) {
+		if (aux->sanitize_needed && aux->sanitize_reg == regno) {
+			verbose(env, "insn %d sanitizes a typed arena pointer only on some paths\n",
+				env->insn_idx);
+			return -EINVAL;
+		}
+		aux->sanitize_plain |= BIT(regno);
+		return 0;
+	}
 
-	if (!type_is_unsanitized_arena_obj(reg->type))
+	ta = bpf_prog_typed_arena(env->prog->aux, reg->btf_id);
+	if (verifier_bug_if(!ta, env, "R%d typed arena pointer has no typed arena", regno))
+		return -EFAULT;
+	if (aux->sanitize_arena && aux->sanitize_reg == regno && aux->sanitize_arena != ta) {
+		verbose(env, "insn %d sanitizes typed arena pointers of different types on different paths\n",
+			env->insn_idx);
+		return -EINVAL;
+	}
+	if (aux->sanitize_arena && aux->sanitize_reg != regno) {
+		if (canonical)
+			return 0;
+		if (aux->sanitize_needed) {
+			verbose(env, "insn %d needs more than one typed arena pointer sanitized\n",
+				env->insn_idx);
+			return -EINVAL;
+		}
+		/* A canonical pointer only booked the register; the one in need takes it. */
+		aux->sanitize_arena = NULL;
+	}
+	if (!aux->sanitize_arena) {
+		aux->sanitize_arena = ta;
+		aux->sanitize_reg = regno;
+	}
+	if (canonical)
 		return 0;
-	verbose(env, "R%d unsanitized typed arena pointer cannot be dereferenced\n", regno);
-	return -EACCES;
+	if (aux->sanitize_plain & BIT(regno)) {
+		verbose(env, "insn %d sanitizes a typed arena pointer only on some paths\n",
+			env->insn_idx);
+		return -EINVAL;
+	}
+	aux->sanitize_needed = true;
+	reg->type &= ~PTR_UNSANITIZED;
+	return 0;
 }
 
 static struct btf_record *reg_btf_record(const struct bpf_reg_state *reg)
-- 
2.53.0

