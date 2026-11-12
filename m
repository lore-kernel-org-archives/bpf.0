Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794498894;
	b=yviJtFBF1L+V8ld/NVdB57HIW1iMDVAiAHLS1FX5M7I4pZS7GG50KXZzp2qbESO1g1Rm
	 MbAU68/fAYYoU+JsY/4Qt5Wv2nM8NJ/iOfggFXtJAGyD09WxP4bf1n3IQ+jqnhJEvQuvE
	 Od3qoCTUxvaUJdjALR9OXWTuo0kVaCWdQTdrKSdOURgIaMuGRhi5plbtvUNwwSr1CoV1n
	 x83iwkuMK/ry79D7Y6tqrN9pbVmiG9HXL35lhPmuamrSLshFgu+3majJ0GU/G/6Pw7Ts+
	 mJoMWLSZAMdD54p4cb++sOOVOYgArRdYnkb9AWPQbmXOi7VUpyXCVREK76JBOXG3LKA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794498894;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=d2TPl4JNAw7RzVE69dDCBFI69w+IvtToIR9imFo6f4Q=;
	b=04eXItCBDwQ/LKzmLZ3mN0kX/EKsbxDfvo6yyxWWcMdTA91lVbmF9KhnTf0zpjNhEYBk
	 MYhoA9OTCSu0QYJx3gulh+GPLwliHzhxsO4QxMUDWe0Wacll1gH8SKqj1FjZLDMDncfs4
	 RCXTQ+PfH2ufHoEDGldKhsu8QaXhEAdQAF1slGvmZQGw57JcEyYZXaMuM1+DUWuHt+6EH
	 3uE+Ih5psnsXySQ+be2z5t4wIkv+ozPzFHQk0XrXMI0Y8MmIKfw3GLMDa9GPm63yatski
	 R/+Muvq/67JrpcdPzuBG4tO//ziWWeD+o+2NRp3XFyGZivL0BSyxWqTBI4nn5rcL+1A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hLxJJHf+;
	arc=none smtp.remote-ip=209.85.210.173
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6333D606A330
	for <bpf@vger.kernel.org>; Thu, 12 Nov 2026 15:54:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6333D606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hLxJJHf+
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-8b67f25e6e1so2378766b3a.0
        for <bpf@vger.kernel.org>; Thu, 12 Nov 2026 07:54:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794498893; x=1795103693; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=d2TPl4JNAw7RzVE69dDCBFI69w+IvtToIR9imFo6f4Q=;
        b=hLxJJHf+Z9mXJGLx9+26UuwjKsXYxL/uULgJtWsKRqLrtBHTjyCVnNJn/0yjLqW+NF
         syPi7Fp37bqki1hVcM95RhV3oh0boDOG4RkmWZ7RhoeV3jvPXOuuAR63kihdwJtdBqYG
         91B/lwVdvGqhsCUrA1PRzNvmbgfiKFJcOyvB8pPzlI/EHmP5JjfNgF0peM46QnfodVeT
         NzLi72RBCcaA6zBUTxq0/iIvjWEAP0P37XdOirjwiLr3fpWhoRMPX4MUMTJM7oGj/zyU
         pOUC6NhIVnisjtK9OqjCUip09mTp/x2bkKckWIQq721qbtlWdR/je0BNKPIB83ghkAuG
         kpFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794498893; x=1795103693;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=d2TPl4JNAw7RzVE69dDCBFI69w+IvtToIR9imFo6f4Q=;
        b=ztCUyKONxXmMY74rMovZFFuj8mlzkaL9YH7FXYn73owih1F2lNfwvrLUISBgZ6C02X
         MrR8I+X4qQyuFsQFCU88h2ZyPMmXeoFKlAjeGrbeg26pQEkwBemfNkwooDGqSlm7Sj8j
         6gbcTuTGWtRnNM4LM9fnZ4kYceoeIsAr7OTMoacplbDfmgnMC3PteyH/mZ6t+aI4MZYg
         j9iSmxKyxGZ8VUbPtiauIQpoNQoYA0qfp65cF+dfAmXlUjK4pt6d7rUH6fK5uHCHF/QL
         1/Hnw9aquWNaB8h8G436On/B+XlT8KJcLZKaUJ9gmENznrPmEeqACL5XY9v54GmZ01Sb
         cCPA==
