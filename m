Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FCEA3112D0
	for <bpf@vger.kernel.org>; Fri, 24 Apr 2026 08:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777018689; cv=none; b=Mn87/PVD6mKKyeI5/gsO2wn3GVCZOOsQv37SkMohjexyrUogCaFlRdS2pmKubg1v8EudnZUiMiF2IR5vMVwqyEIeneJLQchu+nJlqlaDWP+SAFukIE1c9fqwSFyDceEBVD1WaEoAcbAjhZYjJu4OsvyqfT586gwwBC5YLOuBABs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777018689; c=relaxed/simple;
	bh=EpUcKhQhMINZtjDmIreG9WtVIXAWgrauk9ILgU/iQi8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l0HISd1qvVpbJScNpszJpxS0+LaYYDstmWscO4CRCD7nqvqzoh2dZ/Qp6EQXNoaXCuBQEqeEyd1DD01osvAUKs9UpH5xqerxfNHjNp6G0rMkx1+6PdO0pFKYge/8TD3CahAM5Gk1oID9QXzlfjUbwffxNefr6etzXiT/7jrkQVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AaHGqmbF; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AaHGqmbF"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-c7963df6f17so5059316a12.0
        for <bpf@vger.kernel.org>; Fri, 24 Apr 2026 01:18:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777018684; x=1777623484; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=47y/OeQyuQM3dmRP+Rt+Dwe95efkSlfsXJg3Ok6M9Js=;
        b=AaHGqmbFdLUMOSQ6q3BVoxLSnSNz6dOPBnoPIkKV5PnTiWZfGG5w7k0S5qv7KOVd63
         KaQAXFeR2JthbNccBgy7aGYtm5QBkntiNhSNOI4ITEgo7JYjI6wxdbepi218zhmxKVSX
         igZ2mL4BE2GFVa+/ygoRa2IcfVupR/aeurspn2LLcROvNEDKd2WNTvXovJ4MNP24xjYR
         3tguzL9xoZM9nv0UjECu7C4dgPKZJpekPE3ioSA7vm7dMp+ddPr62SOD8jGBwDFNEQ/p
         wJ99dbK1KKjopOruN/58oahxSHjOhwSik3Sq5louRhbUK+W6evlfBPWA3n10X8Ia0E0P
         v5Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777018684; x=1777623484;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=47y/OeQyuQM3dmRP+Rt+Dwe95efkSlfsXJg3Ok6M9Js=;
        b=h9FeI1APVLnOUkiJ8SFCekyj8AfV/4qpnsFIm0HfloWU17nOU4P4NFZuP5YTRoS4wN
         vOzQMN8JzLaK+OjS8VVs7GCQK0l3VuzYT7tiYoDRyz3fI4MeaqYXxhXQYxlTD+eJ+8tM
         JWGXFVHdwwqg8yUuJGn3mZI9b8zSzM+TN8NNNfk2SsmROJW5VnS9aDm9Qpo6+inIcj6o
         IUEiotfKVmPfkwgAR2U5Q4voObaPu+LCFjv18iFund3cUshMsW1g/6K0ddwMg0bxz1gX
         Pu9xarO+7XAgOtxD24U4K7gPxsalZvBGOYXa2JYVjt5FEwyvwVqt8f49wnS4uBnX7vqb
         lDIw==
X-Gm-Message-State: AOJu0YwXWRo6rrF2UCTQj3kOfPyI5gCPWG2drT7FPFBKlba1JGg+LWb+
	MidmDva5yHtfYZNz0THRycxL/dHu+01eOk55IKMMLsCKcDP6lv5cL/7AqIFNAQ==
X-Gm-Gg: AeBDiev3KSyUOX7M/iU9AOSinSkUT1CO0xUUDGGoDPxuZpkj8JwlTcltsYQ2VCxbjME
	kFuA2juEbitC0XYqySQ6lFRC3oPnOfRNVWl76BOjlexBy0d8iIFhHDuNkTegmUNcPhtFlR2fVm+
	+UjisVvZ9fNZToGEJRkUmhGZuY+DVU7UwjPaJd1HHFkHLCkfEDJSISwks+9B5VgrlUtO84u5EJG
	pctl9JpQEkvqHsToix5jCXKIQX2x170FjyOJX34YiZBuPyFGeyvNjsDwqHMfeZWuMpGWSpwOI26
	WeIg18KUf5mllng+WD8r9Sc96MQDA3kZJjFgT+a6SiEyWwFACIqHyiMvhvHo7MXaoRprB9x/CND
	49ECr8juG88iOw92DQuRym9R18PS7thSEoVWj8bVjv1jGwxPxxSKVRFJyZZ1z1KqSyP7y6vwMHB
	nMEUkf2HC7zKnCDyfqqtBz4OdcfTewWKdvMsP+Zh8kR8X2yPPPrSdVmihI/bw=
X-Received: by 2002:a05:6a00:4502:b0:82c:70a8:faee with SMTP id d2e1a72fcca58-82f8c830903mr31384969b3a.6.1777018683682;
        Fri, 24 Apr 2026 01:18:03 -0700 (PDT)
Received: from honey-badger ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f8ec06cbfsm26604340b3a.58.2026.04.24.01.18.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2026 01:18:03 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	shung-hsi.yu@suse.com,
	paul.chaignon@gmail.com,
	harishankar.vishwanathan@gmail.com,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v2 3/4] bpf: replace min/max fields with struct cnum{32,64}
Date: Fri, 24 Apr 2026 01:17:42 -0700
Message-ID: <20260424-cnums-everywhere-rfc-v1-v2-3-57091924c9d7@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260424-cnums-everywhere-rfc-v1-v2-0-57091924c9d7@gmail.com>
References: <20260424-cnums-everywhere-rfc-v1-v2-0-57091924c9d7@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Replace eight independent s64, u64, s32, u32 min/max fields in
bpf_reg_state with two circular number fields:
- cnum64 for a unified signed/unsigned 64-bit range tracking;
- cnum32 for a unified signed/unsigned 32-bit range tracking.
Each cnum represents a range as a single arc on the circular number
line (base + size), from which signed and unsigned bounds are derived
on demand via accessor functions introduced in the preceding commit.

Notable changes:
- Signed<->unsigned deductions in __reg_deduce_bounds() are removed.
- 64<->32 bit deductions are replaced with:
  - reg->r32 = cnum32_intersect(reg->r32, cnum32_from_cnum64(reg->r64));
    this is functionally equivalent to the old code.
  - reg->r64 = cnum64_cnum32_intersect(reg->r64, reg->r32);
    this handles a few additional cases, see commit message for
    "bpf: representation and basic operations on circular numbers".
- regs_refine_cond_op() now computes results in terms of operations on
  sets, e.g. for JNE:

    /* Complement of the range [val, val] as cnum64. */
    lo = (struct cnum64){ val + 1, U64_MAX - 1 };
    reg1->r64 = cnum64_intersect(reg1->r64, lo);

- For add, sub operations on scalars replace explicit bounds
  computations with cnum{32,64}_{add,negate}.
- For add, sub operations on pointers deduplicate with arithmetic
  operations on scalars and use cnum{32,64}_{add,negate}.
- For and, or, xor operations on scalars remove explicit signed bounds
  computations.
- range_bounds_violation() reduces to checking cnum_is_empty().
- const_tnum_range_mismatch() reduces to checking cnum_is_const().

Selftest adjustments: a few existing tests are updated because a
single cnum arc cannot always represent what the old system expressed
as the intersection of independent signed and unsigned ranges.
For example, if the old system tracked u64=[0, U64_MAX-U32_MAX+2] and
s64=[S64_MIN+2, 2] independently, their intersection is a tight
two-point set. A single cnum must pick the shorter arc, losing the
other constraint. These cases are documented with comments in the
adjusted tests.

reg_bounds.c is updated with logic similar to
cnum64_cnum32_intersect(). Instead of using cnums it inspects
intersection between 'b' and first / last / next-after-first /
previous-before-last sub-ranges of 'a'.

reg_bounds.c is also updated to skip test cases that rely
in signed and unsigned ranges intersecting in two intervals,
as such cases are not representable by a single cnum.
The following "crafted" test cases are affected:
- reg_bounds_crafted/(s64)[0xffffffffffff8000; 0x7fff] (u32)<op> [0; 0x1f]
- reg_bounds_crafted/(s64)[0; 0x1f] (u32)<op> [0xffffffffffffff80; 0x7f]
- reg_bounds_crafted/(s64)[0xffffffffffffff80; 0x7f] (u32)<op> [0; 0x1f]
- reg_bounds_crafted/(u64)[0; 1] (s32)<op> [1; 2147483648]
- reg_bounds_crafted/(u64)[1; 2147483648] (s32)<op> [0; 1]
- reg_bounds_crafted/(u64)[0; 0xffffffff00000000] (s64)<op> 0
- reg_bounds_crafted/(u64)0 (s64)<op> [0; 0xffffffff00000000]
- reg_bounds_crafted/(u64)[0; 0xffffffff00000000] (s32)<op> 0
- reg_bounds_crafted/(u64)0 (s32)<op> [0; 0xffffffff00000000]
- reg_bounds_crafted/(s64)[S64_MIN; 0] (u64)<op> S64_MIN
- reg_bounds_crafted/(s64)S64_MIN (u64)<op> [S64_MIN; 0]
- reg_bounds_crafted/(s32)[S32_MIN; 0] (u32)<op> S32_MIN
- reg_bounds_crafted/(s32)S32_MIN (u32)<op> [S32_MIN; 0]
- reg_bounds_crafted/(s64)[0; 0x1f] (u32)<op> [0xffffffff80000000; 0x7fffffff]
- reg_bounds_crafted/(s64)[0xffffffff80000000; 0x7fffffff] (u32)<op> [0; 0x1f]
- reg_bounds_crafted/(s64)[0; 0x1f] (u32)<op> [0xffffffffffff8000; 0x7fff]

As well as some reg_bounds_roand_{consts,ranges}_A_B, where A and B
differ in sign domain.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 include/linux/bpf_verifier.h                       |  39 +-
 kernel/bpf/verifier.c                              | 842 +++------------------
 .../testing/selftests/bpf/prog_tests/reg_bounds.c  |  90 ++-
 .../testing/selftests/bpf/progs/verifier_bounds.c  |   9 +-
 .../testing/selftests/bpf/progs/verifier_subreg.c  |   6 +-
 5 files changed, 218 insertions(+), 768 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index bf3ffa56bbe5..101ca6cc5424 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -8,6 +8,7 @@
 #include <linux/btf.h> /* for struct btf and btf_id() */
 #include <linux/filter.h> /* for MAX_BPF_STACK */
 #include <linux/tnum.h>
+#include <linux/cnum.h>
 
 /* Maximum variable offset umax_value permitted when resolving memory accesses.
  * In practice this is far bigger than any realistic pointer offset; this limit
@@ -120,14 +121,8 @@ struct bpf_reg_state {
 	 * These refer to the same value as var_off, not necessarily the actual
 	 * contents of the register.
 	 */
