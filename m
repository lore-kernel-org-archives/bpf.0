Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FBBB3D955B;
	Mon, 28 Sep 2026 00:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790553712; cv=none; b=ZWsvf463ocfXrni77i32dIGB6iotR1/5ixqIKwFbGSVXOhpQzB+voBpRVbzgmaK9k6mwA+yeb3yGBi5T+7GIJVdWlaaClNClWSWR3VCYGUvZ9S7Wbn1jFszWiEkB31PS37ZiFHUkkuCsoojUSE7DYX6PWArY0ZnF+4PzM4skmIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790553712; c=relaxed/simple;
	bh=tRF2leGgPH3zIgrLL28Xkf0npFv+0FqZVX8d0nFmTP8=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=k4nzF8NpjE6KpaK0LgFhWDIHD6TyPWweFaQo6+UuYVo4LMuI4XpUYX0k+JAxD+EK+Qk1DTv9tL8lJxZ8WUVqj1ujHhcpskA1xnfv6PNyLVIXu4rZDgKUws7aAh+jBgY6nqgYHSzpBfP5jYr3Wvor17O/AQs9tIYRpXE7l6ytfRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nIkamJGo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nIkamJGo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC35C1F000FF;
	Mon, 28 Sep 2026 00:01:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790553705;
	bh=VkcPesmFMTwEZHseXlOeqFidW9zGEP/FXiHjAboPjos=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=nIkamJGoRV4Y3fSirT6H3/LHHCX2f7usXTTQ9OYTWylGQspGQlWg0x0Xfjw5DgI+7
	 LnIRNOuJtgja7dYwPWLz1EJU17gkBYZhqClEx0YzCtGRbYwmd712d0a6lvkoCicZ84
	 tqmaWUZSSffsXU7iiYLio/kFoGzVibA1zcyK7IvJ6ybTIGfKRVgv4qqFiVb6gR6BUi
	 w2ErlIvG78li6Nc/fezbHp6BdIkDGS52vXB3lEtb2JIp/0kg6YPgGX/y7W5CywuOyn
	 qPJdqDlVerdVGAcMXW87k4ci4xao28oL8XvLBaT7+l9f04FsDrrH0uT0SW5S9DWsRo
	 INGuDsE9BqjIg==
Subject:
 Re: [PATCH net-next v2 5/8] eth: mpnic: start and stop the Tx HW queues
From: netdev-bot+sashiko@kernel.org
To: daniel.zahka@gmail.com
Cc: alexanderduyck@fb.com, kuba@kernel.org, kernel-team@meta.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
 john.fastabend@gmail.com, sdf@fomichev.me, dimitri.daskalakis1@gmail.com,
 mohsin.bashr@gmail.com, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 bpf@vger.kernel.org
Date: Mon, 28 Sep 2026 00:01:43 +0000
Message-ID: <179055370349.3145.18291043056842354620@kernel.org>
In-Reply-To: <20260924-linux-mpnic-v2-5-4badc9b58b9e@gmail.com>
References: <20260924-linux-mpnic-v2-5-4badc9b58b9e@gmail.com>
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

- [High] mpnic_wait_all_queues_idle() returns void and drops the
  -ETIMEDOUT from read_poll_timeout().
- [Low] mpnic_enable_twq() writes fls(size_mask) & MPNIC_TWQ_SIZE_SIZE (a
  4-bit field), and mpnic_enable_tcq() writes the same exponent into…

--

eth: mpnic: start and stop the Tx HW queues

This commit writes the Tx work queue and completion queue base addresses
and sizes into the hardware. It adds mpnic_enable() and mpnic_disable() to
turn the Tx queues on and off. It also adds mpnic_wait_all_queues_idle(),
which polls the TWQ, TQS, TDE and TCQ idle bitmaps, and mpnic_flush(),
which throws away any Tx work left in the rings.

> diff --git a/drivers/net/ethernet/meta/mpnic/mpnic_txrx.c b/drivers/net/ethernet/meta/mpnic/mpnic_txrx.c
> index 853976e11b032..aaa3a3e99a138 100644
> --- a/drivers/net/ethernet/meta/mpnic/mpnic_txrx.c
> +++ b/drivers/net/ethernet/meta/mpnic/mpnic_txrx.c

[ ... ]

