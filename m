Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795495639;
	b=ceQ5M64tWDXCLL6lHSl6DwqMNbzTKzU3StBf1UqBa+pFI1B064JmDGynpzFFSXWwHfzA
	 b6qkMwcDDM5hX+au3CKL+9bmK3kknSCJs8HleVAiLulkejYTO7+Wprytyiin6XfqYvhA+
	 0h3huEwFt9f/p0xJ0Pae60mtsbJeXCjvO3/27A3MiDxoQu1k5zTx3bG6jiLT1OQIRGxbH
	 DPUhz3yamF1jB+sEMnF2pqZrQpgqkfs4mEYCJGDsKmFuoibf4TubdGRSk+GIxFEPf8H0V
	 IBFHigl1u+/nN9dcdisTw1amo/FSi9oBqRw+tg5pGFuB8reRuX42T8noq1sc+q6VgQA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795495639;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=OS4cwAkdrOJM9aqftGULq94yK43XBxlzuU1sKGr1J28=;
	b=2EnDzmflg+ppC85tNtuLiM6k3pNA3Dz4VW3gmhUk70p3/8G+zT7wDsBf8AA0Gn1HiMzf
	 JHVvLF6wgVKDSRyN2vBLk63sb+JsNqYzU2Lewj7EHXc50b6QcEHtnXLNGiLtU5u1N+1i9
	 2qMOc8lN1EcSNpCZxphjgov42genwM+vnoAzpSZ9lPc7BERtrmdo7FYApMWSWSTXfRapc
	 i9XVeMtDkbN68CFrHv/Tmb20KkXl9va4crrOS65LCys5MNBt9Kd3hamG7jVPbMrfV777D
	 TRU7cGYlMjfTJKjH0yzx+yZuGtYj6HlfIyzEOr8pwdqI4WcJ2pvi/iw9gXwVYEzzsfg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=THzchvPE;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D019606A327;
	Tue, 24 Nov 2026 04:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=THzchvPE
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BE4D1F000D0;
	Tue, 24 Nov 2026 04:47:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795495638;
	bh=OS4cwAkdrOJM9aqftGULq94yK43XBxlzuU1sKGr1J28=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=THzchvPEYk4FK1obRUDHm4Z8RQhtPmy9xBAfT7kG/NmE76GZIoYGSjBTUt7kixgG1
	 UK21RVXEMdnYE/rgAqFEwMntG26eOehr7ckrDHRy0OsEVHnGRocz1DlzXvwHGbQhJU
	 l5iTIBdEt+6JzSKQECTyCPVlEIiURY35VdXBr4u7iUaVbVRF+gfRAssOFLoD6ZzypD
	 Gkq3qlYNplLuXLzAi45sg1HmPta/K3WCmrpeADTi2GTN8SCyoeUSofX5e156L0IU1q
	 PtWlxe6GALGinN4Q6e+cgJ4pQG5ew0CHZ/zvA9XyAfp6AXHVh3Dj8SflF6M2TjZFuC
	 YqRqDx/uuxiBg==
Subject:
 Re: [PATCH net-next] net: gro: skip the checksum of fraglist GRO packets
From: netdev-bot+sashiko@kernel.org
To: rosenp@gmail.com
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, willemb@google.com, horms@kernel.org,
 ncardwell@google.com, kuniyu@google.com, bpf@vger.kernel.org
Date: Tue, 24 Nov 2026 04:47:17 +0000
Message-ID: <179549563774.3135.4436809339791985282@kernel.org>
In-Reply-To: <20261123042735.139550-1-rosenp@gmail.com>
References: <20261123042735.139550-1-rosenp@gmail.com>
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

Thank you for your contribution! Sashiko AI review found 5 potential
issue(s) to consider.

Critical: 0 · High: 3 · Medium: 1 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] tcp6_gro_receive() in net/ipv6/tcpv6_offload.c saves `iph =
  skb_gro_network_header(skb)` at line 62.
- [High] The new fraglist branch in __skb_checksum_complete()
  (net/core/skbuff.c:4167-4170) checks only ip_summed == CHECKSUM_NONE…
- [High] net: gro: CHECKSUM_NONE fraglist GRO skbs break GSO on
  NETIF_F_GSO_FRAGLIST devs
- [Medium] When tcp4_gro_receive()/tcp6_gro_receive() skip
  skb_gro_checksum_validate() for fraglist candidates…
- [Low] The comment above __skb_checksum_complete() (net/core/skbuff.c)
  and the kernel-doc of skb_checksum_complete()…

--

net: gro: skip the checksum of fraglist GRO packets