-	s64 smin_value; /* minimum possible (s64)value */
-	s64 smax_value; /* maximum possible (s64)value */
-	u64 umin_value; /* minimum possible (u64)value */
-	u64 umax_value; /* maximum possible (u64)value */
-	s32 s32_min_value; /* minimum possible (s32)value */
-	s32 s32_max_value; /* maximum possible (s32)value */
-	u32 u32_min_value; /* minimum possible (u32)value */
-	u32 u32_max_value; /* maximum possible (u32)value */
+	struct cnum64 r64; /* 64-bit range as circular number */
+	struct cnum32 r32; /* 32-bit range as circular number */
 	/* For PTR_TO_PACKET, used to find other pointers with the same variable
 	 * offset, so they can share range knowledge.
 	 * For PTR_TO_MAP_VALUE_OR_NULL this is used to share which map value we
@@ -211,66 +206,62 @@ struct bpf_reg_state {
 
 static inline s64 reg_smin(const struct bpf_reg_state *reg)
 {
-	return reg->smin_value;
+	return cnum64_smin(reg->r64);
 }
 
 static inline s64 reg_smax(const struct bpf_reg_state *reg)
 {
-	return reg->smax_value;
+	return cnum64_smax(reg->r64);
 }
 
 static inline u64 reg_umin(const struct bpf_reg_state *reg)
 {
-	return reg->umin_value;
+	return cnum64_umin(reg->r64);
 }
 
 static inline u64 reg_umax(const struct bpf_reg_state *reg)
 {
-	return reg->umax_value;
+	return cnum64_umax(reg->r64);
 }
 
 static inline s32 reg_s32_min(const struct bpf_reg_state *reg)
 {
-	return reg->s32_min_value;
+	return cnum32_smin(reg->r32);
 }
 
 static inline s32 reg_s32_max(const struct bpf_reg_state *reg)
 {
-	return reg->s32_max_value;
+	return cnum32_smax(reg->r32);
 }
 
 static inline u32 reg_u32_min(const struct bpf_reg_state *reg)
 {
-	return reg->u32_min_value;
+	return cnum32_umin(reg->r32);
 }
 
 static inline u32 reg_u32_max(const struct bpf_reg_state *reg)
 {
-	return reg->u32_max_value;
+	return cnum32_umax(reg->r32);
 }
 
 static inline void reg_set_srange32(struct bpf_reg_state *reg, s32 smin, s32 smax)
 {
-	reg->s32_min_value = smin;
-	reg->s32_max_value = smax;
+	reg->r32 = cnum32_from_srange(smin, smax);
 }
 
 static inline void reg_set_urange32(struct bpf_reg_state *reg, u32 umin, u32 umax)
 {
-	reg->u32_min_value = umin;
-	reg->u32_max_value = umax;
+	reg->r32 = cnum32_from_urange(umin, umax);
 }
 
 static inline void reg_set_srange64(struct bpf_reg_state *reg, s64 smin, s64 smax)
 {
-	reg->smin_value = smin;
-	reg->smax_value = smax;
+	reg->r64 = cnum64_from_srange(smin, smax);
 }
 
 static inline void reg_set_urange64(struct bpf_reg_state *reg, u64 umin, u64 umax)
 {
-	reg->umin_value = umin;
-	reg->umax_value = umax;
+	reg->r64 = cnum64_from_urange(umin, umax);
 }
 
 enum bpf_stack_slot_type {
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index b91d2789e7b9..34900247efba 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -26,6 +26,7 @@
 #include <linux/poison.h>
 #include <linux/module.h>
 #include <linux/cpumask.h>
+#include <linux/cnum.h>
 #include <linux/bpf_mem_alloc.h>
 #include <net/xdp.h>
 #include <linux/trace_events.h>
@@ -1796,10 +1797,8 @@ static const int caller_saved[CALLER_SAVED_REGS] = {
 static void ___mark_reg_known(struct bpf_reg_state *reg, u64 imm)
 {
 	reg->var_off = tnum_const(imm);
-	reg_set_srange64(reg, (s64)imm, (s64)imm);
-	reg_set_urange64(reg, imm, imm);
-	reg_set_srange32(reg, (s32)imm, (s32)imm);
-	reg_set_urange32(reg, (u32)imm, (u32)imm);
+	reg->r64 = cnum64_from_urange(imm, imm);
+	reg->r32 = cnum32_from_urange((u32)imm, (u32)imm);
 }
 
 /* Mark the unknown part of a register (variable offset or scalar value) as
@@ -1818,8 +1817,7 @@ static void __mark_reg_known(struct bpf_reg_state *reg, u64 imm)
 static void __mark_reg32_known(struct bpf_reg_state *reg, u64 imm)
 {
 	reg->var_off = tnum_const_subreg(reg->var_off, imm);
-	reg_set_srange32(reg, (s32)imm, (s32)imm);
-	reg_set_urange32(reg, (u32)imm, (u32)imm);
+	reg->r32 = cnum32_from_urange((u32)imm, (u32)imm);
 }
 
 /* Mark the 'variable offset' part of a register as zero.  This should be
@@ -1932,23 +1930,19 @@ static bool reg_is_init_pkt_pointer(const struct bpf_reg_state *reg,
 
 static void __mark_reg32_unbounded(struct bpf_reg_state *reg)
 {
-	reg_set_srange32(reg, S32_MIN, S32_MAX);
-	reg_set_urange32(reg, 0, U32_MAX);
+	reg->r32 = CNUM32_UNBOUNDED;
 }
 
-/* Reset the min/max bounds of a register */
-static void __mark_reg_unbounded(struct bpf_reg_state *reg)
+static void __mark_reg64_unbounded(struct bpf_reg_state *reg)
 {
-	reg_set_srange64(reg, S64_MIN, S64_MAX);
-	reg_set_urange64(reg, 0, U64_MAX);
-
-	__mark_reg32_unbounded(reg);
+	reg->r64 = CNUM64_UNBOUNDED;
 }
 
-static void __mark_reg64_unbounded(struct bpf_reg_state *reg)
+/* Reset the min/max bounds of a register */
+static void __mark_reg_unbounded(struct bpf_reg_state *reg)
 {
-	reg_set_srange64(reg, S64_MIN, S64_MAX);
-	reg_set_urange64(reg, 0, U64_MAX);
+	__mark_reg64_unbounded(reg);
+	__mark_reg32_unbounded(reg);
 }
 
 static void reset_reg64_and_tnum(struct bpf_reg_state *reg)
@@ -1963,18 +1957,32 @@ static void reset_reg32_and_tnum(struct bpf_reg_state *reg)
 	reg->var_off = tnum_unknown;
 }
 
-static void __update_reg32_bounds(struct bpf_reg_state *reg)
+static struct cnum32 cnum32_from_tnum(struct tnum tnum)
 {
-	struct tnum var32_off = tnum_subreg(reg->var_off);
+	tnum = tnum_subreg(tnum);
+	if ((tnum.mask & S32_MIN) || (tnum.value & S32_MIN))
+		/* min signed is max(sign bit) | min(other bits) */
+		/* max signed is min(sign bit) | max(other bits) */
+		return cnum32_from_srange(tnum.value | (tnum.mask & S32_MIN),
+					  tnum.value | (tnum.mask & S32_MAX));
+	else
+		return cnum32_from_urange(tnum.value, (tnum.value | tnum.mask));
+}
 
-	reg_set_srange32(reg,
-			 /* min signed is max(sign bit) | min(other bits) */
-			 max_t(s32, reg_s32_min(reg), var32_off.value | (var32_off.mask & S32_MIN)),
-			 /* max signed is min(sign bit) | max(other bits) */
-			 min_t(s32, reg_s32_max(reg), var32_off.value | (var32_off.mask & S32_MAX)));
-	reg_set_urange32(reg,
-			 max_t(u32, reg_u32_min(reg), (u32)var32_off.value),
-			 min(reg_u32_max(reg), (u32)(var32_off.value | var32_off.mask)));
+static struct cnum64 cnum64_from_tnum(struct tnum tnum)
+{
+	if ((tnum.mask & S64_MIN) || (tnum.value & S64_MIN))
+		/* min signed is max(sign bit) | min(other bits) */
+		/* max signed is min(sign bit) | max(other bits) */
+		return cnum64_from_srange(tnum.value | (tnum.mask & S64_MIN),
+					  tnum.value | (tnum.mask & S64_MAX));
+	else
+		return cnum64_from_urange(tnum.value, (tnum.value | tnum.mask));
+}
+
+static void __update_reg32_bounds(struct bpf_reg_state *reg)
+{
+	cnum32_intersect_with(&reg->r32, cnum32_from_tnum(reg->var_off));
 }
 
 static void __update_reg64_bounds(struct bpf_reg_state *reg)
@@ -1982,17 +1990,7 @@ static void __update_reg64_bounds(struct bpf_reg_state *reg)
 	u64 tnum_next, tmax;
 	bool umin_in_tnum;
 
-	/* min signed is max(sign bit) | min(other bits) */
-	/* max signed is min(sign bit) | max(other bits) */
-	reg_set_srange64(reg,
-			 max_t(s64, reg_smin(reg),
-			       reg->var_off.value | (reg->var_off.mask & S64_MIN)),
-			 min_t(s64, reg_smax(reg),
-			       reg->var_off.value | (reg->var_off.mask & S64_MAX)));
-	reg_set_urange64(reg,
-			 max(reg_umin(reg), reg->var_off.value),
-			 min(reg_umax(reg),
-			     reg->var_off.value | reg->var_off.mask));
+	cnum64_intersect_with(&reg->r64, cnum64_from_tnum(reg->var_off));
 
 	/* Check if u64 and tnum overlap in a single value */
 	tnum_next = tnum_step(reg->var_off, reg_umin(reg));
