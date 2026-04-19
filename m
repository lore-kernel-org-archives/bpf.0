Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 311082ECEAE
	for <bpf@vger.kernel.org>; Sun, 19 Apr 2026 04:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776574703; cv=none; b=BzLowGhu+uHWtB6oG87Bu11ssgawO48DnhlzbyZyuOarHSLYP8tRxiEInbjO+uRQ5ryp+YTiN2W22qWSMRLHnqHcQT+dvjf77ADy0KDqlIbymk191u546MLInNnBrFTtqxxjyMxbqywpG/zLBqQe/87GlExClbSuv6Qwznuk178=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776574703; c=relaxed/simple;
	bh=kAHt0VRKUBGly4C0MnKTtlqV3Up5JnpjWodwwp+TeAA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=VqxOPAlbZ41QauqgtQ/5/jWnRlsRbBZr35UvACWUraPHtDAG/2KIbbZKDhg7UWztTWo1+eRL4y1bgGUCoo/KuqZGHWc1HTzat2S6AO1+lhBvHeBFj6CobpwkCT/Ufk94MoNPtBLRZNUoCBG4LDsVsxhNgjD5Gs3zbaIEieZn9aY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qAF7TBYZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qAF7TBYZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 843BFC2BCAF;
	Sun, 19 Apr 2026 04:58:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776574702;
	bh=kAHt0VRKUBGly4C0MnKTtlqV3Up5JnpjWodwwp+TeAA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=qAF7TBYZTV9t8m0STqYkNlju1c3w5s8Nvir+gZca0RWhEZhWKzcW6T282bIpfQ1CI
	 iQkIhvYpIFnveMRl3TJtwU3zFHrpeewTp1vm6MyVIAbT0Zr3z1bd7tADGdqQjnVqC3
	 JLuqWAB0IQtqAknkq1YKGL+2kqQecSbqIw1sxCdFYStVRR4dnSlgZYpqHBXVxOV+cJ
	 H1KUBovFzOc6rYulqlL/6Xvq3/Y4n/OX+6QnRXIh/BwmvgEPak/MZkkWcOGM/qp2hM
	 P7UpCDKo3VHhysHzNO5/hCxVBd4QZxgakRnS5A3BwuRJx5IuoBCtavyBqNq5o71WPI
	 Ia2VsZHSjynEA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net 1/4] xsk: avoid skb leak in XDP_TX_METADATA case
Reply-To: sashiko@lists.linux.dev
To: "Jason Xing" <kerneljasonxing@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260418045644.28612-2-kerneljasonxing@gmail.com>
References: <20260418045644.28612-2-kerneljasonxing@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 19 Apr 2026 04:58:21 +0000
Message-Id: <20260419045822.843BFC2BCAF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Sashiko AI review found 2 potential issue(s):
- [High] Premature SKB free triggers AF_XDP completion destructor, corrupti=
ng the Completion Queue (CQ) and causing an infinite TX loop.
- [High] Calling `xsk_skb_metadata()` before SKB fragments are attached bre=
aks software checksum offload and permanently wedges the TX ring.
--

commit 7fb48e575c16e2e098969186062c6a31c8245353
Author: Jason Xing <kerneljasonxing@gmail.com>

xsk: avoid skb leak in XDP_TX_METADATA case

This commit prevents a memory leak when xsk_skb_metadata() fails by
explicitly freeing the skb before returning to the caller.

Link: https://lore.kernel.org/all/20260415085204.3F87AC19424@smtp.kernel.or=
g/

> diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> index 887abed254668..5b273bcd0dbce 100644
> --- a/net/xdp/xsk.c
> +++ b/net/xdp/xsk.c
> @@ -823,8 +823,10 @@ static struct sk_buff *xsk_build_skb_zerocopy(struct=
 xdp_sock *xs,
>  		xsk_skb_init_misc(skb, xs, desc->addr);
>  		if (desc->options & XDP_TX_METADATA) {
>  			err =3D xsk_skb_metadata(skb, buffer, desc, pool, hr);

Is it safe to call xsk_skb_metadata() here before the SKB fragments are
attached?

Because the fragments are populated later in the function via
skb_fill_page_desc(), both skb->len and skb_headlen(skb) are 0 at this poin=
t.

If XDP_TXMD_FLAGS_CHECKSUM is requested and software fallback is active,
xsk_skb_metadata() will call skb_checksum_help(). Because skb_headlen is 0,
the bounds check in skb_checksum_help() can trigger a WARN_ONCE and return
-EINVAL. This permanently wedges the TX ring since -EINVAL does not consume
the descriptor.

> -			if (unlikely(err))
> +			if (unlikely(err)) {
> +				kfree_skb(skb);

Does freeing the SKB here cause issues with the completion queue?

Just before this block, xsk_skb_init_misc() sets skb->destructor to
xsk_destruct_skb. Calling kfree_skb() triggers this destructor, which submi=
ts
the descriptor's address to the CQ and increments the producer index.

However, the caller xsk_build_skb() will see the error and call
xsk_cq_cancel_locked(), which decrements the cached producer index. This
desynchronizes the queue reservation pointers.

Additionally, because the error is not -EOVERFLOW, the kernel does not
advance the TX ring consumer pointer. The bad descriptor remains in the TX
ring and will be retried continuously, potentially causing an infinite loop.

Should skb->destructor be restored to sock_wfree before calling kfree_skb(),
or should xsk_skb_init_misc() be deferred until after the metadata is
validated?

>  				return ERR_PTR(err);
> +			}
>  		}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260418045644.2861=
2-1-kerneljasonxing@gmail.com?part=3D1
