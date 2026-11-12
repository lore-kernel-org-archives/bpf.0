Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794498875;
	b=XMBzQQ5WeYyiA0EPWS5otv/31XSgWJ1VHxFmt4HjstIgZqVAfnwj35u7fwGTC0FxRhvi
	 qfr/8EPhmFCIA9k9zDy3pS9ZfEmDAdWsQdy/D19UpcKqHNK3Cr5ryqw1oSqQe0Vz7TWQj
	 48YoX28EY5GAMFWNHYMI2P0DeDAXQJ7+zc3caVaSjPjIwVjWpIy5efzle/8haD6NYZCWX
	 g87qOQemvLfqp1mTwhq18287n2+TjxLYhAX7jmb5614OzN9yNrJvs0sswqLvWXNxT+S0b
	 fmuQ0ceuM9WmohIKChkhJHSAbEp/tzddK3oOZ4qWwgnTl5j/XDLcaL8rC1lCE/5z1xQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794498875;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=LzLsLO+2G2mLGcXsoPeDJvZ5ZaSjG/RP0/EP2rwgcNw=;
	b=MnswTJBRz3RbjBWBt0pSiILxpY2HraHl6kpXPv5lzF0BO2nwhxRIe1zOFZQxE40IvJZO
	 6r/5hcpqpIRZ+YZM42utJnkKMCJ4ut9UswVxDN51SE1tJjFwQJI9TUHg6osU5BtAoiZNt
	 pkX0A7RXYXHeVq2xcxdcM4w+2oClhQ6eQ1l4n8UJi1ckRL4gaQmNK9VlFAO861MBCrNVo
	 8Xrdw9xURHkIqdd/t38wyhvKwDQA6IF5AsBD6IIWI94c8irnY1aryueRk2C7r4pmawHgS
	 EpJGwN/bsxqqRgDSSlAsi0WTRupd5Wjgft4Z+FJu1pjxUow/elIxzk4vEbWTsSHaTdw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kJ4Z1Z9o;
	arc=none smtp.remote-ip=209.85.216.52
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04FB6606A31C
	for <bpf@vger.kernel.org>; Thu, 12 Nov 2026 15:54:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 04FB6606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kJ4Z1Z9o
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-3ad41b47541so2906355a91.1
        for <bpf@vger.kernel.org>; Thu, 12 Nov 2026 07:54:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794498874; x=1795103674; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LzLsLO+2G2mLGcXsoPeDJvZ5ZaSjG/RP0/EP2rwgcNw=;
        b=kJ4Z1Z9oXLPl1N0Y5WUzOmq6CcyWsaga5Hj3x3LL4a2BF0+dgZEgu+IL6OFYd9MngG
         s0HmO8fftTAY6nNOl2BzE6uS2cstTDprIxSrXV4y+O3ukbSyWBM+Oz4E+yzBWd83aY+Y
         ThJMAhRlo3adHUsTz5WIcX5hanb6We9KRkw3C0GOpw+MdKrr1WmlvEAKZ4bVuT2mcjYd
         bXpcYaIJemS2vvsGr2fo3B5R4nVb7sUPcjST4dR/6YSLKRAGcKtgKvScMhev/ViSxUfw
         YnfK7RL3CdN23JfvQn/tmSjKRe6ZJA9SD06IYUEU9r8b+NK2q0mDgFbvDAo3Bg4SlUiW
         7xnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794498874; x=1795103674;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=LzLsLO+2G2mLGcXsoPeDJvZ5ZaSjG/RP0/EP2rwgcNw=;
        b=PVH6hd9+t/bruyxdmjCjrXCLzT0xFMHMsGsMNl5PlEj9Sbj2JLvLJoRFouRZ+8KKbm
         jXInmPIB2woFxDY/Lntx8aa+/2K0VQxskMbnMfMSVjVzZbyXdhldVJKX2IJdwoKUvGXC
         2PztEcDxaHvSB13Mvr9zp4M4WQqgUjUbKRzNnlRC9K4rj/ZgSp3rZZlV9OD6OkbffcoK
         gVfN80Zuk2MJziBh6AFk9GRN9HN63DHPU2Q2bGun4CWaMm+A/JfoBdSrJo1hlNw4uEzg
         +MVx5wTtM6UpYnDZw6N5kevqtbM/GkBYg48FcbvDsX5SVg5AJVxF2JLHCRp5t7QGA2Kh
         MDRg==
