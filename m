Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F7CD3644C4;
	Sun, 11 Oct 2026 17:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791738051; cv=none; b=hYRcdtLxjpej/nGHlY2JSRWkGO+hvroNsG/0SkxSTgTRGFdwuDc43KK49bikZcn5KYpLaR1UCsRwqdCfNPUQUOJazh/hHwkDwt/BuWPwNOz/7e2deVswARQITPNK7jZq+tCUj1MSOIJmQI58U8rkgX1qgSC9UOio5dN3+DTHA5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791738051; c=relaxed/simple;
	bh=Ulc8WFFdhXnbNRQHtoUH6mhsvkE5+lbsQ+zyeiwMAQ4=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FjXgPPlq0if8T2lBuuA4vgHSN/WNLYiVQtKEUxMyr+OjmhhkqssEM+1akFGjaaKeA0m/hXjhRvgxZw12bctArnAk71bG8gs8XjYM0R9RZuftItmXijvbuLgBVvnEaDMDxGp1MPTFUaPuCfe6TSsGOmzLJUL4z8LFH+F7Fe3s1Is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h0Yldqp7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h0Yldqp7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 386771F0089C;
	Sun, 11 Oct 2026 17:00:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791738047;
	bh=KUE1/HKL2xsUcJ0Z2e13IaEat+osxMwOiXWI3pHZInI=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=h0Yldqp7cPfxOOwY4ixefQKKMzdwU9JkAlfUkM4CtfiByR52PCftweI2QmHXE8Mey
	 K+nHfPvTfKXaq0VeZp3rIJjuaV3n3KkAcUosQNXfMUvRNliuCqu+y5z5sU3IaGrGTZ
	 qVZgqCQJb0w4WG0pQotiZkKnM3FNBq9LdjI/1bgr1rdhaeQ9nQNyJl13V58hnI0KuO
	 eK9NkR3KIvS0XFNyeK3D0PMPSlRtu8XcGey4GbcdRyvuoueHdBXmEw4iFnzWvgkXUn
	 qLuLJGfek11oHZ73vn9BcVaEJ/RQdlmhMFUr8C0WgehZkYQJuIA1jtqHb1BpLrJksq
	 xczSwi2VNLO6g==
Subject: Re: [PATCH net-next v2 4/8] net: skbuff: don't BUG() on leftover
 length in skb_checksum() and friends
From: netdev-bot+sashiko@kernel.org
To: josef@toxicpanda.com
Cc: davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Date: Sun, 11 Oct 2026 17:00:46 +0000
Message-ID: <179173804681.434549.10094920844751005897@kernel.org>
In-Reply-To: <20261007-b4-skbuff-bug-on-v2-4-b9a5f732895b@toxicpanda.com>
References: <20261007-b4-skbuff-bug-on-v2-4-b9a5f732895b@toxicpanda.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 2

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] skb_checksum() and skb_crc32c() now return 0 when they run out
  of skb before @len.
- [Low] The fix is incomplete for one sibling walker in another file.
- [Low] The kernel-doc for skb_to_sgvec() still says it returns "either
  the number of scatterlist items used, or -EMSGSIZE if the contents…

--

net: skbuff: don't BUG() on leftover length in skb_checksum() and friends

This patch replaces the trailing BUG_ON(len) in skb_checksum(),
skb_crc32c() and __skb_to_sgvec() with DEBUG_NET_WARN_ON_ONCE(). In
that case skb_checksum() and skb_crc32c() now return 0, and
__skb_to_sgvec() returns -EINVAL.

> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> index ffc78b1a8ab85..32d7f5ed25eb4 100644
> --- a/net/core/skbuff.c
> +++ b/net/core/skbuff.c
> @@ -3619,7 +3619,10 @@ __wsum skb_checksum(const struct sk_buff *skb, int offset, int len, __wsum csum)
>  		}
>  		start = end;
>  	}
> -	BUG_ON(len);
> +	if (unlikely(len)) {
> +		DEBUG_NET_WARN_ON_ONCE(1);
> +		return 0;
> +	}

