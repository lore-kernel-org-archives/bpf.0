Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795201955;
	b=DUez5h7iyThMXORaPtlmICJGcBy89ckadTZsOyllQFn8d5j6wKB1Ft4DHau5ZfnzktqN
	 Dcs4dqyunmWtaKPPpPgqeZ9toSpdP83/fAxYFH2i2ql1Lv0iiIj0uNRpOPICmWu8m96nJ
	 hai13/5qvfprFTmeIdqpnBH3n5TyVXCz/nueHUeDvUdgIE/GczMd8aRoMGA+wvriytd2p
	 fbHWl31efmd7G2gQix/sC4caSzsf9YYvtp/uoF/byIBDvkiE7hvb0yLXbUxDIFr+xb26M
	 xqR676nnOLpTv58HwdxP1jk4F9I4t65bK2MjzRA2Mk2t2tZhYUO8oUgWvsGlCNm4g5Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795201955;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:To:Cc:Subject:From:In-Reply-To:
	 References:Content-Transfer-Encoding:MIME-Version;
	bh=quIws+psUpfT5p+xm1gGt2RDyS2F35dMxJn1L0LbaMY=;
	b=uSzBgG5QegR02828fi2PBrg08KpTQcByRXlQDy7oQ5Bp3azR6s9uI+NBbuRr5gD/mxVx
	 YIu4KLCJTulYm2AWpXnWtkOPNKve5BlUxBpDaj7q4umcEAavgkYjdqeqzH+AFOF2bTfA+
	 mg61In9lULMDSKFzPiULbVJi7s7C5gFIrgoKWEYh9TmI71ZlezNNCSKBtuXn8Ro4/MVZ3
	 pl+kLtp3dKuo3aAdrsV+8HvR4E3GAcbrdzBbA6Pc0+vYgXrgjEaHBCm8OLGvwqOV/mam4
	 NBmFHMdk9ixu0tTUKUchlRpGx9mn7RM7OQbbAJsMqgvn/35LocS4PJKgCBeijwMY7Rg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=chch5Rh4;
	arc=none smtp.remote-ip=209.85.214.180
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75B5760A263D
	for <bpf@vger.kernel.org>; Fri, 20 Nov 2026 19:12:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 75B5760A263D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=chch5Rh4
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2f04f61282dso3815895ad.1
        for <bpf@vger.kernel.org>; Fri, 20 Nov 2026 11:12:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795201950; x=1795806750; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:from
         :subject:cc:to:message-id:date:content-type:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=quIws+psUpfT5p+xm1gGt2RDyS2F35dMxJn1L0LbaMY=;
        b=chch5Rh4a7kUH4KADEYFCxLpq6LGSWwyRwktZS/9AKa/ysC/zzbwdvyhNG60RGwVS+
         hYgfnG30lMghWXqEF0SJqAJ2OXocm+A7LNr2YVyig6TWUO9/3ZXRexTorLyvNa5nPeTe
         yvnYr9/mwV3/57hfhvZlrDVzmDHz6mhc8eXCzsUUwsqg+PrHCr/YLHF1UJMK82OiM/mO
         j88tBzjtct8eIuXZV+0KGzx3N9xxWTNIU1Xy2Bb4HjwBGN4mgwv3AjS5yTiQwm3devma
         +zfQcKzyLqWOdwq+SRYkv+scz1h/4ySRBgrJEd8fg5F42HEhWtSSWPJRdka2gM6L7Kde
         v8Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795201950; x=1795806750;
        h=mime-version:content-transfer-encoding:references:in-reply-to:from
         :subject:cc:to:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=quIws+psUpfT5p+xm1gGt2RDyS2F35dMxJn1L0LbaMY=;
        b=Rpy02A37EUmxjG0N1v+TfyO6fZcGwA4Awo1UasTLMRkiBf6gtvpWZ1LMS6CTSbtTvI
         SlXYcHYGxwAeDYI8K8ToMbUMtrpLYSfSP7PZ4zn33Zo4mX7zCEr+sIofG3oCQozRl+mZ
         fYt0SAdjTxY+e5v7/EEw2PjekoPSjZQ0T6VFgZqfWURl10GadR9oTrYTb/P3+1CEINKN
         1Xygu9M2UeXtRWYjQ2al3Oo8Wi60U7cyGTQTWJXra3qIgx9Zbze+0ymKso895ghIipx6
         Y/2FmcNMiGsR4td+kkZ/HUKiLwtytBN92H0BGwdh5MkQLm19+tbTIy+biur4JgMKlaaw
         FI+w==
