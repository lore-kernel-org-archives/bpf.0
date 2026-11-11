Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794415627;
	b=vvNP3zsOewoLmxNOMQv7XDrSGTjSumdLGTqXA8e+Ub5EyhmYiqZsxSJMbS07Bu3LrQiJ
	 MPhF4p0+RQt8tD+bcc0Llwl9KbN7MlNGIfNMSBepju5PLT5luyhRilK6HdyETZ2X44SYW
	 knRMNrjUlau8yrHRo3IxeyafUWGr1D9KNB+wlVZcL4MW6/ymP98I0QAbufVGnvvTbm3S7
	 hnhZP5u+sVCCDmmo9Ch0PCYMf7IX6lL3XrrMnVbHyI9lkD4iwU+ihvWTyshldUf71mus6
	 P1fy4vVmDOmd7YI+m8mZVtRNhyX03BcUN+A/Y9cUkai9VsS4hj8c7427NjrhdP210Dw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794415627;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=TFkOTbaH5h93PUAjrWSBGidbhek4et0s9TiTQkOx1gs=;
	b=Bvd+zfL62KRcR+yH8xdRHs720Ut9VCu52hER1L7pH0LS1cIohSgYMNvwSRhYOI9M0WLX
	 hyNtw5zH+6y86kFWD9Xg4FJnvnOUEN3aycclAY4eRsafOTbY1w3R0xCGTNblkSkeJqzf+
	 0QT5Q01uCrZdazME+AXwZLuJDaNyVxS3c1enyMcTb/Z7oIEwUwKfTdrZmR4TNiV6H9Trr
	 qCV/ZPTM5NGFfLFOYN9u7qLvAwowp7e0/pw4CnvWU4vnqaKAyE/CzgTFimCmnvxhQZlmf
	 9my09kQgap7MGmX7jVxJD6M8G9RowKeEeBlKfNhp4sQnWcdVtFQ0lL3xgILIa3LSSlA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vcDTN2Rh;
	arc=none smtp.remote-ip=209.85.216.41
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED0EE606A33C
	for <bpf@vger.kernel.org>; Wed, 11 Nov 2026 16:47:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ED0EE606A33C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vcDTN2Rh
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-3b0e0e65adbso1706276a91.3
        for <bpf@vger.kernel.org>; Wed, 11 Nov 2026 08:47:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794415626; x=1795020426; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TFkOTbaH5h93PUAjrWSBGidbhek4et0s9TiTQkOx1gs=;
        b=vcDTN2RhhuQ1/SkCctfYj61zJEbyeAKE/8DwmFd25gNFkosYr3wp75VKWhkmFNFIKb
         HoJBblxlkB0a//uKBHdeNMjXp0vxe977CPty8Iw8woSphcp7FF5fMfv0OT+V0LwOrxsb
         PMImdX0YGlOWpe1ljYNK2xrZBoMij85BlZSYIiWes0mOBFZmN9A8lcLg5NQuSIHKSTsd
         f0OVOutzT4KTq9AM8bgEREGB5HR3rz9Gt4mLMoJ8C0N8UGeZqLZ7H01IpbfH2PZYDV5V
         +9ThKFTdvM0Eexl6oRubxE4KGjiLyWTzZQ6mUHIaAcgv4uPXIUccTJPCjMkyJ0SF1MGZ
         vVPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794415626; x=1795020426;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=TFkOTbaH5h93PUAjrWSBGidbhek4et0s9TiTQkOx1gs=;
        b=tBrRWY6JKkz9r26i334cC56SDhuS+ykmtP9nCEo7Fj7M8WzkzFf13r6QqJVbpKcTxx
         3KKNYYCVF+9UFzVsJfe6e4jM80l3Q1QWSeS+iJbml6njtMYNRnuqRBEhQMlnLeVXayfU
         8ZkQnWJM9nX/LYZY16J62S/YLqVy/mTbX1PfOYyFLZnUreb5F5Rvziki1Cpb4OHJXUTp
         zSLaeBF6z3aQpZKKywp9KC/PC8NPP9EpB1GlWxKM6rvmdzLStWP1phtqn36jTZllUzqd
         R9Y56SiUMr85X3k/Bq4kf5FrKP1p/seqfbtbNb8yqxTV84T0GBsZwAKxeuE+t3cKn7iR
         q0rQ==
X-Gm-Message-State: APuU4Z+HsW6kDyTaSfKS7nqHhAoAnawbDl/43xjFXttSP84HkSHYj9Pg
	aG72bL2TSYXZJ4lZNJigCJGOTyi+rSZb0P9eURdbhP6lZ6MB84HbSTvvp3UCaA==
