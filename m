Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794374080;
	b=TPfRJyd/vyiZhHMYRvYVCcmUNuwOYlqKyZ2aoPxNjXvg5gqSu/j3jCa+DIo/d2GeofBF
	 XoaOQPdRS/8g2/vtFDjd4vYmdLBOWSJetXaQB1Z6j3vleFtLJgY7X4G8591MVuHWUugcG
	 YUFWbDm7cvBheN3D0DlZY0N8U3Ce5oqRUTelr5GdxAeN9r3XprKGXm19lTwomnXYxxpim
	 iDbrpYOV9HeC4URItqZklU/cK/au6O0X60EpoI6n4ZIJfmXaKfFeCB0M5Z/VqQfKCK8X5
	 EBxAYJYE1Nqmqd36ijV7Ow2cRMt/yErzwyrvBBOHYrMSdr1Q3M4Cu09/lNM5efMF2Mg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794374080;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=00H2MiRz9p8eLUkya05BzpmKsGZ1LM4lgngi7LRL8go=;
	b=2dKaChqCv4US5q14ZBaShzaSnut/CnVK0Sh9Pn+MKiFioX6mNh1V5KufdXtYTbw1xyRu
	 EzJKkKhiw/MRUL5ioCA4dP+/soTG5sOxuB46OWLsgvPXA4XjMHRSFDknYNZIw9pvGflHM
	 HUdqLT57xhwXIhNhJzWUnlROHd9dlNa49lOmw6IptAsdab2lvaDqj/idjDo/CRdRdQFNY
	 O8u3jO8+hEQtj0EwMZkfPX6VLrxDU2Q1+PLMYUFvspAg/3jPPDrkZaOGXXy3WUjNr/hLk
	 Aw1Yl7Ga3NHVEfLugQj7odExwzgDWIPqfBNCiRWLcqmLWKkqtTCkv2qoP76mr/N4+pA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Cn2i8gjd;
	arc=none smtp.remote-ip=209.85.215.176
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6943606A31C
	for <bpf@vger.kernel.org>; Wed, 11 Nov 2026 05:14:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B6943606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Cn2i8gjd
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-cdb684859cbso1598283a12.1
        for <bpf@vger.kernel.org>; Tue, 10 Nov 2026 21:14:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794374079; x=1794978879; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=00H2MiRz9p8eLUkya05BzpmKsGZ1LM4lgngi7LRL8go=;
        b=Cn2i8gjdhmwAjqgd20ngo8ikqYgldWkukVOKi2B2s6AP+McHuzT3Is+Q9StFNQjP78
         ppkD8eIIRbFNS2xeC67u/iVsm+2lmlTtT/78QwKxH0H2gmPJJkosVGd9m8tBG2nar/rL
         7aTGcdAc+Qo2yteO8f51UudAXGlO5YmQDTK2wGil/OROj3LOVpybh87Oj+P0Fh3a7E+A
         Me8AhSk8rL33R062Un7gNou6XurNPIiqer1UO1HgirB3r6OAjSWlzOTS7fIJYHWWrvDg
         uvzKXV93i/L74ycz5LW49d5A42zYDKkX90WDRuE/iahbuQnnPXrwgTNGJza2cjHDsnCU
         ucrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794374079; x=1794978879;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=00H2MiRz9p8eLUkya05BzpmKsGZ1LM4lgngi7LRL8go=;
        b=mACtFNrxfFV3QVJ2frkOhjpARyl7VHxwdWgpUFOInsX7lTC7YUYqOhRYsv50hN+Xxq
         pmk+aBi9XOjkzrmzwWSNUzCEVlO6j3JO0YRwL7sk492vQlPd3DX8gCPTl9sztjXlmJIi
         TghnXoZJDPD3a5cPZC757xJljnPg5qCzOmwtwsL/JetDlzBZ9AZY4WWd19uA2OXKrasY
         Ir6xXmza1RrQOFf52D9Hj5VZhDVNuF5lIPJ7szKiHt3qTrKzid8GRzDhKcDbqaVkX4QC
         FyM4LclTUJTlLiw+qGDEq9x4nfbD/GShESJklpy0SV1MZKB/hKjHKJbePUN63LsFtZwm
         LNUQ==