X-Gm-Message-State: APuU4Z/YnFCnt6aENjCE9KdpAcMkhIo2hMWLVsCBrSshyGaKpYNtsgj2
	jD0MLZ5Hns1hIH4u7wPbYpzprrPZXHep7Iey5J0Oj/u8BRho70Adzuza5tkjHQ==
X-Gm-Gg: AYBFou3hYnngGF1Hvxnk0/1KTgrHWK2CIsmJYRjQAMLxDVVRl7/cXRhDfqmMriSHuk7
	zGFmTgq48DkK2KEnqnL3QiP2bU5PwanIZNK1GB7q0Jk/xh5NhlwWGMF2qF/mAixKa0iHTzoJlU9
	rCoJfAVa3LXF4SUP8PJeXgpwuwU4VrzCITum4pb9ePSfJsL3s2QmkwpzBBlmGfY7GhHaeJ/IuPF
	vjYxXLbHmg6cQFMiKs5nYHmIt+aRcp71SQGucEkqZZZ1gMcZOsitAB53ljU+EgGkV34tscqTkZk
	mH5/vnvia5tz6OqxQUhvtweRn2Ki6mmNTKXcXEbCVH1MeZ5aXQi27sUTYEqdNqmgyrF+XIGYyzW
	50xKY7c6XZFL8TEDptmurn3jqtctwK6EOfOozPB0fjDhGtag7H+GdN7/TwrakQg0cZaB4/h69Wd
	9kP6Ps8u/XhCRccbtnlhRQwYuSlDI8rmkRDIfD9wV31LuQHMk0aMgBs5kHh97t3amnSjBpBDJdw
	LvckBwojFJngT9FWCljp4G1dsKGxk3uwRQBAmp5c01QdZg+v4RGrAqzJRGsK0Zpya2J07eEDEjf
	7TzD2LMj+0BeWfTfE2WBfusRrIDHcijHfLMQ24jX6U2u7bOHGcxu0JLDzAOCan3gjfiLfdeAA9O
	zq7JjgmjHtdoBuC/JmoVpIwjDUsnzJQo4ijAmFNQq3y6GlWZbxCoAPc4KkAbMbpOoa5rtrJw3XH
	XubsQlAv29rQJ/gpABobHz
X-Received: by 2002:a05:6a21:3991:b0:3e1:d43e:367f with SMTP id adf61e73a8af0-3f2fffbe63cmr6442476637.73.1794498892285;
        Thu, 12 Nov 2026 07:54:52 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.253])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8baab8dccc7sm3583511b3a.52.2026.11.12.07.54.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 07:54:51 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next 12/12] selftests/bpf: Test the evaluation of linked expressions
Date: Thu, 12 Nov 2026 15:53:37 +0000
Message-ID: <20261112155337.1040699-13-alexei.starovoitov@gmail.com>
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

Next to the tests of 'p = buf + i':

 - the outermost common base: 'm = n + 1' follows '(u32)(n - 1)' where n is
   a 16-bit fill
 - a masked copy is tested: the register follows if it fits in a u8
 - 'p = &hdr[n]' before 'if (n >= 4)', with n and hdr in stack slots as in
   the HTTP/2 parser of the Datadog agent
 - each branch evaluates in its own state
 - a product in 32 bits, one that wraps
 - a scalar, '63 - n * 8'
 - the constant between an operand and its leader
 - '>>'; '%', '>>' and a zero extension of a value of which too few bits
   are known; the bound of a loop in a slot with a 32-bit spill
 - a signed division by a range that has 0
 - an operand that is overwritten before the jump
 - two partial spills of one value, the step of the address base
 - a pointer below '-' and '*', the offset of a pointer for a scalar
 - an offset that 'p += i' refuses
 - with an arena: a product and a shifted sum of a pointer to the arena
 - memory of a caller whose address the callee holds in r0

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 .../selftests/bpf/progs/verifier_arena.c      |   8 ++
 .../selftests/bpf/progs/verifier_scev.c       | 108 ++++++++++++++++++
 2 files changed, 116 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_arena.c b/tools/testing/selftests/bpf/progs/verifier_arena.c
