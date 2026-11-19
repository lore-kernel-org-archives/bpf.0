Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795118566;
	b=imzFh4cytuEwEa9dR1RWmtvotlykXvjBZizyF6I/t/RdeUzGHOHNMk3cSXBWjVTR/ePB
	 jZ2qUYTi9OzK1Iibj1lbgvXuIWk3DODWCLZTEQoBaKiFFI2xCutM+9VOmktuhgD+2uR2o
	 RZXAalCi4g/NrM9/6TgKpKZ9xL6+b+YKzbjmolI6wfq5rc5asSnmAU8GMoV0hbPgAgEgM
	 pt/sFmJPpMMX76mMnfAWUpCKmkN99GXVFfmvySpEzHghrSudoMVRVBAgUHAGfodgw4hCW
	 VtcXsOCh6Ld4sJ3dmr+T9tk0GHewzMI+LHmua/auVv9AUJUqdJcoGKQIanWnX+xfZOw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795118566;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=wslAM8nQE+b2uA4VEkGTEustCwR0csjpfEvwACbY9dM=;
	b=xEv3mhS3l2m22kY8G6p7eLGslsUJAlJz9RMWr/wh5WxlvYH6dkH30YL1fnwHkWp3mORJ
	 cvAqQjr1jlrRtGxfkpesRS4tR4HOPLBoSWKltnkNvHFSeuYKNJR+D0/u+/2XQLdI06hv1
	 pBGCOJPLcWdeXazV7UOMM+P2kqsT2qFLn6iDsKaMzzJ65whknMEVChRwOrHivqTUr/BcI
	 7PP2YS0JsdQ7uiVUu82Y9C3YjRjme7Ca1KoVyTF3P1vLV6OikQYN2lkcMKdicsJO7NiHv
	 0XTshN9oeKauBr5HgAZ94Kb0w7nXvxZht6ePdV+7/FWMshBh6nGfxa+lzi+IIE6xAow==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jJVkPAhW;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49C36606A320;
	Thu, 19 Nov 2026 20:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jJVkPAhW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9922C1F000C4;
	Thu, 19 Nov 2026 20:02:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795118565;
	bh=wslAM8nQE+b2uA4VEkGTEustCwR0csjpfEvwACbY9dM=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=jJVkPAhWpF5ymMQJQiPUjHPkuaUtvtgNvAkitvtg4baKmfIzzWeP9okgzdbSGGYYw
	 RNNxYk7LyijAgyI8KE2RwfkeNQuyOyc/uhRJTqiPBMz40lcKWOSX1XHgzT1yXA+FtX
	 TqNAp4h/XqjFebBLlKQLysQNN2jRd5qmzkaP8KtXuyO3OW3llkRUfomJ9cmjlafkqu
	 vqht/RP0UA3xM0wOuz+G4xpFoekH+9HC577OOLnhbISTcmQQvuu3fSREU6GKY9/NYK
	 AT49nyvkYC6OX4f0BLbmn/jS3FVtWjAYgUSFe3EnPrf0DdiRw2cq22ay8bFf/ijOnC
	 WR39bOR8x74EQ==
Subject: Re: [PATCH net-next v4 3/4] netfilter: nft_fwd_netdev: drop the stale
 dst when steering to a device
From: netdev-bot+sashiko@kernel.org
To: jhs@mojatatu.com
Cc: netdev@vger.kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
 sdf@fomichev.me, martin.lau@linux.dev, ast@kernel.org, andrii@kernel.org,
 eddyz87@gmail.com, memxor@gmail.com, song@kernel.org, yonghong.song@linux.dev,
 jolsa@kernel.org, emil@etsalapatis.com, ihor.solodrai@linux.dev,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, bpf@vger.kernel.org, jiri@resnulli.us, victor@mojatatu.com,
 sashiko-bot@kernel.org
Date: Thu, 19 Nov 2026 20:02:44 +0000
Message-ID: <179511856420.3136.2766397873785932023@kernel.org>
In-Reply-To: <CORE-9NOG.v4.r0.20261116135311-3@mojatatu.com>
References: <CORE-9NOG.v4.r0.20261116135311-3@mojatatu.com>
X-sashiko-severity: Medium
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

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] nft_fwd_neigh_eval() (net/netfilter/nft_fwd_netdev.c:164-167)
  now calls skb_dst_drop_keep_metadata() before the packet is sent to…
- [Low] This patch fixes a user-visible bug: a frame parked on the
  configured device's incomplete neighbour is later sent on that device…

--

netfilter: nft_fwd_netdev: drop the stale dst when steering to a device

This patch releases the skb dst in nft_fwd_neigh_eval() before switching
skb->dev and calling neigh_xmit(). Without it, a packet parked on an
incomplete neighbour is later rebuilt from the routed device's neighbour.
The release uses skb_dst_drop_keep_metadata(), so LWT encap parameters
move onto a metadata dst. If that allocation fails, the packet is dropped.

Link: https://lore.kernel.org/netdev/QDISC-6HS9.v3.r0.20261103062649-2@mojatatu.com/
Link: https://lore.kernel.org/netdev/avTfQjFQYR2NNdRg@chamomile/