X-Forwarded-Encrypted: i=1; AL+hErH2dxoRyF8TMorAj02AL0aB8vFx9Gv0hrKa+vaKNy6yqXDtlzuSdcwQmsZVeSUHKgfJwwE=@vger.kernel.org
X-Gm-Message-State: APuU4Z8aZ0xrmc7Y0JSiNC6STrvm01x3wy29VQO9poczgeTPsChxAtud
	1dViOtJkpL7LWfSkGO/E+2dP54AC9xORAAR+vog1dZAh9kQFgijMCODU
X-Gm-Gg: AZFdTZcW4jmHoDcg1qwupQamaZz7EiuIZqm9LeI27i1er8qRyrPjnF36uS3bgig2Cch
	Wqg+IdDHvsgCvXq6EgfUskwvHE1pe0TapvdtG7QKBrN1b1m6i2RhFlekw0zYfnKLmUpn1S3W0Gi
	6QNVxWfGjgLcN59VB2OFtuRZk9TnsUnC4g0wU8KpVsQotKS5XJo9iCtOJCqdLtZ79Ms/sDfBzdh
	HUZ51A3MPu/nkNoGEV2RQLgT7Gi1KTaz2M2wXtI115elOWN22G63jtjFIoCK2pykqPRdYyUjgaC
	CikyUr4cxc4A36HLddJjX3hPbyUNay+AI36DBuTN1YjElFu6omcwLrYlQ2vH+aSbguKr1/ifs6I
	h9GytZ6Km3EEqW6J1/BB99Ea7YUcsHjNzraxxV3dMpZHZMqc7GFejYUDEp3dd6z13qcfYNTStge
	KP+weluFwKNDGFCt2vwOhhuhvy7csppYOHgiNmW1OzxwNGgv850bjyVEEVc9vaCqMrRQB8I3pkI
	HBkUCsvj7BYhPT4CN0wdQQxt34/AJ+FMFqSfKOYolji1fJkHxV3fNjlQfOEvEdciNnxMbLkJKhM
	+dA7kicl9H2RQrbFxLSQbK+vEWLame/VZWJiAgDwvdlc0RmCkAI6gH67mBEzqYsZ7o586MrNssS
	i88Mreuwv9ngcnP3/Y74wbrUvITXxOS/hT9E=
X-Received: by 2002:a17:903:41c2:b0:2ed:2b43:483c with SMTP id d9443c01a7336-2f03f1bff81mr46388825ad.38.1795201949460;
        Fri, 20 Nov 2026 11:12:29 -0800 (PST)
Received: from localhost ([153.61.198.249])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2f03f1058fesm18914595ad.48.2026.11.20.11.12.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Nov 2026 11:12:29 -0800 (PST)
Content-Type: text/plain; charset=UTF-8
Date: Fri, 20 Nov 2026 19:12:28 +0000
Message-Id: <DN09ZA2KX6CC.UVO7HNJWT0EO@gmail.com>
To: "Ramin Moussavi" <ramin.moussavi@yacoub.de>, "Russell King"
 <linux@armlinux.org.uk>, "Puranjay Mohan" <puranjay@kernel.org>