X-Gm-Gg: AYBFou18ujdKJXy6Mgm7psI/2gp0t4hEdjKC4wqgvvBPopGHIXFerYNWNnBHTo/gcig
	XIN+7RaFyyKstLt4Jwyyp0KAy9PJiYPoM3Cdz2okZQD8PNafMuE9Q1yOF3bm1ymLXFOzJ8I934G
	ZxxlJdGlDRpY/wettHSmW0b0ZNcRDKazspKWV+fx4spJe8+mlaN6xp+anDtn99IUpxEc5Lp47aO
	kMSf/m9Q55oQjI9R2BqpJbkzSlWeaeeS/aJilmMcARGEhrn2nctH3ZKXRZ5oTgqGzUdX7dAfhv1
	ojQchW3vWI2NNDi2P7nhnrMNU11ZqBMH77xpUNPgkPAeHNgSgiBxFTiJFhzSkHJ+cvgTW4Hb2ur
	KYwv8bidS+i5fyrmw5ldJ57dw8fUy6mXlZ2QbJ9MEB+jKruy11mOufa4qFVIr/xBvgdomYl43eC
	cVHRy7UhwbHNg7ZimYoQ0Ac8vpr2khmgVaSe5BVgHlZnLVM9fX1niKcDMS6Nywkw77aqQTBEIPA
	7g/KBv8ztAzwFxYLZzX+mCsBN+onyGpC6FBHYUFC5UUh1EBfmppBcIdp3zWL3kikv9AB0xwolMt
	+egLrnoPNg8RhYnylfEHNlbM1nl/GNs2EMhjmRtfSwmJ1GcJSt4bWhY1MmveznikQgPXPETfH1g
	kZ7PSIamzQSXpTajf8S/oDdbvJ+KV8y/22EpoyJBp1WZh2i5ku92FvEYQ8lH+6TlHSkAdnZ4DCg
	==
X-Received: by 2002:a17:90b:57cb:b0:3ac:7872:d1b7 with SMTP id 98e67ed59e1d1-3b182eec0f1mr2828472a91.32.1794415626086;
        Wed, 11 Nov 2026 08:47:06 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.252])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cdd8d67e53asm2079561a12.5.2026.11.11.08.47.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 08:47:05 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next v3 11/29] bpf: Don't treat half of a 64-bit spill as a 32-bit spill on big endian
Date: Wed, 11 Nov 2026 16:45:34 +0000
Message-ID: <20261111164557.2659679-12-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261111164557.2659679-1-alexei.starovoitov@gmail.com>
References: <20261111164557.2659679-1-alexei.starovoitov@gmail.com>
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

A fix of the main pass for big endian that stands alone. The patches that
follow refine more registers and stack slots at conditional jumps, so more
progs would run into it.

	*(u64 *)(r10 - 8) = r1
	r2 = *(u32 *)(r10 - 8)

r2 gets the low 32 bits of r1 on little endian and the upper 32 bits on big
endian. In two cases the verifier gives r2 the range of the low 32 bits on
big endian too.

The fill itself is right: check_stack_read_fixed_off() asks
bpf_stack_narrow_access_ok() where the low bytes of a spill are. A fill
from elsewhere gets an unbounded scalar.

After the 32-bit spill '*(u32 *)(r10 - 8) = r1' the half-slot at r10 - 8 is
STACK_SPILL and spilled_ptr describes r1, whose low 32 bits it holds on
both byte orders. Two functions take a 64-bit spill for such a slot:

 - __clean_func_state() marks a dead half-slot STACK_POISON. If that is the
   one at r10 - 4, what remains of a 64-bit spill has the slot types of
   a 32-bit spill.
 - stacksafe() skips the bytes that are STACK_MISC in the old state. An old
   32-bit spill and a current 64-bit spill are then compared by regsafe()
   of spilled_ptr.

That is right on little endian, where the half-slot at r10 - 8 has the low
32 bits of a 64-bit spill. On big endian it has the upper 32 bits.

Keep such a 64-bit spill whole in __clean_func_state(). In stacksafe()
compare two spills only if the bytes of the old one are the low bytes of
the current one. bpf_stack_narrow_access_ok() decides in both.

Two tests in verifier_spill_fill.c, one per function. They load on little
endian and are rejected on big endian.

