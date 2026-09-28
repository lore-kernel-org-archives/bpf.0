Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 899EA2E7370;
	Mon, 28 Sep 2026 00:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790553714; cv=none; b=AbOJlyHN/FqvVtoezGBXisDTDcSbZTGwWuaGRotR3B5MnuuFzG9OzjqnjhrPh4AehoBHb67gXb3YG6TQNkoZDUc/CDKm3toIB1MkOWef2w38vIjBb5TbLxM1jwg4aU3+AlwvpSmsVlM6327OpKWLqW71uF3ThqSQKQIFbfNcyp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790553714; c=relaxed/simple;
	bh=Wmzlz6oTE+4I4on37Bi7lc0x00GpsiEuJbqUhSb6tJI=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oSgKKpfwOmfLVz2l18gFjG1S+H3XUgHpo0OePaOuOLxGqTxYxGGD7v3Clr7dBwaw65fRSrVw6sKmADPk4d8li7GIjNmr3pfpZNMO3z5PbgWJbmeZRZ3r2hudNHIShJvwBByk0BkeKsBh0EwrleWzOJMDbAekHOElDAMP3QsrMmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=erzEeRaN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="erzEeRaN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C9231F00898;
	Mon, 28 Sep 2026 00:01:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790553708;
	bh=R0+yamzmBN+8PNLb+7c4vQ6ZpkLK5wEXcoHtscvoe/M=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=erzEeRaNtPOQMs2uQ4n4iojew7A0joDJf1YykCpefwN7uEfXyn+TIcNQF4B4+gkLv
	 YQO4he1Of2+AKx9spNGf0pdhEUSqhABE95QFCSVFPSSEOwVsmGeYSSmgMC+RJkBDvk
	 aJvByTbAgSiFSvvkfZFm5rUmhMnSLpM2LXkgmn8tjN2KX5gKyQifhfVeUIls0OBwBb
	 hF8xD66N94OwNd8Q1wBOJ0c2nDY9fxfbxCifuBYTFiPO7wkYKBlWLDLxGdDVphvhzh
	 C2KtBN+pECGCRZgp89D3dhB7w0bBDawOptsdqB8dg80cQkGDrYURRx/a+ULPzLrO74
	 cwS5BCLGfd7ZA==
Subject: Re: [PATCH net-next v2 7/8] eth: mpnic: implement Rx queue allocation
 and cleanup
From: netdev-bot+sashiko@kernel.org
To: daniel.zahka@gmail.com
Cc: alexanderduyck@fb.com, kuba@kernel.org, kernel-team@meta.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
 john.fastabend@gmail.com, sdf@fomichev.me, dimitri.daskalakis1@gmail.com,
 mohsin.bashr@gmail.com, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 bpf@vger.kernel.org
Date: Mon, 28 Sep 2026 00:01:46 +0000
Message-ID: <179055370676.3145.8533599239834787365@kernel.org>
In-Reply-To: <20260924-linux-mpnic-v2-7-4badc9b58b9e@gmail.com>
References: <20260924-linux-mpnic-v2-7-4badc9b58b9e@gmail.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] In `mpnic_stop()`
  (drivers/net/ethernet/meta/mpnic/mpnic_netdev.c), Rx teardown frees…

--

eth: mpnic: implement Rx queue allocation and cleanup

This commit adds the Rx side of the mpnic queue triad: a header buffer
queue, a payload buffer queue and a completion queue. All three share
one page pool per triad. It also adds the enable/disable, fill and
flush paths, and adds the HPQ, PPQ and RCQ blocks to the idle wait done
on teardown.

> diff --git a/drivers/net/ethernet/meta/mpnic/mpnic_txrx.c b/drivers/net/ethernet/meta/mpnic/mpnic_txrx.c
> index b1fb0d3902a7a..389a9e5476c6e 100644
> --- a/drivers/net/ethernet/meta/mpnic/mpnic_txrx.c
> +++ b/drivers/net/ethernet/meta/mpnic/mpnic_txrx.c

[ ... ]

> @@ -767,6 +1084,9 @@ void mpnic_wait_all_queues_idle(struct mpnic_dev *mpd)
>  		{ MPNIC_TQS_IDLE(0), MPNIC_TQS_IDLE_CNT, "TQS" },
>  		{ MPNIC_TDE_IDLE(0), MPNIC_TDE_IDLE_CNT, "TDE" },
>  		{ MPNIC_TCQ_IDLE(0), MPNIC_TCQ_IDLE_CNT, "TCQ" },
> +		{ MPNIC_HPQ_IDLE(0), MPNIC_HPQ_IDLE_CNT, "HPQ" },
> +		{ MPNIC_PPQ_IDLE(0), MPNIC_PPQ_IDLE_CNT, "PPQ" },
> +		{ MPNIC_RCQ_IDLE(0), MPNIC_RCQ_IDLE_CNT, "RCQ" },
>  	};
>  	u32 non_idle_bitmap;
>  	int err;
> @@ -779,15 +1099,31 @@ void mpnic_wait_all_queues_idle(struct mpnic_dev *mpd)
>  				non_idle_bitmap, err);
>  }
>  
> +static void mpnic_clean_bdq(struct mpnic_ring *bdq)
> +{
> +	unsigned int head = bdq->head;
> +
> +	while (head != bdq->tail) {
> +		struct page *page = bdq->rx_buf[head];
> +
> +		page_pool_put_full_page(page->pp, page, false);

[Severity: Medium]
What happens to these Rx buffers if the idle poll times out?
mpnic_wait_all_queues_idle() returns void. On timeout it only logs:

	err = read_poll_timeout(mpnic_non_idle_queues, non_idle_bitmap,
				!non_idle_bitmap, 20, 500000, false, mpd,
				queues, ARRAY_SIZE(queues));
	if (err)
		mpnic_idle_dump(mpd, queues, ARRAY_SIZE(queues),
				non_idle_bitmap, err);

mpnic_stop() then carries on with teardown either way:

	mpnic_disable(mpn);
	mpnic_wait_all_queues_idle(mpn->mpd);
	mpnic_flush(mpn);

	mpnic_reset_netif_queues(mpn);
	mpnic_free_resources(mpn);

Two things happen after that:

  - mpnic_flush()->mpnic_clean_bdq() gives every page still posted in
    [head, tail) back to the page pool.
  - mpnic_free_resources()->mpnic_free_rx_qt_resources() frees the HPQ,
    PPQ and RCQ descriptor rings with dma_free_coherent(), then calls
    page_pool_destroy().

Before this patch, the same timeout-and-continue path only covered Tx,
where the device reads host memory. Now there are DMA_FROM_DEVICE page
pool buffers and an RCQ that the device writes to.

If the device has not quiesced when the poll gives up, could it write
frame data into freed or reused pages, or write completions into the
freed RCQ ring?

Separately, the earlier commit "eth: mpnic: start and stop the Tx HW
queues" says every block a packet passes through must report idle
before memory is safe to free. The Rx idle table here covers HPQ, PPQ
and RCQ, but it has no Rx DMA engine entry to match TDE on the Tx side.
The only RDE registers defined are CFG, CTL and the MEM_INIT ones.

Does RCQ reporting idle guarantee that the RDE has no writes in flight?
If not, should an RDE idle entry be polled here as well?

This code is still the same at the end of the series, in "eth: mpnic:
add basic Rx handling".

> +
> +		head++;
> +		head &= bdq->size_mask;
> +	}
> +
> +	bdq->head = head;
> +}

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260924-linux-mpnic-v2-0-4badc9b58b9e%40gmail.com
