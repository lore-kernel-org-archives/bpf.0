Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 186E937702A
	for <bpf@vger.kernel.org>; Thu,  4 Jun 2026 15:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780587621; cv=none; b=O/gAuKrh6h8B9SCHob2zYqag0biPAOwvi7h21YTqsMP9oaZOdt0FKjYHNzZ5J0Z/T0gGAfZcfXVkMxxHEtShSmJTfWg9TLmIVlSviB7hDpRX0H2hUKdo+QyWb/v3Tp4BIpDIQ7m1liC8UJIdsEcxoa/aU09WeAHVLUvo9aIFn90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780587621; c=relaxed/simple;
	bh=N/A8S+EoNkzGAyR6DfhigcUHw/sP3lCPLDEI/2cnv38=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=TwzL7h0I3FDL6fkjkn+eEn3ygCUK+qtVD8k7RzoMZGikqAZQfCnwgrG18rawgTpz7vzYO9Qd/YzAgbNgqcgDUDT5V14lxbEEG3r++b+s9B/8vscw/XHYOTZNQPnNc43kAlyUKeOSkjjmkuzCHihkkuU7/T4wXrsW0kTiBYTYa6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oY/7M2ZZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oY/7M2ZZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 435981F00893;
	Thu,  4 Jun 2026 15:40:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780587617;
	bh=WVdvABIV8Gs9six/oI3GoRS9ZgTmGqg5cBL5cnfJyao=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oY/7M2ZZ/94zrjQ0DpI/z8egKGhpw2pYBnUzto5pMdRWFGupObzAEaBWmKWzvttu7
	 0KBo6GP/jhJmRXPOAmncoDQ6mtUPQGFaf1kEsFPRbThgqQcfhEZrMzQsY2OyHK8oU2
	 +wUxvHnPEQuOpEoC/+A+9vseSXkX2cZ/dDGePd0AvA9iG+pfUhQaga9GdGX9Id+E+k
	 +bttSVTZknEwLCdY8vZMhoA8RQDe56mjy+DG33E+hPJm9cDabXXwtxuQrWud9w5z6t
	 cU1jOo13aHosgeaZiuLz6M2IZxkEPH1xVH9/mZz0Nv34/M8GJiyl/ngH9kTrwKnV6D
	 XckXSoKi1WHow==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf 1/2] bpf, verifier: fold reg->var_off into
 PTR_TO_FLOW_KEYS bounds check
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nuiqi Gui" <gnq25@mails.tsinghua.edu.cn>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260604150755.2487555-2-gnq25@mails.tsinghua.edu.cn>
References: <20260604150755.2487555-2-gnq25@mails.tsinghua.edu.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 04 Jun 2026 15:40:16 +0000
Message-Id: <20260604154017.435981F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Negative variable offsets on PTR_TO_BUF and PTR_TO_TP_BUFFER c=
ompletely bypass memory bounds tracking, permitting out-of-bounds reads/wri=
tes at runtime.
--

commit 2118c968df54a167a0c832db86595b84ed0a8c71
Author: Nuiqi Gui <gnq25@mails.tsinghua.edu.cn>

bpf, verifier: fold reg->var_off into PTR_TO_FLOW_KEYS bounds check

This commit fixes a bounds checking bypass for PTR_TO_FLOW_KEYS by folding
a constant reg->var_off into the offset before validation. This prevents
out-of-bounds reads and writes to kernel stack memory.

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -4997,9 +4997,22 @@ static int check_ctx_access(struct bpf_verifier_en=
v *env, int insn_idx, u32 regn
>  	return err;
>  }
> =20
> -static int check_flow_keys_access(struct bpf_verifier_env *env, int off,
> -				  int size)
> +static int check_flow_keys_access(struct bpf_verifier_env *env, u32 regn=
o,
> +				  int off, int size)
>  {
> +	struct bpf_reg_state *reg =3D reg_state(env, regno);
> +
> +	/* Only a constant offset is allowed here; fold it into off. */
> +	if (!tnum_is_const(reg->var_off)) {
> +		char tn_buf[48];
> +
> +		tnum_strn(tn_buf, sizeof(tn_buf), reg->var_off);
> +		verbose(env, "R%d invalid variable offset to flow keys: off=3D%d, var_=
off=3D%s\n",
> +			regno, off, tn_buf);
> +		return -EACCES;
> +	}
> +	off +=3D reg->var_off.value;
> +
>  	if (size < 0 || off < 0 ||
>  	    (u64)off + size > sizeof(struct bpf_flow_keys)) {
>  		verbose(env, "invalid access to flow keys off=3D%d size=3D%d\n",

[Severity: Critical]
This isn't a bug introduced by this patch, but while looking at how we
validate reg->var_off.value here, do check_buffer_access() and
check_tp_buffer_access() have a vulnerability with negative variable offset=
s?

In __check_buffer_access(), we reject non-constant variable offsets, but we
don't seem to verify if reg->var_off.value or reg->smin_value is negative:

kernel/bpf/verifier.c:__check_buffer_access() {
    ...
    if (!tnum_is_const(reg->var_off)) {
        ...
    }
    ...
}

Later in check_buffer_access(), this gets added to a u32 *max_access:

kernel/bpf/verifier.c:check_buffer_access() {
    ...
    *max_access =3D max(reg->var_off.value + off + size, *max_access);
    ...
}

If reg->var_off.value is a large negative 64-bit constant whose lower 32
bits evaluate to a small positive number (e.g., -4294967296, which is
0xFFFFFFFF00000000ULL), does reg->var_off.value + off + size truncate when
assigned to the u32 *max_access?

If it truncates to a small value, it seems like it could bypass the bounds
check, making a massively out-of-bounds access appear perfectly valid to
the verifier.

It appears check_tp_buffer_access() might apply the identical bounds
truncation logic:

kernel/bpf/verifier.c:check_tp_buffer_access() {
    ...
    env->prog->aux->max_tp_access =3D max(reg->var_off.value + off + size,
                                        env->prog->aux->max_tp_access);
    ...
}

Could this lead to out-of-bounds access at runtime?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260604150755.2487=
555-1-gnq25@mails.tsinghua.edu.cn?part=3D1
