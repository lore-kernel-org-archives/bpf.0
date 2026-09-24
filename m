Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFEE83FF1C0
	for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 08:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790238167; cv=none; b=Mh73ghn9Aa/lISfsbJ/fTCF2LCWtXc4ily5U7RFvGVB7zFt192obLAs9xvGwa409mQhFHZFCp8ws5WebQPHIdf3iRono7hQ5cja9Fa14HwCfpC5NDTu/+JfwH1r1J8zxtMbBEv+8dxeAtMnpGh4teXujOnpP67/2VXwNjPi0ia4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790238167; c=relaxed/simple;
	bh=Dq4IZXrtgGbdE5mjpprcJEBrzgXkFHM02HzALU+oizA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u4y06Rk19ot8WlONKPumTjX0gGu+B21gccRne7uzMeHhheuLyFJLAO+rZjwJhSDIOpQiE4Ws4hVJusHS1BGumtV6pA1YrkhATefiB9lnbVZYPB9lrKg7NjXqCjRKOUvugrPEYEswyMLeWCnHNhU2cszTtHFd1VXLH22U+0qz3sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LYbApDLc; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LYbApDLc"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49e7d2bb404so6093195e9.1
        for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 01:22:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790238164; x=1790842964; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=4HHnn+wFyq/rjLJHO0qvSlndCsSVnEJyRlM3aqBNu7s=;
        b=LYbApDLc7TipElhZIyTvZbF12tRratcJ1qe3c2+ejJfNoU8Qo2VYn7F3To0BlK+RLj
         kCz4YDuNs56p0ipBTYqgePtlANaYyMdolI2qdedDVQrQZdInPm7bxWlN8Ypms+Bgo/SD
         zHd7kDHuTb7bz60dTCNUrDuQLfkkPPSpIY1zQgFZvXWqHm74cw5kh39IlcqjctUJwzI8
         1NYeO6H/G5xf7KsLugg5/F0ZPmgG39Q5hZTkG8QfVKVKU1XEKnatavf7Xz/nvYR9qVQv
         ylplRPNeE+La0KWTLhw5hYrvFFN7Dy1wW40l9aiBDTYtc8Otqc2zstK1JILpKRKqV5Yi
         EQ9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790238164; x=1790842964;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4HHnn+wFyq/rjLJHO0qvSlndCsSVnEJyRlM3aqBNu7s=;
        b=BAc5j5cLfH03lhtuYTbWd+Y11Tl3peZwVnhzKC/g8t8gZfbJhI8Dwxku2s7bpz76YG
         QppO/WVo/C1j91WT8uEQMAD1eVf0nEvzZ9zmgS4kTtwkQwDIQT6qxJwIml3Wv5a1V24G
         P8dbGs2XZi5HtUqyywGVI3auvVF0C0DNdBif5izNOmwJsQiJjCR8UALgyNwNPAOomGGb
         k4n/EsC3xcUkeA+bwS/aC3rNEHIZNGZPttfpqWMLbSrvpu3z0LRroMjYSc20rm6inwja
         /y1aXUWbNCPYoq/ydyXIL44kqcnGAq8/Rx3rdovkZdHodjnBjC7dPbjK9TTgfuZ82sYP
         Q2Lw==
X-Forwarded-Encrypted: i=1; AKwUvBxznUIvEpQx5uPd//r1XolQ4mQP1TX04CzAAG1L4Rnb9qlZ5GYvsOI95zU8dALVMKx/tQI=@vger.kernel.org
X-Gm-Message-State: AFuF++knAnFA7M65yAxeWrepEosboh460swsgS5mkfpTFvwrwYQc7paJ
	mlstUhdKLaBaIkYuTFxMaOrydwarRBozXVAKbkSK3qGinBW/6dmrOCit
