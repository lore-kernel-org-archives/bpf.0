Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BA043612FE;
	Sun, 11 Oct 2026 17:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791738053; cv=none; b=ef5s10fPPD6izHCRZHjbdjUeHEuLj8YEK3UEOwbl+fXfDhocUas5l/G45z2c+1RbeUg1OdHNS+jpIPNhTu9TUA6eiv/scbUQZfx26HtH+qRJ4QrKAsN8g9+r71o/BVwoFAfi3OMjCWkAQ2Wh7zmJj+s8ux9XUxkHuoFAwKBFglg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791738053; c=relaxed/simple;
	bh=IDgTFkys4Nps5M9jPHe03DEeFlpEcWrXMp0xNffVmYM=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lmJ5ozqLhnvTx7YZvQBRsxFX7oXbDjdanIZ+prAjySgMRto+GR7XEhqaBdNmNVyvE21f+Bna8R1DXqzq5SwyMrf8/MvhqPG0z5IfQCnEAQcXtAdokgdoToJ9W7+D9IjUUWGIuZm8o43PFpAC6Y6Ob7ZTEoe9uL1D/ZCOiHTCN5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f7+3GlUW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f7+3GlUW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A95D1F0089D;
	Sun, 11 Oct 2026 17:00:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791738049;
	bh=zLwWcv2btELl1lMpdyJkvhRVTDN4ZWjaJXGg8NgIrfY=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=f7+3GlUWjGVDx0YmBL/W/XAv2anaXZGIp8ooeKentUKAAnQcYI8hDyEThPzgBRjvd
	 pgzyXlb9REPwe4IwERt1mqyCPIGY8Fp6Jbnq7Cwp9XBxOfffjY88/mrlMgpHTxcgJE
	 ROygBZCKG5foSXbMdY1Gb2RW8+F5LCyfd7qgMGtqhs+tmPiSHLPAlyUAdXDxxngkF2
	 sMcFQDj2LaZvDnZhZ/fNUTZFT+Dsr/4y5GPnuwchKl/fx1ZGVT37sNV0EGSj3Tjc0a
	 GK7JTsCA2TMaZ/VJfHK/sKp90NE7Q+ZPQvD5uM1/iQc1hQ47pKFG02j+lQHLbdThKa
	 kxyohiUeK2R2g==
Subject: Re: [PATCH net-next v2 6/8] net: skbuff: don't BUG() on leftover
 length in skb_copy_and_csum_bits()
From: netdev-bot+sashiko@kernel.org
To: josef@toxicpanda.com
Cc: davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Date: Sun, 11 Oct 2026 17:00:48 +0000
Message-ID: <179173804895.434549.6728733650187678065@kernel.org>
In-Reply-To: <20261007-b4-skbuff-bug-on-v2-6-b9a5f732895b@toxicpanda.com>
References: <20261007-b4-skbuff-bug-on-v2-6-b9a5f732895b@toxicpanda.com>
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

- [High] The patch zero-fills the destination on only one of
  skb_copy_and_csum_bits()'s two short-copy exits (net/core/skbuff.c).
- [Low] The commit message justifies the new behaviour with "Its callers
  copy into a buffer that is about to go out on the wire, an ICMP error…

--

net: skbuff: don't BUG() on leftover length in skb_copy_and_csum_bits()

This patch replaces the BUG_ON(len) at the end of skb_copy_and_csum_bits()
with a DEBUG_NET_WARN_ON_ONCE(). It zero-fills the part of the destination
buffer that was not copied and returns a checksum of 0, so a short copy
should not crash and should not leave stale bytes in the buffer.

> It can't just return, though.  Its callers copy into a buffer that is
> about to go out on the wire, an ICMP error quoting the offending packet
> for example, so bailing out early would send whatever was left in the
> rest of that buffer.

[Severity: Low]
Does this hold for every caller? xdr_skb_read_bits() in
net/sunrpc/socklib.c is on the receive path. It copies a received UDP skb
into RPC receive buffers:

net/sunrpc/socklib.c:xdr_skb_read_bits() {
    ...
		csum = skb_copy_and_csum_bits(desc->skb, desc->offset, to, len);
		desc->csum = csum_block_add(desc->csum, csum, desc->offset);
    ...
}

With this change, that path would put zeros in the RPC receive buffer and
get a partial checksum of 0. Only the later check in
csum_partial_copy_to_xdr() rejects the result:

	if (csum_fold(desc.csum))
		return -1;

This is still better than BUG(). Could the commit message also mention that
receive-side callers are affected?

> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> index c896770203f71..7fd2f8142cc41 100644
> --- a/net/core/skbuff.c
> +++ b/net/core/skbuff.c
> @@ -3713,7 +3713,13 @@ __wsum skb_copy_and_csum_bits(const struct sk_buff *skb, int offset,
>  		}
>  		start = end;
>  	}
> -	BUG_ON(len);
> +	if (unlikely(len)) {
> +		DEBUG_NET_WARN_ON_ONCE(1);
> +		/* Don't hand the caller a buffer with stale bytes in it. */
> +		if (len > 0)
> +			memset(to, 0, len);
> +		return 0;
> +	}

[Severity: High]
Does this cover every short-copy exit in skb_copy_and_csum_bits()? Right
after the linear head copy, the function still has:

	if (!skb_frags_readable(skb))
		return 0;

That exit leaves the remaining len bytes at to unwritten. So the stale-bytes
case the commit message describes can still happen in this function.

As one example, take an ICMP error that quotes a header-split skb with
unreadable (devmem) frags, where only the headers are in the linear area.
__icmp_send() caps the quote by skb->len and room, not by skb_headlen():

	icmp_param->data_len = icmp_param->skb->len - icmp_param->offset;
	if (icmp_param->data_len > room)
		icmp_param->data_len = room;

The call chain would then be:

__icmp_send()
  ip_append_data()
    __ip_append_data()        /* reserves non-zeroed skb data */
      icmp_glue_bits()
        skb_copy_and_csum_bits()
          if (!skb_frags_readable(skb))
                  return 0;

icmp_glue_bits() uses the return value only as a checksum and reports
success. icmp_push_reply() then calls ip_push_pending_frames().

Could this send several hundred bytes of uninitialized skb head memory on
the wire in the ICMP quote?

The frag_list recursion seems to have the same gap. If skb_gro_receive()
chains an unreadable skb onto frag_list, the recursive call returns 0
without writing anything:

			csum2 = skb_copy_and_csum_bits(frag_iter,
						       offset - start,
						       to, copy);

The outer loop still does len -= copy and to += copy, so the new memset()
at the end never covers that slice.

The unreadable early return predates this patch. It came from commit
65249feb6b3d ("net: add support for skbs with unreadable frags"). However,
the new comment and the commit message's "either way it carries nothing it
shouldn't" both depend on that exit being handled too.

skb_checksum() treats the same condition as an error:

	if (WARN_ON_ONCE(!skb_frags_readable(skb)))
		return 0;

Would it make sense to send the unreadable exit through the same guarded
zero-fill, for example with a shared label? That would also cover the
frag_list recursion, since each recursive call would zero its own slice.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261007-b4-skbuff-bug-on-v2-0-b9a5f732895b%40toxicpanda.com
