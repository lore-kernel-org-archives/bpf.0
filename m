Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D295E3A75A3
	for <bpf@vger.kernel.org>; Mon, 22 Jun 2026 12:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782131543; cv=none; b=uH5PdGHmJFWj0kWL2/z3AlfwMYuO5FClcwfVT97gIRQgH5MN17CaZiEm0aU6s7nIRwlT0Unn2hyPSw18S4WJYrv7HUL/HgucuLS6SAUq5ZdNwK5Bdb7XO7//rSuJ54dJhx8krHmQRsePBKTRm/AxF8u10YmXZ60OYhML2Vr6uWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782131543; c=relaxed/simple;
	bh=5TTtO0wucTcd0iEQK6eGiDMWrIZYca54tqoO1m3xrLI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=OmiiewQrkY0i0rnmPCBy+NUV7IxyaMzUJwQn1eTL5dm0qaObTiPyfmwDuwnjHyqi9A0aIVYiNft/5agcyD2NnruBZE6kQMY41KJmsv7Dp++7p6Lqf4RqIzzqTTOiX4/FxClhqweW6/Mp3Z0LrmfnjL26dOTr9z0A76ts8XnSxzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ERywxlDn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ERywxlDn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AE7F1F000E9;
	Mon, 22 Jun 2026 12:32:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782131542;
	bh=Avlqmo5pum/fDEGVjKzqIJjdh/UMRpX+L/1R5bnGKkw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ERywxlDnSH4CqxY4voP8by9PpUWAPyaY9zGky8RKwW1ptRIANig8wVMUlBKkSKJj2
	 nCbYG1KPOp2ZvselZbrh/7l2ZNrA9NIWyKpa2FKJfRMjyTPF+6biDbwnDhjDVMazBk
	 Zi14GNne86G6pdIvdmBKJKrB4ZkTkc+THpC/n5h31P96exxWpH4x3T6bTjUW1ZL9ki
	 dkFqYEfY/Rros1vbw475hVzFWrZEjHAds9MaKfDXjwNmLf2iSch40awvnFtbYysBDC
	 ESZo4FeqDeRCZbAFC5n080YIhs1wo35oeav4onXjK8g25yyAXOC/t3R+ngBZmS+1YE
	 97E/ZkpnHazuA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v8 3/7] bpf: add bpf_icmp_send kfunc
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mahe Tardy" <mahe.tardy@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260622120515.137082-4-mahe.tardy@gmail.com>
References: <20260622120515.137082-1-mahe.tardy@gmail.com>
 <20260622120515.137082-4-mahe.tardy@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 22 Jun 2026 12:32:22 +0000
Message-Id: <20260622123222.5AE7F1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] bpf_icmp_send() causes __icmp_send() to bypass broadcast checks an=
d spoof the source address for TC ingress packets.
--

commit 2acddb10f02b54c09816af3432bc928c87824069
Author: Mahe Tardy <mahe.tardy@gmail.com>

bpf: add bpf_icmp_send kfunc

This commit adds the bpf_icmp_send kfunc to allow cgroup_skb and tc programs
to send ICMP error messages in response to packets. It clones the original
packet, optionally assigns a route using ip_route_reply_fill_dst for
unrouted ingress packets, and invokes the standard icmp_send or icmpv6_send
functions.

> diff --git a/net/core/filter.c b/net/core/filter.c
> --- a/net/core/filter.c
> +++ b/net/core/filter.c

[ ... ]

> @@ -12546,6 +12548,101 @@ __bpf_kfunc int bpf_xdp_pull_data(struct xdp_md=
 *x, u32 len)
> +__bpf_kfunc int bpf_icmp_send(struct __sk_buff *skb_ctx, int type, int c=
ode)
> +{
> +	struct sk_buff *skb =3D (struct sk_buff *)skb_ctx;
> +	struct sk_buff *nskb;
> +	struct sock *sk;

[ ... ]

> +	switch (skb->protocol) {
> +#if IS_ENABLED(CONFIG_INET)
> +	case htons(ETH_P_IP):
> +		if (type !=3D ICMP_DEST_UNREACH)
> +			return -EOPNOTSUPP;
> +		if (code < 0 || code > NR_ICMP_UNREACH)
> +			return -EINVAL;
> +
> +		nskb =3D skb_clone(skb, GFP_ATOMIC);
> +		if (!nskb)
> +			return -ENOMEM;
> +
> +		if (!pskb_network_may_pull(nskb, sizeof(struct iphdr))) {
> +			kfree_skb(nskb);
> +			return -EBADMSG;
> +		}
> +
> +		if (!skb_dst(nskb) && ip_route_reply_fill_dst(nskb) < 0) {
                                      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
[Severity: High]
Does using ip_route_reply_fill_dst() here cause regressions with how
__icmp_send() evaluates routing flags?

For TC ingress packets where skb_dst(nskb) is NULL, this attaches an output
route. However, __icmp_send() expects the SKB to have an input route when
evaluating rt_flags:

net/ipv4/icmp.c:__icmp_send() {
        ...
        if (rt->rt_flags & (RTCF_BROADCAST | RTCF_MULTICAST))
                goto out;
        ...
        saddr =3D iph->daddr;
        if (!(rt->rt_flags & RTCF_LOCAL)) {
                ...
                saddr =3D 0;
        }
        ...
}

Because the attached route is an output route, it lacks RTCF_BROADCAST,
which might incorrectly allow ICMP replies to broadcast traffic.

Additionally, because RTCF_LOCAL is missing on the output route,
__icmp_send() clears saddr. This causes icmp_route_lookup() to select the
primary IP of the outgoing interface rather than the specific IP the packet
was originally addressed to, violating RFC 1122 requirements for ICMP error
source addresses.

> +			kfree_skb(nskb);
> +			return -EHOSTUNREACH;
> +		}
> +
> +		memset(IPCB(nskb), 0, sizeof(struct inet_skb_parm));
> +
> +		icmp_send(nskb, type, code, 0);
> +		consume_skb(nskb);
> +		break;
> +#endif

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260622120515.1370=
82-1-mahe.tardy@gmail.com?part=3D3
