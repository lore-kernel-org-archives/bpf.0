Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F9354854E5;
	Fri,  9 Oct 2026 08:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791533532; cv=none; b=iOqRjvpYkFFefAMkURdekAVi1YUlMyEzJZYpElVGjtU7afKdS9C91oqrP5DdQ5REOGWU0TfMKP4bE/ZXpYC93yN6X41H77ErqPG+E18+7ZPy+oFVCGnSUzS5jtOULT31idLaFAIZJJeOV23Cf0V2yMGaTtZf2YWDbWwlM9XnWqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791533532; c=relaxed/simple;
	bh=YVNARmkLDX7I+nYePGwqvtZelGm/ZIYzDAw9ApCl9MQ=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=o671LZPCM4p0Yk7SjVQqGsLOwC0NQ3rclvjUImyUG4QhbkPfx9ReXSfemPamv9XxWX8qwqMMmZN1UEBpR3ujjFAdwkHH6mMpHDYbK9SIALE+LXqQpdd7+ioTM5DuNE7LOg+/BpjbntRqYwZB3ubKqUXdpyk0S5Q1S8F6LlwJPpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CZtT3gbu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CZtT3gbu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E8411F0089B;
	Fri,  9 Oct 2026 08:12:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791533524;
	bh=ddCssXENqOwsDO3ufhFoQ7id8XAA/fk+0GZQ/hhS8CQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=CZtT3gbuNBOFnPTBs0SdYypd1NyVHNo8MzL0ovTJd1EsqUj0AsmUAQRkRc+NKqbJ3
	 c85AfHN5/svpTHHDXvATWPW5cyqbR5iRn454dL5C1fAA7oB5U6uBwdkMdz3XxnKeye
	 W5yutnP45iYYURkhXKj79CfzcdJkHTGvD0TfE2cEDOTi5TNFqLWuaCAFIJPm964n1c
	 2Zl41+fcY+8I7pU2nw6dBGZ3MYV9EIReUwCPTbWdZAFEHOCljYdS2o2XJhwrdmyw6R
	 Mo8rUAA5W6gkZIJ5nLd+b5yDWCRnpU7Zt0+zSXavn3OxpRvj30mgKxE7zXIfQTUMnN
	 R7Spd0lkYo8Nw==
Subject: Re: [PATCH net-next 7/9] net: skbuff: don't BUG() on leftover length
 in skb_copy_and_csum_bits()
From: netdev-bot+sashiko@kernel.org
To: josef@toxicpanda.com
Cc: davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, kaiyuanz@google.com,
 almasrymina@google.com, willemb@google.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Date: Fri, 09 Oct 2026 08:12:03 +0000
Message-ID: <179153352363.434549.4339273413337902624@kernel.org>
In-Reply-To: <20261006-b4-skbuff-bug-on-v1-7-1b4434c5357c@toxicpanda.com>
References: <20261006-b4-skbuff-bug-on-v1-7-1b4434c5357c@toxicpanda.com>
X-sashiko-severity: Medium
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

Critical: 0 · High: 0 · Medium: 2 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] In net/core/skbuff.c, skb_copy_and_csum_bits() now has a new
  exhaustion branch (line 3712).
- [Medium] In net/core/skbuff.c, skb_segment()'s non-SG path has two
  branches for copying a segment's payload from head_skb.

--

net: skbuff: don't BUG() on leftover length in skb_copy_and_csum_bits()

This patch replaces the BUG_ON(len) at the end of skb_copy_and_csum_bits()
with a WARN_ON_ONCE(). When the skb runs out before len does, the
uncopied rest of the destination buffer is now zero-filled and 0 is
returned as the checksum. The commit message says the wrong checksum
will make the receiver drop the packet.

> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> index c8c2c0319b87a..e29eda2eaf3f6 100644
> --- a/net/core/skbuff.c
> +++ b/net/core/skbuff.c
> @@ -3709,7 +3709,12 @@ __wsum skb_copy_and_csum_bits(const struct sk_buff *skb, int offset,
>  		}
>  		start = end;
>  	}
> -	BUG_ON(len);
> +	if (WARN_ON_ONCE(len)) {
> +		/* Don't hand the caller a buffer with stale bytes in it. */
> +		if (len > 0)
> +			memset(to, 0, len);
> +		return 0;
> +	}

