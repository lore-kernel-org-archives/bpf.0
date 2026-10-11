Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C97E030596F;
	Sun, 11 Oct 2026 17:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791738049; cv=none; b=ZaF2YcYedM4IbqDK6yKcJ4ksI6auGseccEt7sWKEE3QpIKkx6+nQaK57brj2wlZP35QXkKBFTENJqY+hE2YhJ0jaGcoPDUFbTMitGAF60dXnCQxQb1xcP4YhQXfPVEydsfqe7BELMrQr9Pd3udLqUy91iDf07TaBl8RxCojmsU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791738049; c=relaxed/simple;
	bh=vWIV+Qu1QZXIFLkm1LrRDf3K8Bdnt5ppT5W9LquwC0Q=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gHX0T0fJbymPough35lLBB1SQXru7tE23Q8jzqjzKWkB7heESY2EwusJjUB2WrmRf3PM+7b5vKPs8YP6ezogM3jmX6n5U0y4AUn8EpM5MQBbp0TyvvMG1ir2whkp769qGMSWyerB4a0nisFRTpgwVg1eIQRaS9703EHLXI7P2+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GR4DgoSE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GR4DgoSE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31A1E1F0089F;
	Sun, 11 Oct 2026 17:00:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791738046;
	bh=hzo3X3q6qdgOl/s8/aTDbRQYDi7NPN9uDiY0NH1L1Uo=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=GR4DgoSEKF+6sbeblAmVzkr1Z5w4DJxBf4fkh55/ghu1kGpPgWNFUkbe2vNU0KeJa
	 wBwRMqqoDHgqb11fhlMYsswo33Q1zIU+oI2r3nIuMQ6DZjwx3UaAPWqoFyomZRplYW
	 N7G3r/p3gFTSAYptURUzv8IOKWmG6KkYChhpnaa1VBuVWmHj1ThRNUiYOjhGfNwDLA
	 OBT2isVyDnjuvm30nfFeU/kQgYICY1T6RW8/H7/gb0cLr9/05TNXw5ByAIf0uctgek
	 P+fZuBA8X8csr6GyK1W+wBMBLfQPl29PtuDyLhcESzmKBrIb64o8g0ZZpfcz6+U1Me
	 HEEXErCmisKKg==
Subject: Re: [PATCH net-next v2 3/8] net: skbuff: don't BUG() when
 skb_copy_bits() fails in copy helpers
From: netdev-bot+sashiko@kernel.org
To: josef@toxicpanda.com
Cc: davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Date: Sun, 11 Oct 2026 17:00:45 +0000
Message-ID: <179173804578.434549.12357016377866471421@kernel.org>
In-Reply-To: <20261007-b4-skbuff-bug-on-v2-3-b9a5f732895b@toxicpanda.com>
References: <20261007-b4-skbuff-bug-on-v2-3-b9a5f732895b@toxicpanda.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 (1) · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] skb_try_coalesce() in net/core/skbuff.c stores the unsigned
  `from->len` in `int len`.

Pre-existing issues:
- [Medium] This problem wasn't introduced by this patch, but bounce_skb()
  in drivers/net/xen-netfront.c is an open-coded copy of skb_copy().

--

net: skbuff: don't BUG() when skb_copy_bits() fails in copy helpers

This patch removes the BUG_ON(skb_copy_bits()) calls from skb_copy(),
skb_copy_expand() and skb_try_coalesce(). On failure, skb_copy() and
skb_copy_expand() now free the new skb and return NULL, and
skb_try_coalesce() returns false. skb_try_coalesce() now copies into the
tailroom before calling skb_put(), so that @to is left untouched on failure.

> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> index a6821ab139691..ffc78b1a8ab85 100644
> --- a/net/core/skbuff.c
> +++ b/net/core/skbuff.c
> @@ -2201,7 +2201,12 @@ struct sk_buff *skb_copy(const struct sk_buff *skb, gfp_t gfp_mask)
>  	/* Set the tail pointer and length */
>  	skb_put(n, skb->len);
>
> -	BUG_ON(skb_copy_bits(skb, -headerlen, n->head, headerlen + skb->len));
> +	if (unlikely(skb_copy_bits(skb, -headerlen, n->head,
> +				   headerlen + skb->len))) {
> +		DEBUG_NET_WARN_ON_ONCE(1);
> +		kfree_skb(n);
> +		return NULL;
> +	}
>
>  	skb_copy_header(n, skb);
>  	return n;

[Severity: Medium]
This isn't a bug introduced by this patch, but bounce_skb() in
drivers/net/xen-netfront.c is an open-coded copy of skb_copy(), and it
still has the same BUG_ON():

drivers/net/xen-netfront.c:bounce_skb() {
    ...
	/* Set the data pointer */
	skb_reserve(n, headerlen);
	/* Set the tail pointer and length */
	skb_put(n, skb->len);

	BUG_ON(skb_copy_bits(skb, -headerlen, n->head, headerlen + skb->len));
    ...
}

bounce_skb() already frees n and returns NULL on the misaligned head path,
and xennet_start_xmit() handles that:

	nskb = bounce_skb(skb);
	if (!nskb)
		goto drop;

Could bounce_skb() get the same NULL-return conversion, either in this
patch or in a follow-up? No later patch in the series touches this site.

The other remaining BUG_ON(skb_copy_bits()) calls in net/ipv4/icmp.c and
net/ipv6/ip6_output.c look like a different case. There, the length is
checked beforehand or the destination fragment is already sized for the
copy.

[ ... ]

> @@ -6233,8 +6243,15 @@ bool skb_try_coalesce(struct sk_buff *to, struct sk_buff *from,
>  		return false;
>
>  	if (len <= skb_tailroom(to) && skb_frags_readable(from)) {
> -		if (len)
> -			BUG_ON(skb_copy_bits(from, 0, skb_put(to, len), len));
> +		if (len) {
> +			if (unlikely(skb_copy_bits(from, 0,
> +						   skb_tail_pointer(to),
> +						   len))) {
> +				DEBUG_NET_WARN_ON_ONCE(1);
> +				return false;
> +			}
> +			skb_put(to, len);

[Severity: Medium]
If from->len is corrupt, can copying before skb_put() turn it into an
out-of-bounds write past the tailroom of to?

skb_try_coalesce() stores the unsigned from->len in an int:

	int i, delta, len = from->len;

If from->len is above INT_MAX, len is negative. A negative len passes the
check above, because skb_tailroom() returns int.

It also gets past the first check in skb_copy_bits(). With offset 0 and
len == (int)skb->len, this compares 0 > 0:

	if (offset > (int)skb->len - len)
		goto fault;

After that, copy = start - offset is positive (headlen), copy > len is
true, and so copy is set to the negative len.
skb_copy_from_linear_data_offset() takes a const unsigned int len, so the
memcpy() into skb_tail_pointer(to) becomes roughly 2 GiB. When headlen is 0,
the frag path does the same thing through skb_frag_foreach_page().

Before this patch, skb_put(to, len) ran first. With the offset-based tail
on 64-bit, any from->len in roughly [2^31, 2^32 - tail) hit skb_over_panic()
before anything was copied.

This needs skb metadata that is already corrupt, for example a driver
passing a bogus frag size to skb_add_rx_frag(). No concrete producer has
been found. It also doesn't match this line in the commit message:

  "Copy into the tailroom before skb_put() so that @to is untouched on
   failure."

Would it work to reject len < 0, or to compare from->len as unsigned
against skb_tailroom(to), before the copy?

> +		}
>  		*delta_truesize = 0;
>  		return true;
>  	}

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261007-b4-skbuff-bug-on-v2-0-b9a5f732895b%40toxicpanda.com
