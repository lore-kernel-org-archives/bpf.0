Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792901808;
	b=Y54YLG8Dk9mEthvXDS5YEtyzc4GNQwO0LNlXKa4qtG8ys1d3nLBn6InCEDVaOg2OpuQs
	 jjwyqQLTTQsfjDUKY7C5AyyYZLLy4q8CGO7IBmEYQ2HWiUXPI9zxa2sAD4Qq6HPQLw+hW
	 rPf/fBYpWGMspc+iLbY++XspqiCkIOjWKag2KXYy/TtrSkduVZlBTDVXw7rOfYGh5P0wr
	 PNuE91RZivQwTgA3KaOec9Bt+kyK6baI0J7oJvaJ+VWsVr33o+5dNUkdRMiIExTFNOu8o
	 3BkRYy0HOPW0I3wbD1MuBsB1J74wTLnGJ7wZFWVZGRtL+AE6JN/RjShQmfzysg7T9EA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792901808;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=qGKFNIgR0aINQjRdPsD8xXBsvzRYD+GNKrD/JJJosXU=;
	b=Lc2FhcqUvbYFb54VwEA7DjEs0HaRuNAPq6H5D17KtArUF9ec1EsTNbAyWQFNID3SZ6sj
	 nIbJqCz8B8m77un6RajkMJNaRhWKjmlVQBTDFTN0YLQOjxQOiXJfW9UAoz36QWI+j0EII
	 ZHRwUF9UAsBnP3nY/6V7XrT71D+SZxGj5dlLBEwcykfG02WFj8abbLyIDgDM3Xftt03n0
	 5ddkxaZU492TO00LoxCnu34+idammbn+CeFF+opT7StYXO7jXkAAXi3zhUayTuV0yduDl
	 D/+w4oOvw+o4a4UfCrKakUROHeQBUHVTOkP3RnfhYoxdV5ZmfZnAbUBcULgj3H2z6Wg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fYyEfdzL;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 001E3606A31D;
	Sun, 25 Oct 2026 04:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fYyEfdzL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02DB51F01829;
	Sun, 25 Oct 2026 04:16:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792901807;
	bh=qGKFNIgR0aINQjRdPsD8xXBsvzRYD+GNKrD/JJJosXU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=fYyEfdzLjF5YVZdR7cKTzPFApnnylC3CCJhwW8Vq1dWEZNunm9No5MUjvKbaNVd4S
	 asaujq8OruRcl56e7/Eix/gEfFuaEVSyAC3D1hmz1c5SFZ40Kf5kx55G8a6vdMSnlI
	 8nyfmbF6/bWzklERnnJzOQjRZJrz/86zx83Y1nfqLWPACn2h8r6NIr6QJ4AcQBX99l
	 /S3ZGNsFCQxSrxX8OiYS7w43zWtNo2v/11sx2BD0/wtS+hOSyxICL60ONkHfFWCdWv
	 QcRQr4Eg3XbsMIncx7Qb510aOP9w7dlibb9J93wQFvSzafACly0iIiYXTjbrQBpfvY
	 tGbf+tGdRl6zw==
Subject: Re: [PATCH v3] net: gso: validate transport header before computing
 segment length
From: netdev-bot+sashiko@kernel.org
To: mst@redhat.com
Cc: linux-kernel@vger.kernel.org, willemb@google.com, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 rusty@rustcorp.com.au, maxk@qualcomm.com, netdev@vger.kernel.org,
 bpf@vger.kernel.org
Date: Sun, 25 Oct 2026 04:16:46 +0000
Message-ID: <179290180655.3134.12380616706567480368@kernel.org>
In-Reply-To:
 <52b8bfe4ee848aff8ace47752352de486171d45f.1792596586.git.mst@redhat.com>
References:
 <52b8bfe4ee848aff8ace47752352de486171d45f.1792596586.git.mst@redhat.com>
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

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 2 · Medium: 0 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The patch adds a transport-header check only to the GSO length
  validators in net/core/gso.c.
- [High] net: gso: xfrm crypto offload tunnel TSO packets dropped in
  xfrm_output()

--

net: gso: validate transport header before computing segment length

This patch adds a check to the GSO segment length helpers in
net/core/gso.c. For TCP GSO packets, the (inner) transport header must
now be set, and the TCP header must sit in the linear data, before
tcp_hdrlen() is read. If the check fails, skb_gso_validate_network_len()
and skb_gso_validate_mac_len() report the packet as not fitting, and a
new helper, skb_transport_header_linear(), is added to skbuff.h for the
check.

> diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
> index d6894f463bf43..11c8b295bd260 100644
> --- a/include/linux/skbuff.h
> +++ b/include/linux/skbuff.h

[ ... ]

> @@ -3250,6 +3257,29 @@ static inline int skb_transport_offset(const struct sk_buff *skb)
>  	return skb_transport_header(skb) - skb->data;
>  }
>  
> +/* Is the (inner) transport header, as specified by
> + * skb->transport_header/inner_transport_header, in the linear data?
> + */
> +static inline bool skb_transport_header_linear(const struct sk_buff *skb,
> +					       unsigned int hlen)
> +{
> +	int thoff;
> +
> +	if (!skb_transport_header_was_set(skb))
> +		return false;
> +
> +	if (skb->encapsulation) {
> +		if (!skb_inner_transport_header_was_set(skb))
> +			return false;
> +
> +		thoff = skb_inner_transport_offset(skb);
> +	} else {
> +		thoff = skb_transport_offset(skb);
> +	}
> +
> +	return thoff >= 0 && thoff + hlen <= skb_headlen(skb);
> +}

[Severity: High]
Does this break TSO over IPsec tunnel mode with crypto offload?

