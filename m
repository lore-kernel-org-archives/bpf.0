Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEE3C3CFF73
	for <bpf@vger.kernel.org>; Wed,  5 Aug 2026 22:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785970084; cv=none; b=oWIrQNjhRAnh5FwSwRAIe6fRMaPc5dkZ2HokF72MDVpFwfb5dQmY5eG5H9GbehADjpDEyiHu2n/fGuAm0eOz0P+vMI/VDHIJ+Dzyb+6wBebO7e7W2gjY+RzF4ep6UWjpS6rrLHeWA+PvVXCS+/r+nBetY1hPEB/troqgBRUZMQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785970084; c=relaxed/simple;
	bh=RvanfiCL3sK86RRp5fIwHpQhd39NRiBKq/MUdAEzoXM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=AbllSgOytPTFWE6kI6duuixeDfaoRnB4cA6Syjr3YqHxStWeOcIf9xzqoHKLo+JGrqZ4vG1+QrohEeHeB4VTLMMFOXV5M7MO7cF/1+tiUCJaqyQy85RkdbtzxWGLUjTpYstlMWgC34rdEmZ/ILmhifNXzfrfo4OdFHr+f704kdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GUC0TZ96; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GUC0TZ96"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F9711F000E9;
	Wed,  5 Aug 2026 22:48:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785970082;
	bh=GevyTLC74v+V6EDtyCMQ9LlRuX+R2CNSWCClVwGMulA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GUC0TZ96OpDZ71Z9IlDSoGi/R2puyZ3apg6dCXuNrI83wlvlbQncbcmn9iaQbJOqM
	 O7oA+RTQmsYHWAh1cIeJy+4iTfW+FY7RlUM8UN5W9YruZvPbuQmjZppIyFR6EyKBtg
	 2+0WcJcx5OyRWgUISsKYAdEUtQ4oFb7MgLCqbgYRji0fRGnJsCDOoN3R2mQWynbSAV
	 5NcBSGsar1H6s+EjQRUZW9rDm4legEPIxmuK6Lm3tEII4dOuyhe2qKeiK5S7xs2u1k
	 AB4evcKWl1SygKhZSvvM+qONrPqoYVaGNM0mLTGmqGILInLQgig9HF3vhAsHa4MZ7W
	 QVQaeWYhDSxmQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v3 2/2] bpf: htab: Reduce elem_size by 8 bytes
 for small key sizes
Reply-To: sashiko-reviews@lists.linux.dev
To: "T.J. Mercier" <tjmercier@google.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260805223516.1495988-3-tjmercier@google.com>
References: <20260805223516.1495988-1-tjmercier@google.com>
 <20260805223516.1495988-3-tjmercier@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 05 Aug 2026 22:48:01 +0000
Message-Id: <20260805224802.5F9711F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Multi-line comments in the BPF subsystem must have the opening `/*`=
 on its own line.
--

--- Patch [2]: [PATCH bpf-next v3 2/2] bpf: htab: Reduce elem_size by 8 byt=
es for small key sizes ---
commit 9160b7ed8c4c16e32cb4fa06437bbe88f7eb2eea
Author: T.J. Mercier <tjmercier@google.com>

bpf: htab: Reduce elem_size by 8 bytes for small key sizes

This commit optimizes BPF hash tables by eliminating the cached hash value
for maps with small keys. This reduces the element size and key offset for
standard and PCPU maps by up to 8 bytes.

> diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
> index f54366da459f5..9967268d453d0 100644
> --- a/kernel/bpf/hashtab.c
> +++ b/kernel/bpf/hashtab.c

[ ... ]

> @@ -618,6 +625,13 @@ static struct bpf_map *htab_map_alloc(union bpf_attr=
 *attr)
> =20
>  	bpf_map_init_from_attr(&htab->map, attr);
> =20
> +	/* Avoid hash memory use and comparisons where unnecessary.
> +	 * u32 hash reads are always atomic. If we elide them, key comparisons =
must also be atomic
> +	 * to avoid false positive key matches due to torn key reads / writes. =
This is only possible
> +	 * when the key fits within a word, so check key_size.
> +	 */

[Severity: Low]
This isn't a bug, but should this multi-line comment have the opening /* on
its own line to match the BPF subsystem comment style?

> +	htab->has_hash =3D htab_is_lru(htab) || htab->map.key_size > sizeof(uns=
igned long);
> +
>  	if (percpu_lru) {

[ ... ]

> @@ -761,10 +777,22 @@ static struct htab_elem *lookup_elem_raw(struct bpf=
_htab *htab,

[ ... ]

> +	} else {
> +		/* When hash is omitted, key comparisons must be atomic. Zero extend
> +		 * the caller's key to the word size to support an atomic compare.
> +		 */

[Severity: Low]
This isn't a bug, but does this comment format match the preferred multi-li=
ne
style for the BPF subsystem? It typically expects the opening /* to be on a
separate line.

> +		unsigned long k =3D 0;
> +
> +		memcpy(&k, key, key_size);

[ ... ]

> @@ -1188,7 +1226,17 @@ static struct htab_elem *alloc_htab_elem(struct bp=
f_htab *htab, void *key,

[ ... ]

> +	} else {
> +		/* Zero-extend key into k for an atomic write to support
> +		 * lockless RCU readers.
> +		 */

[Severity: Low]
This isn't a bug, but should the opening /* be placed on its own line here =
as
well?

> +		unsigned long k =3D 0;
> +
> +		memcpy(&k, key, key_size);

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260805223516.1495=
988-1-tjmercier@google.com?part=3D2
