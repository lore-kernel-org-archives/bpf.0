Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794374110;
	b=SnMpkY3KDSpAk7AgFscY0eOus2IHs1zvxIOK3/5EeuwQ0dexesOghPIYvAr43T2MONN5
	 inAOJCQ+8YCyDRBlZBNdv70D4X2m8UEMQAsN2VGybtJdJQAXNN7++JLjPou6ViOXPkkML
	 uL3EhslKdyiitW15WxCe8rJ2LjWRXpRW05XxtBCFwKCvfI+Mq78jm9iajXDNp6W3UnoE8
	 qc/POA/wTpM10dxa7B/vAV6la/c/4YkrUr3EpR2XOiXf70/Ytsmv6A0+Vf2GMJaOUUX35
	 nwhjyTDoSseqycykB7+YNeLJY7Z7NsB1OEAhGLvKtvzP7/zv+N/woEcm/T8Doth3LUw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794374110;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=iDQVhoTmEVtQPZEDedB3vDz3t3eDnK0X/bbpEZfAdes=;
	b=PCZoMH2WHdTamhvyji19FCFtE+wQYg3jir+P9pSlXVXS5WPbw78/b8dlE7QzLxBir+Jg
	 SpTtdJL87SvBSCF5Kep0ZLSCgrJfbCFpTjbkRHIve9FiXqJ5LbBRYGQMQqtwTOHagILNh
	 U8z63LWDzOtnyW7yLqxXdLA/my//uP9QpGxS7oB6+NMOgIHY3K6TI4+P9bW8OpcYFVnd5
	 VjfYc9+/tYooSXw7NfyPkj/y9jIq2DANszFhysi4u7PUNTE0yFaOBNA6PUx2O1li7m7nb
	 xrlG7oUn1UT3b3pbC+0PS/q56kdQH+V/ut/xjWSjKZVwu9KUJxVaRk1RM2y+SD40sOA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="Tp/QpmGu";
	arc=none smtp.remote-ip=209.85.215.170
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B292A606A31C
	for <bpf@vger.kernel.org>; Wed, 11 Nov 2026 05:15:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B292A606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Tp/QpmGu
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-cdab8873d9dso1194798a12.1
        for <bpf@vger.kernel.org>; Tue, 10 Nov 2026 21:15:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794374109; x=1794978909; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iDQVhoTmEVtQPZEDedB3vDz3t3eDnK0X/bbpEZfAdes=;
        b=Tp/QpmGubnlzhknHR3yT/Rt1KkbOvXTHY904QyhmAIS5omg7cLRlpGPmuJrdGL9OQM
         tPWAwyesnpKVz0ipbqe38tybI0NioBe+RjfoxNfsk77/N21fqY/NLnLx8DNoOw4KryVU
         P6bXjEHoTcQ8IngWFEIIfaOSpd72IBkUstd5qA9rIZ03dgzlIOaROKfVJC49umry4MvK
         AmgFhtFEpYfOivvavg17JgORFrWWSdK3iwlmJKTHuIZgTi1SB3aLMcYSYwlvGWYr21CH
         LgYoAfPAByxduNc0pd330gZfD+yd6wuEWxzgjbA/5W4e0jSmSJtq3MpCpgpw8efbZEuF
         WsKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794374109; x=1794978909;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=iDQVhoTmEVtQPZEDedB3vDz3t3eDnK0X/bbpEZfAdes=;
        b=eAf9NKANruhrat9l4WIROMprK9EbS/tRn2aVo0jxPKmmX07iw6oldi0/x6LHE1FRtY
         qRH/49Cm+BE2x6kjfimsBVW+lrmSLqPHtjRE0d8cUQgiAB6igVsDFxFdnE6qj6M4ELrc
         Z2/xj2ODH0+n7rsXq//N6y6vRH3N9fHrWXPW6+5YaCbekkw48fV0isPQ/uSjxPHnk+C/
         e4w8zq3j2I4jftcHuVPbfoXjN+04Qzd2cGnlo5DiihspIH+0t/4QYesblbR7peKhXFRT
         0WpVxT5xndyNlWAu/dbi4k3uhzdywmrwQZnmmNFaiT4eQZO3tUiLvAwoy3bAljcah0X0
         XURA==
