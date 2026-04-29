Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71A6737E2FD
	for <bpf@vger.kernel.org>; Wed, 29 Apr 2026 19:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777492364; cv=none; b=daZUGmWnRvYrFWvvXLrmxpfuI92PQiHs/JVibTeQR3RpIE538AJzZ5AqA38r/U8Di0dQ0DINI0V8egYEMuOJoPpDuz9ZobY8hanYQFWKs3GahwCKYv89BcmzIJlkz5DW/Xr9nQytPWPzJGeaxtuC6jNIetfv7AMeomDfUf0GOeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777492364; c=relaxed/simple;
	bh=CfP9iIXPty7aqbS/v9+4isA3bfhe/Wx4Sst11puONik=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=EaVuRFjyk8v7mgTx7MjaEyVhm1UYylKkD/VYPETi+C9Bd2bKNDAEr2NjiS4Z6QyviL8/7qzEWsQMj+cUMreptpWJHbGepexobLe7tRdHX7vgoCI32+J6vWGCBr6xV05ETsziQdQG7QB1obMuzwLsk+9kFccO5rxMlD9YHbp+npM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nC7hvApB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nC7hvApB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA3BAC19425;
	Wed, 29 Apr 2026 19:52:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777492364;
	bh=CfP9iIXPty7aqbS/v9+4isA3bfhe/Wx4Sst11puONik=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=nC7hvApBMH1BgCaovTBXx17HckuEQPaP/+vLl7tiXDu2qNsHebTBNbh0vxIbDlHWk
	 0a1Skz+HX9OZdvs149FZF2hZJvlY6CjhEiKqCaxM9jXAu6AaSkk0uyHfUOEUVKWTXc
	 PTQ4tW2T4XJtDZXLLMSRODDcez09/v7dxdvQeiYye+ebUtq12DfArkjQgVA219SFHu
	 RkL+50UWmLTXkwPF9KyZ1j/SfCbUXMb7ZTJ6LBrJLs/W84GBu8LRVZm4kH0v7ELepA
	 7lbYO85kD38j49QKftUykyRgnSTUVmw/CwTT9AVRzQQpG5BO6a5NThz0/l9Z4omrkC
	 vOS9oRpjsLVLQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net] net: Clear skb metadata before LWT xmit
Reply-To: sashiko@lists.linux.dev
To: "Jakub Sitnicki" <jakub@cloudflare.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260428-wip-skb-local-storage-from-scratch-v1-1-8f7ca9b378ce@cloudflare.com>
References: <20260428-wip-skb-local-storage-from-scratch-v1-1-8f7ca9b378ce@cloudflare.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 29 Apr 2026 19:52:42 +0000
Message-Id: <20260429195243.EA3BAC19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Modifying `skb_shinfo(skb)->meta_len` via `skb_metadata_clear()` o=
n a potentially cloned SKB without unsharing causes data races and shared m=
emory corruption.
- [High] Unconditional clearing of SKB metadata breaks XDP-to-TC metadata p=
assing for all forwarded packets.
--

commit 9bd10448be11f5fe388ec5590ce62a619d12c1d2
Author: Jakub Sitnicki <jakub@cloudflare.com>

net: Clear skb metadata before LWT xmit

This commit attempts to clear SKB metadata before calling into LWT xmit from
the IPv4 and IPv6 output paths. This is intended to prevent hidden RX
metadata from affecting LWT SKB mutation helpers.

> diff --git a/net/ipv4/ip_output.c b/net/ipv4/ip_output.c
> index e4790cc7b5c2..3295e043310f 100644
> --- a/net/ipv4/ip_output.c
> +++ b/net/ipv4/ip_output.c
> @@ -220,6 +220,8 @@ static int ip_finish_output2(struct net *net, struct =
sock *sk, struct sk_buff *s
>  			return -ENOMEM;
>  	}
> =20
> +	skb_metadata_clear(skb);

Does this clear metadata for all forwarded packets, rather than just those
destined for LWT xmit?

By placing skb_metadata_clear() outside of the lwtunnel_xmit_redirect()
block, it appears XDP metadata is permanently stripped from all packets on
the output path. Could this break XDP-to-TC egress metadata passing
system-wide when these packets later reach dev_queue_xmit()?

> +
>  	if (lwtunnel_xmit_redirect(dst->lwtstate)) {
>  		int res =3D lwtunnel_xmit(skb);
> =20

[ ... ]

> diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
> index 7e92909ab5be..734818463e07 100644
> --- a/net/ipv6/ip6_output.c
> +++ b/net/ipv6/ip6_output.c
> @@ -111,6 +111,8 @@ static int ip6_finish_output2(struct net *net, struct=
 sock *sk, struct sk_buff *
>  		}
>  	}
> =20
> +	skb_metadata_clear(skb);

Can this modify the shared info on a cloned SKB without unsharing it first?

skb_metadata_clear() directly sets skb_shinfo(skb)->meta_len =3D 0. Earlier
in this function, multicast packets may be cloned:

net/ipv6/ip6_output.c:ip6_finish_output2() {
    ...
		if (!(dev->flags & IFF_LOOPBACK) && sk_mc_loop(sk) &&
		    ...
			struct sk_buff *newskb =3D skb_clone(skb, GFP_ATOMIC);

			if (newskb)
				NF_HOOK(NFPROTO_IPV6, NF_INET_POST_ROUTING,
    ...
}

If the SKB is cloned and being processed concurrently by NF_HOOK, would
writing to skb_shinfo(skb)->meta_len cause a data race and corrupt the
shared memory for the clone?

> +
>  	if (lwtunnel_xmit_redirect(dst->lwtstate)) {
>  		int res =3D lwtunnel_xmit(skb);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260428-wip-skb-lo=
cal-storage-from-scratch-v1-1-8f7ca9b378ce@cloudflare.com?part=3D1
