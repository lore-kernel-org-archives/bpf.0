Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794442133;
	b=ibpvp34r40rtNm57/K1HJKh/99tZKUtwuFtspOpccZ/jeBvj9OSPI7C76V4HQ4t2n6gS
	 yuA1VJRcbRI0LRMYEuLJTDPtJCf3rSipyjC0phko/rwLQTUC7e12MCGBKOTnbHe9n+MPe
	 rQ3f3ZPkq3rmlNBUvtuskgyjpX8xRV/t4uCBfYur2k24b5NwBaDrpR9Ku9UE1JOuH7TEV
	 yVNFU5zOn3N2KkO5noRIVKkSRAb18KtLP/oas+ty1QukpwEssvVs6tvDNm77DiKJkCcDy
	 xINyokTMtocPkTy8oAXUgZbAAFFsCKAG2ZF2CZhv05DlO7D6yu4w4IFeY6X75z5b42w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794442133;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=4IqfiLjrtZK0Vc6Kqn07lwCGDYJ5+QU+VRyPbGGpiIU=;
	b=353lLF8ia+I/l8Ku9lkhiWJ6W+iBeucN6ZECK5UnijYM7BofKeIjLiQaM7Quk8zU0xT/
	 t3aU+Ix0xPoQ9MWpOa94RyRyrZ19hA3jtaHS1/ZUeQK5tJomFjRgbpk+T3hmthrrwXZDW
	 sXAtkQSrOqCHxO8KPmqiWfpJhzlO0ArO6qOubsgh9tuPUfMaacquCOlRhN7mqF6ehSmaI
	 FfOzBTUgKi527Ig38sUURB5D+yvHk+I6UXoLXpnMzeRTbtY5GIgAu5LM8TGPH/X9bA3OW
	 wgeO9uxe5sje1uK8exE4NOfrbEKzRJjbOPzkvDgo7O0WHPJ633RXpZ9g9hwPClARXUg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=eDwBrqip;
	arc=none smtp.remote-ip=209.85.210.182
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E84DD606A31C
	for <bpf@vger.kernel.org>; Thu, 12 Nov 2026 00:08:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E84DD606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=eDwBrqip
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-8b5a6f2f27fso1469272b3a.3
        for <bpf@vger.kernel.org>; Wed, 11 Nov 2026 16:08:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794442132; x=1795046932; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4IqfiLjrtZK0Vc6Kqn07lwCGDYJ5+QU+VRyPbGGpiIU=;
        b=eDwBrqipAzHulx/sqNghaags/UFAS09g4h2wU1Bt0jd6daupYthIkGRK+UnEIZDLC5
         CZJgRn3Ps0tL0HJkB4F1OPM+oJnYWVEwZzrpXfbp1riIqu2ykXD2o9pXZrszPdjj/LO+
         zJ/lIj/PULWm7MNrrl/Wz1BLU1jDKHsDMP8z+hGIB9DO5DDeRv6/EKUqz1HbtGJxgLXg
         xhEHzo6332uEnwpfWxn4O8f/lKoQkrftmtFNBRyFyIX5Tw8R7HG5uqh5ug/xppzOEZnL
         abZKpUh7SRoblLhblczkPyGZPv/4Dd0IOSy8+zpR+DUMmXoFFvD+QZJ1hqiXwJeT8m3j
         WV7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794442132; x=1795046932;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=4IqfiLjrtZK0Vc6Kqn07lwCGDYJ5+QU+VRyPbGGpiIU=;
        b=XwzuXqAFrl+bQG+l7BC833qOD54Fww0hOkQS+8kO0fQdELzzDp4a+dH83N/oQHS0Q8
         ymcKwRmmQ74BaBE6xwhqDR+u11akoC8SlSmWA6UCNBS1uCoY+fKcYal25LGBYQjVP2Ly
         LL+IEsuWRk8szXMwu7H6m1X+7fNrRbL17TcDrhLRkyWqk4E3ZJChB3v4LqXk3iwVtwJv
         JhUGhFfCuUm5eytpg5GZdcuDpPphZKEX5DFDBn8dlQp4dDweqScaWX95LE7Pi7SRB5Uc
         lZXWSZLxf/5ldp4xmFSDDphGLw7S7vxIIx6kqbJsVRjQlVtDaEP9hHf+iQePR6tLoAJo
         bFig==
