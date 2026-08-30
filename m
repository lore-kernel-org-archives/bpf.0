Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4CBD3932EE
	for <bpf@vger.kernel.org>; Sun, 30 Aug 2026 07:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788076734; cv=none; b=quH/xpEfMjTbsooEEuTI7QCtaWTUKEwJWUdRJ0rAVeJnxyfC0b6bP8BGFilS4jpID20vIHBZaGap3A87ZLFjcRPXF58SNgAsPaTt9+sIPe/ad5aphOCPOX8wJqVvHgpnOmbPKodM1pQVyphOCpKtbqEekxn9lazpDcSCbk98AKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788076734; c=relaxed/simple;
	bh=jCOV5kJUqaW+2RbW35OGKGHtRRX84NnMgHChFRzcfN0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=HU0iWpLPl7PkQSaqgZix8Qies7Sln1GbsK5KclJ5Cl+H79xdDrMit16eFOfyAPDIgUkud8UXxPNTXOFqmZTGNhVfk14G6ruqF2ugip/RcOVITmXNZjYvDmY191797oj2lzeAFse1+1YRg/bPwt3L9B1BXkBlbGjrgKTlzctUuo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J+KqjPsR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J+KqjPsR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10EE01F000E9;
	Sun, 30 Aug 2026 07:58:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788076729;
	bh=kxsZMFh9qvD3JoKNEekrHnuxlO7pEpYkRNsOTkVEBEg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=J+KqjPsRtXT7bT0UugyTTXxMzUr9rpDmrp+v7/shfkkjzjb8k35IHog8c+/ke4c4y
	 gH7+u5GrGgCyYa+MzCcb8UA6n85BKEm3fnXRr6PxbwVUEunTzl1A2DJCQ2P/AQarGo
	 MVLDVffiNo0b/DrzV6zvPbWzgSSY9LIfE1EbIeMLEFyuGOsjUDZwriETCAF7GyrBYM
	 9oJzAoyyGIlDS2Te3cFEYR2/NHHENs2gBcM0yfiD9zWsQB/4JB9Y169JZvGdTSlXS4
	 6731Bnf4EJuFeYuq9Xo2iiWdhv2T4ixAREbssYeZTRIx0OluXqEuV8vQa5BNAmyXmT
	 Gkki1YUVyEYuQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf v2 2/4] bpf: Fix NULL-ptr-deref when showing a void
 BTF type
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jiayuan Chen" <jiayuan.chen@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260830073242.148092-3-jiayuan.chen@linux.dev>
References: <20260830073242.148092-1-jiayuan.chen@linux.dev>
 <20260830073242.148092-3-jiayuan.chen@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 30 Aug 2026 07:58:48 +0000
Message-Id: <20260830075849.10EE01F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] NULL pointer dereference in `btf_var_show()` when rendering vmlinu=
x BTF types via `bpf_snprintf_btf()`.
--

commit f9ef7fc1b664c580ca28b8d18cae855dd7b0e940
Author: Jiayuan Chen <jiayuan.chen@linux.dev>

bpf: Fix NULL-ptr-deref when showing a void BTF type

This patch fixes a NULL pointer dereference when btf_modifier_show() attemp=
ts
to render a void type. Because void lacks a show op, it falls back to
btf_df_show() instead of dereferencing a NULL pointer.

> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index da36d4b9d31ab..81506cbb9f9ae 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -2911,7 +2911,15 @@ static void btf_modifier_show(const struct btf *bt=
f,
>  	else
>  		t =3D btf_type_skip_modifiers(btf, type_id, NULL);
> =20
> -	btf_type_ops(t)->show(btf, t, type_id, data, bits_offset, show);
> +	/*
> +	 * A modifier can resolve to the void type (e.g. "const void"), which
> +	 * has no show op (kind_ops[BTF_KIND_UNKN] is NULL). Print a placeholder
> +	 * instead of dereferencing NULL.
> +	 */
> +	if (!btf_type_ops(t))
> +		btf_df_show(btf, t, type_id, data, bits_offset, show);
> +	else
> +		btf_type_ops(t)->show(btf, t, type_id, data, bits_offset, show);
>  }
> =20
>  static void btf_var_show(const struct btf *btf, const struct btf_type *t,
>  			 u32 type_id, void *data, u8 bits_offset,
>  			 struct btf_show *show)
>  {
>  	t =3D btf_type_id_resolve(btf, &type_id);

[Severity: High]
This isn't a bug introduced by this patch, but while looking at this fix, I
noticed a potential issue in btf_var_show() just below it.

Can btf_var_show() cause a NULL pointer dereference when rendering vmlinux
BTF types via bpf_snprintf_btf()?

If a BPF program calls the bpf_snprintf_btf() helper and passes the type ID
of a BTF_KIND_VAR from the vmlinux BTF, formatting will dispatch to
btf_var_show().

This function unconditionally calls btf_type_id_resolve(), which attempts to
dereference btf->resolved_ids.

However, since type resolution is skipped for base BTF during parsing,
btf->resolved_ids is NULL for vmlinux BTF. Does this unconditionally result=
 in
a NULL pointer dereference inside btf_type_id_resolve()?

> =20
>  	btf_type_ops(t)->show(btf, t, type_id, data, bits_offset, show);
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260830073242.1480=
92-1-jiayuan.chen@linux.dev?part=3D2
