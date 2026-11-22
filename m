Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795376589;
	b=NIa31ejsqYsAtQdfuWzfoatzSryVSDXA5hSqgi75KgnahdJm8mYVHHmt8KjQVv1XwOy9
	 ihtm0l72Uz+d+qXPmgX7PvrdlMMbMXry9kvJeu+Ulchm/Tx8lYSmK0R2kQsXK5HGsSgi/
	 1/9l+YnBsncm5u67ODyjJUoPx4Z87raJFhi9HmOvhiXDCSqhGnMINuvXJn0t+ir6R86M/
	 QIHTTaPBk8JOK+tEhcbCRgVfkBNdSg7tF28LOh5gL47NGicwSgWd7oa8mPJT/mVD1DclF
	 LEeZXE+P3QJcTySF/2VZlTyaVoIE4zIwaeWefIwBySTUr1Jh54M5bUH+LvpvVepkN+w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795376589;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=3Rts9xMlV/I79tsAmx/LYiDpXcrHBQz49ckYW4v4Vs8=;
	b=HOJUnyXsqKdETXVfv9xtotuJjIvfK5BgF05SOU/IMWrcJp37iwgLayJCsKO3v7vL4Hoo
	 yu8XX6LOQDoh/1LGbwPB+T28DfiQpo1fFiBLAE6lfenY5pTl1e4VODwJAJqgYtmoiu8Oy
	 IGxnSdY9NPwJ25vGo3AqyVsAZ33toQEcmrNkz/j2/ANXppRnxZvOtYtIigIcS/J0B+tlN
	 R/N1/HSKobUrhN9cviHGg4PJ8Rm01W/VR1gEUQXZxC7buKlKMakbiR4xzQZNgEbp+owtK
	 KxfT01ysuWiTd9fGZA15LUSeAVGrrUndJ3PWTNpA3pI08ZTtszJHttC0UkGpqRK2U5w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=lukasstockner.de;
	spf=pass smtp.mailfrom=lukasstockner.de;
	dkim=pass header.d=lukasstockner-de.20260707.gappssmtp.com header.i=@lukasstockner-de.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=qBGZ7cH+;
	arc=none smtp.remote-ip=209.85.128.48
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14C3E606A31A
	for <bpf@vger.kernel.org>; Sun, 22 Nov 2026 19:43:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 14C3E606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lukasstockner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lukasstockner.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lukasstockner-de.20260707.gappssmtp.com header.i=@lukasstockner-de.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=qBGZ7cH+
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-49d05d51553so17688855e9.2
        for <bpf@vger.kernel.org>; Sun, 22 Nov 2026 11:43:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lukasstockner-de.20260707.gappssmtp.com; s=20260707; t=1795376587; x=1795981387; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3Rts9xMlV/I79tsAmx/LYiDpXcrHBQz49ckYW4v4Vs8=;
        b=qBGZ7cH+raT/AcIdvuR/kZmGyauYx0tnWjT0Z++zaDGYG31h8irFGjUrPHYQdB2fgF
         T63eMPqP18+NxIW3juEYNE6PRT0rk18OSYDTKgVGGB9nRii+aCOy5q5TqHWVxYBWnJgT
         kuV1obmEuqciBnj33WSYsyw9O2zifs48bG+9/z0kww/fufD3bOXXUYTyWgeBh7g5A3Js
         kCyeKo8leVRK89sGLNg+onha5gZ661d+FiMRRX5wuWECOLZ7ZNa+6lp46Q7VyPcZ45Lh
         FPr1XiI4jlCr43oEi9HL7KyMjtW8FVLRF0MThhFNmxO7B16XvuqK2LT1LZDVtTXidATe
         mi9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795376587; x=1795981387;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=3Rts9xMlV/I79tsAmx/LYiDpXcrHBQz49ckYW4v4Vs8=;
        b=Sm06AtMAH9SDOaVcvP0KymOqXc6VMikIMf9aWSps1vkwjc6ebH3LAnsJN/oIOmI7Y6
         tM77akP49WqsMzr8zHdWAwk643zAJzk97IYurRaKha7gtQa420sbJLKpdo/pkzfl+4PF
         rA4zJ6Xmq7+jKkgYkNgvcG3LyC82e2MNC9koQi+ofnIb6TIfrsVZ21W8jEEaQqhQEzdm
         DhVY7fzMU44h0gx80IqWXt3sjjY8oyHRSBEZtM8i0VJ9nCtZqv94B6usLk+qpqrGFRBJ
         LtOlctKu1p/iJhuPO4mgKFJiAqd4v6eXUu+UkSlnMcxJdiycR++3lkxtb7W3QlSiNWVK
         7N5g==
X-Forwarded-Encrypted: i=1; AL+hErHOI+Bjbr7hhKC1kCGNhURHH/6F6WQsDi6HBpYiSWBSek3f9In6bKsewrxMN7N+J9Wm7jw=@vger.kernel.org
X-Gm-Message-State: APuU4Z8e6aYyCdSIOkzHNOrIjnAm9yzC6w/1CniPPgtH3yKQ+/IZhKpR
	zt/dpthnzD9Y3t+RHcAU0tSuWwmYIcTd//NImCeAaAi5AymsCIiY8cUKISLWtSN/U4A=
