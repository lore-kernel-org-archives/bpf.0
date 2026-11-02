Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793640066;
	b=PkEbv00YJ5GYhfWCx2A8wGnmGIAor7YTx6RnyilDPdEDj4Hn4gJKQ4bSBb1bB+XRS05X
	 xp2JSuMUoDrmg6W2h1jw7medfpLpeY37XT/UviGkNz5dFmnY4FiJWbdCdHgyuP9IoGpH/
	 Vsp5gHSW9hWj8RoSLaBeC1Q6BlUKs3oSC8KTLw3P82FVGnStTPbNNU2U7SURlVtSMIHTE
	 sNi9waz2vlQFn+WGQYyBJ101g2IWEEU5xoF0eQlcakIvRb7ZH08/s6xIrZm07SvQ22mox
	 xRFkToglzRXwCv+S+Hc8e54smoaooD5FxqjCTqSxhGvAJkNZSIIjYkh92I/ZzOoasdA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793640066;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=/pFPFJHaHSGvC04TAAFnHJVXri/6byTcIoteC2lWvuc=;
	b=fPFfC1JOnaXNtnlUQRUOq2wNtw7koExE3k6EuTb2uw9bsVWFXKpHAonQ4Hh6DrcRAZjg
	 eTgbUHLXCQ6EgHPBru3AKK6aornjL25c9xFU0sJ2QEnQvCFZikrs00oBPURCYA2SjtVUy
	 RteAY722mFybrSK2g5mCE7kQ3R7vmO59YpUakKsW2Ywz0cOO8MCKsK42dV34YUhPrwIRT
	 6OQ/TalXFXhYAmK8MpBZNGrUK9uphBaFLrS5jhprQUD8NX5kJnrKB6LwNUvexiAbXQwuQ
	 jpAjYYWaPlCPDnglX1B5PCLRjKKTeguKNT4qS8jteAI/WCWNdHYams9vkvzDyfjAUHQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hZ9+gCl8;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAFF760A34EB;
	Mon,  2 Nov 2026 17:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hZ9+gCl8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBEEF1F00A16;
	Mon,  2 Nov 2026 17:21:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793640065;
	bh=/pFPFJHaHSGvC04TAAFnHJVXri/6byTcIoteC2lWvuc=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=hZ9+gCl8bIhiQf8qfLRJRScAEGXiDYTUEipY2YRbT7ImrU8XyhnK29u9xyGGSvUmF
	 fnt/19NEUP2In078KjMoqO8xgtJnPLqCU4Fp0CBqLxbvASrC4ZwJobP2CpBaQAeBX3
	 Rd4av9fjy0MScmvzqmjdmZUkM7UEVrroZ9JaDXSmMRMEQVyzfGGz/8I3Rh+FIQPaQf
	 AYTDFrl8XxdBZq9pBX2eIzwSm+zfuPv46U+ZH+4AXRkkZRRG5priEBGeFBJqVhK+4E
	 J6vQyilc1UOnk4kjor/rkMifI+MD7zcSw+mAdavnLFvVwBCzwiiKI70n2ddOzOkpD8
	 5q8GdUOx2o/2g==
Subject: Re: [PATCH net 1/2] net: keep the TCP fixed-ID flags on the header
 they describe
From: netdev-bot+sashiko@kernel.org
To: julius@bairaktaris.de
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, dsahern@kernel.org,
 idosch@nvidia.com, richardbgobert@gmail.com, willemb@google.com,
 ecree.xilinx@gmail.com, daniel@iogearbox.net, john.fastabend@gmail.com,
 sdf@fomichev.me, martin.lau@linux.dev, ast@kernel.org, andrii@kernel.org,
 eddyz87@gmail.com, memxor@gmail.com, song@kernel.org, yonghong.song@linux.dev,
 jolsa@kernel.org, emil@etsalapatis.com, ihor.solodrai@linux.dev,
 shuah@kernel.org, bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Mon, 02 Nov 2026 17:21:03 +0000
