Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37BD633262A
	for <bpf@vger.kernel.org>; Tue, 28 Jul 2026 03:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785209173; cv=none; b=GU+8tALzrInylRhKnJSgy8UeIBviKCODmIW/e8JfWKjY/I7OIpSlFZ0q+yWF+YaJaHAz4dDgYLDrDh9HT25eEKTZvjduJ8iDOJp+L/lhU2kGpZFMp/r8VY+LJoNnBmpvszv8IDuCN34vZHH4z68/V/u+fAjVUz575MNwojbn5/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785209173; c=relaxed/simple;
	bh=P11G2mDGYceWo458gdza8GwsK6XaomEOxMETj5cPluE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=IozdRJNK7ijjydJpWzPGSNW6VE3FaEUg/Gcij7H/yPYtBJPgS5x/IjBHLEnPi+1Q4zoZYvJzGRD96Metk7ztD2pk6urc79ru1objULhrR6lVc1GUzyAc42n0aY/TZ9gnZCwz3K5mCWjLf5feWYQz1xRdD+8IOG2Nlb5h3ky6v+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k7CdfJEd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k7CdfJEd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA2001F00A3E;
	Tue, 28 Jul 2026 03:26:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785209172;
	bh=J4+5lVMI2zEVPfUdEtffnjMl7TtlL3QXJAPfejIQd9Y=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=k7CdfJEdQjxWzdvBdpLwfR9VMSDxN/PYb7N7uHu+ymbQEihzPM/NhaBeNvRWbNOLu
	 5ciOBJet1vqRdKZAhKMmMikBSuxk/291iOnShiw4GwnAC+VhfHx0WyG5v2pgun9wp1
	 Y/RQedkjZ5khsu40VoNXE2b+FYTL50+xgzVlSq5iUh0I/A9C/C3eHhU34WXISr62ea
	 zByKoFom06Xkn7kxT1UN4zxASBQdMbq9qiD07pWabODH3UT3VTO7nEsc0HInbhYKZy
	 BwtcyL+Cx6xOKDnZHL4oSsi36/QalFMoSwepHmf0YtWZFEOMSb3YoBIJTiyzsv6W88
	 naNsQJvL/hyGg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net 2/2] veth: fix skb length accounting after XDP frag
 adjustment
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sun Jian" <sun.jian.kdev@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260727032535.13469-3-sun.jian.kdev@gmail.com>
References: <20260727032535.13469-1-sun.jian.kdev@gmail.com>
 <20260727032535.13469-3-sun.jian.kdev@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 28 Jul 2026 03:26:11 +0000
Message-Id: <20260728032611.EA2001F00A3E@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Incorrect ordering of SKB length synchronization and manipulation =
helpers causes BUG_ON() panics in __skb_put and __skb_pull.
--

--- Patch [2]: [PATCH net 2/2] veth: fix skb length accounting after XDP fr=
ag adjustment ---
commit 7bca8b2841500975db8d1e89e6bd51e147aa4ad3
Author: Sun Jian <sun.jian.kdev@gmail.com>

veth: fix skb length accounting after XDP frag adjustment

This commit fixes an issue where veth_xdp_rcv_skb() left skb->len containing
stale fragment sizes after an XDP program adjusted the fragment area. It
subtracts the old data_len before replacing it and adds the new data_len
afterwards to keep skb->len and skb->data_len synchronized.

Link: https://lore.kernel.org/r/20260720141859.19FF41F000E9@smtp.kernel.org
Link: https://lore.kernel.org/bpf/al9T9Eto%2FhRIzP5W@boxer/

> diff --git a/drivers/net/veth.c b/drivers/net/veth.c
> index 00e34afd858e7..a956498a073be 100644
> --- a/drivers/net/veth.c
> +++ b/drivers/net/veth.c
> @@ -871,12 +871,14 @@ static struct sk_buff *veth_xdp_rcv_skb(struct veth=
_rq *rq,
>  		__skb_put(skb, off); /* positive on grow, negative on shrink */

[Severity: High]
This is a pre-existing issue, but can this sequence of SKB length
synchronizations trigger a kernel panic due to the order of operations?

If an XDP program modifies a fragmented packet, veth_xdp_rcv_skb() adjusts
the head and tail before syncing skb->data_len:

    if (off < 0)
        __skb_pull(skb, -off);
    ...
    if (off !=3D 0)
        __skb_put(skb, off); /* positive on grow, negative on shrink */

If the XDP program shrinks the tail past the fragments, __skb_put() is call=
ed
with a negative offset while skb->data_len is still non-zero. Doesn't this
trigger SKB_LINEAR_ASSERT if CONFIG_DEBUG_SG is enabled?

Likewise, if the program shrinks the head (triggering __skb_pull() before
updating skb->data_len), could skb->len drop below the stale skb->data_len
value? This would hit the unconditional BUG_ON(skb->len < skb->data_len)
inside __skb_pull() and cause a denial of service.

Would it make sense to synchronize skb->data_len and skb->len before calling
__skb_pull() and __skb_put()?

> =20
>  	/* XDP frag metadata (e.g. nr_frags) are updated in eBPF helpers
> -	 * (e.g. bpf_xdp_adjust_tail), we need to update data_len here.
> +	 * (e.g. bpf_xdp_adjust_tail), update skb length fields here.
>  	 */
> +	skb->len -=3D skb->data_len;
>  	if (xdp_buff_has_frags(xdp))
>  		skb->data_len =3D skb_shinfo(skb)->xdp_frags_size;
>  	else
>  		skb->data_len =3D 0;
> +	skb->len +=3D skb->data_len;
> =20
>  	skb->protocol =3D eth_type_trans(skb, rq->dev);
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260727032535.1346=
9-1-sun.jian.kdev@gmail.com?part=3D2