> @@ -467,6 +468,180 @@ void mpnic_reset_netif_queues(struct mpnic_net *mpn)
>  	}
>  }
>  
> +static void mpnic_enable_twq(struct mpnic_dev *mpd, struct mpnic_ring *twq)
> +{
> +	u32 log_size = fls(twq->size_mask);
> +	u32 i = twq->q_idx;

[ ... ]

> +	/* Store descriptor ring address and size */
> +	mpnic_wr64(mpd, MPNIC_TWQ_BASE_ADDR(i, 0), twq->dma);
> +	mpnic_wr64(mpd, MPNIC_TWQ_SIZE(i, 0), log_size & MPNIC_TWQ_SIZE_SIZE);

[ ... ]

> +static void mpnic_enable_tcq(struct mpnic_dev *mpd,
> +			     struct mpnic_napi_vector *nv,
> +			     struct mpnic_ring *tcq)
> +{
> +	u32 log_size = fls(tcq->size_mask);
> +	u32 i = tcq->q_idx;

[ ... ]

> +	/* Store descriptor ring address and size */
> +	mpnic_wr64(mpd, MPNIC_TCQ_BASE_ADDR(i), tcq->dma);
> +	mpnic_wr64(mpd, MPNIC_TCQ_SIZE(i), log_size & MPNIC_TCQ_SIZE_SIZE);

[Severity: Low]
This isn't a bug with the current fixed 1024-entry rings, but
mpnic_enable_twq() and mpnic_enable_tcq() mask the same exponent with
fields of different widths in mpnic_csr.h:

  #define MPNIC_TWQ_SIZE_SIZE    CSR_GENMASK(3, 0)
  #define MPNIC_TCQ_SIZE_SIZE    CSR_GENMASK(4, 0)

For a 64K-entry ring (fls() == 16), TWQ_SIZE would get 0 and TCQ_SIZE
would get 16. Is this the intended encoding for each register?

fbnic has a comment for the 4-bit form: "Write lower 4 bits of log size
as 64K ring size is 0". Would a similar comment help here?

[ ... ]

> +void mpnic_wait_all_queues_idle(struct mpnic_dev *mpd)
> +{
> +	static const struct mpnic_idle_regs queues[] = {
> +		{ MPNIC_TWQ_IDLE(0), MPNIC_TWQ_IDLE_CNT, "TWQ" },
> +		{ MPNIC_TQS_IDLE(0), MPNIC_TQS_IDLE_CNT, "TQS" },
> +		{ MPNIC_TDE_IDLE(0), MPNIC_TDE_IDLE_CNT, "TDE" },
> +		{ MPNIC_TCQ_IDLE(0), MPNIC_TCQ_IDLE_CNT, "TCQ" },
> +	};
> +	u32 non_idle_bitmap;
> +	int err;
> +
> +	err = read_poll_timeout(mpnic_non_idle_queues, non_idle_bitmap,
> +				!non_idle_bitmap, 20, 500000, false, mpd,
> +				queues, ARRAY_SIZE(queues));
> +	if (err)
> +		mpnic_idle_dump(mpd, queues, ARRAY_SIZE(queues),
> +				non_idle_bitmap, err);
> +}

[Severity: High]
What happens to the Tx rings if this poll times out?

The commit message says every block "has to report idle before the
descriptors are safe to free". However, the -ETIMEDOUT from
read_poll_timeout() is only logged. mpnic_wait_all_queues_idle() returns
void, so a caller can't tell a timeout apart from a clean drain.

mpnic_stop() is added later in the series, in "eth: mpnic: add a netdevice
and basic Tx handling". It carries on whatever the result:

  mpnic_disable(mpn);
  mpnic_wait_all_queues_idle(mpn->mpd);
  mpnic_flush(mpn);

  mpnic_reset_netif_queues(mpn);
  mpnic_free_resources(mpn);

mpnic_disable_twq() and mpnic_disable_tcq() only clear the enable bits.
TWQ_BASE_ADDR and TCQ_BASE_ADDR still point at the rings.

After a timeout, mpnic_flush()->mpnic_clean_twq0(..., true, tail) unmaps
the in-flight Tx buffers and consumes their skbs. Then
mpnic_free_ring_resources() calls dma_free_coherent() on the TWQ and TCQ
descriptor memory.

Could a Tx engine that is still busy then fetch descriptors or payload from
freed memory and put it on the wire? Could the TCM write completion
descriptors into memory that now belongs to another user?

fbnic_wait_all_queues_idle() handles the same case differently. It turns
on Tx drop through fbnic_tx_flush(), polls again, and returns an int.
Would something similar be needed here? At minimum, could the error be
returned so the caller can avoid freeing the rings?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260924-linux-mpnic-v2-0-4badc9b58b9e%40gmail.com
