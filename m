Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794498869;
	b=MvLZ3ZUfmy1As4hcix2jDvPoXPhJwc2lfCwhNXjyzhBW0CLsbYmY6gYtY+/9xLJu5Lhx
	 REtDctCgltUWzstxSQBAIhtKHwNJ9hQahscMJSbook/G0iVpw4a0uuoeEu3crCcp8pPyK
	 wfG8Bkv5MAjzRmlOTVv/UEzQ6v4dPD1moTHk0p05mKnWlSt/a2IM4MFAJ6WlTE0akxcLC
	 3/z3DTkjcjnEkoUxqZQv0P5x3J4bd0QeWWVNBikv1AFZ/S8PDAt9CbDqoiu/f4W9jyInC
	 vK7jV3sAg3IUmUin5B2VSWpi5JPV23x3zc6hYno82TKSfvzkgwJx+2dsHPGwsyGE0Wg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794498869;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=m0yxcbitoPwaoyIZjidXv1MS88yf9Z1UTDaVRsCujAI=;
	b=0Gbj4QBVkH6pNH0uHsmLL86rrRDfvCdy+AXTwP7w9NWauRBdnwuy5mnPS2Rm2cwQ30hd
	 BGkgsyyqYzsSVe24kYhiIabbrnC9OovQb6rwXJO7U5dY7bpy1UPZJiGODNWV5IJmJGrdV
	 KTYdL0J7gpGSMQr2M/LzW8+dJx2oh2EOhDOkIT66FP0QGZQ1ImFHlxIk/h4G/EDsXM4WW
	 y9wGTG9lppu9zDVm0+7EHMbeNqudYjZSDoKcre8mPrPOPQXehvU4lKclEPeeHEM9CtjPR
	 Epzh6NPZCSSiUVcmEy/LlE7nxsbtQAot1iBS0ZWRW0Q78AoU52hqPaLRwL/uhQTEdgQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AbsQaXZJ;
	arc=none smtp.remote-ip=209.85.216.46
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A571606A327
	for <bpf@vger.kernel.org>; Thu, 12 Nov 2026 15:54:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2A571606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AbsQaXZJ
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-3b0b3754f57so2641949a91.0
        for <bpf@vger.kernel.org>; Thu, 12 Nov 2026 07:54:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794498868; x=1795103668; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=m0yxcbitoPwaoyIZjidXv1MS88yf9Z1UTDaVRsCujAI=;
        b=AbsQaXZJpzTVx1ghLzz8ksyhu8d9Z7LXs2tJOpUqwwvjMQNmOmcoTZhFR56lyGkcqC
         tz/RWh4uroHZuU5V8PLRDGGpzy7Vw2uwedz3mDAFLi5eVcNJedfTFp0AWmxzGwLeCNNm
         OIFLmZfZTF0UWMAR+P3FnTArNBBmiYl971qWTRN0wmJ/CJfSuo+UKGVCobiyGR52Dy9U
         p8rNp6y304wYUkrs1sGvF/myVkeaODInw5pyJMKxJVIIueLOoGeQ4KEx+DsaMhCItSK6
         GlKmr2STLf5l2LnFfKz/SYg/2odG8q6vTv/jWFFAs7k0LlLaKq4vS8B+ZdDzELYokKdM
         UXYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794498868; x=1795103668;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=m0yxcbitoPwaoyIZjidXv1MS88yf9Z1UTDaVRsCujAI=;
        b=XZ1M7Opk0rBWW1bCidvfm4Q5dUd9stVRPX7D6bGnXpSEPKPLK3jQIuj66bfa5Ami+T
         +rXnbcf1+sw6OrjGWdfh3DV5RC0UMjb+1MWID0x6SPxpnlqBSgPlpx7FgbLAE7UVzfyL
         6n/vLhtlLGLb8CDp2uHSaiyv+iXdMRFocSc1n0TAOzUagPYeBzdnS6HgjQ5caS8Xrhoj
         qCbNxkkRvMYB/obSSIhWkiU79Oeha3VO0YA/89W/rcdXO0QwPPkQaYduPN4+q6qEE718
         ICN27B8OjAQ9wORB1bTYwVSIrBtrv86eec459pfJtNQBSCQVPhYimUdWnEdUPfc4HXAd
         CiXw==
