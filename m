Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D152F2EB874
	for <bpf@vger.kernel.org>; Fri, 31 Jul 2026 01:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785461701; cv=none; b=Yi91BvgeKAp/CnBQkxbMttMTFumVaGTVmGveZnSwx17jGWHvm71G9s7F7cjvaBx2dyJ+5n8HRrsNJm09sjExNLucec0/WkhaGxDKj6r9ZgNCuWyOpu8KbZ5wM/W5tAvtgmJbY/Ju/JnwZ3HoahspyzKFn0npxYNSjyFcsLxMozg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785461701; c=relaxed/simple;
	bh=ykDBKNBnmx5ovyBdBiQsx2wY+67prha4G4+vltw/80I=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=IfY2COD58M9XgOSufOtH5Jw91A7FKZAK4vPp0RsI/xkzfPzW7JTwfvnJkG4fIOWj/B76TPTgpqc6okx7vaWKZ/ZAfSng7MRiN2MiUn/CZvv3umJwBFOtnoVZYEd5Keg3Na594c9QdgclCmAFFf0WDwTgZpbm0H7kALzZJMgFn6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dj9fleLl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dj9fleLl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D2491F000E9;
	Fri, 31 Jul 2026 01:35:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785461700;
	bh=GjbLMaRYgRpU3CtFbeYHS+CaA2z3C2n67x1c1wIPvvY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Dj9fleLlNX8JfK/XZNWvSyDNeItQmrUuvWx0IW1w7voOAozURaGkKchS2RxQ1Ogjc
	 87i1vDCB9tnu7jSntvHaPebiEA9PeUD4K1q+tWnlXqlGf+K0i+dfuZDe3PfGhyy0+r
	 zAyPIjYrXSd1DUFOW0ncvzXMMceEObmhe6S2BgNXhwKIsoHoN59M/a6rNCARZfqg3u
	 n95p2q+jLxfo8535LH58ZEdDIKAEUgPMADroTgc4PPtFaOkqJRTWAnAIJ+0OTctPeg
	 0RNfSUyxDDgO0Cbk+FiYlrDNObjbwjDF2Xt0d4DYi45El5CHiZ5gjQmdVa0L3Sx1+m
	 zWZoeu51tIVXA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v2 1/2] bpf: htab: Split htab_elem_lru and
 htab_elem_pcpu off of htab_elem
Reply-To: sashiko-reviews@lists.linux.dev
To: "T.J. Mercier" <tjmercier@google.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260731010645.3965783-2-tjmercier@google.com>
References: <20260731010645.3965783-1-tjmercier@google.com>
 <20260731010645.3965783-2-tjmercier@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 31 Jul 2026 01:34:59 +0000
Message-Id: <20260731013500.5D2491F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Multi-line comment does not follow the preferred BPF subsystem styl=
e.
--

--- Patch [1]: [PATCH bpf-next v2 1/2] bpf: htab: Split htab_elem_lru and h=
tab_elem_pcpu off of htab_elem ---
commit d1965b9ee7c9db7418fb306ab2fc480a8cd067d3
Author: T.J. Mercier <tjmercier@google.com>

bpf: htab: Split htab_elem_lru and htab_elem_pcpu off of htab_elem

This commit eliminates per-element memory overhead by splitting the generic
htab_elem structure into dedicated structures for different map types. It
introduces struct htab_elem_pcpu and struct htab_elem_lru, and updates
struct bpf_htab to track a dynamic key offset for element accesses.

> diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
> index 9f394e1aa2e85..f54366da459f5 100644
> --- a/kernel/bpf/hashtab.c
> +++ b/kernel/bpf/hashtab.c
> @@ -117,11 +119,27 @@ struct htab_elem {

[ ... ]

> +struct htab_elem_lru {
> +	struct htab_node node;
> +	struct bpf_lru_node lru_node;
> +	u32 hash;
> +	char key[] __aligned(8);
> +};
> +
> +/* Only for non-preallocated PCPU maps. Preallocated PCPU maps don't need
> + * ptr_to_pptr, and use htab_elem.
> + */

[Severity: Low]
This isn't a bug, but does this multi-line comment violate the modern BPF
subsystem comment style? The BPF guidelines specify that the opening slash
and star should reside on their own line, with the text beginning on the
following line.

> +struct htab_elem_pcpu {
> +	struct htab_node node;
> +	void *ptr_to_pptr;
>  	u32 hash;
>  	char key[] __aligned(8);
>  };

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260731010645.3965=
783-1-tjmercier@google.com?part=3D1
