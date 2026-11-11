Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794415799;
	b=lkH545CrvIKpuRErNdxhspRdwVD4h5bthGkhtMmIgeFmmAi6hnKsSgER6sdBlMRq11yd
	 7gDHvv3+dD4krq4YmZdEATYEH2a0wSAThb3GCW0e4BKmvI6llNGlZh8AAgxI9rXyZlXkn
	 z40yyzk95v6mqfN5a8kK0gYXjkE9RB2TOA8i4oPy2tx2ENgI80iObnYgM/qusG37Wu6pd
	 kDkKr/PTE5bGnQLVGjz48DfPh0zU+Aa3Hm1Ly2Zs3SUNxsDDE8LUtWIdcC3I08piqpG7l
	 /UA680EmtCTNfXaDngOrZdlqa8qHDiAViru42eGj4rEdQs1f+t6jagM61TsJ8T9R1gQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794415799;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=SUPrvo+OaH+RHfTGTJPCOBR9G5qXoPE8egpdr1XclPY=;
	b=S9/h+uTeRUf9HRFRKzexmePJaqBiUUBBGWMLDlQychYna+RK5jxoGER52CPbeGdDiO3U
	 aCcFHjgvuYwCN2ZmUY1rC7NQgu0lX9GxR0TSG7XbSnTpB4Lg0HUsQl/n9hRJ++47lx99I
	 8K0o9c+n+zIPk/oSVbObVX3BJ9wZ8iov4X1qaGMWYje57HSVej1PhMmkI5bOjnFYt7K7A
	 kXAEZXy71whHixr8U0Y3Wpnk+K0YXQTpcU5092rSxX0nlIf2mlKeLmw9QlpkC+ssrJbKm
	 llrxKm3Ev2cZXI6CBXJeuKmKgfTEDRsytLeQdS4MxWTfT6vrrDA/zJiLDJPVP9xlpCw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=w+ksYvCb;
	arc=none smtp.remote-ip=209.85.210.178
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E337606A335
	for <bpf@vger.kernel.org>; Wed, 11 Nov 2026 16:49:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4E337606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=w+ksYvCb
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-8b66d1a08ccso72132b3a.1
        for <bpf@vger.kernel.org>; Wed, 11 Nov 2026 08:49:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794415799; x=1795020599; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SUPrvo+OaH+RHfTGTJPCOBR9G5qXoPE8egpdr1XclPY=;
        b=w+ksYvCb6tvNhLb+h+tPgOPx1BL6ls01G7rj3ku0GELiHZQhfCROV5Uee58cELfBa8
         9GyF2JR0fTLLZiREmsenK8b3dU8z6lIRRv31xWUgLAZxf7Rn8g4Ye0huMaCHvDDPXe38
         nszQYxiQM73l3UVhl8L/Ll94NgwZGvJOG6xO8Z3ds9TzSu0WjnKkexdv85qRTW16xJs2
         s9SFVYTlcGMMKecRkah2zo6HsZnM5HMm0UzYry5jt3yMQPcR7YBrPpXE5UuxepwISbXY
         4BhNka7Bf3NzGSw0UwoVxOri+Em8dPWk4EdfLRIV/oM1kwxscHE1YMQwpQoMpLwBaKkz
         j7ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794415799; x=1795020599;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=SUPrvo+OaH+RHfTGTJPCOBR9G5qXoPE8egpdr1XclPY=;
        b=Lb4kI8V7EahImi4ZJy2YJ+5VSwuBCYWzklamkcNZZqp+qTI1qA3xHaCQx7J5su9Q86
         Rp3f1glARZF6ww5nLnU8iAn4NcnistRaoiG5zIaPp+1JYVjZq3N79JwG2+X5Y17Z34gh
         T4IWxR7RcZEcIswmvHEtq06ZfbTF0oBWoEgi2yF0Ide6lwszBKUcnf3L6WyvNDFAA6TS
         OkL7YoVaK0NoIOukLbiepndDMxJiU/BbeyrgjhtNXAOf89AV2HtKgc/QwNpQuWJBE9uP
         i8M70FPq08z3K05A1O0I5H2X8oFIucHxF06ZTAYGW9mhsBLdRqiudxUk+mYpbpgfCTah
         QJCQ==