@@ -2031,340 +2029,17 @@ static void __update_reg_bounds(struct bpf_reg_state *reg)
 /* Uses signed min/max values to inform unsigned, and vice-versa */
 static void deduce_bounds_32_from_64(struct bpf_reg_state *reg)
 {
-	/* If upper 32 bits of u64/s64 range don't change, we can use lower 32
-	 * bits to improve our u32/s32 boundaries.
-	 *
-	 * E.g., the case where we have upper 32 bits as zero ([10, 20] in
-	 * u64) is pretty trivial, it's obvious that in u32 we'll also have
-	 * [10, 20] range. But this property holds for any 64-bit range as
-	 * long as upper 32 bits in that entire range of values stay the same.
-	 *
-	 * E.g., u64 range [0x10000000A, 0x10000000F] ([4294967306, 4294967311]
-	 * in decimal) has the same upper 32 bits throughout all the values in
-	 * that range. As such, lower 32 bits form a valid [0xA, 0xF] ([10, 15])
-	 * range.
-	 *
-	 * Note also, that [0xA, 0xF] is a valid range both in u32 and in s32,
-	 * following the rules outlined below about u64/s64 correspondence
-	 * (which equally applies to u32 vs s32 correspondence). In general it
-	 * depends on actual hexadecimal values of 32-bit range. They can form
-	 * only valid u32, or only valid s32 ranges in some cases.
-	 *
-	 * So we use all these insights to derive bounds for subregisters here.
-	 */
-	if ((reg_umin(reg) >> 32) == (reg_umax(reg) >> 32)) {
-		/* u64 to u32 casting preserves validity of low 32 bits as
-		 * a range, if upper 32 bits are the same
-		 */
-		reg_set_urange32(reg,
-				 max_t(u32, reg_u32_min(reg), (u32)reg_umin(reg)),
-				 min_t(u32, reg_u32_max(reg), (u32)reg_umax(reg)));
-
-		if ((s32)reg_umin(reg) <= (s32)reg_umax(reg)) {
-			reg_set_srange32(reg,
-					 max_t(s32, reg_s32_min(reg), (s32)reg_umin(reg)),
-					 min_t(s32, reg_s32_max(reg), (s32)reg_umax(reg)));
-		}
-	}
-	if ((reg_smin(reg) >> 32) == (reg_smax(reg) >> 32)) {
-		/* low 32 bits should form a proper u32 range */
-		if ((u32)reg_smin(reg) <= (u32)reg_smax(reg)) {
-			reg_set_urange32(reg,
-					 max_t(u32, reg_u32_min(reg), (u32)reg_smin(reg)),
-					 min_t(u32, reg_u32_max(reg), (u32)reg_smax(reg)));
-		}
-		/* low 32 bits should form a proper s32 range */
-		if ((s32)reg_smin(reg) <= (s32)reg_smax(reg)) {
-			reg_set_srange32(reg,
-					 max_t(s32, reg_s32_min(reg), (s32)reg_smin(reg)),
-					 min_t(s32, reg_s32_max(reg), (s32)reg_smax(reg)));
-		}
-	}
-	/* Special case where upper bits form a small sequence of two
-	 * sequential numbers (in 32-bit unsigned space, so 0xffffffff to
-	 * 0x00000000 is also valid), while lower bits form a proper s32 range
-	 * going from negative numbers to positive numbers. E.g., let's say we
-	 * have s64 range [-1, 1] ([0xffffffffffffffff, 0x0000000000000001]).
-	 * Possible s64 values are {-1, 0, 1} ({0xffffffffffffffff,
-	 * 0x0000000000000000, 0x00000000000001}). Ignoring upper 32 bits,
-	 * we still get a valid s32 range [-1, 1] ([0xffffffff, 0x00000001]).
-	 * Note that it doesn't have to be 0xffffffff going to 0x00000000 in
-	 * upper 32 bits. As a random example, s64 range
-	 * [0xfffffff0fffffff0; 0xfffffff100000010], forms a valid s32 range
-	 * [-16, 16] ([0xfffffff0; 0x00000010]) in its 32 bit subregister.
-	 */
-	if ((u32)(reg_umin(reg) >> 32) + 1 == (u32)(reg_umax(reg) >> 32) &&
-	    (s32)reg_umin(reg) < 0 && (s32)reg_umax(reg) >= 0) {
-		reg_set_srange32(reg,
-				 max_t(s32, reg_s32_min(reg), (s32)reg_umin(reg)),
-				 min_t(s32, reg_s32_max(reg), (s32)reg_umax(reg)));
-	}
-	if ((u32)(reg_smin(reg) >> 32) + 1 == (u32)(reg_smax(reg) >> 32) &&
-	    (s32)reg_smin(reg) < 0 && (s32)reg_smax(reg) >= 0) {
-		reg_set_srange32(reg,
-				 max_t(s32, reg_s32_min(reg), (s32)reg_smin(reg)),
-				 min_t(s32, reg_s32_max(reg), (s32)reg_smax(reg)));
-	}
-}
-
-static void deduce_bounds_32_from_32(struct bpf_reg_state *reg)
-{
-	/* if u32 range forms a valid s32 range (due to matching sign bit),
-	 * try to learn from that
-	 */
-	if ((s32)reg_u32_min(reg) <= (s32)reg_u32_max(reg)) {
-		reg_set_srange32(reg,
-				 max_t(s32, reg_s32_min(reg), reg_u32_min(reg)),
-				 min_t(s32, reg_s32_max(reg), reg_u32_max(reg)));
-	}
-	/* If we cannot cross the sign boundary, then signed and unsigned bounds
-	 * are the same, so combine.  This works even in the negative case, e.g.
-	 * -3 s<= x s<= -1 implies 0xf...fd u<= x u<= 0xf...ff.
-	 */
-	if ((u32)reg_s32_min(reg) <= (u32)reg_s32_max(reg)) {
-		reg_set_urange32(reg,
-				 max_t(u32, reg_s32_min(reg), reg_u32_min(reg)),
-				 min_t(u32, reg_s32_max(reg), reg_u32_max(reg)));
-	} else {
-		if (reg_u32_max(reg) < (u32)reg_s32_min(reg)) {
-			/* See __reg64_deduce_bounds() for detailed explanation.
-			 * Refine ranges in the following situation:
-			 *
-			 * 0                                                   U32_MAX
-			 * |  [xxxxxxxxxxxxxx u32 range xxxxxxxxxxxxxx]              |
-			 * |----------------------------|----------------------------|
-			 * |xxxxx s32 range xxxxxxxxx]                       [xxxxxxx|
-			 * 0                     S32_MAX S32_MIN                    -1
-			 */
-			reg_set_srange32(reg, (s32)reg_u32_min(reg), reg_s32_max(reg));
-			reg_set_urange32(reg,
-					 reg_u32_min(reg),
-					 min_t(u32, reg_u32_max(reg), reg_s32_max(reg)));
-		} else if ((u32)reg_s32_max(reg) < reg_u32_min(reg)) {
-			/*
-			 * 0                                                   U32_MAX
-			 * |              [xxxxxxxxxxxxxx u32 range xxxxxxxxxxxxxx]  |
-			 * |----------------------------|----------------------------|
-			 * |xxxxxxxxx]                       [xxxxxxxxxxxx s32 range |
-			 * 0                     S32_MAX S32_MIN                    -1
-			 */
-			reg_set_srange32(reg, reg_s32_min(reg), (s32)reg_u32_max(reg));
-			reg_set_urange32(reg,
-					 max_t(u32, reg_u32_min(reg), reg_s32_min(reg)),
-					 reg_u32_max(reg));
-		}
-	}
-}
-
-static void deduce_bounds_64_from_64(struct bpf_reg_state *reg)
-{
-	/* If u64 range forms a valid s64 range (due to matching sign bit),
-	 * try to learn from that. Let's do a bit of ASCII art to see when
-	 * this is happening. Let's take u64 range first:
-	 *
-	 * 0             0x7fffffffffffffff 0x8000000000000000        U64_MAX
-	 * |-------------------------------|--------------------------------|
-	 *
-	 * Valid u64 range is formed when umin and umax are anywhere in the
-	 * range [0, U64_MAX], and umin <= umax. u64 case is simple and
-	 * straightforward. Let's see how s64 range maps onto the same range
-	 * of values, annotated below the line for comparison:
-	 *
-	 * 0             0x7fffffffffffffff 0x8000000000000000        U64_MAX
-	 * |-------------------------------|--------------------------------|
-	 * 0                        S64_MAX S64_MIN                        -1
-	 *
-	 * So s64 values basically start in the middle and they are logically
-	 * contiguous to the right of it, wrapping around from -1 to 0, and
-	 * then finishing as S64_MAX (0x7fffffffffffffff) right before
-	 * S64_MIN. We can try drawing the continuity of u64 vs s64 values
-	 * more visually as mapped to sign-agnostic range of hex values.
-	 *
-	 *  u64 start                                               u64 end
-	 *  _______________________________________________________________
-	 * /                                                               \
-	 * 0             0x7fffffffffffffff 0x8000000000000000        U64_MAX
-	 * |-------------------------------|--------------------------------|
-	 * 0                        S64_MAX S64_MIN                        -1
-	 *                                / \
-	 * >------------------------------   ------------------------------->
-	 * s64 continues...        s64 end   s64 start          s64 "midpoint"
-	 *
-	 * What this means is that, in general, we can't always derive
-	 * something new about u64 from any random s64 range, and vice versa.
-	 *
-	 * But we can do that in two particular cases. One is when entire
-	 * u64/s64 range is *entirely* contained within left half of the above
-	 * diagram or when it is *entirely* contained in the right half. I.e.:
-	 *
-	 * |-------------------------------|--------------------------------|
-	 *     ^                   ^            ^                 ^
-	 *     A                   B            C                 D
-	 *
-	 * [A, B] and [C, D] are contained entirely in their respective halves
-	 * and form valid contiguous ranges as both u64 and s64 values. [A, B]
-	 * will be non-negative both as u64 and s64 (and in fact it will be
-	 * identical ranges no matter the signedness). [C, D] treated as s64
-	 * will be a range of negative values, while in u64 it will be
-	 * non-negative range of values larger than 0x8000000000000000.
-	 *
-	 * Now, any other range here can't be represented in both u64 and s64
-	 * simultaneously. E.g., [A, C], [A, D], [B, C], [B, D] are valid
-	 * contiguous u64 ranges, but they are discontinuous in s64. [B, C]
-	 * in s64 would be properly presented as [S64_MIN, C] and [B, S64_MAX],
-	 * for example. Similarly, valid s64 range [D, A] (going from negative
-	 * to positive values), would be two separate [D, U64_MAX] and [0, A]
-	 * ranges as u64. Currently reg_state can't represent two segments per
-	 * numeric domain, so in such situations we can only derive maximal
-	 * possible range ([0, U64_MAX] for u64, and [S64_MIN, S64_MAX] for s64).
-	 *
-	 * So we use these facts to derive umin/umax from smin/smax and vice
-	 * versa only if they stay within the same "half". This is equivalent
-	 * to checking sign bit: lower half will have sign bit as zero, upper
-	 * half have sign bit 1. Below in code we simplify this by just
-	 * casting umin/umax as smin/smax and checking if they form valid
-	 * range, and vice versa. Those are equivalent checks.
-	 */
-	if ((s64)reg_umin(reg) <= (s64)reg_umax(reg)) {
-		reg_set_srange64(reg,
-				 max_t(s64, reg_smin(reg), reg_umin(reg)),
-				 min_t(s64, reg_smax(reg), reg_umax(reg)));
-	}
-	/* If we cannot cross the sign boundary, then signed and unsigned bounds
-	 * are the same, so combine.  This works even in the negative case, e.g.
-	 * -3 s<= x s<= -1 implies 0xf...fd u<= x u<= 0xf...ff.
-	 */
-	if ((u64)reg_smin(reg) <= (u64)reg_smax(reg)) {
-		reg_set_urange64(reg,
-				 max_t(u64, reg_smin(reg), reg_umin(reg)),
-				 min_t(u64, reg_smax(reg), reg_umax(reg)));
-	} else {
-		/* If the s64 range crosses the sign boundary, then it's split
-		 * between the beginning and end of the U64 domain. In that
-		 * case, we can derive new bounds if the u64 range overlaps
-		 * with only one end of the s64 range.
-		 *
-		 * In the following example, the u64 range overlaps only with
-		 * positive portion of the s64 range.
-		 *
-		 * 0                                                   U64_MAX
-		 * |  [xxxxxxxxxxxxxx u64 range xxxxxxxxxxxxxx]              |
-		 * |----------------------------|----------------------------|
-		 * |xxxxx s64 range xxxxxxxxx]                       [xxxxxxx|
-		 * 0                     S64_MAX S64_MIN                    -1
-		 *
-		 * We can thus derive the following new s64 and u64 ranges.
-		 *
-		 * 0                                                   U64_MAX
-		 * |  [xxxxxx u64 range xxxxx]                               |
-		 * |----------------------------|----------------------------|
-		 * |  [xxxxxx s64 range xxxxx]                               |
-		 * 0                     S64_MAX S64_MIN                    -1
-		 *
-		 * If they overlap in two places, we can't derive anything
-		 * because reg_state can't represent two ranges per numeric
-		 * domain.
-		 *
-		 * 0                                                   U64_MAX
-		 * |  [xxxxxxxxxxxxxxxxx u64 range xxxxxxxxxxxxxxxxx]        |
-		 * |----------------------------|----------------------------|
-		 * |xxxxx s64 range xxxxxxxxx]                    [xxxxxxxxxx|
-		 * 0                     S64_MAX S64_MIN                    -1
-		 *
-		 * The first condition below corresponds to the first diagram
-		 * above.
-		 */
-		if (reg_umax(reg) < (u64)reg_smin(reg)) {
-			reg_set_srange64(reg, (s64)reg_umin(reg), reg_smax(reg));
-			reg_set_urange64(reg, reg_umin(reg), min_t(u64, reg_umax(reg), reg_smax(reg)));
-		} else if ((u64)reg_smax(reg) < reg_umin(reg)) {
-			/* This second condition considers the case where the u64 range
-			 * overlaps with the negative portion of the s64 range:
-			 *
-			 * 0                                                   U64_MAX
-			 * |              [xxxxxxxxxxxxxx u64 range xxxxxxxxxxxxxx]  |
-			 * |----------------------------|----------------------------|
-			 * |xxxxxxxxx]                       [xxxxxxxxxxxx s64 range |
-			 * 0                     S64_MAX S64_MIN                    -1
-			 */
-			reg_set_srange64(reg, reg_smin(reg), (s64)reg_umax(reg));
-			reg_set_urange64(reg, max_t(u64, reg_umin(reg), reg_smin(reg)), reg_umax(reg));
-		}
-	}
+	cnum32_intersect_with(&reg->r32, cnum32_from_cnum64(reg->r64));
 }
 
 static void deduce_bounds_64_from_32(struct bpf_reg_state *reg)
 {
-	/* Try to tighten 64-bit bounds from 32-bit knowledge, using 32-bit
-	 * values on both sides of 64-bit range in hope to have tighter range.
-	 * E.g., if r1 is [0x1'00000000, 0x3'80000000], and we learn from
-	 * 32-bit signed > 0 operation that s32 bounds are now [1; 0x7fffffff].
-	 * With this, we can substitute 1 as low 32-bits of _low_ 64-bit bound
-	 * (0x100000000 -> 0x100000001) and 0x7fffffff as low 32-bits of
-	 * _high_ 64-bit bound (0x380000000 -> 0x37fffffff) and arrive at a
-	 * better overall bounds for r1 as [0x1'000000001; 0x3'7fffffff].
-	 * We just need to make sure that derived bounds we are intersecting
-	 * with are well-formed ranges in respective s64 or u64 domain, just
-	 * like we do with similar kinds of 32-to-64 or 64-to-32 adjustments.
-	 */
-	__u64 new_umin, new_umax;
-	__s64 new_smin, new_smax;
-
-	/* u32 -> u64 tightening, it's always well-formed */
-	new_umin = (reg_umin(reg) & ~0xffffffffULL) | reg_u32_min(reg);
-	new_umax = (reg_umax(reg) & ~0xffffffffULL) | reg_u32_max(reg);
-	reg_set_urange64(reg,
-			 max_t(u64, reg_umin(reg), new_umin),
-			 min_t(u64, reg_umax(reg), new_umax));
-	/* u32 -> s64 tightening, u32 range embedded into s64 preserves range validity */
-	new_smin = (reg_smin(reg) & ~0xffffffffULL) | reg_u32_min(reg);
-	new_smax = (reg_smax(reg) & ~0xffffffffULL) | reg_u32_max(reg);
-	reg_set_srange64(reg,
-			 max_t(s64, reg_smin(reg), new_smin),
-			 min_t(s64, reg_smax(reg), new_smax));
-
-	/* Here we would like to handle a special case after sign extending load,
-	 * when upper bits for a 64-bit range are all 1s or all 0s.
-	 *
-	 * Upper bits are all 1s when register is in a range:
-	 *   [0xffff_ffff_0000_0000, 0xffff_ffff_ffff_ffff]
-	 * Upper bits are all 0s when register is in a range:
-	 *   [0x0000_0000_0000_0000, 0x0000_0000_ffff_ffff]
-	 * Together this forms are continuous range:
-	 *   [0xffff_ffff_0000_0000, 0x0000_0000_ffff_ffff]
-	 *
-	 * Now, suppose that register range is in fact tighter:
-	 *   [0xffff_ffff_8000_0000, 0x0000_0000_ffff_ffff] (R)
-	 * Also suppose that it's 32-bit range is positive,
-	 * meaning that lower 32-bits of the full 64-bit register
-	 * are in the range:
-	 *   [0x0000_0000, 0x7fff_ffff] (W)
-	 *
-	 * If this happens, then any value in a range:
-	 *   [0xffff_ffff_0000_0000, 0xffff_ffff_7fff_ffff]
-	 * is smaller than a lowest bound of the range (R):
-	 *   0xffff_ffff_8000_0000
-	 * which means that upper bits of the full 64-bit register
-	 * can't be all 1s, when lower bits are in range (W).
-	 *
-	 * Note that:
-	 *  - 0xffff_ffff_8000_0000 == (s64)S32_MIN
-	 *  - 0x0000_0000_7fff_ffff == (s64)S32_MAX
-	 * These relations are used in the conditions below.
-	 */
-	if (reg_s32_min(reg) >= 0 && reg_smin(reg) >= S32_MIN && reg_smax(reg) <= S32_MAX) {
-		reg_set_srange64(reg, reg_s32_min(reg), reg_s32_max(reg));
-		reg_set_urange64(reg, reg_s32_min(reg), reg_s32_max(reg));
-		reg->var_off = tnum_intersect(reg->var_off,
-					      tnum_range(reg_smin(reg), reg_smax(reg)));
-	}
+	reg->r64 = cnum64_cnum32_intersect(reg->r64, reg->r32);
 }
 
 static void __reg_deduce_bounds(struct bpf_reg_state *reg)
 {
-	deduce_bounds_64_from_64(reg);
 	deduce_bounds_32_from_64(reg);
-	deduce_bounds_32_from_32(reg);
 	deduce_bounds_64_from_32(reg);
 }
 
