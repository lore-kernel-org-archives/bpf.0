Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794206916;
	b=ZuyGHbpg7IR8vDct1T3DtCvyEAGFgT3B0QTRESU9p3XYYH6gtoteDbXSm2TGnF50S8qh
	 oQq5KTKR7NubL3GISlZ/0co2m77WQdUsnPHdWbi+LNhggKH7DtfbSjnZMt7sOC4kmQc2p
	 2hrd0si/v24EhoaHx1JlbDXCrkuB8iBpIO1vZPpZgJuaMkKhbeEYTVdWZ4CHJijEZBdtb
	 xJAZExCkJ1+L1robskFTDoBFyL97aKyuliXDgkAgWzGHCTfJ3Lv9OhKp/L8KGlCztWvyV
	 WoulGhUI0SlpYfgzXO0jrZ3wjQYERm4/65FlmGHKpbIdWT8dIVowUualFsc8zbIcsNQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794206916;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=xY6xPoohPQdQ+mcXXC+LnfGlZJXXlJYAzFuF5JcVc0g=;
	b=x0Wa8nxUBAmjlEGF8Ju7HtSe5xNBqKDqaOUIwmukOBhX1+jIwOQ733lPY2ccC+soD0G1
	 pOgZW9GCXnn0g00xDzuUdgPD5J09TGbGuks/9GxYNt0fbJaUkI1FHc/vzTU1LtoGPd9Mz
	 mZ8BKOCaMYHkaIdC/yXZt6BWSKnuhrsgmecQP6huCp73LUCc41c+4HNSWUEBVmsGGVJby
	 /fSwHynZWercu0GAc8nUX7UfvtUrzYOFD6ee8d0SOS2FXjKmBQp3HtWn0omtgOs2nvKQR
	 j4EXO4/G156Kg6eI9DcDG+nIw8WO9AQGi0N7ExcW0eQwZlfsMhjjXRtHJtFS2U6Rp9g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PHY6MhSe;
	arc=none smtp.remote-ip=209.85.216.50
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94CD6606A31C
	for <bpf@vger.kernel.org>; Mon,  9 Nov 2026 06:48:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 94CD6606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PHY6MhSe
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-3ada8bc2380so238985a91.3
        for <bpf@vger.kernel.org>; Sun, 08 Nov 2026 22:48:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794206915; x=1794811715; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xY6xPoohPQdQ+mcXXC+LnfGlZJXXlJYAzFuF5JcVc0g=;
        b=PHY6MhSelyq8FEYtnip1LpD8R8By5dM1QsK+nu4ah/ToptOT3tLu+pXqTbsiBJJmwS
         fiegIJM06XjQZ3kzMAh0H+wtJk0Snt+ry0QL+vUvRcmb6/9OfZYYwtVtwzf6uqPB51jr
         j2HC1v3eQTporLM7Pu5JrJ7I1Q6IbSztLlZ5hacpIWi9WP5O3uSgVMGda9X723g5ywpp
         vwgnhAvh8D3/69y1Au2N/CvtAV2zzkHHbuRMM6T3b4fj2tndfjIf0nrrnpJNbFXwWn5N
         iBtUqvoBs7qWS7LCp2M3Q6rN9H2GNl086Zm7VtJgo7+N8ttPZqXCot4ZV6Y7uKNe5sJo
         T9gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794206915; x=1794811715;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=xY6xPoohPQdQ+mcXXC+LnfGlZJXXlJYAzFuF5JcVc0g=;
        b=YHiT5VLn3kPf+P01bpmQk5qZj39QsWd22I0vFe2lfn9XYLpnE1MMZrpaKRu1uGYPoQ
         ymtyX+FW3zQZIgrXVhWglaCKeT+pH6/J3qzIKSmzU5rrY028vhHahHtJG6Q2v+seYh5E
         aFlpzgb3TxI/gwIZlNIPeMzJ+TWiHI0WaA6RpKdkIkJPSbxYV2SsqDmgZWc4UUu0eRU9
         +LYlsIUhtNGbIhzXc7qjuBzammcZiWCiA6SR1UE1LwJMyaSSRaAznm3EbJBBEcgb4Klq
         HmqawoR/9nkMmJmFeI0vtjeQCyVeWLv/mZkHaL1wAq6jgtG0bw70kfBD02n+dgrEUEjd
         8eJg==
X-Gm-Message-State: APuU4Z9EzUxUMazAoegDfim1WeCuYMSV8IiY0THB/4kUO7LpyuzOUVQG
	JZHuXXsmY6iz/exip+E/O/AY4JIcBaLzxcdeF1YqNE6SFRJy/aN87zkpyPt1ZA==
