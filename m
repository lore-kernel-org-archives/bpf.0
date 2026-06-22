Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C56E83815DD
	for <bpf@vger.kernel.org>; Mon, 22 Jun 2026 07:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782115101; cv=none; b=ZI5tflItc7V91C8Oe+/GduTThEawjvzkkPCFCexswYf4bf1N41Z/Vu0p9A5PYkgEYk3Rc79XBphjZkpTdJz5eKRjvz9Wayj5O3rrmJiwWOWuu001XLf3TB5Z3ouyDCoSViQhGpJpHUk4J9/0keYp7HHqANe8qlE12CQNIaJ3umo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782115101; c=relaxed/simple;
	bh=E3OKjRDoXQzViSHSylAsdvIYIyC9ojF1peT2kz3UufY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=FC1lhuVqXWZi+3Hqv0LlUQFtHNXser7IxZoHUYYsqHojj2/bYYkwoh8tuAfP0zozn5ay+xAdGOxcPryEdEPHdrm78uGN8iNFa8jx+mGNjRSsfGIuy4O1AZBvkSpZ2My/dqya1NYtsQZub3YHaqlCfstCSSz+nZv9REwLSV/1S3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TONicnRc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TONicnRc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DB331F000E9;
	Mon, 22 Jun 2026 07:58:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782115100;
	bh=rUzVkMvyTjZ6Z6nyfpeeoBRWDswyKNItPegVrlx+LgE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TONicnRcAYb5H2AVn0/JoimfcEOC81ypOFJc4wUNV2YxTI0Qfn/0/gAeFfAotkXp5
	 oykp4rgJ7UzxWMKsYDQoH8v2N5YVwFC8zI9Ws4hQXZR5A3TV/Du0eTanawpvEczkzY
	 TwaXOtWGw0jSshwsclrm6rMhlpkDDITC7T68pYoFS/VJ27hoYzc2uBHqk7UFUUh3YS
	 2T7o+1zGTetWSzX2/VSocfnWXbh1gdwq8d36S9s88YJRuO+A4Kv7qhCFgXMCG/B/fF
	 J399pWofy8TpU2TA7Sj0B05+RBVOby+Fumh1RhHYV59RMcoHyz8PuDo1luyJgh7uxd
	 bcYelsKCarzPw==
From: sashiko-bot@kernel.org
Subject: Re: [RFC bpf-next 2/3] bpf: implement compare-and-delete
 (BPF_F_COMPARE) for BPF_MAP_TYPE_HASH
Reply-To: sashiko-reviews@lists.linux.dev
To: "Gyutae Bae" <gyutae.opensource@navercorp.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260622071649.31541-3-gyutae.opensource@navercorp.com>
References: <20260622071649.31541-1-gyutae.opensource@navercorp.com>
 <20260622071649.31541-3-gyutae.opensource@navercorp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 22 Jun 2026 07:58:20 +0000
Message-Id: <20260622075820.7DB331F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] BPF_MAP_DELETE_ELEM no longer validates that the `value` field is =
zero, silently allowing uninitialized garbage and breaking BPF's strict UAP=
I zero-initialization guarantees.
--

commit 513ae67888e0e87d8de22021be59f6117444ee43
Author: Gyutae Bae <gyutae.bae@navercorp.com>

bpf: implement compare-and-delete (BPF_F_COMPARE) for BPF_MAP_TYPE_HASH

This commit introduces the BPF_F_COMPARE flag for map_delete_elem(), allowi=
ng
atomic compare-and-delete operations on hash maps. It adds a new map operat=
ion
and updates the syscall handler to process the new compare fields.

> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
[ ... ]
> @@ -1892,18 +1892,30 @@ static int map_update_elem(union bpf_attr *attr, =
bpfptr_t uattr)
>  	return err;
>  }
> =20
> -#define BPF_MAP_DELETE_ELEM_LAST_FIELD key
> +#define BPF_MAP_DELETE_ELEM_LAST_FIELD compare_size
> =20
>  static int map_delete_elem(union bpf_attr *attr, bpfptr_t uattr)
>  {
>  	bpfptr_t ukey =3D make_bpfptr(attr->key, uattr.is_kernel);
>  	struct bpf_map *map;
> -	void *key;
> +	void *key, *compare =3D NULL;
> +	u32 off =3D 0, size =3D 0;
>  	int err;
> =20
>  	if (CHECK_ATTR(BPF_MAP_DELETE_ELEM))
>  		return -EINVAL;
> =20
> +	if (attr->flags & ~BPF_F_COMPARE)
> +		return -EINVAL;
> +
> +	/* The compare* fields are meaningful only with BPF_F_COMPARE.  Reject =
them
> +	 * when the flag is absent so a dropped BPF_F_COMPARE cannot silently t=
urn a
> +	 * compare-and-delete into an unconditional delete.
> +	 */
> +	if (!(attr->flags & BPF_F_COMPARE) &&
> +	    (attr->compare || attr->compare_offset || attr->compare_size))
> +		return -EINVAL;

[Severity: High]
Does changing BPF_MAP_DELETE_ELEM_LAST_FIELD to compare_size bypass
zero-validation for attr->value?

CHECK_ATTR now only validates that fields after compare_size are zero.
The patch manually adds validation for flags and the compare* fields to ens=
ure
they are zero when not in use, but it does not appear to add a similar check
for attr->value.

Could this allow userspace to pass uninitialized stack garbage in the value
field without being rejected, permanently preventing the safe repurposing of
the value field for future BPF_MAP_DELETE_ELEM extensions?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260622071649.3154=
1-1-gyutae.opensource@navercorp.com?part=3D2
