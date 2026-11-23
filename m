Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795406369;
	b=1jFPXJuqFMAC0d+g8cQR/tPn3Lz98V7Obd7u5Po5GEQWVYUtbgqF2Ms32uzFOQHuNlZT
	 2R1AYnDj34t/9Du0BMc0CQr94YubeuKxNUC4Ge6YqmUcl83AKN9uwSZpjuGuuggCDmEFC
	 JhS7thZsFQRhOhl/fvZArAzvR92IxdGXBQJRtVGYp/aHZvekg4z+JI3qZJYcW9aBq8C+H
	 wFqxhcfb6qBXAISx3ZEn24PssYKZ78mp9NUZam3jCVCXKP6s5PvkKvCh7c8wesykOU0md
	 6MoDAzhRbaLiz+9NqSLpI7EZSaZWmTZhPzt0DMJzycH0Te/hFBWaInZWiZQKEQUAwZw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795406369;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=h/OFAzdpxrl003vwQjCZSPpInQ04oC6dMNVi1B39uzE=;
	b=eZLka0ixtR3K8d1aS4LyjThqW1AOH9Gugok6zDwvwad4RHPhXs0KH4NlDZgSM4DL4t8n
	 3ZmVrdy6ukbjsy+HkH8hqZd0vk0SZ4t4JVvm3LTiGGzJ2MXwC8ZbnQSvHRaQqRdig450N
	 gp0lQELYi9KJixLXNqzFcV47W1fvnuwgY1Jg7yVmvFvJT0vNzgipXnlo9a/kx0BDaylFL
	 IUB8cq2mI25qD+oVjnwZWbt1nfzwrTuifbRdUBQXvLOFXOdcWxvMGrd52WuZMON91ew8v
	 EM5KNqWR7mCau+SardpHzS/04OQqO3YSLW1VwxpOCUz3uNpJe4UtSA7EAQx7Gd0gs1g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="P9nonK/D";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFB9C606A31A;
	Mon, 23 Nov 2026 03:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=P9nonK/D
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2523B1F000CA;
	Mon, 23 Nov 2026 03:59:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795406369;
	bh=h/OFAzdpxrl003vwQjCZSPpInQ04oC6dMNVi1B39uzE=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=P9nonK/DKTt9rPNOhwE0lkc/2wnEDWJrqk/1fnJCD69UP9qi0DoDwLFhs6U+FQyHo
	 Zxv8TglY91xCyjkeIaKgozLcTp+Yz2PpeUHTUVKe86jI5dIAF3MahUo3Hp+bJnMX+b
	 En4BTmVSZlMYVoWDO+izrMFE0LLynZxY1Bh1TwKQu35tWkIKfta/Lywvpoph6p4i0n
	 TryRcREA12nkx+i0KpWTOzHjgeCK/QDzMhVpX2/tFcc0qs6eEKGiKGYd7W8sERq+Gs
	 gTjm35Xw/qP5umUm9KsqG+GWhdF3E4y06w3d4NL5oejlCRxMZpXRUt7/G8CNtJyvJK
	 F5afNo8Ixkt7w==
Subject:
 Re: [PATCH net-next v2 10/11] netlink: specs: rt-link: add veth attributes