X-Gm-Message-State: APuU4Z9oDW3YBnuKahmmySQkzpxMcJYhQrzc/KAgzSOfQwHHzzXTwU8X
	91VY46gI2TNem1sQ4GoB5Ip2dsRM4KNgdDBgpebM1Uqn6u2RIhLlIgFNT7BMNA==
X-Gm-Gg: AYBFou0uV1vz/nL01c+vVRSgXb7+RmnAugFzpExv+gUaVrih7S4xudNKjaqsFcH6Izc
	kPehjH2opGwufF3lCWD+tGmLdUlJ34UrhYxPOaD8kyvd97a+bkOA3lD1Qd1yfYlc2JtPv42MGqH
	3qIpELsvgHxlEELX701i7j5cWcUKGZN2HZD2HxVczr6oBT8nS6aM2k9wf9DpPE8sjQxWZB3p+Lv
	x2jhnIpVEZwTyvhE4xp00AP6E32NV6dQLOprHEYA4lDPRF69msp9B7QR2JZGVtBEQMesRipjM32
	aqC4oADNaMOZo+eZKnNdQaiBL30xOnXBvNCMm7Gf57HUtJCtfE3Cs4ummYLyOkflXRoMbHQcvvH
	kBaxXx7rk6z7Iz1u+Evz+6EG4P1+t/mLsJX6I9DGVPotY9nJTOLj5uJRvwlLf/0f+Sk+gkx8nj3
	L9z/hbrcbLgIRls6kSmup6CbNKZVqWDO7ByYWv1ECZAwOD0WOIQr2wdUyzjMLBc5hVHufvGk3hj
	TXH3zSfVo+B8WweSEIM4TxZhhpLsbSbF47kP+JJOnK2uI/J5BNGnYUf4w36QbSttE8BA5y1sF+P
	W4ge0yEehGgj/IvRkQ/ijlF6OPiU5BEugwAbV8qi+7FkUFUtmrF/dWtAoROM3iMExzfExvMTNaV
	fByeeGahtyS3mCwNVjUEdjj2JZj2zuLo+KwVabV+EQDf/7/dYZAgiMngpsq63b0df/Q/u5nBSIw
	==
X-Received: by 2002:a17:90a:d643:b0:3ad:43c1:7d41 with SMTP id 98e67ed59e1d1-3b182fbe2e4mr1276856a91.33.1794374108771;
        Tue, 10 Nov 2026 21:15:08 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.251])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b186234c12sm778834a91.10.2026.11.10.21.15.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 21:15:08 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next v2 14/29] selftests/bpf: Test registers linked by scalar evolution
Date: Wed, 11 Nov 2026 05:13:25 +0000
Message-ID: <20261111051341.2800252-15-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261111051341.2800252-1-alexei.starovoitov@gmail.com>
References: <20261111051341.2800252-1-alexei.starovoitov@gmail.com>
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

Tests for the patch that refines the linked registers of a conditional
jump, and for the value numbering of phis. Linked registers are the live
registers and stack slots that are a tested register + a constant on every
path to the jump.

The existing tests of linked scalars, spills and loops cover the mechanism:
a copy, an added constant, the low 32 bits, a spill and its fill, two
calls, a store through a pointer. These tests are for the hazards that only
a static analysis has. scev.c computes the links before the main pass, from
the insns alone, without types and without states.

