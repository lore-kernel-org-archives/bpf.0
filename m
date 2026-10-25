Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792901806;
	b=yF0Kx1FGV+JLXlblh3JZurY8bnSUjJzahGXKmZp/nFdf3ZQgkLR/tGr/38RR4qPvfQdQ
	 FeuMCWnAAgpEfP6pb93A7DLI97PKv5Zm7ex5fvAywViZCnpCOFfx8+UHydYt1u8AJ2yyq
	 LSAnQ87T1O60UgqtyDEYQowHSPiI1dBagG1gUKj2hn6Ao8sexHTHtr6alqjfGZPF9aH6p
	 lYpwYvaUg2CdvmSNycHzRZQlZ+VJmkh6PdEmf8Lt+ojHEbCqSancC5pe29rf4S16MqNiY
	 dSYAFpIyoy/StbricejxLliQyFddf6FFX9bAz0x0oxaGOyWTXwWXCqsHob0Cdu1KP0w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792901806;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=PToQzXUjYFEQszf30gAQ4ggV9TKpUaZjERtmBpyrb2M=;
	b=yIWauaeQ15PDDHGjSOUBt8Tiw1mrwMpP8x81CgdlaEEgrjz/bLsyjmdhRTQ7KdsPlqeV
	 fXapeOr5ToyyIiSwKNvU9sUYtnsGztxPWUyJ4dUqjl/q6C9hKc4U3ZMtDL/y5g9uEZzaf
	 dB+vkAwPjPhMD0vaazvHBuD8Z09RU3MEwXYERPD0F3UUMRjha3+D9TK8V644yAuIlP1SI
	 Q5SXvB8UIG9neySlsbpqxsjwE1hLGrPjCsBMzZyJbD5a9+gRf/Sc8k4HovItUCBeD2W0D
	 bbt1DqsqUr6ex71a31/LBcJbQP2QGB74MD+xks6+4SRZ7N1T/zqDyghL931On8CXPIg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VZzzwQKW;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54D03606A31A;
	Sun, 25 Oct 2026 04:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VZzzwQKW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D61B1F01825;
	Sun, 25 Oct 2026 04:16:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792901806;
	bh=PToQzXUjYFEQszf30gAQ4ggV9TKpUaZjERtmBpyrb2M=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=VZzzwQKWHddl8VgwDz5iAj1bc6PAjXP11dDqt1vJEf7GVf6nn3KjuwmENFTxKb8Hu
	 2GqvxzEaZdyt5pOirFOjUmUAWbdGrHvlkwBU0e5Z0D6hWpz5f70F5kdY+DprBRaLAE
	 Tg6IOaAB5EVcu+JMhbVauE3W1wMTUnDsCckeGu4THz+Y4Oa7bI37SgSKo12Qu4lGaN
	 pxzWk/eaWr6p1c/e86PHq8KgDNGaQgHNlyBFLb3q1tJ1SOgPZV7sLQV+RQSpoeh6WI
	 fMKb21XG7WKlQc3is6qs1dUN/SANPkrzETYOiZxC1yiSB/90NfL+aMB3SXmFMQpIE1
	 1EB1T5uOKoMwQ==
Subject: Re: [PATCH net v3] net: gso: validate transport header before
 computing segment length
From: netdev-bot+sashiko@kernel.org
To: mst@redhat.com
Cc: linux-kernel@vger.kernel.org, willemb@google.com, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 maxk@qualcomm.com, rusty@rustcorp.com.au, netdev@vger.kernel.org,
 bpf@vger.kernel.org
Date: Sun, 25 Oct 2026 04:16:44 +0000
Message-ID: <179290180493.3134.5235549211177646736@kernel.org>
In-Reply-To:
 <52b8bfe4ee848aff8ace47752352de486171d45f.1792595507.git.mst@redhat.com>
References:
 <52b8bfe4ee848aff8ace47752352de486171d45f.1792595507.git.mst@redhat.com>
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

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 0 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The patch is incomplete for the producer its own commit message
  names.

--

net: gso: validate transport header before computing segment length

This patch makes the GSO segment length helpers in net/core/gso.c check
the TCP header before they read it. If the transport header is unset, or
the TCP header is not in the linear data, skb_gso_validate_network_len()
and skb_gso_validate_mac_len() now report that the skb does not fit. It
also adds two helpers, skb_inner_transport_header_was_set() and
skb_transport_header_linear(), to include/linux/skbuff.h.

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

[Severity: High]

The commit message names bpf_skb_adjust_room() as a way to leave a bad
transport header behind. It also says:

    Qdisc length estimation has carried a guard against exactly this since

Is that guard enough for the bpf_skb_adjust_room() case? In
qdisc_pkt_len_segs_init(), the only check is for an unset transport
header. Nothing there matches the thoff >= 0 check added here:

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

bpf_skb_net_hdr_pop() moves mac_header and network_header forward. It
leaves transport_header where it was, unless it was equal to
network_header:

net/core/filter.c:bpf_skb_net_hdr_pop() {
    ...
		skb->mac_header += len;
		skb->network_header += len;
		if (trans_same)
			skb->transport_header = skb->network_header;
    ...
}

When the DECAP_L4 or DECAP_IPXIP flags remove the last tunnel GSO bit,
bpf_skb_net_shrink() also clears skb->encapsulation.

Take a locally VXLAN-encapsulated TCP TSO skb whose transport_header
points at the outer UDP header. If a tc program calls
bpf_skb_adjust_room(skb, -50, BPF_ADJ_ROOM_MAC,
BPF_F_ADJ_ROOM_DECAP_L4_UDP | ...), the transport offset ends up at -16
and encapsulation is 0.

A simpler BPF_ADJ_ROOM_NET shrink of 40 bytes on a plain Ethernet/IPv4
TSO skb gives an offset of -6.

If the program then redirects to egress with bpf_redirect(), this path
runs before any of the validators hardened in this patch:

__bpf_tx_skb()
  dev_queue_xmit()
    __dev_queue_xmit()
      qdisc_pkt_len_segs_init()

In that function hdr_len is an unsigned int, so -16 becomes 0xfffffff0.
hdr_len + sizeof(struct tcphdr) is then truncated to 4 when passed as the
unsigned int len argument of pskb_may_pull(), so the pull succeeds.

Wouldn't __tcp_hdrlen(th) then read about 4GB past skb->data on 64-bit?

Should qdisc_pkt_len_segs_init() get the same check, for example by
using skb_transport_header_linear()? If not, could the commit message
be changed so it does not say the qdisc path already guards against
this?

> +}
> +
>  static inline u32 skb_network_header_len(const struct sk_buff *skb)
>  {
>  	DEBUG_NET_WARN_ON_ONCE(!skb_transport_header_was_set(skb));

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/52b8bfe4ee848aff8ace47752352de486171d45f.1792595507.git.mst%40redhat.com