index 3931a1d9b6da..4741cd7d20cd 100644
--- a/tools/testing/selftests/bpf/progs/verifier_arena.c
+++ b/tools/testing/selftests/bpf/progs/verifier_arena.c
@@ -659,6 +659,14 @@ ARENA_LINKED(scalar_plus_two_constants, __success __retval(0),
 ARENA_LINKED(arena_ptr_plus_constant, __failure,
 	"r3 += 1; r3 = le64 r3; r7 = le64 r7; r2 = 0xffffffff ll; if r7 != r2 goto out_%=;"
 	"r3 >>= 32; r3 -= 1; r1 = r6; r1 += r3;")
+/* the add is an operand: (>> (+ x 1) 32) */
+ARENA_LINKED(arena_ptr_plus_constant_shifted, __failure,
+	"r3 += 1; r3 = le64 r3; r3 >>= 32; r7 = le64 r7; r2 = 0xffffffff ll;"
+	"if r7 != r2 goto out_%=; r3 -= 1; r1 = r6; r1 += r3;")
+/* 'r3 *= 2' is converted to 'w3 *= 2': r3 is 0 and not 1 << 32 */
+ARENA_LINKED(arena_ptr_times_constant, __failure,
+	"r3 *= 2; r3 = le64 r3; r7 = le64 r7; r2 = 0x80000000 ll; if r7 != r2 goto out_%=;"
+	"r3 >>= 32; r3 -= 1; r1 = r6; r1 += r3;")
 /* At the join point r3 is phi((+ x 1)). The insn there, an add to a scalar, does not define it. */
 ARENA_LINKED(arena_ptr_plus_constant_on_two_paths, __failure,
 	"if r8 == 0 goto 1f; r3 += 1; goto 2f; 1: r3 += 1; 2: r8 += 1; r3 = le64 r3; r7 = le64 r7;"
diff --git a/tools/testing/selftests/bpf/progs/verifier_scev.c b/tools/testing/selftests/bpf/progs/verifier_scev.c
index 012515859921..8039a5d6769f 100644
--- a/tools/testing/selftests/bpf/progs/verifier_scev.c
+++ b/tools/testing/selftests/bpf/progs/verifier_scev.c
@@ -3581,6 +3581,106 @@ LINKED(index_is_empty, VALID __flag(BPF_F_TEST_REG_INVARIANTS),
 	"r7 &= 1; r7 *= 7; r7 += -2; r1 = r6; r1 += r7; r1 += 2; if r7 & 1 goto l_%=; goto out_%=;"
 	"l_%=: if r7 & 2 goto m_%=; goto out_%=; m_%=: r1 += 1;" USE_R6)
 
+/*
+ *	n = hdr.len; m = n + 1; if ((u32)(n - 1) > 61) return 0; c = buf[m];
+ * n is a u16. r3 and r4 are r2 + a constant modulo 2^32, and the slot + a constant modulo 2^16.
+ * r3 does not fit in a u16.
+ */
+#define U16_FILL(m)								\
+	"*(u64 *)(r10 - 8) = r8; r2 = *(u16 *)(r10 - 8); r3 = " m "; r3 += 1; w4 = w2;"	\
+	"w4 += -1; if r4 > 61 goto out_%=; r1 = r6; r1 += r3;"
+
+LINKED(outermost_common_base, VALID, U16_FILL("r2"))
+LINKED(innermost_common_base, UNBOUND, U16_FILL("r8"))
+/*
+ *	u8 n; .. if (n > 3) return 0; c = buf[n * 16];
+ * n is in a 64-bit register, the compiler tests a masked copy. r2 is (u8)r8. If r8 fits in a u8 too
+ * the jump bounds it.
+ */
+#define MASKED_COPY(shift)							\
+	"r8 >>= " shift "; r2 = r8; r2 &= 255; if r2 > 3 goto out_%=; r8 <<= 4; r1 = r6; r1 += r8;"
+
+LINKED(masked_copy_tested, VALID, MASKED_COPY("56"))
+LINKED(masked_copy_tested_256_is_0, MAP_OOB, MASKED_COPY("55"))
+/*
+ *	p = &hdr[n]; if (n >= 4) return 0; c = p->type;
+ * sizeof(hdr[0]) is 20, n is a u8 in a slot, hdr is live in a slot. The jump bounds r2. The
+ * expression of r1, *fp-16 + (u8)*fp-24 * 20, is evaluated in the state after the jump.
+ */
+#define HDR(cnt)								\
+	"*(u64 *)(r10 - 16) = r6; *(u64 *)(r10 - 24) = r8; r2 = *(u64 *)(r10 - 24); r2 &= 255;"	\
+	"r3 = r2; r3 *= 20; r1 = *(u64 *)(r10 - 16); r1 += r3; r3 = " cnt ";"	\
+	"if r3 > r2 goto l_%=; goto out_%=; l_%=: r0 = *(u64 *)(r10 - 16);"
+
+LINKED(scaled_index_tested_after_the_add, VALID, HDR("4"))
+LINKED(scaled_index_tested_after_the_add_oob, MAP_OOB, HDR("5"))
+/* both branches evaluate in their own state: r7 is 8 or more in the one, less in the other */
+LINKED(scaled_index_in_the_other_branch, MAP_OOB,
+	"r2 = r7; r2 *= 8; r1 = r6; r1 += r2; if r7 > 7 goto l_%=; goto out_%=; l_%=:" USE_R6)
+LINKED(scaled_index_is_32bit, VALID,
+	"w2 = w7; w2 *= 16; r1 = r6; r1 += r2; if r7 > 3 goto out_%=;" USE_R6)
+/* w2 wraps: r8 is 0x10000003 */
+LINKED(scaled_index_is_32bit_and_wraps, __failure,
+	"r8 >>= 32; w2 = w8; w2 *= 16; r3 = r8; r3 *= 16; if r2 > 48 goto out_%=;"
+	"r1 = r6; r1 += r3;")
+LINKED(scalar_is_evaluated, VALID,
+	"r3 = r7; r3 *= 8; r2 = 63; r2 -= r3; if r7 > 7 goto out_%=; r1 = r6; r1 += r2;")
+LINKED(scalar_is_evaluated_oob, __failure,
+	"r3 = r7; r3 *= 8; r2 = 63; r2 -= r3; if r7 > 8 goto out_%=; r1 = r6; r1 += r2;")
+/* the operand r8 + 1 is dead, its leader is r8 */
+LINKED(leader_plus_constant, VALID,
+	"r4 = r8; r4 += 1; r2 = r4; r2 *= 8; r4 = 0; if r8 > 6 goto out_%=; r1 = r6; r1 += r2;")
+LINKED(leader_plus_constant_oob, MAP_OOB,
+	"r4 = r8; r4 += 1; r2 = r4; r2 *= 8; r4 = 0; if r8 > 7 goto out_%=; r1 = r6; r1 += r2;")
+LINKED(shifted_index, VALID,
+	"r2 = r8; r2 >>= 2; r1 = r6; r1 += r2; if r8 > 255 goto out_%=;" USE_R6)
+/* r8 is dead at the jump. Its leader r3 holds 32 or 8 bits of it: r8 is 1 << 32, 1 << 8 */
+LINKED(remainder_of_low_32_bits, MAP_OOB,
+	"w3 = w8; r2 = r8; r2 %%= 100; r8 = 0; if r3 > 63 goto out_%=; r1 = r6; r1 += r2;")
+/* r8 >> 32 has a leader and no value */
+LINKED(operand_has_a_leader_but_no_value, __failure __msg("R1 unbounded memory access"),
+	"w3 = w8; r2 = r8; r2 >>= 32; r2 += r7; r8 = 0; if r7 != 0 goto out_%=;"
+	"r1 = r6; r1 += r2; r0 = r3;")
+/* the bound is filled from 8 bytes: a 32-bit spill below 4 bytes that nobody knows */
+LINKED(bound_of_loop_above_a_32bit_spill, UNBOUND,
+	"*(u64 *)(r10 - 16) = r8; r3 = 5; *(u32 *)(r10 - 16) = r3; r1 = 0;"
+	"l_%=: r2 = *(u64 *)(r10 - 16); r1 += 1; if r1 < r2 goto l_%=; r1 *= 12; r1 += r6;")
+LINKED(zero_extension_of_low_8_bits, MAP_OOB,
+	"r3 = r8; r3 &= 0xff; r2 = r8; r2 &= 0xffff; r2 *= 8; r8 = 0; if r3 > 7 goto out_%=;"
+	"r1 = r6; r1 += r2;")
+/* Two slots have the expression (spill32 r8). Their upper halves differ: r3 is 1 << 32 */
+LINKED(two_partial_spills_of_one_value, __failure,
+	"r4 = 0; *(u64 *)(r10 - 16) = r4; *(u32 *)(r10 - 16) = r8; r4 = 0x100000000 ll;"
+	"*(u64 *)(r10 - 24) = r4; *(u32 *)(r10 - 24) = r8; r2 = *(u64 *)(r10 - 16);"
+	"r3 = *(u64 *)(r10 - 24); if r2 > 63 goto out_%=; r1 = r6; r1 += r3;")
+/* r3 is r6 + 0, 8 .. 56. r3 + r8 is not a multiple of 8: 8 bytes at 63 */
+LINKED(step_of_the_address_base, MAP_OOB,
+	"r2 = r7; r2 &= 7; r2 <<= 3; r3 = r6; r3 += r2; r8 >>= 32; r1 = r3; r1 += r8;"
+	"if r8 > 7 goto out_%=; r0 = *(u64 *)(r1 + 0); r0 = *(u8 *)(r3 + 0);")
+/* The divisor is a range that has 0: the quotient is not known, whatever the jump tells */
+LINKED(dividend_tested, VALID,
+	"r3 = r7; r2 = r8; r2 s/= r3; if r8 > 7 goto out_%=; r2 &= 63; r1 = r6; r1 += r2; r0 = r3;")
+/* r7 is another value at the jump than in r9 */
+LINKED(operand_is_overwritten, MAP_OOB,
+	"r9 = r7; r9 *= 8; call %[bpf_get_prandom_u32]; r7 = r0; r7 &= 255;"
+	"if r7 > 7 goto out_%=; r1 = r6; r1 += r9;")
+/* a pointer is evaluated below an add only */
+LINKED(pointer_minus_index, __failure,
+	"r1 = r6; r1 += 63; r1 -= r7; if r7 > 63 goto out_%=;" USE_R6)
+/* r3 is an address as a scalar. r6 + r7 * 2 has the offset [0, 14]: that is not the range of r3 */
+LINKED(offset_of_pointer_is_not_scalar, UNBOUND,
+	"r2 = r7; r2 *= 2; r5 = r6; r5 += r2; r3 = r5; r3 = le64 r3; if r7 > 7 goto out_%=;"
+	"r1 = r6; r1 += r3;")
+LINKED(product_of_pointer, UNBOUND,
+	"r5 = r6; r5 += r7; r3 = r5; r3 = le64 r3; r3 *= 2; if r7 > 7 goto out_%=;"
+	"r1 = r6; r1 += r3;")
+/* As index_is_constant_that_the_add_refuses: r7 + r8 * 16 is r10 - 32 + 0x100000010 */
+LINKED_SEC("tc", scaled_index_that_the_add_refuses,
+	__failure __msg("dynptr has to be at a constant offset"),
+	"r1 = r9; r2 = 0; r3 = r10; r3 += -16; call %[bpf_dynptr_from_skb];"
+	"r8 >>= 8; r7 = r10; r7 += -32; r3 = r8; r3 *= 16; r1 = r7; r1 += r3; r2 = 0x10000001 ll;"
+	"if r8 != r2 goto out_%=; r2 = 0; r3 = r7; r4 = 0; call %[bpf_dynptr_slice_rdwr]; r1 = r6;")
+
 /*
  *	static void clamp(struct buf *b) { if (b->len > 63) b->len = 0; }
  *	clamp(&b); c = b.data[b.len];
@@ -3612,6 +3712,14 @@ LINKED(callee_writes_next_field, VALID, CALL(store_next_and_clamp))
 /* another address base can be another name of the memory */
 CLAMP(store_alias_and_clamp, "*(u64 *)(r4 + 0) = r2;")
 LINKED(callee_writes_through_alias, __failure, CALL(store_alias_and_clamp))
+static __naked __noinline __used void clamp_through_r0(void)
+{
+	asm volatile (
+	"r0 = r1; r1 = 0; r3 = *(u64 *)(r0 + 0);"
+	"if r3 <= 63 goto +2; r3 = 0; *(u64 *)(r0 + 0) = r3; r0 = 0; exit;"
+	::: __clobber_all);
+}
+LINKED(callee_has_the_address_in_r0, VALID, CALL(clamp_through_r0))
 
 /*
  *	struct { char *buf; u64 len; } c = { buf, 0 };		bpf_loop(100, append, &c, 0);
-- 
2.55.0

