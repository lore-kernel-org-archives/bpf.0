Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09EA62F7445;
	Thu,  6 Aug 2026 10:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786013402; cv=none; b=Y/Dg87Rpj1kIeaCm5R6rJUp7t8ZGMASn68xaoJMst0dLItI3UVp6x/DHTmsgU9+5Ml/4jFa38HoRMG8wBcQWzRxMKti1m9Vv7g29ffDJC5XlADJaZeQl9Zl7KqS+KTK1VV5hW6nDQiddddpNMjBa9X9smdOEhf/NXdm2LLtnqro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786013402; c=relaxed/simple;
	bh=NnZXd1SoPj+D6jYdOMWAqaxGSrebvxKHwv3NZ/qJxag=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=cga4Uo30sMCIoO1JfbIB/2XSJpPg35SOltAKu8k4JpyaTzI+2yGNuAn9qbOtz24fn/hcX6uqbe+ZO7LbN1e3kV86in0qLC8vf+kvoL89+KVg4oNjlu79rWYiKqAL1KrSI1zj5m/acHksHwGzOWqJupU+GfmXVembccTigkuUUuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UChuUzxF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UChuUzxF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B9B71F00A3A;
	Thu,  6 Aug 2026 10:49:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786013400;
	bh=+Flv98NFo1FKOZCwgGMrnLcEUXdnlQQyTgVKrQ096HA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UChuUzxFI6JhCLQV3S/fKY35sIrmxu6voCJMd40V2n1iinmCPkiqf+nf/sZqmIq5g
	 DJwcNjJEn55SSvH6vTEeKAglLCfgWqXAay/2LRTdXIjQHqB4NpiD8mqI6NyT7RXOpt
	 oY3+2cxxcsk1bLRyOXR8brwUs562LIH8VrrwnVon+/ugkUEpncxwPphbNMqg3UAieg
	 liKY502602MRfE+ulhpoMk2ja4NV8NXjXRRlnTk0hgTNO2YqCkM7hruqfL8aR3IqGH
	 T/wv/K1f+yu138LyLZxUFkWwaeE6z5xyjgbSzTvRNDHuEZ6V+RRljt6HIPSaKDZIcH
	 mYwEe+3tZFz6g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net 1/2] net: packet: fix skb->protocol not updated
 after VLAN network header adjustment
Reply-To: sashiko-reviews@lists.linux.dev
To: wei.fang@oss.nxp.com
Cc: bpf@vger.kernel.org, Frank.Li@kernel.org, imx@lists.linux.dev
In-Reply-To: <20260805105314.3882595-2-wei.fang@oss.nxp.com>
References: <20260805105314.3882595-1-wei.fang@oss.nxp.com>
 <20260805105314.3882595-2-wei.fang@oss.nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 06 Aug 2026 10:49:59 +0000
Message-Id: <20260806105000.5B9B71F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Overwriting `skb->protocol` with the inner protocol while leaving =
the VLAN tag inline in the payload hides the VLAN tag from the network stac=
k and drivers. This breaks packet transmission for VLAN-tagged packets sent=
 via AF_PACKET SOCK_RAW.
--

--- Patch [1]: [PATCH net 1/2] net: packet: fix skb->protocol not updated a=
fter VLAN network header adjustment ---
commit f62ea124b860e7404cd95296234dc5505cb676c4
Author: Wei Fang <wei.fang@nxp.com>

net: packet: fix skb->protocol not updated after VLAN network header adjust=
ment

This commit updates skb->protocol with the inner protocol resolved by
vlan_get_protocol_and_depth() for VLAN-tagged frames sent via AF_PACKET
SOCK_RAW. This allows the flow dissector to correctly identify the inner
transport header instead of failing and leaving the transport header unset.

> diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
> index 0e1355be89f64..a62d445047c0e 100644
> --- a/net/packet/af_packet.c
> +++ b/net/packet/af_packet.c
> @@ -1945,9 +1945,15 @@ static void packet_parse_headers(struct sk_buff *s=
kb, struct socket *sock)
> =20
>  	/* Move network header to the right position for VLAN tagged packets */
>  	if (likely(skb->dev->type =3D=3D ARPHRD_ETHER) &&
> -	    eth_type_vlan(skb->protocol) &&
> -	    vlan_get_protocol_and_depth(skb, skb->protocol, &depth) !=3D 0)
> -		skb_set_network_header(skb, depth);
> +	    eth_type_vlan(skb->protocol)) {
> +		__be16 proto =3D vlan_get_protocol_and_depth(skb, skb->protocol,
> +							   &depth);
> +
> +		if (proto !=3D 0) {
> +			skb_set_network_header(skb, depth);
> +			skb->protocol =3D proto;

[Severity: High]
Does overwriting skb->protocol here hide the inline VLAN tag from the netwo=
rk
stack and drivers?

Since the VLAN tag is left inline in the MAC payload, updating skb->protocol
to the inner protocol (e.g. ETH_P_IP) causes eth_type_vlan(skb->protocol) to
become false.

This can lead to vlan_features_check() being bypassed, which might allow the
stack to send VLAN packets to a driver with TSO enabled even if the hardware
doesn't support it.

Additionally, drivers like ixgbe that check for ETH_P_8021Q might fail to
recognize the inline software VLAN tag, potentially causing issues like
inserting duplicate VLAN tags when DCB is enabled or breaking egress TC fil=
ters.

> +		}
> +	}
> =20
>  	skb_probe_transport_header(skb);
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260805105314.3882=
595-1-wei.fang@oss.nxp.com?part=3D1
