Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794605059;
	b=JktrUBsagv209l7BsTPa2h7WsXt2DbxaEyY/hOBfzED+RDJpsgJStIDhbtZLOw+Hp+j0
	 ptdqLVApzWlo+molfgq+/EDJcXBqgRndPen2nR0pvGcp1vaD0vcP9FBGCuLsaYaLS54qf
	 415xYOeAsspwVPV83HGGGcI2gJuWW/tB40bpv0OJRI63Kbykss8U4YqVHqD47CTiaARPR
	 sENIIPEYOEgvQIJJOmhuTBgznMJaZwxa0LTVNxhYsGXoOrVxmKrwntQMI9x9Ymgj8RpF+
	 aUxLHjnSAaeOzHE57kbW3zIJAT7146thrufPi8Og8KlRAT1YIzmejXCPJFJezK1SPtQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794605059;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=jAiN1wsoSl5iEsunvD1hICWAFwkCWgqT3J/Jr+Riq9M=;
	b=VNxcpfOS5hCAsZONXcgbxqA5d7SIowrQUfFVWTpJaRAD804NVCOUDRPdx0+HIpbx+jRN
	 bVRoJG6u54VXxtGAht1CodHv7XMWGSqjxej9gFReIBD0Pw73hl9YjcD2aOjCISGVkzP2Y
	 xpa+5YoZifIpJ1woJ2xbtBZgU2X7bfo7gEk7Hf+5AYupoNGBklXRjCymrxPKkN5AQz8da
	 x4GC3K29ZlaS/cCY+UxNoWsa4yiRHoDzAxpDdycNstcnHt/J2Z923hPGk2DkZc7nv6ffU
	 1rqux00n+WZwJgBCwh+bWhYH6rKVHsFbRojcTqjrEdLJWHMDF35v90KODrrKDyX269g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DqgpZ+Vg;
	arc=none smtp.remote-ip=209.85.128.170
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37F93606A330
	for <bpf@vger.kernel.org>; Fri, 13 Nov 2026 21:24:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 37F93606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DqgpZ+Vg
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-8b305d38bafso12493157b3.3
        for <bpf@vger.kernel.org>; Fri, 13 Nov 2026 13:24:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794605055; x=1795209855; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jAiN1wsoSl5iEsunvD1hICWAFwkCWgqT3J/Jr+Riq9M=;
        b=DqgpZ+VghOv6kiKlYlBTomZzfu+hcG4BBrcq+hovu8GS1vBD3yjqxcs/91Mc8EiYut
         2myKqC1quAOzq43Y+sDNwh/fwLkCPXw+Sww2BiGA8npqcphk5YXIEKODAqa8Jv9Mst1D
         MK88pNxeAMNkZfU4Xvv0jU0qvW9plGeWVVv14SmK0gDFwtQKtUk1LBVzupOAYBOjexw0
         a+6U8nkbJ05qH2J2fzGT/qcRtTx7P5b8bcr3bdeHJk2kJjwCghYqnwjBKh4gFiCgO7SX
         ahR2txV/ZpVc3VVkEXLD3nAtC+9eNZgClLtGmTXBuij0JPH+qfJP6Wbw3MYQF2mq1MAX
         fUBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794605055; x=1795209855;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jAiN1wsoSl5iEsunvD1hICWAFwkCWgqT3J/Jr+Riq9M=;
        b=k6U4OgivOHnDFGMT4zjRMKaofE6/xSNq5W1q283mDYq3M//+O1ru3Lu6X4kltaQDC2
         O9e7zNLIyqGmmGkuKmms17SGW/RnXUTYFQaob4CG2Xd5BUJ5rFk1px+QOiwF1Qeke8QC
         bD9ynG5jTW4sXaf7Y1Vx6mmY5Pn8ZroRaVzFAHJ55O7xpNmcnuNso8KsE2pWU9Xwqstj
         dkt9TktDD+0FHTV8JVRdjJAwr3fw9C2xr8hrSenzIA4Rw+oiSufRdVgaHsDYtG1kocBm
         2ppk5zhpZa9D3xABlFY/5tnk9R24In2vrqkaCB59CMnS5gax2tZNoqP1kyRW3isCaUku
         FpxA==
X-Forwarded-Encrypted: i=1; AL+hErGTwg43ndAK6+lvWg7LeVeyqKLmMGzSBPR5G1MEnR48e6/ziLNTXahJAo3qPmegLG9C0ew=@vger.kernel.org
X-Gm-Message-State: APuU4Z8o8TTk1SvfO0X7mQg/EYuhp7K15RV35XPsrhjH96WSYVl1C+f3
	8rXwSXC2NLl2kTVcfxQJrYyWw+aMs72jmh672tCtxdAg/jaMZgSwcC+I
