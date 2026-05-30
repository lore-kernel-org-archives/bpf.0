Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C13B12652A2
	for <bpf@vger.kernel.org>; Sat, 30 May 2026 00:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780101858; cv=none; b=pK7Dm12lKMOOnjstRUpODKhn1CXOQV+iy9yo9f/Rt2KnR7b2tQ6koN8mzTaNN6cNHC/r9pw2CNXMPx8B64JFDsb7u32VA+6rGpCvyEsrh3bRNCt5SSd3IyHi+G2Y2PeH6Mq8kuyjWE5lkHhJsvtE4ldx11FopXbOjQa1KqTGifI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780101858; c=relaxed/simple;
	bh=73FwsImqaXHYm0d5JG8YB7d94JwFPyS+q+X/HaMVdak=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=I8jzHoEGBencxDzYYB0V62X0GLmI2hjatx1+SyQugcaO/IbgE3HzHB50kfXh2DzHtec0OEGvVbdGP8ASGi5FcQrz/gSOK5Sw2rgd7swPPjdMEdVtpcwBFBMwEQImIEHb7GT99vut+rlU0UvRvyJeUS9HWSvgXXZmQBXNsGbiSJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JvHoBT9K; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JvHoBT9K"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D2D61F00899;
	Sat, 30 May 2026 00:44:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780101857;
	bh=hv55slqBYr/mijd0aPK3w5cSvybGLfFa6ujgaubbrmI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JvHoBT9KHl8AiX4VcnWNUL6wnBgCvtK4SLUG3ctWgA87iyOZlgyYseMiU6cFxuf+u
	 gHuBa4wfFFMDoW/3UFjwzbgNj3i+5J3bZwN8rZpFTCnX0CZJXa28jDDnS1vHBF23/b
	 mqD9KLxPwNd1r2mPunFqXizXdgp+XjBOGeZwU1BgIPYCabYJUAEFrXCaF0u3lDDrVF
	 gO9wOEYsPCK1lAE2yIOSZIXwOIbPyiKCwzSNVy9ZDfyqAq9pHplTkSXPWsrEx+lmzu
	 5OQSgMB3b7dWxAQH1vb8/VQOKbu6lTaTBK0yrFecStP0wxgyisHPdSmlx9Gt+l0HO6
	 gPAaIPRBa8wPA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v4 4/5] xsk: drain continuation descs on invalid
 descriptor in __xsk_generic_xmit()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jason Xing" <kerneljasonxing@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260520004244.55663-5-kerneljasonxing@gmail.com>
References: <20260520004244.55663-5-kerneljasonxing@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 30 May 2026 00:44:17 +0000
Message-Id: <20260530004417.7D2D61F00899@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Failure to update TX ring consumer pointer when processing only in=
valid or dropped descriptors leads to a deadlocked TX ring.
--

commit 8b2ad485d536e9c6cf90b478357bdf68eb66e24c
Author: Jason Xing <kerneljasonxing@gmail.com>

xsk: drain continuation descs on invalid descriptor in __xsk_generic_xmit()

This commit addresses an issue where an invalid descriptor mid-packet causes
the partial skb to be dropped, but leaves continuation descriptors in the TX
ring. It introduces a drain_cont flag to flush the remaining fragments of
the corrupted multi-buffer packet on subsequent iterations.

> diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> index f4add7be8c935..de953f38b9e2a 100644
> --- a/net/xdp/xsk.c
> +++ b/net/xdp/xsk.c
> @@ -1122,6 +1122,7 @@ static int __xsk_generic_xmit(struct sock *sk)
>  		if (xs->skb)
>  			xsk_drop_skb(xs->skb);
>  		xskq_cons_release(xs->tx);
> +		xs->drain_cont =3D xp_mb_desc(&desc);
>  	}
> =20
>  out:

[Severity: High]
This is a pre-existing issue, but does skipping the TX release when there a=
re
no successfully sent frames lead to a deadlocked TX ring?

In __xsk_generic_xmit(), the consumer pointer is updated and the socket is
awoken only if sent_frame is true:

out:
	if (sent_frame)
		__xsk_tx_release(xs);

The sent_frame flag is set to true only when a packet is successfully
transmitted via __dev_direct_xmit(). If a batch of processing consists
entirely of invalid descriptors, dropped packets, or drained continuations
(including the newly added drain_cont path), sent_frame remains false.

If sent_frame remains false, the function skips calling __xsk_tx_release().
As a result, the advanced cached_cons index is never published to the shared
ring->consumer pointer.

If a workload encounters enough invalid descriptors or drops to fill the
ring, the consumer pointer will never advance. Userspace will see the ring =
as
completely full and block in poll or sendmsg waiting for EPOLLOUT. Since the
kernel hasn't published the advanced consumer pointer nor called
sk_write_space(), could the socket permanently deadlock?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260520004244.5566=
3-1-kerneljasonxing@gmail.com?part=3D4
