Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9772345CCA
	for <bpf@vger.kernel.org>; Tue, 21 Apr 2026 09:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776764424; cv=none; b=hf6NdDbR4qk8aRSmIXX+hEcjtlMPvemzJQ52HxwN3WBdmrSFjO6h+QPzzA+3SINyOCD4WaaSzYJs0F8lS3Ve0BGBqrOxmRpTFitdFdSO6W3hCnZo5XwFe9Ls1E4xWAzEF35v7GG98hr9ksA1IjjsqCEE6mCZT9GvVnjvBjTdpCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776764424; c=relaxed/simple;
	bh=tCDC2/9iRtOMmve+brU/ALMcLIFTP5+b8sbRLrQ1Y8o=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=XQLs0YS3Tg3Rzjggb0+6zE8Alnbn9LloTvCb8fO+ZxJ5BAzzEN5XbuI1U6CXoBCu09+3OHNHxSdZoYPvIeyM48WuHUrTMaA92sAij5XYLbBCEHdvFyMxrlUWCQSBH2i5wpMwZOsIFF+gvss1czL5kBShahyJoZBwXOTn8Trt01w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jDJK2nam; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jDJK2nam"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E8EBC2BCB0;
	Tue, 21 Apr 2026 09:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776764424;
	bh=tCDC2/9iRtOMmve+brU/ALMcLIFTP5+b8sbRLrQ1Y8o=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=jDJK2namcG8hswqf2wNB3vSpB9M4A21F54KIZ79mubZ0Ca04UuzESkx16CbyyBiRz
	 i8gp8hGgKIV4JPg8wIUuP5+6JgF82LSVbzNNO9oaG1ehrvLOuzx5kQSZd2zku0v8kc
	 BantpWScbKzk1FmmxnSe2sVTvxaMITE2mvGSNMuk6pPEQMYF1U3M7JW81XSmv+U7+0
	 3tPUhBAQMXIGQA4qTTs9CkwajGvsnKvTWnPN37LgNo37ZlSIflvUcXW82k5Eyaq54l
	 9Tq9n1PHzMhqqm0X0mQyzvP/RxNttO9UTxmDWmGdtqLTuYkN/LZ4i/MA97JQ9tuQAz
	 lt8599JX6e9cQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v2 3/8] xsk: fix use-after-free of xs->skb in
 xsk_build_skb() free_err path
Reply-To: sashiko@lists.linux.dev
To: "Jason Xing" <kerneljasonxing@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260420082805.14844-4-kerneljasonxing@gmail.com>
References: <20260420082805.14844-4-kerneljasonxing@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 21 Apr 2026 09:40:23 +0000
Message-Id: <20260421094024.5E8EBC2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Sashiko AI review found 1 potential issue(s):
- [Critical] Dangling `xs->skb` pointer on `-EOVERFLOW` error path leading =
to Use-After-Free.
--

commit 4ce0cecf5e8e18bd369c02242f70a42cc8fbdf03
Author: Jason Xing <kerneljasonxing@gmail.com>

xsk: fix use-after-free of xs->skb in xsk_build_skb() free_err path

This commit aims to fix a use-after-free in the xsk_build_skb() error
handling path by ensuring we only free newly allocated skbs when a
continuation descriptor fails. It prevents freeing an in-progress
multi-buffer skb by adding a check for !xs->skb before kfree_skb(skb).

Link: https://lore.kernel.org/all/20260415082654.21026-4-kerneljasonxing@gm=
ail.com/

> diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> --- a/net/xdp/xsk.c
> +++ b/net/xdp/xsk.c
> @@ -969,7 +969,7 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock =
*xs,
[ ... ]
>  free_err:
> -	if (skb && !skb_shinfo(skb)->nr_frags)
> +	if (skb && !xs->skb && !skb_shinfo(skb)->nr_frags)
>  		kfree_skb(skb);
> =20
>  	if (err =3D=3D -EOVERFLOW) {

Does this patch leave a use-after-free on the -EOVERFLOW error path?

When xsk_build_skb() handles a continuation descriptor and encounters an
-EOVERFLOW error, it jumps to free_err and enters this block. Looking at the
subsequent code in xsk_build_skb():

	if (err =3D=3D -EOVERFLOW) {
		if (xs->skb) {
			/* Drop the packet */
			xsk_inc_num_desc(xs->skb);
			xsk_drop_skb(xs->skb);
		} else {

The xsk_drop_skb(xs->skb) call consumes and frees the socket buffer, but
xs->skb is never set to NULL.

Because xsk_build_skb() returns ERR_PTR(-EOVERFLOW), the caller
__xsk_generic_xmit() intercepts this error and continues its transmission
loop without aborting.

On the next iteration, __xsk_generic_xmit() would pass the dangling xs->skb
pointer back into xsk_build_skb(), which will dereference the freed memory
when checking skb_shinfo(skb)->nr_frags.

Should xs->skb be cleared to NULL after calling xsk_drop_skb() here?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260420082805.1484=
4-1-kerneljasonxing@gmail.com?part=3D3