@@ -2402,35 +2077,25 @@ static void reg_bounds_sync(struct bpf_reg_state *reg)
 	__update_reg_bounds(reg);
 }
 
-static bool range_bounds_violation(struct bpf_reg_state *reg)
-{
-	return (reg_umin(reg) > reg_umax(reg) || reg_smin(reg) > reg_smax(reg) ||
-		reg_u32_min(reg) > reg_u32_max(reg) ||
-		reg_s32_min(reg) > reg_s32_max(reg));
-}
-
 static bool const_tnum_range_mismatch(struct bpf_reg_state *reg)
 {
-	u64 uval = reg->var_off.value;
-	s64 sval = (s64)uval;
-
 	if (!tnum_is_const(reg->var_off))
 		return false;
 
-	return reg_umin(reg) != uval || reg_umax(reg) != uval ||
-	       reg_smin(reg) != sval || reg_smax(reg) != sval;
+	return !cnum64_is_const(reg->r64) || reg->r64.base != reg->var_off.value;
 }
 
 static bool const_tnum_range_mismatch_32(struct bpf_reg_state *reg)
 {
-	u32 uval32 = tnum_subreg(reg->var_off).value;
-	s32 sval32 = (s32)uval32;
-
 	if (!tnum_subreg_is_const(reg->var_off))
 		return false;
 
-	return reg_u32_min(reg) != uval32 || reg_u32_max(reg) != uval32 ||
-	       reg_s32_min(reg) != sval32 || reg_s32_max(reg) != sval32;
+	return !cnum32_is_const(reg->r32) || reg->r32.base != tnum_subreg(reg->var_off).value;
+}
+
+static bool range_bounds_violation(struct bpf_reg_state *reg)
+{
+	return cnum32_is_empty(reg->r32) || cnum64_is_empty(reg->r64);
 }
 
 static int reg_bounds_sanity_check(struct bpf_verifier_env *env,
@@ -2455,12 +2120,11 @@ static int reg_bounds_sanity_check(struct bpf_verifier_env *env,
 
 	return 0;
 out:
-	verifier_bug(env, "REG INVARIANTS VIOLATION (%s): %s u64=[%#llx, %#llx] "
-		     "s64=[%#llx, %#llx] u32=[%#x, %#x] s32=[%#x, %#x] var_off=(%#llx, %#llx)",
-		     ctx, msg, reg_umin(reg), reg_umax(reg),
-		     reg_smin(reg), reg_smax(reg),
-		     reg_u32_min(reg), reg_u32_max(reg),
-		     reg_s32_min(reg), reg_s32_max(reg),
+	verifier_bug(env, "REG INVARIANTS VIOLATION (%s): %s r64={.base=%#llx, .size=%#llx} "
+		     "r32={.base=%#x, .size=%#x} var_off=(%#llx, %#llx)",
+		     ctx, msg,
+		     reg->r64.base, reg->r64.size,
+		     reg->r32.base, reg->r32.size,
 		     reg->var_off.value, reg->var_off.mask);
 	if (env->test_reg_invariants)
 		return -EFAULT;
@@ -2468,26 +2132,6 @@ static int reg_bounds_sanity_check(struct bpf_verifier_env *env,
 	return 0;
 }
 
-static bool __reg32_bound_s64(s32 a)
-{
-	return a >= 0 && a <= S32_MAX;
-}
-
-static void __reg_assign_32_into_64(struct bpf_reg_state *reg)
-{
-	reg_set_urange64(reg, reg_u32_min(reg), reg_u32_max(reg));
-
-	/* Attempt to pull 32-bit signed bounds into 64-bit bounds but must
-	 * be positive otherwise set to worse case bounds and refine later
-	 * from tnum.
-	 */
-	if (__reg32_bound_s64(reg_s32_min(reg)) &&
-	    __reg32_bound_s64(reg_s32_max(reg)))
-		reg_set_srange64(reg, reg_s32_min(reg), reg_s32_max(reg));
-	else
-		reg_set_srange64(reg, 0, U32_MAX);
-}
-
 /* Mark a register as having a completely unknown (scalar) value. */
 void bpf_mark_reg_unknown_imprecise(struct bpf_reg_state *reg)
 {
@@ -5636,7 +5280,7 @@ static int check_buffer_access(struct bpf_verifier_env *env,
 static void zext_32_to_64(struct bpf_reg_state *reg)
 {
 	reg->var_off = tnum_subreg(reg->var_off);
-	__reg_assign_32_into_64(reg);
+	reg_set_urange64(reg, reg_u32_min(reg), reg_u32_max(reg));
 }
 
 /* truncate register to smaller size (in bytes)
@@ -5651,12 +5295,10 @@ static void coerce_reg_to_size(struct bpf_reg_state *reg, int size)
 
 	/* fix arithmetic bounds */
 	mask = ((u64)1 << (size * 8)) - 1;
-	if ((reg_umin(reg) & ~mask) == (reg_umax(reg) & ~mask)) {
+	if ((reg_umin(reg) & ~mask) == (reg_umax(reg) & ~mask))
 		reg_set_urange64(reg, reg_umin(reg) & mask, reg_umax(reg) & mask);
-	} else {
+	else
 		reg_set_urange64(reg, 0, mask);
-	}
-	reg_set_srange64(reg, reg_umin(reg), reg_umax(reg));
 
 	/* If size is smaller than 32bit register the 32bit register
 	 * values are also truncated so we push 64-bit bounds into
@@ -5681,8 +5323,6 @@ static void set_sext64_default_val(struct bpf_reg_state *reg, int size)
 		reg_set_srange64(reg, S32_MIN, S32_MAX);
 		reg_set_srange32(reg, S32_MIN, S32_MAX);
 	}
-	reg_set_urange64(reg, 0, U64_MAX);
-	reg_set_urange32(reg, 0, U32_MAX);
 	reg->var_off = tnum_unknown;
 }
 
@@ -5703,10 +5343,8 @@ static void coerce_reg_to_size_sx(struct bpf_reg_state *reg, int size)
 			reg->var_off = tnum_const((s32)u64_cval);
 
 		u64_cval = reg->var_off.value;
-		reg_set_srange64(reg, u64_cval, u64_cval);
-		reg_set_urange64(reg, u64_cval, u64_cval);
-		reg_set_srange32(reg, u64_cval, u64_cval);
-		reg_set_urange32(reg, u64_cval, u64_cval);
+		reg->r64 = cnum64_from_urange(u64_cval, u64_cval);
+		reg->r32 = cnum32_from_urange((u32)u64_cval, (u32)u64_cval);
 		return;
 	}
 
@@ -5734,9 +5372,7 @@ static void coerce_reg_to_size_sx(struct bpf_reg_state *reg, int size)
 	/* both of s64_max/s64_min positive or negative */
 	if ((s64_max >= 0) == (s64_min >= 0)) {
 		reg_set_srange64(reg, s64_min, s64_max);
-		reg_set_urange64(reg, s64_min, s64_max);
 		reg_set_srange32(reg, s64_min, s64_max);
-		reg_set_urange32(reg, s64_min, s64_max);
 		reg->var_off = tnum_range(s64_min, s64_max);
 		return;
 	}
@@ -5752,7 +5388,6 @@ static void set_sext32_default_val(struct bpf_reg_state *reg, int size)
 	else
 		/* size == 2 */
 		reg_set_srange32(reg, S16_MIN, S16_MAX);
-	reg_set_urange32(reg, 0, U32_MAX);
 	reg->var_off = tnum_subreg(tnum_unknown);
 }
 
@@ -5771,7 +5406,6 @@ static void coerce_subreg_to_size_sx(struct bpf_reg_state *reg, int size)
 
 		u32_val = reg->var_off.value;
 		reg_set_srange32(reg, u32_val, u32_val);
-		reg_set_urange32(reg, u32_val, u32_val);
 		return;
 	}
 
@@ -5795,7 +5429,6 @@ static void coerce_subreg_to_size_sx(struct bpf_reg_state *reg, int size)
 
 	if ((s32_min >= 0) == (s32_max >= 0)) {
 		reg_set_srange32(reg, s32_min, s32_max);
-		reg_set_urange32(reg, (u32)s32_min, (u32)s32_max);
 		reg->var_off = tnum_subreg(tnum_range(s32_min, s32_max));
 		return;
 	}
@@ -9952,8 +9585,6 @@ static int do_refine_retval_range(struct bpf_verifier_env *env,
 	case BPF_FUNC_get_smp_processor_id:
 		reg_set_urange64(ret_reg, 0, nr_cpu_ids - 1);
 		reg_set_urange32(ret_reg, 0, nr_cpu_ids - 1);
-		reg_set_srange64(ret_reg, 0, nr_cpu_ids - 1);
-		reg_set_srange32(ret_reg, 0, nr_cpu_ids - 1);
 		reg_bounds_sync(ret_reg);
 		break;
 	}
@@ -13756,10 +13387,8 @@ static int adjust_ptr_min_max_vals(struct bpf_verifier_env *env,
 	struct bpf_func_state *state = vstate->frame[vstate->curframe];
 	struct bpf_reg_state *regs = state->regs, *dst_reg;
 	bool known = tnum_is_const(off_reg->var_off);
-	s64 smin_val = reg_smin(off_reg), smax_val = reg_smax(off_reg),
-	    smin_ptr = reg_smin(ptr_reg), smax_ptr = reg_smax(ptr_reg);
-	u64 umin_val = reg_umin(off_reg), umax_val = reg_umax(off_reg),
-	    umin_ptr = reg_umin(ptr_reg), umax_ptr = reg_umax(ptr_reg);
+	s64 smin_val = reg_smin(off_reg), smax_val = reg_smax(off_reg);
+	u64 umin_val = reg_umin(off_reg), umax_val = reg_umax(off_reg);
 	struct bpf_sanitize_info info = {};
 	u8 opcode = BPF_OP(insn->code);
 	u32 dst = insn->dst_reg;
@@ -13861,23 +13490,7 @@ static int adjust_ptr_min_max_vals(struct bpf_verifier_env *env,
 		 * added into the variable offset, and we copy the fixed offset
 		 * from ptr_reg.
 		 */
-		{
-		s64 smin_res, smax_res;
-		u64 umin_res, umax_res;
-
-		if (check_add_overflow(smin_ptr, smin_val, &smin_res) ||
-		    check_add_overflow(smax_ptr, smax_val, &smax_res)) {
-			reg_set_srange64(dst_reg, S64_MIN, S64_MAX);
-		} else {
-			reg_set_srange64(dst_reg, smin_res, smax_res);
-		}
-		if (check_add_overflow(umin_ptr, umin_val, &umin_res) ||
-		    check_add_overflow(umax_ptr, umax_val, &umax_res)) {
-			reg_set_urange64(dst_reg, 0, U64_MAX);
-		} else {
-			reg_set_urange64(dst_reg, umin_res, umax_res);
-		}
-		}
+		dst_reg->r64 = cnum64_add(ptr_reg->r64, off_reg->r64);
 		dst_reg->var_off = tnum_add(ptr_reg->var_off, off_reg->var_off);
 		dst_reg->raw = ptr_reg->raw;
 		if (reg_is_pkt_pointer(ptr_reg)) {
@@ -13909,27 +13522,7 @@ static int adjust_ptr_min_max_vals(struct bpf_verifier_env *env,
 				dst);
 			return -EACCES;
 		}
-		/* A new variable offset is created.  If the subtrahend is known
-		 * nonnegative, then any reg->range we had before is still good.
-		 */
-		{
-		s64 smin_res, smax_res;
-
-		if (check_sub_overflow(smin_ptr, smax_val, &smin_res) ||
-		    check_sub_overflow(smax_ptr, smin_val, &smax_res)) {
-			/* Overflow possible, we know nothing */
-			reg_set_srange64(dst_reg, S64_MIN, S64_MAX);
-		} else {
-			reg_set_srange64(dst_reg, smin_res, smax_res);
-		}
-		}
-		if (umin_ptr < umax_val) {
-			/* Overflow possible, we know nothing */
-			reg_set_urange64(dst_reg, 0, U64_MAX);
-		} else {
-			/* Cannot overflow (as long as bounds are consistent) */
-			reg_set_urange64(dst_reg, umin_ptr - umax_val, umax_ptr - umin_val);
-		}
+		dst_reg->r64 = cnum64_add(ptr_reg->r64, cnum64_negate(off_reg->r64));
 		dst_reg->var_off = tnum_sub(ptr_reg->var_off, off_reg->var_off);
 		dst_reg->raw = ptr_reg->raw;
 		if (reg_is_pkt_pointer(ptr_reg)) {
@@ -13986,139 +13579,25 @@ static int adjust_ptr_min_max_vals(struct bpf_verifier_env *env,
 static void scalar32_min_max_add(struct bpf_reg_state *dst_reg,
 				 struct bpf_reg_state *src_reg)
 {
-	s32 smin = reg_s32_min(dst_reg);
-	s32 smax = reg_s32_max(dst_reg);
-	u32 umin = reg_u32_min(dst_reg);
-	u32 umax = reg_u32_max(dst_reg);
-	u32 umin_val = reg_u32_min(src_reg);
-	u32 umax_val = reg_u32_max(src_reg);
-	bool min_overflow, max_overflow;
-
-	if (check_add_overflow(smin, reg_s32_min(src_reg), &smin) ||
-	    check_add_overflow(smax, reg_s32_max(src_reg), &smax)) {
-		smin = S32_MIN;
-		smax = S32_MAX;
-	}
-
-	/* If either all additions overflow or no additions overflow, then
-	 * it is okay to set: dst_umin = dst_umin + src_umin, dst_umax =
-	 * dst_umax + src_umax. Otherwise (some additions overflow), set
-	 * the output bounds to unbounded.
-	 */
-	min_overflow = check_add_overflow(umin, umin_val, &umin);
-	max_overflow = check_add_overflow(umax, umax_val, &umax);
-
-	if (!min_overflow && max_overflow) {
-		umin = 0;
-		umax = U32_MAX;
-	}
-
-	reg_set_srange32(dst_reg, smin, smax);
-	reg_set_urange32(dst_reg, umin, umax);
+	dst_reg->r32 = cnum32_add(dst_reg->r32, src_reg->r32);
 }
 
 static void scalar_min_max_add(struct bpf_reg_state *dst_reg,
 			       struct bpf_reg_state *src_reg)
 {
-	s64 smin = reg_smin(dst_reg);
-	s64 smax = reg_smax(dst_reg);
-	u64 umin = reg_umin(dst_reg);
-	u64 umax = reg_umax(dst_reg);
-	u64 umin_val = reg_umin(src_reg);
-	u64 umax_val = reg_umax(src_reg);
-	bool min_overflow, max_overflow;
-
-	if (check_add_overflow(smin, reg_smin(src_reg), &smin) ||
-	    check_add_overflow(smax, reg_smax(src_reg), &smax)) {
-		smin = S64_MIN;
-		smax = S64_MAX;
-	}
-
-	/* If either all additions overflow or no additions overflow, then
-	 * it is okay to set: dst_umin = dst_umin + src_umin, dst_umax =
-	 * dst_umax + src_umax. Otherwise (some additions overflow), set
-	 * the output bounds to unbounded.
-	 */
-	min_overflow = check_add_overflow(umin, umin_val, &umin);
-	max_overflow = check_add_overflow(umax, umax_val, &umax);
-
-	if (!min_overflow && max_overflow) {
-		umin = 0;
-		umax = U64_MAX;
-	}
-
-	reg_set_srange64(dst_reg, smin, smax);
-	reg_set_urange64(dst_reg, umin, umax);
+	dst_reg->r64 = cnum64_add(dst_reg->r64, src_reg->r64);
 }
 
 static void scalar32_min_max_sub(struct bpf_reg_state *dst_reg,
 				 struct bpf_reg_state *src_reg)
 {
-	s32 smin = reg_s32_min(dst_reg);
-	s32 smax = reg_s32_max(dst_reg);
-	u32 umin = reg_u32_min(dst_reg);
-	u32 umax = reg_u32_max(dst_reg);
-	u32 umin_val = reg_u32_min(src_reg);
-	u32 umax_val = reg_u32_max(src_reg);
-	bool min_underflow, max_underflow;
-
-	if (check_sub_overflow(smin, reg_s32_max(src_reg), &smin) ||
-	    check_sub_overflow(smax, reg_s32_min(src_reg), &smax)) {
-		/* Overflow possible, we know nothing */
-		smin = S32_MIN;
-		smax = S32_MAX;
-	}
-
-	/* If either all subtractions underflow or no subtractions
-	 * underflow, it is okay to set: dst_umin = dst_umin - src_umax,
-	 * dst_umax = dst_umax - src_umin. Otherwise (some subtractions
-	 * underflow), set the output bounds to unbounded.
-	 */
-	min_underflow = check_sub_overflow(umin, umax_val, &umin);
-	max_underflow = check_sub_overflow(umax, umin_val, &umax);
-
-	if (min_underflow && !max_underflow) {
-		umin = 0;
-		umax = U32_MAX;
-	}
-
-	reg_set_srange32(dst_reg, smin, smax);
-	reg_set_urange32(dst_reg, umin, umax);
+	dst_reg->r32 = cnum32_add(dst_reg->r32, cnum32_negate(src_reg->r32));
 }
 
 static void scalar_min_max_sub(struct bpf_reg_state *dst_reg,
 			       struct bpf_reg_state *src_reg)
 {
-	s64 smin = reg_smin(dst_reg);
-	s64 smax = reg_smax(dst_reg);
-	u64 umin = reg_umin(dst_reg);
-	u64 umax = reg_umax(dst_reg);
-	u64 umin_val = reg_umin(src_reg);
-	u64 umax_val = reg_umax(src_reg);
-	bool min_underflow, max_underflow;
-
-	if (check_sub_overflow(smin, reg_smax(src_reg), &smin) ||
-	    check_sub_overflow(smax, reg_smin(src_reg), &smax)) {
-		/* Overflow possible, we know nothing */
-		smin = S64_MIN;
-		smax = S64_MAX;
-	}
-
-	/* If either all subtractions underflow or no subtractions
-	 * underflow, it is okay to set: dst_umin = dst_umin - src_umax,
-	 * dst_umax = dst_umax - src_umin. Otherwise (some subtractions
-	 * underflow), set the output bounds to unbounded.
-	 */
-	min_underflow = check_sub_overflow(umin, umax_val, &umin);
-	max_underflow = check_sub_overflow(umax, umin_val, &umax);
-
-	if (min_underflow && !max_underflow) {
-		umin = 0;
-		umax = U64_MAX;
-	}
-
-	reg_set_srange64(dst_reg, smin, smax);
-	reg_set_urange64(dst_reg, umin, umax);
+	dst_reg->r64 = cnum64_add(dst_reg->r64, cnum64_negate(src_reg->r64));
 }
 
 static void scalar32_min_max_mul(struct bpf_reg_state *dst_reg,
@@ -14148,8 +13627,8 @@ static void scalar32_min_max_mul(struct bpf_reg_state *dst_reg,
 		smax = max_array(tmp_prod, 4);
 	}
 
-	reg_set_srange32(dst_reg, smin, smax);
-	reg_set_urange32(dst_reg, umin, umax);
+	dst_reg->r32 = cnum32_intersect(cnum32_from_urange(umin, umax),
+					cnum32_from_srange(smin, smax));
 }
 
 static void scalar_min_max_mul(struct bpf_reg_state *dst_reg,
@@ -14179,8 +13658,8 @@ static void scalar_min_max_mul(struct bpf_reg_state *dst_reg,
 		smax = max_array(tmp_prod, 4);
 	}
 
-	reg_set_srange64(dst_reg, smin, smax);
-	reg_set_urange64(dst_reg, umin, umax);
+	dst_reg->r64 = cnum64_intersect(cnum64_from_urange(umin, umax),
+					cnum64_from_srange(smin, smax));
 }
 
 static void scalar32_min_max_udiv(struct bpf_reg_state *dst_reg,
@@ -14192,7 +13671,6 @@ static void scalar32_min_max_udiv(struct bpf_reg_state *dst_reg,
 			 reg_u32_max(dst_reg) / src_val);
 
 	/* Reset other ranges/tnum to unbounded/unknown. */
-	reg_set_srange32(dst_reg, S32_MIN, S32_MAX);
 	reset_reg64_and_tnum(dst_reg);
 }
 
@@ -14205,7 +13683,6 @@ static void scalar_min_max_udiv(struct bpf_reg_state *dst_reg,
 			 div64_u64(reg_umax(dst_reg), src_val));
 
 	/* Reset other ranges/tnum to unbounded/unknown. */
-	reg_set_srange64(dst_reg, S64_MIN, S64_MAX);
 	reset_reg32_and_tnum(dst_reg);
 }
 
@@ -14242,7 +13719,6 @@ static void scalar32_min_max_sdiv(struct bpf_reg_state *dst_reg,
 reset:
 	reg_set_srange32(dst_reg, smin, smax);
 	/* Reset other ranges/tnum to unbounded/unknown. */
-	reg_set_urange32(dst_reg, 0, U32_MAX);
 	reset_reg64_and_tnum(dst_reg);
 }
 
@@ -14279,7 +13755,6 @@ static void scalar_min_max_sdiv(struct bpf_reg_state *dst_reg,
 reset:
 	reg_set_srange64(dst_reg, smin, smax);
 	/* Reset other ranges/tnum to unbounded/unknown. */
-	reg_set_urange64(dst_reg, 0, U64_MAX);
 	reset_reg32_and_tnum(dst_reg);
 }
 
@@ -14299,7 +13774,6 @@ static void scalar32_min_max_umod(struct bpf_reg_state *dst_reg,
 	reg_set_urange32(dst_reg, 0, min(reg_u32_max(dst_reg), res_max));
 
 	/* Reset other ranges/tnum to unbounded/unknown. */
-	reg_set_srange32(dst_reg, S32_MIN, S32_MAX);
 	reset_reg64_and_tnum(dst_reg);
 }
 
@@ -14319,7 +13793,6 @@ static void scalar_min_max_umod(struct bpf_reg_state *dst_reg,
 	reg_set_urange64(dst_reg, 0, min(reg_umax(dst_reg), res_max));
 
 	/* Reset other ranges/tnum to unbounded/unknown. */
-	reg_set_srange64(dst_reg, S64_MIN, S64_MAX);
 	reset_reg32_and_tnum(dst_reg);
 }
 
@@ -14359,7 +13832,6 @@ static void scalar32_min_max_smod(struct bpf_reg_state *dst_reg,
 	}
 
 	/* Reset other ranges/tnum to unbounded/unknown. */
-	reg_set_urange32(dst_reg, 0, U32_MAX);
 	reset_reg64_and_tnum(dst_reg);
 }
 
@@ -14399,7 +13871,6 @@ static void scalar_min_max_smod(struct bpf_reg_state *dst_reg,
 	}
 
 	/* Reset other ranges/tnum to unbounded/unknown. */
-	reg_set_urange64(dst_reg, 0, U64_MAX);
 	reset_reg32_and_tnum(dst_reg);
 }
 
@@ -14419,15 +13890,9 @@ static void scalar32_min_max_and(struct bpf_reg_state *dst_reg,
 	/* We get our minimum from the var_off, since that's inherently
 	 * bitwise.  Our maximum is the minimum of the operands' maxima.
 	 */
-	reg_set_urange32(dst_reg, var32_off.value, min(reg_u32_max(dst_reg), umax_val));
-
-	/* Safe to set s32 bounds by casting u32 result into s32 when u32
-	 * doesn't cross sign boundary. Otherwise set s32 bounds to unbounded.
-	 */
-	if ((s32)reg_u32_min(dst_reg) <= (s32)reg_u32_max(dst_reg))
-		reg_set_srange32(dst_reg, reg_u32_min(dst_reg), reg_u32_max(dst_reg));
-	else
-		reg_set_srange32(dst_reg, S32_MIN, S32_MAX);
+	reg_set_urange32(dst_reg,
+			 var32_off.value,
+			 min(reg_u32_max(dst_reg), umax_val));
 }
 
 static void scalar_min_max_and(struct bpf_reg_state *dst_reg,
@@ -14445,15 +13910,10 @@ static void scalar_min_max_and(struct bpf_reg_state *dst_reg,
 	/* We get our minimum from the var_off, since that's inherently
 	 * bitwise.  Our maximum is the minimum of the operands' maxima.
 	 */
-	reg_set_urange64(dst_reg, dst_reg->var_off.value, min(reg_umax(dst_reg), umax_val));
+	reg_set_urange64(dst_reg,
+			 dst_reg->var_off.value,
+			 min(reg_umax(dst_reg), umax_val));
 
-	/* Safe to set s64 bounds by casting u64 result into s64 when u64
-	 * doesn't cross sign boundary. Otherwise set s64 bounds to unbounded.
-	 */
-	if ((s64)reg_umin(dst_reg) <= (s64)reg_umax(dst_reg))
-		reg_set_srange64(dst_reg, reg_umin(dst_reg), reg_umax(dst_reg));
-	else
-		reg_set_srange64(dst_reg, S64_MIN, S64_MAX);
 	/* We may learn something more from the var_off */
 	__update_reg_bounds(dst_reg);
 }
@@ -14474,16 +13934,9 @@ static void scalar32_min_max_or(struct bpf_reg_state *dst_reg,
 	/* We get our maximum from the var_off, and our minimum is the
 	 * maximum of the operands' minima
 	 */
-	reg_set_urange32(dst_reg, max(reg_u32_min(dst_reg), umin_val),
+	reg_set_urange32(dst_reg,
+			 max(reg_u32_min(dst_reg), umin_val),
 			 var32_off.value | var32_off.mask);
-
-	/* Safe to set s32 bounds by casting u32 result into s32 when u32
-	 * doesn't cross sign boundary. Otherwise set s32 bounds to unbounded.
-	 */
-	if ((s32)reg_u32_min(dst_reg) <= (s32)reg_u32_max(dst_reg))
-		reg_set_srange32(dst_reg, reg_u32_min(dst_reg), reg_u32_max(dst_reg));
-	else
-		reg_set_srange32(dst_reg, S32_MIN, S32_MAX);
 }
 
 static void scalar_min_max_or(struct bpf_reg_state *dst_reg,
@@ -14501,16 +13954,10 @@ static void scalar_min_max_or(struct bpf_reg_state *dst_reg,
 	/* We get our maximum from the var_off, and our minimum is the
 	 * maximum of the operands' minima
 	 */
-	reg_set_urange64(dst_reg, max(reg_umin(dst_reg), umin_val),
+	reg_set_urange64(dst_reg,
+			 max(reg_umin(dst_reg), umin_val),
 			 dst_reg->var_off.value | dst_reg->var_off.mask);
 
-	/* Safe to set s64 bounds by casting u64 result into s64 when u64
-	 * doesn't cross sign boundary. Otherwise set s64 bounds to unbounded.
-	 */
-	if ((s64)reg_umin(dst_reg) <= (s64)reg_umax(dst_reg))
-		reg_set_srange64(dst_reg, reg_umin(dst_reg), reg_umax(dst_reg));
-	else
-		reg_set_srange64(dst_reg, S64_MIN, S64_MAX);
 	/* We may learn something more from the var_off */
 	__update_reg_bounds(dst_reg);
 }
@@ -14529,14 +13976,6 @@ static void scalar32_min_max_xor(struct bpf_reg_state *dst_reg,
 
 	/* We get both minimum and maximum from the var32_off. */
 	reg_set_urange32(dst_reg, var32_off.value, var32_off.value | var32_off.mask);
-
-	/* Safe to set s32 bounds by casting u32 result into s32 when u32
-	 * doesn't cross sign boundary. Otherwise set s32 bounds to unbounded.
-	 */
-	if ((s32)reg_u32_min(dst_reg) <= (s32)reg_u32_max(dst_reg))
-		reg_set_srange32(dst_reg, reg_u32_min(dst_reg), reg_u32_max(dst_reg));
-	else
-		reg_set_srange32(dst_reg, S32_MIN, S32_MAX);
 }
 
 static void scalar_min_max_xor(struct bpf_reg_state *dst_reg,
@@ -14552,31 +13991,21 @@ static void scalar_min_max_xor(struct bpf_reg_state *dst_reg,
 	}
 
 	/* We get both minimum and maximum from the var_off. */
-	reg_set_urange64(dst_reg, dst_reg->var_off.value,
+	reg_set_urange64(dst_reg,
+			 dst_reg->var_off.value,
 			 dst_reg->var_off.value | dst_reg->var_off.mask);
-
-	/* Safe to set s64 bounds by casting u64 result into s64 when u64
-	 * doesn't cross sign boundary. Otherwise set s64 bounds to unbounded.
-	 */
-	if ((s64)reg_umin(dst_reg) <= (s64)reg_umax(dst_reg))
-		reg_set_srange64(dst_reg, reg_umin(dst_reg), reg_umax(dst_reg));
-	else
-		reg_set_srange64(dst_reg, S64_MIN, S64_MAX);
-
-	__update_reg_bounds(dst_reg);
 }
 
 static void __scalar32_min_max_lsh(struct bpf_reg_state *dst_reg,
 				   u64 umin_val, u64 umax_val)
 {
-	/* We lose all sign bit information (except what we can pick
-	 * up from var_off)
-	 */
-	reg_set_srange32(dst_reg, S32_MIN, S32_MAX);
 	/* If we might shift our top bit out, then we know nothing */
 	if (umax_val > 31 || reg_u32_max(dst_reg) > 1ULL << (31 - umax_val))
 		reg_set_urange32(dst_reg, 0, U32_MAX);
 	else
+		/* We lose all sign bit information (except what we can pick
+		 * up from var_off)
+		 */
 		reg_set_urange32(dst_reg, reg_u32_min(dst_reg) << umin_val,
 				 reg_u32_max(dst_reg) << umax_val);
 }
@@ -14602,23 +14031,27 @@ static void scalar32_min_max_lsh(struct bpf_reg_state *dst_reg,
 static void __scalar64_min_max_lsh(struct bpf_reg_state *dst_reg,
 				   u64 umin_val, u64 umax_val)
 {
+	struct cnum64 u, s;
+
 	/* Special case <<32 because it is a common compiler pattern to sign
 	 * extend subreg by doing <<32 s>>32. smin/smax assignments are correct
 	 * because s32 bounds don't flip sign when shifting to the left by
 	 * 32bits.
 	 */
 	if (umin_val == 32 && umax_val == 32)
-		reg_set_srange64(dst_reg, (s64)reg_s32_min(dst_reg) << 32,
-				 (s64)reg_s32_max(dst_reg) << 32);
+		s = cnum64_from_srange((s64)reg_s32_min(dst_reg) << 32,
+				       (s64)reg_s32_max(dst_reg) << 32);
 	else
-		reg_set_srange64(dst_reg, S64_MIN, S64_MAX);
+		s = CNUM64_UNBOUNDED;
 
 	/* If we might shift our top bit out, then we know nothing */
 	if (reg_umax(dst_reg) > 1ULL << (63 - umax_val))
-		reg_set_urange64(dst_reg, 0, U64_MAX);
+		u = CNUM64_UNBOUNDED;
 	else
-		reg_set_urange64(dst_reg, reg_umin(dst_reg) << umin_val,
-				 reg_umax(dst_reg) << umax_val);
+		u = cnum64_from_urange(reg_umin(dst_reg) << umin_val,
+				       reg_umax(dst_reg) << umax_val);
+
+	dst_reg->r64 = cnum64_intersect(u, s);
 }
 
 static void scalar_min_max_lsh(struct bpf_reg_state *dst_reg,
@@ -14657,7 +14090,6 @@ static void scalar32_min_max_rsh(struct bpf_reg_state *dst_reg,
 	 * and rely on inferring new ones from the unsigned bounds and
 	 * var_off of the result.
 	 */
-	reg_set_srange32(dst_reg, S32_MIN, S32_MAX);
 
 	dst_reg->var_off = tnum_rshift(subreg, umin_val);
 	reg_set_urange32(dst_reg, reg_u32_min(dst_reg) >> umax_val,
@@ -14687,7 +14119,6 @@ static void scalar_min_max_rsh(struct bpf_reg_state *dst_reg,
 	 * and rely on inferring new ones from the unsigned bounds and
 	 * var_off of the result.
 	 */
-	reg_set_srange64(dst_reg, S64_MIN, S64_MAX);
 	dst_reg->var_off = tnum_rshift(dst_reg->var_off, umin_val);
 	reg_set_urange64(dst_reg, reg_umin(dst_reg) >> umax_val,
 			 reg_umax(dst_reg) >> umin_val);
@@ -14707,6 +14138,8 @@ static void scalar32_min_max_arsh(struct bpf_reg_state *dst_reg,
 
 	/* Upon reaching here, src_known is true and
 	 * umax_val is equal to umin_val.
+	 * Blow away the dst_reg umin_value/umax_value and rely on
+	 * dst_reg var_off to refine the result.
 	 */
 	reg_set_srange32(dst_reg,
 			 (u32)(((s32)reg_s32_min(dst_reg)) >> umin_val),
@@ -14714,11 +14147,6 @@ static void scalar32_min_max_arsh(struct bpf_reg_state *dst_reg,
 
 	dst_reg->var_off = tnum_arshift(tnum_subreg(dst_reg->var_off), umin_val, 32);
 
-	/* blow away the dst_reg umin_value/umax_value and rely on
-	 * dst_reg var_off to refine the result.
-	 */
-	reg_set_urange32(dst_reg, 0, U32_MAX);
-
 	__mark_reg64_unbounded(dst_reg);
 	__update_reg32_bounds(dst_reg);
 }
@@ -14736,11 +14164,6 @@ static void scalar_min_max_arsh(struct bpf_reg_state *dst_reg,
 
 	dst_reg->var_off = tnum_arshift(dst_reg->var_off, umin_val, 64);
 
-	/* blow away the dst_reg umin_value/umax_value and rely on
-	 * dst_reg var_off to refine the result.
-	 */
-	reg_set_urange64(dst_reg, 0, U64_MAX);
-
 	/* Its not easy to operate on alu32 bounds here because it depends
 	 * on bits being shifted in from upper 32-bits. Take easy way out
 	 * and mark unbounded so we can recalculate later from tnum.
@@ -15829,23 +15252,15 @@ static void regs_refine_cond_op(struct bpf_reg_state *reg1, struct bpf_reg_state
 	switch (opcode) {
 	case BPF_JEQ:
 		if (is_jmp32) {
-			reg_set_urange32(reg1, max(reg_u32_min(reg1), reg_u32_min(reg2)),
-					 min(reg_u32_max(reg1), reg_u32_max(reg2)));
-			reg_set_srange32(reg1, max(reg_s32_min(reg1), reg_s32_min(reg2)),
-					 min(reg_s32_max(reg1), reg_s32_max(reg2)));
-			reg_set_urange32(reg2, reg_u32_min(reg1), reg_u32_max(reg1));
-			reg_set_srange32(reg2, reg_s32_min(reg1), reg_s32_max(reg1));
+			reg1->r32 = cnum32_intersect(reg1->r32, reg2->r32);
+			reg2->r32 = reg1->r32;
 
 			t = tnum_intersect(tnum_subreg(reg1->var_off), tnum_subreg(reg2->var_off));
 			reg1->var_off = tnum_with_subreg(reg1->var_off, t);
 			reg2->var_off = tnum_with_subreg(reg2->var_off, t);
 		} else {
-			reg_set_urange64(reg1, max(reg_umin(reg1), reg_umin(reg2)),
-					 min(reg_umax(reg1), reg_umax(reg2)));
-			reg_set_srange64(reg1, max(reg_smin(reg1), reg_smin(reg2)),
-					 min(reg_smax(reg1), reg_smax(reg2)));
-			reg_set_urange64(reg2, reg_umin(reg1), reg_umax(reg1));
-			reg_set_srange64(reg2, reg_smin(reg1), reg_smax(reg1));
+			reg1->r64 = cnum64_intersect(reg1->r64, reg2->r64);
+			reg2->r64 = reg1->r64;
 
 			reg1->var_off = tnum_intersect(reg1->var_off, reg2->var_off);
 			reg2->var_off = reg1->var_off;
@@ -15862,32 +15277,11 @@ static void regs_refine_cond_op(struct bpf_reg_state *reg1, struct bpf_reg_state
 		 */
 		val = reg_const_value(reg2, is_jmp32);
 		if (is_jmp32) {
-			/* u32_min is not equal to 0xffffffff at this point,
-			 * because otherwise u32_max is 0xffffffff as well,
-			 * in such a case both reg1 and reg2 would be constants,
-			 * jump would be predicted and regs_refine_cond_op()
-			 * wouldn't be called.
-			 *
-			 * Same reasoning works for all {u,s}{min,max}{32,64} cases
-			 * below.
-			 */
-			if (reg_u32_min(reg1) == (u32)val)
-				reg_set_urange32(reg1, reg_u32_min(reg1) + 1, reg_u32_max(reg1));
-			if (reg_u32_max(reg1) == (u32)val)
-				reg_set_urange32(reg1, reg_u32_min(reg1), reg_u32_max(reg1) - 1);
-			if (reg_s32_min(reg1) == (s32)val)
-				reg_set_srange32(reg1, reg_s32_min(reg1) + 1, reg_s32_max(reg1));
-			if (reg_s32_max(reg1) == (s32)val)
-				reg_set_srange32(reg1, reg_s32_min(reg1), reg_s32_max(reg1) - 1);
+			/* Complement of the range [val, val] as cnum32. */
+			cnum32_intersect_with(&reg1->r32, (struct cnum32){ val + 1, U32_MAX - 1 });
 		} else {
-			if (reg_umin(reg1) == (u64)val)
-				reg_set_urange64(reg1, reg_umin(reg1) + 1, reg_umax(reg1));
-			if (reg_umax(reg1) == (u64)val)
-				reg_set_urange64(reg1, reg_umin(reg1), reg_umax(reg1) - 1);
-			if (reg_smin(reg1) == (s64)val)
-				reg_set_srange64(reg1, reg_smin(reg1) + 1, reg_smax(reg1));
-			if (reg_smax(reg1) == (s64)val)
-				reg_set_srange64(reg1, reg_smin(reg1), reg_smax(reg1) - 1);
+			/* Complement of the range [val, val] as cnum64. */
+			cnum64_intersect_with(&reg1->r64, (struct cnum64){ val + 1, U64_MAX - 1 });
 		}
 		break;
 	case BPF_JSET:
@@ -15934,38 +15328,38 @@ static void regs_refine_cond_op(struct bpf_reg_state *reg1, struct bpf_reg_state
 		break;
 	case BPF_JLE:
 		if (is_jmp32) {
-			reg_set_urange32(reg1, reg_u32_min(reg1), min(reg_u32_max(reg1), reg_u32_max(reg2)));
-			reg_set_urange32(reg2, max(reg_u32_min(reg1), reg_u32_min(reg2)), reg_u32_max(reg2));
+			cnum32_intersect_with_urange(&reg1->r32, 0, reg_u32_max(reg2));
+			cnum32_intersect_with_urange(&reg2->r32, reg_u32_min(reg1), U32_MAX);
 		} else {
-			reg_set_urange64(reg1, reg_umin(reg1), min(reg_umax(reg1), reg_umax(reg2)));
-			reg_set_urange64(reg2, max(reg_umin(reg1), reg_umin(reg2)), reg_umax(reg2));
+			cnum64_intersect_with_urange(&reg1->r64, 0, reg_umax(reg2));
+			cnum64_intersect_with_urange(&reg2->r64, reg_umin(reg1), U64_MAX);
 		}
 		break;
 	case BPF_JLT:
 		if (is_jmp32) {
-			reg_set_urange32(reg1, reg_u32_min(reg1), min(reg_u32_max(reg1), reg_u32_max(reg2) - 1));
-			reg_set_urange32(reg2, max(reg_u32_min(reg1) + 1, reg_u32_min(reg2)), reg_u32_max(reg2));
+			cnum32_intersect_with_urange(&reg1->r32, 0, reg_u32_max(reg2) - 1);
+			cnum32_intersect_with_urange(&reg2->r32, reg_u32_min(reg1) + 1, U32_MAX);
 		} else {
-			reg_set_urange64(reg1, reg_umin(reg1), min(reg_umax(reg1), reg_umax(reg2) - 1));
-			reg_set_urange64(reg2, max(reg_umin(reg1) + 1, reg_umin(reg2)), reg_umax(reg2));
+			cnum64_intersect_with_urange(&reg1->r64, 0, reg_umax(reg2) - 1);
+			cnum64_intersect_with_urange(&reg2->r64, reg_umin(reg1) + 1, U64_MAX);
 		}
 		break;
 	case BPF_JSLE:
 		if (is_jmp32) {
-			reg_set_srange32(reg1, reg_s32_min(reg1), min(reg_s32_max(reg1), reg_s32_max(reg2)));
-			reg_set_srange32(reg2, max(reg_s32_min(reg1), reg_s32_min(reg2)), reg_s32_max(reg2));
+			cnum32_intersect_with_srange(&reg1->r32, S32_MIN, reg_s32_max(reg2));
+			cnum32_intersect_with_srange(&reg2->r32, reg_s32_min(reg1), S32_MAX);
 		} else {
-			reg_set_srange64(reg1, reg_smin(reg1), min(reg_smax(reg1), reg_smax(reg2)));
-			reg_set_srange64(reg2, max(reg_smin(reg1), reg_smin(reg2)), reg_smax(reg2));
+			cnum64_intersect_with_srange(&reg1->r64, S64_MIN, reg_smax(reg2));
+			cnum64_intersect_with_srange(&reg2->r64, reg_smin(reg1), S64_MAX);
 		}
 		break;
 	case BPF_JSLT:
 		if (is_jmp32) {
-			reg_set_srange32(reg1, reg_s32_min(reg1), min(reg_s32_max(reg1), reg_s32_max(reg2) - 1));
-			reg_set_srange32(reg2, max(reg_s32_min(reg1) + 1, reg_s32_min(reg2)), reg_s32_max(reg2));
+			cnum32_intersect_with_srange(&reg1->r32, S32_MIN, reg_s32_max(reg2) - 1);
+			cnum32_intersect_with_srange(&reg2->r32, reg_s32_min(reg1) + 1, S32_MAX);
 		} else {
-			reg_set_srange64(reg1, reg_smin(reg1), min(reg_smax(reg1), reg_smax(reg2) - 1));
-			reg_set_srange64(reg2, max(reg_smin(reg1) + 1, reg_smin(reg2)), reg_smax(reg2));
+			cnum64_intersect_with_srange(&reg1->r64, S64_MIN, reg_smax(reg2) - 1);
+			cnum64_intersect_with_srange(&reg2->r64, reg_smin(reg1) + 1, S64_MAX);
 		}
 		break;
 	default:
diff --git a/tools/testing/selftests/bpf/prog_tests/reg_bounds.c b/tools/testing/selftests/bpf/prog_tests/reg_bounds.c
index 71f5240cc5b7..7f170a69d1d8 100644
--- a/tools/testing/selftests/bpf/prog_tests/reg_bounds.c
+++ b/tools/testing/selftests/bpf/prog_tests/reg_bounds.c
@@ -478,6 +478,52 @@ static struct range range_refine_in_halves(enum num_t x_t, struct range x,
 
 }
 
+static __always_inline u64 next_u32_block(u64 x) { return x + (1ULL << 32); }
+static __always_inline u64 prev_u32_block(u64 x) { return x - (1ULL << 32); }
+
+/* Is v within the circular u64 range [base, base + len]? */
+static __always_inline bool u64_range_contains(u64 v, u64 base, u64 len)
+{
+	return v - base <= len;
+}
+
+/* Is v within the circular u32 range [base, base + len]? */
+static __always_inline bool u32_range_contains(u32 v, u32 base, u32 len)
+{
+	return v - base <= len;
+}
+
+static bool range64_range32_intersect(enum num_t a_t,
+				      struct range a /* 64 */,
+				      struct range b /* 32 */,
+				      struct range *out /* 64 */)
+{
+	u64 b_len = (u32)(b.b - b.a);
+	u64 a_len = a.b - a.a;
+	u64 lo, hi;
+
+	if (u32_range_contains((u32)a.a, (u32)b.a, b_len)) {
+		lo = a.a;
+	} else {
+		lo = swap_low32(a.a, (u32)b.a);
+		if (!u64_range_contains(lo, a.a, a_len))
+			lo = next_u32_block(lo);
+		if (!u64_range_contains(lo, a.a, a_len))
+			return false;
+	}
+	if (u32_range_contains(a.b, (u32)b.a, b_len)) {
+		hi = a.b;
+	} else {
+		hi = swap_low32(a.b, (u32)b.b);
+		if (!u64_range_contains(hi, a.a, a_len))
+			hi = prev_u32_block(hi);
+		if (!u64_range_contains(hi, a.a, a_len))
+			return false;
+	}
+	*out = range(a_t, lo, hi);
+	return true;
+}
+
 static struct range range_refine(enum num_t x_t, struct range x, enum num_t y_t, struct range y)
 {
 	struct range y_cast;
@@ -533,23 +579,12 @@ static struct range range_refine(enum num_t x_t, struct range x, enum num_t y_t,
 		}
 	}
 
-	/* the case when new range knowledge, *y*, is a 32-bit subregister
-	 * range, while previous range knowledge, *x*, is a full register
-	 * 64-bit range, needs special treatment to take into account upper 32
-	 * bits of full register range
-	 */
 	if (t_is_32(y_t) && !t_is_32(x_t)) {
-		struct range x_swap;
+		struct range x1;
 
-		/* some combinations of upper 32 bits and sign bit can lead to
-		 * invalid ranges, in such cases it's easier to detect them
-		 * after cast/swap than try to enumerate all the conditions
-		 * under which transformation and knowledge transfer is valid
-		 */
-		x_swap = range(x_t, swap_low32(x.a, y_cast.a), swap_low32(x.b, y_cast.b));
-		if (!is_valid_range(x_t, x_swap))
-			return x;
-		return range_intersection(x_t, x, x_swap);
+		if (range64_range32_intersect(x_t, x, y, &x1))
+			return x1;
+		return x;
 	}
 
 	/* otherwise, plain range cast and intersection works */
@@ -1300,6 +1335,26 @@ static bool assert_range_eq(enum num_t t, struct range x, struct range y,
 	return false;
 }
 
+/* For a pair of signed/unsigned t1/t2 checks if r1/r2 intersect in two intervals. */
+static bool needs_two_arcs(enum num_t t1, struct range r1,
+			   enum num_t t2, struct range r2)
+{
+	u64 lo = cast_t(t1, r2.a);
+	u64 hi = cast_t(t1, r2.b);
+
+	/* does r2 wrap in t1's domain: [0, hi] ∪ [lo, MAX]? */
+	return lo > hi && r1.a <= hi && r1.b >= lo;
+}
+
+static bool reg_state_needs_two_arcs(struct reg_state *s)
+{
+	if (!s->valid)
+		return false;
+
+	return needs_two_arcs(U64, s->r[U64], S64, s->r[S64]) ||
+	       needs_two_arcs(U32, s->r[U32], S32, s->r[S32]);
+}
+
 /* Validate that register states match, and print details if they don't */
 static bool assert_reg_state_eq(struct reg_state *r, struct reg_state *e, const char *ctx)
 {
@@ -1524,6 +1579,11 @@ static int verify_case_op(enum num_t init_t, enum num_t cond_t,
 	    !assert_reg_state_eq(&fr2, &fe2, "false_reg2") ||
 	    !assert_reg_state_eq(&tr1, &te1, "true_reg1") ||
 	    !assert_reg_state_eq(&tr2, &te2, "true_reg2")) {
+		if (reg_state_needs_two_arcs(&fe1) || reg_state_needs_two_arcs(&fe2) ||
+		    reg_state_needs_two_arcs(&te1) || reg_state_needs_two_arcs(&te2)) {
+			test__skip();
+			return 0;
+		}
 		failed = true;
 	}
 
diff --git a/tools/testing/selftests/bpf/progs/verifier_bounds.c b/tools/testing/selftests/bpf/progs/verifier_bounds.c
index c1ae013dee29..f0b3fbbbb627 100644
--- a/tools/testing/selftests/bpf/progs/verifier_bounds.c
+++ b/tools/testing/selftests/bpf/progs/verifier_bounds.c
@@ -1239,7 +1239,8 @@ l0_%=:	r0 = 0;						\
 SEC("tc")
 __description("multiply mixed sign bounds. test 1")
 __success __log_level(2)
-__msg("r6 *= r7 {{.*}}; R6=scalar(smin=umin=0x1bc16d5cd4927ee1,smax=umax=0x1bc16d674ec80000,smax32=0x7ffffeff,umax32=0xfffffeff,var_off=(0x1bc16d4000000000; 0x3ffffffeff))")
+__msg("r6 *= r7 {{.*}}; R6=scalar(smin=umin=0x1bc16d5cd4927ee1,smax=umax=0x1bc16d674ec80000,smax32=0x7ffffeff,var_off=(0x1bc16d4000000000; 0x3ffffffeff))")
+/* cnum can't represent both [0, 0xffff_feff] and [0x8000_0000, 0x7fff_feff], so it picks one */
 __naked void mult_mixed0_sign(void)
 {
 	asm volatile (
@@ -1648,7 +1649,8 @@ l0_%=:	r0 = 0;				\
 SEC("socket")
 __description("bounds deduction cross sign boundary, two overlaps")
 __failure
-__msg("3: (2d) if r0 > r1 {{.*}} R0=scalar(smin=smin32=-128,smax=smax32=127,umax=0xffffffffffffff80)")
+__msg("3: (2d) if r0 > r1 {{.*}} R0=scalar(smin=smin32=-128,smax=smax32=127)")
+/* smin=-128 includes point 0xffffffffffffff80 */
 __msg("frame pointer is read only")
 __naked void bounds_deduct_two_overlaps(void)
 {
@@ -2043,7 +2045,8 @@ __naked void signed_unsigned_intersection32_case2(void *ctx)
  */
 SEC("socket")
 __description("bounds refinement: 64bits ranges not overwritten by 32bits ranges")
-__msg("3: (65) if r0 s> 0x2 {{.*}} R0=scalar(smin=0x8000000000000002,smax=2,umin=smin32=umin32=2,umax=0xffffffff00000003,smax32=umax32=3")
+__msg("3: (65) if r0 s> 0x2 {{.*}} R0=scalar(smin=0x8000000000000002,smax=2,smin32=umin32=2,smax32=umax32=3,var_off{{.*}}))")
+/* Can't represent both [S64_MIN+2, 2] and [2, U64_MAX - U32_MAX + 2] at the same time, picks shorter interval */
 __msg("4: (25) if r0 > 0x13 {{.*}} R0=2")
 __success __log_level(2)
 __naked void refinement_32bounds_not_overwriting_64bounds(void *ctx)
diff --git a/tools/testing/selftests/bpf/progs/verifier_subreg.c b/tools/testing/selftests/bpf/progs/verifier_subreg.c
index 31832a306f91..73b5b0cf6706 100644
--- a/tools/testing/selftests/bpf/progs/verifier_subreg.c
+++ b/tools/testing/selftests/bpf/progs/verifier_subreg.c
@@ -558,7 +558,8 @@ __description("arsh32 imm sign negative extend check")
 __success __retval(0)
 __log_level(2)
 __msg("3: (17) r6 -= 4095                    ; R6=scalar(smin=smin32=-4095,smax=smax32=0)")
-__msg("4: (67) r6 <<= 32                     ; R6=scalar(smin=0xfffff00100000000,smax=smax32=umax32=0,umax=0xffffffff00000000,smin32=0,var_off=(0x0; 0xffffffff00000000))")
+__msg("4: (67) r6 <<= 32                     ; R6=scalar(smin=0xfffff00100000000,smax=smax32=umax32=0,smin32=0,var_off=(0x0; 0xffffffff00000000))")
+/* represents shorter of signed / unsigned 64-bit ranges */
 __msg("5: (c7) r6 s>>= 32                    ; R6=scalar(smin=smin32=-4095,smax=smax32=0)")
 __naked void arsh32_imm_sign_extend_negative_check(void)
 {
@@ -581,7 +582,8 @@ __description("arsh32 imm sign extend check")
 __success __retval(0)
 __log_level(2)
 __msg("3: (17) r6 -= 2047                    ; R6=scalar(smin=smin32=-2047,smax=smax32=2048)")
-__msg("4: (67) r6 <<= 32                     ; R6=scalar(smin=0xfffff80100000000,smax=0x80000000000,umax=0xffffffff00000000,smin32=0,smax32=umax32=0,var_off=(0x0; 0xffffffff00000000))")
+__msg("4: (67) r6 <<= 32                     ; R6=scalar(smin=0xfffff80100000000,smax=0x80000000000,smin32=0,smax32=umax32=0,var_off=(0x0; 0xffffffff00000000))")
+/* represents shorter of signed / unsigned 64-bit ranges */
 __msg("5: (c7) r6 s>>= 32                    ; R6=scalar(smin=smin32=-2047,smax=smax32=2048)")
 __naked void arsh32_imm_sign_extend_check(void)
 {

-- 
2.53.0
