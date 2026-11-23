Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795406344;
	b=ZSO9PRbbgjLgycahuN85/j1QBj2P+LvFsComxrzsN7rvyF0LRiBZ53AuDNM1Lbe9b9Kh
	 Kf8PFYHjjn30ZNcNFn/uzr8OqfFW1snMpnIDUhv5i35JysqhV1/3kojA0J3JtUFXasFFg
	 7aSFtXuU05MNKWN97duFDpXKg6XiKkTSOT0y0G9MyJnUKJPULZmXKAPmQ1NWie1HNOjmv
	 2Z4BBnA5L48eYl1Ka6tRVJss/CVzyjGbDZ71pQZ/nJ8OowKpfBjRQBbCYhYc+NiaUdgmR
	 +YUhm+hV7WfKSxf2xQj9pEnKS12vDGmtGsogUUl1D7pCQ8ul5XRXxE2sUI6wKos5koQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795406344;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=B3cIwgW8xrh8Ndjtv3N49JH+sVnVexWtWgTwsy9Ru1w=;
	b=LP0dtx9CHSwI34l1p3UHaCLUJd0/RVkuL4zEgO+Rg8rQz0iDHGqwmQoFD2us++cH4UTQ
	 2/2A539OiVEAyKVPxG3WCsXLXdao2lB7T6cwHdD+680HPV9xozC714ruTJUmWFdDOmaZm
	 JDFyMuxB9fsxMFztSNMb2v4KFNnqPdcnDiM3/I8mSqtdtQwx3OrFaLG1rtjLDyP2Si/fv
	 UABNwA6fjgysUiG44+hEvIRPOdck8ylqak4pQ4J8X7wr4wlvjpAUbSDRbuvXz9bY0vN2U
	 FuEEs6dKnDPMujU0FP5jxPEAmii45mvjPto9TmE4d1r/7+ggnWdpxZReNuBDuS4S6ZA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=O97asVKD;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84266606A31A;
	Mon, 23 Nov 2026 03:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=O97asVKD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9ED9A1F000C6;
	Mon, 23 Nov 2026 03:59:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795406344;
	bh=B3cIwgW8xrh8Ndjtv3N49JH+sVnVexWtWgTwsy9Ru1w=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=O97asVKDwkxOeeadFeh3J9aPbXrLb+FCaT6AqdP03OlYyX73QkkH0sLQNrvIdeVRk
	 GyZieTnJahFjBX+EFSm2odWmdyjyeEUUr5Q/RbYHCe8Vo88X3Oxda/ynAgXB1higF/
	 VGsxksAIvrawwdjWd4CRhlBEJPW3cFwVZgXehrd8PfdlYuNE25SF+6xWoqt3QtOlM4
	 5TgAdSGRVCAEmWjhE1uUgJ5Jg+93E9wsSu53y1agyNl8IGXMM74MRZs8GOqu1EVfZ7
	 a6E9WEWtBBMXMOIolzew8v/xvWLCHdDh2j4YDInUcEvaPLJUsHCSczPH0FgVyuT6k4
	 ZL9L1f7gnLSGQ==
Subject: Re: [PATCH net-next v2 01/11] net: add tx_extra_headroom and
 netdev_get_alloc_headroom()
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
Date: Mon, 23 Nov 2026 03:59:00 +0000
Message-ID: <179540634013.3135.970023281433843364@kernel.org>
In-Reply-To: <20261119013830.36935-2-tianyi@cloudflare.com>
References: <20261119013830.36935-2-tianyi@cloudflare.com>
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

- [Low] At this commit, Documentation/networking/netdevices.rst says
  tx_extra_headroom is "at most 512 bytes" and include/linux/netdevice.h…
- [Low] At this commit, the new documentation describes behaviour that is
  not implemented yet.

--

net: add tx_extra_headroom and netdev_get_alloc_headroom()

