Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 745621A680A
	for <bpf@vger.kernel.org>; Mon, 22 Jun 2026 21:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782163056; cv=none; b=rUyEvG/9qkUbeITk99hWaW7hx2mDNzBkJYw/9l6EYsU4EBJenBdxv7f6DwDpfK1+AKxT/IgdxpgRhFQnvIKqj2i14lg5vTf/6K3oBHimg44Mj8dQnTzUJm5qpZm/oQV/+CLgXAX/OpekFLqO4lNjMMkw7ZszIuUY3kcOcmmwZs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782163056; c=relaxed/simple;
	bh=dYxAfae1+4H1G1KqpIX04MVMvlkmgCmAodBnYnUJ+Rw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Fdh24yaU2AlF0Uy1weJQdbnFgRuqRC3sRbZDt92Rc7yHMbO6vkrdHrRkIHifzeLXUVFfIvW9MbYJkNK4Za0pEnq4HlogjMPm19hjs75hXcyf0sFEV1aaVPJCYun/AMqWnb3RzEp/3+lT/0h89A0UZPlXfN1dmy/uUtDdG710zn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xquqbp1t; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xquqbp1t"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC3831F000E9;
	Mon, 22 Jun 2026 21:17:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782163055;
	bh=ayDL2APw1jVdG+8P3yOKHiCQZeWVluz0wB6cZ9dWVGc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Xquqbp1tQg9zn0VxZsAJnD7k6TDAoUS7OWTP/Qe5RIPhsp3a8RS0TKwXoRYE7Rz4E
	 j7BCOYuTphLVwPbnx3PwvSxgNnAqJBTiJbyhz7X+Cun3d7Kx+yEAYT6iYhYzdUq6G+
	 bRRD+jTWnpeLTHt2PwULujtB9g0cTLaQoLjsPkTEu8UjIlcDMAXYELhF/urxbBYoVl
	 bdH7jQ1/CaztsqLrgioLH6+YTGLAXKSsmkK/uZZXtsgJh4boTxN5FgM4wF56MHAxaD
	 6NXISQDrJV49oz+GP7hWEUmAk7shQFg4T1/sWJ1KXCjO7Drcfe0Gokq3sVFvO+AbDZ
	 ISMFrMrHMrEKw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] libbpf: fix weak kfunc name suffix resolution for light
 skeletons
Reply-To: sashiko-reviews@lists.linux.dev
To: "Siddharth Nayyar" <sidnayyar@google.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260622-bpf-lskel-fixes-v1-1-7c09a1585ba4@google.com>
References: <20260622-bpf-lskel-fixes-v1-1-7c09a1585ba4@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 22 Jun 2026 21:17:34 +0000
Message-Id: <20260622211734.EC3831F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Resolving weak kfuncs to their essential names in light skeletons =
breaks backwards-compatibility fallbacks and can cause silent garbage injec=
tion into kernel functions.
--

commit 4f2d3782567ee95facb86d9351ef9b20032be805
Author: Siddharth Nayyar <sidnayyar@google.com>
Subject: libbpf: fix weak kfunc name suffix resolution for light skeletons

When generating a light skeleton, libbpf currently records the unstripped
name of kfuncs into the external symbol records. This commit changes
bpf_program_record_relos to pass ext->essent_name when calling
bpf_gen__record_extern for BTF_KIND_FUNC, stripping suffixes so the kernel
resolves them properly.

> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 1368752aa13c3..421bfd5e159d1 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -8309,19 +8309,25 @@ static int bpf_program_record_relos(struct bpf_pr=
ogram *prog)
>  		struct reloc_desc *relo =3D &prog->reloc_desc[i];
>  		struct extern_desc *ext =3D &obj->externs[relo->ext_idx];
>  		int kind;
> +		const char *name;
> =20
>  		switch (relo->type) {
>  		case RELO_EXTERN_LD64:
>  			if (ext->type !=3D EXT_KSYM)
>  				continue;
> -			kind =3D btf_is_var(btf__type_by_id(obj->btf, ext->btf_id)) ?
> -				BTF_KIND_VAR : BTF_KIND_FUNC;
> -			bpf_gen__record_extern(obj->gen_loader, ext->name,
> +			if (btf_is_var(btf__type_by_id(obj->btf, ext->btf_id))) {
> +				kind =3D BTF_KIND_VAR;
> +				name =3D ext->name;
> +			} else {
> +				kind =3D BTF_KIND_FUNC;
> +				name =3D ext->essent_name ?: ext->name;
> +			}
> +			bpf_gen__record_extern(obj->gen_loader, name,
>  					       ext->is_weak, !ext->ksym.type_id,
>  					       true, kind, relo->insn_idx);
>  			break;
>  		case RELO_EXTERN_CALL:
> -			bpf_gen__record_extern(obj->gen_loader, ext->name,
> +			bpf_gen__record_extern(obj->gen_loader, ext->essent_name ?: ext->name,
>  					       ext->is_weak, false, false, BTF_KIND_FUNC,
>  					       relo->insn_idx);
>  			break;

[Severity: High]
By resolving weak kfuncs to their essential names instead of their suffixed
names here in RELO_EXTERN_CALL and RELO_EXTERN_LD64 above, does this break
backward compatibility fallbacks in light skeletons?

If a BPF program uses bpf_ksym_exists() to fall back to an older prototype
(e.g., calling func___v1 which takes 1 argument) but the kernel provides a
newer prototype without the suffix (taking 2 arguments), this would resolve
successfully because prototype validation against the suffix is bypassed.

Would the BPF verifier then accept a program calling the kfunc with only
R1 set, causing the kernel to execute the function with uninitialized or
garbage data in R2? Alternatively, if the verifier rejects the incompatible
register state, wouldn't this entirely break the intended backward
compatibility logic?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260622-bpf-lskel-=
fixes-v1-1-7c09a1585ba4@google.com?part=3D1
