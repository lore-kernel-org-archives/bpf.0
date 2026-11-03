Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793683871;
	b=MR6AvNf9DXeUByPZ+ubHhUvKCQsHDFOML+l+PSyT0oLSVcntmti+/VDz948CRQR5PU/q
	 1Oy8PNg2i3eOD/I9BXSdbGSCCcua9eRHXGo8IJQwk8XR/efj7UlGN2MwdCDCYw28L1Nbd
	 v4waTBstA2vtq0v1KWQVPcm1h2NutuAfCZf2esZCSV4JEFWS/NIYJzdbo4jSMANydLl/2
	 6VsuuwH0HE5TKY1rKC8DHrY0i4nGcO3cmL6mP8fuxzzH378MgNTXcEMwY1WBCBjFsshR2
	 vrT7bTwT/j43+pMKFIjL8gbh11lKwctjqw+a5wypIheo8op8qWbd2DRuantwIix6sBQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793683871;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=83SLCOz3rh7B/wZGKItRNH7rHIr+gB02Ar0ANGvkQGw=;
	b=wu8trU+yLzm2R1afcQz2dcHDJFlnMI6FDFwySFYP+6xlaYJWQUccYClOz/HFNsrNctQR
	 IDTa142n36SHdfsgLFMR+kLFWZMtyT3VgmmTL7s0zDPz9ePEejhPJQsfRnT7ki+tY9pys
	 UUvA0qdype9s8mFZ7r2uZllEXdnAych0UAJ3TzLb+VvnxjBMMCLfi0BWocDUKg7l4Hslq
	 BGwfCJW1V58KF5W3UMEEOk/Vnm2o+1+sZUmGtyjwDRdjwWpbbulNLyceAn+ZDfaLXMaK0
	 Om3EXOeEtKEG5xZASqDRD8D9NmZ8grp+7h2gi9wEa3vOPtuiOe5kcSD8oIh/fe3XRpQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gCl8XuCp;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2B44606A32F;
	Tue,  3 Nov 2026 05:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gCl8XuCp
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B1FB1F0093A;
	Tue,  3 Nov 2026 05:31:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793683870;
	bh=83SLCOz3rh7B/wZGKItRNH7rHIr+gB02Ar0ANGvkQGw=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=gCl8XuCppbXqLs8tZEKmfRXaM80R3cadZ1y/tKS+l1SoSMHF/peFIGfJr43nog0Zo
	 e8c1EYkVPu+MhQ5qppGLQDZyHvbNuDvlzl5zSlPTALrDnsswIvzIQCjcRfqrvfY7rK
	 mZJcZmRzlcgd6Gao2fcSeTYMK9/tPjhUkyR9ORp/WiJkeI1MHsxuZPd0ZLMOXarT9h
	 CVM1cusmcbFZ/8lIH+ITAwfEQyiniARWqcsfpm7LNoyCck9F2WJvd9hMyKhEGLyEt+
	 von92Bmbq5PKm3x5fBYJzFFxUteOUJ+Y9ts0bpxLwQHGzYYlCHHqEtzx2jucxCbAqj
	 kRdV2ui3/oZjg==
Subject:
 Re: [PATCH net v2 1/2] net: Make PSP skb extension survive packet scrubbing
From: netdev-bot+sashiko@kernel.org
To: weiwan@google.com
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 andrew+netdev@lunn.ch, shuah@kernel.org, horms@kernel.org,
 jakub@cloudflare.com, daniel.zahka@gmail.com, willemb@google.com,
 netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Date: Tue, 03 Nov 2026 05:31:09 +0000
Message-ID: <179368386903.488856.14280858409286758396@kernel.org>
In-Reply-To: <20261030043145.2185700-2-weiwan@google.com>
References: <20261030043145.2185700-2-weiwan@google.com>
X-sashiko-severity: Medium
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

Critical: 0 · High: 0 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] When re-adding SKB_EXT_PSP fails in skb_ext_scrub()
  (net/core/skbuff.c:6401), the code clears skb->decrypted and lets the…

--

net: Make PSP skb extension survive packet scrubbing

This commit adds a static skb_ext_scrub() helper, used by
skb_scrub_packet() in place of skb_ext_reset(). The helper keeps
SKB_EXT_PSP and drops every other extension. If re-adding the PSP
extension fails, it clears skb->decrypted.

Link: https://lore.kernel.org/r/20260910-bpf-meta-inside-skb-ext-v2-3-0b21e42180b0@cloudflare.com

> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> index 48f6764117243..6adb54674f1c9 100644
> --- a/net/core/skbuff.c
> +++ b/net/core/skbuff.c
> @@ -6379,6 +6379,32 @@ bool skb_try_coalesce(struct sk_buff *to, struct sk_buff *from,
>  }
>  EXPORT_SYMBOL(skb_try_coalesce);
>  
> +static void skb_ext_scrub(struct sk_buff *skb)
> +{
> +#if IS_ENABLED(CONFIG_INET_PSP)
> +	struct psp_skb_ext *pse = skb_ext_find(skb, SKB_EXT_PSP);
> +
> +	if (pse) {
> +		struct skb_ext *ext = skb->extensions;
> +		struct psp_skb_ext tmp = *pse;
> +
> +		/* Nothing else to scrub if PSP is the only extension in ext. */
> +		if (ext->chunks == SKB_EXT_CHUNKSIZEOF(*ext) +
> +				   skb_ext_type_len[SKB_EXT_PSP])
> +			return;
> +
> +		skb_ext_reset(skb);
> +		pse = skb_ext_add(skb, SKB_EXT_PSP);
> +		if (pse)
> +			memcpy(pse, &tmp, sizeof(*pse));
> +		else
> +			skb->decrypted = 0;
                        ^^^^

[Severity: Medium]
If the GFP_ATOMIC allocation in skb_ext_add() fails, can a packet whose
payload is already decrypted lose its decrypted mark and be sent out as
plaintext?

Before this patch, skb_scrub_packet() only called skb_ext_reset(), which
leaves skb->decrypted alone. A HW-decrypted PSP RX packet, for example
from mlx5e_psp_offload_handle_rx_skb(), keeps skb->decrypted = 1. If it
is later forwarded, it is dropped in sk_validate_xmit_skb() in
net/core/dev.c, because forwarded packets have no skb->sk:

	if (sk_validate) {
		skb = sk_validate(sk, dev, skb);
	} else if (unlikely(skb_is_decrypted(skb))) {
		pr_warn_ratelimited("unencrypted skb with no associated socket - dropping\n");
		kfree_skb(skb);
		skb = NULL;
	}

This branch is the path taken when the extension buffer holds something
besides PSP, e.g. a TC_SKB_EXT or nf_bridge extension. On this path, if
__skb_ext_alloc(GFP_ATOMIC) fails, skb->decrypted is cleared but the
payload stays decrypted.

The packet could then reach an egress device by either route:

  skb_do_redirect() (BPF_F_PEER) -> skb_scrub_packet() -> forwarded in
  the peer netns

  ip_tunnel_rcv() -> skb_scrub_packet() -> forwarded

In both cases skb_is_decrypted() would return false, so the drop above
is skipped. On the success path the same packet is still dropped. The
check fails closed today, but on this failure path it would fail open.

Would it be safer to drop the packet, or keep skb->decrypted set, when
the PSP extension cannot be re-added?

> +		return;
> +	}
> +#endif
> +	skb_ext_reset(skb);
> +}
> +

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261030043145.2185700-1-weiwan%40google.com
