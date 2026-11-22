Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795376605;
	b=yn0wxE9g8pYhvgdWTngUNdgKLuTSQ9aBRZcpqIjy5VB1seD5c08BaATq4wh4uXq675LD
	 4ibpBIgXUUki+YyAjAHTk4dH5LMj8ITQgVlwScqgOpzb8DrypghibXVSUntrfG2Nz3iuT
	 X6QA2aLu2R23rAWVtmPoPloHTcvB307CAbpmoCq2BBUbzgb6sV1yQX7Yb89rnfXNYCI4L
	 MDZaslKwBFdH/FLlMX5ZgW0qzFYfCZfr54KB6mrQmesb63IwnGCrH50T2xN1imT7FptDQ
	 NAurwbb00pGuMGiFuPpKpA1YeeOdb8Iz2bFbclVAhQu/xeJyBScdgFAiyWAA83Fp15Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795376605;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=G+WV6WweTrvYpw8ZO0v54L+LwjPDZMRYJnrkI0b2uK4=;
	b=TMe1lXPf1niY99pVSxPtdryxvd0aF/3BR0GSc3BGAnJLCjRevf2xtfRwqfX/Qn4kIK0o
	 y6+7417LjahcjZelriNmTSlB4Mjok4zrG4O7FHxovL4kA33SkPZq+TBqVbRysKta71kjy
	 tyhjzkasSX83HXKNtqpthRmw5YQ97sXmS0I+K4R2we++/sKXRs5w2+SotJgQGhncgCd4R
	 GLHoJUiMp0dZgeF/lTo/By8faEtmolwbK25XNaZwtM3zOLUX+JKr4jBvdNZoNgSeOYkPx
	 uM8uuiAjeQhPiv9oShUeMws/IbkK5t/a93hRNtXcfaaQ3ZiB0KZjN74/rHFyUBYpkWw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=lukasstockner.de;
	spf=pass smtp.mailfrom=lukasstockner.de;
	dkim=pass header.d=lukasstockner-de.20260707.gappssmtp.com header.i=@lukasstockner-de.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=L2lcPlf8;
	arc=none smtp.remote-ip=209.85.128.44
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E9E0606A31A
	for <bpf@vger.kernel.org>; Sun, 22 Nov 2026 19:43:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3E9E0606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lukasstockner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lukasstockner.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lukasstockner-de.20260707.gappssmtp.com header.i=@lukasstockner-de.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=L2lcPlf8
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4bb64ef5a00so19570395e9.3
        for <bpf@vger.kernel.org>; Sun, 22 Nov 2026 11:43:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lukasstockner-de.20260707.gappssmtp.com; s=20260707; t=1795376603; x=1795981403; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=G+WV6WweTrvYpw8ZO0v54L+LwjPDZMRYJnrkI0b2uK4=;
        b=L2lcPlf8FGmyPENTasMlkLKU2/4xmhn/1r0YTcRJjZwVGKTLCTDV/rFGPCvFT172TP
         1i27hO6wz5Gyoslxl6tvAhu/87zv58YZSw1UIjpcjQe80qF7SveJqUqj0gkQv0EjDv/U
         NfgVm3M588jwFbAge7LBIov/sQbea9GysUibwzJpUgfz+D/ya/fPZ1wthrXvM+/iTp31
         pyB7Y5Ab8ql8gmY7PFbTxjSwyuNtMKqbm3hOEtWH93Ans/y8Lh4ksS1Uy/r3llLW0ZNd
         EZQao6RmHbxyQtzJoqvupQVQO7J7al/ZEovDSivgLc9wu1PB5MRRQV4rIv/lY5/e1i/e
         P25Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795376603; x=1795981403;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=G+WV6WweTrvYpw8ZO0v54L+LwjPDZMRYJnrkI0b2uK4=;
        b=YBgVIgb+0PGPm5Yu8xTpEKgKFe3Q0OH9b3X17q4FJKQZHPXhXfRMK6xlvi2Q7HSAew
         qvcHtV7ofcKdQDyddg5S0D2BPDo53dD0tiBymnVki2QvpTSikZ9RhOWqA2n+qmI9qD5X
         f8MDBp72ov/JllcvDjY/Q4t32YFTkX63xYytoMI64MWOW6cByfrCWfR6B3rIClCU6pcU
         orAZsTw1k29v9jMyJzvpRxILAgFMCwXM6ntui+6g82mEmxIPVahHWw0phpsKpjgW8NAG
         LV8rbNWdwHw5C8rZHBFhIyvD8fseHs0siNoujgYcj8LR1WofebwjB+i9PqCPkvkyVAlC
         Eh3w==