X-Gm-Message-State: APuU4Z/M/XBvUhRmACCHTHOkjGWYIZ1N0jkmixaqwt3m7zfZkajsCu2a
	urzXxQCKyTgYQ/S7T5euQi0imvLdC5aVoWazhC87vB0xGv4ZLKEV8VaWUlivAQ==
X-Gm-Gg: AYBFou37YedBXkt0vRCqExOISQZ3+dwmRHRuBKcwqOBaQZIKOB+qUakrUTDms74OcsS
	EdHauhNlEk5V4GTG0Blm3vJzivqY2X4199UQsC/khUwE1sUi6RO/hjg1Fz92yUIfPhBkI0Yphuf
	Ld0fACotZ3MejHE5vH94Pkxz1zr4+iTura102Iv/lFvPSCt1WbVz14FLtr8uyr4E0z4pzYALX3N
	6Ohq7XTMZe3FUasjYHaVVHfRD8FIzjzmhPqX7sxc0aHbszBJiaIu3glDRN7odExTwCSaG1O5kM2
	ILwfWZkV1AeIzq11ffUKv5oTQm08DxA91YVo3hFCuj5QXcW0R5Yh4UnUh2hr8mmDc6ZNeM8vfpn
	Ora2c/7ey2YA6n320SKjnCAFwTLHxW4VH8eewlGqov4as5nsVFBoN9tX7Sz/NbAbQi33bgtB7WR
	IzQGnG8whx2FBdp+9XuyC5inzu8phpruSeH+kPUwTaCoaI+MBqwjfuw3Dq0CJ1ShZlZ2GMRhehC
	jNPm6pnhVOL81wFuKuDRkoMYHGxx1HLLA5rY6aDCssqTGp8iu+T99Z9xiGCHrEOJ5uUMWRKwYoB
	VPLehoHPEhMH5M+edosJmQG2vXKCu48NGdY2h4CtJyM5AyhUfNqE+yBEdOnf46wHL8tvw6YXBO1
	x/kzJAmjdql9BrvbDsYPCvkMGvvHG6TzSZdnQ0IUAtkxdUVzeHMUgDIgJLznAymGUW6M57bSkiA
	==
X-Received: by 2002:a17:90b:57e7:b0:3b0:9781:ee8b with SMTP id 98e67ed59e1d1-3b182ebd75bmr1492179a91.26.1794374078803;
        Tue, 10 Nov 2026 21:14:38 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.249])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b17e2045ddsm2684851a91.15.2026.11.10.21.14.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 21:14:38 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next v2 09/29] bpf: Include older frames in a fill through an imprecise stack pointer
Date: Wed, 11 Nov 2026 05:13:20 +0000
Message-ID: <20261111051341.2800252-10-alexei.starovoitov@gmail.com>
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

A fix of liveness.c. This series needs it: scalar evolution keeps the
expression of a stack slot across a call unless bpf_may_write_mask() of the
call has the slot, and this is a write that the mask does not have.

	struct scope { struct scope *parent; u64 hits; };

	static __noinline int leaf(struct scope *up)
	{
		for (s = up; s && n < 8; s = s->parent, n++)
			s->hits++;
		..
	}

	static __noinline int level2(struct scope *up)
	{
		struct scope me = { .parent = up };

		return leaf(&me) + me.hits;
	}

level1() is like level2() and calls it. The program has the first scope and
calls level1(). In leaf(), frame 3, s points to frame 2, then to frame 1:
at the loop header struct arg_track is ARG_IMPRECISE with the mask
BIT(1) | BIT(2). For the load of s->parent arg_track_deref() returns the
pointer that it was given, so for liveness.c s never points to frame 0. The
scope of the program gets neither stack_use nor may_def at the call of
level1(), and the program is rejected:

  reading from stack off -16+0 size 8, slot poisoned by dead code elimination

put(cond ? out : &tmp) with out in frame 1, tmp in frame 2 and out->buf in
frame 0 has such a pointer without a loop. That program loads, but the
call in frame 0 has no may_def for buf.