X-Gm-Gg: AYBFou1kH89kenKddF4uk1lFqQ1upgDILP9D/91RWK13EftMKmsx6YdO5p7GUth6LEk
	QCWpaUm2XQziSDBRP09SeBuF5NlNXQix44AbNQwEuaxMNNHvO1fyTAwn8zuzTJsHIBVy6pKlQdK
	vgkc1oKK+F4FEcArUllNeepUjcWM1q0VOkALAgoorGdPfnerWzzqEI8eSFcizJ+YU3vyemXbqy6
	pfcFuMWTJNUJp0clOPPa521+KoV0/en2clptob+p0DbzoRa+tUZQ1djw/UxRrXqbUqKUoty7gQB
	Uypp9MiBzXIwt1I++AhzwWpJWODpz7XKdxnBUxxiSHvb3MZQXGs2rMoeFuJfBDWnNBxRsKvARL8
	DMwibmYNAcpKnE25cNf12tNsZVtnwnt6YQDIV+ayILQdmS+JDl4ACjJ8UxDsO6u2mFZxme/nYde
	P2oF46EPEY8afO9prNjLch/ChT/Jr12pkadMYWJ7Bbs9eg/4kKbshHOpiH87SCGtkUlEp8RBMeo
	kmH1DOt8M+pf5TivxMxAizl09HLozmZYzZRYmT9VW6FLme57BbquHSj+b0rODXXBKAs5Lge/S7N
	Eo12yVJ+UIg5E5sPxqc6S6UXzI9vJ8lY4Q==
X-Received: by 2002:a05:690c:c6c3:b0:890:c0ab:2303 with SMTP id 00721157ae682-8b4aa2331f1mr19962947b3.21.1794605055316;
        Fri, 13 Nov 2026 13:24:15 -0800 (PST)
Received: from [127.0.1.1] ([187.15.141.223])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b4aaa1361fsm29539357b3.43.2026.11.13.13.24.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 13:24:14 -0800 (PST)
From: Nicholas Dudar <main.kalliope@gmail.com>
Date: Fri, 13 Nov 2026 16:24:10 -0500
Subject: [PATCH bpf-next 1/2] bpf, parisc: Add support for BPF_MOVSX in the
 parisc64 JIT
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261113-parisc_bpf_jit_movsx_20261112-v1-1-7ecc33cdf1b2@gmail.com>
References: <20261113-parisc_bpf_jit_movsx_20261112-v1-0-7ecc33cdf1b2@gmail.com>
In-Reply-To: <20261113-parisc_bpf_jit_movsx_20261112-v1-0-7ecc33cdf1b2@gmail.com>
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Eduard Zingerman <eddyz87@gmail.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, 
 Helge Deller <deller@gmx.de>
Cc: Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
 Emil Tsalapatis <emil@etsalapatis.com>, 
 Ihor Solodrai <ihor.solodrai@linux.dev>, bpf@vger.kernel.org, 
 linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Nicholas Dudar <main.kalliope@gmail.com>
X-Mailer: b4 0.16.0

RFC9669 defines BPF_MOV | BPF_X with an offset of 8, 16 or 32 as a
sign-extending move, dst = (s8,s16,s32)src. The parisc64 JIT does not
look at the offset and emits a plain move, so r0 = (s8)r0 with 0x80
gives 128 instead of -128.

Sign-extend the low 8, 16 or 32 bits of the source with extrd,s for
ALU64, and the low 8 or 16 bits with extrw,s for ALU32. Zero-extend the
ALU32 result unless the verifier inserts the zero extension.

Under QEMU on a 64-bit kernel, with test_progs built as a static 32-bit
binary with jit_insns only:

  # ./test_progs -t jit_insns -d jit_insns/helper_calls -w 0
  [...]
  #201/33  jit_insns/movsx:OK
  [...]
  #202     jit_insns_blinded:OK
  Summary: 1/46 PASSED, 0 SKIPPED, 1/5 FAILED

Without this change jit_insns/movsx fails as well. The five failures
left fail without it too. jit_insns/helper_calls is left out because it
does not complete on the 64-bit kernel with or without this change.

Signed-off-by: Nicholas Dudar <main.kalliope@gmail.com>
---
 arch/parisc/net/bpf_jit_comp64.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/parisc/net/bpf_jit_comp64.c b/arch/parisc/net/bpf_jit_comp64.c
index c326fa737ec8..315ae2a3ead8 100644
--- a/arch/parisc/net/bpf_jit_comp64.c
+++ b/arch/parisc/net/bpf_jit_comp64.c
@@ -619,6 +619,17 @@ int bpf_jit_emit_insn(const struct bpf_insn *insn, struct hppa_jit_context *ctx,
 			emit_zext_32(rd, ctx);
 			break;
 		}
+		if (off == 8 || off == 16 || (is64 && off == 32)) {
+			/* Sign-extending mov: dst = (s8,s16,s32)src */
+			if (is64)
+				emit_hppa64_extrd(rs, 63, off, rd, true, ctx);
+			else
+				emit_hppa64_extrw(rs, 31, off, rd, true, ctx);
+
+			if (!is64 && !aux->verifier_zext)
+				emit_hppa64_zext32(rd, rd, ctx);
+			break;
+		}
 		if (!is64 && !aux->verifier_zext)
 			emit_hppa64_zext32(rs, rd, ctx);
 		else

-- 
2.53.0

