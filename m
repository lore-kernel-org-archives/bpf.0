Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45075361963;
	Sun, 11 Oct 2026 17:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791738052; cv=none; b=D+13HTEsSg+q1T4gSHhEU3RJdpKLTiC4mv+bcM8kWlO8p9nOhIMOgcg1KTSMJPs+PBRAeZfJ0fn6K6GwpKcAFRzZ6TCq218xKT9o71rILQJ43PN5cQRdnFOwlGXixKQap62AVLkBaqYzrrbC9gaueCO8ZtCPC9eOs2BEScsFP3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791738052; c=relaxed/simple;
	bh=ImLOz9s6aPcO5ICd0qC8x0X97R96hCywpKIMCMBGl+8=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YEvlZnfSolWBYpo004/xj2PYXcA9hbkvWBY5uBwQRpaTGsHoKdE0ohQz2eBQN3RHacrIvlGXlu7YCw0XbhdZ8i+bJqhqozrkPOEZozctbpuXSvZD8ChUROWgsSaI3zuv1uXVdtvBgYk9G8sl+3j07tFqT0h9Nd89bNaHeWaggjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HJVqC0jb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HJVqC0jb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 476B81F0089B;
	Sun, 11 Oct 2026 17:00:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791738048;
	bh=QkNHOjj59IxqcLHlee+z9QlPqlzlq9GC9FGxHjQeNrw=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=HJVqC0jbEpIks0BPsOUV0GXq1BbeHx+RfARqrZqDSzr/5qCHuZHQOfrxo4X7CjHq9
	 Rns0qCPbiCmnQkr123iXkQgyWGatD3kEJT9illJL5BC2xXqWiKuhpe0WkQt7mgRAGL
	 PO5sbyXXVnyCYXFPMb3KkSepjVbqBvJt28xi182z+3v7ufhhZZBxlfeqhJVgGyJ2ib
	 KqNdgk5ffCBgZ7QD1Gvqt9lVMFZPsFn/qkGMAUv4TFmQOp8Cm4Dd3nvpqus0SCwpHL
	 ZmkEhasbSdgMLJ3y/5c03fxRp+jvCpFdShwUErc3HpAV+myJbOQq+ai0kIbkZrbcJK
	 1Lg62VABZlf2g==
Subject: Re: [PATCH net-next v2 5/8] net: skbuff: don't BUG() on a bad
 csum_start in skb_copy_and_csum_dev()
From: netdev-bot+sashiko@kernel.org
To: josef@toxicpanda.com
Cc: davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Date: Sun, 11 Oct 2026 17:00:47 +0000
Message-ID: <179173804783.434549.11451844008896039021@kernel.org>
In-Reply-To: <20261007-b4-skbuff-bug-on-v2-5-b9a5f732895b@toxicpanda.com>
References: <20261007-b4-skbuff-bug-on-v2-5-b9a5f732895b@toxicpanda.com>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] The commit message gives the wrong reason for the new csum_offset
  bound in skb_copy_and_csum_dev() (net/core/skbuff.c).
- [Low] The concern says the 'don't BUG()' subject and framing hide that
  skb_copy_and_csum_dev() closes silent memory-corruption paths: a…

--

net: skbuff: don't BUG() on a bad csum_start in skb_copy_and_csum_dev()

This patch replaces the BUG_ON() in skb_copy_and_csum_dev() with a check
on both ends of csum_start and on whether the checksum field fits in the
frame. When the check fails, the whole frame is copied with
skb_copy_bits() and the checksum is not filled in. If that copy also
fails, the buffer is zeroed.

> It also trusts
> csum_offset when it stores the folded checksum.  So far
> skb_copy_and_csum_bits() BUG()ing on a short skb has covered for that,
> but once it returns instead, a bad csum_offset would write past the end
> of the caller's buffer.

[Severity: Low]

Is this description accurate? skb_copy_and_csum_dev() asks
skb_copy_and_csum_bits() for exactly the bytes left in the skb:

    csum = skb_copy_and_csum_bits(skb, csstart, to + csstart,
                                  skb->len - csstart);

The BUG_ON(len) at the end of skb_copy_and_csum_bits() only fires when the
head, frags and frag_list add up to less than skb->len. csum_offset plays
no part in that check.

For a well-formed skb with a bad csum_offset, the pre-patch code would not
BUG and would go on to:

    long csstuff = csstart + skb->csum_offset;
    *((__sum16 *)(to + csstuff)) = csum_fold(csum);

csum_offset is a __u16. Couldn't this store land up to ~64KB past
to + skb->len and overflow the driver's bounce buffer (for example
tx_buf[entry] in 8139too) today?

The follow-up patch that replaces BUG_ON(len) in skb_copy_and_csum_bits()
with a memset and return doesn't change this. A short skb with a valid
csum_offset still writes inside [0, skb->len), and a well-formed skb with
a bad csum_offset overflows with or without that patch.

It isn't clear which producer could create such a csum_offset, since entry
points like skb_partial_csum_set() validate it. Still, could the commit
message say that the new csum_offset check closes an existing
out-of-bounds store, rather than one that only shows up after the next
patch? The code change itself looks correct.

> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> index 32d7f5ed25eb4..c896770203f71 100644
> --- a/net/core/skbuff.c
> +++ b/net/core/skbuff.c
> @@ -3977,7 +3977,18 @@ void skb_copy_and_csum_dev(const struct sk_buff *skb, u8 *to)
>  	else
>  		csstart = skb_headlen(skb);
>  
> -	BUG_ON(csstart > skb_headlen(skb));
> +	if (unlikely(csstart < 0 || csstart > skb_headlen(skb) ||

[Severity: Low]

The commit message says a negative offset "gets past the check and
becomes a ~4GB copy". Is that only the case on 64-bit?

csstart is a long and skb_headlen() returns unsigned int. On 64-bit the
comparison is signed. A negative csstart gets past the old BUG_ON() and
becomes a huge unsigned int length in skb_copy_from_linear_data().

On 32-bit the comparison is unsigned, so the old BUG_ON() would have
caught it.

The patch closes a silent memory-corruption path on 64-bit, plus the
csum_offset store described above. Should it have a Fixes: tag or a
Cc: stable? The trailers only have Assisted-by: and Signed-off-by:. No
producer is named that would show whether this is reachable, and that may
affect whether a stable backport is needed.

> +		     (skb->ip_summed == CHECKSUM_PARTIAL &&
> +		      csstart + skb->csum_offset + sizeof(__sum16) >
> +		      skb->len))) {

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261007-b4-skbuff-bug-on-v2-0-b9a5f732895b%40toxicpanda.com