X-Gm-Gg: AYBFou01P0X/+wr6J3iChTyT6G8g2hKcfw9QHI4yo432e4/+Pe8Bdb/o5o5V1y+qR+l
	gZFIi6OAQFgMnlxfYklJTTUFXvMygaZAYU/eP5zZ9gLGHzatV5VAnCt1vNSgVO2I8XL5x60RotO
	CUONfK9R1IxGZL6hM9xm0oqoqeu/Cwf4bXQRCnkiEdSxxas07OKV5chG1fJwiZbrMKYmQZSHvpY
	M3zSMKCd0mLhdwjiWRK6/FmIjD+EY8Nv0Kg6ruDZ6EdMgOXWzOA1OWUdihN9V4+/3ylYPsy4hf0
	f97O6tQQ0x32rEpHVrKUW4Pe7WpC/Ky3mexFf8pLE8H97aO5IytqFJ08DhJLBKPx780HV4h7gzy
	pbig5o04vg+wimBtpF5XVxEuOLN4tXN/ae4oMOa0VwvR8vJ0MbfM7b4koFG4L+FhU+SfyTGVhP2
	wAs2nbHFrdv4vfwyHn6u+eELIALmZO2ar7k1JdXlmE8JNfILbVMjoFi/VtPoJyxxuYKVukvdqp0
	C4w3sgXfeSOpYbWQPK86lT+NhJCx6ir/iWgnNJpTOjUVKZQJaGPoGQEyX3KmIOBsRt1yd/jkHpR
	Bj3QfVxdoto6HnbPKilCe4HRmOMfnqaN7GTVMX/7Ar5wMz1xgrZQd/V8g/7Er4XbRUHygBQ7Rzp
	jcTcjk11ZclTHEEoBP6vj+Nmh48ATxPYGjnAVmRO5V+U4ixs4dhi7oP50EmeTROaCGf4q36l8x9
	VWays9ClQmhCYUfeu3QPM=
X-Received: by 2002:a17:90b:33c4:b0:3ab:c370:3684 with SMTP id 98e67ed59e1d1-3b12d365f07mr2703854a91.30.1794206914759;
        Sun, 08 Nov 2026 22:48:34 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.255])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b139d0a166sm3342760a91.3.2026.11.08.22.48.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 22:48:34 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next 13/26] selftests/bpf: Test registers linked by scalar evolution
Date: Mon,  9 Nov 2026 06:46:57 +0000
Message-ID: <20261109064715.2382452-14-alexei.starovoitov@gmail.com>
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

Tests for the patch that refines the linked registers of a conditional
jump. These are the live registers and stack slots that are a tested
register + a constant on every path to the jump.

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
   before the store and a fill after it are not linked. Rejected.
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
   is a phi. Loads there, rejected on big endian.
 - An empty intersection: the range that the jump implies and the known
   bits of the linked register don't overlap. The register is left as it
   is: loads with BPF_F_TEST_REG_INVARIANTS.
 - A link modulo 2^8: after 'r2 = (s8)r8; if r8 > 63 goto' both fit in s8,
   so r2 is refined. Loads.

The tests with an arena are in verifier_arena.c, the others in
verifier_scev.c.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 .../selftests/bpf/progs/verifier_arena.c      |  39 +++++++
 .../selftests/bpf/progs/verifier_scev.c       | 107 ++++++++++++++++++
 2 files changed, 146 insertions(+)

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
index 70aeeadcd181..1047845c916b 100644
--- a/tools/testing/selftests/bpf/progs/verifier_scev.c
+++ b/tools/testing/selftests/bpf/progs/verifier_scev.c
@@ -3307,6 +3307,113 @@ NOT_LINEAR_TEST(lsh_grows, "r7 &= 15;", "r7 <<= 1;", UNROLLED("(<< r7 1)"))
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
+/* The low 3 bits of r3 are 5. It is r8 + 5 once r8 fits in s8: no overlap with [-2, 1]. */
+LINKED(empty_intersection, VALID __flag(BPF_F_TEST_REG_INVARIANTS),
+	"r3 = (s8)r8; if r3 & 7 goto out_%=; r3 += 5; if r3 s> 100 goto out_%=;"
+	"if r3 s< -100 goto out_%=; if r8 s< -7 goto out_%=; if r8 s> -4 goto out_%=;"
+	"r3 += 3; r1 = r6;")
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
+
+/* r0 is r10 - 24 when the first 8 bytes of the packet are not in one piece */
+LINKED_SEC("tc", slot_written_through_a_slice, UNBOUND,
+	"r1 = r9; r2 = 0; r3 = r10; r3 += -16; call %[bpf_dynptr_from_skb];"
+	"r1 = r10; r1 += -16; r2 = 0; r3 = r10; r3 += -24; r4 = 8;"
+	"call %[bpf_dynptr_slice_rdwr]; if r0 == 0 goto out_%=;"
+	"r3 = *(u64 *)(r10 - 24); *(u64 *)(r0 + 0) = r8; r2 = *(u64 *)(r10 - 24);"
+	"if r3 > 63 goto out_%=; r1 = r6; r1 += r2;")
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