X-Gm-Gg: AZFdTZc3Sn55+utl1rqtV5e9T0clj5hypoOk3hj3c39nFRVDT/I7HEZJdwy8nnaaC1q
	8a7jdvDwp1dmd0jqpdyuS+PrR5XL+rlXjWjGtAzg+X9BMBlgOnLuzQPhRg6p1DbfRZnGWN+J0iA
	Nqqaq84YGF8T8eAih3B1d0KdS/rhDoO4UiYV4oSdrHa+6i7sShsnx1rfOYSKwwxQzGni5mL9tFm
	vmnW8EFZOLwtKsS4eKqoZ/F9p+Re+CmxzF2lFQ53fLoKqpxOZxrlGk3FUmHEDKdmyr3+Nj0Oa0+
	0+fhe6THnBRFs1bRWxalDPICAu3sq4n/J2ELB5+OCEtTKCmE0fi4CtCzmVP2MEC3QTN5HqzlfXO
	Pq7MqtJ8nOpSLLu4th/EjSDHzLRg+sdfjFLs+0oXgojqN1YZnJD1sHxkvasUeg5GLQp9erZQeUH
	/1x0mWwULD/vW29nsufUufG0vfx+7zVmLDM85q4GidnBSAYCf8K4CKlqdG/ZeUGHpTrQuw34+UM
	9qnciq8t0KxAsocOYL9zShl0VDfGR4zkgzncSnEP/i/7/qJhV5kdMZGJ/HEIRRkL+bNDGC1SoJH
	P3CPhT9a3DSCWTvFuMWbZQhxXRjAr8t0V+k6JvNqjMIBix4MvrtYf2xBGZT2ZBTKO/qIDO29KUy
	3
X-Received: by 2002:a05:600c:a085:b0:4a2:526b:d410 with SMTP id 5b1f17b1804b1-4bb8881092bmr210336715e9.13.1795376587215;
        Sun, 22 Nov 2026 11:43:07 -0800 (PST)
Received: from lukas-laptop (195-200-20-154.mclarenap.oninferno.net. [195.200.20.154])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb88442995sm293917125e9.2.2026.11.22.11.42.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2026 11:43:06 -0800 (PST)
From: Lukas Stockner <lukas@lukasstockner.de>
To: Hari Bathini <hbathini@linux.ibm.com>,
	Christophe Leroy <chleroy@kernel.org>,
	bpf@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Cc: Naveen N Rao <naveen@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Lukas Stockner <lukas@lukasstockner.de>
Subject: [PATCH 1/4] powerpc32/bpf: fix argument passing for subprograms
Date: Sun, 22 Nov 2026 20:42:02 +0100
Message-ID: <20261122194205.218543-2-lukas@lukasstockner.de>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261122194205.218543-1-lukas@lukasstockner.de>
References: <20261122194205.218543-1-lukas@lukasstockner.de>
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

Main programs receive a single 32-bit pointer as the first argument,
so the current prologue converts it to the 64-bit BPF_REG_1 by moving
R3 to R4 and zeroing R3.

However, subprograms are called like helper functions, so there the first
argument already is 64-bit - but the prologue still does its conversion,
so the argument ends up with its halves swapped and the upper one zeroed.
The same problem applies to the return value.

In particular, in the common case where the first argument is a context
pointer, the callee ends up with the upper (zeroed) 32 bits, which then
triggers a kernel panic as soon as it's used.

Therefore, make JIT emit the appropriate 64-bit prologue/epilogue for
subprograms.

Fixes: 51c66ad849a7 ("powerpc/bpf: Implement extended BPF on PPC32")
Signed-off-by: Lukas Stockner <lukas@lukasstockner.de>
---
 arch/powerpc/net/bpf_jit_comp32.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/net/bpf_jit_comp32.c b/arch/powerpc/net/bpf_jit_comp32.c
index f5b9441cf46a..261ac0646b96 100644
--- a/arch/powerpc/net/bpf_jit_comp32.c
+++ b/arch/powerpc/net/bpf_jit_comp32.c
@@ -179,9 +179,11 @@ void bpf_jit_build_prologue(u32 *image, struct codegen_context *ctx)
 	if (ctx->seen & SEEN_TAILCALL)
 		EMIT(PPC_RAW_STW(_R4, _R1, bpf_jit_stack_offsetof(ctx, BPF_PPC_TC)));
 
-	/* First arg comes in as a 32 bits pointer. */
-	EMIT(PPC_RAW_MR(bpf_to_ppc(BPF_REG_1), _R3));
-	EMIT(PPC_RAW_LI(bpf_to_ppc(BPF_REG_1) - 1, 0));
+	/* Programs receive the first arg as a 32 bits pointer, subprograms don't. */
+	if (!ctx->is_subprog) {
+		EMIT(PPC_RAW_MR(bpf_to_ppc(BPF_REG_1), _R3));
+		EMIT(PPC_RAW_LI(bpf_to_ppc(BPF_REG_1) - 1, 0));
+	}
 
 	/*
 	 * We need a stack frame, but we don't necessarily need to
@@ -231,7 +233,13 @@ static void bpf_jit_emit_common_epilogue(u32 *image, struct codegen_context *ctx
 
 void bpf_jit_build_epilogue(u32 *image, u32 *fimage, struct codegen_context *ctx)
 {
-	EMIT(PPC_RAW_MR(_R3, bpf_to_ppc(BPF_REG_0)));
+	/* Programs return a 32-bit value, while subprograms return 64 bit. */
+	if (ctx->is_subprog) {
+		EMIT(PPC_RAW_MR(_R3, bpf_to_ppc(BPF_REG_0) - 1));
+		EMIT(PPC_RAW_MR(_R4, bpf_to_ppc(BPF_REG_0)));
+	} else {
+		EMIT(PPC_RAW_MR(_R3, bpf_to_ppc(BPF_REG_0)));
+	}
 
 	bpf_jit_emit_common_epilogue(image, ctx);
 
-- 
2.56.0

