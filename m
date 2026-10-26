Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792991126;
	b=J2tZ3fJwEQRMdqvjhCRLCybIioCLompyps3ECdrGFjnWfyPQ+B5KnHNmSfAhZqFhZEZE
	 rcsJ9L3R2+tO5OMeXxSroS7EmZH8OiVKwnrhoWokxpX56ZFWzjEeFFd6GPnJRyB+FRpfw
	 V44T+Spdy1jfcRGCSdmGr+fZYWilY6oEN9XFqg73tcqBuEBuM0mxWmLBE0AlQwhSJFcik
	 SZHeYRlHVefuVIeny3PH9MnsIZUdZB2tqt9gXTNTPerFeKd4Al8TskcwOM3npxCb3gxFg
	 TNzmRbni8W1IVfqny7Uto7kqbV3ewSU/Oopk/fX5V/Cb0yHhYQvMR3PuBoYR8vKmpZA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792991126;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=2mJ2Dm6CqrM0byK/8f5SbclEqaonqfPePomOFdNTjzQ=;
	b=eUOCQ57Sny64IwfcwMebk0VyhF/cJbm1f0SXCZaS5UlHNmo8rO4//viw+iojGODoAgBp
	 6BnnBOmYlGqeV0XKK6+lacYvchww0vqmDhtjwuC3m894I8pIMKedCdFtHUQ32Te4ZTlBZ
	 fDAvufJYemRE9otrHHpByAJ3gKmZqP+hGms56ortFX0R1BGh/zKb4d+Ap52si8dMqojru
	 wwNsa7ZTZWV1MYOCCZiL5+MULdNfy6SgyvD5mak60e032HOSlrvs7pYTSW3gY+ZcENxPH
	 bIGPXV+YpQ+fYHvXnOGQ9qqF/9ALu96EcEchTyhmwF9rbg7JTOG3iNcloQs882vtaCw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AsTQ9v3C;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89034606A31A;
	Mon, 26 Oct 2026 05:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AsTQ9v3C
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 441BE1F01825;
	Mon, 26 Oct 2026 05:05:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792991126;
	bh=2mJ2Dm6CqrM0byK/8f5SbclEqaonqfPePomOFdNTjzQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=AsTQ9v3CAO5fnoCL7YFentEDArMsIW42dzNouGP+XtbzNzWlIhfUto998NxbjN4F5
	 qfVWmiH247iDy4axd6Uf9WVWOnYQ1Nj5AUwZhOqGZqewh7E1aIZTlI7uwIMU8CTkB0
	 WIGXI1zCNZ8wudc4JgvbVqC+aBBjLC1GMBieQo4JMDcSWbUsUiUWGrIXmzWW4+VfIi
	 zFFT/AjqXFaB3oaKc4x9Ulmjq6eHx6EePSbPXB98npaCtP2Wwy+WfEuxSkOhIIJtYG
	 pvGZMdDgX3Dx8r6g4lsP/AzJFoK46YQJAvYgrm44JFEfZGN3PsFX20T7WBIPX8GCKW
	 j9/ckR3c8FsJg==
Subject:
 Re: [PATCH net 1/2] net: Make PSP skb extension survive packet scrubbing
From: netdev-bot+sashiko@kernel.org
To: weiwan@google.com
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 andrew+netdev@lunn.ch, shuah@kernel.org, horms@kernel.org,
 jakub@cloudflare.com, daniel.zahka@gmail.com, willemb@google.com,
 netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Date: Mon, 26 Oct 2026 05:05:24 +0000
Message-ID: <179299112474.3134.2003199816680362406@kernel.org>
In-Reply-To: <20261025040523.678027-2-weiwan@google.com>
References: <20261025040523.678027-2-weiwan@google.com>
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

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] In net/core/skbuff.c, skb_ext_scrub() (lines 7446-7461) deletes
  extensions one at a time with skb_ext_del() and keeps SKB_EXT_PSP…
- [Medium] Keeping SKB_EXT_PSP across tunnel decap in skb_scrub_packet()
  (net/core/skbuff.c:6402) means inner IP fragments taken from a PSP-…

--

net: Make PSP skb extension survive packet scrubbing

This patch adds skb_ext_scrub(), which deletes every skb extension except
SKB_EXT_PSP. It uses the new helper in skb_scrub_packet() in place of
skb_ext_reset(). The goal is to keep the PSP extension on packets
redirected into another netns, for example through netkit associated
with a PSP device.

Link: https://lore.kernel.org/r/20260910-bpf-meta-inside-skb-ext-v2-3-0b21e42180b0@cloudflare.com
Closes: https://lore.kernel.org/netdev/DLODSKPY6ON6.1G6SP3CFFLCPJ@gmail.com/

> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> index 48f6764117243..4269d91cf6078 100644
> --- a/net/core/skbuff.c
> +++ b/net/core/skbuff.c

[ ... ]

> @@ -6398,7 +6399,7 @@ void skb_scrub_packet(struct sk_buff *skb, bool xnet)
>  	skb->skb_iif = 0;
>  	skb->ignore_df = 0;
>  	skb_dst_drop(skb);
> -	skb_ext_reset(skb);
> +	skb_ext_scrub(skb);

[Severity: Medium]
skb_scrub_packet() also runs on tunnel decap, for example in
ip_tunnel_rcv() and in vxlan_rcv()->__iptunnel_pull_header(). With this
change, inner IP fragments taken from a PSP-decrypted tunnel payload now
carry SKB_EXT_PSP.

