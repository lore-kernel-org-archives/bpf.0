Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794206898;
	b=ExNW62w2rmRzRafMKfTlXmw/nCQaUz+cfEzyE6brCJhz0zswg3OtBxofNblJeQ62EfX/
	 xioIfWkJLvJxVDyVmHpppGTXINMkrfEOUgbPGr2E/F9NITC5/zwvatC2rIsJDe4bwG4Yj
	 W2hW73fsfJ8ClkfxcOqIREdJuNeHriNhGdlRHGm7DYfZAaSjgVvfPKrAsM3wflzTaU3gT
	 Ju0SmyhVmvrS1OCYAQDFpN9LFhUMFr53qmEanBR47dF68LQjtI4HR+dSYaapRap5YanBN
	 nkDrJ/1wlpTe/rEubtesMnrjmL4bG2irx4+eh/azKVyhUrqFabulaviGmMbYZjBI22w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794206898;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=OkpeMu+uswjZKtmq8ik3E24OrXbZMprFiNr5i3iykis=;
	b=XinXgAXaog5C8JhXqKWOU9F4K3bCyUEwvWp8CgANkjereJVRvpyQS5NDiW7t+Kjn3vDC
	 5FyVX+5WxOJTPKE+UE5+uYfXKmv7pVu5ZKh6Ge9xyG+ZctxnEH1xIYLYJaClLuBZPeFLF
	 Akd1pm5ZfijDz1e58CnQBVUYL5ISfU/V01QnTVrq1ulzUxoaQ2zi7kBox3GLC6LftTBbF
	 +bfpfOEP1NobL6eNN8uvxSmZmYW0RYXMs4/P2cnDPVd2cpVGIQgfa5bxXi2hAF1yblacy
	 QX9gHmtbTlci54HFs+ZXWFjuc6HxmzOfe5FfifPvKg8vIe1NJGE6axjojhKCs/t5gDw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ocCf8gnA;
	arc=none smtp.remote-ip=209.85.216.45
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3554E606A31C
	for <bpf@vger.kernel.org>; Mon,  9 Nov 2026 06:48:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3554E606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ocCf8gnA
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-3b09a83d12aso343624a91.2
        for <bpf@vger.kernel.org>; Sun, 08 Nov 2026 22:48:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794206897; x=1794811697; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OkpeMu+uswjZKtmq8ik3E24OrXbZMprFiNr5i3iykis=;
        b=ocCf8gnAqbqOIwGfpbCLjfJm3sXSgGAIDu83AqaQI13UwlZOHeLKGYVlQPbDEXPtau
         6XCWkr8lgFfGT9qHzWNCO1zdv0WUWqDW56fXj+Wxu51IvXdNGY07WFW2ij30+n7TiyQn
         3HQMcdAn3lWJfgpVZxz4VJlY/4tp+p2zxbSHDD2/N2WlU6H5N30nMrCtMIDu4xZioVP5
         YGvTGIQtmUfMrGlqpCnxTd0CXBOeSvktrawToLOfZXDJGX8g3AOA0V3dtyJhHJtM8O5p
         7BkZ6NE2rvG1FJ5Vu0RZENXSg9rTof2ZSjEC01BKYprl2ZN4hxsrffrrB7FkJDZnHLMp
         Sq1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794206897; x=1794811697;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=OkpeMu+uswjZKtmq8ik3E24OrXbZMprFiNr5i3iykis=;
        b=0pJGhmLRGdYu9/9ytF93/uGdlKNtA4Iiw++0euzyGS+m2U/gMNG+hnt3+TnKM5o6qz
         DL7SIcOpj4Soq1R8wyZACJ5uUxDIAf72MqZeEcEcAIuwlx1TOcrLeRpMfRLX1YJh3PT/
         aC3mhRW/yf0q1artz3amNx+8GRB0nXlyhSeEnGg2bAteyzva15gBq1b+ZbA+vetv47tr
         qhxsQRR0HmlgqMVE5iUgT8WtMvLEtmsTVR6Pa60xcdfYe4354ezrGL6H4DCofUjz5F4U
         78+TdCcrJUFgbDIMg7NpiwHYvBIY+iMR3imKqmtpJ/D216pR7mBYqmkbWh2kY2tCvhzL
         I3bQ==
X-Gm-Message-State: APuU4Z82/pYxnbf1Ku1UE3wBxICOpgK1it1+rA5ggKK2GQi5Wxs+LJLm
	uRBKnoDJqUXfun0U2ugVJS/4PDL0ma/J0lyIj9YXsl1aABM6jG7MI5oWOSembA==