Cc: "Daniel Borkmann" <daniel@iogearbox.net>, "Andrii Nakryiko"
 <andrii@kernel.org>, <bpf@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH bpf-next v2] bpf, arm32: build constants inline instead
 of using a literal pool
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
In-Reply-To: <20261120140147.166934-1-ramin.moussavi@yacoub.de>
References: <20261111121621.665533-1-ramin.moussavi@yacoub.de> <20261120140147.166934-1-ramin.moussavi@yacoub.de>
Content-Transfer-Encoding: 8bit
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Fri, Nov 20, 2026 at 06:01 AM Ramin Moussavi <ramin.moussavi@yacoub.de> wrote:
> Commit 0b59d8806a31 ("ARM: net: delegate filter to kernel interpreter
> when imm_offset() return value can't fit into 12bits.") handles that by
> setting FLAG_IMM_OVERFLOW and dropping the whole program to the
> interpreter, and already noted that multiple pools "would better be done
> as a feature instead of fix".

Not always. imm is u16 in imm_offset():

	imm = offset - (8 + ctx->idx * 4);

	if (imm & ~0xfff) {

Take a classic filter that starts with 'div #3'.
Put 64 KB of code without hard constants after it:

  offset - (8 + ctx->idx * 4)   0x10008
  imm                           0x8, the check passes
  ldr ip, [pc, #8]              loads an insn, not jit_udiv32
  blx ip                        jumps to the value of that insn

So the patch fixes a crash too.
Pls say that in the log and add a Fixes tag for 0b59d8806a31.

> ARMv7 and later are unaffected, the MOVW/MOVT path is unchanged.

Only when the kernel is built without v6.
The v6 line wins in arch/arm/Makefile:

	cpp-$(CONFIG_CPU_32v7)		:=-D__LINUX_ARM_ARCH__=7
	cpp-$(CONFIG_CPU_32v6)		:=-D__LINUX_ARM_ARCH__=6

imx_v6_v7_defconfig and omap2plus_defconfig enable both.
With the JIT on, an i.MX6 runs the new code. Pls fix the log.

> +	for (shift = 0; shift < 32; shift += 8) {
> +		u32 part = val & (0xffU << shift);
> +
> +		if (!part)
> +			continue;
> +		if (first)
> +			emit(ARM_MOV_I(rd, imm8m(part)), ctx);
> +		else
> +			emit(ARM_ORR_I(rd, rd, imm8m(part)), ctx);
> +		first = false;
> +	}
> +	if (first)
> +		emit(ARM_MOV_I(rd, 0), ctx);

The log says that arm64 does the same. Not for small negative values.
arm64 emits one MOVN. Here they get the longest sequence.
For 'r2 += -264' val is 0xfffffef8 and ~val is 0x107, not an imm8m:

  version      insns for 0xfffffef8
  -----------  ---------------------------------
  today        ldr r8, [pc, #off]
  patch        mov, orr, orr, orr
  diff below   mvn r8, #0x7; bic r8, r8, #0x100

The last 'if (first)' is dead code.
emit_mov_i() is the only caller and imm8m(0) is 0.

Here is emit_mov_i_no8m() on top of your patch. I didn't compile it:

diff --git a/arch/arm/net/bpf_jit_32.c b/arch/arm/net/bpf_jit_32.c
index 58d066a..28a2c5e 100644
--- a/arch/arm/net/bpf_jit_32.c
+++ b/arch/arm/net/bpf_jit_32.c
@@ -411,30 +411,30 @@ static inline void emit_mov_i_no8m(const u8 rd, u32 val, struct jit_ctx *ctx)
 {
 #if __LINUX_ARM_ARCH__ < 7
 	/*
-	 * A single MVN if the inverted value is an imm8m, else one
-	 * MOV/ORR per non-zero byte -- a byte is always an imm8m.
+	 * A single MVN if the inverted value is an imm8m. Else MOV + ORR set
+	 * the bytes of val, or MVN + BIC clear the bytes of ~val.
 	 */
+	u32 op = ARM_MOV_I(rd, 0), next = ARM_ORR_I(rd, rd, 0);
 	int imm12 = imm8m(~val);
 	unsigned int shift;
-	bool first = true;
 
 	if (imm12 >= 0) {
 		emit(ARM_MVN_I(rd, imm12), ctx);
 		return;
 	}
+	if (val >= 0xffff0000) {
+		op = ARM_MVN_I(rd, 0);
+		next = ARM_BIC_I(rd, rd, 0);
+		val = ~val;
+	}
 	for (shift = 0; shift < 32; shift += 8) {
 		u32 part = val & (0xffU << shift);
 
 		if (!part)
 			continue;
-		if (first)
-			emit(ARM_MOV_I(rd, imm8m(part)), ctx);
-		else
-			emit(ARM_ORR_I(rd, rd, imm8m(part)), ctx);
-		first = false;
+		emit(op | imm8m(part), ctx);
+		op = next;
 	}
-	if (first)
-		emit(ARM_MOV_I(rd, 0), ctx);
 #else
 	emit(ARM_MOVW(rd, val & 0xffff), ctx);
 	if (val > 0xffff)

pw-bot: cr
