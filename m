Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E6CB2ECEAE
	for <bpf@vger.kernel.org>; Sun, 19 Apr 2026 04:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776574704; cv=none; b=LBx9RFHAL4rvpLqrBy2qZrsSRm8C72H8N9foBMsMMMUgc96nL2sw8QyfMc99leSclP8gM5QC9r9fvFj1LpbXIHKctYVAWRoBomKSLEVPbMHO7D78QF6FDC+qCExY3S0k/7ZkEMiq2D5jkqFsBF6QJiWZ9qwQy2vdwkUGqYz4xN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776574704; c=relaxed/simple;
	bh=Y8enpvDedvqSjn1eHoARJe3ZBX2XZixtD6IlshKAt0E=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=tNer5qzCJf7DQJr3z9KKJXvJjD9qKYDhjrWvoiwowAmxz8q7ZoF8QPhMBohf260mvnBtV93j/YVc9UJS39ueuJ8jGJfTUTsP9Wv+8tvFL4Qy6F80eYFbGoVNOgR7+TAf0ZCDmKX4FiHLeXNbJEb9Or8LJzYIitPFzNDmM1S4rOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mmddhfdX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mmddhfdX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0402FC2BCAF;
	Sun, 19 Apr 2026 04:58:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776574704;
	bh=Y8enpvDedvqSjn1eHoARJe3ZBX2XZixtD6IlshKAt0E=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=mmddhfdXMKIZFchWkebBQne3/2UwdhvIeBJ+fsCLjXbRXzvC418EGCYsa3rigk9kH
	 4lTRTjL9pC0NB8KjtUcTFvelz25PJiW5+yw3zrd2CgXuTjTFzTvBHcD/MhCDuwFpA6
	 NnUb9jw37KBZklDOktMO6d/cc/4JEcsFZeCLhxHYWelM/UeewCxzpMBzA7XCqsyRT2
	 fRU+GsdqKChTt4//Vz8SHqGte8oGa6eHkZyAt1pnrgGdtmsq9Gh1X8jfn8ky/Vn/xv
	 P2mxoytYLoS6u74mXnhZhcEzs79bAE7HRL7b9ZjVgTPTWtNe9vDJlX14ZHdC56pYCH
	 FTWOIvel9u2hg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net 3/4] xsk: handle NULL dereference of the skb without
 frags issue
Reply-To: sashiko@lists.linux.dev
To: "Jason Xing" <kerneljasonxing@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260418045644.28612-4-kerneljasonxing@gmail.com>
References: <20260418045644.28612-4-kerneljasonxing@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 19 Apr 2026 04:58:23 +0000
Message-Id: <20260419045824.0402FC2BCAF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Sashiko AI review found 2 potential issue(s):
- [Critical] Calling `kfree_skb(skb)` without clearing the SKB destructor c=
auses Completion Queue (CQ) ring corruption and false completions.
- [High] Use-after-free of `xs->skb` in the continuation path when an error=
 like `-EAGAIN` occurs.
--

commit 1c728000f884ce0a536d9c1fd763eb0c560ada51
Author: Jason Xing <kerneljasonxing@gmail.com>

xsk: handle NULL dereference of the skb without frags issue

This commit addresses a NULL pointer dereference in the error path of
xsk_build_skb_zerocopy() by checking if xs->skb is valid before
dereferencing it during -EOVERFLOW handling. It also adds an alternative
branch to handle bookkeeping for the first-descriptor case.

> diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> index 3d6c6caa7ff82..2f00f188533c1 100644
> --- a/net/xdp/xsk.c
> +++ b/net/xdp/xsk.c
> @@ -978,9 +978,14 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock=
 *xs,
>  		kfree_skb(skb);

Can this lead to a use-after-free on xs->skb?=20

In the non-zerocopy path, if the first descriptor is linear, nr_frags remai=
ns
0 and the caller __xsk_generic_xmit() stores the SKB in xs->skb.

During the next iteration for a continuation descriptor, if an error like
-EAGAIN occurs (e.g., from alloc_page()), the code jumps to the free_err
label. The cleanup logic if (skb && !skb_shinfo(skb)->nr_frags) would
evaluate to true, freeing the entire SKB.

The function then returns -EAGAIN, leaving the freed SKB pointer in xs->skb.
On the next application retry, the code could dereference the freed xs->skb.

Note that this regression is fixed later in the patch series by commit 'xsk:
fix use-after-free of xs->skb in xsk_build_skb() free_err path'.

Also, could calling kfree_skb(skb) without clearing the SKB destructor cause
Completion Queue (CQ) ring corruption and false completions?

In xsk_build_skb_zerocopy(), xsk_skb_init_misc() sets
skb->destructor =3D xsk_destruct_skb. When an error occurs on the first
descriptor (e.g., xsk_skb_metadata() returning -EINVAL), kfree_skb(skb) is
called.

Because the destructor is not overridden with sock_wfree (like
xsk_consume_skb() does), kfree_skb(skb) triggers xsk_destruct_skb(), which
submits the descriptor to the CQ and increments q->ring->producer.

>  	if (err =3D=3D -EOVERFLOW) {
> -		/* Drop the packet */
> -		xsk_inc_num_desc(xs->skb);
> -		xsk_drop_skb(xs->skb);
> +		if (xs->skb) {
> +			/* Drop the packet */
> +			xsk_inc_num_desc(xs->skb);
> +			xsk_drop_skb(xs->skb);
> +		} else {
> +			xsk_cq_cancel_locked(xs->pool, 1);
> +			xs->tx->invalid_descs++;
> +		}
>  		xskq_cons_release(xs->tx);
>  	} else {
>  		/* Let application retry */
>  		xsk_cq_cancel_locked(xs->pool, 1);
>  	}

The error handling paths then call xsk_cq_cancel_locked(), which decrements
the reservation counter q->cached_prod.

Does decrementing the reservation while the actual producer pointer has
advanced break queue accounting?

The kernel calculates available space using cached_prod; this artificial
underflow could cause the queue to over-report free space, allowing the
producer to silently overwrite unread user-space CQ entries.

Furthermore, in the -EINVAL path, does the invalid descriptor generate a
false completion to user space without being released from the TX ring? When
the application reuses the completed buffer, could the kernel retransmit the
same descriptor on retry, causing a use-after-free and data corruption?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260418045644.2861=
2-1-kerneljasonxing@gmail.com?part=3D3
