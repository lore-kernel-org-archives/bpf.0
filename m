Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA52B72627
	for <bpf@vger.kernel.org>; Tue, 14 Jul 2026 00:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783989397; cv=none; b=Dn+Ti6Baftc0WceSGqAthR4dg+A7Cv/il3v2O9OD4rcnxWpiFlAxiFneEm9dAlEqUxcP3RtaRq5zRr82IxRIgBDb0nirrhHIDNK5Ka/DxEy0BKPsstVyRS9c11wM7ZRXQz1vQyyO0v3tyQRmWat2WqJn0hS1TrwC3eIRULTseN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783989397; c=relaxed/simple;
	bh=/3jKhzBZ+cebna2cxZP8VZokBD3ICWUNrUMDKYZtU7c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WdyYdhM+3cMT5VAV4255+4Gm0yllBX7ki5gfzt89VHhIynyA7D2EkO90quT4Z3fCGS81ee7LUXgQ/jKF52PiTf60e5cnJ9lKeijUUZfZqkWRofntbeRrLseMkmxYy3aMdYSrY62wPeCVVunDbV+JNT//OYoyx3La3UMKrBfpmhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KUaW4SWU; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KUaW4SWU"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2cc7e86e7aeso3439035ad.2
        for <bpf@vger.kernel.org>; Mon, 13 Jul 2026 17:36:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783989395; x=1784594195; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3Z7qrd6+HWKi29hSZU2yo+FitwF6K/D1YKKZYYrEqhY=;
        b=KUaW4SWUvku7vZAzd8CdOPYnMFJhnG8gb9PSK584yVOox7q89lW5uMugjLK+6sgvTU
         hP9/H7gYnPQ2Ya0eR7ZSQCIGJ1KYm2Z9SvKWXDJZSuI5jFXZ+sxuI37ToHCxvciRnQca
         otL2Z8+VsdKnJF2m8LVo0PLv6xNQEDn7WEs1fqd2RzKx84w0u6QczuvzsHkMGgMJKO2J
         w+H4+nwNvk3JPyIq4kT2nYLe3K5lB0B+KSrGTQJ2LWC9dH/+OMKG9lx/IvItRUbs+kdJ
         kgDJlASbyvPd4g8JbP1jhNUw/ThpCwHIPNn7/R65QYikckfL/ggBTztnn+6CMp98BDP/
         mAVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783989395; x=1784594195;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3Z7qrd6+HWKi29hSZU2yo+FitwF6K/D1YKKZYYrEqhY=;
        b=ZE6tBip6XVW3Yd34zv3AUTLZH39b6sA7MlCychyVscxPBqKAO16RcHhMBdvq5zmVFU
         +1Zo8QC3uOOtPYy+h5KYDQfFIg01TLMU4wWcVsx2yDpevEXd4WHo11gLJIAaBnmOBzLR
         9mf4Rexog22KoR+1ujkWpk5Qp97pyxe/6eYAleY4Xt44avw0rudDGez4upgbmHXhcOeT
         heGwicABkPjTNiYIh7Ap/6q3hqT7r+wlOmJKk9tBDGKhCifT/5yCT6tK6C7rpJb1fe7V
         MCuO6jPJ64Wr2ZaVTEeIdvLBW0+RB4/w2swOF1uf5DEf/2ylZ17S2yW8mHWrAUXXneXf
         A6vA==
X-Gm-Message-State: AOJu0YysG/hZt5VODVc0JkbWBFn5YP1gzKdgX9PCOd+owvpuPGjs/eY3
	nj58tvGq9667RHmZD8zhWcpxlURWjbbMkhciKaROqPacgU7RhpOW+cK5
X-Gm-Gg: AfdE7cl0emjuIFE7G6Hf17kP0fjO/dhKfOfBI6UEg4zFfF3z8QZBvVKDHVjNiTs8Jc9
	+VaGbddNcVZe8pl+1EoNEWGcUJdglHIuE4umLcTg1IhgqULph6kfQqrl9vD035FzJN0zJaRktEC
	+yrZC5knWV3MYqdC4ze2RaZjoc2wIy9cPD4X1f/dHGth61LjRV31zvTH8fuln46UwmzKl5IiAzi
	E7q4ER9r/FnBgkGYQnN8jD4lXzCd2z1TIeiyvJp4SoG5BleJT+tvXaxUv2SeO+T2ZftIp5AZ2Y6
	7iVMdinl7vl/OfDks/N16+RlmD6kicpxw9L3IiZ25aefC+BupGLY5BgfzZUVKRkw9HYMOXF8HsV
	83KPMzKpDFQ7VCcLk04jPVxgoF4TdX41Brezzu4xe4cK3HdlxSpYzZFe2ogZSnrUEp1vwxwsT5B
	jrab4WJNKyzPDu4CPhpszYyBFQvYdqbe3yLvPmR3hPmK0QyA==
X-Received: by 2002:a17:903:388e:b0:2c9:e9c7:2b59 with SMTP id d9443c01a7336-2ce9f029a3emr108618375ad.35.1783989395230;
        Mon, 13 Jul 2026 17:36:35 -0700 (PDT)
