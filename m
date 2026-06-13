Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15FFB21257F
	for <bpf@vger.kernel.org>; Sat, 13 Jun 2026 18:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781376536; cv=none; b=Og6V1MHdc74pk8ezzYz85jeklF9FXnRCbnyj34+i/z6dPQSJpS54NLcAtuVooCKdUAUwhblMeO17Oo3sQCF2d6sallSDKB/anXl/oBi4xjx3MwgblksL0U9Ex1J8znRjTXVok7yEKablDbcpzjiUothKl/dH0idsdE2BUy03eZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781376536; c=relaxed/simple;
	bh=fGAQN1JxgsRViAZUKXeYuJVgeMy85psLaSbH1d1rzrc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=kPHQLyf7IMQD3FxIdboRFy5dEs6LXl5x5knpKsj0QwRLEigixzYlzc24DBbBuFNA59AdtHZ0bBK3IjQ6jIezZ3/F0Vw1ylSHE9cRzSdkipqgdmc9XLE9mgokIC1TSuvnizkxjM70Qp43c9SnnoTWCwJER6+8/aGaOKuWfbrP0QU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AF/ua/1i; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AF/ua/1i"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 997E61F000E9;
	Sat, 13 Jun 2026 18:48:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781376534;
	bh=48RN53eN9aSsMLTfAVE60lWnvIYmHFJQCHSdNr8n/vU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=AF/ua/1i8FgGj/U7xqARY/2KO0emVBESbxZJ9oKWvB3GOhCxu7qWGEnwhRLG8uEm7
	 fqNe3j6IRFsKtgAsW2iIY61C5ZjclGl+jvk94T2UKZ1pcC9RTOqG7nTejhbLBFwe8Z
	 ZLlebvI+ZZH0wKZ3g1iWvJuFOm1ZNMScMeooVwGV+qgAHQfwf4L6Q1QmYafQkgjs3O
	 XYvC3WcizuyuEfZL7fI4UtIKy8kpBpCI+3+wsgH7UOa/3rn+KLZiog/26OQzA06mp4
	 EaJKF8C1KO0fekPtELeCcRCf92DyKNcuzfr17sxQS7m64IjXEIAOlbrGlBoeXYAkwj
	 QGyw3h3sN3zDA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 bpf-next 1/2] bpf: Support BPF_F_INGRESS with
 bpf_redirect_peer
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jordan Rife" <jordan@jrife.io>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260613183424.1198073-2-jordan@jrife.io>
References: <20260613183424.1198073-2-jordan@jrife.io>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 13 Jun 2026 18:48:53 +0000
Message-Id: <20260613184854.997E61F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] The BPF_F_INGRESS flag is overloaded to mean 'redirect to egress',=
 which explicitly contradicts its name and creates a highly confusing UAPI.
--

commit c2f57c74761992eef4cef91a47661432c2110683
Author: Jordan Rife <jordan@jrife.io>

bpf: Support BPF_F_INGRESS with bpf_redirect_peer

This patch extends bpf_redirect_peer to support the BPF_F_INGRESS flag.
When this flag is provided, the skb is emitted in the egress direction of
the target interface's peer device. This allows traffic to be redirected
directly from one netkit peer device to another for use cases like
transparent proxies.

> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index 11dd610fa5fae..dd0f2c3aea58b 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h

[ ... ]

> @@ -5074,17 +5074,19 @@ union bpf_attr {
>   * 	Description
>   * 		Redirect the packet to another net device of index *ifindex*.
>   * 		This helper is somewhat similar to **bpf_redirect**\ (), except
> - * 		that the redirection happens to the *ifindex*' peer device and
> - * 		the netns switch takes place from ingress to ingress without
> - * 		going through the CPU's backlog queue.
> + * 		that the redirection happens to the *ifindex*' peer device. If
> + * 		*flags* is 0, the netns switch takes place from ingress to
> + * 		ingress without going through the CPU's backlog queue. If the
> + * 		**BPF_F_INGRESS** flag is provided then redirection happens in
> + * 		the egress direction of the peer device.

[Severity: High]
Does this create a confusing UAPI by overloading the BPF_F_INGRESS flag to
mean the exact opposite of its name?

In standard bpf_redirect(), flags =3D 0 means egress, and flags =3D BPF_F_I=
NGRESS
means ingress. For bpf_redirect_peer(), flags =3D 0 was originally defined =
to
mean ingress-to-ingress redirection.

Using BPF_F_INGRESS to mean egress for this specific helper might lead to
long-term confusion, especially since UAPI additions are permanent.

Could a properly named flag like BPF_F_PEER_EGRESS be introduced instead of
overloading BPF_F_INGRESS with contradictory semantics?

>   *
>   * 		*skb*\ **->mark** and *skb*\ **->tstamp** are not cleared during
>   * 		the netns switch.

[ ... ]

> diff --git a/net/core/filter.c b/net/core/filter.c
> index 9590877b0714f..c24fdf744f75f 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c

[ ... ]

> @@ -2529,16 +2529,18 @@ int skb_do_redirect(struct sk_buff *skb)
>  	if (unlikely(!dev))
>  		goto out_drop;
>  	if (flags & BPF_F_PEER) {
> -		if (unlikely(!skb_at_tc_ingress(skb)))
> -			goto out_drop;
>  		dev =3D skb_get_peer_dev(dev);
>  		if (unlikely(!dev ||
>  			     !(dev->flags & IFF_UP) ||
>  			     net_eq(net, dev_net(dev))))
>  			goto out_drop;
> -		skb->dev =3D dev;
> -		dev_sw_netstats_rx_add(dev, skb->len);
>  		skb_scrub_packet(skb, false);
> +		if (flags & BPF_F_INGRESS)
> +			return __bpf_redirect(skb, dev, 0);

[Severity: High]
Is it contradictory to check a flag literally named INGRESS, but then
call __bpf_redirect(skb, dev, 0) which forces the packet onto the egress
TX path of the peer?

> +		if (unlikely(!skb_at_tc_ingress(skb)))
> +			goto out_drop;
> +		dev_sw_netstats_rx_add(dev, skb->len);
> +		skb->dev =3D dev;
>  		return -EAGAIN;
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260613183424.1198=
073-1-jordan@jrife.io?part=3D1
