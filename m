Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B95B23D1CC5;
	Thu, 24 Sep 2026 02:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790215539; cv=none; b=H0PeBd+rGftb4nXGgSg4j46CVxaImdn1KH0+UQaEWwj1P0+abkQfeQexqPqrEszXrsZqXdfCdAqlz2I2y2xYkqzsjuBKxMkpEwIxzeh4KUPT2o0HRft6hL15YW+HYFvqqptWvkFoGFL7YFcjE+5KXAiyhquL6d+PHgN7+m3YKkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790215539; c=relaxed/simple;
	bh=BTa2uhTSH10bUUZyshMsV/gROXfu4SytGr76lqzZQwY=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TsjFkjRRJS4sI/95YB/3uDn4ABChY9DCcKYTjIzAxOcvZfBjoEDbkStFbZrpqitJVH9Xlu+zpHKjVR3n1WK7fOd6ckIJpYYVmeZwqjSUNEWMIUT9iPYRpvvWekoQu6Zik2bGpYwMFz/RBas6Ge4KX409ImRzgAAJ00QNbgF5wTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qj9Hm5Fr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qj9Hm5Fr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B8511F000FF;
	Thu, 24 Sep 2026 02:05:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790215537;
	bh=4JpC7MhhO01QBhiCKrKoEdQTvJwASIIw4aCarGELn1Q=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Qj9Hm5FrqVgr3OeDfSjOchmN6hSYjCOwHXgaIBSasKjKUSRmX4IuoNhHBFffGva23
	 kkq1crhLzkae+qMeAclGf+RTl3Lvgg1pjnJagRT2CGgaKanjNdaDzPIVdwazZRMNj2
	 1Xnx6+rbkXNoW4GzAnURuioSo9yQqgzVnsfHWRrRmMkHtaTDHHRvB377A9Ygg8V9IF
	 vMOdM5CRpHKISzQxzzoQBhDcmKVqE9YsFXLWMZK9ngxlOg/r5R7IT6+lkU9iTQ9XqU
	 VP1/DmwRJnhuY8SzQ8W9Gu08kJsPFJlqjs0Q+sBMVO4vIXZfjJnDGf49ePPub89OrA
	 rjRqahrPC/44w==
Subject: Re: [PATCH net-next 5/8] eth: mpnic: start and stop the Tx HW queues
From: netdev-bot+sashiko@kernel.org
To: daniel.zahka@gmail.com
Cc: alexanderduyck@fb.com, kuba@kernel.org, kernel-team@meta.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
 john.fastabend@gmail.com, sdf@fomichev.me, dimitri.daskalakis1@gmail.com,
 mohsin.bashr@gmail.com, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 bpf@vger.kernel.org
Date: Thu, 24 Sep 2026 02:05:35 +0000
Message-ID: <179021553598.2160803.16775147198934716952@kernel.org>
In-Reply-To: <20260922-linux-mpnic-v1-5-236844f53072@gmail.com>
References: <20260922-linux-mpnic-v1-5-236844f53072@gmail.com>
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

Critical: 0 · High: 0 · Medium: 2 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] mpnic_wait_all_queues_idle()
  (drivers/net/ethernet/meta/mpnic/mpnic_txrx.c:599) returns void.
- [Medium] mpnic_non_idle_queues() (mpnic_txrx.c:569-570) counts a block
  as idle when every idle register reads ~0ULL.

--

eth: mpnic: start and stop the Tx HW queues

This commit programs the Tx work and completion queue base addresses and
sizes into the hardware, and adds helpers to enable and disable the Tx
queues. It also adds mpnic_wait_all_queues_idle(), which polls the idle
bitmaps of the TWQ, TQS, TDE and TCQ blocks so that teardown can wait for
the DMA engines before the rings are freed.

> diff --git a/drivers/net/ethernet/meta/mpnic/mpnic_txrx.c b/drivers/net/ethernet/meta/mpnic/mpnic_txrx.c
> index fe360a26a27be..cb4d1427434c9 100644
> --- a/drivers/net/ethernet/meta/mpnic/mpnic_txrx.c
> +++ b/drivers/net/ethernet/meta/mpnic/mpnic_txrx.c

[ ... ]

> +static u32 mpnic_non_idle_queues(struct mpnic_dev *mpd,
> +				 const struct mpnic_idle_regs *regs,
> +				 unsigned int nregs)
> +{
> +	u32 non_idle_bitmap = 0;
> +	unsigned int i, j;
> +
> +	for (i = 0; i < nregs; i++) {
> +		for (j = 0; j < regs[i].reg_cnt; j++) {
> +			if (mpnic_rd64(mpd, regs[i].reg_base + 2 * j) !=
> +			    ~0ULL) {
> +				non_idle_bitmap |= BIT(i);
> +				break;
> +			}

[Severity: Medium]
Could this report a device that can't be reached as idle? The idle test
here is ~0ULL, and mpnic_rd64() returns that same value once CSR access
has been disabled:

drivers/net/ethernet/meta/mpnic/mpnic_pci.c:mpnic_rd64() {
	u32 __iomem *csr = READ_ONCE(mpd->uc_addr0);
	...
	if (!csr)
		return ~0ULL;
	...
	mpnic_mmio_err(mpd, reg);

	return ~0ULL;
}

mpnic_wr64() also drops writes silently in that state:

	if (csr)
		writeq(val, csr + reg);

After mpnic_mmio_err() clears uc_addr0, the writes in mpnic_disable()
that clear MPNIC_TWQ_CTL_ENABLE and MPNIC_TCQ_CTL never reach the device.
On the first poll, mpnic_wait_all_queues_idle() then sees all four blocks
as idle and returns without a timeout. The caller can't tell a confirmed
idle state apart from an unreadable device, so it goes on to free the
rings.

mpnic_mmio_err() logs "awaiting reset", which suggests the device may be
recoverable rather than gone. Suppose the device can still bus-master
after two all-ones reads in a row, for example after a transient MMIO
failure. Could its still-enabled queues then DMA into ring memory that
has already been freed?

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

[Severity: Medium]
What happens to the rings when this poll times out? The -ETIMEDOUT in
err is only passed to mpnic_idle_dump() for logging and then dropped.
Because the function returns void, no caller can act on the timeout.

The commit message says:

  every one of the four blocks a packet passes through on its way out
  has to report idle before the descriptors are safe to free.

Later in the series, though, mpnic_stop() runs the teardown with no
condition between the steps:

	mpnic_disable(mpn);
	mpnic_wait_all_queues_idle(mpn->mpd);
	mpnic_flush(mpn);

	mpnic_reset_netif_queues(mpn);
	mpnic_free_resources(mpn);

After a timeout, mpnic_flush() calls mpnic_clean_twq0() with
qt->sub0.tail. That unmaps every pending TWD and frees the in-flight
skbs. mpnic_free_ring_resources() then calls dma_free_coherent() on the
TWQ and TCQ descriptor rings, whose addresses mpnic_enable_twq() and
mpnic_enable_tcq() handed to the hardware.

If a block is still busy after 500 ms, can the device still read the
freed skb data and descriptors? Can it write completions into the freed
TCQ memory?

The final version of the series (the "eth: mpnic: add basic Rx handling"
commit) still returns void and still frees unconditionally. It also adds
the Rx HPQ/PPQ/RCQ blocks to this wait, which would expose the Rx rings
and page pool pages the same way.

Should mpnic_wait_all_queues_idle() return the error? Teardown could then
avoid freeing memory the device may still be using.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260922-linux-mpnic-v1-0-236844f53072%40gmail.com