r8 is an unbounded scalar. Each prog computes a second value from it, tests
one of the two and uses the other one as an offset into a map value of
64 bytes. What loads is run.

 - An add that becomes ALU32: 'r3 += 1' is converted to 'w3 += 1' at fixup
   if r3 is an arena pointer. r3 == r7 + 1 holds modulo 2^32 only, also
   after 'r3 = le64 r3; r7 = le64 r7' has turned both into scalars, and
   also for the phi of two such adds. Rejected. A scalar + two constants
   in a prog with an arena is linked modulo 2^64: loads.
 - A store through a dynptr slice may alias the buffer on the stack: a fill
   before the store and a fill after it are not linked. Rejected. One fill
   and its copy are linked, whatever is stored after the fill. Loads.
 - The buffer of a slice is at one of two stack offsets, a range in the
   state, with a live slot between them. A slice of 0 bytes has its buffer
   at a variable offset. Both load.
 - An edge that the verifier adds: each iteration of the outer loop saves
   r3, which is r8, and restores it. may_goto that the verifier adds before
   the header of the nested loop leaves both loops while r3 is r7.
   Rejected.
 - A link at a loop header: two induction variables that are linked at loop
   entry and have the same step are linked there. Negative test: the steps
   differ.
 - A pointer is not a scalar: r3 is the address in r1 as a scalar. A bound
   of r3 does not bound the offset of r1. Rejected.
 - Big endian: a 32-bit spill goes to the first half-slot. The low 32 bits
   of a 64-bit fill are that spill on little endian only, also if the slot
   is a phi. Loads there, rejected on big endian. The same for a 64-bit
   spill of which the first half-slot is filled: the other one is dead, the
   state has a 32-bit spill at the jump.
 - An empty intersection: the range that the jump implies and the known
   bits of the linked register don't overlap. The register is left as it
   is: loads with BPF_F_TEST_REG_INVARIANTS. The same if var_off of the
   two registers don't overlap.
 - A link modulo 2^8: after 'r2 = (s8)r8; if r8 > 63 goto' both fit in s8,
   so r2 is refined. Loads.
 - A link in 64 bits and a JMP32: 'if w3 s> 63' refines nothing but the
   32-bit range of r3. The registers that are equal to r3 get it. Loads.
 - Value numbered phis: a copy + 1 on each of two paths is linked after
   the join point. Negative tests: another delta on one path, unrelated
   values on one of three edges. (zext32 x) on both paths is linked in 64
   bits.

The tests with an arena are in verifier_arena.c, the others in
verifier_scev.c.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 .../selftests/bpf/progs/verifier_arena.c      |  39 +++++
 .../selftests/bpf/progs/verifier_scev.c       | 162 ++++++++++++++++++
 2 files changed, 201 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_arena.c b/tools/testing/selftests/bpf/progs/verifier_arena.c
