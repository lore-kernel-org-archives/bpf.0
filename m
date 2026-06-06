Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A7882F7F01
	for <bpf@vger.kernel.org>; Sat,  6 Jun 2026 11:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780743917; cv=none; b=blzYOBeH6aZ5RAazCGGtqLBSmhOjd25EvnjuNjjYyMDd3tDZCLjN4u/KPWVxF2qp4XSLzZEpuX0FjjmKAnkF5Tv7i/ohNfdB1vbzcNDzUDXb4PZXycoMILXb6wYhudRoUajRv7Qdh1QyycbQ7eoRQenT3kLjdBvf57a5BA6W1/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780743917; c=relaxed/simple;
	bh=HFFf/E7pyF6TPbBVzmgaLFOhfhIB7hf91ffK2gJHuiE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=oW+DlayBqJD9wyz6N3HX+lzg5ubebnCTW7O2NTB8kyY4TTi6B3gtm6x1fQRS/hTP5mTTAaAUUlMz6eUlcz5Ut2UqoZM0NwiXans9Iv0AIw8c/rXlpQeI3u2VJDsvPClVZfzYYT3LCEvcw9fIrPsLN8khfClNoPa691PURuxkLa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qognq9B0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qognq9B0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F03FF1F00893;
	Sat,  6 Jun 2026 11:05:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780743916;
	bh=n0Ks+RZnTJoWXB2V3IWUnCdE9JRJshkMwjWOWhhryrE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Qognq9B06GfOHUhypgtjay8f3mD0IBeKEZq3g4vq1CLoEG2EJNPtAL685Tp5PYFjf
	 0MWC6bNSLl2Kuf9eUKe8HQlOgjSD4UTYbfUlYya6HacHsjf9U1Fi9bIn5Ra01mevxe
	 fOKPytRRA40VISY3x/eQ2V1QMshFa161jY6Ih+pDfk1hQifuizmLLgfYFK/Vui+EGW
	 /8mkrNAjFH9w2kiHBI6hJda6WYDIBEsn+kZHcugqYMW3BRYecbt2rsrEusHJVNLASz
	 wyisMXgy/30T0QzI233EWfWPMb+23uXc5x/sdYJzp1IhBVn1yE1niZliV6YoYGNemv
	 BW/fkzIoKAJYQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v3 1/2] bpf, verifier: fold reg->var_off into
 PTR_TO_FLOW_KEYS bounds check
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nuoqi Gui" <gnq25@mails.tsinghua.edu.cn>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260606-c3-01-v3-v3-1-97c51f592f15@mails.tsinghua.edu.cn>
References: <20260606-c3-01-v3-v3-1-97c51f592f15@mails.tsinghua.edu.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 06 Jun 2026 11:05:15 +0000
Message-Id: <20260606110515.F03FF1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The patch introduces undeclared identifiers (`argno_t`, `argno`, an=
d `reg_arg_name()`), which will cause a fatal compilation error.
--

commit c76d52d074593085f56551ce421dd163632b1f9d
Author: Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>

bpf, verifier: fold reg->var_off into PTR_TO_FLOW_KEYS bounds check

This patch modifies check_flow_keys_access() to fold the constant
reg->var_off.value into the offset before bounds checking, mirroring the
behavior of other pointer types. It also rejects non-constant variable
offsets to prevent out-of-bounds memory accesses.

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 7fb88e1cd7c4d..28b83a91720c5 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -4997,9 +4997,21 @@ static int check_ctx_access(struct bpf_verifier_en=
v *env, int insn_idx, u32 regn
>  	return err;
>  }
> =20
> -static int check_flow_keys_access(struct bpf_verifier_env *env, int off,
> -				  int size)
> +static int check_flow_keys_access(struct bpf_verifier_env *env,
> +				  struct bpf_reg_state *reg, argno_t argno,
> +				  int off, int size)
>  {

[Severity: Low]
Is argno_t a valid type here? I couldn't find a definition for it in the
tree, so this looks like it might cause a build failure.

> +	/* Only a constant offset is allowed here; fold it into off. */
> +	if (!tnum_is_const(reg->var_off)) {
> +		char tn_buf[48];
> +
> +		tnum_strn(tn_buf, sizeof(tn_buf), reg->var_off);
> +		verbose(env, "%s invalid variable offset to flow keys: off=3D%d, var_o=
ff=3D%s\n",
> +			reg_arg_name(env, argno), off, tn_buf);

[Severity: Low]
Does the reg_arg_name() function exist? This seems to reference an undeclar=
ed
function which could also prevent the kernel from compiling.

> +		return -EACCES;
> +	}
> +	off +=3D reg->var_off.value;
> +
>  	if (size < 0 || off < 0 ||
>  	    (u64)off + size > sizeof(struct bpf_flow_keys)) {
>  		verbose(env, "invalid access to flow keys off=3D%d size=3D%d\n",

[ ... ]

> @@ -6514,7 +6526,7 @@ static int check_mem_access(struct bpf_verifier_env=
 *env, int insn_idx, u32 regn
>  			return -EACCES;
>  		}
> =20
> -		err =3D check_flow_keys_access(env, off, size);
> +		err =3D check_flow_keys_access(env, reg, argno, off, size);

[Severity: Low]
Is argno declared in the scope of check_mem_access()? Could this be a typo
for regno?

>  		if (!err && t =3D=3D BPF_READ && value_regno >=3D 0)
>  			mark_reg_unknown(env, regs, value_regno);
>  	} else if (type_is_sk_pointer(reg->type)) {

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260606-c3-01-v3-v=
3-0-97c51f592f15@mails.tsinghua.edu.cn?part=3D1