X-Gm-Message-State: APuU4Z8WdJt3yh/fsDIKdiVJCeFI200G8z0QLXN2GkOiWrfF08uxry4A
	6aXGyl+K+Jv7x/Z0VAcBKxT2374x/FPq6wG+xPSLLuJ9XRVMzQ4za6hWdZwO2A==
X-Gm-Gg: AYBFou2jBbNB2a0rDNKpsgKakFsPuXNMHr+jsKCaYRefcVVgMS5uaOEZOZ+WWe9FwCy
	nVGWJ7Kyhwh7cnSANTiabIo86CfHYOiyRxH9P/yBgBhZYFYjVnn2CDRr++/RdVTx+91FTf9fHkn
	tpa870iS4HPEBuui+ZJZRycLb8SmYifPPwF/+Lb9IAL4cGoUgMVcfG25pfeODhgt/nMorBncwXY
	rYUjXZj8/zPMyiZEdkog2gzt4sqeckH2q9WyxI+/HZJa19ZxxuJFlU/D3T5pOkW2QH5tOjZze+f
	sRZzjUjr8lG+2f+JSAGH38hOJORevp1ZEnIkDyZA3ozwoeQ6UHxCWtN/brd2AsBwt3hbT0JbBRc
	h/QZXaznlsLVYahqPFnHjR5mt21WNXLgsN3tvcdwjnuXa1q7kOEzkHZRvMRRApNMq8qAYCKZTmj
	+GvsA0WaV1RmKT/KBdoGOARC9qF0HsOCjZyUN52Fed6rmnP+TzRhjTooh/Cd6gwbvCVFnTcSq5r
	82zM06V6KjoPSh70fzM1vPjvV6imZOMNhEBaaPf+YegvZYmr+dgVcuk+lMbNCmjub9kW9JNcz6S
	8Pw7KWYh2IELBAhJVViktRLm6Qeh6c+ej8QAouUJdfU/6z4BoLvCMxyOpXOGB30YPqonIfFC9aO
	3BJ50/ZIPKGQOItGqgbtf2ZTrLOXK5ot/ukmz8JPcGr338oeR/PZLZzGAWfXFXGLDl1p2nb1qAw
	==
X-Received: by 2002:a05:6a21:a45:b0:3e8:b7fd:626c with SMTP id adf61e73a8af0-3f2fd69dd40mr4286116637.20.1794442132053;
        Wed, 11 Nov 2026 16:08:52 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.253])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8baaac46b20sm2639969b3a.30.2026.11.11.16.08.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 16:08:50 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next v2 2/7] bpf: Add const, sub, zext32 and sext32 operations to cnum
Date: Thu, 12 Nov 2026 00:08:30 +0000
Message-ID: <20261112000836.3138846-3-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261112000836.3138846-1-alexei.starovoitov@gmail.com>
References: <20261112000836.3138846-1-alexei.starovoitov@gmail.com>
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

A register is a cnum64 and a cnum32. scev.c does not compute with them:
struct scev_value has the eight bounds umin .. s32_max and adds them by
hand, with four checks for wrap-around. [-1, 0] + 1 is 'any number' as
an unsigned range, and [0, 1] as a cnum. A later patch moves scev.c to
cnum. These operations are missing or open coded:

 - cnum{32,64}_const(v). verifier.c has cnum{32,64}_from_urange(imm, imm)
   in three functions.
 - cnum{32,64}_sub(a, b). verifier.c has
   cnum{32,64}_add(a, cnum{32,64}_negate(b)) in three functions.
 - cnum64_zext32(), cnum64_sext32(). They move from scev.c to cnum.c.

Convert the users. ___mark_reg_known() follows when it moves to struct
scalar.

Like add, negate and intersect the two extensions now give an empty range
for an empty range. They gave [0, U32_MAX] and all of s64. Their user,
linear_bounds(), has no empty range to pass. No other functional change.

Suggested-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 include/linux/cnum.h   |  6 ++++++
 kernel/bpf/cnum.c      | 19 +++++++++++++++++++
 kernel/bpf/cnum_defs.h | 11 +++++++++++
 kernel/bpf/scev.c      | 10 ----------
 kernel/bpf/verifier.c  | 12 ++++++------
 5 files changed, 42 insertions(+), 16 deletions(-)