index bebb607000a5..bf50413f6c08 100644
--- a/tools/testing/selftests/bpf/progs/verifier_arena.c
+++ b/tools/testing/selftests/bpf/progs/verifier_arena.c
@@ -625,6 +625,45 @@ ARENA_TEST(arena_pointer_moves, "r6 += 8;", __success NOT_UNROLLED100)
 ARENA_TEST(arena_pointer_becomes_a_number, "if r7 != 5 goto +1; r6 = 4096;",
 	   __failure NOT_UNROLLED100 __msg("R6 invalid mem access 'scalar'"))
 
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__uint(max_entries, 1);
+	__type(key, __u32);
+	__type(value, char[64]);
+} map64 SEC(".maps");
+
+/*
+ * r6: 64 bytes. r8: an unbounded scalar. r3, r7: an arena pointer and a copy of it.
+ * The test leaves an address in r1.
+ */
+#define ARENA_LINKED(name, expect, body)					\
+SEC("syscall") expect __load_if_JITed()						\
+__naked void name(void)								\
+{										\
+	asm volatile (								\
+	"r1 = %[arena] ll; r1 = 0; *(u32 *)(r10 - 4) = r1; r2 = r10; r2 += -4;"	\
+	"r1 = %[map64] ll; call %[bpf_map_lookup_elem]; if r0 == 0 goto out_%=; r6 = r0;"	\
+	"call %[bpf_ktime_get_ns]; r8 = r0; r3 = addr_space_cast(r8, 0, 1); r7 = r3;"	\
+	body									\
+	"r0 = *(u8 *)(r1 + 0);"							\
+	"out_%=: r0 = 0; exit;"							\
+	:									\
+	: __imm(bpf_map_lookup_elem), __imm(bpf_ktime_get_ns),			\
+	  __imm_addr(map64), __imm_addr(arena)					\
+	: __clobber_all);							\
+}
+
+ARENA_LINKED(scalar_plus_two_constants, __success __retval(0),
+	"r2 = r8; r2 += 1; r2 += 1; if r8 > 61 goto out_%=; r1 = r6; r1 += r2;")
+/* 'r3 += 1' is converted to 'w3 += 1': r3 is 0 and not 1 << 32 */
+ARENA_LINKED(arena_ptr_plus_constant, __failure,
+	"r3 += 1; r3 = le64 r3; r7 = le64 r7; r2 = 0xffffffff ll; if r7 != r2 goto out_%=;"
+	"r3 >>= 32; r3 -= 1; r1 = r6; r1 += r3;")
+/* At the join point r3 is phi((+ x 1)). The insn there, an add to a scalar, does not define it. */
+ARENA_LINKED(arena_ptr_plus_constant_on_two_paths, __failure,
+	"if r8 == 0 goto 1f; r3 += 1; goto 2f; 1: r3 += 1; 2: r8 += 1; r3 = le64 r3; r7 = le64 r7;"
+	"r2 = 0xffffffff ll; if r7 != r2 goto out_%=; r3 >>= 32; r3 -= 1; r1 = r6; r1 += r3;")
+
 SEC("syscall")
 __description("arena: a number is not an address in arena")
 __failure __msg("R6 invalid mem access 'scalar'")
