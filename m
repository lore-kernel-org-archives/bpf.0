Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795376607;
	b=0UBAkySq0GRkO15N/OPP6hOUfsfENTQl6xl4BfIam8R67cQmpBzEq8XhN0dsAdTh/5XI
	 wzc5nzfqvYS1PIvQ3m6u4rnuIJGja2FZzSXEBynvXZol4X0cuiVYkNVUeSBJz2an6bB5N
	 HdBorUYqkyJtOEMf08597O6HcBsqnH5i0CzNqwWPsTFZojHclLBo4XpfmvmHFiiGJIIoh
	 q1H8zMfWp6FebTycOE+2cIMnZ/q3CqFHLhRQXqdmGbZEoCvILVsSzyVK5Xs5E40J3pwGm
	 R/DXRBeI3Gylev3vjZ+bHeIvj6Cp6X7fBr+nA3jagDUbhBmcQBderC4/rGIIidsTnSw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795376607;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=SacHS26F4wxER6qI4ojBTAAYYFLzdB/Bos5NQBqEPVo=;
	b=DaeE5b/u3QOkNzWaNvfp/ZEk9CE6j+Ponm5h8w+d5kkENLgWMs1l4EIrOpL8KpMh/tSu
	 RQdzWRFrcw6zDA9csn9glHnDQKMSIPb432s2d0kxy49IcwuyT2w2qZR4reJgkSjP7gFcr
	 ZIV7jlc40SlDAxn54X2Ja/OmlHohn3ks4SqXSvlqWH8neiM+0PF1I2ilQoLUNjRf2p5By
	 jlHQJmNo1r0mCB825XQJU+LP6UfaMUf4Pnn8JOo53jeZGcBXVSjSk6DvIFnH6zwLbCgWN
	 He/wOwOXhfMoOLh1wiqTHGHQMAAfWDXD7ijX524r7SEVci4d5pMwu4BJmbPmlAyQTIA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=lukasstockner.de;
	spf=pass smtp.mailfrom=lukasstockner.de;
	dkim=pass header.d=lukasstockner-de.20260707.gappssmtp.com header.i=@lukasstockner-de.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=bL9mmmLE;
	arc=none smtp.remote-ip=209.85.128.41
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61A9A606A31A
	for <bpf@vger.kernel.org>; Sun, 22 Nov 2026 19:43:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 61A9A606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lukasstockner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lukasstockner.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lukasstockner-de.20260707.gappssmtp.com header.i=@lukasstockner-de.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=bL9mmmLE
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4ac95761c85so19132775e9.2
        for <bpf@vger.kernel.org>; Sun, 22 Nov 2026 11:43:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lukasstockner-de.20260707.gappssmtp.com; s=20260707; t=1795376606; x=1795981406; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SacHS26F4wxER6qI4ojBTAAYYFLzdB/Bos5NQBqEPVo=;
        b=bL9mmmLEihbEIIB3vU84AxI0a4I0k1uHKc9wG2v4PxQcYjU0AvrS1iIQtLFPZ6GnXy
         BpggiqJx8aVrCabzThfnP62oKTd5dMQovc6rf1PsNhmFkBcK4QIuA7lim9ygunFOdkAo
         02MS69daynKEaZxrd2vX27XarXMD/Rzw51yNMcR48JbmNwuKx2DHZxeyH3hJHI8nV6xv
         rzE7bLn3WRoa7xsmUOfN3ZE1eznKfvfmY9YVfZq+1kfGrt9DTtyPUxJgE0CrL2keTlW0
         Up+h49KGVBVomr40vgtmrJgZC+K1VtLJYMxUf/p+KfPS6PS4UEu5nEPZgk81OCAArhEn
         1uhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795376606; x=1795981406;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=SacHS26F4wxER6qI4ojBTAAYYFLzdB/Bos5NQBqEPVo=;
        b=Cl3ig6ouebblnP7eDKcODREmJpZNx7toEPYTnPuWMAbKNHZFOQ9niWyIO9sm17ksxA
         tp7mSHhUF4h4DhsloFtINzk8GHeU3QSlfe13bUArYzG/mM0BD6D6AUdwZwqd+P+o79Oj
         3puApl/x1i2h1WjW5H7joYQjMd/P9+Lca1dChX+xd5hTWMhAWwO6j/9zhKjdY4K0iizk
         eVhfGrBjNQ1mDAnMvXmPKfWm0zwpwsSBC/mGSfpVTosMS2U6TvV5bfJWk7H2yWJaJ5tu
         RuH5jTk0VejtLfIbiV6x2058uOze/nAN5X7MlEhMPo34Ky+Tz4vZsWrd9lIJXhAr0aYQ
         3D5Q==
X-Forwarded-Encrypted: i=1; AL+hErEHADTNBgKNgoQH5RzJYX4q/+7AWBTcB8tAh0Hg/3InV1krL6QHa9ol2VClXEMVdoS3JVE=@vger.kernel.org
X-Gm-Message-State: APuU4Z+T6llq4ApSBlJOsdREyk9LKtOiiEFU3wSWohoWag/naztm9Mi2
	2yO1nWpsmjBF3BeRI3Us92RYza2uKxNKHQ5LIo4D8pEt25m5O+moVy9jgl+5czjHYlY=