X-Gm-Message-State: APuU4Z/rYn6yjaNCY39HP1DYCGnApiylhxunGQcPdXxAeoBkHOTWj2mm
	g3LbkSxMgrHxBCdGQdV4eYywI7NslvQqvY8j+g4d1AMBixE/dSHbNeTFTe8g0w==
X-Gm-Gg: AYBFou3CGLkD7tsAd3BG9ghFJFxxASP/JnTziIxxVjPl1mPF0yEk9x1Ouh8FyO8u8NV
	bDPAIGrjfMQb/8gpxsZ1OuqWpFYOHqniKJM4B3oihU2b1LCcwpOZ+ecK8cn3M4kzoYtv3+9ru9O
	dv902uZCQVo/+7jyWMDmYsCMDiKTNeNGmxSB1H3KVTXQQc1bVIv+5ntwqhe9B3oeDEFl/Ny9BHx
	YLy7HOeVhGHoFz1PuGnwWH0rP20ZxJDQxF/HcqVwVmiKwyrtHjadAKXI4GEv+1YAg0U01PONwHa
	jdZPFJI3VrcfL2p14MSvXh9ZnscPamTeK7LcWz+7QiXPPAyL57MymVVamW9cXtC7z7UzUvvadcs
	mmBN6139PzwTn9MJKtVhWI6yI1ODka7Q3S2T0WYkqL+Ns4frCT42p/6ZmC56fLr2eD5/b6uPa2b
	lnMOBw2nvnp3YCZ8aZYMNAwihz/5IrMmhDqO/+M8HpDg1+XUvgNIfgHUEmfnQqlGIADPVcSpTS5
	YYrqI+QnZiAqCPmdZ/Lhwxw7oiM/CwBxixGmwU1jEf6zsYA45VAP1O7nYpHdF3yGLvBaXxjtFzK
	c2gx9ot/JN/pShbXFf/Ao+q8IJMIv7BnNHWlYRBln/JMOOBXHKaEaB8FJTG2m8lix1szy1aaTvD
	SR8z6JqMs4Ezee/356riErNS7Ubj+Xw2VPv45MLHzsZdko4VGqNawBa4TKiwfQ3WSEavX7CDQca
	B2
X-Received: by 2002:a05:6a00:2e1c:b0:8a0:7ba9:939c with SMTP id d2e1a72fcca58-8bc1b8face0mr3166660b3a.11.1794415798393;
        Wed, 11 Nov 2026 08:49:58 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.241])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8baab21835fsm2356422b3a.42.2026.11.11.08.49.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 08:49:57 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next 1/6] bpf: Add const, sub, zext32 and sext32 operations to cnum
Date: Wed, 11 Nov 2026 16:49:44 +0000
Message-ID: <20261111164950.2674588-2-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261111164950.2674588-1-alexei.starovoitov@gmail.com>
References: <20261111164950.2674588-1-alexei.starovoitov@gmail.com>
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
index c9c6b1367a0b..1f33e69b4aee 100644
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
@@ -6345,8 +6345,8 @@ static void coerce_reg_to_size_sx(struct bpf_reg_state *reg, int size)
 			reg->var_off = tnum_const((s32)u64_cval);
 
 		u64_cval = reg->var_off.value;
-		reg->r64 = cnum64_from_urange(u64_cval, u64_cval);
-		reg->r32 = cnum32_from_urange((u32)u64_cval, (u32)u64_cval);
+		reg->r64 = cnum64_const(u64_cval);
+		reg->r32 = cnum32_const(u64_cval);
 		return;
 	}
 
@@ -17077,7 +17077,7 @@ static int adjust_ptr_min_max_vals(struct bpf_verifier_env *env, struct bpf_insn
 				"Use addition from R10 to form stack addresses within the tracked stack frame.");
 			return -EACCES;
 		}
-		dst_reg->r64 = cnum64_add(ptr_reg->r64, cnum64_negate(off_reg->r64));
+		dst_reg->r64 = cnum64_sub(ptr_reg->r64, off_reg->r64);
 		dst_reg->var_off = tnum_sub(ptr_reg->var_off, off_reg->var_off);
 		dst_reg->raw = ptr_reg->raw;
 		if (reg_is_pkt_pointer(ptr_reg)) {
@@ -17184,13 +17184,13 @@ static void scalar_min_max_add(struct bpf_reg_state *dst_reg,
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