X-Gm-Gg: AYBFou2nqMEl9EVqd05l/GAx47TPM5FWGLxqqFEXTGDZXPkEtE2MGV++J0+R1UW1S0B
	Ko1ZHULoVg75a/QEXsneDMe1AZ/iSHq0WKJA2nOfeMdLMb1sAOune/5T3TzgNT/49s1+6X2ty8g
	+nTM0TTDPXHyt/q5aMb7kqdDXi+yW3SJhRJlTbfWg+tZnGuVixqEaR4fIPYzQVvQyBG3o4UN5nN
	xAUwVdP8EFH0WM2URRFPTPPTr6wwNR7pGeq31hMy9FPwLrK8HHX4zOkFXv4dENf8eSL24EilTH3
	o+EnFAskdNx1gFpG+JnpWVlgro8SKxT57ZG7D5LnCAdqfLCw3eWzzNW7hxPsxeXE7PsGbN+WJZc
	/kFdrvQzYn6hRBkZ0slH4anOwOzfsqW3WxN1wAF4T2NqE2Du9ArBDI7MpPsmIC/ZWDLArVHmCZr
	J0axSZB1DObWcw4N0nFTiSUxW57btvIBxtJILYY63WI6QFEQf9t2NuF+hngDULhJDmrpIRsuACH
	H3znYP/whAm58wo3bXcm4KtmSCFeMHrC/k=
X-Received: by 2002:a05:600c:8b5b:b0:49c:f13e:e4d with SMTP id 5b1f17b1804b1-49fe66f17damr26591975e9.10.1790238161498;
        Thu, 24 Sep 2026 01:22:41 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fdf157cdfsm56052875e9.0.2026.09.24.01.22.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 01:22:40 -0700 (PDT)
Date: Thu, 24 Sep 2026 09:22:39 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Johan Almbladh <johan.almbladh@anyfinetworks.com>
Cc: tsbogend@alpha.franken.de, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com,
 paulburton@kernel.org, main.kalliope@gmail.com, martin.lau@linux.dev,
 song@kernel.org, yonghong.song@linux.dev, jolsa@kernel.org,
 emil@etsalapatis.com, ihor.solodrai@linux.dev, linux-mips@vger.kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org, philmd@oss.qualcomm.com
Subject: Re: [PATCH bpf 1/2] bpf, mips: Fix immediate JMP JEQ/JNE on MIPS32
Message-ID: <20260924092239.0743b082@pumpkin>
In-Reply-To: <20260923105158.3514342-1-johan.almbladh@anyfinetworks.com>
References: <20260923105158.3514342-1-johan.almbladh@anyfinetworks.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 23 Sep 2026 12:51:57 +0200
Johan Almbladh <johan.almbladh@anyfinetworks.com> wrote:

> An addu instruction was emitted instead of addiu, causing the immediate
> value 1 to be interpreted as register $at. This made the comparison
> result invalid when the immediate operand was negative. Note that $at
> is mapped to BPF_REG_AX, which is used for constant blinding.
                                                      ^^ building??

David

> 
> Fix the instruction to use the immediate form.
> 
> Found with test_bpf on MIPS32r1 emulated by QEMU.
> 
> Fixes: eb63cfcd2ee8 ("mips, bpf: Add eBPF JIT for 32-bit MIPS")
> Signed-off-by: Johan Almbladh <johan.almbladh@anyfinetworks.com>
> ---
>  arch/mips/net/bpf_jit_comp32.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/mips/net/bpf_jit_comp32.c b/arch/mips/net/bpf_jit_comp32.c
> index 40a878b672f5..15a2a153dc87 100644
> --- a/arch/mips/net/bpf_jit_comp32.c
> +++ b/arch/mips/net/bpf_jit_comp32.c
> @@ -1111,7 +1111,7 @@ static void emit_jmp_i64(struct jit_context *ctx,
>  			emit(ctx, xor, tmp, lo(dst), tmp);
>  		}
>  		if (imm < 0) { /* Compare sign extension */
> -			emit(ctx, addu, MIPS_R_T9, hi(dst), 1);
> +			emit(ctx, addiu, MIPS_R_T9, hi(dst), 1);
>  			emit(ctx, or, tmp, tmp, MIPS_R_T9);
>  		} else {       /* Compare zero extension */
>  			emit(ctx, or, tmp, tmp, hi(dst));