On NICs without RX checksum offload, this patch skips the software TCP
checksum check in GRO for fraglist candidates and leaves the merged skb
CHECKSUM_NONE. It adds a path to __skb_checksum_complete() that checks
each packet of such an skb against its own headers. tcp_add_backlog() now
verifies the checksum before calling skb_condense().

> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> index e5b0209aec1c9..fc26b230497de 100644
> --- a/net/core/skbuff.c
> +++ b/net/core/skbuff.c
> @@ -4087,6 +4087,68 @@ __sum16 __skb_checksum_complete_head(struct sk_buff *skb, int len)
>  }
>  EXPORT_SYMBOL(__skb_checksum_complete_head);
>  
> +/* Verify the TCP checksum of one packet of a TCP fraglist GRO skb: the
> + * head, whose data starts at or before its TCP header, or one of the skbs on
> + * its frag_list, whose data starts at the payload with the headers in front
> + * of it.
> + */
> +static bool skb_flist_tcp_csum_ok(const struct sk_buff *skb, bool ipv6)
> +{

[ ... ]

> +	off = th - skb->data;
> +	if (off > (int)skb_headlen(skb) || -off > (int)skb_headroom(skb))
> +		return false;
> +
> +	len = skb_pagelen(skb) - off;
> +	csum = 0;
> +	if (skb_checksum_full(skb, off, len, &csum))
> +		return false;

[Severity: High]
Can valid packets fail this check once the head and frag_list no longer
match the packets GRO built?

__skb_checksum_complete() picks the fraglist branch using only ip_summed
and the SKB_GSO_FRAGLIST and SKB_GSO_TCPV4/TCPV6 bits. The expression
skb_pagelen(skb) - off assumes the head still holds only its own packet.
tcp4_gso_segment() checks the geometry before it trusts the frag_list:

net/ipv4/tcp_offload.c:tcp4_gso_segment() {
    ...
		if ((skb_pagelen(skb) - th->doff * 4 == skb_shinfo(skb)->gso_size) &&
		    !(skb_shinfo(skb)->gso_type & SKB_GSO_DODGY))
			return __tcp4_gso_segment_list(skb, features);
    ...
}

There is no similar check here.

For example, a tc ingress BPF program can call bpf_skb_pull_data() with a
length that goes past the first packet:

bpf_skb_pull_data()
  bpf_try_make_writable()
    skb_ensure_writable()
      pskb_may_pull()
        __pskb_pull_tail()     <- frag_list payload moved into the head

gso_type still has SKB_GSO_FRAGLIST. With nf_conntrack_checksum=1, the
default, PRE_ROUTING then runs:

tcp_error()
  nf_checksum()
    nf_ip_checksum()
      __skb_checksum_complete()
        skb_flist_csum_ok()    <- head checksum now covers extra bytes

conntrack logs "bad checksum" and attaches no ct, so the aggregate is
INVALID. If the aggregate is delivered locally through REDIRECT or TPROXY,
tcp_checksum_complete() drops it with SKB_DROP_REASON_TCP_CSUM.

bpf_skb_proto_4_to_6() and bpf_skb_proto_6_to_4() seem to cause a similar
mismatch. They swap SKB_GSO_TCPV4 and SKB_GSO_TCPV6 in gso_type, but the
frag_list members keep their old-family headers.

Before this patch these skbs were CHECKSUM_UNNECESSARY and nothing checked
them again.

The commit message says:

    This covers whatever asks for the checksum later: conntrack with
    nf_conntrack_checksum enabled, and local delivery

It also says that skbs changed by bpf_skb_pull_data() are segmented by
skb_segment() on the way out. That doesn't cover any check made before
egress. The only pull this patch moves after the check is the
skb_condense() call in tcp_add_backlog().

Does this need a geometry check like the one in tcp4_gso_segment(), plus
a defined fallback when the geometry no longer matches?

[ ... ]

> @@ -4102,6 +4164,11 @@ __sum16 __skb_checksum_complete(struct sk_buff *skb)
>  	__wsum csum = 0;
>  	__sum16 sum;
>  
> +	if (unlikely(skb->ip_summed == CHECKSUM_NONE && skb_is_gso(skb) &&
> +		     (skb_shinfo(skb)->gso_type & SKB_GSO_FRAGLIST) &&
> +		     (skb_shinfo(skb)->gso_type & (SKB_GSO_TCPV4 | SKB_GSO_TCPV6))))
> +		return skb_flist_csum_ok(skb) ? 0 : (__force __sum16)1;

[Severity: Low]
This isn't a bug, but should the comment above __skb_checksum_complete()
and the kernel-doc of skb_checksum_complete() in include/linux/skbuff.h
be updated for this branch?

Both describe the same behaviour. The function computes the checksum over
the whole packet plus skb->csum and stores the full checksum back in
skb->csum. It leaves the skb CHECKSUM_COMPLETE and returns the checksum.

This early return ignores skb->csum and returns a made-up 0 or 1. On
success it sets the skb to CHECKSUM_UNNECESSARY. On failure it leaves the
skb CHECKSUM_NONE without calling skb_checksum_complete_failed() or
setting csum_valid.

The current callers (nf_ip_checksum(), nf_ip6_checksum() and
tcp_checksum_complete()) only test for zero. So this is a documentation
mismatch, not a functional problem.

> diff --git a/net/ipv4/tcp_offload.c b/net/ipv4/tcp_offload.c
> index b84fcd07c7230..d38eaf24c3c58 100644
> --- a/net/ipv4/tcp_offload.c
> +++ b/net/ipv4/tcp_offload.c

[ ... ]

> @@ -433,10 +436,21 @@ static void tcp4_check_fraglist_gro(struct list_head *head, struct sk_buff *skb,
>  INDIRECT_CALLABLE_SCOPE
>  struct sk_buff *tcp4_gro_receive(struct list_head *head, struct sk_buff *skb)
>  {

[ ... ]

> +	/* Don't bother verifying checksum if we're going to flush anyway.
> +	 * A fraglist skb is verified one packet at a time if anything asks
> +	 * for it, see skb_gro_flist_skip_csum().
> +	 */
> +	if (!NAPI_GRO_CB(skb)->flush && !skb_gro_flist_skip_csum(skb) &&
>  	    skb_gro_checksum_validate(skb, IPPROTO_TCP,
>  				      inet_gro_compute_pseudo))
>  		goto flush;

[Severity: Medium]
What happens to valid packets that get chained to a corrupted one here?

Before this patch, a packet with a bad TCP checksum failed
skb_gro_checksum_validate() and went to flush, so it was handled on its
own.

With the check skipped, the next non-GSO packet inherits is_flist from p
in tcp4_check_fraglist_gro(). Both packets are CHECKSUM_NONE, so this test
in tcp_gro_receive() doesn't stop the merge:

		flush |= skb->ip_summed != p->ip_summed;

skb_gro_receive_list() can then chain the bad packet with up to 63 valid
ones. skb_flist_csum_ok() gives one result for the whole aggregate. With
nf_conntrack_checksum=1, tcp_error() at PRE_ROUTING marks every packet in
it "bad checksum" and attaches no ct.

A "ct state invalid drop" rule then drops all of them. Without such a
rule they are forwarded without NAT, for example SNAT or masquerade
traffic leaving with its private source address. On local delivery,
tcp_checksum_complete() drops all of them.

tcp6_gro_receive() skips the check in the same way.

The commit message says:

    A corrupted packet is then forwarded unchanged and dropped by the
    receiver, as it would be without GRO.

Is that still true when conntrack checksum validation is enabled?

> diff --git a/net/ipv6/tcpv6_offload.c b/net/ipv6/tcpv6_offload.c
> index eec3778855eb8..9c5709b2bf721 100644
> --- a/net/ipv6/tcpv6_offload.c
> +++ b/net/ipv6/tcpv6_offload.c

[ ... ]

> @@ -56,10 +59,23 @@ static void tcp6_check_fraglist_gro(struct list_head *head, struct sk_buff *skb,
>  static __always_inline struct sk_buff *tcp6_gro_receive(struct list_head *head,
>  							struct sk_buff *skb)
>  {
> +	const struct ipv6hdr *iph = skb_gro_network_header(skb);
> +	unsigned int off = skb_gro_offset(skb);
>  	struct tcphdr *th;
>  
> -	/* Don't bother verifying checksum if we're going to flush anyway. */
> +	th = skb_gro_header(skb, off + sizeof(*th), off);
> +	if (unlikely(!th))
> +		goto flush;
> +
> +	if (unlikely(skb->dev->features & NETIF_F_GRO_FRAGLIST))
> +		tcp6_check_fraglist_gro(head, skb, th);
> +
> +	/* Don't bother verifying checksum if we're going to flush anyway.
> +	 * __skb_checksum_complete() can only verify the packets of a fraglist
> +	 * skb without extension headers.
> +	 */
>  	if (!NAPI_GRO_CB(skb)->flush &&
> +	    !(skb_gro_flist_skip_csum(skb) && iph->nexthdr == IPPROTO_TCP) &&
>  	    skb_gro_checksum_validate(skb, IPPROTO_TCP,
>  				      ip6_gro_compute_pseudo))
>  		goto flush;

[Severity: High]
Can iph point to freed memory by the time iph->nexthdr is read?

iph comes from skb_gro_network_header() before skb_gro_header() runs. If
frag0_len is shorter than off + sizeof(*th), skb_gro_header() calls
skb_gro_header_slow() -> pskb_may_pull() -> __pskb_pull_tail().
include/net/gro.h documents that this can invalidate frag0:

/* A pull can release the page fragment frag0 points to, or reallocate
 * skb->head, even if it fails. Call this before the pull, to make sure later
 * skb_gro_header() and skb_gro_network_header() calls no longer use frag0.
 */

If headlen is non-zero, iph points into skb->head, and pskb_expand_head()
frees that buffer when tailroom is short. If headlen is zero, iph points
into frags[0], which skb_frag_unref() releases when the whole fragment is
pulled.

The read only happens in the case this patch targets: NETIF_F_GRO_FRAGLIST
set, no local socket, and CHECKSUM_NONE. The value it reads decides
whether the checksum is skipped.

Before this patch, tcp6_check_fraglist_gro() and ip6_gro_compute_pseudo()
both fetched the network header after the pull. The IPv4 side still does.
Commit 98d949a15ff9d3 ("net: gro: invalidate frag0 after a pull") fixed
the same kind of problem for UDP and ESP.

Could iph be fetched with skb_gro_network_header() after skb_gro_header()
succeeds instead?

[ ... ]

> @@ -465,7 +476,9 @@ INDIRECT_CALLABLE_SCOPE int tcp4_gro_complete(struct sk_buff *skb, int thoff)
>  		skb_shinfo(skb)->gso_type |= SKB_GSO_FRAGLIST | SKB_GSO_TCPV4;
>  		skb_shinfo(skb)->gso_segs = NAPI_GRO_CB(skb)->count;
>  
> -		__skb_incr_checksum_unnecessary(skb);
> +		/* not verified, see skb_gro_flist_skip_csum() */
> +		if (skb->ip_summed != CHECKSUM_NONE)
> +			__skb_incr_checksum_unnecessary(skb);
>  
>  		return 0;
>  	}

[Severity: High]
Does leaving the aggregate CHECKSUM_NONE defeat fraglist GSO
passthrough on the way out?

netif_needs_gso() asks for software segmentation of any GSO skb that
is neither CHECKSUM_PARTIAL nor CHECKSUM_UNNECESSARY, even when
skb_gso_ok() says the device can take it as is:

include/linux/netdevice.h:netif_needs_gso() {
	return skb_is_gso(skb) && (!skb_gso_ok(skb, features) ||
		unlikely((skb->ip_summed != CHECKSUM_PARTIAL) &&
			 (skb->ip_summed != CHECKSUM_UNNECESSARY)));
}

Before this patch, tcp4_gro_complete() and tcp6_gro_complete() marked
the fraglist skb CHECKSUM_UNNECESSARY, so it passed through bridge,
VLAN, veth, VRF, bond and tunnel devices, which advertise
NETIF_F_GSO_FRAGLIST and NETIF_F_FRAGLIST, and was only split at the
real egress device. Now validate_xmit_skb() on the first of those
devices calls skb_gso_segment(), and tcp4_gso_segment() or
tcp6_gso_segment() hands it to __tcp4_gso_segment_list() or
__tcp6_gso_segment_list(). skb_segment_list() doesn't look at the
device features, so the aggregate is split into up to 64 packets
right there, and everything after that point (bridge forwarding, VLAN
tagging, tunnel encapsulation) runs once per packet again.

On OpenWrt, forwarded traffic normally crosses br-lan, so this hits
the setup the patch is aimed at. Was there a bridge on the path for
the MX65 numbers?

It gets worse when the geometry was changed after GRO, for example by
bpf_skb_pull_data(). tcp4_gso_segment() then skips the list path,
sets CHECKSUM_PARTIAL, writes a pseudo-header checksum into th->check
with __tcp_v4_send_check() and calls tcp_gso_segment(). With
NETIF_F_GSO_FRAGLIST, NETIF_F_TSO and NETIF_F_FRAGLIST in features,
the skb_gso_ok(skb, features | NETIF_F_GSO_ROBUST) test there is
true, so it returns NULL without calling skb_segment().
validate_xmit_skb() then sends the original skb on unsegmented, but
now CHECKSUM_PARTIAL. If that device is a veth, the peer sees
CHECKSUM_PARTIAL, skb_csum_unnecessary() returns true, and a local
socket in that namespace accepts payload that nothing verified. The
new skb_flist_csum_ok() path can't catch it either, since the skb is
no longer CHECKSUM_NONE. tcp6_gso_segment() does the same through
__tcp_v6_send_check().

Should netif_needs_gso() handle the SKB_GSO_FRAGLIST case, or does the
unverified state need a marker other than CHECKSUM_NONE, so the
transmit path keeps treating these skbs as it did before?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261123042735.139550-1-rosenp%40gmail.com
