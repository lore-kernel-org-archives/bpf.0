Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795526790;
	b=1dd97NsC/gyLHM7UjhJ7i/ccF5oBkTxqymCGpW9Jtjq/WOdDQr/tBC18ix8uhZs5vcRC
	 TkCXZcyAFXPzF/jw40zHWhn/hOGpaUuXR94FNfx0TbRRchEHsEMqKsAu1MUH7bv1e7+b0
	 Mb2JKI/vHuarjDLYIDEh63NweW6wd5UznSVUsdvDgg9k94G7SHhuI9UBRSw86TaFYEi5o
	 9W6iykbJV1Zt8iK3UqUupeB2SDR9RSHvnfHzixDa0u5P1CB9UNIdvncDUio0xN5n/dLBM
	 0sckGxr5kdlxyenyXw2fIZ2kwgrghYXBONApN1hmjkp/9Y6eU1zyqspqj9cP6ow6sNw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795526790;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=BUFMmdOEluzkiFS1/VYvQjPKeZ2ocL8nf6EPYzQ1tVA=;
	b=3eHJ3pJ4wPPYXoLPEYq+tl8W+vcaj3WoxyYi7KBaRRaYEIV8P0BcSOusTWUew66tulIP
	 pd3JHSKXEUPHS85filh3uXYovZfaWLdPp8/NNl2BYzTKejRykE3LRTYijfanuB+eSl4kZ
	 fFd9GoZu4wATrzCwWbESLryijRoRg58iDYZX2AcL0RrMS+G+xTkts/4km7VgQES8otor9
	 E74A/Z2TnAC9Dt1huvA3KytuOpopRVyGIam9F/t3yJuiVsTGah1P/DAEJ2GQoCDhMi2XF
	 jtjI7EKyZvAyXiBYqHFTaodGWoxv6avD2iW1vO1JpHdpdY8RQzgXw7Nf0gZU2iFom1g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VgR0xoAW;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49425606A336;
	Tue, 24 Nov 2026 13:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VgR0xoAW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B6A01F000C0;
	Tue, 24 Nov 2026 13:26:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795526790;
	bh=BUFMmdOEluzkiFS1/VYvQjPKeZ2ocL8nf6EPYzQ1tVA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=VgR0xoAWJuy9cj3Xzg/3436wkn4wGgTYr9Ek6hrvI1e8Hn0fVa4uTPhdeUPwhOTTh
	 b5U+fIbAkEqSeNpvUpCAG+fZpr+WJWkseTLMiEYEuJS9UEbAoeS2u2j3Ug1id9wzIB
	 gU0C9g44INMyloE2qrE0w0/sqaJ9XF/zmz10+69vkwjtxHhosNRprX/6qIs/mbKyDO
	 e0mso1Q8UGjW/TDSXicpUxkDDFIfvj/oEojBrKEebfCr8TRN4KrkiSh0KPVwBtHpC2
	 WgsFSC7a1eeb24Q+WmAnTUl3If2xT0InhUsJSCBqYigauFGFqHsdrH0wuv2VjUVil+
	 bGU9sVvY9pANQ==
Subject: Re: [PATCH net v2 4/5] vmxnet3: drop XDP frames that do not fit in
 one rx buffer
From: netdev-bot+sashiko@kernel.org
To: filzador@gmail.com
Cc: ronak.doshi@broadcom.com, bcm-kernel-feedback-list@broadcom.com,
 netdev@vger.kernel.org, bpf@vger.kernel.org, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
 john.fastabend@gmail.com, sdf@fomichev.me, u9012063@gmail.com
Date: Tue, 24 Nov 2026 13:26:28 +0000
Message-ID: <179552678888.3135.8339153303682923721@kernel.org>
In-Reply-To: <20261123124855.1021-5-filzador@gmail.com>
References: <20261123124855.1021-5-filzador@gmail.com>
X-sashiko-severity: Low
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

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] In vmxnet3_rq_rx_complete() (drivers/net/vmxnet3/vmxnet3_drv.c),
  the patch adds an early exit inside the `rcd->eop && rcd->err` branch:…
