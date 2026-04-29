Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A20C396B68
	for <bpf@vger.kernel.org>; Wed, 29 Apr 2026 12:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777465358; cv=none; b=SigHHNMxeluAsepDR6tf0zhaWKTRBjIkK+KGEL4+xlVNwKL3TyjHaOB4aUX2FFwe+4due2p7U+ClNzevcl98eBOzDlxP7NHMZIjHz8tFVU4Pf2JDI4I2pH/0JZD4RA50z87lP0llv9XjBNoKAh6Q/Hdmc736nXH94xO9fvwCsuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777465358; c=relaxed/simple;
	bh=txJfO9VvHzSjtuAfiTjpauWj4lURh4iilyh7oyKU/Zw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Qb4x/6PHEDJFW5BuZx3VRa6xxg4PvwX+0GTeRRtoYRflKNc2Bl/Nqtzk6PDEYrUj/f1CB6KdJK6uL+DfDNprmLNTwIGqH83bhAncl4nVzb9+0lwYBI7ETTVUdjKKObLEEfAZwof2NEhu6AsvrcrD8ypoCy1rwkxIcFO1lv3nEkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qbhQRUCV; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qbhQRUCV"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4893940bb5eso67641485e9.3
        for <bpf@vger.kernel.org>; Wed, 29 Apr 2026 05:22:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777465356; x=1778070156; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PCTWDJ2uCFhe3ba/Y7lAsYdbVICxlPc/tem5foBwLwE=;
        b=qbhQRUCVJHpW1Gza0cq1GGJtBb4DgRDATIJZg5cE1g6G94KJD33hyAAJrLs4cYAmTO
         BckQOiJOC565gOD8Q8cFQt8P/NNFqfZrDibC9qRxG7UK7VEQKr9mnoRoKwVKeHMV/RCP
         Wv3zXExmvUfdpo5/jP1rkKe43ALKne8YoAWcdgG+JQCdHbpZKlcAifmkqgekE9hGx/Hs
         YVBUMay7S3Pxrtl0fcXnguawZCNh6Tz8mapEkSBIto5mC/PnSJTmM3oHl/V7FpMiwdyr
         sW+oQl8daMjhQuZd/b5vj89zgllcZm+nniuDwTWW2a0CVNZVFnkfNUfHdnXVR5YiLrC2
         I2tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777465356; x=1778070156;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PCTWDJ2uCFhe3ba/Y7lAsYdbVICxlPc/tem5foBwLwE=;
        b=a4sKcsYvbUvGn1gDe6dci2G+ytkYBbXB63a3NkQUWVBDSXRM5pKJle47Vv2jKBULG8
         WuFeX4BzDe9SVgHjTC63+WCv75dMNH7qjmV+eOL6UoKyXo77PcQl0y3waW4stDxUf3Rh
         SKy+TtgKhDcRtw3WPiqWVIfFw0XHnm46+9vKh9+yuh5w3v0v3+kj1fUU51b2R7FQS6wd
         LOcLo4Xh7Rbyx9KWI0bZtpWs8eyfHduykPprBUZNAH026MUXx3kiA8HCR57j5wUF71se
         ptJTcFi9Gtfrf4NjY8NN/SRz/Z48qrPSR1f9yVgtax+fIFvsfcfCRjFaCBN5CmhlQ+mR
         BmTQ==
X-Forwarded-Encrypted: i=1; AFNElJ/OFiYesVeZ72ZTu661ZEjhU/TUqdizUsTi43djumplIQICCmRlnoO1/7XBxN5PA0hNbik=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/99zXnvUa51s/iSTooPbZuizJHD4r6Gy0SEOfCXt4gjYrYRhv
	z7eIzrvOPVt2XqNxBRia4KgW8VStmCGW+ooDx8XEKVOwtEZzhMrjUDVh
X-Gm-Gg: AeBDiesBTvK1Xx5fa65a2gMA3UJr1fMEAz5GKYJixe8v/AnGEPzWcXEBgweHSQFJMHz
	YxUCx+Bm7UoD23sZCWYNQODybhxmX8xXPcMvfu+69PceLBOrv3ExK3WzCkos4K4gUtqzAs0o4rg
	C7P3ho9sdYdIeIlJ2yt/e3NmVtdTBwKNQsmt6L//sMzW/XaU5jOPqBfIF3mvjgCvW8W/JRaLkEk
	f1wDol0UrHxjEytJwH5hHRliEzJ47xAX11ypAqJFqR3TW8tcZBsCWAwMwIwu1vesM23hFu+Apoj
	t3O3QbivD+LHcnJup5H81UdCUosiEXXR5wAFNspTUdwzjhyyFvRYVVALMr5gbpPuviiwFHhqMxr
	4qRBeF8Ts8BST5/26Fn0z55wZXBTbB7y3U56UQaAwvjzCDKV/gpJRASYFGsejLgmzux8VC7tP3n
	GS6+jwV4YZm6EtfZpdZAE9yuFIlbHfgOYPfiETM0i5YN3GpzjJlBmiBDpkvFwQIZdzzdy2xUUAg
	GxRnJi0BxJPxLWYmyYPUGYVni4l7Q==