[Severity: Medium]
Is 0 a safe value to return here? 0 is also a valid checksum. Returning
it drops the caller's seed and the partial sum, so callers can't tell a
failed walk from a real result.

The commit message says:

  The resulting checksum is wrong, so the packet fails verification on
  receive or goes out with a bad checksum on transmit

However, __skb_checksum_complete() adds the pseudo-header in skb->csum
after the call:

net/core/skbuff.c:__skb_checksum_complete() {
	csum = skb_checksum(skb, 0, skb->len, 0);

	sum = csum_fold(csum_add(skb->csum, csum));
    ...
	if (!skb_shared(skb)) {
		/* Save full packet checksum */
		skb->csum = csum;
		skb->ip_summed = CHECKSUM_COMPLETE;
		skb->csum_complete_sw = 1;
		skb->csum_valid = !sum;
	}

	return sum;
}

When csum is 0, sum becomes csum_fold(skb->csum). That is 0 whenever the
pseudo-header sum, which depends only on saddr, daddr, len and proto,
folds to 0xffff.

In that case, would tcp_checksum_complete() and the UDP checksum paths
accept a packet whose payload was never fully checksummed? The skb would
also have csum_valid set and a wrong CHECKSUM_COMPLETE value in
skb->csum.

skb_crc32c() has a similar problem through sctp_compute_cksum():

include/net/sctp/checksum.h:sctp_compute_cksum() {
    ...
	new = ~skb_crc32c(skb, offset, skb->len - offset, ~0);
    ...
}

A 0 return becomes 0xffffffff whatever the packet contains. So
sctp_rcv_checksum() would accept the packet whenever the checksum on the
wire equals that value.

Callers that pass their seed into skb_checksum(), such as
__skb_checksum_complete_head(), do fail as described, because
csum_fold(0) is 0xffff.

Hitting this still needs an skb whose skb->len is larger than the data
in head, frags and frag_list. Before this patch, the same case hit the
BUG().

[ ... ]

> @@ -5339,7 +5345,10 @@ __skb_to_sgvec(struct sk_buff *skb, struct scatterlist *sg, int offset, int len,
>  		}
>  		start = end;
>  	}
> -	BUG_ON(len);
> +	if (unlikely(len)) {
> +		DEBUG_NET_WARN_ON_ONCE(1);
> +		return -EINVAL;
> +	}
>  	return elt;
>  }

[Severity: Low]
Should __skb_nsg() in net/tls/tls_sw.c get the same change? It copies
this head/frags/frag_list walk, and it still ends with:

net/tls/tls_sw.c:__skb_nsg() {
    ...
        BUG_ON(len);
        return elt;
}

tls_decrypt_sg() calls skb_nsg() on the same range that it later passes
to skb_to_sgvec():

	n_sgin = skb_nsg(skb, rxm->offset + prot->prepend_size,
			 rxm->full_len - prot->prepend_size);
    ...
	err = skb_to_sgvec(skb, &sgin[1],
			   rxm->offset + prot->prepend_size,
			   rxm->full_len - prot->prepend_size);
	if (err < 0)
		goto exit_free;

If that range ever ran past the end of the skb, the path
tls_decrypt_sg()->skb_nsg()->__skb_nsg() would still BUG(). That happens
before the new -EINVAL path in __skb_to_sgvec() is reached. The commit
message doesn't mention __skb_nsg().

A later commit in the series, "net: skbuff: don't BUG() on leftover
length in skb_copy_and_csum_bits()", covers the skb_copy_and_csum_bits()
case. After that, the TLS copy seems to be the only one left.

[Severity: Low]
This isn't a bug, but the kernel-doc for skb_to_sgvec() still says:

 *	region of the buffer space attached to a socket buffer. Returns either
 *	the number of scatterlist items used, or -EMSGSIZE if the contents
 *	could not fit.

skb_to_sgvec() and skb_to_sgvec_nomark() return this new -EINVAL to
their callers unchanged. Could the comment mention it as well? Nothing
later in the series updates it.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261007-b4-skbuff-bug-on-v2-0-b9a5f732895b%40toxicpanda.com
