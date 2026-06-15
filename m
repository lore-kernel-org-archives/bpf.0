Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE9AB3C5DBF
	for <bpf@vger.kernel.org>; Mon, 15 Jun 2026 15:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781538120; cv=none; b=oD3wscaH2ju9H+ULu4HbQqJgZEOj6wyi5FnXZw51u6EMq5/ywh6hf8LsS/evPQEJXmJ+oPbJZv5lxnOkcJ/hX9ez28+6+xHPKfR3B+/GUGSBdvSRlijbgTu8POiVD9bEMzblTYjo7JjPdoiUx7oQv15SUMhYtY38VdAdbPY0lBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781538120; c=relaxed/simple;
	bh=WcdvzlNci0zoZkhputJlp2C2mCcnhAlQEDeJGXB9zbw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=RaVoz1DxZ+UaYINXS/n2U8d/ucl5AaAxWyxB9CHbgF6WOOkdH+97mlXjgOC45QPsWgpksqHv/4CwW1xb0ZTEWzMsKcQ5gwhdzeislgIO68L/f8uNpe09X8qgJz8lj7u8STls53seiPl5EYCa042Tomz6hH18Xtc65UZuDC/+Lvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mvAch1ic; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mvAch1ic"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CF531F000E9;
	Mon, 15 Jun 2026 15:41:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781538118;
	bh=PyukyWKRXGDLQvHldXDxUXpyc+a5pfVhp8Jwju6Io6A=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mvAch1icKAd4SHx3zgN1Vsv8LAjnFZtMgLRtPdLYON+pWVTrhL4QXawxFqMfUqqgG
	 tYB2zmeXNJFAOXAL/8afxSruSWFmP0nZXBv1p474NXrSR2w1vRRew3vstkvAVY/yYw
	 k9mM+N19Cu+6Q+TS4mh0+1fWK0b+TO1fOAW6780gB0wT27X25ETd6Ye4qHcwQDcyFr
	 aEIf4neM3HH99ojcKxBTUKwXVinLUtYImIcYEPk9AKhUM0dT1QYv+B8WU92Y7j9VOg
	 SC8Dyf/HgNfpmVadTiZi9QRfGDWL06tLMAAZ0POEwkZj+xhbR3vZ8T/qM5BCVD9UoB
	 /GXphx6Tn3Zsw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v6 06/12] libbpf: Add support for global percpu
 data
Reply-To: sashiko-reviews@lists.linux.dev
To: "Leon Hwang" <leon.hwang@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260615152646.27639-7-leon.hwang@linux.dev>
References: <20260615152646.27639-7-leon.hwang@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 15 Jun 2026 15:41:57 +0000
Message-Id: <20260615154158.5CF531F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Missing endianness conversion for `flags` in `bpf_gen__map_update_=
elem` breaks cross-compiled BPF skeleton loaders.
--

commit fc64dc7d301e1cf5be2bffba25f597b23162b717
Author: Leon Hwang <leon.hwang@linux.dev>

libbpf: Add support for global percpu data

This commit adds support for global percpu data in libbpf by introducing a
new ".percpu" section. It updates the gen_loader to populate the percpu_arr=
ay
map using the BPF_F_ALL_CPUS flag.

> diff --git a/tools/lib/bpf/gen_loader.c b/tools/lib/bpf/gen_loader.c
> index d79695f01c87f..7ceb096f18ecb 100644
> --- a/tools/lib/bpf/gen_loader.c
> +++ b/tools/lib/bpf/gen_loader.c

[ ... ]

> @@ -1198,6 +1198,7 @@ void bpf_gen__map_update_elem(struct bpf_gen *gen, =
int map_idx, void *pvalue,
>  	int zero =3D 0;
> =20
>  	memset(&attr, 0, attr_size);
> +	attr.flags =3D flags;

[Severity: High]
Does this assignment need to use tgt_endian() to support cross-compilation?

When libbpf generates a skeleton loader for a target architecture with a
different endianness than the host, fields populated into the union bpf_attr
blob usually need to be converted to the target byte order.

For global percpu data maps, this flag will be BPF_F_ALL_CPUS (0x10). If a
little-endian host generates a skeleton for a big-endian target, a direct
assignment of the 64-bit value could result in it being interpreted as
0x1000000000000000 by the target kernel, which would cause the sys_bpf
call to fail with -EINVAL.

> =20
>  	value =3D add_data(gen, pvalue, value_size);
>  	key =3D add_data(gen, &zero, sizeof(zero));

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260615152646.2763=
9-1-leon.hwang@linux.dev?part=3D6
