Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795118568;
	b=tzySdFuYWzmJ8oD5G3Hh9AFMmr4CWStu1fpqhoUjA0xdKFsUdTt9A80F5rbLHukeslTB
	 /oGKrbIjTS/vFyR77OD/6KvHrrHvAHIv8+mC2xDSPsCPjed5vo55Jizqm9vHJUNwm++Lb
	 7y6b+gLrHxjy/lRQOlIvtrxTa/PEoZ1XnGkojtcEVcw2ESAGEeais4P4yPaPorjtOHcgw
	 ibFXjaoVNsYcPSbP5j3Ttpid7gBQbgkxJetm2elmoPRJZiM5cPtrk6Q0uJMMo9wimVU0i
	 C4AR6f/PRiHvYhaodR7OJhkN1j88loEGb0WchP++69tRTSE6HJG1oN0d7lOKygmZgcw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795118568;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=RKK0OI96pECkHppROmIdESDMy4NSloW0JuhxhC44a4A=;
	b=joWzqAMuDv3sCA9XffJ+1RY5nBGXEA89Z7bMRHiuSNc6B84JnWmS0dmUBgfYRQTQrgBK
	 1S/O4iPrWi/xhPk9xZ27aiZSu4MOBh354gaKchRcWPA89ioOatBuLC04qs6lhV4RNGxsI
	 YrM/F0wKROVmwXzNfM6TJrUdBa8qpensoNaOy3Mc8j6OJlljjLz/ANorxOShEC1+W1MLW
	 Aj3hur5hapacmkw8SoBlNfB912HJnKYUpHTcrviam/ncc2S20ulndV96UpebtdY4FMnKA
	 4gFGZY0UL5IKUU9Cl+k9W4eqDbhR00O/ohGs6N7BwRLJjAXgi8Pj8PXzdbwRnKbStyA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PpH7DsWN;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E09C2606A332;
	Thu, 19 Nov 2026 20:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PpH7DsWN
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62C9D1F000C7;
	Thu, 19 Nov 2026 20:02:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795118567;
	bh=RKK0OI96pECkHppROmIdESDMy4NSloW0JuhxhC44a4A=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=PpH7DsWNKZZ5nDxLnHjF/22h6Rz55sVIj+y3RERJctzTeuY3SOwzt11Ct10nU6qbH
	 HcxcPbjuGTh3gK9vCn3g7/BLeJVspYOvxE5j1gsVGCHyiP1Om1UT8IE+Bo6u5T5KFb
	 KBfFMsWRuKIfcUsizdCPgpJh4oSR4fxCa+OntDcPhz0YIcaH3vdl6ujfzhgXXDyHoj
	 XfdA7QMIE/T3ZetULJxEESYQThEO1iv/kOFhDno1uF55cI3IRxnFY2aLkN9Lwz6Bcu
	 rL8Oa07Oxvy24cRTiDMZGrFQDNFSUhG3qw0P0wpyEBN+oQ7lnPwvHsCAz9eAZbpthW
	 zV3YE5OI5MXUA==
Subject: Re: [PATCH net-next v4 4/4] bpf: drop the stale dst when redirecting
 to an explicit nexthop
From: netdev-bot+sashiko@kernel.org
To: jhs@mojatatu.com
Cc: netdev@vger.kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
 sdf@fomichev.me, martin.lau@linux.dev, ast@kernel.org, andrii@kernel.org,
 eddyz87@gmail.com, memxor@gmail.com, song@kernel.org, yonghong.song@linux.dev,
 jolsa@kernel.org, emil@etsalapatis.com, ihor.solodrai@linux.dev,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, bpf@vger.kernel.org, jiri@resnulli.us, victor@mojatatu.com,
 sashiko-bot@kernel.org
Date: Thu, 19 Nov 2026 20:02:45 +0000
Message-ID: <179511856597.3136.7846835490904436138@kernel.org>
In-Reply-To: <CORE-9NOG.v4.r0.20261116135311-4@mojatatu.com>
References: <CORE-9NOG.v4.r0.20261116135311-4@mojatatu.com>
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

- [Medium] In the explicit-nexthop branch of __bpf_redirect_neigh_v4(),
  the new skb_dst_drop_keep_metadata() call can replace a real struct…
- [Low] The patch fixes a long-standing, user-visible bug but has no
  Fixes: tag and no Cc: stable.

--

bpf: drop the stale dst when redirecting to an explicit nexthop

This patch changes __bpf_redirect_neigh_v4() and __bpf_redirect_neigh_v6()
so they release the arrival dst through skb_dst_drop_keep_metadata() when
the BPF program supplies an explicit nexthop. Without it, a packet parked
on the target device's incomplete neighbour can later leave with the
original device's link-layer header. Encapsulation parameters carried by
the route are moved onto a metadata dst.

Link: https://lore.kernel.org/netdev/QDISC-6HS9.v3.r0.20261103062649-2@mojatatu.com/
Link: https://lore.kernel.org/netdev/avTfQjFQYR2NNdRg@chamomile/