X-Gm-Gg: AYBFou26mGBRpeU+eazvOOAVF+j+a6Ccf87dxf6XU5ZC8KTle9mIiMg0Fp7bs0cEnAE
	/sL9XSvKJJONMTV0RLzQFBqKuTnRA7tibUDBjcjm/nYZq6+RUXMQ4HQ0dd2+ktddHB1xpHr9HCv
	bAHhWLf8e5H83bfpQRMsH7ZKQ7e1PmnNKzBLmqqxa0Eh9fWIHQyJY88diPx/5VDz+Xgp1nj639C
	N4uLO2oCf2pvS+ZzmB1LMf7pMgJ1zLsB3ydfaryY3UF1hV4JNecWw3pBxqWrwUQfngLmNOaA7ti
	C3vNVIR98zla1LsT3obhHqQKR87W3PiQak8z6dRlmlLVXS6VCsambHv47eYo09CKQxXPKOsR2qr
	BRMVO+UUJG/jgDPWjp2HpDZy+oJbH/akuMiqlawUw4MggNv62ucbcHHRYpUBKXUsuEecsL7mqXO
	8kwsAuRdl4mzFBSd8jNb6WKTB3AXHJnsQwRwMlyWYNt3mXh7J3JVXh8/mQe/0wRb3ZCg0q4gxUM
	soBvgeXcuku/IryNOlI6PlDzuVKOHspMQ0P1O2n8OrOiFKdvCwv1EcYAHYzX/iqW7ROBDAP+qyN
	O4Tw9K+li+dA3dZa4Srz/rxXlXcHvVd3X38LKvGDpOQ6QbhZJPYN2EqwAWkUeEICVrlwdlRhr9V
	HKWsBsNjpIixXalRSY9PaOtCJFPan5t5u4irvHjPdXPvOjBZiG6GXnxwTgK+b3J7W6m4uUY+WiA
	==
X-Received: by 2002:a17:90a:d007:b0:3b0:9b3c:4434 with SMTP id 98e67ed59e1d1-3b12d4ae6e8mr2955887a91.36.1794206897271;
        Sun, 08 Nov 2026 22:48:17 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.250])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b127891fa4sm5617493a91.4.2026.11.08.22.48.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 22:48:16 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next 10/26] bpf: Detect a dead branch when a range and var_off don't overlap
Date: Mon,  9 Nov 2026 06:46:54 +0000
Message-ID: <20261109064715.2382452-11-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261109064715.2382452-1-alexei.starovoitov@gmail.com>
References: <20261109064715.2382452-1-alexei.starovoitov@gmail.com>
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

A fix of the main pass that stands alone. It is also a prerequisite of the
patch that refines linked registers at conditional jumps: that patch
intersects the range of one register with var_off of another one and asks
reg_is_empty() if the intersection is empty.

  1: r0 <<= 3
  2: r0 += 5
  3: if r0 s< -2 goto pc+2
  4: if r0 s> 1 goto pc+1
  5: r0 += 3
  verifier bug: REG INVARIANTS VIOLATION (alu): range bounds violation

The low three bits of r0 are 5. No value in [-2, 1] has them: the range and
var_off don't overlap, the fall-through branch of insn 4 is dead. The
verifier takes it with an empty register, and the addition at insn 5 trips
over that.

simulate_both_branches_taken() refines the registers as each branch does
and drops a branch in which a range is empty. It relies on
reg_bounds_sync() to empty the range. __update_reg64_bounds() steps through
var_off from umin to umax, which are 0 and U64_MAX for a range that
crosses 0. __update_reg32_bounds() uses only the smallest and the largest
member of var_off.

tnum_step() returns the next member of var_off. reg_is_empty() asks for the
first one from the start of the range on and compares it with the end, in
64 and in 32 bits. A range that crosses 0 wraps around at U64_MAX or
U32_MAX: tnum_overlaps_cnum() splits it there. The test is sufficient, not
exact: 64 and 32 bits are checked each on its own.

Two tests in verifier_bounds.c, with the values above shifted left by 32:
no member of var_off is in [-2, 1] and the branch is dead, -3 is one in
[-3, 1] and the branch is verified.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/verifier.c                         | 34 +++++++++++++++++--
 .../selftests/bpf/progs/verifier_bounds.c     | 33 ++++++++++++++++++
 2 files changed, 65 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index ae3b751b99a1..83249ecbdfb1 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -2325,6 +2325,36 @@ static bool range_bounds_violation(struct bpf_reg_state *reg)
 	return cnum32_is_empty(reg->r32) || cnum64_is_empty(reg->r64);
 }
 
