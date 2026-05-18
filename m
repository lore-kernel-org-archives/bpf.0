Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 339C6369985
	for <bpf@vger.kernel.org>; Mon, 18 May 2026 16:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779121557; cv=none; b=Owm2i8l+8gPFKogQF4Z31R+UOxI+IoK7x1zWUb8UgXfdonnyaNcaTpBnp3RDYHqtBjYrhsnv1qL6qoM0To29zuTeUwsAyG3JZ3l/8kjGUhgxaWHLBZigrD/dpx4hOU4OpD2u0dwnLuQxI1T5d0XhHXDB4BQGc/b84HJ+R9NHkT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779121557; c=relaxed/simple;
	bh=0mexjWGCEXnlcweBM5ZrCMGDCJYk51SkoMGRlOWa9JE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=rM3cy/K8UUBCJJZ5yXSuIeG5Xl0qpStb2SRYmM8foyQVUWhJnmKf8KWx0opnNxW3FjEruYasCdlMH729zAusNYEIZ/g8uQRbDNYrfAu3K7IiHHK1YiUyMmkCnGYVfqo6eh8VGaDl5w7bF8Z2IbSRjd9XAv1+MdFSAzanF+wbgzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EKj2zD2C; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EKj2zD2C"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE85AC2BCB8;
	Mon, 18 May 2026 16:25:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779121556;
	bh=0mexjWGCEXnlcweBM5ZrCMGDCJYk51SkoMGRlOWa9JE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=EKj2zD2CwCuEDxqiT7NNwdoYYCoGZZEr6fVlm5zd8zQCKb3IDszG5cOycphekS1IO
	 8IQFP0Q2Vc5ePCrqhrdYTzJLtNB5v8q6AQNOmKriA/RWxII2oaYY72S08fDOUX34nT
	 nx6XWJDyVzBgIlJ0OzfOLljnqCv5xYu/xVfCBiF1A4+VdCH4rKfbUKK/GzOo0bNyYr
	 I0Ei+/iHDPCunqv+R0G5gy/GJUIN/ttiHSYz9EkaAzMjfS8DfvYLrqFYcviWLX0qLr
	 jyDLOdP+YbEgeXwucSMOg2JB7OkogUK81rPPSkCiz3T36XtiYvL40093qqG48LJRP0
	 PjScWTEWtosSQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v6 3/6] bpf: add bpf_icmp_send kfunc
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mahe Tardy" <mahe.tardy@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260518122842.218522-4-mahe.tardy@gmail.com>
References: <20260518122842.218522-4-mahe.tardy@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 18 May 2026 16:25:56 +0000
Message-Id: <20260518162556.BE85AC2BCB8@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The BPF kfunc `bpf_icmp_send()` originates ICMPv6 DEST_UNREACH m=
essages for IPv6 fragments other than the first fragment, violating RFC 444=
3.
--

commit 7a9ef91672faeb43ff51c256f81255a263f374aa
Author: Mahe Tardy <mahe.tardy@gmail.com>

bpf: add bpf_icmp_send kfunc

Adds a bpf_icmp_send() kfunc for cgroup_skb and tc BPF programs to reply
with ICMP/ICMPv6 destination unreachable messages. It clones the packet
to safely generate the ICMP response without altering the original skb,
and includes protection against recursion.

> diff --git a/net/core/filter.c b/net/core/filter.c
> --- a/net/core/filter.c
> +++ b/net/core/filter.c

[ ... ]

> @@ -12464,6 +12466,110 @@ __bpf_kfunc int bpf_xdp_pull_data(struct xdp_md=
 *x, u32 len)
>  	return 0;
>  }
> =20
> +static DEFINE_PER_CPU(bool, bpf_icmp_send_in_progress);
> +
> +/**
> + * bpf_icmp_send - Send an ICMP control message

[ ... ]

> +__bpf_kfunc int bpf_icmp_send(struct __sk_buff *skb_ctx, int type, int c=
ode)
> +{

[ ... ]

> +#if IS_ENABLED(CONFIG_IPV6)
> +	case htons(ETH_P_IPV6):
> +		if (type !=3D ICMPV6_DEST_UNREACH)
> +			return -EOPNOTSUPP;
> +		if (code < 0 || code > ICMPV6_REJECT_ROUTE)
> +			return -EINVAL;
> +
> +		nskb =3D skb_clone(skb, GFP_ATOMIC);
> +		if (!nskb)
> +			return -ENOMEM;
> +
> +		if (!pskb_network_may_pull(nskb, sizeof(struct ipv6hdr))) {
> +			kfree_skb(nskb);
> +			return -EBADMSG;
> +		}
> +
> +		if (!skb_dst(nskb) && ip6_route_reply_fill_dst(nskb) < 0) {
> +			kfree_skb(nskb);
> +			return -EHOSTUNREACH;
> +		}
> +
> +		memset(IP6CB(nskb), 0, sizeof(struct inet6_skb_parm));
> +
> +		*in_progress =3D true;
> +		icmpv6_send(nskb, type, code, 0);

The commit message notes that "icmp_send will only reply to fragment 0".
While IPv4's __icmp_send() explicitly drops non-initial fragments, does
icmpv6_send() provide the same guarantee?

Looking at icmpv6_send(), the internal is_ineligible() check does not seem
to prevent replying to non-initial UDP/TCP fragments. Other kernel subsyste=
ms
that originate ICMPv6 errors, such as Netfilter's nf_send_unreach6(), appear
to manually parse extension headers via ipv6_skip_exthdr() and explicitly
drop non-initial fragments.

Will calling icmpv6_send() directly here originate ICMPv6 errors for every
fragment of a dropped fragmented IPv6 packet, violating RFC 4443 Section
2.4 (e.5)?

> +		*in_progress =3D false;
> +		kfree_skb(nskb);
> +		break;
> +#endif

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260518122842.2185=
22-1-mahe.tardy@gmail.com?part=3D3