> diff --git a/net/core/filter.c b/net/core/filter.c
> index bd98d29ed7f8f..ae5346d6abd23 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -2318,6 +2318,8 @@ static int __bpf_redirect_neigh_v6(struct sk_buff *skb, struct net_device *dev,
>  		skb_dst_set(skb, dst);
>  	} else if (nh->nh_family != AF_INET6) {
>  		goto out_drop;
> +	} else if (!skb_dst_drop_keep_metadata(skb)) {
> +		goto out_drop;
>  	}
>  
>  	err = bpf_out_neigh_v6(net, skb, dev, nh);

[Severity: Low]
Should this patch carry a Fixes: tag, and maybe Cc: stable?

The nh != NULL branch in __bpf_redirect_neigh_v4() and
__bpf_redirect_neigh_v6() skips the FIB lookup and keeps the incoming
dst. That branch appears to come from commit ba452c9e996d ("bpf: Fix
bpf_redirect_neigh helper api to support supplying nexthop"). Before that
commit, bpf_redirect_neigh() always did a FIB lookup on the target device
and installed the resulting route.

The commit message gives a reproducer that puts wrong addresses on the
wire. Would a tag like this one help stable trees that carry ba452c9e996d
pick up the fix?

Fixes: ba452c9e996d ("bpf: Fix bpf_redirect_neigh helper api to support supplying nexthop")

> @@ -2433,6 +2435,8 @@ static int __bpf_redirect_neigh_v4(struct sk_buff *skb, struct net_device *dev,
>  
>  		skb_dst_drop(skb);
>  		skb_dst_set(skb, &rt->dst);
> +	} else if (!skb_dst_drop_keep_metadata(skb)) {
> +		goto out_drop;
>  	}
>  
>  	err = bpf_out_neigh_v4(net, skb, dev, nh);

[Severity: Medium]
Can this pass a metadata_dst to code that still casts the skb dst to a
struct rtable?

Suppose the arrival route has lwtstate of type LWTUNNEL_ENCAP_IP,
LWTUNNEL_ENCAP_IP6 or LWTUNNEL_ENCAP_XFRM. Then
skb_dst_drop_keep_metadata() replaces the rtable with a METADATA_IP_TUNNEL
or METADATA_XFRM dst, and that dst uses dst_blackhole_ops:

net/core/dst.c:skb_dst_drop_keep_metadata() {
    ...
		md_dst = metadata_dst_alloc(src->options_len,
					    METADATA_IP_TUNNEL, GFP_ATOMIC);
    ...
	skb_dst_drop(skb);
	if (md_dst)
		skb_dst_set(skb, &md_dst->dst);
    ...
}

If the redirect target is a non-collect_md NBMA tunnel, its transmit path
still calls skb_rtable() on that dst. For an IPv4 payload with raddr set
to any:

net/ipv6/ip6_tunnel.c:ip6_tnl_xmit() {
    ...
		} else if (payload_protocol == htons(ETH_P_IP)) {
			const struct rtable *rt = skb_rtable(skb);

			if (!rt)
				goto tx_err_link_failure;

			if (rt->rt_gw_family == AF_INET6)
				memcpy(&fl6->daddr, &rt->rt_gw6, sizeof(fl6->daddr));
		}
    ...
}

ip_tunnel_xmit() falls back the same way when skb_tunnel_info() gives no
usable AF_INET key dst. That covers METADATA_XFRM, an AF_INET6 key from
LWTUNNEL_ENCAP_IP6 on an IPv4 route, and a key.u.ipv4.dst of zero:

net/ipv4/ip_tunnel.c:ip_tunnel_xmit() {
    ...
		} else if (payload_protocol == htons(ETH_P_IP)) {
			rt = skb_rtable(skb);
			dst = rt_nexthop(rt, inner_iph->daddr);
		}
    ...
}

On 64-bit, rt_gw_family and rt_gw4/rt_gw6 land on the tun_info.key
address fields in the metadata_dst union. So rt_gw_family reads the first
byte of key.u.ipv4.src, and rt_gw6 starts at key.u.ipv4.dst.

Here is an example. An IPv4 route carries "encap ip ... src 10.x.x.x dst
D", and a tc egress program redirects with a supplied nexthop to an NBMA
ip4ip6 tunnel. Then rt_gw_family reads as 10, which is AF_INET6.
ip6_tnl_xmit() copies 16 bytes starting at key.u.ipv4.dst into
fl6->daddr, and the packet is encapsulated towards an outer IPv6 address
made of tunnel key bytes.

Before this patch the skb kept the real rtable on this path, so the cast
read real route fields.

The METADATA_XFRM layout does not seem to match AF_INET or AF_INET6.
IPv6 payloads coming from __bpf_redirect_neigh_v6() look like they are
dropped, because dst_blackhole_neigh_lookup() returns NULL. So this looks
limited to IPv4 payloads in the IP/IP6 encap case.

The commit message says:

  The release here can leave one behind as well, when the parameters a
  route carries are not usable for the payload. The cast is repaired
  separately.

ip_tunnel_xmit() and ip6_tnl_xmit() are unchanged at this commit. Should
this patch go after the skb_rtable() fix, or include it? Otherwise this
path is exposed until that fix lands.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/CORE-9NOG.v4.r0.20261116135311%40mojatatu.com
