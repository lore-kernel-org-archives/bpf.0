Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F98E246BC0
	for <bpf@vger.kernel.org>; Sat, 14 Mar 2026 01:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773451779; cv=none; b=bEw3tQ7K6TTncWbOtfNAwjFQobUF7wzmpV3OSvz3VzEyRfC3VDh6NoAuGvIRN/EH5YO0lm3nlJKlT8Q92CN1eSR1UHNBhfu7jZiIuOKXGiiSDmMXAewyHMWXen6jXvqkfQ25gi2XDtAUn+WfgN4/3rCVVr9QdrzPZXts1QpyqUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773451779; c=relaxed/simple;
	bh=joHvCo3Mef3lidTNmKFQXs+zuz68Ddv2REm0xsdd24w=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mM7XNdfZLguUCsRsExHb7dKUSNKxp9RUSDKJMlhoqPWdUTIFoeK3Ulu6PdCycowiHpTQjTstKfXawkTmoAabXmPgBA2BL731gu72PuzSwlFSEWpL+4WKqmQEf4u+wpj1LsyuQrlvn339RbVz9fQuLoieqzV5EMyF/+F7WkMJSTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Re4Ido98; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Re4Ido98"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-35a07ed3ebdso1335606a91.1
        for <bpf@vger.kernel.org>; Fri, 13 Mar 2026 18:29:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773451777; x=1774056577; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7EmrSuHvutIrDBDAGlQ6buLIUtau7tLM1U33dA0uIH0=;
        b=Re4Ido98JXTAFfYrWIaY3DC16EXt+KJGfQPojW1m9PHjIi/Gx9rdLbKReJ7dEKM6sk
         ouzyDtQPIPHZMANla7gk3p05kz89Rzwop5rYC2PSdDuci9+0KgCc7ksPOVdLMdyXJQ7E
         4qQCb/x7yq0dWnoL85/jarSx2Y7k4zZGojkvyCy9lzxB8hlk9BzUN5MiAithFecooXaD
         8rGd1CJ5SGF4jJOY/yPoQIWm0XrQixroUYI+lK9EEbD3z3Wm95Y8E67Pb3OpktIS526+
         xTEPnxxJWNU45if72/5qK+CyU3/rt4hn33CRO/PQuPJCG37fu4uiN6tvm1+tQb6pTPBe
         3Jrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773451777; x=1774056577;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7EmrSuHvutIrDBDAGlQ6buLIUtau7tLM1U33dA0uIH0=;
        b=qIsSO2w1IHBBZMAWqCxfdzx+urbGGbFd2S2z5Ipr1oRpeodr1NA2WcLbzGKpllYm1m
         BOFCP9w+DGStwZzl+58QCNx9toOaDrGeoLlE2uFDXXHHmybAe212bKeU2vN7BD4uSipn
         5v+S2SDBiECRu2L7TwIAOKchgAU3HzMZksdO4mytw18SdLsXNdzVfwLF1m27qrvbDHAi
         G8E1ZrVH6zNn1S+ks6f74FLK8fC+YIeVB2x+5P8FqrNe/1jzrlMLwTg0GIhX5MFOQ6UT
         oCy856+AUa72Hs7Gz7jjdwSbN1lANCpKpyR30aOMp6jEe5AH75Z0y+KwxqFXciD+yFja
         3vQg==
X-Forwarded-Encrypted: i=1; AJvYcCW9wXHLrFeypGDxljDavy7kjfrhjrix7k6sQKlDUjKsxolBIuU+PgcJ57cyii0hhiO3URM=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywl4NwVP/SunpCiF+cFlhJ+Pz4a0hqhY/KaqVSJ5+UFFDNl4ANQ
	LO24tMAK+cfvDfd42ajQcRrMyRmib/fTYmi9YPWIqD6YZnok933NKK/WBYlWHbbt