Message-ID: <179364006336.3131.6485270170756612370@kernel.org>
In-Reply-To: =?utf-8?q?=3Cf689def2f03965d7e4c48455c3926d7475044910=2E1792857?=
 =?utf-8?q?378=2Egit=2Ejulius=40bairaktaris=2Ede=3E?=
References: =?utf-8?q?=3Cf689def2f03965d7e4c48455c3926d7475044910=2E17928573?=
 =?utf-8?q?78=2Egit=2Ejulius=40bairaktaris=2Ede=3E?=
X-sashiko-severity: High
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

Thank you for your contribution! Sashiko AI review found 6 potential
issue(s) to consider.

Critical: 0 · High: 2 · Medium: 4 (1) · Low: 0 (1)

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] Use-after-free read in ipv6_srh_rcv() (net/ipv6/exthdrs.c).
- [High] One encapsulation site was missed: IPsec tunnel mode with device
  ESP offload.
- [Medium] The patch removes `SKB_GSO_CB(skb)->encap_level = 0;` from
  __skb_udp_tunnel_segment() (and gre_gso_segment()).
- [Medium] iptunnel_handle_offloads() (net/ipv4/ip_tunnel_core.c) moves
  the fixed-ID flag only on the 0 -> 1 transition of skb->encapsulation…
- [Medium] BPF L3-only decapsulation now loses fixed IDs on a round trip
  that worked before.
- [Medium] net: geneve_post_decap_hint() leaves fixed-ID flag on outer
  header after decap

Pre-existing issues:
- [Medium] This problem wasn't introduced by this patch, but
  handle_gso_encap() (net/core/lwt_bpf.c) matches `case IPPROTO_IP:` (0)…
- [Low] This problem wasn't introduced by this patch, but
  bpf_lwt_seg6_action() SEG6_LOCAL_ACTION_END_DT6 (net/core/filter.c)…

--

net: keep the TCP fixed-ID flags on the header they describe

This patch adds skb_gso_fixedid_encap() and skb_gso_fixedid_decap(). They
move SKB_GSO_TCP_FIXEDID between the outer and inner bit when a GSO packet
gains or loses an outer header, and the IP tunnel, BPF and segment routing
encap/decap paths now call them. The patch also stops gre_gso_segment()
and __skb_udp_tunnel_segment() from resetting SKB_GSO_CB(skb)->encap_level.

> diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
> index 6787fcf6ac3e4..00df57cbc05c2 100644
> --- a/include/linux/skbuff.h
> +++ b/include/linux/skbuff.h
> @@ -5337,6 +5337,36 @@ static inline void skb_decrease_gso_size(struct skb_shared_info *shinfo,
>  	shinfo->gso_size -= decrement;
>  }
>  
> +/**
> + * skb_gso_fixedid_encap - move the TCP fixed-ID flag to the inner header
> + * @shinfo: shared info of a GSO packet that becomes encapsulated
> + *
> + * The IPv4 header that SKB_GSO_TCP_FIXEDID describes becomes the inner one,
> + * and the new outer header gets an incrementing ID.
> + */
> +static inline void skb_gso_fixedid_encap(struct skb_shared_info *shinfo)
> +{
> +	unsigned int fixedid = shinfo->gso_type & SKB_GSO_TCP_FIXEDID;
> +
> +	shinfo->gso_type &= ~(SKB_GSO_TCP_FIXEDID | SKB_GSO_TCP_FIXEDID_INNER);
> +	shinfo->gso_type |= fixedid << 1;
> +}

[Severity: High]
Does one more encapsulation site need this helper? IPsec tunnel mode with
ESP device offload seems to make a GSO packet encapsulated without moving
the flag.

In xfrm_output(), when xfrm_dev_offload_ok() succeeds for a GSO skb
without inner_protocol:

