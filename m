Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795406348;
	b=TjY2u0R/u9EeQCEmhQlcvFwDr79MSpA/bkF6DqhcmfFDraAyWQcmFPJjM67sCt2r+qDi
	 Kyy8RX96AlODIXCtxzNV77u4S0fKyfLFTiHtd/j8KxzOnWttS/SFHROElCJCHEpM0ysMj
	 ZslJ9Lh+QYgABBrbLEqkbYmpLuSMZaxECajmDRaUHDrU6ddSojzcYGiV3r82RNDDEKFzN
	 mS7pKEi2NKCLTYDD2otbELbXahlduXyo44F+is7FGuk656aPg+U4S61ETU5alx3+aeVET
	 sBhUuUl0FtJMoA8TKmqOMx48U4eTzzGhiSsAta7zMOq97a/MFJC/IXFbVZBHnEBRAUQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795406348;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=40vOlkrsn5bcKQ9hugL/8J0cEKMjQf6aWMjTelXnSIM=;
	b=SCpd7O1M7ANUn99JeYcGiIQAhiw46L6ffkGHOnlAOCh8+xN9KZLB8l0dhuNXsFMJuImg
	 m298KyzLZvNJ3kaB0MQX2GlBiKUOBrPG19l9uZi66TN4Sx4t+9o2eJwDGaiF7ZGWLk4XU
	 pjcskF1wAdjPj11xUswzJptO7aAa3ht7Q+tFQBakXWUFobqTRiiR/mH2Ad0TbDL5L5SCA
	 XZkjnvycRBTkLb+XS/DIOJlRX1b0X9PPrrtNtAE6A3xunWH+Z+ZC7RDvYPBc20VVJjEqR
	 0avsoSpLLPbnPpdXMikUWDlTC/rRUyWSdGEPPjAp0mY7cairw281trYxlmvZY9gaMSg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HwpXlY9m;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96E86606A31E;
	Mon, 23 Nov 2026 03:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HwpXlY9m
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF5911F000C6;
	Mon, 23 Nov 2026 03:59:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795406348;
	bh=40vOlkrsn5bcKQ9hugL/8J0cEKMjQf6aWMjTelXnSIM=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=HwpXlY9m2MBcwL/YhwYMz6mfik0O2RI/E/w2eT2ygBowvuJAhkGJs7nnahQTnKTKP
	 8Ee+z834dDifrLMV3MMs4l9E4kXfenECjvkRwGNuVxKwGHL31wZ1h/lwIDC7ZEqwg1
	 NIWjlnqtgadvmpYubS9ucWnEiBUnYMYRn0obS8Apcm+UA/6crGIcJoBHE/+ZzojP6G
	 F0JqFAh8SpfCI7Mij80dA/1DlL+7oFhD4PDf57ffUCTymAInDj2Y2WS/Idz2lf4ZKw
	 DIdRTBvCz+EYWhCwRlCdQx7BFgnoMC11R4Sntu+VTZJirlUQvl7p9NcjFUdhw3fjib
	 +P3Vz1CgAegyw==
Subject:
 Re: [PATCH net-next v2 02/11] net: reserve extra TX headroom for local egress
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
Date: Mon, 23 Nov 2026 03:59:04 +0000
Message-ID: <179540634443.3135.6612168607080086679@kernel.org>
In-Reply-To: <20261119013830.36935-3-tianyi@cloudflare.com>
References: <20261119013830.36935-3-tianyi@cloudflare.com>
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

- [Low] The documentation for tx_extra_headroom, added in commit "net:
  add tx_extra_headroom and netdev_get_alloc_headroom()", says without…

--

net: reserve extra TX headroom for local egress

This patch makes several allocation paths use the new
netdev_get_alloc_headroom*() helpers instead of LL_RESERVED_SPACE() and
LL_RESERVED_SPACE_EX(). The converted paths are the IPv4/IPv6
append_data paths, the IPv4/IPv6 raw hdrincl paths, the three AF_PACKET
transmit paths and AF_XDP copy mode, so their locally generated packets
get dev->tx_extra_headroom when they are allocated. Paths that expand
existing packets on demand, and the fragmentation paths, are left alone
on purpose.

> diff --git a/net/ipv4/ip_output.c b/net/ipv4/ip_output.c
> index 5d6f5f5fc0ed2..dedea01c6adc6 100644
> --- a/net/ipv4/ip_output.c
> +++ b/net/ipv4/ip_output.c
> @@ -988,7 +988,7 @@ static int __ip_append_data(struct sock *sk,
>  	mtu = cork->gso_size ? IP_MAX_MTU : cork->fragsize;
>  	paged = !!cork->gso_size;
>  
> -	hh_len = LL_RESERVED_SPACE(rt->dst.dev);
> +	hh_len = netdev_get_alloc_headroom(rt->dst.dev);

[Severity: Low]
This isn't a bug, but does the documentation added earlier in the series
promise more than this patch delivers?

Documentation/networking/netdevices.rst says, with no exceptions:

  tx_extra_headroom is extra headroom for locally generated packets. The
  stack adds it when it allocates such a packet for the device, so that
  headers pushed later, for example at TC egress, fit without a
  reallocation.

The comment above netdev_get_alloc_headroom_hlen() in
include/linux/netdevice.h describes the same contract.

This is the only patch in the series that converts allocation sites.
Several places that allocate a locally generated packet for a specific
device still reserve only LL_RESERVED_SPACE(dev) at the end of the
series:

  net/ipv4/arp.c:arp_create()
  net/ipv4/igmp.c:igmpv3_newpack() and igmp_send_report()
  net/ipv4/ipconfig.c:ic_bootp_send_if()
  net/ipv6/mcast.c:mld_newpack() and igmp6_send()
  net/ipv6/ndisc.c:ndisc_alloc_skb()

For example:

net/ipv6/ndisc.c:ndisc_alloc_skb() {
    int hlen = LL_RESERVED_SPACE(dev);
    int tlen = dev->needed_tailroom;
    ...
}

So if tx_extra_headroom is set through the tcx decl tag or
VETH_INFO_TX_EXTRA_HEADROOM, ARP, ND, IGMP and MLD packets will still be
reallocated by bpf_skb_adjust_room(), or copied for XDP on the veth
peer.

Could the general sentence list the covered paths instead? A later
paragraph in the same section already lists UDP, raw, AF_PACKET and
AF_XDP copy mode for the XDP case. Another option would be to convert
these allocation sites as well.

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261119013830.36935-1-tianyi%40cloudflare.com
