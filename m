Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4615286D70
	for <bpf@vger.kernel.org>; Thu, 11 Jun 2026 04:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781153933; cv=none; b=LM1zu9Q24FX0raS+bkr64MArnVTRABbUuB8MJV6FavQ5qBQEmJBxqPaSKvEuLkQCm/s6wShWh/JSZLQa0OaH9HcdrkZIyMmB4eydfw1OMWGQvGrym4Os4uTF7mXswqcguwrRx9chRLDeSoAV+cQGSxERLjbZqQOh5VHwzeOGiBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781153933; c=relaxed/simple;
	bh=tO+z+7og8IDjWZVl/rJCkTDFtT1ydBeBxWlLtfyz4TY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=UQMv8QB+GvcyakyfbNF28QtFSSON3yM5+R9wyuPYASct0FE3eD64IkC7pPE+IKPd52UW9oNfG9da6O2L+IcNT5ahO6wG2qVvHSQfQw9+i5hM5GZhiWKRqzuFLXqfuzDEeHp8OumCChRXh63YIUiYNvkHEcy1wV6RzVjP1El1qUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T94BkOrW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T94BkOrW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A5B71F00898;
	Thu, 11 Jun 2026 04:58:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781153923;
	bh=dEFnHYHfqoE10wg4/QfDl3mT+XnJgev6U+d9aVRx7A8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=T94BkOrWHXBDZH9mZKdimZaDKMjMd4n1BLP+mHvh2OwexAf4rEAsalnZYfsdClYqG
	 2ZOHgrWoq8PsPGVcP1E4GRoLtWa75+SijmY3shO1NlXl24uoloO64/so3II2Xa+Psg
	 z7yaEBceRrl89rPF0qqxlBiWOP/6hwoEqzWruiDwPy7PFoSD53j4YhObw8hZAPYLWv
	 BLBqjDuLiUy5iwZZgK+Wr5TviSgM6E9goP6o/ShReNey55QzkiZ2/JM2zIP0gPkCcQ
	 juPRKupwBg+lF4pv7QSybip1GmAo0DbR9DgO9OYTwFkIVeOzwcmyiMzt6LTcCGXkeJ
	 siREUdlEFyusQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf v3 1/2] bpf: Run generic devmap egress prog on
 private skb
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sun Jian" <sun.jian.kdev@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260611043317.512843-2-sun.jian.kdev@gmail.com>
References: <20260611043317.512843-2-sun.jian.kdev@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 11 Jun 2026 04:58:42 +0000
Message-Id: <20260611045842.7A5B71F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Critical] A maliciously crafted or buggy BPF devmap egress program can c=
ause a double free of an skb by returning an action code that implicitly ca=
sts to a negative integer.
- [High] skb_copy() zeroes out skb->mac_len, causing generic XDP to operate=
 on the wrong skb->data offset and potentially read garbage from uninitiali=
zed headroom.
--

commit b95ebb55a25ce44657b1e9ee2add3b1177f06853
Author: Sun Jian <sun.jian.kdev@gmail.com>

bpf: Run generic devmap egress prog on private skb

This commit introduces a fix to prevent multiple destinations from sharing
the same packet data in generic devmap egress programs by copying cloned
skbs before running the program.

> diff --git a/kernel/bpf/devmap.c b/kernel/bpf/devmap.c
> index cc0a43ebab6b9..14506834345aa 100644
> --- a/kernel/bpf/devmap.c
> +++ b/kernel/bpf/devmap.c
> @@ -512,8 +512,10 @@ static inline int __xdp_enqueue(struct net_device *d=
ev, struct xdp_frame *xdpf,
>  	return 0;
>  }
> =20
> -static u32 dev_map_bpf_prog_run_skb(struct sk_buff *skb, struct bpf_dtab=
_netdev *dst)
> +static int dev_map_bpf_prog_run_skb(struct sk_buff **pskb,
> +				    struct bpf_dtab_netdev *dst)

[Severity: Critical]
The return type here was changed from u32 to int. Because xdp action codes
returned by bpf programs are unconstrained 32-bit unsigned integers, what
happens if a program returns a value with the highest bit set?=20

Could this arbitrary unsigned action code be implicitly cast to a negative
integer, causing callers to mistakenly interpret it as a kernel error?

>  {
> +	struct sk_buff *skb =3D *pskb;
>  	struct xdp_txq_info txq =3D { .dev =3D dst->dev };
>  	struct xdp_buff xdp;

[ ... ]

> @@ -521,6 +523,18 @@ static u32 dev_map_bpf_prog_run_skb(struct sk_buff *=
skb, struct bpf_dtab_netdev
>  	if (!dst->xdp_prog)
>  		return XDP_PASS;
> =20
> +	if (skb_cloned(skb)) {
> +		struct sk_buff *nskb;
> +
> +		nskb =3D skb_copy(skb, GFP_ATOMIC);

[Severity: High]
Does skb_copy preserve the mac_len field?

Because skb_copy allocates a new skb and zeroes out the structure up to the
headers, mac_len is left as 0.

> +		if (!nskb)
> +			return -ENOMEM;
> +
> +		consume_skb(skb);
> +		skb =3D nskb;
> +		*pskb =3D nskb;
> +	}
> +
>  	__skb_pull(skb, skb->mac_len);

[Severity: High]
Following up on the skb_copy question above, if mac_len is 0, will this
pull 0 bytes instead of the expected header length?

If so, the data pointer would remain at the mac header instead of the
network header. If an egress program later modifies the ethernet header
and triggers the mac update path, could this push the data pointer
backwards into uninitialized headroom, leading to protocol corruption
or leaked kernel memory?

[ ... ]

> @@ -710,7 +724,10 @@ int dev_map_generic_redirect(struct bpf_dtab_netdev =
*dst, struct sk_buff *skb,
>  	 * return 0 even if packet is dropped. Helper below takes care of
>  	 * freeing skb.
>  	 */
> -	if (dev_map_bpf_prog_run_skb(skb, dst) !=3D XDP_PASS)
> +	err =3D dev_map_bpf_prog_run_skb(&skb, dst);
> +	if (err < 0)
> +		return err;

[Severity: Critical]
If dev_map_bpf_prog_run_skb returns a negative integer due to an implicitly
cast unsigned action code as mentioned above, will it hit this error path?

If dev_map_bpf_prog_run_skb already dropped the packet via kfree_skb, will
propagating this negative value cause higher level callers to execute their
own error paths and free the identical skb a second time?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260611043317.5128=
43-1-sun.jian.kdev@gmail.com?part=3D1
