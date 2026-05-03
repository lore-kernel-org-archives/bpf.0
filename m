Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9866A386C1C
	for <bpf@vger.kernel.org>; Sun,  3 May 2026 20:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777838964; cv=none; b=S2gasB3CsNIkHSkZy5PwLwMfza6ylIAnh6DfHEW/vs+8MlRdg8b0Hn956MSzGHh8neUrfGaAybPRFS+xrBKi/oApIIL3DRVAgAXvwVQnylk5sVS/ja95lUjUt/oNXFIdbRg28/pDesT5q6/gJstF/g81O7uzByf0rd42LQ2yvvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777838964; c=relaxed/simple;
	bh=aZnJViAu9EYZ4FO8d84Vvr/oKenhObRD5JWAjJh3GA0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=koY+tJ7n/p5Gc3Pf4R4UqN1uqNeY4LSuMT9PndoNOM/49vBn45//wiM22BdBxH7OwpjOhTF54KKgGiVqwKtl7vp9dzx+5qNs+XazaYl+fQY7domTlO+kof/wICKRFFOY17kNtzhRrnhcGhl1aSyXR4ME6+b4NgRul6LIIIU9ifE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EXvs2L1+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EXvs2L1+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EE32C2BCF4;
	Sun,  3 May 2026 20:09:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777838964;
	bh=aZnJViAu9EYZ4FO8d84Vvr/oKenhObRD5JWAjJh3GA0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=EXvs2L1+TwIrHVZuKBQohyQnTUExzfWiZueBAQVObYhml+7Y0f9Sv5YH2jSmrU2SK
	 eXcHdtOCcUdA01NY5yMKJPxdz1bEHEgtXP1rA2txKQQJ9lt0ObnHSEHfYVtOTgMOWT
	 Z0TzaVJQfiCVcDm5KeNWfn8hQQh3rT0CRxzMCbTz+Ya0n95yu+DNEhiPruhrBKXuSb
	 0TQv7LpIInzz6VbyA+4XCVcNnB+Gylt4V1o9KSVOUUVMzoCw9uyZURGlLlARvRYejE
	 flqxBYEKY2ahvWPokFgioGuw8icI+XwBdGD1N4rN7CpwH6pFCVAxDcJIXoiYsleAAG
	 56n7XYKDnbs2A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v5 2/8] xsk: free the skb when hitting the upper
 bound MAX_SKB_FRAGS
Reply-To: sashiko@lists.linux.dev
To: "Jason Xing" <kerneljasonxing@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260502200722.53960-3-kerneljasonxing@gmail.com>
References: <20260502200722.53960-3-kerneljasonxing@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 03 May 2026 20:09:23 +0000
Message-Id: <20260503200924.4EE32C2BCF4@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Critical] This problem wasn't introduced by this patch, but returning -E=
OVERFLOW when xs->skb is NULL leads to an unconditional NULL pointer derefe=
rence in the caller's error path.
- [High] Calling kfree_skb(skb) directly on a partially built SKB triggers =
the custom XSK destructor, which incorrectly submits the failed descriptor =
to the AF_XDP completion queue.
- [High] This problem wasn't introduced by this patch, but an identical SKB=
 memory leak exists when xsk_skb_metadata() fails.
--

commit cf402952a5ccf9981b4749df15227be947716b0d
Author: Jason Xing <kerneljasonxing@gmail.com>

xsk: free the skb when hitting the upper bound MAX_SKB_FRAGS

This patch explicitly adds kfree_skb() before returning -EOVERFLOW to
its caller when hitting the MAX_SKB_FRAGS limit on a newly allocated
SKB. This prevents the SKB from being permanently leaked.

> diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> index 887abed25466..d706b1e0bf60 100644
> --- a/net/xdp/xsk.c
> +++ b/net/xdp/xsk.c
> @@ -856,8 +856,11 @@ static struct sk_buff *xsk_build_skb_zerocopy(struct=
 xdp_sock *xs,
>  	addr =3D buffer - pool->addrs;
> =20
>  	for (copied =3D 0, i =3D skb_shinfo(skb)->nr_frags; copied < len; i++) {
> -		if (unlikely(i >=3D MAX_SKB_FRAGS))
> +		if (unlikely(i >=3D MAX_SKB_FRAGS)) {
> +			if (!xs->skb)
> +				kfree_skb(skb);

Does calling kfree_skb() directly here incorrectly trigger the custom
XSK destructor for a dropped packet?

Earlier in xsk_build_skb_zerocopy(), the newly allocated SKB is initialized
via xsk_skb_init_misc(), which explicitly sets skb->destructor =3D
xsk_destruct_skb.

When xsk_destruct_skb() runs, it calls xsk_cq_submit_addr_locked(), which
erroneously generates a spurious TX completion for userspace and bypasses
the queue's cached_prod reservation state, corrupting the completion queue
logic.

Should the destructor be cleared first to safely discard the partially
built SKB?

Note that this regression was fixed later in the patch series by commit
88b75ff1d12b ("xsk: prevent CQ desync when freeing half-built skbs in
xsk_build_skb()").

This problem wasn't introduced by this patch, but can returning -EOVERFLOW
when xs->skb is NULL cause a NULL pointer dereference in the caller's error
path?

In the caller xsk_build_skb(), the local skb pointer is set to NULL, and
execution jumps to the free_err label. Because err =3D=3D -EOVERFLOW, the e=
rror
handler unconditionally calls:

	xsk_inc_num_desc(xs->skb);
	xsk_drop_skb(xs->skb);

Since xs->skb is strictly NULL, these functions will immediately dereference
the NULL pointer via skb_shinfo(NULL) inside xsk_skb_destructor_is_addr(),
causing a panic.

Note that this regression was fixed later in the patch series by commit
819a57cd3753 ("xsk: handle NULL dereference of the skb without frags
issue").

This problem wasn't introduced by this patch either, but is there an
identical SKB memory leak earlier in this function when xsk_skb_metadata()
fails?

If desc->options & XDP_TX_METADATA is set and xsk_skb_metadata() fails,
the function returns ERR_PTR(err) directly without freeing the newly
allocated skb:

	xsk_skb_init_misc(skb, xs, desc->addr);
	if (desc->options & XDP_TX_METADATA) {
		err =3D xsk_skb_metadata(skb, buffer, desc, pool, hr);
		if (unlikely(err))
			return ERR_PTR(err);
	}

The caller xsk_build_skb() explicitly overrides its local skb pointer to
NULL before jumping to free_err, causing this SKB to be permanently leaked.

An unprivileged user could trigger this leak by providing malformed
metadata, leading to memory exhaustion.

Note that this regression was fixed later in the patch series by commit
f1079e939977 ("xsk: avoid skb leak in XDP_TX_METADATA case").

>  			return ERR_PTR(-EOVERFLOW);
> +		}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260502200722.5396=
0-1-kerneljasonxing@gmail.com?part=3D2
