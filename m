Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794075790;
	b=5gpYS4BFOEas9Sbkvb6Hevzy4gz06E57l0f5Hj8wtK/Q6wcNpVxd4d/yQApxm4sdT8oV
	 Ug7v1k4+jvKJf7vca7JaT4NzZWPLsqmuauEIiQynHvs0oeEvRt+pe1uCLhgx9XC7Qny7q
	 NQOIDZ9ojmhRUb9FzWc5sRR/DNYCFk/xYh03Zo4sRQMLtGuoMQtEEXzx/yvxkarZOW2os
	 /rsuNAADVFP8i877rVZGJHm7CvSUyiWr5uWp8KMU3H9B7D51MGUawmdoNObBsv4NOjnx3
	 oaOyfJ03Hptw+molYdzqOO4MUikTUpzJkEuW/YZYdCc9RRrQIUCv55FQGidAjkeMIaA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794075790;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=VL4CJG4Bqvr+fzoMjPDzD2G1n8i3JodTzSWz2pr6X1o=;
	b=tiBNZLXfeqA0amEbLDekBTc7UvRE+R9TbpxHmPTBtYx2qA3Zli/8SV9Bii7UfqDCcbi+
	 x4w0LQ1OaG8lDTSAEEGviPl2glv2kI/LDZ54sSi8bKEm/LjSz8P2ah52JrxP+1m6DvvJl
	 9aFP+Fkwxg12YYNQt72I6zB1bgUZBGAzW3coJwvrFBe2WAW7gRSQzOHJ9XQDwGcaAIJs9
	 QiXVoFgXjI4caFo7jP+PufXhGgQMejn8BzSJJGT5dVoUQYBSyBJ9LASuJXtsn0XClXat8
	 ul30Dgejo93Bsusz1e1Rv9xRJVMlKCXU5ewZwEIzW2FbEO/5cq+z3F6iqQq237zKn0A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Cvp43QIL;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4370C606A330;
	Sat,  7 Nov 2026 18:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Cvp43QIL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07E861F0089F;
	Sat,  7 Nov 2026 18:23:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794075789;
	bh=VL4CJG4Bqvr+fzoMjPDzD2G1n8i3JodTzSWz2pr6X1o=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Cvp43QILjzTswudy4XJI2wVZ5VTBSzve87ORyugzjgjaq+fSynMOM+b0zQH4zcJ9c
	 Q6VnVQnukvW/bSkUWP4WIzZCxZaNHANL1dNtPvsX6V5JbdSJOfa56l2ylLTDZvGXwk
	 d8/K8GAFYAtDkJGEQwkhDatupr3+HB0/bLi66nzp71HBUqTay/zAHld57Whuxa5acy
	 S5CCBtdG5guIi/tQBgcWxeJjMaW3em2aIHHxAR14JekvKnIR7tNrQJ5Wt3gWsWChIJ
	 UUcrdCNBdrnhX3ARwEq61Jwv849hFDXfZtlYcs02dfieCVmV0zhHHV4EfFisjd2Xqr
	 kDpefGO+pb5Bg==
Subject:
 Re: [PATCH net v3 1/2] net: Make PSP skb extension survive packet scrubbing
From: netdev-bot+sashiko@kernel.org
To: weiwan@google.com
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 andrew+netdev@lunn.ch, shuah@kernel.org, horms@kernel.org,
 jakub@cloudflare.com, daniel.zahka@gmail.com, willemb@google.com,
 netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Date: Sat, 07 Nov 2026 18:23:08 +0000
Message-ID: <179407578851.994134.3306031633734740315@kernel.org>
In-Reply-To: <20261106182007.374660-2-weiwan@google.com>
References: <20261106182007.374660-2-weiwan@google.com>
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

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] skb_ext_scrub() keeps SKB_EXT_PSP for every caller of
  skb_scrub_packet().
- [Low] On the slow path, skb_ext_scrub() frees the whole extension block
  with skb_ext_reset() before it re-creates SKB_EXT_PSP with…

--

net: Make PSP skb extension survive packet scrubbing

This patch adds a static skb_ext_scrub() helper, called from
skb_scrub_packet(). It keeps SKB_EXT_PSP and drops every other skb
extension. The goal is to keep the PSP metadata on packets redirected into
a netns associated with a PSP device via PSP_CMD_DEV_ASSOC, so that
__psp_sk_rx_policy_check() stops rejecting them.

Link: https://lore.kernel.org/r/20260910-bpf-meta-inside-skb-ext-v2-3-0b21e42180b0@cloudflare.com

> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> index 8da53d5b76fc2..3f8dc08b434fa 100644
> --- a/net/core/skbuff.c
> +++ b/net/core/skbuff.c
> @@ -6379,6 +6379,31 @@ bool skb_try_coalesce(struct sk_buff *to, struct sk_buff *from,
>  }
>  EXPORT_SYMBOL(skb_try_coalesce);
>  
> +static void skb_ext_scrub(struct sk_buff *skb)
> +{
> +#if IS_ENABLED(CONFIG_INET_PSP)
> +	struct psp_skb_ext *pse = skb_ext_find(skb, SKB_EXT_PSP);
> +
> +	if (pse) {

[Severity: Medium]

Is SKB_EXT_PSP meant to be kept for every caller of skb_scrub_packet()?
The commit message only argues for one case: a netkit redirect into a
netns associated through PSP_CMD_DEV_ASSOC.

skb_scrub_packet() is also called from:

  - same-netns tunnel decap: ip_tunnel_rcv(), __iptunnel_pull_header()
    for vxlan/geneve, __ip6_tnl_rcv()
  - tunnel encap on TX: iptunnel_xmit(), vxlan_xmit_one(),
    geneve_build_skb()
  - dev_forward_skb(), veth and ipvlan, into any netns
  - skb_do_redirect()

Nothing here checks xnet, the direction, or whether the target netns or
device is associated with pse->dev_id.

psp_dev_rcv() copies the next header into the outer IP header without
checking it:

net/psp/psp_main.c:psp_dev_rcv() {
    ...
	iph->protocol = psph->nexthdr;
    ...
}

So the decrypted payload can be IPIP, GRE or UDP/VXLAN. Once a tunnel
driver decapsulates it, the inner packet now inherits the outer packet's
PSP metadata.

__psp_sk_rx_policy_check() decides based on whether the extension is
present:

include/net/psp/functions.h:__psp_sk_rx_policy_check() {
    ...
	if (!pas)
		return pse ? SKB_DROP_REASON_PSP_INPUT : 0;
    ...
}

Doesn't this change two outcomes?

First, inner or forwarded traffic to a non-PSP socket was accepted before.
That applies both to a non-associated netns and to traffic behind a
tunnel. It would now be dropped with SKB_DROP_REASON_PSP_INPUT.

Second, inner tunnelled TCP segments to a PSP socket were rejected before.
They would now be accepted when spi, dev_id, generation and version match.

The skb_scrub_packet() kernel-doc still says that for xnet we "have to
clear all information in the skb that could impact namespace isolation".
The new note only says the PSP skb extension is "preserved across packet
scrubbing by design".

Should preservation be limited to the associated-netns case? If not,
could the reasoning for the tunnel decap and non-associated netns cases
be documented?

> +		struct skb_ext *ext = skb->extensions;
> +		struct psp_skb_ext tmp;
> +
> +		/* Nothing else to scrub if PSP is the only extension in ext. */
> +		if (ext->chunks == SKB_EXT_CHUNKSIZEOF(*ext) +
> +				   skb_ext_type_len[SKB_EXT_PSP])
> +			return;
> +
> +		tmp = *pse;
> +		skb_ext_reset(skb);
> +		pse = skb_ext_add(skb, SKB_EXT_PSP);
> +		if (pse)
> +			memcpy(pse, &tmp, sizeof(*pse));
> +		return;

[Severity: Low]

What happens to the PSP metadata if skb_ext_add() fails here?

skb_ext_reset() frees the whole extension block first. With
active_extensions now 0, skb_ext_add() goes through
__skb_ext_alloc(GFP_ATOMIC), which can fail under memory pressure. If it
does, the PSP extension is lost without any signal and the packet keeps
going.

That seems to contradict the new kernel-doc line "PSP skb extension is
preserved across packet scrubbing by design".

It also differs from psp_dev_rcv(), which treats the same failure as
fatal:

net/psp/psp_main.c:psp_dev_rcv() {
    ...
	pse = skb_ext_add(skb, SKB_EXT_PSP);
	if (!pse)
		return -EINVAL;
    ...
}

Its callers, mlx5e_psp_offload_handle_rx_skb() and nsim_do_psp(), then
drop the packet.

If the allocation fails here, a data segment for a PSP socket would later
be dropped in __psp_sk_rx_policy_check() with SKB_DROP_REASON_PSP_INPUT.
That is the symptom this patch is meant to fix, and the drop reason would
be misleading.

Could the replacement be allocated before the old block is released? Or
should the new comment be reworded so it does not promise unconditional
preservation?

> +	}
> +#endif
> +	skb_ext_reset(skb);
> +}

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261106182007.374660-1-weiwan%40google.com