X-Gm-Gg: ATEYQzwe8KW0u1MRVLOgLUPLRn9ABBqE0udVjHPKak1bJ+TXZN7IUwptPpofNtiNB5F
	9TIvW196bWEUC8Ri+Q5euP50BQTW4UAFpfyci1cEm2CNCFfnf9+UpBcDwA2De9ikBWm0OrXx785
	YVZSplxHGbuyxaRmUl1dze8hshUxTdLlAwlydnqLZIAUEBN7ke9xXbfIKZ5jsjKsH5/d2AcbVv4
	88SSOmLpFFvLsttVGg5MTorpfonaZjIK/eh0x4fMlOHxAwvXDHuhgokwCBj2CVbeAWE7FljIqbK
	CIfYbDYD9cskp4zFO2dvQMoMoxQqpJ1OPGxEFQmnzXAddHkFJRzdk0ZgvkPpey3lVyQv1ggTxmi
	Es3SGlyjaWs5gFDxNjRYLmAU4kvrXN+Dx171k1T0PZYF6bOeE2l2dGqqay8JJiWgpDMe9KgQVza
	mGJSrPXUoeUm1miDX5yh+iZPEMzsfGAv5ZGXr/qMmziXkFznD3BKM=
X-Received: by 2002:a17:90b:2683:b0:359:8d2e:6f79 with SMTP id 98e67ed59e1d1-35a21f6874bmr5053778a91.14.1773451777422;
        Fri, 13 Mar 2026 18:29:37 -0700 (PDT)
Received: from [192.168.0.56] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35a02fc8465sm9531222a91.9.2026.03.13.18.29.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2026 18:29:37 -0700 (PDT)
Message-ID: <4e4c3be9bfca85c5343834b5d6b1d6283fd6a1f5.camel@gmail.com>
Subject: Re: [PATCH bpf-next v9 1/5] bpf: Move constants blinding out of
 arch-specific JITs
From: Eduard Zingerman <eddyz87@gmail.com>
To: Xu Kuohai <xukuohai@huaweicloud.com>, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>,  Andrii Nakryiko <andrii@kernel.org>, Martin KaFai
 Lau <martin.lau@linux.dev>, Yonghong Song	 <yonghong.song@linux.dev>,
 Puranjay Mohan <puranjay@kernel.org>, Anton Protopopov
 <a.s.protopopov@gmail.com>, Alexis =?ISO-8859-1?Q?Lothor=E9?=
 <alexis.lothore@bootlin.com>,  Shahab Vahedi <list+bpf@vahedi.org>, Russell
 King <linux@armlinux.org.uk>, Tiezhu Yang <yangtiezhu@loongson.cn>,  Hengqi
 Chen <hengqi.chen@gmail.com>, Johan Almbladh
 <johan.almbladh@anyfinetworks.com>, Paul Burton	 <paulburton@kernel.org>,
 Hari Bathini <hbathini@linux.ibm.com>, Christophe Leroy
 <chleroy@kernel.org>, Naveen N Rao <naveen@kernel.org>, Luke Nelson	
 <luke.r.nels@gmail.com>, Xi Wang <xi.wang@gmail.com>, 
 =?ISO-8859-1?Q?Bj=F6rn_T=F6pel?=	 <bjorn@kernel.org>, Pu Lehui
 <pulehui@huawei.com>, Ilya Leoshkevich	 <iii@linux.ibm.com>, Heiko Carstens
 <hca@linux.ibm.com>, Vasily Gorbik	 <gor@linux.ibm.com>, "David S . Miller"
 <davem@davemloft.net>, Wang YanQing	 <udknight@gmail.com>
Date: Fri, 13 Mar 2026 18:29:33 -0700
In-Reply-To: <20260312170255.3427799-2-xukuohai@huaweicloud.com>
References: <20260312170255.3427799-1-xukuohai@huaweicloud.com>
	 <20260312170255.3427799-2-xukuohai@huaweicloud.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.1 (3.58.1-1.fc43) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2026-03-13 at 01:02 +0800, Xu Kuohai wrote:

[...]

> diff --git a/arch/arc/net/bpf_jit_core.c b/arch/arc/net/bpf_jit_core.c
> index 1421eeced0f5..973ceae48675 100644
> --- a/arch/arc/net/bpf_jit_core.c
> +++ b/arch/arc/net/bpf_jit_core.c

[...]

> @@ -229,12 +211,19 @@ static void jit_ctx_cleanup(struct jit_context *ctx=
)
> =C2=A0		ctx->bpf2insn_valid =3D false;
> =C2=A0
> =C2=A0	/* Freeing "bpf_header" is enough. "jit.buf" is a sub-array of it.=
 */