X-Gm-Message-State: APuU4Z9LLbWbrnStroWHcd/DxG5New/1xFi9r6SBmA78jcKCWNIDqasz
	OieMsAoR9K6aLzHGcxbJqp/jzlkaH3AG1td9golg3YChHCp8uTf/YmOKjKUGvw==
X-Gm-Gg: AYBFou080kqNyNPM7YBxGEwPN6Jfqv+rgO9dLLXPWQ1n1KDJwXctT28CmngO1BoxBSO
	ty/06u6e7cbrfSMfJM308ALE/bZmOzebL3tpgvvJXhbGSvR7t3wBA7YCJJynC8SKlZXR0R+Kh3r
	IzASWfrGKdMVoLK88VoSLL0nbCtqoFOsvZA7YTK5OTNrxvY12XMkEHWhtnvzr2xYfUZs4ISGFzS
	TfoPzvV2ugFFjq42kD3m3qnNRc9j0MoQYdKDS5eoTcV0r2RvwL4ejZwFofbIiNucZ/ouFm3Zz0Z
	YU/b1UEUVPor58SW4uYOIYc99O/WIYsfRb2gvHbxgtIsPW7+CfkGHbSyAs+3g4kYlJmwnHP/0U6
	Kb53mjx5Yiz3SWW8FcIRhGNbWdwEvjUG597tHbqL5pUDz/NxE4CYI+biJcbQ2guSRXnwp0KfWD8
	fQWfJHh6g61Mbi89xEDSnog+Bl1QdEwRCa+hSy/FkFHhKgIpMQkh65J/g5IP83mU0D8O5KvWEkq
	QEQ/0MyVUNmpOjpcwiFmC4l6vRe8QkSdBsL/PB598CSGHKS5jJSyMlpB2L53jNS9OKg6Q+8jX5I
	Byvw5BfQY0yGiUnLbmUUauFImLZZbyBG/a3OVO1FSi5GRyeHSeZf2rOcN+r2guNVStN7j6akI7b
	iqxjmH8pHfOLvV7LyOO407MKFcHu/W2vpE2qb32OO8ECh6g6r6M/lwo5mLOkJs9H5EyuyOfY6mC
	A=
X-Received: by 2002:a17:90b:5405:b0:3ac:9c37:9430 with SMTP id 98e67ed59e1d1-3b182e6f7c4mr5766421a91.21.1794498874005;
        Thu, 12 Nov 2026 07:54:34 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.243])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b197d257a0sm5308099a91.11.2026.11.12.07.54.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 07:54:33 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next 09/12] bpf: Add scalar_intersect()
Date: Thu, 12 Nov 2026 15:53:34 +0000
Message-ID: <20261112155337.1040699-10-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261112155337.1040699-1-alexei.starovoitov@gmail.com>
References: <20261112155337.1040699-1-alexei.starovoitov@gmail.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

	r1 = r6
	r1 &= 255
	if r1 > 29 goto out
	/* r6 is used */

Scalar evolution tells refine_linked_regs() that r6 and r1 are equal in
their low 8 bits. For other registers it is 16, 32 or 64 bits. The function
intersects the two by hand: are they equal in all bits because both fit, do
the known bits overlap, the 32-bit ranges, the 64-bit ranges, the
reduction, and back to the saved register if nothing is left.

The next patches compute the value of an expression in scev.c. A value can
be known from more than one source there, what a register holds and what
the operands give, in a number of bits each. The sources are intersected by
the same rules.

Move the rules into scalar_intersect(dst, src, bits), an operation on
struct scalar like scalar_add() and scalar_alu(). No functional change.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 include/linux/bpf_verifier.h |  1 +
 kernel/bpf/verifier.c        | 70 ++++++++++++++++++++++--------------
 2 files changed, 45 insertions(+), 26 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 15528f3a352e..516e704c3d7d 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -2071,6 +2071,7 @@ void scalar_set_const(struct scalar *s, u64 imm);
 void scalar_add(struct scalar *dst, const struct scalar *a, const struct scalar *b);
 void scalar_alu(struct scalar *dst, const struct scalar *src, const struct bpf_insn *insn);
 void scalar_zext32(struct scalar *s);
+bool scalar_intersect(struct scalar *dst, const struct scalar *src, u32 bits);
 void scalar_union(struct scalar *acc, const struct scalar *src);
 int bpf_set_reg_range(struct bpf_verifier_env *env, struct bpf_reg_state *reg,
 		      const struct scalar *range);
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 9721530636e3..47ed36292e1b 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -19394,6 +19394,46 @@ static bool scalars_fit_in_bits(const struct scalar *a, const struct scalar *b,
 		cnum64_smin(b->r64) >= -smax - 1 && cnum64_smax(b->r64) <= smax);
 }
 
