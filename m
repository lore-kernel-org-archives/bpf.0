Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 376E639099C;
	Mon, 19 Oct 2026 11:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792408239; cv=none; b=MVWlaSYb/Lm6U3hQ18daLKLYDBFftRivlkqeKl4FJsCLxWficoX4+Exnn5Vfd3PO5X1uLc0oqLYHhygLzI7PfSPH9WsI88vr6MlRl/H27abe24JGdBX5dndjVJ5x7dpdNV3iftjKtRazV6VojxXYn3QFJQwslXZVmWRMjro4y7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792408239; c=relaxed/simple;
	bh=HI3jLzIMNHgXngha933TyDy60kZHwaCdeVQpvZO8cTM=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=CZL3to3MpWlEn8tft0Wslaksbse3Evgobg5agHJRztyV9mRFoaOKlyRc/7yogK7kZIqrXgUjAG12i0lXWK0IIdpTgwKyhMDMLYw33ARSmeYCUv2giV3YcVmMnzRv0TwMU9EMdOl+POOGWKAeAiRn+2w6qMyryCNyAn4sFPXMhUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=LvyJ1pby; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="LvyJ1pby"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D813FA012B;
	Mon, 19 Oct 2026 13:10:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1792408235; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=t+VSMmyfYD4g+GNYlrSnZIeaS9t9MvdaQFl0FVMqPCo=;
	b=LvyJ1pbyvgjoMdZoaSeBG62z3wRWXrUIUJ4NeeaxNoW9hd/uSC5BtjwEYI5SaLFQETtPrG
	rmt7qPKPS4hlD+1bLGpPzdb2Vd1J+arx04AjKXmT8oxYwOvUV0HaiJO6Dw+a9plsKD4Cjw
	oKtj3PnWArmj87okeVF8jewNL35fr4A6AXUueUXMXjwrkSFTloRthv8C90aopFMHuIcZPO
	6XPiiIa+zJl5aIDLqU98D7pX80lFV+NJA4QLs+miDmibA5VUt+ZKptYc1QvD/L3q3xpeHa
	TwZxISdFcYm98rFADZBQ1rSa3miOb2CJdc4/GvnDoOp63Fz82ORStom6q3V5kg==
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 19 Oct 2026 13:10:33 +0200
From: Nicolai Buchwitz <nb@tipi-net.de>
To: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre
 Torgue <alexandre.torgue@foss.st.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer
 <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, Stanislav
 Fomichev <sdf@fomichev.me>, Jose Abreu <Jose.Abreu@synopsys.com>, Ong Boon
 Leong <boon.leong.ong@intel.com>, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org
Subject: Re: [PATCH net-next v8 5/5] net: stmmac: rework stmmac_rx to support
 XDP rx multi-buff
In-Reply-To: <20261018-stmmac-rx-mb-v8-5-5f58c0b25849@oss.qualcomm.com>
References: <20261018-stmmac-rx-mb-v8-0-5f58c0b25849@oss.qualcomm.com>
 <20261018-stmmac-rx-mb-v8-5-5f58c0b25849@oss.qualcomm.com>
Message-ID: <937b7f07872c29b1c486ac836c8f990e@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

On 18.10.2026 19:07, Lorenzo Bianconi wrote:
> The preceding commit dropped frames split across multiple descriptors, 
> or
> using a second buffer, while XDP was enabled. This prevented the
> per-descriptor XDP path from re-parsing frame tails and from applying 
> FCS
> handling to truncated buffers.
> 
> Rework stmmac_rx() to accumulate all the descriptors that make up a 
> frame
> in an xdp_buff, so the XDP program runs on the full (possibly 
> fragmented)
> packet instead of just the first buffer. Frames split across 
> descriptors
> or buffers are now passed to programs loaded with BPF_F_XDP_HAS_FRAGS;
> programs without that capability continue to drop fragmented frames. 
> When
> the frame is not consumed by the program, assemble the skb from the 
> head
> buffer and the collected fragments via napi_build_skb()/
> xdp_update_skb_frags_info().
> 
> Note that XDP still rejects an MTU larger than ETH_DATA_LEN
> (stmmac_xdp_set_prog(), stmmac_change_mtu()) and disables SPH, so an
> ordinary frame fits in a single buffer. This path is therefore 
> exercised
> by frames that do span several descriptors (for example jumbo frames 
> the
> MAC admits through its jumbo-enable bit) and is groundwork for 
> extending
> XDP to jumbo/SPH; it does not enable XDP jumbo support by itself.
> 
> To do so, store the in-progress xdp_buff in rx_q->state instead of the
> partially built skb, so the accumulated head and fragments survive a 
> NAPI
> poll boundary (mid-frame dma_own or dirty_rx break). The state is saved
> only while a frame is in progress and cleared once it completes, 
> leaving
> it untouched when the poll does not process anything (e.g. netpoll 
> invoked
> with a zero budget).
> 
> In addition:
> - advertise NETDEV_XDP_ACT_RX_SG, since the RX path can now deliver
>   non-linear buffers to XDP;
> - build the skb head with napi_build_skb() passing xdp->frame_sz, so
>   skb_shinfo() lands on the same shared_info the fragments were 
> accumulated
>   into;
> - carry the XDP metadata written with bpf_xdp_adjust_meta() into the 
> skb
>   via skb_metadata_set(), so it is no longer dropped and TC/BPF 
> programs
>   can read it through data_meta;
> - attach fragments with xdp_buff_add_frag(), which initializes all the
>   shared_info fields and takes care of the pfmemalloc bit;
> - charge fragments the whole page_pool page size (xdp->frame_sz) as
>   truesize instead of the old dma_buf_sz; with SPH/buf2 most frames 
> carry
>   a fragment, so skb->truesize grows by roughly 1.5x on 4K pages and 2x 
> on
>   64K pages, which reduces the effective socket receive buffer. The new
>   value is more accurate now that a fragment is a full page_pool page, 
> but
>   it is a behavior change;
> - release the buffers collected in the xdp_buff when a frame is dropped
>   on RX errors; the previous code relied on dev_kfree_skb() recycling 
> the
>   skb frags, which no longer applies now that the head and fragments 
> live
>   in an xdp_buff rather than a partially built skb;
> - drop the whole frame when it would exceed MAX_SKB_FRAGS, where the
>   previous skb_add_rx_frag() calls were unbounded;
> - strip the Ethernet FCS from the accumulated xdp_buff with a 
> driver-local
>   tail shrink (stmmac_xdp_shrink_tail()) for both linear and fragmented
>   frames, instead of trimming the skb or the first descriptor length.
> 
> Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>

> [...]

Reviewed-by: Nicolai Buchwitz <nb@tipi-net.de>

Thanks,
Nicolai