X-Received: by 2002:a05:600c:3541:b0:488:936a:6220 with SMTP id 5b1f17b1804b1-48a77b1bb4cmr121925615e9.21.1777465355408;
        Wed, 29 Apr 2026 05:22:35 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:1126:4:da80:667b:e928:cc8c? ([2620:10d:c092:500::7:916f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a7b92a0cfsm19756975e9.10.2026.04.29.05.22.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2026 05:22:34 -0700 (PDT)
Message-ID: <0ab27743df8930a342517e1f3246662c86c0763a.camel@gmail.com>
Subject: Re: [PATCH bpf-next 04/18] bpf: Extend liveness analysis to track
 stack argument slots
From: Eduard Zingerman <eddyz87@gmail.com>
To: Yonghong Song <yonghong.song@linux.dev>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>, "Jose E .
 Marchesi" <jose.marchesi@oracle.com>, kernel-team@fb.com,  Martin KaFai Lau
 <martin.lau@kernel.org>
Date: Wed, 29 Apr 2026 05:22:34 -0700
In-Reply-To: <20260424171454.2035580-1-yonghong.song@linux.dev>
References: <20260424171433.2034470-1-yonghong.song@linux.dev>
	 <20260424171454.2035580-1-yonghong.song@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2026-04-24 at 10:14 -0700, Yonghong Song wrote:

[...]

> diff --git a/kernel/bpf/const_fold.c b/kernel/bpf/const_fold.c
> index db73c4740b1e..b65285d61efe 100644
> --- a/kernel/bpf/const_fold.c
> +++ b/kernel/bpf/const_fold.c
> @@ -51,13 +51,22 @@ static void const_reg_xfer(struct bpf_verifier_env *e=
nv, struct const_arg_info *
>  			   struct bpf_insn *insn, struct bpf_insn *insns, int idx)
>  {
>  	struct const_arg_info unknown =3D { .state =3D CONST_ARG_UNKNOWN, .val =
=3D 0 };
> -	struct const_arg_info *dst =3D &ci_out[insn->dst_reg];
> -	struct const_arg_info *src =3D &ci_out[insn->src_reg];
> +	struct const_arg_info *dst, *src;

Nit: there is no harm in computing addresses before validating the range.

>  	u8 class =3D BPF_CLASS(insn->code);
>  	u8 mode =3D BPF_MODE(insn->code);
>  	u8 opcode =3D BPF_OP(insn->code) | BPF_SRC(insn->code);
>  	int r;
> =20
> +	/* Stack arguments use BPF_REG_PARAMS which is outside the tracked regi=
ster set. */
> +	if (insn->dst_reg =3D=3D BPF_REG_PARAMS)

Nit: I'd add several accessors:
     - is_stack_arg_st(insn)
     - is_stack_arg_stx(insn)
     - is_stack_arg_ldx(insn)

> +		return;
> +	if (insn->src_reg =3D=3D BPF_REG_PARAMS) {
> +		ci_out[insn->dst_reg] =3D unknown;
> +		return;
> +	}
> +
> +	dst =3D &ci_out[insn->dst_reg];
> +	src =3D &ci_out[insn->src_reg];
>  	switch (class) {
>  	case BPF_ALU:
>  	case BPF_ALU64:

[...]

> diff --git a/kernel/bpf/liveness.c b/kernel/bpf/liveness.c
> @@ -1560,6 +1603,9 @@ static int compute_subprog_args(struct bpf_verifier=
_env *env,
>  	struct arg_track at_out[MAX_BPF_REG];
>  	struct arg_track (*at_stack_in)[MAX_ARG_SPILL_SLOTS] =3D NULL;
>  	struct arg_track *at_stack_out =3D NULL;
> +	struct arg_track (*at_stack_arg_in)[MAX_STACK_ARG_SLOTS] =3D NULL;
> +	struct arg_track at_stack_arg_out[MAX_STACK_ARG_SLOTS];
> +	struct arg_track at_stack_arg_entry[MAX_STACK_ARG_SLOTS];

I think this implementation is correct.  That being said, an
alternative option would be to track at_stack_arg_{in,out} as a part
of at_{in,out}, just at indexes >=3D11. This should avoid duplicating
the code processing joins in compute_subprog_args(), record_call_access(),
and memory handling a bit. Wdyt?

[...]