X-Gm-Message-State: APuU4Z9nEIoNztGBgUtIgUuMRYGeSnAz3d5vFYbQbxtxTC+DAfDwkY+Y
	QCWfYhHU7r+lz/FtPp0pRZsWluPkP2QDHjb71SYDMSeCZGNqKw7Tfkpg3BKL6w==
X-Gm-Gg: AYBFou3E9y9fWAuWRenbY7QUuptXAarUhBiafYnINlTUPO26pqrpwjV2RGB6Wt8pm2E
	m4w87wMs5nkrNzkNBMBLL3bOC/HQei/9WviBYjBLYlLIn6+Y6NZaQ+ggaFBYzSO5uvZHZORe1Av
	CL8e2SbDm+FL3/Olg4+t9cUSd/WQtM5Q6kdu/Orr/ZEuW8cxI5larrfbA9+Oxv0vQyA6WFLllA+
	nOQojEnGfc/XEaDywpzwlboL1lA0YaGMIGPTO0V5nzf8f7QvRl1a5AK6dv6rONeSCAOCTs/qtgD
	Ta8ZLkmoI5wTAFxYV16HbIeV0MTturlP73+bgXK6W4H1TGKU/XhQly5D53EhU+W3I4UMRkWNaWP
	BQkaiHSKZg4OTtfxiMvwkS/LHDd/nAdgI2BYZ40eYmRinnTsy9mWBP86pbptJmM8GXVxKegeOo1
	sWNt2Q2LadF0iPmyUo5DKsx0m3O6Pb3iMIYMFTB52ldYWAn4ulXk24W6b0CTf/Q/3KDDNjoq76g
	nRk2sFKC/gk0D3knXsaKnG35bUTWnuNoS1FaJZZZxX6qQQPEO+q1KrRw1+mKfYVAKvOGoASBi/j
	8toJMrM0z6UyoEeN0HklI8L0GWoncDFED9V9IJFUi+JkD1pzVLlcSV8mBwjh7k9Mt/D63KtSZwB
	T5qubHmj61h3Shq+QyAohnzvkTUqaHG9wlQCiSjer+c80er5pFQY+orpcx/xBp+lym+VKl0Aa75
	c=
X-Received: by 2002:a17:90b:2887:b0:3ac:7378:be04 with SMTP id 98e67ed59e1d1-3b182d35e6bmr5912756a91.0.1794498868150;
        Thu, 12 Nov 2026 07:54:28 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.243])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b197d0fdbdsm5243908a91.10.2026.11.12.07.54.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 07:54:27 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next 08/12] bpf: Treat 'r1 &= 0xff' as a zero extension in scalar evolution
Date: Thu, 12 Nov 2026 15:53:33 +0000
Message-ID: <20261112155337.1040699-9-alexei.starovoitov@gmail.com>
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

The HTTP/2 filter of the Datadog agent counts the frames that it keeps in
a __u8 (find_relevant_headers() of release 7.50):

	__u8 interesting_frame_index = 0;
	..
	/* in a loop that is unrolled */
	if (interesting_frame_index < HTTP2_MAX_FRAMES_ITERATIONS && ..) {
		frames_array[interesting_frame_index].frame = ..;
		frames_array[interesting_frame_index].offset = ..;
		interesting_frame_index++;
	}

The count is in a 64-bit register, and clang masks a copy at every use:

	2802: r1 = r6
	2803: r1 &= 255
	2806: if r1 > 0x1d goto pc+27
	2818: r1 = r6
	2819: r1 &= 255
	2820: r1 <<= 4
	2822: r3 += r1
	2829: *(u8 *)(r3 +8) = r1
	invalid access to map value, value_size=488 off=488 size=1

The states of the unrolled iterations are joined: r6 is [0, 30]. The jump
bounds r1. (& r6 255) is a base of its own, so nothing links r1 to r6, and
the second copy is [0, 30] again.

