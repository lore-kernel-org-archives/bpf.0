Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97693BA34
	for <bpf@vger.kernel.org>; Sun, 19 Apr 2026 04:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776574703; cv=none; b=CxIutL/OA7BV6FOW3sQYAoSv75QwFsN1pJJk1dKwMrsa3uGTXx91neLdWCPDQaxvDa0mai61NtIZco9CW8f13q5V5M7C1JI56Pt94hmAelJRP+4Z+EJ9x75G2x8hq8GPgBM6Ssz3CsCJQS22X/JBFihJKcva8pWZLVfZkcabd+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776574703; c=relaxed/simple;
	bh=/+u6SPUA+ZRwwpgT3SHopMQaXRtDCxpat3/t6zcgicE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=eWOEbIs7Wb0tQ3trgcb8c9lAlW7S6vV5i5D2WwU56Up3dlNgCUnsdE3hITrK4p5n3D6FFc5BTDOoAafkhI0igM+FaXgDd1cl9lB4ZWDFLUVoG3bPy9HEtQ5JnRhGUCBxLDXoDh+mXvY4W8WPh237KNKgOmpaiuQwqD1qURgJY/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M3R6+zwC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M3R6+zwC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 417A4C2BCB8;
	Sun, 19 Apr 2026 04:58:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776574703;
	bh=/+u6SPUA+ZRwwpgT3SHopMQaXRtDCxpat3/t6zcgicE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=M3R6+zwCgbAP28bX42K1bskhSKJV24B14I1pIKlO2LF07wi7B8M9mFyddE9S/gAF3
	 GXb/oyYXUu3ciyGt4K6LhQnSzu47koHjo6MhheeoyuanZTIEGZQBzhuRNwVTuTRBtr
	 XZ7RLetprmo6fo9l4HjnsTIvYIXqSyfumo5wdkaH3sqecDc90UPqMUycAFTF0OC9eG
	 6r4VOlU1XWYA3HYSpqCxmA0Gi/U4eHJ77zXsdUrUBH6PcC9Ln5lLUvt5WfDYD3ihSc
	 bKh2NNNOM6wCgsvwDeqyuKu/5z9rmpVdhFLyTVEp6u7fxYYYqL09fgvlqqbxfy/Etw
	 SATl/z71fsMUQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net 2/4] xsk: free the skb when hitting the upper bound
 MAX_SKB_FRAGS
Reply-To: sashiko@lists.linux.dev
To: "Jason Xing" <kerneljasonxing@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260418045644.28612-3-kerneljasonxing@gmail.com>
References: <20260418045644.28612-3-kerneljasonxing@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 19 Apr 2026 04:58:22 +0000
Message-Id: <20260419045823.417A4C2BCB8@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Sashiko AI review found 2 potential issue(s):
- [High] The patch leaves a guaranteed NULL pointer dereference in the call=
er's error handling path when `-EOVERFLOW` is returned for the first fragme=
nt.
- [High] Calling `kfree_skb(skb)` directly triggers the packet destructor a=
nd incorrectly submits the dropped packet to the userspace Completion Queue=
 (CQ).
--

commit e5bfaac263557abd44f47ec6e9c85e50c7aa1efc
Author: Jason Xing <kerneljasonxing@gmail.com>

    xsk: free the skb when hitting the upper bound MAX_SKB_FRAGS

This commit explicitly frees the skb when the MAX_SKB_FRAGS limit is hit
on the first descriptor to avoid a memory leak.

> diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> index 5b273bcd0dbce..3d6c6caa7ff82 100644
> --- a/net/xdp/xsk.c
> +++ b/net/xdp/xsk.c
> @@ -858,8 +858,11 @@ static struct sk_buff *xsk_build_skb_zerocopy(struct=
 xdp_sock *xs,
>  	addr =3D buffer - pool->addrs;
> =20
>  	for (copied =3D 0, i =3D skb_shinfo(skb)->nr_frags; copied < len; i++) {
> -		if (unlikely(i >=3D MAX_SKB_FRAGS))
> +		if (unlikely(i >=3D MAX_SKB_FRAGS)) {
> +			if (!xs->skb)
> +				kfree_skb(skb);

If we free the newly allocated skb here and return -EOVERFLOW, the caller
xsk_build_skb() catches the error and jumps to free_err, where it calls:

    if (err =3D=3D -EOVERFLOW) {
        /* Drop the packet */
        xsk_inc_num_desc(xs->skb);

Since xs->skb is still NULL, will this cause xsk_inc_num_desc() to
dereference a NULL pointer?

Note that this regression appears to be fixed in a later commit 1c728000f88=
4c
("xsk: handle NULL dereference of the skb without frags issue").

Additionally, does calling kfree_skb(skb) here trigger the packet destructor
and incorrectly submit the dropped packet to the userspace completion queue?

Prior to entering the fragmentation loop, xsk_skb_init_misc() sets the
destructor to xsk_destruct_skb(). When kfree_skb(skb) is called, it invokes
this destructor, which sequentially calls xsk_cq_submit_addr_locked().

This writes the descriptor address to the completion queue and advances the
user-visible q->ring->producer pointer, falsely notifying userspace of a
successful transmission.

The caller xsk_build_skb() then executes its own error handling, calling
xsk_cq_cancel_locked(), which only decrements the kernel's internal
q->cached_prod counter.

Could this desynchronize the internal queue tracking variables from the
shared memory ring pointers?

Should the destructor be changed back to sock_wfree before freeing it,
similar to how xsk_consume_skb() handles it?

>  			return ERR_PTR(-EOVERFLOW);
> +		}
> [ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260418045644.2861=
2-1-kerneljasonxing@gmail.com?part=3D2
