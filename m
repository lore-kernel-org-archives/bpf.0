Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794374092;
	b=PMez+zNnW0mYZSZ2ZQkqYSTcPpz0zaljJ6+RKxpJDsGXwGn5nzSbNzLuumEkrf2oMNLf
	 x8zxFSu/wE53oKuuLUWMc/29tOf27Wvi5VfDbHsM+AWclo5hb52UOZxJpZxuoJhii0fh1
	 gwQ4PeeTUm/0Z1VXcSlW2mzD/un7wCB96MMs0XQv5MX8QKtb2w4k8M7nDcPF6w0aKiOdf
	 5Ry/j6x54YA/vv6UU1ATl4G7dhE9hYk67dmdnABMcnwKOASyajj/umWKFG7rPjIQm/KCy
	 KnclPOqSLVjOJ8GkZL544c3A69C62aQAJrMslTeDdUy68X4nVXTiPuoL19WogJvDizA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794374092;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=TFkOTbaH5h93PUAjrWSBGidbhek4et0s9TiTQkOx1gs=;
	b=cDQ8hTyXn8swI0oaXuNT6EkuyBBROHlNIte0i72/SuaPvx6a+vZDQJVbG0Gw9hD74eBb
	 vrJZrvmEolwZRZTfTA+emrWaixyitmJg0x9Ck7vyILr1U9cUXrdF2o2JEAKxDExU3hbB3
	 euJqvwwgp0fWPFZtjWos0mJi4oDRlvhz9s7z+QGpE6j/KJ++qdWK+0OHGOzS+8dapRq4r
	 xxDA2Yl0pVdfKYXRmItB16oppEqOhhuyLlZImHRkkIOPPzQK+B5PGTtVTuN2wyEbCl5WR
	 WqTXdCJ/dSZGAIu5QWcvEYyoo4CP/Tz3EtvH6i1g5sTY/gIT7FcMSnb71CpvlSsy0Wg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=F7jbhSwE;
	arc=none smtp.remote-ip=209.85.216.50
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2ED7606A31C
	for <bpf@vger.kernel.org>; Wed, 11 Nov 2026 05:14:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B2ED7606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=F7jbhSwE
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-3b094e649d3so1688406a91.0
        for <bpf@vger.kernel.org>; Tue, 10 Nov 2026 21:14:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794374091; x=1794978891; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TFkOTbaH5h93PUAjrWSBGidbhek4et0s9TiTQkOx1gs=;
        b=F7jbhSwENYlt849h53IlA+tXc9gWkANVjGpPxXDSb4/+CVbJvI+KdaQv0Mibw0sTaQ
         s5HWSFvBegnIa1ZQf3Pjn37k7cE5j7pa2SiAIGxlpDgfMZXmTU+lIefwpEjMBfIX95FU
         tuD4LmABuMAvqqmFRQzyqc5Hs7Zg17nTCEJG39r69wNMbo3z4seXZvR7rOU+Mw55sRpb
         +h6YQFaZ7GUmEgsdzxVRFnClImiHrTmncpY8yMvgVwwtslh8N82ZBKaT8VZ3I/ZCv3Ot
         LVSnr48D477vdPJ0KSWsT/pd3hccnjmh1rGg2fOVOuRRQnuB3COuGE+owUzPfWWcBzME
         HIjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794374091; x=1794978891;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=TFkOTbaH5h93PUAjrWSBGidbhek4et0s9TiTQkOx1gs=;
        b=o4XN76cCTL/GRsN6877RqGew7Zlt1KdAIGTSQ71eqSpBTkTaSYJ8OEvIbLXKRkm3EW
         KZo5SataYPfs1fG7PXA3QHqEd9aIhYh158EhwA7prlfPAF0hMWsE5z3V1nU4fnz/mfmW
         kCiJhpzNRIY2tRuyN1p/yBGjgDkRjMK5AVrHlX0TfrpkPuSnRGrK3n51yShx08UVtw+X
         yziU0nhbAYsSlW+EIC+HJ3fjKVwHGcLn+xdw/HA55HhBoh0Zlj4xwzTq3gbSjBFVkemT
         baAaC/xmjKfz/zbGYl2ZPefujtny4oT+7GUQoneC5L6eWqCtGroqrvQjVQo5IgiMR3i6
         Zzgw==
X-Gm-Message-State: APuU4Z/WyEATXEP9wvik7np5Cv1LtgHBE0sFsfxeLUk9syrMrKGuO1yH
	afSVaX+4c62Hn3sWQzg0WpXNm4VpVRGI8suACO6nFE5UkvelsZT2R4C1yBV8uA==
X-Gm-Gg: AYBFou3imKGhipiW5rq19Uz2AFolrrEJAb1vjTMtb5dd5aitIMup8qqudRXIcS6PJiB
	hNnqTVtutHGLzTwBkXRCOS95qb7Gp1YK5LWgZLTIfoNhXRQqwzIdxs4T8Oqz4F0tqx/Pd+tpy2r
	AAEUuP5UCo1edXZXfr3sc+nYuSsj14BXMZd5KHBbAn59itPpcxQ5K1WFf8wAPtVgU+b5EhqFpkq
	uUzZrm6rCFP6z4wqOJwwPERWdXd1IvWKTzk2rVsOC0eAPR4CNYpI8mnYFIyLo3LxU+GX/LKe+c7
	AxMoAFKgNOjMqIFt/yyHyOFo3XepdxNGben1+NvaszcvTMveseHFvyR+AB7a8dmc0CQBwzfDT8q
	WxQleWRmCTX2ayMNyP9W6KsC7V+avPAqc4I9Bd9ct6xlXS25+LUimzOGwn/wM8x0JuJSWwihqt9
	dDtnVZAhQW9Hzc/KPrccYrdRSLOvvjFBsjNKJckOHuELNBn+ygQqVr9Pn6RYGovoFkMAfrf84LM
	esTDkstgcPzh1tanN8o+DK0zYwLC2+8aYaPVqLL3TR8QFnsm65jtNwVZKFZtFD0Gmfoiicuw1Pp
	UYLh6OatdB4QQ2U0F6DCrm1g5LSlpgws//js07pwzYZlut8cEf9d+Wu/fpTTTQdKFM/1Keo24+A
	AF4QNBCfqTetKxs2MEmsw3r5xua5vdXZObarsxT9+2UOIGY19O/0Kk9ino2UbCgj4wBtriIVDXv
	s=
X-Received: by 2002:a17:90b:5910:b0:3ac:9d83:8856 with SMTP id 98e67ed59e1d1-3b182deab28mr1488466a91.9.1794374090845;
        Tue, 10 Nov 2026 21:14:50 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.250])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b18142fa70sm2271472a91.16.2026.11.10.21.14.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 21:14:50 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next v2 11/29] bpf: Don't treat half of a 64-bit spill as a 32-bit spill on big endian
Date: Wed, 11 Nov 2026 05:13:22 +0000
Message-ID: <20261111051341.2800252-12-alexei.starovoitov@gmail.com>
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