> Reported-by: Sashiko (nipa) <sashiko-bot@kernel.org>
> Closes: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/QDISC-6HS9.v3.r0.20261103062649-2@mojatatu.com
> Link: https://lore.kernel.org/netdev/QDISC-6HS9.v3.r0.20261103062649-2@mojatatu.com/
> Link: https://lore.kernel.org/netdev/avTfQjFQYR2NNdRg@chamomile/
> Reviewed-by: Pablo Neira Ayuso <pablo@netfilter.org>
> Reviewed-by: Victor Nogueira <victor@mojatatu.com>
> Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>

[Severity: Low]
Should this have a Fixes: tag? The skb->dev switch and the neigh_xmit()
call in nft_fwd_neigh_eval(), which run with the stale dst still attached,
come from:

Fixes: d32de98ea70f ("netfilter: nft_fwd_netdev: allow to forward packets via neighbour layer")

The bug can be seen in neigh_update_process_arp_queue(). It looks the
neighbour up again from skb_dst(skb) using dst_neigh_lookup_skb(), while
skb->dev is already the configured device.

The commit message also doesn't list the in-series prerequisites:

  - It won't build without "net: dst: keep the LWT metadata of a dropped
    route", which adds skb_dst_drop_keep_metadata().

  - According to "net: xfrm: interface: restore dst_orig on every xfrm
    interface", the netdev egress fwd to an xfrm interface path hits a
    skb_dst_set() WARN in xfrmi_xmit2() unless that commit is also present.
    With CONFIG_DEBUG_NET=y and panic_on_warn, that WARN becomes a panic.

Could these dependencies be noted, so a stable backport doesn't take this
patch without them?

> diff --git a/net/netfilter/nft_fwd_netdev.c b/net/netfilter/nft_fwd_netdev.c
> index 7447da931a957..f486c7be385cf 100644
> --- a/net/netfilter/nft_fwd_netdev.c
> +++ b/net/netfilter/nft_fwd_netdev.c

[ ... ]

> @@ -160,6 +161,11 @@ static void nft_fwd_neigh_eval(const struct nft_expr *expr,
>  		goto out;
>  	}
>  
> +	if (!skb_dst_drop_keep_metadata(skb)) {
         ^^^^

[Severity: Medium]
Can this give an NBMA tunnel a metadata_dst that it then reads as a
struct rtable?

When the route carries an LWT encap (LWTUNNEL_ENCAP_IP, LWTUNNEL_ENCAP_IP6
or LWTUNNEL_ENCAP_XFRM), skb_dst_drop_keep_metadata() replaces the rtable
with a metadata_dst built on dst_blackhole_ops.

The configured device can be an NBMA tunnel: ipip or gre with no remote,
or ip6tnl with raddr :: and no collect_md. In that case the packet reaches
the tunnel like this:

nft_fwd_neigh_eval()
  neigh_xmit()
    neigh_direct_output()
      dev_queue_xmit()
        ip_tunnel_xmit() / ip6_tnl_xmit()

ip_tunnel_xmit() takes the md branch only when tun_info is AF_INET with a
nonzero key.u.ipv4.dst. For any other IPv4 payload it falls back to this:

net/ipv4/ip_tunnel.c:ip_tunnel_xmit() {
    ...
	} else if (payload_protocol == htons(ETH_P_IP)) {
		rt = skb_rtable(skb);
		dst = rt_nexthop(rt, inner_iph->daddr);
    ...
}

Two configurations reach that fallback. One is encap ip6 on an IPv4
route. The other is encap ip with no dst, which ip_tun_build_state()
accepts because LWTUNNEL_IP_DST is optional.

In its NBMA IPv4-payload branch, ip6_tnl_xmit() never checks tun_info:

net/ipv6/ip6_tunnel.c:ip6_tnl_xmit() {
    ...
		const struct rtable *rt = skb_rtable(skb);

		if (!rt)
			goto tx_err_link_failure;

		if (rt->rt_gw_family == AF_INET6)
			memcpy(&fl6->daddr, &rt->rt_gw6, sizeof(fl6->daddr));
    ...
}

On 64-bit, rt_gw_family overlays the first octet of the tunnel key's IPv4
source address, and rt_gw6 starts at key.u.ipv4.dst.

Take "encap ip id 42 src 10.20.0.2 dst 192.0.2.9" on the routed device and
a fwd rule to an NBMA ip6tnl. The leading 10 equals AF_INET6, so the
payload would be encapsulated towards c000:209::, an address built from
the key bytes.

For METADATA_XFRM, rt_gw_family overlays the low byte of the dst_orig
pointer, so the result depends on allocation alignment, not on a check.

All reads stay inside the metadata_dst allocation. The result is a wrong
outer destination, not an out-of-bounds access. Before this patch, the
same configuration gave the tunnel a real rtable.

The commit message mentions this case:

    The release here can leave one behind as well, when the parameters a
    route carries are not usable for the payload. The cast is repaired
    separately.

However, no patch in this series seems to touch net/ipv4/ or net/ipv6/.
Should the skb_rtable() fix go in before this patch, or with it, so the
fwd path doesn't add a new way to reach the cast?

> +		verdict = NF_DROP;
> +		goto out;
> +	}
> +
>  	local_bh_disable();
>  	if (nf_dev_xmit_recursion()) {
>  		local_bh_enable();

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/CORE-9NOG.v4.r0.20261116135311%40mojatatu.com