(& x 0xff) is (zext8 x) and (& x 0xffff) is (zext16 x), as in LLVM's
ScalarEvolution: simplify() rewrites them. The base below the extension is
r6: r1 == r6 modulo 2^8, and refine_linked_regs() takes two registers that
fit in a u8 for equal. The main pass does not change.

'w1 &= 0xff' is (zext32 (zext8 x)): a zero extension of a zero extension
that is not wider is dropped.

In a prog with an arena the ALU64 insn has a def. There is no link through
it, as before.

Two tests of verifier_bounds_step.c want a range in '(u8)r6' after a jump
on r6. 'if r6 > 0' leaves the constant 0 there now. Test 'r6 > 0xff'.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/scev.c                                  | 14 ++++++++++++++
 .../selftests/bpf/progs/verifier_bounds_step.c     |  4 ++--
 2 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/scev.c b/kernel/bpf/scev.c
index 991f800b1b15..af437e9286cb 100644
--- a/kernel/bpf/scev.c
+++ b/kernel/bpf/scev.c
@@ -478,6 +478,11 @@ static u32 op_low_bits(u32 op)
 	return 0;
 }
 
+static bool is_zext(u32 op)
+{
+	return op == ZEXT8 || op == ZEXT16 || op == ZEXT32;
+}
+
 /* The low @bits bits of the slot are those of @left. The other bits are not known. */
 static bool is_spill(struct scev *scev, int id, u32 *bits, u32 *left)
 {
@@ -2714,6 +2719,11 @@ static int simplify(struct scev *scev, u32 id)
 	    is_imm(scev, b, &imm1) && imm1 == 32 && !scev->exprs[l].def.set)
 		return expr1(scev, ZEXT32, a);
 
+	/* 'r1 &= 0xff' is (u8)r1, 'r1 &= 0xffff' is (u16)r1: (& x 0xff) -> (zext8 x) */
+	if (is_binop(scev, BPF_AND, id, &l, &r) &&
+	    is_imm(scev, r, &imm1) && (imm1 == 0xff || imm1 == 0xffff))
+		return expr1(scev, imm1 == 0xff ? ZEXT8 : ZEXT16, l);
+
 	/* (+ (linear base slope) imm) -> (linear (+ base imm) slope) */
 	if (is_add(scev, id, &l, &r) &&
 	    is_linear(scev, l, &base, &slope) &&
@@ -2741,6 +2751,10 @@ static int simplify(struct scev *scev, u32 id)
 	if (!bits)
 		return id;
 	t = scev->exprs[id].params[0];
+	/* 'w1 &= 0xff': (zext32 (zext8 $a)) -> (zext8 $a) */
+	if (is_zext(op) && is_zext(scev->exprs[t].op) && !scev->exprs[t].def.set &&
+	    op_low_bits(scev->exprs[t].op) <= bits)
+		return t;
 	if (is_low_bits(scev, t, bits, &a))
 		return expr1(scev, op, a);
 	if (is_add(scev, t, &l, &r) && !scev->exprs[t].def.phi &&
diff --git a/tools/testing/selftests/bpf/progs/verifier_bounds_step.c b/tools/testing/selftests/bpf/progs/verifier_bounds_step.c
index b42717a825c6..2b8ff0f44c36 100644
--- a/tools/testing/selftests/bpf/progs/verifier_bounds_step.c
+++ b/tools/testing/selftests/bpf/progs/verifier_bounds_step.c
@@ -473,7 +473,7 @@ __naked void step_prune_hit_const_on_line(void)
 	r7 = r0;					\
 	r1 = r6;					\
 	r1 &= 0xff;					\
-	if r6 > 0 goto l_cur_%=;			\
+	if r6 > 0xff goto l_cur_%=;			\
 	r1 *= 3;			/* step 3 */	\
 	goto l_join_%=;					\
 l_cur_%=:						\
@@ -523,7 +523,7 @@ __naked void step_prune_miss_const_off_line(void)
 	r7 = r0;					\
 	r1 = r6;					\
 	r1 &= 0xff;					\
-	if r6 > 0 goto l_cur_%=;			\
+	if r6 > 0xff goto l_cur_%=;			\
 	r1 *= 3;			/* step 3 */	\
 	goto l_join_%=;					\
 l_cur_%=:						\
-- 
2.55.0