Received: from google.com ([2a00:79e0:2039:4:603:d769:e361:37a9])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ce8217a64bsm60488795ad.13.2026.07.13.17.36.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 17:36:34 -0700 (PDT)
Date: Tue, 14 Jul 2026 08:36:31 +0800
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: Nicholas Dudar <main.kalliope@gmail.com>
Cc: bpf@vger.kernel.org, udknight@gmail.com, ast@kernel.org,
	daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com,
	memxor@gmail.com
Subject: Re: [PATCH bpf] bpf, x86: Fix signed 32-bit div/mod in the i386 JIT
Message-ID: <alWEj2hDtxz8RW-l@google.com>
References: <20260713185848.120137-1-main.kalliope@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260713185848.120137-1-main.kalliope@gmail.com>

Hi Nicholas,

On Mon, Jul 13, 2026 at 02:58:48PM -0400, Nicholas Dudar wrote:
> emit_ia32_div_mod_r() always emits an unsigned divide (xor edx,edx +
> div ecx), regardless of the BPF instruction's signedness. Signed
> ALU32 BPF_DIV and BPF_MOD (off=1) therefore get an unsigned quotient
> and remainder in the i386 JIT, diverging from the verifier's and the
> interpreter's signed result for negative operands.
> 
> Thread is_signed = (insn->off == 1) into emit_ia32_div_mod_r() and
> emit cdq + idiv ecx on the signed path, xor edx,edx + div ecx
> unchanged on the unsigned path, mirroring the cdq/idiv-vs-xor/div
> split the x86_64 JIT uses for the same instructions. bpf_do_misc_fixups()
> rewrites the zero-divisor and INT_MIN/-1 cases out of the instruction
> stream before the JIT runs.
> 
> The RV32 JIT has the same gap.
> 
> Fixes: ec0e2da95f72 ("bpf: Support new signed div/mod instructions.")

As suggested by Pu Lehui [1], let's use 'Add support for xxx' and drop
the Fixes tag.

[1]: https://lore.kernel.org/bpf/fa8a040f-64c4-484f-9538-fb0ec287639f@huawei.com/

> Signed-off-by: Nicholas Dudar <main.kalliope@gmail.com>
> Assisted-by: Claude:claude-opus-4-8
> ---
>  arch/x86/net/bpf_jit_comp32.c | 23 ++++++++++++++++-------
>  1 file changed, 16 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/x86/net/bpf_jit_comp32.c b/arch/x86/net/bpf_jit_comp32.c
> index 852baf2e4db4..46b47432f50a 100644
> --- a/arch/x86/net/bpf_jit_comp32.c
> +++ b/arch/x86/net/bpf_jit_comp32.c
> @@ -433,7 +433,8 @@ static inline void emit_ia32_to_be_r64(const u8 dst[], s32 val,
>   * dst = dst (div|mod) src
>   */
>  static inline void emit_ia32_div_mod_r(const u8 op, const u8 dst, const u8 src,
> -				       bool dstk, bool sstk, u8 **pprog)
> +				       bool dstk, bool sstk, bool is_signed,
> +				       u8 **pprog)

Let's combine op and is_signed to struct bpf_insn *insn to simplify the
parameters.

Regards,
Kuan-Wei

>  {
>  	u8 *prog = *pprog;
>  	int cnt = 0;
> @@ -454,10 +455,17 @@ static inline void emit_ia32_div_mod_r(const u8 op, const u8 dst, const u8 src,
>  		/* mov eax,dst */
>  		EMIT2(0x8B, add_2reg(0xC0, dst, IA32_EAX));
>  
> -	/* xor edx,edx */
> -	EMIT2(0x31, add_2reg(0xC0, IA32_EDX, IA32_EDX));
> -	/* div ecx */
> -	EMIT2(0xF7, add_1reg(0xF0, IA32_ECX));
> +	if (is_signed) {
> +		/* cdq */
> +		EMIT1(0x99);
> +		/* idiv ecx */
> +		EMIT2(0xF7, add_1reg(0xF8, IA32_ECX));
> +	} else {
> +		/* xor edx,edx */
> +		EMIT2(0x31, add_2reg(0xC0, IA32_EDX, IA32_EDX));
> +		/* div ecx */
> +		EMIT2(0xF7, add_1reg(0xF0, IA32_ECX));
> +	}
>  
>  	if (op == BPF_MOD) {
>  		if (dstk)
> @@ -1796,7 +1804,8 @@ static int do_jit(struct bpf_prog *bpf_prog, int *addrs, u8 *image,
>  			switch (BPF_SRC(code)) {
>  			case BPF_X:
>  				emit_ia32_div_mod_r(BPF_OP(code), dst_lo,
> -						    src_lo, dstk, sstk, &prog);
> +						    src_lo, dstk, sstk,
> +						    insn->off == 1, &prog);
>  				break;
>  			case BPF_K:
>  				/* mov ecx,imm32*/
> @@ -1804,7 +1813,7 @@ static int do_jit(struct bpf_prog *bpf_prog, int *addrs, u8 *image,
>  					    imm32);
>  				emit_ia32_div_mod_r(BPF_OP(code), dst_lo,
>  						    IA32_ECX, dstk, false,
> -						    &prog);
> +						    insn->off == 1, &prog);
>  				break;
>  			}
>  			if (!bpf_prog->aux->verifier_zext)
> 
> base-commit: 7cbd0c4cebe4c9f678d15e6b9ba975e1155a107f
> -- 
> 2.34.1
> 