diff --git a/include/linux/cnum.h b/include/linux/cnum.h
index 49160318adf9..bf514cc0a098 100644
--- a/include/linux/cnum.h
+++ b/include/linux/cnum.h
@@ -33,6 +33,7 @@ struct cnum32 {
 #define CNUM32_UNBOUNDED ((struct cnum32){ .base = 0, .size = U32_MAX })
 #define CNUM32_EMPTY ((struct cnum32){ .base = U32_MAX, .size = U32_MAX })
 
+struct cnum32 cnum32_const(u32 v);
 struct cnum32 cnum32_from_urange(u32 min, u32 max);
 struct cnum32 cnum32_from_srange(s32 min, s32 max);
 u32 cnum32_umin(struct cnum32 cnum);
@@ -49,6 +50,7 @@ bool cnum32_is_const(struct cnum32 cnum);
 bool cnum32_is_empty(struct cnum32 cnum);
 struct cnum32 cnum32_add(struct cnum32 a, struct cnum32 b);
 struct cnum32 cnum32_negate(struct cnum32 a);
+struct cnum32 cnum32_sub(struct cnum32 a, struct cnum32 b);
 bool cnum32_is_subset(struct cnum32 outer, struct cnum32 inner);
 
 /* Same as cnum32 but for 64-bit ranges */
@@ -60,6 +62,7 @@ struct cnum64 {
 #define CNUM64_UNBOUNDED ((struct cnum64){ .base = 0, .size = U64_MAX })
 #define CNUM64_EMPTY ((struct cnum64){ .base = U64_MAX, .size = U64_MAX })
 
+struct cnum64 cnum64_const(u64 v);
 struct cnum64 cnum64_from_urange(u64 min, u64 max);
 struct cnum64 cnum64_from_srange(s64 min, s64 max);
 u64 cnum64_umin(struct cnum64 cnum);
@@ -76,9 +79,12 @@ bool cnum64_is_const(struct cnum64 cnum);
 bool cnum64_is_empty(struct cnum64 cnum);
 struct cnum64 cnum64_add(struct cnum64 a, struct cnum64 b);
 struct cnum64 cnum64_negate(struct cnum64 a);
+struct cnum64 cnum64_sub(struct cnum64 a, struct cnum64 b);
 bool cnum64_is_subset(struct cnum64 outer, struct cnum64 inner);
 
 struct cnum32 cnum32_from_cnum64(struct cnum64 cnum);
+struct cnum64 cnum64_zext32(struct cnum32 cnum);
+struct cnum64 cnum64_sext32(struct cnum32 cnum);
 struct cnum64 cnum64_cnum32_intersect(struct cnum64 a, struct cnum32 b);
 struct cnum64 cnum64_intersect_linear(struct cnum64 in, u16 base, u16 step);
 
diff --git a/kernel/bpf/cnum.c b/kernel/bpf/cnum.c
index 8ec5187d7c75..21bb6411cfb8 100644
--- a/kernel/bpf/cnum.c
+++ b/kernel/bpf/cnum.c
@@ -23,6 +23,25 @@ struct cnum32 cnum32_from_cnum64(struct cnum64 cnum)
 		return (struct cnum32){ .base = (u32)cnum.base, .size = cnum.size };
 }
 
+/* The zero extension of each value of 'cnum'. An arc that crosses U32_MAX/0 gives [0, U32_MAX]. */
+struct cnum64 cnum64_zext32(struct cnum32 cnum)
+{
+	if (cnum32_is_empty(cnum))
+		return CNUM64_EMPTY;
+	return cnum64_from_urange(cnum32_umin(cnum), cnum32_umax(cnum));
+}
+
+/*
+ * The sign extension of each value of 'cnum'.
+ * An arc that crosses S32_MAX/S32_MIN gives [S32_MIN, S32_MAX].
+ */
+struct cnum64 cnum64_sext32(struct cnum32 cnum)
+{
+	if (cnum32_is_empty(cnum))
+		return CNUM64_EMPTY;
+	return cnum64_from_srange(cnum32_smin(cnum), cnum32_smax(cnum));
+}
+
 /*
  * Suppose 'a' and 'b' are laid out as follows:
  *
diff --git a/kernel/bpf/cnum_defs.h b/kernel/bpf/cnum_defs.h
index 05b17a8b4814..56d0c6f555a8 100644
--- a/kernel/bpf/cnum_defs.h
+++ b/kernel/bpf/cnum_defs.h
@@ -20,6 +20,11 @@
 #define EMPTY    __PASTE(__PASTE(CNUM, T), _EMPTY)
 #define FN(name) __PASTE(__PASTE(cnum, T), __PASTE(_, name))
 
+struct cnum_t FN(const)(ut v)
+{
+	return (struct cnum_t){ .base = v, .size = 0 };
+}
+
 struct cnum_t FN(from_urange)(ut min, ut max)
 {
 	return (struct cnum_t){ .base = min, .size = (ut)max - min };
@@ -259,6 +264,12 @@ struct cnum_t FN(negate)(struct cnum_t a)
 	return FN(normalize)((struct cnum_t){ -((ut)a.base + a.size), a.size });
 }
 
+/* { x - y : x in 'a', y in 'b' } */
+struct cnum_t FN(sub)(struct cnum_t a, struct cnum_t b)
+{
+	return FN(add)(a, FN(negate)(b));
+}
+
 bool FN(is_empty)(struct cnum_t cnum)
 {
 	return cnum.base == EMPTY.base && cnum.size == EMPTY.size;
diff --git a/kernel/bpf/scev.c b/kernel/bpf/scev.c
index 8438313e7b4a..a477a3029baa 100644
--- a/kernel/bpf/scev.c
+++ b/kernel/bpf/scev.c
@@ -4453,16 +4453,6 @@ static struct bpf_reg_state *spill32_counter(struct scev *scev, struct bpf_func_
 	return scev_reg_for_spill32(st, r);
 }
 
-static struct cnum64 cnum64_zext32(struct cnum32 r32)
-{
-	return cnum64_from_urange(cnum32_umin(r32), cnum32_umax(r32));
-}
-
-static struct cnum64 cnum64_sext32(struct cnum32 r32)
-{
-	return cnum64_from_srange(cnum32_smin(r32), cnum32_smax(r32));
-}
-
 /* Compute the range an induction variable in `reg` spans over the loop. */
 static void linear_bounds(struct bpf_reg_state *reg, u32 max_header_count,
 			  struct linear_coefs *coefs, struct bounds *out)
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 5a30ce76da73..6512909600f4 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -2020,7 +2020,7 @@ void bpf_mark_reg_known_scalar(struct bpf_reg_state *reg, u64 imm)
 static void __mark_reg32_known(struct bpf_reg_state *reg, u64 imm)
 {
 	reg->var_off = tnum_const_subreg(reg->var_off, imm);
-	reg->r32 = cnum32_from_urange((u32)imm, (u32)imm);
+	reg->r32 = cnum32_const(imm);
 }
 
 /* Mark the 'variable offset' part of a register as zero.  This should be
@@ -6351,8 +6351,8 @@ static void coerce_reg_to_size_sx(struct bpf_reg_state *reg, int size)
 			reg->var_off = tnum_const((s32)u64_cval);
 
 		u64_cval = reg->var_off.value;
-		reg->r64 = cnum64_from_urange(u64_cval, u64_cval);
-		reg->r32 = cnum32_from_urange((u32)u64_cval, (u32)u64_cval);
+		reg->r64 = cnum64_const(u64_cval);
+		reg->r32 = cnum32_const(u64_cval);
 		return;
 	}
 
@@ -17083,7 +17083,7 @@ static int adjust_ptr_min_max_vals(struct bpf_verifier_env *env, struct bpf_insn
 				"Use addition from R10 to form stack addresses within the tracked stack frame.");
 			return -EACCES;
 		}
-		dst_reg->r64 = cnum64_add(ptr_reg->r64, cnum64_negate(off_reg->r64));
+		dst_reg->r64 = cnum64_sub(ptr_reg->r64, off_reg->r64);
 		dst_reg->var_off = tnum_sub(ptr_reg->var_off, off_reg->var_off);
 		dst_reg->raw = ptr_reg->raw;
 		if (reg_is_pkt_pointer(ptr_reg)) {
@@ -17190,13 +17190,13 @@ static void scalar_min_max_add(struct bpf_reg_state *dst_reg,
 static void scalar32_min_max_sub(struct bpf_reg_state *dst_reg,
 				 struct bpf_reg_state *src_reg)
 {
-	dst_reg->r32 = cnum32_add(dst_reg->r32, cnum32_negate(src_reg->r32));
+	dst_reg->r32 = cnum32_sub(dst_reg->r32, src_reg->r32);
 }
 
 static void scalar_min_max_sub(struct bpf_reg_state *dst_reg,
 			       struct bpf_reg_state *src_reg)
 {
-	dst_reg->r64 = cnum64_add(dst_reg->r64, cnum64_negate(src_reg->r64));
+	dst_reg->r64 = cnum64_sub(dst_reg->r64, src_reg->r64);
 }
 
 static void scalar32_min_max_mul(struct bpf_reg_state *dst_reg,
-- 
2.55.0