This adds a tx_extra_headroom field to struct net_device. It also adds the
netdev_get_alloc_headroom(), netdev_get_alloc_headroom_hlen() and
netdev_get_alloc_needed_headroom() helpers for sites that allocate locally
generated packets. Nothing sets the field yet (later patches in the series
set it from XDP, TC egress and a veth attribute), and the unused
LL_RESERVED_SPACE_EXTRA() macro is removed.

> diff --git a/Documentation/networking/net_cachelines/net_device.rst b/Documentation/networking/net_cachelines/net_device.rst
> index 7620d3fcb8dce..4341e9e443bab 100644
> --- a/Documentation/networking/net_cachelines/net_device.rst
> +++ b/Documentation/networking/net_cachelines/net_device.rst
> @@ -35,6 +35,7 @@ unsigned_short                      gflags

[ ... ]

>  unsigned_short                      needed_headroom             read_mostly                             LL_RESERVED_SPACE/ip_finish_output2
> +unsigned_short                      tx_extra_headroom           read_mostly                             netdev_get_alloc_headroom/__ip_append_data

[ ... ]

> diff --git a/Documentation/networking/netdevices.rst b/Documentation/networking/netdevices.rst
> index 6a87f09e70158..f593b242da9cc 100644
> --- a/Documentation/networking/netdevices.rst
> +++ b/Documentation/networking/netdevices.rst
> @@ -441,6 +441,19 @@ from a notifier.
>  
>  Drivers **must not** generate nested notifications of the ops-locked types.
>  
> +TX headroom reservation
> +=======================
> +
> +``tx_extra_headroom`` is extra headroom for locally generated packets. The
> +stack adds it when it allocates such a packet for the device, so that
> +headers pushed later, for example at TC egress, fit without a
> +reallocation. It is at most 512 bytes.

[Severity: Low]
Is this text accurate at this point in the series? This commit does not
convert any allocation site. __ip_append_data() still sizes its headroom
with LL_RESERVED_SPACE(), and nothing calls the new
netdev_get_alloc_headroom*() helpers yet.

The net_cachelines/net_device.rst row above names __ip_append_data as a
reader of tx_extra_headroom. That is also only true after the next patch.

This changes nothing at runtime, because the field is always 0 here. The
next commit, "net: reserve extra TX headroom for local egress", converts
__ip_append_data(), __ip6_append_data(), raw_send_hdrinc(),
rawv6_send_hdrinc(), the AF_PACKET paths and AF_XDP copy mode. After that
commit the docs match the code.

Could these documentation updates move into that patch, so the docs match
the code at every bisect point?

[ ... ]

> diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
> index 0325c6f2a7d14..392e6fc81e347 100644
> --- a/include/linux/netdevice.h
> +++ b/include/linux/netdevice.h

[ ... ]

> @@ -2196,6 +2195,8 @@ struct net_device {
>  	 */
>  	unsigned int		mtu;
>  	unsigned short		needed_headroom;
> +#define NETDEV_TX_EXTRA_HEADROOM_MAX	512
> +	unsigned short		tx_extra_headroom;

[Severity: Low]
Nothing in this commit uses NETDEV_TX_EXTRA_HEADROOM_MAX. Even so,
netdevices.rst above already says the field "is at most 512 bytes".
Nothing writes tx_extra_headroom yet, so there is nothing to clamp.

Later in the series, every write goes through
__netdev_update_tx_extra_headroom(), which does:

	WRITE_ONCE(dev->tx_extra_headroom,
		   min(tx_extra_headroom, NETDEV_TX_EXTRA_HEADROOM_MAX));

The inputs are bounded as well. bpf_find_tx_extra_headroom() in the
verifier rejects larger values, and veth applies
NLA_POLICY_MAX(NLA_UINT, NETDEV_TX_EXTRA_HEADROOM_MAX) to
VETH_INFO_TX_EXTRA_HEADROOM. So the documented limit holds by the end of
the series.

Would it be cleaner to add the define and the "at most 512 bytes" sentence
in the same patch as the first code that uses them?

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261119013830.36935-1-tianyi%40cloudflare.com