+/* Do @t and [min, max] overlap: is a member of @t in the range? */
+static bool tnum_overlaps_urange(struct tnum t, u64 min, u64 max)
+{
+	u64 tnum_next = tnum_step(t, min);
+
+	return (min & ~t.mask) == t.value || (tnum_next > min && tnum_next <= max);
+}
+
+/* The same for the cnum [@base, @base + @size]. It wraps around at @ut_max. */
+static bool tnum_overlaps_cnum(struct tnum t, u64 base, u64 size, u64 ut_max)
+{
+	u64 end = (base + size) & ut_max;
+
+	if (base <= end)
+		return tnum_overlaps_urange(t, base, end);
+	return tnum_overlaps_urange(t, base, ut_max) || tnum_overlaps_urange(t, 0, end);
+}
+
+/*
+ * A range and var_off don't overlap. reg_bounds_sync() compares var_off with umin and umax: it
+ * doesn't see that [-2, 1], which crosses 0, has no member with 5 in its low three bits.
+ */
+static bool reg_is_empty(struct bpf_reg_state *reg)
+{
+	return range_bounds_violation(reg) ||
+	       !tnum_overlaps_cnum(reg->var_off, reg->r64.base, reg->r64.size, U64_MAX) ||
+	       !tnum_overlaps_cnum(tnum_subreg(reg->var_off), reg->r32.base, reg->r32.size,
+				   U32_MAX);
+}
+
 static int reg_bounds_sanity_check(struct bpf_verifier_env *env,
 				   struct bpf_reg_state *reg, const char *ctx)
 {
@@ -18952,7 +18982,7 @@ static int simulate_both_branches_taken(struct bpf_verifier_env *env, u8 opcode,
 	 * reg_states in the FALSE branch (i.e. reg1, reg2), the FALSE branch must be dead. Only
 	 * TRUE branch will be taken.
 	 */
-	if (range_bounds_violation(&env->false_reg1) || range_bounds_violation(&env->false_reg2))
+	if (reg_is_empty(&env->false_reg1) || reg_is_empty(&env->false_reg2))
 		return 1;
 
 	/* Jump (TRUE) branch */
@@ -18964,7 +18994,7 @@ static int simulate_both_branches_taken(struct bpf_verifier_env *env, u8 opcode,
 	 * reg_states in the TRUE branch (i.e. true_reg1, true_reg2), the TRUE branch must be dead.
 	 * Only FALSE branch will be taken.
 	 */
-	if (range_bounds_violation(&env->true_reg1) || range_bounds_violation(&env->true_reg2))
+	if (reg_is_empty(&env->true_reg1) || reg_is_empty(&env->true_reg2))
 		return 0;
 
 	/* Both branches are possible, we can't determine which one will be taken. */
diff --git a/tools/testing/selftests/bpf/progs/verifier_bounds.c b/tools/testing/selftests/bpf/progs/verifier_bounds.c
index f55d58af8004..316e9377caa8 100644
--- a/tools/testing/selftests/bpf/progs/verifier_bounds.c
+++ b/tools/testing/selftests/bpf/progs/verifier_bounds.c
@@ -1995,6 +1995,39 @@ __naked void bounds_refinement_multiple_overlaps(void *ctx)
 	: __clobber_all);
 }
 
+/*
+ * r0 is x << 32, the low three bits of x are 5. No such x is in [-2, 1], -3 is in [-3, 1].
+ * umin and umax are unbounded for a range that crosses 0.
+ */
+#define RANGE_CROSSES_0(name, smin)		\
+__naked void name(void *ctx)			\
+{						\
+	asm volatile(				\
+	"call %[bpf_ktime_get_ns];"		\
+	"r0 <<= 35;"				\
+	"r1 = 0x500000000 ll;"			\
+	"r0 += r1;"				\
+	"r1 = " #smin " ll;"			\
+	"if r0 s< r1 goto 1f;"			\
+	"r1 = 0x100000000 ll;"			\
+	"if r0 s> r1 goto 1f;"			\
+	"r10 = 0;"				\
+"1:	exit;"					\
+	:					\
+	: __imm(bpf_ktime_get_ns)		\
+	: __clobber_all);			\
+}
+
+SEC("socket")
+__description("dead branch: tnum and a range that crosses 0 don't overlap")
+__success
+RANGE_CROSSES_0(range_crossing_0_no_tnum_overlap, -0x200000000)
+
+SEC("socket")
+__description("tnum overlaps the negative part of a range that crosses 0")
+__failure __msg("frame pointer is read only")
+RANGE_CROSSES_0(range_crossing_0_tnum_overlap_below_0, -0x300000000)
+
 SEC("socket")
 __success
 __naked void signed_unsigned_intersection32_case1(void *ctx)
-- 
2.55.0