X-Gm-Gg: AZFdTZcY1WbLKQsdWpa00/jrdgXbstlvk46lB9DG9cWki8iZJ8ie5bxhOppEVJ6gjHk
	EEoRzXpow4715xBri+6Xlvj1W2TC+zPKJeEaK8a07o5zbQHbjojBIHF5MjNaRBsW30ziHQIKxdS
	SSLF7WwK/GgYSBt/I148DhDOG/AnDTS/K2TEBBWickfWR46QvwW5mrMl2ge+m5I5ZFtid3b6uz3
	lPS0HDdWVkn1uQk6uTuQKgp0vPUPX/9pAn5o6w+bOt2C81mHIcstPim8FWNUH8VMGolKluABFE7
	PcICFHaaBccG+QJZVC74pGNhaw48gS8hvDCpu+JV5scWNex8l1CGKuXuymdyJq2LfAOycYH5LCm
	896qFyqGBqGQwmT/u4cJGPvGmASX/mGufBZwUJFCqc/7Ceou5nMV4xttOaJhABeulbMqmyvBMEX
	TxAY1ozM62NHZW+sv2LWOvHhQ/0oM+0iWBF+PnbLVikGM2D94coI2ZHg8+glfZzpJZ4yd6w/wzb
	w83xuZy4N309jBd+n5lHdOJuybVyZpR0hP4QBlmTfLUnYyYdg4WhDNdzqT/ZS5QRr8d0Fvqb3KW
	9XiKVVHPYfKhH8cri9vITY98ukY6EWllDsU3fKFmAe+cNdzyoddKEijqkz18TfTmg0D0DT2PpZt
	B
X-Received: by 2002:a05:600c:820d:b0:4a1:dfaf:f465 with SMTP id 5b1f17b1804b1-4bb887c2ca3mr208489695e9.4.1795376605748;
        Sun, 22 Nov 2026 11:43:25 -0800 (PST)
Received: from lukas-laptop (195-200-20-154.mclarenap.oninferno.net. [195.200.20.154])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb88442995sm293917125e9.2.2026.11.22.11.43.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2026 11:43:25 -0800 (PST)
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
Subject: [PATCH 3/4] powerpc32/bpf: mark all argument registers seen in function calls
Date: Sun, 22 Nov 2026 20:42:04 +0100
Message-ID: <20261122194205.218543-4-lukas@lukasstockner.de>
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

The JIT code tracks which registers are used and remaps based on that,
but currently does not account for the fact that function calls implicitly
use registers because the called function will treat them as arguments.

Therefore, if a function merely passes through one of its arguments
to another function call, it will incorrectly be considered unused and may
be overwritten with another register's contents.

In practice, this is unlikely to affect main programs as they only get
one argument (the context, which they are very likely to touch somehow
in addition to passing it on), so they'll have to touch other registers
if they want to pass them as arguments. Subprograms, however, are much
likelier to hit this.

Similarly, tail calls pass R1 to the callee, so mark it used as well.

Fixes: 51c66ad849a7 ("powerpc/bpf: Implement extended BPF on PPC32")
Fixes: a8936569a07b ("powerpc/bpf: Always reallocate BPF_REG_5, BPF_REG_AX and TMP_REG when possible")
Signed-off-by: Lukas Stockner <lukas@lukasstockner.de>
---
 arch/powerpc/net/bpf_jit_comp32.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/net/bpf_jit_comp32.c b/arch/powerpc/net/bpf_jit_comp32.c
index 9f55dd4bdfd6..7414e350d2d4 100644
--- a/arch/powerpc/net/bpf_jit_comp32.c
+++ b/arch/powerpc/net/bpf_jit_comp32.c
@@ -339,7 +339,7 @@ int bpf_jit_build_body(struct bpf_prog *fp, u32 *image, u32 *fimage, struct code
 {
 	const struct bpf_insn *insn = fp->insnsi;
 	int flen = fp->len;
-	int i, ret;
+	int i, ret, max_arg;
 
 	/* Start of epilogue code - will only be valid 2nd pass onwards */
 	u32 exit_addr = addrs[flen];
@@ -1183,6 +1183,18 @@ int bpf_jit_build_body(struct bpf_prog *fp, u32 *image, u32 *fimage, struct code
 			if (ret < 0)
 				return ret;
 
+			/*
+			 * We don't know which arguments the called function will use,
+			 * so if this is a subprogram, assume the worst case where it
+			 * uses all of them. Regular programs only get one argument,
+			 * so any others would have been explicitly set.
+			 */
+			max_arg = ctx->is_subprog ? BPF_REG_5 : BPF_REG_1;
+			for (int reg = BPF_REG_1; reg <= max_arg; ++reg) {
+				bpf_set_seen_register(ctx, bpf_to_ppc(reg) - 1);
+				bpf_set_seen_register(ctx, bpf_to_ppc(reg));
+			}
+
 			if (bpf_is_seen_register(ctx, bpf_to_ppc(BPF_REG_5))) {
 				EMIT(PPC_RAW_STW(bpf_to_ppc(BPF_REG_5) - 1, _R1, 8));
 				EMIT(PPC_RAW_STW(bpf_to_ppc(BPF_REG_5), _R1, 12));
@@ -1412,6 +1424,9 @@ int bpf_jit_build_body(struct bpf_prog *fp, u32 *image, u32 *fimage, struct code
 		 * Tail call
 		 */
 		case BPF_JMP | BPF_TAIL_CALL:
+			bpf_set_seen_register(ctx, bpf_to_ppc(BPF_REG_1) - 1);
+			bpf_set_seen_register(ctx, bpf_to_ppc(BPF_REG_1));
+
 			ctx->seen |= SEEN_TAILCALL;
 			ret = bpf_jit_emit_tail_call(image, ctx, addrs[i + 1]);
 			if (ret < 0)
-- 
2.56.0

