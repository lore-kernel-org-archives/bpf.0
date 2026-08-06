Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E083C3CB8EB;
	Thu,  6 Aug 2026 10:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786013401; cv=none; b=EJ3BcNbSMrrhjzssj0Jfmshlh+wMLDByiO6letqcWzfpBHg1gmHnRJ1pZwws/cnY2KwyvEzb6Wz850BcFpMMGCRnecXUIRXop/WfeBKgz3DByRGwh8B3PJkOs5F7dYxhdDa3z6iDFfcLQRrTwW61VZSVhc9p3nMyAkXpON9mUuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786013401; c=relaxed/simple;
	bh=z78FM1GQVzSIZdMOCxihahtPCa4kbw3dCwRhq0rNLEw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=oJkTmY4xvlWMmyzHEnEIjNyduldqF4xKgqUR9bO4n0vFpazSuc0GwztNfkzOEUGINnVu8VKX5+8gNMewc3/zBQO6iGoL2BkK0xZwnCRtqwhPPgONwJuKK4nVXW/Dy+2rnLHedwvCaxm/fS+qAEMThdzPKKXxkwNWhxQ+gVc9QhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PwFqrqN5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PwFqrqN5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B0D61F000E9;
	Thu,  6 Aug 2026 10:49:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786013399;
	bh=s8NCflKFP3OwpKNR7morTlifCNrnK9/MWKVZexHshi8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PwFqrqN5OEJSNHGV8lWg4xVEvYFdDZo5kRKmfsoZxHEnJWFPEjWYH8Tr9DK3F8i0U
	 D79wcH9lD11ulir0Bn6i2z1C522iOlR0isEDA66AAqBPAQiBU16DPhTEyLbZFOtJh1
	 5qajA4ifUhTNAQgSnhsFjSs5YVrxkShcgz6I1+i9gJqJwwqamjRvNtHkU0NytgljLL
	 G7iuVq0Ypa16OLkK92vEWg8BOfh9MXWOyntAaSzElkf0bl06MHtZyMLJzQiGFBY0zl
	 4lJmcTrNjyjShZh3oytfzmy9WP59OjokVfeiX33+nV2fny2XNFo9QIFqUi/WGE9JHY
	 eVr+JVILl+Fww==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net 2/2] net: tap: fix skb->protocol not updated after
 VLAN network header adjustment
Reply-To: sashiko-reviews@lists.linux.dev
To: wei.fang@oss.nxp.com
Cc: bpf@vger.kernel.org, Frank.Li@kernel.org, imx@lists.linux.dev
In-Reply-To: <20260805105314.3882595-3-wei.fang@oss.nxp.com>
References: <20260805105314.3882595-1-wei.fang@oss.nxp.com>
 <20260805105314.3882595-3-wei.fang@oss.nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 06 Aug 2026 10:49:58 +0000
Message-Id: <20260806104959.3B0D61F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Incomplete fix: `skb->protocol` is not updated after `network_head=
er` adjustment in `tap_get_user()`.
--

--- Patch [2]: [PATCH net 2/2] net: tap: fix skb->protocol not updated afte=
r VLAN network header adjustment ---
commit 6866d2a8bbb104d45013a4b8fcd7c1800086ae28
Author: Wei Fang <wei.fang@nxp.com>

net: tap: fix skb->protocol not updated after VLAN network header adjustment

This commit fixes an issue in tap_get_user_xdp() where skb->protocol was not
updated after advancing the network header past the VLAN tag. It sets the
protocol to the inner EtherType to keep skb->protocol and network_header
consistent for subsequent processing.

> diff --git a/drivers/net/tap.c b/drivers/net/tap.c
> index fae115915c8ef..afcc4919bd042 100644
> --- a/drivers/net/tap.c
> +++ b/drivers/net/tap.c
> @@ -1081,9 +1081,15 @@ static int tap_get_user_xdp(struct tap_queue *q, s=
truct xdp_buff *xdp)
>  	}
> =20
>  	/* Move network header to the right position for VLAN tagged packets */
> -	if (eth_type_vlan(skb->protocol) &&
> -	    vlan_get_protocol_and_depth(skb, skb->protocol, &depth) !=3D 0)
> -		skb_set_network_header(skb, depth);
> +	if (eth_type_vlan(skb->protocol)) {
> +		__be16 proto =3D vlan_get_protocol_and_depth(skb, skb->protocol,
> +							   &depth);
> +
> +		if (proto !=3D 0) {
> +			skb_set_network_header(skb, depth);
> +			skb->protocol =3D proto;
> +		}
> +	}

[Severity: High]
This isn't a bug introduced by this patch, but does tap_get_user() also need
this same fix for non-XDP transmission paths?

Looking at tap_get_user() in drivers/net/tap.c, it contains the identical
logic that was patched here:

drivers/net/tap.c:tap_get_user() {
    ...
    /* Move network header to the right position for VLAN tagged packets */
    if (eth_type_vlan(skb->protocol) &&
        vlan_get_protocol_and_depth(skb, skb->protocol, &depth) !=3D 0)
        skb_set_network_header(skb, depth);
    ...
}

Without updating skb->protocol here as well, will TC egress and eBPF progra=
ms
still read skb->protocol as ETH_P_8021Q while network_header points to the
inner IP header?

If a user or guest VM writes a VLAN-tagged packet to a TAP file descriptor
using standard (non-XDP) I/O, could this allow them to craft an IP header
that causes traffic classification and security policies to misinterpret the
packet?

> =20
>  	rcu_read_lock();
>  	tap =3D rcu_dereference(q->tap);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260805105314.3882=
595-1-wei.fang@oss.nxp.com?part=3D2