Fixes: be23266b4a08 ("bpf: 4-byte precise clean_verifier_state")
Fixes: 6715df8d5d24 ("bpf: Allow reads from uninit stack")
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/states.c                           | 19 ++++++++++++
 .../selftests/bpf/progs/verifier_spill_fill.c | 31 +++++++++++++++++++
 2 files changed, 50 insertions(+)

diff --git a/kernel/bpf/states.c b/kernel/bpf/states.c
index efc0870b85c2..b60676349655 100644
--- a/kernel/bpf/states.c
+++ b/kernel/bpf/states.c
@@ -168,6 +168,16 @@ static void __clean_func_state(struct bpf_verifier_env *env,
 			    stype == STACK_IRQ_FLAG)
 				continue;
 
+			/*
+			 * When the half-slot closer to FP is dead, what remains of a
+			 * 64-bit spill looks like a 32-bit spill: the low 32 bits of
+			 * the value. On big endian the other half-slot holds the upper
+			 * 32 bits.
+			 */
+			if (hi_live && bpf_spill_size(bpf_stack_slot(st, i)) == BPF_REG_SIZE &&
+			    !bpf_stack_narrow_access_ok(0, BPF_REG_SIZE / 2, BPF_REG_SIZE))
+				continue;
+
 			/*
 			 * Only scalar spills can be degraded to raw stack bytes
 			 * when their high half is dead. Pointer spills need the
@@ -446,6 +456,15 @@ static bool stacksafe(struct bpf_verifier_env *env, struct bpf_func_state *old,
 		if (!cur_slot)
 			return false;
 
+		/*
+		 * The old spill is the first bytes of a wider spill. On big endian
+		 * these are not the low bytes of the value.
+		 */
+		if (old_type == STACK_SPILL && bpf_is_spilled_reg(cur_slot) &&
+		    !bpf_stack_narrow_access_ok(0, bpf_spill_size(old_slot),
+						bpf_spill_size(cur_slot)))
+			return false;
+
 		/*
 		 * 64 and 32-bit scalar spills vs MISC/INVALID slots and vice versa.
 		 * Load from MISC/INVALID slots produces unbound scalar.
diff --git a/tools/testing/selftests/bpf/progs/verifier_spill_fill.c b/tools/testing/selftests/bpf/progs/verifier_spill_fill.c
index 0baa8e06b8d1..623ed5ef3630 100644
--- a/tools/testing/selftests/bpf/progs/verifier_spill_fill.c
+++ b/tools/testing/selftests/bpf/progs/verifier_spill_fill.c
@@ -1451,6 +1451,37 @@ __naked void imprecise_scalar_spill_half_dead(void)
 : __clobber_all);
 }
 
+/*
+ * The first half-slot of a 64-bit spill holds its low 32 bits on little endian only.
+ * The test spills to r10 - 8. The first four bytes of the slot are an offset into one byte.
+ */
+#if __BYTE_ORDER__ == __ORDER_LITTLE_ENDIAN__
+#define FIRST_HALF_IS_LOW	__success
+#else
+#define FIRST_HALF_IS_LOW	__failure __msg("access may be outside object bounds")
+#endif
+#define FIRST_HALF(name, stores)						\
+SEC("raw_tp") FIRST_HALF_IS_LOW							\
+__naked void name(void)								\
+{										\
+	asm volatile (								\
+	"call %[bpf_ktime_get_ns];"						\
+	stores									\
+	"r7 = *(u32 *)(r10 - 8); r1 = %[single_byte_buf] ll; r1 += r7; r0 = *(u8 *)(r1 + 0);"	\
+	"out_%=: r0 = 0; exit;"							\
+	:									\
+	: __imm(bpf_ktime_get_ns), __imm_addr(single_byte_buf)			\
+	: __clobber_all);							\
+}
+
+/* The low 32 bits of the value are 0. The second half-slot is dead after the jump. */
+FIRST_HALF(first_half_of_spill_second_half_dead,
+	   "r0 <<= 32; *(u64 *)(r10 - 8) = r0; if r0 == 0 goto out_%=;")
+/* One path has a 32-bit spill of r6, whose low 32 bits are 0, the other one a 64-bit spill */
+FIRST_HALF(spill_of_64_bits_vs_spill_of_32_bits,
+	   "r6 = r0; r6 <<= 32; if r0 > 5 goto 1f; *(u32 *)(r10 - 8) = r6; goto 2f;"
+	   "1: r6 = 0x7ffffff000000000 ll; *(u64 *)(r10 - 8) = r6; 2:")
+
 /* check valid spill/fill, ptr to tp buffer */
 SEC("raw_tracepoint.w")
 __success
-- 
2.55.0

