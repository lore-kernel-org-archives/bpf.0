Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDE4449505D;
	Fri,  9 Oct 2026 08:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791533528; cv=none; b=mG0TJ9pctUfY0k+2+RqZjX+jlXEC6Da7yrMc3uvmbPHFAfX6Ekvs3+EL1zHbFwm27O/WQhyZykPOZe8qGptcNsFwd19XC3twf21BzTFqv7paL+TmobGy6g5xQGBLLTzXA1CaG8WuVRiSDf5p76AFOGeAKPr3bce6dMLdSoUboQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791533528; c=relaxed/simple;
	bh=hET4+cBiJD2w1zNeYJsmHZ5gQfXNCuaG+bfOzCtoKdU=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UYAfOO1rK18EgfioYY+wVWw0LwFprkeq3BIg3HtXsNA7X6Pp14W8GlIzz00ReO9QlEYWNTWJ4ZZLIELQPVJevPKlXjtkaRr8xVo2t8/byTUluVS/uxFm/qfR8w71QD619HbbxannVZlkmw25B4uXfBrQTrN32dnZGk+goytWy8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VizfXN6L; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VizfXN6L"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 429061F000FF;
	Fri,  9 Oct 2026 08:11:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791533519;
	bh=VXl3YoAxrg0oNP9Z0z61toA984cJEjzeQZY56cG0aCI=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=VizfXN6LLTdxK4Lyv62KF6ISCm95R9xkExQKBb9sbAyFcdWu6Nz1xFY/HV8u3gmje
	 xXi/b2uamD/m1BuZo5Xn8KZ2jcKFO4ep4tUKg1talUWiID520IjWHULVv9uffXPYds
	 16huJTX9fuepbnrOVzDhLAwJq/5GcZ+14KnlGdd2xunoTgijHCMWAtNE1uukvVWN15
	 HMJpwz9NHoiCq/MhJ+7L2GcJTL31p7eBSkILiudkb6mHQwt4aYBVZMkl7DQbzmIFcU
	 dcMQPoRTn2RSeu5SW91GWuI8WoV1CN0DrGZbi6BE2hr0W2rQsItdJdJy+Fvi4pNxag
	 F8pBkjbJ1exEg==
Subject: Re: [PATCH net-next 1/9] net: skbuff: don't leave stale bytes in
 skb_copy_and_csum_bits()
From: netdev-bot+sashiko@kernel.org
To: josef@toxicpanda.com
Cc: davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, kaiyuanz@google.com,
 almasrymina@google.com, willemb@google.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Date: Fri, 09 Oct 2026 08:11:58 +0000
Message-ID: <179153351881.434549.16789222638740983358@kernel.org>
In-Reply-To: <20261006-b4-skbuff-bug-on-v1-1-1b4434c5357c@toxicpanda.com>
References: <20261006-b4-skbuff-bug-on-v1-1-1b4434c5357c@toxicpanda.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 0 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The patch's own claim that "the checksum is already wrong in
  this case, so the packet still gets dropped by the receiver" does not…
- [Low] The commit message names two wire paths that would send stale
  bytes: the ICMP error quote, and "a driver's TX bounce buffer in…

--

net: skbuff: don't leave stale bytes in skb_copy_and_csum_bits()

This patch zeroes the rest of the destination buffer in
skb_copy_and_csum_bits() when the function reaches unreadable frags.
Before, those bytes were left as they were. The commit message says
this affects ICMP error quoting and driver TX bounce buffers. It also
says the returned checksum is already wrong, so the receiver drops the
packet anyway.

> The callers copy into a buffer that is about to go
> out on the wire: an ICMP error quoting the offending packet, or a
> driver's TX bounce buffer in skb_copy_and_csum_dev().  Neither buffer
> is zeroed beforehand, so whatever was in memory there gets sent.

[Severity: Low]
Can the skb_copy_and_csum_dev() path see unreadable frags at all?

These drivers call skb_copy_and_csum_dev():

  ep93xx_eth, ec_bhf, ksz884x, 8139too, sc92031, via-rhine

The sunvnet TX path does too. None of them sets dev->netmem_tx, so they
are all NETMEM_TX_NONE.

validate_xmit_skb() calls validate_xmit_unreadable_skb() first, and
that frees these skbs before ndo_start_xmit is reached:

net/core/dev.c:validate_xmit_unreadable_skb() {
    ...
	if (dev->netmem_tx == NETMEM_TX_NONE)
		goto out_free;
    ...
}

Only bnxt, gve, mlx5, fbnic and netkit set netmem_tx. None of them
calls skb_copy_and_csum_dev().

The ICMP/ICMPv6 quote path through icmp_glue_bits() still justifies the
fix. Could the driver bounce buffer example be dropped from the commit
message? This is a Fixes-tagged patch, and the example could mislead
stable backporters.

> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> index 5c4024a03e105..512ff9cfa269f 100644
> --- a/net/core/skbuff.c
> +++ b/net/core/skbuff.c
> @@ -3633,8 +3633,12 @@ __wsum skb_copy_and_csum_bits(const struct sk_buff *skb, int offset,
>  		pos	= copy;
>  	}
>  
> -	if (!skb_frags_readable(skb))
> +	if (!skb_frags_readable(skb)) {
> +		/* Don't hand the caller a buffer with stale bytes in it. */
> +		if (len > 0)
> +			memset(to, 0, len);
>  		return 0;
> +	}

[Severity: High]
The commit message says "The checksum is already wrong in this case, so
the packet still gets dropped by the receiver". Does that hold when
offset >= skb_headlen(skb), so nothing is copied from the linear area?

In that case the whole range is zeroed and 0 is returned. 0 is the
correct partial checksum for an all-zero buffer, so the data and the
checksum now agree.

In the !sg && !csum arm, skb_segment() stores this return value without
checking skb_frags_readable():

net/core/skbuff.c:skb_segment() {
    ...
				SKB_GSO_CB(nskb)->csum =
					skb_copy_and_csum_bits(head_skb, offset,
							       skb_put(nskb,
								       len),
							       len);
    ...
}

tcp_gso_segment() then folds it into the TCP checksum:

	th->check = gso_make_checksum(skb, ~th->check);

The result is a TCP checksum that is valid over a payload of zeros.

For a devmem TCP TX skb, the linear area holds only the headers and all
payload sits in net_iov frags. So every segment has offset >= headlen.

This path looks reachable after something like "ethtool -K dev sg off
tx off" on a NETMEM_TX_DMA device (bnxt, gve, mlx5, fbnic).
validate_xmit_unreadable_skb() lets the skb through, because netmem_tx
is DMA and the binding dev matches. Turning SG off also drops TSO, so
netif_needs_gso() is true and the skb takes this path:

validate_xmit_skb()->skb_gso_segment()->...->tcp_gso_segment()->
    skb_segment()->skb_copy_and_csum_bits()

skb_segment() runs with sg and csum both false.

skb_orphan_frags() returns 0 here because msg_zerocopy_alloc() sets
SKBFL_DONT_ORPHAN.

tcp_sendmsg_locked() checks NETIF_F_SG only at send time. Skbs already
in the write or retransmit queues are affected either way.

Would the peer then accept and ACK these zeroed segments as real stream
data? Before this patch the stale bytes did not match the returned 0,
so the segment was dropped.

Would it be better to return a checksum that is deliberately wrong
here? Another option is for skb_segment() to reject unreadable skbs, as
the csum arm already does when skb_copy_bits() returns -EFAULT.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261006-b4-skbuff-bug-on-v1-0-1b4434c5357c%40toxicpanda.com
