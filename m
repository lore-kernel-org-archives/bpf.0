Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3276F25B0AA;
	Sun, 11 Oct 2026 03:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791690677; cv=none; b=pKfoAkR/JBU3BLVyZS3pGX6JW7Fm0+PnOpvY+aXVrjy267al5ZMcNIJHaPl0FAT0t/8QDURYxzdQIR5COJYhwLkkdwLqNpljrg9bB7wpNUy03V/RiAeP12Vz4Ux5gpD+4k63TV79pa9w1Ajf8kc8pUt3oCayBzQpGylxaEc3dFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791690677; c=relaxed/simple;
	bh=X5Ixg3fxEMwvNPAQRx75yKDpZg12oGnkj05165U+2Rg=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NHKHRudAT2igXJyESYgcazQEuwJENQfdyLFAEknShox2BSA1O3UPEBsIMFhKFtRaPWi1LqvScNFcRlikyXUGEP0KrlT+OzvvgDlDR3AoGf2EP4Cf21SOanGOYp23aFJ7dIUoKsC31FGjnEa7HOC5QNflhX5DasdNHCvTWnxDmMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gKpMiS/0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gKpMiS/0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EECF1F000FF;
	Sun, 11 Oct 2026 03:51:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791690675;
	bh=ajuPNc6AYdRFyH5XN7//XCC/5UxqIs3E6g54pV9bOBY=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=gKpMiS/0srXIO2nTPd+iwB3R2xkU2gjbOEnc+D3XsQPRZG0hxFQEHt2ikVKbH97b5
	 rA4gMGBE3kFfp+IJTZ0gSX7usJ3hGyefrQvMXLFya/bzgRwwFgY8lKn7wFVSNqLqlh
	 rNsBRv+8mgrCXz6k/X8oUMmxAoD45aaPw/gU9rjoooJ7H6xbmOoHYZQZlP3IMCnNEH
	 8WVtyqbZqf2v677nRpz3HOtdLrKiduOjTrttgJq6bjjvry7DilADIBqhPK60ZtRysc
	 UO3BKMnN12BgbnS5yH9QwuAzm2W1YB53h/2i2+E4Ls4EZ28CiN2fFnWot86IuJkj2i
	 /KcBUY3JnIxnA==
Subject: Re: [PATCH net-next v3 1/2] net: netmem: document netmem and memory
 provider design in comments
From: netdev-bot+sashiko@kernel.org
To: almasrymina@google.com
Cc: netdev@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 corbet@lwn.net, skhan@linuxfoundation.org, rdunlap@infradead.org,
 hawk@kernel.org, ilias.apalodimas@linaro.org, ast@kernel.org,
 daniel@iogearbox.net, john.fastabend@gmail.com, sdf@fomichev.me,
 lrizzo@google.com, bjorn@kernel.org, asml.silence@gmail.com
Date: Sun, 11 Oct 2026 03:51:13 +0000
Message-ID: <179169067381.434549.11136857943175735340@kernel.org>
In-Reply-To: <20261010033630.1171692-2-almasrymina@google.com>
References: <20261010033630.1171692-2-almasrymina@google.com>
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

Critical: 0 · High: 0 · Medium: 1 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The patch adds a comment in skb_try_coalesce()
  (net/core/skbuff.c, lines 6213-6216).
- [Low] The new skb_frag_t comment (include/linux/skbuff.h:361-363) gives
  'the same io_uring area' as an example of 'the same memory provider…

--

net: netmem: document netmem and memory provider design in comments

This commit adds comments describing the design principles for netmem,
memory providers, page_pool and skb frags. It documents that all frags in
an skb must be page-backed or come from the same memory provider instance.
It also adds a comment to that effect in skb_try_coalesce().

> diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
> index 27ec1e38c8283..af1cbc2799b77 100644
> --- a/include/linux/skbuff.h
> +++ b/include/linux/skbuff.h
> @@ -358,6 +358,12 @@ struct sk_buff;
>   */
>  #define GSO_BY_FRAGS	0xFFFF
>  
> +/* All frags in an skb must either all be struct page-backed or all belong to
> + * the same memory provider instance (e.g. the same devmem binding or io_uring
> + * area). Mixing page and memory-provider frags, or mixing frags from different

[Severity: Low]
Is "io_uring area" the right example here? For io_uring zcrx, the provider
instance is the ifq, not the area:

io_uring/zcrx.c:io_pp_to_ifq() {
	return pp->mp_priv;
}

io_zcrx_recv_frag() also checks identity per ifq:

	if (!pp || pp->mp_ops != &io_uring_pp_zc_ops || io_pp_to_ifq(pp) != ifq)
		return -EFAULT;

One ifq can own several areas. io_zcrx_append_area() grows ifq->areas[] up
to ZCRX_MAX_AREAS, and userspace can add areas to an existing ifq with
ZCRX_CTRL_ADD_AREA. Frags from two areas of the same ifq share one provider
instance and one page_pool, and nothing stops them from sharing an skb.

Read literally, the example says those frags must not share an skb. Would
"the same io_uring zcrx ifq" be more accurate?

The later commit "docs: netmem: document netmem and memory provider design
principles" repeats this example in Documentation/networking/netmem.rst.

> + * memory providers within a single skb (including via coalescing), is not
> + * allowed.
> + */
>  typedef struct skb_frag {
>  	netmem_ref netmem;
>  	unsigned int len;

[ ... ]

> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> index d56f4f0102f75..69d3d27e29d97 100644
> --- a/net/core/skbuff.c
> +++ b/net/core/skbuff.c
> @@ -6210,6 +6210,10 @@ bool skb_try_coalesce(struct sk_buff *to, struct sk_buff *from,
>  	if (to->pp_recycle != from->pp_recycle)
>  		return false;
>  
> +	/* All frags in an skb must either all be struct page-backed or all
> +	 * belong to the same memory provider instance; do not coalesce skbs
> +	 * that would mix them.
> +	 */
>  	if (skb_frags_readable(from) != skb_frags_readable(to))
>  		return false;

[Severity: Medium]
Does this check enforce the rule stated in the comment above it?
skb_frags_readable() only looks at a single bit:

include/linux/skbuff.h:skb_frags_readable() {
	return !skb->unreadable;
}

Nothing in skb_try_coalesce() compares pp->mp_priv, the devmem binding or
the zcrx ifq of to and from.

Two unreadable skbs from different provider instances would pass this
check, and their frag arrays would be memcpy'd together. For example, two
devmem bindings, or a devmem binding and a zcrx ifq, could reach one TCP
socket through different RX queues via
tcp_try_coalesce()->skb_try_coalesce().

Also, when an unreadable from skb has a non-zero, stealable linear head,
the skb_headlen(from) != 0 branch adds the head page as a page frag next to
the net_iov frags:

	page = virt_to_head_page(from->head);
	...
	skb_fill_page_desc(to, to_shinfo->nr_frags,
			   page, offset, skb_headlen(from));

skb_gro_receive() in net/core/gro.c is another coalescing path. It checks
only pp_recycle and skb_zcopy, with no readability or provider check.

Existing consumers already handle mixed skbs one frag at a time:
io_zcrx_recv_frag() rejects frags from another ifq, and
tcp_recvmsg_dmabuf() re-checks each frag with skb_frag_net_iov().

The same patch also says providers may supply page-backed netmems and that
net_iovs may be readable. Under those principles, readability alone can't
tell page frags from provider frags.

The new skb_frag_t comment and the commit message state this as a hard
invariant ("is not allowed", "including via coalescing"). Could the wording
describe what the code currently guarantees instead? Otherwise the per-frag
checks above might later be removed because of it.

Or should skb_try_coalesce() and skb_gro_receive() actually compare
provider identity?

The later commit "docs: netmem: document netmem and memory provider design
principles" repeats the same claim in Documentation/networking/netmem.rst.
The comment here is not corrected anywhere in the series.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261010033630.1171692-1-almasrymina%40google.com