In xfrm_output(), when xfrm_dev_offload_ok() succeeds for an
XFRM_DEV_OFFLOAD_CRYPTO state, encapsulation is set on the skb before
any inner header offsets have been recorded:

net/xfrm/xfrm_output.c:xfrm_output() {
    ...
		xfrm_get_inner_ipproto(skb, x);
		skb->encapsulation = 1;

		if (skb_is_gso(skb)) {
			...
			skb_shinfo(skb)->gso_type |= SKB_GSO_ESP;
			goto out;
		}
    ...
}

The xfrm_output_gso() branch elided above is only taken when
skb->inner_protocol is already set. A plain TCP skb, whether locally
generated or forwarded, still has inner_protocol and
inner_transport_header at 0 here, so it goes to xfrm_output2(). The
inner offsets are only filled in by the tunnel encap helpers, and that
happens after the size check has run:

xfrm_output2()
  xfrm_output_resume()
    xfrm_output_one()
      xfrm_outer_mode_output()
        xfrm4_prepare_output()
          xfrm_inner_extract_output()
            xfrm4_tunnel_check_size()
              skb_gso_validate_network_len()
          xfrm4_tunnel_encap_add()
            skb_set_inner_transport_header()

The IPv6 path through xfrm6_prepare_output() has the same ordering.

So skb_gso_validate_network_len() is called with encapsulation set
and inner_transport_header == 0. With this patch, the following
happens:

- skb_inner_transport_header_was_set() returns false.
- skb_gso_transport_seglen() returns -EINVAL.
- The packet is reported as not fitting.

xfrm4_tunnel_check_size() (when DF is set, as it normally is for TCP)
and xfrm6_tunnel_check_size() then report the MTU to the local socket
or send an ICMP too big error, and return -EMSGSIZE. xfrm_output_one()
then frees the skb. As a result, every TSO packet over such an SA is
dropped.

The commit message expects the caller to fall back to software
segmentation, but here a false return is treated as a hard MTU
failure. The MTU reported back is the one the flow is already using,
so it is not clear what would make the sender stop building these
packets.

Before this patch, the same call read inner_tcp_hdrlen() from
skb->head and computed thlen against a zero inner offset. The result
was meaningless, but in practice it let these packets through.

Should xfrm_output() record the inner network and transport offsets
at the point where it sets encapsulation for the crypto offload case?
Or is there another way you would prefer to handle this, before the
new check starts requiring a valid inner transport header whenever
encapsulation is set?

[Severity: High]

The commit message says:

  Qdisc length estimation has carried a guard against exactly this since

  commit a0dce8752193 ("net: Skip GSO length estimation if transport
  header is not set");

Does that hold for the bpf_skb_adjust_room() case named later in the
commit message?

The guard in qdisc_pkt_len_segs_init() in net/core/dev.c only rejects an
unset transport header on a non-encapsulated skb:

net/core/dev.c:qdisc_pkt_len_segs_init() {
    ...
	if (!skb->encapsulation) {
		if (unlikely(!skb_transport_header_was_set(skb)))
			return SKB_NOT_DROPPED_YET;
		hdr_len = skb_transport_offset(skb);
	} else {
		hdr_len = skb_inner_transport_offset(skb);
	}
	/* + transport layer */
	if (likely(shinfo->gso_type & (SKB_GSO_TCPV4 | SKB_GSO_TCPV6))) {
		const struct tcphdr *th;

		if (!pskb_may_pull(skb, hdr_len + sizeof(struct tcphdr)))
			return SKB_DROP_REASON_SKB_BAD_GSO;

		th = (const struct tcphdr *)(skb->data + hdr_len);
		tlen = __tcp_hdrlen(th);
    ...
}

It does not reject a transport offset that is set but negative.
bpf_skb_net_hdr_pop() in net/core/filter.c can leave one behind. After
bpf_skb_generic_pop() moves skb->data forward, only mac_header and
network_header are moved too:

net/core/filter.c:bpf_skb_net_hdr_pop() {
    ...
	ret = bpf_skb_generic_pop(skb, off, len);
	if (likely(!ret)) {
		skb->mac_header += len;
		skb->network_header += len;
		if (trans_same)
			skb->transport_header = skb->network_header;
	}
    ...
}

Two cases leave transport_header in front of the new skb->data:

- MAC-mode decap of a locally encapsulated VXLAN packet with
  BPF_F_ADJ_ROOM_DECAP_L4_UDP. transport_header still points at the
  outer UDP header, and encapsulation is cleared.
- A NET-mode shrink with len > off.

If the tc program then calls bpf_redirect() to egress, the skb reaches
the estimator before any of the newly guarded validators run:

__bpf_redirect_common()
  __bpf_tx_skb()
    dev_queue_xmit()
      __dev_queue_xmit()
        qdisc_pkt_len_segs_init()

In qdisc_pkt_len_segs_init(), an offset of -16 does the following:

- It is stored in the unsigned hdr_len as 0xFFFFFFF0.
- hdr_len + sizeof(struct tcphdr) is truncated to 4 when passed to
  pskb_may_pull(), so the check passes.
- th ends up about 4GiB past skb->data on 64-bit, and __tcp_hdrlen(th)
  then reads th->doff from it.

Could this oops, or read unrelated memory and compute a garbage length?

The encapsulated branch also calls skb_inner_transport_offset() without
any of the rules this patch adds: inner header not 0 or ~0U, outer
header set, offset >= 0, and header inside the linear data. As a
result, the qdisc estimator and the GSO validators now apply different
rules to the same TSO skb.

Should qdisc_pkt_len_segs_init() also use skb_transport_header_linear(),
or should the commit message describe this as a gap that remains?

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/52b8bfe4ee848aff8ace47752352de486171d45f.1792596586.git.mst%40redhat.com