diff --git a/tools/testing/selftests/bpf/progs/verifier_scev.c b/tools/testing/selftests/bpf/progs/verifier_scev.c
index b961a12b5224..1f9aa7e691be 100644
--- a/tools/testing/selftests/bpf/progs/verifier_scev.c
+++ b/tools/testing/selftests/bpf/progs/verifier_scev.c
@@ -3338,6 +3338,168 @@ NOT_LINEAR_TEST(lsh_grows, "r7 &= 15;", "r7 <<= 1;", UNROLLED("(<< r7 1)"))
 NOT_LINEAR_TEST(same_constant, "r7 = 17;", "r7 &= 31;", NOT_CHANGED)
 NOT_LINEAR_TEST(same_wide_constant, "r7 = 0xffffffff00000011 ll;", "r7 &= -239;", NOT_CHANGED)
 
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__uint(max_entries, 1);
+	__type(key, __u32);
+	__type(value, char[64]);
+} map64 SEC(".maps");
+
+/*
+ * A conditional jump refines the registers and stack slots that are linked to what it tests.
+ * r6: 64 bytes. r7: a scalar below 256. r8: an unbounded scalar. r9: the context.
+ * The test leaves an address in r1.
+ */
+#define LINKED_SEC(sec, name, expect, body)					\
+SEC(sec) expect									\
+__naked void name(void)								\
+{										\
+	asm volatile (								\
+	"r9 = r1; r1 = 0; *(u32 *)(r10 - 4) = r1; r2 = r10; r2 += -4; r1 = %[map64] ll;"	\
+	"call %[bpf_map_lookup_elem]; if r0 == 0 goto out_%=; r6 = r0;"		\
+	"call %[bpf_get_prandom_u32]; r7 = r0; r7 &= 255;"			\
+	"call %[bpf_ktime_get_ns]; r8 = r0;"					\
+	body									\
+	"r0 = *(u8 *)(r1 + 0);"							\
+	"out_%=: r0 = 0; exit;"							\
+	:									\
+	: __imm(bpf_map_lookup_elem), __imm(bpf_get_prandom_u32), __imm(bpf_ktime_get_ns),	\
+	  __imm(bpf_dynptr_from_skb), __imm(bpf_dynptr_slice_rdwr),		\
+	  __imm(bpf_ringbuf_reserve), __imm(bpf_ringbuf_discard),		\
+	  __imm_addr(map64), __imm_addr(ringbuf)				\
+	: __clobber_all);							\
+}
+#define LINKED(name, expect, body)	LINKED_SEC("socket", name, expect, body)
+
+#define VALID	__success __retval(0)
+#define UNBOUND	__failure __msg("unbounded min value")
+
+/* r3 is the address in r1 as a scalar. It does not bound the offset of r1. */
+LINKED(pointer_is_not_scalar, __failure,
+	"r7 &= 127; r1 = r6; r1 += r7; r3 = r1; r3 = le64 r3; if r3 < 64 goto out_%=; r1 += -64;")
+
+LINKED(sign_extension_that_fits, VALID, "r2 = (s8)r8; if r8 > 63 goto out_%=; r1 = r6; r1 += r2;")
+
+/* 'int n' in three registers. 'if w3 s> 63' refines only 32-bit ranges: those of the copies too. */
+LINKED(copies_get_the_32_bit_range, VALID,
+	"w2 = w8; r3 = r2; r4 = r2; if w3 s> 63 goto out_%=; if w4 s< 0 goto out_%=;"
+	"r1 = r6; r1 += r2;")
+
+/* A copy on each of two paths: r2 and r3 are phis with the same operands, up to a constant */
+#define TWO_PATHS(a, b)								\
+	"if r7 > 9 goto l_%=; r2 = r8; " a " goto m_%=; l_%=: r2 = r8; r2 >>= 1; " b	\
+	"m_%=: if r2 > 62 goto out_%=; r1 = r6; r1 += r3;"
+
+LINKED(congruent_phis, VALID, TWO_PATHS("r3 = r2; r3 += 1;", "r3 = r2; r3 += 1;"))
+LINKED(phis_with_other_delta_on_one_path, UNBOUND,
+       TWO_PATHS("r3 = r2; r3 += 1;", "r3 = r2; r3 += 2;"))
+/* One of three edges brings unrelated values */
+LINKED(phis_not_linked_on_one_of_three_edges, UNBOUND,
+	"r3 = r8; r3 >>= 2; r2 = 0; if r7 == 20 goto m_%=;"
+	TWO_PATHS("r3 = r2; r3 += 1;", "r3 = r2; r3 += 1;"))
+/* (zext32 x) on both paths: linked in 64 bits */
+LINKED(congruent_phis_of_zext32, VALID,
+	"if r7 > 9 goto l_%=; w2 = w8; r3 = r2; goto m_%=; l_%=: r2 = r8; r2 >>= 1; w2 = w2;"
+	"r3 = r2; m_%=: r3 += 1; if r2 > 62 goto out_%=; r1 = r6; r1 += r3;")
+
+/* The low 3 bits of r3 are 5. It is r8 + 5 once r8 fits in s8: no overlap with [-2, 1]. */
+LINKED(empty_intersection, VALID __flag(BPF_F_TEST_REG_INVARIANTS),
+	"r3 = (s8)r8; if r3 & 7 goto out_%=; r3 += 5; if r3 s> 100 goto out_%=;"
+	"if r3 s< -100 goto out_%=; if r8 s< -7 goto out_%=; if r8 s> -4 goto out_%=;"
+	"r3 += 3; r1 = r6;")
+
+/* r2 is even. It is r8 once r8 fits in s8. r8 is odd after the last jump: var_off don't overlap. */
+LINKED(var_off_dont_overlap, VALID,
+	"r2 = (s8)r8; if r2 & 1 goto out_%=; if r2 s> 100 goto out_%=; if r2 s< -100 goto out_%=;"
+	"if r8 > 5 goto out_%=; if r8 & 1 goto l_%=; goto out_%=;"
+	"l_%=: r2 &= 1; r2 <<= 6; r1 = r6; r1 += r2;")
+
+/* The low bytes of the spill to r10 - 16 come first or last */
+#if __BYTE_ORDER__ == __ORDER_LITTLE_ENDIAN__
+#define FIRST_BYTES_ARE_LOW	VALID
+#else
+#define FIRST_BYTES_ARE_LOW	__failure __msg("R1 unbounded memory access")
+#endif
+
+/* r2 is the low 32 bits of the slot. The 32-bit spill is in its first half-slot. */
+LINKED(spill_32_bits_fill_64_take_low_half, FIRST_BYTES_ARE_LOW,
+	"*(u64 *)(r10 - 16) = r7; *(u32 *)(r10 - 16) = r8; r2 = *(u64 *)(r10 - 16); w2 = w2;"
+	"w3 = w8; if r2 > 63 goto out_%=; r1 = r6; r1 += r3;")
+/* The slot is a phi: two paths spill distinct values to its first half-slot */
+LINKED(spill_32_bits_on_two_paths_fill_64_take_low_half, FIRST_BYTES_ARE_LOW,
+	"*(u64 *)(r10 - 16) = r7; *(u32 *)(r10 - 16) = r8; if r7 > 9 goto l_%=;"
+	"r3 = r8; r3 >>= 1; *(u32 *)(r10 - 16) = r3;"
+	"l_%=: r2 = *(u64 *)(r10 - 16); w2 = w2; if r2 > 63 goto out_%=;"
+	"r3 = *(u32 *)(r10 - 16); r1 = r6; r1 += r3;")
+/* The half-slot at r10 - 12 is dead: at the second jump the state has a 32-bit spill */
+LINKED(spill_64_bits_fill_32, FIRST_BYTES_ARE_LOW,
+	"*(u64 *)(r10 - 16) = r8; if r8 s> 63 goto out_%=; if r8 s< 0 goto out_%=;"
+	"r2 = *(u32 *)(r10 - 16); r1 = r6; r1 += r2;")
+
+/* r0 is r10 - 24 when the first 8 bytes of the packet are not in one piece */
+LINKED_SEC("tc", slot_written_through_a_slice, UNBOUND,
+	"r1 = r9; r2 = 0; r3 = r10; r3 += -16; call %[bpf_dynptr_from_skb];"
+	"r1 = r10; r1 += -16; r2 = 0; r3 = r10; r3 += -24; r4 = 8;"
+	"call %[bpf_dynptr_slice_rdwr]; if r0 == 0 goto out_%=;"
+	"r3 = *(u64 *)(r10 - 24); *(u64 *)(r0 + 0) = r8; r2 = *(u64 *)(r10 - 24);"
+	"if r3 > 63 goto out_%=; r1 = r6; r1 += r2;")
+/* One fill reads one value: r2 is a copy of r3, whatever is stored through the slice */
+LINKED_SEC("tc", copy_of_a_fill_from_a_slice_buffer, VALID,
+	"r1 = r9; r2 = 0; r3 = r10; r3 += -16; call %[bpf_dynptr_from_skb];"
+	"r1 = r10; r1 += -16; r2 = 0; r3 = r10; r3 += -24; r4 = 8;"
+	"call %[bpf_dynptr_slice_rdwr]; if r0 == 0 goto out_%=;"
+	"r3 = *(u64 *)(r10 - 24); r2 = r3; *(u64 *)(r0 + 0) = r8;"
+	"if r3 > 63 goto out_%=; r1 = r6; r1 += r2;")
+
+/* The buffer is r10 - 32 or r10 - 48, a range in the state. The call does not write to r10 - 40. */
+LINKED_SEC("tc", slice_buffer_at_two_offsets, VALID,
+	"r1 = r9; r2 = 0; r3 = r10; r3 += -16; call %[bpf_dynptr_from_skb];"
+	"*(u64 *)(r10 - 32) = r7; *(u64 *)(r10 - 40) = r7; *(u64 *)(r10 - 48) = r7;"
+	"r8 = r10; r8 += -48; r9 = r10; r9 += -32; r7 = 0;"
+	"l_%=: call %[bpf_get_prandom_u32]; if r0 == 0 goto s_%=; r9 = r8;"
+	"s_%=: r7 += 1; if r7 < 64 goto l_%=;"
+	"r1 = r10; r1 += -16; r2 = 0; r3 = r9; r4 = 8; call %[bpf_dynptr_slice_rdwr];"
+	"r1 = *(u64 *)(r10 - 40); r1 = r6;")
+/* No insn stores through a slice of 0 bytes, and the call does not write to the buffer */
+LINKED_SEC("tc", slice_of_0_bytes_at_variable_offset, VALID,
+	"r1 = r9; r2 = 0; r3 = r10; r3 += -16; call %[bpf_dynptr_from_skb];"
+	"*(u64 *)(r10 - 24) = r7; *(u64 *)(r10 - 32) = r7; r7 &= 8;"
+	"r1 = r10; r1 += -16; r2 = 0; r3 = r10; r3 += -32; r3 += r7; r4 = 0;"
+	"call %[bpf_dynptr_slice_rdwr]; r1 = r6;")
+
+/* BTF of the kfuncs that only asm calls */
+void __kfunc_btf_root(void)
+{
+	bpf_dynptr_from_skb(0, 0, 0);
+	bpf_dynptr_slice_rdwr(0, 0, 0, 0);
+}
+
+/* Linked at the header in every iteration: r2 is r3 + 2 at loop entry, both have the step 1 */
+#define LOOP_HEADER(enter, step)						\
+	enter "l_%=: if r3 > 61 goto out_%=; r1 = r6; r1 += r2; r0 = *(u8 *)(r1 + 0);" step	\
+	"if r0 != 0 goto l_%=;"
+
+LINKED(linked_at_loop_header, VALID,
+	LOOP_HEADER("r3 = r8; r2 = r8; r2 += 1; r2 += 1;", "r2 += 1; r3 += 1;"))
+LINKED(linked_at_loop_entry_only, __failure,
+	LOOP_HEADER("r3 = r8; r2 = r8; r2 += 1; r2 += 1;", "r2 += 2; r3 += 1;"))
+
+/*
+ * No exit of the inner loop dominates its backedges: may_goto is added before its header. The prog
+ * holds a reference, so may_goto goes to the exit of the outer loop: an edge that the verifier
+ * adds. Every iteration of the outer loop restores r3. At the header of the inner one it is r7.
+ */
+LINKED(added_edge, UNBOUND,
+	"r1 = %[ringbuf] ll; r2 = 8; r3 = 0; call %[bpf_ringbuf_reserve]; if r0 == 0 goto out_%=;"
+	"*(u64 *)(r10 - 16) = r0; r3 = r8;"
+	"o_%=: r2 = r3; r3 = r7;"
+	"i_%=: r1 = *(u8 *)(r6 + 0); if r1 == 1 goto a_%=; if r1 == 2 goto b_%=; goto i_%=;"
+	"a_%=: goto i_%=;"
+	"b_%=: r3 = r2; r1 = *(u8 *)(r6 + 1); if r1 == 3 goto o_%=;"
+	"r4 = r6; if r8 > 63 goto r_%=; r4 += r3;"
+	"r_%=: *(u64 *)(r10 - 24) = r4; r1 = *(u64 *)(r10 - 16); r2 = 0;"
+	"call %[bpf_ringbuf_discard]; r1 = *(u64 *)(r10 - 24);")
+
 /*
  * r7 = ctx->data;
  * r8 = r7
-- 
2.55.0