- [Low] The patch changes the initialiser in vmxnet3_rq_rx_complete()
  (drivers/net/vmxnet3/vmxnet3_drv.c:1618) from `bool skip_page_frags =…

--

vmxnet3: drop XDP frames that do not fit in one rx buffer

With XDP enabled, a frame with sop set but not eop can land in a page_pool
head buffer. It then falls through to the skb path and crashes. This patch
drops such frames and skips their body buffers. It also starts each poll
with skip_page_frags set when no frame is in progress, and avoids counting
a dropped frame twice when its last body buffer has rcd->err set.

> diff --git a/drivers/net/vmxnet3/vmxnet3_drv.c b/drivers/net/vmxnet3/vmxnet3_drv.c
> index e8be95c1d9f8e..66f677391bbbc 100644
> --- a/drivers/net/vmxnet3/vmxnet3_drv.c
> +++ b/drivers/net/vmxnet3/vmxnet3_drv.c
> @@ -1614,7 +1614,8 @@ vmxnet3_rq_rx_complete(struct vmxnet3_rx_queue *rq,
>  		adapter->rx_prod_offset, adapter->rx_prod2_offset
>  	};
>  	u32 num_pkts = 0;
> -	bool skip_page_frags = false;
> +	/* A frame dropped at its head may continue in the next poll. */
> +	bool skip_page_frags = !rq->rx_ctx.skb;

[Severity: Low]
This initializer runs on every poll in vmxnet3_rq_rx_complete(), with or
without XDP. Does it also change behaviour on the non-XDP rx path?

Before this patch, two head-buffer drops set only the poll-local
skip_page_frags: the netdev_alloc_skb_ip_align() failure and the
dma_map_single() failure.

Suppose the poll ended before the body completion became visible. The next
poll then started with skip_page_frags = false and ctx->skb == NULL, and the
body completion would hit this in the non-sop branch:

    BUG_ON(ctx->skb == NULL && !skip_page_frags);

That problem seems to predate 54f00cce1178. With this change the non-XDP
case is fixed as well. Orphan body completions at the start of a poll are
now skipped silently instead of triggering the BUG_ON.

The subject, the Fixes: tag and this sentence in the commit message all
present the change as XDP-only:

  "drop such frames: count them in drop_total, reuse the head buffer and
  skip the body buffers, as the existing allocation failure path does."

Could the commit message say that the existing allocation failure path had
the same cross-poll problem, and that non-XDP rx behaviour changes too? The
non-XDP issue looks older than the Fixes: commit, so this would help
stable backport triage.

[ ... ]

> @@ -1662,10 +1663,27 @@ vmxnet3_rq_rx_complete(struct vmxnet3_rx_queue *rq,
>  		       rxd->len != rbi->len);
>  
>  		if (unlikely(rcd->eop && rcd->err)) {
> +			/* The last body buffer of a frame already dropped */
> +			if (!rcd->sop && skip_page_frags)
> +				goto rcd_done;

[Severity: Low]
Does this skip assume that every path setting skip_page_frags has already
counted the frame in drop_total?

The head-buffer drops do increment drop_total. Those are the new XDP
oversize drop, the netdev_alloc_skb_ip_align() failure and the
dma_map_single() failure.

The two body-buffer drops later in vmxnet3_rq_rx_complete() set
skip_page_frags without touching drop_total:

    if (unlikely(!new_page)) {
        rq->stats.rx_buf_alloc_failure++;
        dev_kfree_skb(ctx->skb);
        ctx->skb = NULL;
        skip_page_frags = true;
        goto rcd_done;
    }

The dma_map_page() failure branch right after it does the same.

Before this patch, suppose the final body completion of such a frame had
rcd->eop && rcd->err set. vmxnet3_rx_error() then counted the frame once in
drop_err and drop_total.

With this check, does that frame go uncounted in both? drop_total feeds
rx_dropped in vmxnet3_get_stats64() and the ethtool drop counters.

Would it make sense to increment drop_total in those two body-path failure
branches? Another option is to limit this skip to drops that were already
counted.

>  			vmxnet3_rx_error(rq, rcd, ctx, adapter);
>  			goto rcd_done;
>  		}

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261123124855.1021-1-filzador%40gmail.com
