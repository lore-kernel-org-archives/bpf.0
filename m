Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795784338;
	b=BEaBs23onI8saAfyI7l3/0XzXRYUgNyZJOS8Ufr0y1D2v0Lxr07VoxAtDcmR3q8mh0e5
	 3iYbMreJCs0MTjRHF6wJO/3/tydO7qJPwuwHRZ5hSrCCkm3gIajvRMeRtO7Dhr5V3DunL
	 u4VtcSgnobQ7ukJ6MWYW+AAGPTnu7h4s113uuTaEWqdKZxwtu+cXy2bsmntxlSyh0WUSA
	 Xw++C+shVN+Xz/FezUUXG1bW/T3tJPRQwpHfbXgna0fzLZHV6QHL7khBseGuBMM0U+Xl7
	 P2s2RS2IYGB5TiXn2Jt3LJ8rEgX+n5J548CCGTVBS67M7TOwXACWtELTXV4ZS3KiHCg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795784338;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=S86xxUGwV15YEfbN+aCl9NirgG9JMY4TvbzkKSFyqG4=;
	b=XBXMHeqmxpVW/QvK9X9WwcCWzy4CPOvcvlDKFWBUUJ+32YgB7QWHfTh9SBqiJz3isKiN
	 BMcpkZY6k156VkzTPrfNR79bOvF4jMUPfLOFz0lAaY6xPSUYFqyem4zoX1B2PK8AwsA6E
	 jAsNje3ItlHQTogQw8bhuIBO52MM6BD4GIC2ZMC2tf/g9G1Ji3aiQJNKHze8i8kaZrXqn
	 cj/KEI2V2D1ZW+8o3XKP8xydyH0VKWKx9HCoh3BwnAqT5yDXC2hWNKdAZ3awgHklhAJzL
	 HFpZOshVcm/R0q8rSb6BKNzDmXC3xVeE9S4tUtt/YuDE4NVd4DChRSZnY2zRJ9rytZg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VI29tSQD;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4944B606A31C;
	Fri, 27 Nov 2026 12:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VI29tSQD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 408F11F00893;
	Fri, 27 Nov 2026 12:58:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795784338;
	bh=S86xxUGwV15YEfbN+aCl9NirgG9JMY4TvbzkKSFyqG4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=VI29tSQDQ0cTfVTKIQGO7tb4aUUSI64Vr2p1R4bDTg6Gs6dC1TOJZbKXYEvrZrLkt
	 nROB7nTSRoIhHXA+D7Kq3L406pbRzT7Nu6BOatj7HFU9j9eE8VaQDk4Ci8giC0ZifK
	 CK08c9iO4G9uMKFvi3TH4LKX6CxcqEFSi+9c3e7qSZM0u3EpKTHvmF6SirwbF+y7Gj
	 5dArZ7fbZjucMW6EA3N5VcqBF0OXMGsMfrRTmfJ7UgXWMqCUXweNV1KgIIw97WzNRW
	 gmqXGOX66ZkB+MbseS3lqCeTphuZ4uki5lhh8fFa2M6BS2y0HpkZw4ioY2bHBpb2z4
	 Gs7qqsVh/Blfg==
Subject: Re: [PATCH net] net: xdp: Fix skb->tail after bpf_xdp_adjust_tail()
 in generic mode
From: netdev-bot+sashiko@kernel.org
To: rhkrqnwk98@gmail.com
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, willemb@google.com,
 horms@kernel.org, ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
 john.fastabend@gmail.com, sdf@fomichev.me, tehnerd@tehnerd.com
Date: Fri, 27 Nov 2026 12:58:56 +0000
Message-ID: <179578433682.3135.10241295283064186673@kernel.org>
In-Reply-To: <20261126125558.2032158-1-rhkrqnwk98@gmail.com>
References: <20261126125558.2032158-1-rhkrqnwk98@gmail.com>
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

- [High] Generic XDP assumes the frame left after the BPF program runs
  still covers the mac_len bytes of L2 header that it subtracts.

--

net: xdp: Fix skb->tail after bpf_xdp_adjust_tail() in generic mode