[Severity: Medium]
Is the 0 returned here certain to give a wrong checksum? The commit
message says:

  As with skb_checksum(), the checksum is wrong and the packet gets
  dropped by whoever receives it.

Zero bytes add nothing to a ones' complement sum. So 0 is the correct
partial checksum for the buffer as written whenever the discarded csum
over the copied prefix was 0 mod 0xffff.

This always happens when nothing was copied, because offset was already
past the real data. It can also happen when the copied prefix sums to
zero, for example a full IPv4 header with a valid header checksum.

In the ICMP case named in the commit message, icmp_glue_bits() folds
the return value in and always reports success:

net/ipv4/icmp.c:icmp_glue_bits() {
    ...
	csum = skb_copy_and_csum_bits(icmp_param->skb,
				      icmp_param->offset + offset,
				      to, len);

	skb->csum = csum_block_add(skb->csum, csum, odd);
    ...
	return 0;
}

Then icmp_push_reply() does:

		icmph->checksum = csum_fold(csum);
		skb->ip_summed = CHECKSUM_NONE;
		ip_push_pending_frames(sk, fl4);

Could the ICMP error go out with a valid checksum over a zero-filled
quote?

icmpv6_getfrag() looks to be in the same position. So does
skb_copy_and_csum_dev(), which stores csum_fold() of the result in the
frame, and so does vnet_skb_shape() in sunvnet_common.c.

The commit message also says:

  Its callers copy into a buffer that is about to go out on the wire

That isn't true of xdr_skb_read_bits() in net/sunrpc/socklib.c, which
copies from a received skb:

	if (desc->need_checksum) {
		__wsum csum;

		csum = skb_copy_and_csum_bits(desc->skb, desc->offset, to, len);
		desc->csum = csum_block_add(desc->csum, csum, desc->offset);
	} else {
		if (unlikely(skb_copy_bits(desc->skb, desc->offset, to, len)))
			return 0;
	}

	desc->count -= len;
	desc->offset += len;
	return len;

The skb_copy_bits() branch notices the short copy and returns 0. The
checksum branch still advances by the full len. After that, only the
csum_fold(desc.csum) check in csum_partial_copy_to_xdr() can reject the
zero-filled RPC data, and whether it does depends on the data.

Could callers get a failure they can detect? Another option is to
return a value that can never match the real partial sum, so the
checksum is always wrong. Failing that, should the commit message be
reworded?

[Severity: Medium]
How should skb_segment() handle this now? Its non-SG path copies a
segment's payload from head_skb in one of two branches:

net/core/skbuff.c:skb_segment() {
    ...
		if (!sg) {
			if (!csum) {
				if (!nskb->remcsum_offload)
					nskb->ip_summed = CHECKSUM_NONE;
				SKB_GSO_CB(nskb)->csum =
					skb_copy_and_csum_bits(head_skb, offset,
							       skb_put(nskb,
								       len),
							       len);
				SKB_GSO_CB(nskb)->csum_start =
					skb_headroom(nskb) + doffset;
			} else {
				if (skb_copy_bits(head_skb, offset, skb_put(nskb, len), len))
					goto err;
			}
			continue;
		}
    ...
}

Take a head_skb that holds less data than skb->len says. The csum
branch drops the GSO skb through goto err. Before this patch, the !csum
branch (no SG and no checksum offload) hit BUG_ON(len). Now that branch
keeps a zero-filled payload, stores 0 in SKB_GSO_CB(nskb)->csum and
emits the segment.

gso_make_checksum() then builds the segment checksum from that value.
If a segment starts past the real data, 0 is the exact sum of its
all-zero payload. Can a zero-filled TCP or UDP segment then go out with
a valid checksum?

This seems to go against the earlier patch in this series, "net:
skbuff: don't BUG() on a bad frag_list layout in skb_segment()". That
patch says a packet that can't be segmented should be dropped through
the -EINVAL error path.

This commit message doesn't mention this caller. The later patches in
the series (skb_zerocopy, skb_shift) don't touch skb_segment().

Could skb_copy_and_csum_bits() report the failure so the !csum branch
can also goto err? Or could skb_segment() check head_skb before the
copy?

>  	return csum;
>  }
>  EXPORT_SYMBOL(skb_copy_and_csum_bits);

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261006-b4-skbuff-bug-on-v1-0-1b4434c5357c%40toxicpanda.com