From: netdev-bot+sashiko@kernel.org
To: tianyi@cloudflare.com
Cc: netdev@vger.kernel.org, kuba@kernel.org, pabeni@redhat.com,
 edumazet@kernel.org, davem@davemloft.net, horms@kernel.org, dkeogh@amazon.com,
 hawk@kernel.org, daniel@iogearbox.net, dwmw2@infradead.org,
 dtatulea@nvidia.com, noren@nvidia.com, alasdair@mcwilliam.dev,
 willemdebruijn.kernel@gmail.com, maciej.fijalkowski@intel.com,
 sdf@fomichev.me, magnus.karlsson@intel.com, dsahern@kernel.org,
 idosch@nvidia.com, ast@kernel.org, john.fastabend@gmail.com,
 donald.hunter@gmail.com, andrew+netdev@lunn.ch, corbet@lwn.net,
 skhan@linuxfoundation.org, shuah@kernel.org, rdunlap@infradead.org,
 leitao@debian.org, ast@fiberby.net, danieller@nvidia.com, kuniyu@google.com,
 bpf@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kselftest@vger.kernel.org, kernel-team@cloudflare.com,
 nh-open-source@amazon.com, stephen@networkplumber.org, gustavoars@kernel.org,
 one-d-wide@protonmail.com, ameryhung@gmail.com, andrii@kernel.org,
 aroulin@nvidia.com, anilkaushikwireless@gmail.com, demosthenes.ra@gmail.com,
 eddyz87@gmail.com, emil@etsalapatis.com, hangbin.liu@linux.dev,
 ihor.solodrai@linux.dev, jiayuan.chen@linux.dev, jolsa@kernel.org,
 joe@dama.to, memxor@gmail.com, lirongqing@baidu.com, louis.scalbert@6wind.com,
 mkl@pengutronix.de, martin.lau@linux.dev, mkarsten@uwaterloo.ca,
 mattbobrowski@google.com, michael.bommarito@gmail.com, razor@blackwall.org,
 runyu.xiao@seu.edu.cn, song@kernel.org, linux@leemhuis.info,
 wang.zhan@smartx.com, yonghong.song@linux.dev, n0ps1edzz@gmail.com,
 tianyi.gao@linux.dev
Date: Mon, 23 Nov 2026 03:59:25 +0000
Message-ID: <179540636572.3135.16989356517509282876@kernel.org>
In-Reply-To: <20261119013830.36935-11-tianyi@cloudflare.com>
References: <20261119013830.36935-11-tianyi@cloudflare.com>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] In Documentation/netlink/specs/rt-link.yaml, the new `tx-extra-
  headroom` attribute in the `linkinfo-veth-attrs` attribute set (added…

--

netlink: specs: rt-link: add veth attributes

This adds a linkinfo-veth-attrs attribute set to rt-link.yaml, so YNL can
set and read the veth attributes, including tx-extra-headroom. It also
renames the guard in include/uapi/linux/veth.h to _UAPI__NET_VETH_H_, so
that YNL's get_hdr_inc can pick up the source tree header.

> diff --git a/Documentation/netlink/specs/rt-link.yaml b/Documentation/netlink/specs/rt-link.yaml
> index 81b58633911d6..36dece2517789 100644
> --- a/Documentation/netlink/specs/rt-link.yaml
> +++ b/Documentation/netlink/specs/rt-link.yaml
> @@ -2368,6 +2368,17 @@ attribute-sets:
>          name: mode
>          type: u8
>          enum: ovpn-mode
> +  -
> +    name: linkinfo-veth-attrs
> +    name-prefix: veth-info-
> +    header: linux/veth.h
> +    attributes:
> +      -
> +        name: peer
> +        type: binary
> +      -
> +        name: tx-extra-headroom
> +        type: uint

[Severity: Low]
Should this attribute carry a checks block that matches the kernel policy?

The kernel caps the value in veth_policy in drivers/net/veth.c:

	[VETH_INFO_TX_EXTRA_HEADROOM] =
		NLA_POLICY_MAX(NLA_UINT, NETDEV_TX_EXTRA_HEADROOM_MAX),

include/linux/netdevice.h defines the limit:

	#define NETDEV_TX_EXTRA_HEADROOM_MAX	512

As written, the spec allows any 64-bit value. The kernel rejects anything
above 512 with -ERANGE.

NETDEV_TX_EXTRA_HEADROOM_MAX is not part of uAPI, so the spec can't refer
to it by name. Other attributes in this spec already state kernel limits
as literals, for example txqlen:

        name: txqlen
        type: u32
        checks:
          max: 32767

Would something like this work here?

        name: tx-extra-headroom
        type: uint
        checks:
          max: 512

The selftest later in the series (tx_extra_headroom.py) hardcodes
TX_EXTRA_HEADROOM_MAX = 512 with a comment naming
NETDEV_TX_EXTRA_HEADROOM_MAX. The spec still lists only type: uint at the
end of the series.

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261119013830.36935-1-tianyi%40cloudflare.com