This patch changes how bpf_prog_run_generic_xdp() recomputes skb->tail
after bpf_xdp_adjust_tail() has moved data_end. It now subtracts mac_len,
because the XDP frame starts mac_len bytes before skb->data. Without this,
skb->tail could land past skb->end, and a later tc bpf_skb_change_tail()
would write out of bounds.

> diff --git a/net/core/dev.c b/net/core/dev.c
> index cd0796a1dbfdf..1934e11c4401a 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -5737,7 +5737,7 @@ u32 bpf_prog_run_generic_xdp(struct sk_buff *skb, struct xdp_buff *xdp,
>  	/* check if bpf_xdp_adjust_tail was used */
>  	off = xdp->data_end - orig_data_end;
>  	if (off != 0) {
> -		skb_set_tail_pointer(skb, xdp->data_end - xdp->data);
> +		skb_set_tail_pointer(skb, xdp->data_end - xdp->data - mac_len);
>  		skb->len += off; /* positive on grow, negative on shrink */

[Severity: High]

This line assumes the frame left after the XDP program still covers the
mac_len bytes being subtracted. Is that guaranteed?

bpf_xdp_adjust_tail() only enforces a floor of ETH_HLEN relative to
xdp->data, not mac_len:

net/core/filter.c:bpf_xdp_adjust_tail() {
    ...
	if (unlikely(data_end < xdp->data + ETH_HLEN))
		return -EINVAL;
    ...
}

bpf_xdp_frags_shrink_tail() uses the same ETH_HLEN floor for nonlinear
frames.

In generic XDP, mac_len can be larger than ETH_HLEN. One example is a GRE
device that uses ipgre_header_ops (no remote, or a multicast remote). On
such a device, __ipgre_rcv() leaves mac_header at the outer IP header:

net/ipv4/ip_gre.c:__ipgre_rcv() {
    ...
		if (tunnel->dev->header_ops == &ipgre_header_ops)
			skb_pop_mac_header(skb);
    ...
}

So mac_len is at least 24 by the time do_xdp_generic() runs. The IPoIB
pseudo-header has a similar effect.

Take mac_len = 24 and headlen H, with a program that shrinks the frame to
data_end = xdp->data + 14:

  off = -(H + 10)
  skb_set_tail_pointer(skb, 14 - 24)  ->  skb->tail = skb->data - 10
  skb->len += off                     ->  skb->len wraps to 0xfffffff6

Before this patch tail was at least skb->data + 14. With it, tail ends up
before skb->data. The skb->len wrap is not new; it happened before this
patch too.

With that state, can the KASAN splat from the commit message still be
reached? A tc program that calls bpf_skb_change_tail(skb, 4096) sees
new_len < skb->len and takes the trim path:

  bpf_skb_change_tail()
    pskb_trim_rcsum()
      __skb_trim()    ->  skb->tail = skb->data + 4096

That can put tail past skb->end. A second call that grows the skb then
reaches __skb_grow() with a negative skb_tailroom(), no expand happens,
and bpf_skb_grow_rcsum() writes past the buffer.

Even without tc, ip_rcv_core() trusts the wrapped skb->len and calls
pskb_trim_rcsum(skb, iph->tot_len). tot_len comes from the received inner
header, so this could also move tail past skb->end.

The adjust_head fixup earlier in bpf_prog_run_generic_xdp() has a similar
gap. bpf_xdp_adjust_head() also keeps only ETH_HLEN bytes:

	if (unlikely(data < data_start ||
		     data > xdp->data_end - ETH_HLEN))
		return -EINVAL;

So off in __skb_pull(skb, off) can reach headlen + mac_len - ETH_HLEN. On
a linear skb that is larger than skb->len, and skb->len wraps silently.

Would it make sense to drop or clamp the frame here when
xdp->data_end - xdp->data < mac_len, and to do the same for the
adjust_head path? Another option is a lower bound in the helpers that
accounts for the generic XDP mac_len.

>  	}
>

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261126125558.2032158-1-rhkrqnwk98%40gmail.com