net/xfrm/xfrm_output.c:xfrm_output() {
    ...
	skb->encapsulation = 1;

	if (skb_is_gso(skb)) {
		if (skb->inner_protocol && x->props.mode == XFRM_MODE_TUNNEL)
			return xfrm_output_gso(net, sk, skb);

		skb_shinfo(skb)->gso_type |= SKB_GSO_ESP;
		goto out;
	}
    ...
}

xfrm4_tunnel_encap_add() then turns the original IPv4 header into the
inner one and builds a new outer header:

net/xfrm/xfrm_output.c:xfrm4_tunnel_encap_add() {
    ...
	top_iph->frag_off = (flags & XFRM_STATE_NOPMTUDISC) || small_ipv6 ?
		0 : (XFRM_MODE_SKB_CB(skb)->frag_off & htons(IP_DF));
    ...
	ip_select_ident(dev_net(dst->dev), skb, NULL);
    ...
}

Neither function calls skb_gso_fixedid_encap(), so SKB_GSO_TCP_FIXEDID
still describes the old header. With software segmentation, the outer
inet_gso_segment() pass runs with encap_level == 0 and reads:

	fixedid = !!(skb_shinfo(skb)->gso_type & (SKB_GSO_TCP_FIXEDID << encap));

Every segment would then get the same outer ID, possibly with DF clear.

The inner pass goes through
esp4_gso_segment()->xfrm4_tunnel_gso_segment()->skb_eth_gso_segment()
with encap_level > 0. It finds FIXEDID_INNER clear, so the inner IDs
increment.

The commit message describes this same result for
iptunnel_handle_offloads(). Should the xfrm tunnel output path also call
skb_gso_fixedid_encap()?

[ ... ]

> diff --git a/net/core/filter.c b/net/core/filter.c
> index 09c60a58c82ab..4f87a827b25be 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -3718,6 +3718,9 @@ static int bpf_skb_net_grow(struct sk_buff *skb, u32 off, u32 len_diff,
>  	if (skb_is_gso(skb)) {
>  		struct skb_shared_info *shinfo = skb_shinfo(skb);
>  
> +		if (encap)
> +			skb_gso_fixedid_encap(shinfo);
> +
>  		/* Header must be checked, and gso_segs recomputed. */
>  		shinfo->gso_type |= gso_type;
>  		shinfo->gso_segs = 0;
> @@ -3809,9 +3812,11 @@ static int bpf_skb_net_shrink(struct sk_buff *skb, u32 off, u32 len_diff,
>  						  SKB_GSO_GRE_CSUM |
>  						  SKB_GSO_IPXIP4 |
>  						  SKB_GSO_IPXIP6 |
> -						  SKB_GSO_ESP)))
> -				if (skb->encapsulation)
> -					skb->encapsulation = 0;
> +						  SKB_GSO_ESP)) &&
> +			    skb->encapsulation) {
> +				skb_gso_fixedid_decap(shinfo);
> +				skb->encapsulation = 0;
> +			}
>  		}

[Severity: Medium]
Can a BPF encap/decap round trip now lose fixed IDs?

bpf_skb_net_grow() moves the flag to SKB_GSO_TCP_FIXEDID_INNER for any L3
encap. That includes BPF_F_ADJ_ROOM_ENCAP_L3_IPV6 or _IPV4 with no L4
flag.