+/*
+ * The values of @dst and @src are equal in their low @bits bits: @dst becomes the intersection.
+ * False: @dst is left as it is. Fewer than 32 bits say nothing about a range. Or the intersection
+ * is empty: no execution gets here with these values, the path is infeasible.
+ */
+bool scalar_intersect(struct scalar *dst, const struct scalar *src, u32 bits)
+{
+	struct tnum a = dst->var_off, b = src->var_off;
+	struct scalar s = *dst;
+
+	if (scalars_fit_in_bits(dst, src, bits))
+		bits = 64;
+	if (bits < 32)
+		return false;
+	if (bits < 64) {
+		a = tnum_subreg(a);
+		b = tnum_subreg(b);
+	}
+	/* tnum_intersect() of two tnums that don't overlap is not empty */
+	if (!tnum_overlap(a, b))
+		return false;
+	/*
+	 * Equal in 64 bits is equal in the low 32 bits too. 'if w1 s> 200' on a zero extended int
+	 * refines nothing but the 32-bit range.
+	 */
+	s.r32 = cnum32_intersect(dst->r32, src->r32);
+	if (bits == 64) {
+		s.r64 = cnum64_intersect(dst->r64, src->r64);
+		s.var_off = tnum_intersect(a, b);
+	} else {
+		s.var_off = tnum_with_subreg(dst->var_off, tnum_intersect(a, b));
+	}
+	scalar_bounds_sync(&s);
+	if (scalar_is_empty(&s) || const_tnum_range_mismatch(&s) ||
+	    const_tnum_range_mismatch_32(&s))
+		return false;
+	*dst = s;
+	return true;
+}
+
 /*
  * The state of the SCEV register @r. As in check_stack_read_fixed_off() a fill of @bits bits from
  * byte @fill_off of the slot reads the low bits of the spill.
@@ -19494,7 +19534,7 @@ static void refine_linked_regs(struct bpf_verifier_env *env, struct bpf_verifier
 			       int idx, u32 regno)
 {
 	struct bpf_func_state *frame = vstate->frame[vstate->curframe], *linked_frame;
-	struct bpf_reg_state *reg, *base_reg, implied, saved;
+	struct bpf_reg_state *reg, *base_reg, implied;
 	u32 pos, linked_regno, fill_off, bits;
 	int base_regno;
 	s64 delta;
@@ -19527,33 +19567,11 @@ static void refine_linked_regs(struct bpf_verifier_env *env, struct bpf_verifier
 		add_scalar_to_reg(&implied, delta);
 		if (base_regno >= 0) {
 			base_reg = scev_reg_for_fill(frame, base_regno, 0, 64);
-			if (base_reg && bits == 64 && recompute_ptr(env, reg, base_reg, &implied))
-				goto scratch;
-			continue;
-		}
-		if (scalars_fit_in_bits(scalar_of(reg), scalar_of(&implied), bits))
-			bits = 64;
-		if (bits < 32)
-			continue;
-		/* tnum_intersect() of two tnums that don't overlap is not empty */
-		if (!tnum_overlap(bits == 32 ? tnum_subreg(reg->var_off) : reg->var_off,
-				  bits == 32 ? tnum_subreg(implied.var_off) : implied.var_off))
-			continue;
-		saved = *reg;
-		/*
-		 * Equal in 64 bits is equal in the low 32 bits too. 'if w1 s> 200' on a zero
-		 * extended int refines nothing but the 32-bit range.
-		 */
-		scalars_refine_cond_op(scalar_of(reg), scalar_of(&implied), BPF_JEQ, true);
-		if (bits == 64)
-			scalars_refine_cond_op(scalar_of(reg), scalar_of(&implied), BPF_JEQ, false);
-		reg_bounds_sync(reg);
-		if (reg_is_empty(reg) || const_tnum_range_mismatch(scalar_of(reg)) ||
-		    const_tnum_range_mismatch_32(scalar_of(reg))) {
-			*reg = saved;
+			if (!base_reg || bits < 64 || !recompute_ptr(env, reg, base_reg, &implied))
+				continue;
+		} else if (!scalar_intersect(scalar_of(reg), scalar_of(&implied), bits)) {
 			continue;
 		}
-scratch:
 		if (linked_regno < MAX_BPF_REG)
 			mark_reg_scratched(env, linked_regno);
 		else if (linked_frame == frame)
-- 
2.55.0