> -	if (!ctx->success && ctx->bpf_header) {
> -		bpf_jit_binary_free(ctx->bpf_header);
> -		ctx->bpf_header =3D NULL;
> -		ctx->jit.buf=C2=A0=C2=A0=C2=A0 =3D NULL;
> -		ctx->jit.index=C2=A0 =3D 0;
> -		ctx->jit.len=C2=A0=C2=A0=C2=A0 =3D 0;
> +	if (!ctx->success) {
> +		if (ctx->bpf_header) {
> +			bpf_jit_binary_free(ctx->bpf_header);
> +			ctx->bpf_header =3D NULL;
> +			ctx->jit.buf=C2=A0=C2=A0=C2=A0 =3D NULL;
> +			ctx->jit.index=C2=A0 =3D 0;
> +			ctx->jit.len=C2=A0=C2=A0=C2=A0 =3D 0;
> +		}
> +		if (ctx->is_extra_pass) {

Nit: The idea is that for !ctx->is_extra_pass
     ctx->prog->bpf_func !=3D NULL only when ctx->success is true, right?
     Maybe just drop the condition?

> +			ctx->prog->bpf_func =3D NULL;
> +			ctx->prog->jited =3D 0;
> +			ctx->prog->jited_len =3D 0;
> +		}
> =C2=A0	}
> =C2=A0
> =C2=A0	ctx->emit =3D false;
> diff --git a/arch/arm/net/bpf_jit_32.c b/arch/arm/net/bpf_jit_32.c
> index deeb8f292454..e6b1bb2de627 100644
> --- a/arch/arm/net/bpf_jit_32.c
> +++ b/arch/arm/net/bpf_jit_32.c
> @@ -2144,9 +2144,7 @@ bool bpf_jit_needs_zext(void)
> =C2=A0
> =C2=A0struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
> =C2=A0{
> -	struct bpf_prog *tmp, *orig_prog =3D prog;
> =C2=A0	struct bpf_binary_header *header;
> -	bool tmp_blinded =3D false;
> =C2=A0	struct jit_ctx ctx;
> =C2=A0	unsigned int tmp_idx;
> =C2=A0	unsigned int image_size;

The code in arch/arc is modified to do `... ctx->prog->jited =3D 0; ...`,
but for arm32 there is no such modification. Why is that so?

[...]

> diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.=
c
> index adf84962d579..cd5a72fff500 100644
> --- a/arch/arm64/net/bpf_jit_comp.c
> +++ b/arch/arm64/net/bpf_jit_comp.c
> @@ -2009,14 +2009,12 @@ struct arm64_jit_data {

[...]

> @@ -2245,13 +2211,15 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_p=
rog *prog)
> =C2=A0		kfree(jit_data);
> =C2=A0		prog->aux->jit_data =3D NULL;
> =C2=A0	}
> -out:
> -	if (tmp_blinded)
> -		bpf_jit_prog_release_other(prog, prog =3D=3D orig_prog ?
> -					=C2=A0=C2=A0 tmp : orig_prog);
> +
> =C2=A0	return prog;
> =C2=A0
> =C2=A0out_free_hdr:
> +	if (extra_pass) {
> +		prog->bpf_func =3D NULL;
> +		prog->jited =3D 0;
> +		prog->jited_len =3D 0;
> +	}

Just for my understanding, is the following correct?
- Previously, a call bpf_jit_blind_constants() always cloned the prog.
- Jits only set prog->jited to true upon successful compilation.
- On error exit jits restored the original prog with it's prog->jited =3D=
=3D 0.

What happened in case of an extra pass?
I'd expect that in case of an extra pass prog->jited would be true
even before program is cloned by blind_constants() (and that's what
arc code uses to figure out if the current pass is an extra pass).
If so, old code would preserve prog->jited as true even in case of
extra pass failure. Is that true or am I confused?

Just trying to understand why this patch has to deal with the above
snippet at all. In case it is indeed necessary, it seems the logic
should be similar for all jits, is there a way to push this snippet to
some common code? E.g. in verifier.c where the extra pass is initiated.

[...]