X-Forwarded-Encrypted: i=1; AL+hErGGk+Ot7lJoevvka6N8+yoCXdGC5HU181uoLd3a1cLAf1HSFXKI4vR42Mqn1THWwZ0mISg=@vger.kernel.org
X-Gm-Message-State: APuU4Z/3sC65IyMzrMqQMIZkF89a1ABjgpdWetxigyh0J0xxbYauFslR
	z18SxldcuT2D8GVKgNRIYE8kXPpDtAItcdub5SbUl4ZUKNh0+CQjoaZQA6glWkRrEHo=
X-Gm-Gg: AZFdTZdjZL6PM2ALDtNApqGfL8jLBn2J9ungsawiZ+XpnZobrdxWZ67ReX74W6+matK
	LS4aM4iyeDUe/qlGAsGMXk/nBg65Ghk0KldjE3zX7J1bI7Eqp8pwklBGi6XAm9KEiP2niL6Io3e
	d9+J2wlxxkGDdhwdFhyqdhQFkPLOjEHmAZn5X1zugc//i7Z3pFGaMnxV53LaiezPTnCdGXwlutW
	Z1RPsi3jPCWLCj9pVs/gtwSKH6gnKMSb3pp2M/5aDxc/LgsDQyur4LnkwkdOLmsCET/BaL4Yh7J
	clhk8bMl91/Z37P6a9XhxreYSvfx1m9yTBy9+5cLpDOhhoX2mi7p6pSViTTxhWSIFjsZpQh3PTt
	jV6qbPVha3+Mq69lQ5MK8IlU8Ae7YhXiyCXnKODpRNNvsw68htZA1UpH0GwWjyD6mYFh036yt7R
	vL30iDXCCeR14C+lENi4s+dAPH44Zsy4hBsVx3Dw0/2weMXCZICQiMLPX+XgH2pehYIJfS8DsKU
	/ODbvPGS8QcVGQtQ/klej8E/q8xYSp6Jgleq5KCDjJFEnwzAg9hzWURapusGixH+EJngUMMYIe9
	Io6Y4h7CwtEsZuOrSP0JS4TYLwmkyR4DFWpsXmk39zwghIjseJmCWcShSXUnmvtLE7AziXxGbPh
	2
X-Received: by 2002:a05:600d:6507:20b0:4bb:8d13:19c0 with SMTP id 5b1f17b1804b1-4bb8d131af9mr101596545e9.26.1795376603631;
        Sun, 22 Nov 2026 11:43:23 -0800 (PST)
Received: from lukas-laptop (195-200-20-154.mclarenap.oninferno.net. [195.200.20.154])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb88442995sm293917125e9.2.2026.11.22.11.43.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2026 11:43:23 -0800 (PST)
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
Subject: [PATCH 2/4] powerpc32/bpf: fetch fifth argument in BPF subprograms
Date: Sun, 22 Nov 2026 20:42:03 +0100
Message-ID: <20261122194205.218543-3-lukas@lukasstockner.de>
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

Commit 7dd0e2848764 ("powerpc/bpf/32: BPF prog is never called with more
than one arg") removed the BPF_REG_5 load since it's not used for program
arguments, but that is only true for regular programs - subprograms may
get up to five arguments, so the load is required there.

Fixes: 7dd0e2848764 ("powerpc/bpf/32: BPF prog is never called with more than one arg")
Signed-off-by: Lukas Stockner <lukas@lukasstockner.de>
---
 arch/powerpc/net/bpf_jit_comp32.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/powerpc/net/bpf_jit_comp32.c b/arch/powerpc/net/bpf_jit_comp32.c
index 261ac0646b96..9f55dd4bdfd6 100644
--- a/arch/powerpc/net/bpf_jit_comp32.c
+++ b/arch/powerpc/net/bpf_jit_comp32.c
@@ -199,6 +199,13 @@ void bpf_jit_build_prologue(u32 *image, struct codegen_context *ctx)
 		if (bpf_is_seen_register(ctx, i))
 			EMIT(PPC_RAW_STW(i, _R1, bpf_jit_stack_offsetof(ctx, i)));
 
+	/* If this is a subprogram, load fifth argument from the stack */
+	if (ctx->is_subprog && bpf_is_seen_register(ctx, bpf_to_ppc(BPF_REG_5))) {
+		int offset = bpf_has_stack_frame(ctx) ? BPF_PPC_STACKFRAME(ctx) : 0;
+		EMIT(PPC_RAW_LWZ(bpf_to_ppc(BPF_REG_5) - 1, _R1, offset + 8));
+		EMIT(PPC_RAW_LWZ(bpf_to_ppc(BPF_REG_5), _R1, offset + 12));
+	}
+
 	/* Setup frame pointer to point to the bpf stack area */
 	if (bpf_is_seen_register(ctx, bpf_to_ppc(BPF_REG_FP))) {
 		EMIT(PPC_RAW_LI(bpf_to_ppc(BPF_REG_FP) - 1, 0));
-- 
2.56.0

