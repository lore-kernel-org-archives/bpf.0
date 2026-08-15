Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C85E21E0DE8
	for <bpf@vger.kernel.org>; Sat, 15 Aug 2026 08:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786781693; cv=none; b=XkKAhidKkIcpOJ8cmbES1yY6jb5mSq2Q4KuxgpaUPdwwe/dKPo9lB3eSKJOqj6zIispj3v8Nwx4ilxJQxR0D6eUgHAWOkZT+mZ6CJSAdRrgYflIzt4Rt9oGKh0HwMYHfJA1/cuTW09jrCZO1cjTkwLBhH3Ysa7+bWmVu1LTaa0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786781693; c=relaxed/simple;
	bh=WddCTM3tTaCvPItcPgyyq0v1Bvw0fjcTVItPMrxR6yw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=gGVt7OWcngExAapj6dAx1JkBlzgjqEwvTDelr8+YOOLLxZaOEwG23vPOg7vEUUrNfEQI1xCwYDJpvoO+BOcthso8fHiXUwb+9vXeFjeQ4m2rzOwdR7bYPeEse2e+GzjJDETCDTbLbCnCogS5w2+Hm1MSovlD3MwaPmww2WLahcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E6NjV1Yi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E6NjV1Yi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8817D1F00A3D;
	Sat, 15 Aug 2026 08:14:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786781691;
	bh=syifls2wWDYcvaDXZGe2HhAXbsULhbNPt8iH0cL9nbc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=E6NjV1YiwP+DtwhR8ioQcPRSIBqMPhNxRUB1HPEppkulGR7WdixVU7auCIsMYXeIm
	 oDm7NjYgr76ST1Q1RXM9nw+iDrTVd9eczuRRZXSesoqN72nFnetwSwrTlEYwCicWo3
	 dcr31Yk7FpfHeP2CVLkqDRMeuOasHkax9zb23GBS9lf2tqN5Hm8qbrgL28kVSr76SD
	 8NFK6OhuqSKOYFVRIjLFhc5cs4L8TBW9hgZWpS3mougFRgv94+MRUenCpI1RXtlYoB
	 GEx+3DW42W2aDZY0B3R8Y0kU2CAEm0pbf5nyuEX7focaJB4+eeJe0urGBYAW7du25e
	 4vlVAAQrqiWww==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next 01/14] bpf: Introduce per-packet metadata
 storage for BPF programs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jakub Sitnicki" <jakub@cloudflare.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260814-bpf-meta-inside-skb-ext-v1-1-767edd862656@cloudflare.com>
References: <20260814-bpf-meta-inside-skb-ext-v1-0-767edd862656@cloudflare.com>
 <20260814-bpf-meta-inside-skb-ext-v1-1-767edd862656@cloudflare.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 15 Aug 2026 08:14:51 +0000
Message-Id: <20260815081451.8817D1F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] bpf_dynptr_from_skb_ext() mutates skb->extensions without synchron=
ization in TRACING and LSM programs, causing data races.
- [High] bpf_dynptr_from_skb_ext() COWs the SKB extension without invalidat=
ing existing dynptr slices in the verifier, leading to a Use-After-Free.
- [High] __bpf_skb_ext_store_bytes() and bpf_skb_ext_pointer() allow lockle=
ss mutation of shared SKB extensions on cloned SKBs.
--

--- Patch [1]: [PATCH net-next 01/14] bpf: Introduce per-packet metadata st=
orage for BPF programs ---
commit e0c430f0cc32850ff4a67d41f0ec463446dca9ae
Author: Jakub Sitnicki <jakub@cloudflare.com>

bpf: Introduce per-packet metadata storage for BPF programs

This commit adds a new sk_buff extension (struct bpf_skb_ext) to provide
up to 256 bytes of per-packet storage for BPF programs. The storage is
exposed to BPF programs via the bpf_dynptr_from_skb_ext() kfunc.

> diff --git a/net/core/filter.c b/net/core/filter.c
> index 16845987b2449..2cbb40b392edd 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -12259,6 +12259,48 @@ int __bpf_skb_meta_store_bytes(struct sk_buff *s=
kb, u32 offset,

[ ... ]

> +int __bpf_skb_ext_store_bytes(struct sk_buff *skb, u32 offset,
> +			      const void *from, u32 len, u64 flags)
> +{
> +	struct bpf_skb_ext *ext;
> +
> +	if (unlikely(flags))
> +		return -EINVAL;
> +
> +	ext =3D skb_ext_find(skb, SKB_EXT_BPF);
> +	if (!ext)
> +		return -ENOENT;
> +
> +	memmove(ext->buf + offset, from, len);

[Severity: High]
Is it safe to directly mutate the extension buffer here without checking if
the SKB is cloned?

If a BPF program creates a writable dynptr, clones the SKB (which increments
the extension's reference count), and then writes to the dynptr, this
memmove() will modify the shared extension block while the cloned SKB might
be executing concurrently on another CPU.

Should this use a mechanism like bpf_try_make_writable() or check
ext->refcnt before mutating to ensure exclusive ownership?

> +	return 0;
> +}
> +#endif /* CONFIG_BPF_SKB_EXT */

[ ... ]

> +__bpf_kfunc int bpf_dynptr_from_skb_ext(struct __sk_buff *skb_, u32 size,
> +					u64 flags,
> +					struct bpf_dynptr *ptr__uninit)
> +{

[ ... ]

> +	ext =3D skb_ext_add(skb, SKB_EXT_BPF);
> +	if (!ext) {
> +		err =3D -ENOMEM;
> +		goto error;
> +	}

[Severity: High]
Could this COW operation lead to a use-after-free if existing dynptr slices
are not invalidated?

If a BPF program obtains a direct slice to a read-only SKB extension via
bpf_dynptr_from_skb_ext() and bpf_dynptr_slice(), and then calls
bpf_dynptr_from_skb_ext() again with BPF_SKB_EXT_F_CREATE, this forces a
Copy-On-Write in skb_ext_add(), dropping the reference on the old block.

However, because KF_bpf_dynptr_from_skb_ext is not added to
bpf_is_kfunc_pkt_changing() in the verifier, clear_all_pkt_pointers() won't
be invoked. The previously obtained slice remains valid in the verifier
state, allowing the program to read or write the freed memory.

> +	if (!exists)
> +		memset(ext, 0, sizeof(*ext));
> +out:
> +	bpf_dynptr_init(ptr, skb, BPF_DYNPTR_TYPE_SKB_EXT, 0, size);

[ ... ]

> @@ -12640,6 +12760,21 @@ static int __init bpf_kfunc_init(void)

[ ... ]

> +	ret =3D ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_NETFILTER, &bpf_=
kfunc_set_skb_ext);
> +	ret =3D ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_LSM, &bpf_kfunc_=
set_skb_ext);
> +	ret =3D ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_TRACING, &bpf_kf=
unc_set_skb_ext);

[Severity: High]
Can calling bpf_dynptr_from_skb_ext() from TRACING or LSM programs cause
data races on the skb structure?

TRACING and LSM programs can intercept an SKB that is currently shared
(skb->users > 1) and being processed concurrently on multiple CPUs.

Since bpf_dynptr_from_skb_ext() unconditionally calls skb_ext_add(), which
performs lockless read-modify-write operations on skb->active_extensions,
concurrent execution could corrupt the bitfield or overwrite the extension
pointer, leaking the allocated extension block.

> +#endif
>  	ret =3D ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_XDP, &bpf_kfunc_=
set_xdp);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260814-bpf-meta-i=
nside-skb-ext-v1-0-767edd862656@cloudflare.com?part=3D1