In bpf_skb_net_shrink(), the flag is only moved back inside:

	if (flags & (BPF_F_ADJ_ROOM_DECAP_L4_MASK |
		     BPF_F_ADJ_ROOM_DECAP_IPXIP_MASK)) {

bpf_skb_adjust_room() still accepts a shrink with only
BPF_F_ADJ_ROOM_DECAP_L3_IPV4/IPV6 set, or with no decap flags at all.
Programs written before the L4/IPXIP decap flags existed do this.

After such a decap the bit stays in FIXEDID_INNER. The top-level
inet_gso_segment() then sees SKB_GSO_TCP_FIXEDID clear, and the segments
get incrementing IDs.

Before this patch, grow left SKB_GSO_TCP_FIXEDID where it was, so the
round trip kept fixed IDs. The commit message says the change avoids
losing fixed IDs for "a packet encapsulated and decapsulated again without
segmentation".

Should the fixed-ID move in bpf_skb_net_shrink() also cover L3-only
decaps?

[Severity: Low]
This isn't a bug introduced by this patch. The segment routing paths in
exthdrs.c are converted to iptunnel_pull_offloads(), but the
SEG6_LOCAL_ACTION_END_DT6 case in bpf_lwt_seg6_action() still
decapsulates IPv6-in-IPv6 by hand:

net/core/filter.c:bpf_lwt_seg6_action() {
    ...
		__skb_pull(skb, hdroff);
		skb_postpull_rcsum(skb, skb_network_header(skb), hdroff);
		skb_reset_network_header(skb);
		skb_reset_transport_header(skb);
		skb->encapsulation = 0;
    ...
}

Tunnel GSO types such as SKB_GSO_IPXIP6 stay set on a packet that is no
longer encapsulated. Both headers are IPv6, so the fixed-ID bits don't
matter here.

Could the leftover gso_type force software GSO on devices without
GSO_IPXIP6? Would iptunnel_pull_offloads() fit here as well?

> diff --git a/net/core/lwt_bpf.c b/net/core/lwt_bpf.c
> index da49364ec63de..4d9faf2cc5de5 100644
> --- a/net/core/lwt_bpf.c
> +++ b/net/core/lwt_bpf.c
> @@ -539,6 +539,7 @@ static int handle_gso_type(struct sk_buff *skb, unsigned int gso_type,
>  {
>  	struct skb_shared_info *shinfo = skb_shinfo(skb);
>  
> +	skb_gso_fixedid_encap(shinfo);
>  	gso_type |= SKB_GSO_DODGY;
>  	shinfo->gso_type |= gso_type;
>  	skb_decrease_gso_size(shinfo, encap_len);

[Severity: Medium]
This is a pre-existing issue, not one introduced by this patch.
handle_gso_encap() matches IPPROTO_IP (0) instead of IPPROTO_IPIP (4):

net/core/lwt_bpf.c:handle_gso_encap() {
    ...
	case IPPROTO_IP:
	case IPPROTO_IPV6:
		if (ipv4)
			return handle_gso_type(skb, SKB_GSO_IPXIP4, encap_len);
    ...
}

Take a TCP GSO packet pushed by bpf_lwt_push_ip_encap() with an outer IPv4
header whose protocol is IPPROTO_IPIP. Does it fall through to the default
case and fail with -EPROTONOSUPPORT, even though the same header works for
non-GSO packets?

Should this be case IPPROTO_IPIP?

[ ... ]

> diff --git a/net/ipv4/ip_tunnel_core.c b/net/ipv4/ip_tunnel_core.c
> index 6c2855adff289..59050229e3499 100644
> --- a/net/ipv4/ip_tunnel_core.c
> +++ b/net/ipv4/ip_tunnel_core.c
> @@ -182,9 +182,10 @@ EXPORT_SYMBOL_GPL(iptunnel_metadata_reply);
>  int iptunnel_handle_offloads(struct sk_buff *skb,
>  			     int gso_type_mask)
>  {
> +	bool encap = !skb->encapsulation;
>  	int err;
>  
> -	if (likely(!skb->encapsulation)) {
> +	if (likely(encap)) {
>  		skb_reset_inner_headers(skb);
>  		skb->encapsulation = 1;
>  	}
> @@ -193,6 +194,8 @@ int iptunnel_handle_offloads(struct sk_buff *skb,
>  		err = skb_header_unclone(skb, GFP_ATOMIC);
>  		if (unlikely(err))
>  			return err;
> +		if (encap)
> +			skb_gso_fixedid_encap(skb_shinfo(skb));
>  		skb_shinfo(skb)->gso_type |= gso_type_mask;
>  		return 0;
>  	}

[Severity: Medium]
What happens here when the GSO skb is already encapsulated?

Forwarded GRE or IPIP traffic merged by gre_gro_complete() or
ipip_gro_complete() arrives with skb->encapsulation = 1. Its
SKB_GSO_TCP_FIXEDID describes its outer header.

Suppose a router sends it into another IPv4 tunnel, for example through
ipip_tunnel_xmit(). Then encap is false here and the flag stays where it
is.

The new outermost header is segmented by inet_gso_segment() with
encap_level == 0, which reads the stale SKB_GSO_TCP_FIXEDID. Every segment
then gets the single ID from ip_select_ident(), possibly with DF clear.

That is the wire behaviour the commit message lists as fixed: "forwarded
into a tunnel gets one outer ID for all segments, also with DF clear".

Two bits can't describe three headers. Would clearing SKB_GSO_TCP_FIXEDID
for the newly pushed outer header in the nested case avoid this? If not,
could the commit message mention the limitation?

> diff --git a/net/ipv4/udp_offload.c b/net/ipv4/udp_offload.c
> index cf07c3c6611a2..edcabe1115a60 100644
> --- a/net/ipv4/udp_offload.c
> +++ b/net/ipv4/udp_offload.c
> @@ -205,7 +205,6 @@ static struct sk_buff *__skb_udp_tunnel_segment(struct sk_buff *skb,
>  
>  	/* setup inner skb. */
>  	skb->encapsulation = 0;
> -	SKB_GSO_CB(skb)->encap_level = 0;
>  	__skb_pull(skb, tnl_hlen);
>  	skb_reset_mac_header(skb);
>  	skb_set_network_header(skb, skb_inner_network_offset(skb));

[Severity: Medium]
Does keeping encap_level here undo the feature override for remote
checksum offload?

With SKB_GSO_TUNNEL_REMCSUM, __skb_udp_tunnel_segment() masks with
hw_enc_features and then adds NETIF_F_HW_CSUM on purpose for the inner
pass:

	features &= skb->dev->hw_enc_features;
	...
	if (remcsum) {
		features &= ~NETIF_F_CSUM_MASK;
		if (!need_csum || offload_csum)
			features |= NETIF_F_HW_CSUM;
	}

encap_level is no longer reset, so the inner inet_gso_segment() (and
ipv6_gso_segment()) masks a second time:

	encap = SKB_GSO_CB(skb)->encap_level > 0;
	if (encap)
		features &= skb->dev->hw_enc_features;

The second mask removes NETIF_F_HW_CSUM whenever hw_enc_features lacks
it. Examples are the register_netdevice() default and NICs that only
advertise IP_CSUM or IPV6_CSUM.

skb_segment() then runs with csum == false, which has three effects:

- It skips the GSO_PARTIAL path.
- It linearizes every segment with shared frags. If __skb_linearize()
  fails, the whole GSO packet is dropped.
- It computes a software checksum per segment. remcsum_offload keeps
  CHECKSUM_PARTIAL, so tcp_gso_segment() throws that checksum away in
  gso_reset_checksum().

The commit message says "the inner pass then also masks the features with
hw_enc_features, which the tunnel handlers have done already". Does that
still hold in the remcsum case?

> diff --git a/net/ipv6/exthdrs.c b/net/ipv6/exthdrs.c
> index 96c8402a27a54..126058772bc5a 100644
> --- a/net/ipv6/exthdrs.c
> +++ b/net/ipv6/exthdrs.c

[ ... ]

> @@ -406,7 +407,10 @@ static int ipv6_srh_rcv(struct sk_buff *skb, struct inet6_dev *idev)
>  
>  			skb_reset_network_header(skb);
>  			skb_reset_transport_header(skb);
> -			skb->encapsulation = 0;
> +			if (iptunnel_pull_offloads(skb)) {
> +				kfree_skb(skb);
> +				return -1;
> +			}
>  			if (hdr->nexthdr == NEXTHDR_IPV4)
                            ^^^^^^^^^^^^

[Severity: High]
Can hdr be stale at this point? It is set at the top of ipv6_srh_rcv():

	hdr = (struct ipv6_sr_hdr *)skb_transport_header(skb);

For a GSO skb, iptunnel_pull_offloads() calls skb_unclone(). If
skb_cloned() is true, that reaches pskb_expand_head(), which allocates a
new head, drops this skb's reference on the old one and switches
skb->head:

iptunnel_pull_offloads()
  skb_unclone(skb, GFP_ATOMIC)
    pskb_expand_head()
      skb_release_data(skb, SKB_CONSUMED)
      skb->head = data

After that, hdr->nexthdr reads a buffer that only the other clone holder
still references. For example, when a packet tap is active, an AF_PACKET
socket on another CPU may already have freed it.

The segments_left != 0 path in this function already reloads hdr after its
own pskb_expand_head().

Should hdr->nexthdr be saved before the iptunnel_pull_offloads() call, or
hdr reloaded after it? ipv6_rpl_srh_rcv() doesn't use hdr after the new
call, so it looks unaffected.

[ ... ]

> diff --git a/include/net/ip_tunnels.h b/include/net/ip_tunnels.h
> --- a/include/net/ip_tunnels.h
> +++ b/include/net/ip_tunnels.h
> @@ -665,6 +665,8 @@ static inline int iptunnel_pull_offloads(struct sk_buff *skb)
>  		err = skb_unclone(skb, GFP_ATOMIC);
>  		if (unlikely(err))
>  			return err;
> +		if (skb->encapsulation)
> +			skb_gso_fixedid_decap(skb_shinfo(skb));
>  		skb_shinfo(skb)->gso_type &= ~(NETIF_F_GSO_ENCAP_ALL >>
>  					       NETIF_F_GSO_SHIFT);
>  	}

[Severity: Medium]
Does the Geneve GRO hint path need a matching skb_gso_fixedid_encap()?

geneve_udp_encap_recv() calls iptunnel_pull_header() and then
geneve_post_decap_hint(). Take a GRO-merged packet that carries a GRO
hint for a nested UDP tunnel. GRO completed the innermost TCP/IPv4
header with encap_mark set, so that header's fixed-ID state sits in
SKB_GSO_TCP_FIXEDID_INNER.

With this patch, iptunnel_pull_offloads() sees skb->encapsulation set
and calls skb_gso_fixedid_decap(), which moves the bit down to
SKB_GSO_TCP_FIXEDID. geneve_post_decap_hint() then does two things:

- It sets skb->encapsulation = 1 again.
- It adds SKB_GSO_UDP_TUNNEL or SKB_GSO_UDP_TUNNEL_CSUM for the nested
  tunnel.

skb->inner_network_header still points at the innermost IPv4 header,
and nothing moves the bit back to SKB_GSO_TCP_FIXEDID_INNER.

When the packet is segmented, the top-level inet_gso_segment() pass
runs with encap_level == 0 on the nested tunnel's outer IPv4 header.
It reads SKB_GSO_TCP_FIXEDID, which really describes the innermost
header. If that outer header has DF set, all segments get the same
ID. If DF is clear, the fixed-ID check in inet_gso_segment() fails the
segmentation and the packet is dropped.

The inner pass then finds SKB_GSO_TCP_FIXEDID_INNER clear. The
innermost IDs that GRO saw as fixed come out incrementing.

If the nested tunnel is decapsulated later instead, the next
iptunnel_pull_offloads() shifts the now clear
SKB_GSO_TCP_FIXEDID_INNER down. The fixed-ID state of the innermost
header is then lost.

Should geneve_post_decap_hint() call skb_gso_fixedid_encap() where it
restores skb->encapsulation? That would put the bit back on the
innermost header and give the nested outer header incrementing IDs.
Or would you rather keep iptunnel_pull_offloads() from moving the flag
when a GRO hint is present?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/cover.1792857378.git.julius%40bairaktaris.de