Before this patch, a PSP extension could only be on whole transport-mode
packets. Those have no inner IP header, so they can't be fragmented.

IP reassembly takes the extensions from the head fragment only:

net/ipv4/inet_fragment.c:inet_frag_reasm_prepare() {
    ...
	skb_morph(skb, head);
    ...
}

inet_frag_reasm_finish() never compares the extensions of the other
fragments.

Could a reassembled TCP segment keep a valid PSP extension when only its
head fragment came through PSP? The remaining fragments could arrive
unprotected, as plain IP or plain VXLAN with a spoofed inner source.

__psp_sk_rx_policy_check() only compares spi, generation, version and
dev_id through psp_pse_matches_pas(). It looks like such a segment would
be accepted by the PSP socket.

This seems hard to exploit:

  - The PSP peer would have to send inner fragments, and inner TCP
    usually sets DF.
  - The attacker would have to guess the IP ID.
  - Mismatched ip_summed forces CHECKSUM_NONE, so the attacker's
    fragments must reproduce the checksum of encrypted, unknown data.

The commit message only justifies keeping the PSP extension for
cross-netns forwarding. Was keeping it across tunnel decapsulation also
intended?

>  	nf_reset_ct(skb);
>  	nf_reset_trace(skb);
>  
> @@ -7441,6 +7442,23 @@ void __skb_ext_put(struct skb_ext *ext)
>  	kmem_cache_free(skbuff_ext_cache, ext);
>  }
>  EXPORT_SYMBOL(__skb_ext_put);
> +
> +void skb_ext_scrub(struct sk_buff *skb)
> +{
> +	unsigned int id;
> +
> +	if (likely(!skb->active_extensions))
> +		return;
> +
> +	for (id = 0; id < SKB_EXT_NUM; id++) {
> +#if IS_ENABLED(CONFIG_INET_PSP)
> +		if (id == SKB_EXT_PSP)
> +			continue;
> +#endif
> +		skb_ext_del(skb, id);
> +	}

[Severity: High]
Can this loop leave a shared extension block half-deleted, and later
cause an xfrm_state refcount underflow?

Take skb A with ext block E, where SKB_EXT_PSP and SKB_EXT_SEC_PATH are
both active and E is shared with clone B (refcnt 2). When the loop
reaches SKB_EXT_SEC_PATH, __skb_ext_del() does:

	skb->active_extensions &= ~(1 << id);
	if (skb->active_extensions == 0) {
		...
	}

	if (refcount_read(&ext->refcnt) > 1)
		return;

PSP is still active, so this returns early. E keeps offset[SEC_PATH] set,
and sp->len still holds the N xfrm_state references.

Now suppose skb_ext_add() runs on A while B is still alive. Callers that
can do this include nf_bridge_alloc(), tc_skb_ext_alloc() and MPTCP.
skb_ext_maybe_cow() copies the whole block, stale sec_path included, but
only takes references for active ids:

	memcpy(new, old, old->chunks * SKB_EXT_ALIGN_VALUE);
	refcount_set(&new->refcnt, 1);

#ifdef CONFIG_XFRM
	if (old_active & (1 << SKB_EXT_SEC_PATH)) {
		...
			xfrm_state_hold(sp->xvec[i]);
	}

__skb_ext_put() releases based on offsets, not active bits:

	if (__skb_ext_exist(ext, SKB_EXT_SEC_PATH))
		skb_ext_put_sp(skb_ext_get_ptr(ext, SKB_EXT_SEC_PATH));

Freeing A puts the N states through the copy. Freeing B puts the same N
states again through E.

Wouldn't that underflow the xfrm_state refcount and allow a
use-after-free of the xfrm_state?

If B is freed first instead, a later secpath_set() on A can leak the
references. This happens when the inner packet is ESP again. skb_ext_add()
reuses the stale slot through this path:

		if (__skb_ext_exist(new, id))
			goto set_active;

secpath_set() then sees tmp == NULL and sets sp->len = 0. That loses the
N references still stored in xvec[].

One possible path:

  - A PSP packet whose nexthdr is ESP gets a sec_path from host xfrm.
  - After ESP decap, an AF_PACKET tap clones it in packet_rcv(), so the
    ext block is now shared.
  - The inner packet is VXLAN, so
    vxlan_rcv()->__iptunnel_pull_header()->skb_scrub_packet() runs.
  - The VXLAN device is a bridge port with br_netfilter, so
    nf_bridge_alloc() triggers the COW.

The commit message says:

    Scrubbing is safe when the extension slab is shared with clones:
    deleting an extension only clears the per-skb active_extensions bit,
    and the shared slab payload is released lazily by __skb_ext_put()
    once the last reference goes away.

Does that still hold once the scrubbed skb is COWed or re-adds the slot?
The previous skb_ext_reset() dropped the whole block and never left one
in this state.

The same COW/put asymmetry already exists for secpath_reset() callers
such as l2tp_eth_dev_recv() and xfrmi_scrub_packet(). This patch makes it
reachable from every tunnel encap/decap and netns forward.

Instead of looping over skb_ext_del(), could this call skb_ext_reset()
when PSP is not active? When PSP is active, it could attach a fresh
extension that holds only the PSP payload. Another option might be for
skb_ext_maybe_cow() to clear the offsets of inactive ids in the copy.

> +}
> +EXPORT_SYMBOL(skb_ext_scrub);
>  #endif /* CONFIG_SKB_EXTENSIONS */
>  
>  static void kfree_skb_napi_cache(struct sk_buff *skb)

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261025040523.678027-1-weiwan%40google.com