A frame holds pointers to its own stack and to the stacks of its callers:
a pointer to the stack is never spilled into the frame of a caller. So what
is loaded through a pointer to one of the frames in the mask points to the
youngest of them or to an older one. fill_from_stack() does the same for
a known frame and an unknown offset: GENMASK(frame, 0).

Fixes: bf0c571f7feb ("bpf: introduce forward arg-tracking dataflow analysis")
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/liveness.c                         |  4 +-
 .../selftests/bpf/progs/verifier_live_stack.c | 60 +++++++++++++++++++
 2 files changed, 63 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/liveness.c b/kernel/bpf/liveness.c
index e930d928afa5..c52f0435193b 100644
--- a/kernel/bpf/liveness.c
+++ b/kernel/bpf/liveness.c
@@ -1398,8 +1398,10 @@ static struct arg_track arg_track_deref(struct bpf_verifier_env *env, struct bpf
 
 		return fill_from_stack(insn, at_out, reg, parent->at, parent->slots, ptr->frame);
 	}
+	/* A frame holds pointers to its own stack and to the stacks of its callers */
 	if (ptr->frame == ARG_IMPRECISE && !(ptr->mask & BIT(depth)) && ptr->mask)
-		return *ptr;
+		return (struct arg_track){ .mask = GENMASK(fls(ptr->mask) - 1, 0),
+					   .frame = ARG_IMPRECISE };
 	return (struct arg_track){ .frame = ARG_NONE };
 }
 
diff --git a/tools/testing/selftests/bpf/progs/verifier_live_stack.c b/tools/testing/selftests/bpf/progs/verifier_live_stack.c
index 32bab3cb3fcb..d6a6420d219d 100644
--- a/tools/testing/selftests/bpf/progs/verifier_live_stack.c
+++ b/tools/testing/selftests/bpf/progs/verifier_live_stack.c
@@ -3143,6 +3143,66 @@ static __used __naked void imprecise_fill_cross_frame(void)
 	: __clobber_all);
 }
 
+/*
+ * fill_older_frame_3() loads through a pointer to the stack of frame 1 or of frame 2. Both slots
+ * hold a pointer to fp-8 of frame 0: the store is a may_def of that slot at the call in frame 0.
+ */
+SEC("socket")
+__log_level(2)
+__success
+__msg("3: (85) call pc+2{{ +}}; may_def: fp0-8..-{{[0-9]+}}")
+__naked void imprecise_parent_fill_loses_older_frame(void)
+{
+	asm volatile (
+	"*(u64 *)(r10 - 8) = 0;"
+	"r1 = r10;"
+	"r1 += -8;"
+	"call fill_older_frame_1;"
+	"r0 = *(u64 *)(r10 - 8);"
+	"exit;"
+	::: __clobber_all);
+}
+
+static __used __naked void fill_older_frame_1(void)
+{
+	asm volatile (
+	"*(u64 *)(r10 - 8) = r1;"
+	"r1 = r10;"
+	"r1 += -8;"
+	"call fill_older_frame_2;"
+	"exit;"
+	::: __clobber_all);
+}
+
+static __used __naked void fill_older_frame_2(void)
+{
+	asm volatile (
+	"r2 = *(u64 *)(r1 + 0);"
+	"*(u64 *)(r10 - 8) = r2;"
+	"r2 = r10;"
+	"r2 += -8;"
+	"call fill_older_frame_3;"
+	"exit;"
+	::: __clobber_all);
+}
+
+static __used __naked void fill_older_frame_3(void)
+{
+	asm volatile (
+	"r6 = r1;"
+	"r7 = r2;"
+	"call %[bpf_get_prandom_u32];"
+	"if r0 == 0 goto +1;"
+	"r6 = r7;"
+	/* ARG_IMPRECISE{mask=BIT(1)|BIT(2)} */
+	"r1 = *(u64 *)(r6 + 0);"
+	"*(u64 *)(r1 + 0) = 7;"
+	"r0 = 0;"
+	"exit;"
+	:: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
 /* Test that spill_to_stack with multi-offset dst (sz=8) joins instead
  * of overwriting. r1 has offsets [-8, -16]. Both slots hold FP-derived
  * pointers. Writing through r1 should join *val with existing values,
-- 
2.55.0

