Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18D8E344D8C;
	Thu, 24 Sep 2026 02:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790215537; cv=none; b=tAGfjeAsUMzI3pu4EcUPpCr85FMQ11dnom0begdDg8Wzk+XYLANt4k5efbAUKKI6Aou3uWnRDr9OdNouQ8jspFfmAFBhJ1xFPRayOPs4loholfeOJ59LWD1P2cfCZZkoqmsn2Kvea7A7TWiGBF4visuLlYldL6sqlku1mNvCZDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790215537; c=relaxed/simple;
	bh=INUWDUamiz4Y0hvC3pIrcJ+0uEmCVYzqeLMJn7FoYA4=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mHMbBxZU4YIOvip33+QDfreY3/PGWsu7aJLqhYCCypEdJM9DIRRaHRB1JTqwaY0lIVi96LI++hz5km5Vd5cthuzbBbR0QAuPAYSEQvUr4WUKCygQV58oxfXxyQp6d5zD2uQ9uk1um9SjJj5A2wts9Lh+0pAMfbA4+ZOP11cY6Ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dVGrRDX7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dVGrRDX7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E695E1F00893;
	Thu, 24 Sep 2026 02:05:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790215535;
	bh=DrxmNLLSP4wFq1ZILXBibz6M0o8IyY9bV3emg9qzGKc=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=dVGrRDX7kUf4qAC7aqB00N5uU7byqpCAnmaIQZI2YT9q8JWgqLB5+76cXdZJzrwDT
	 OuqyXM+XspqfZrjU2SSoFkK/PP2UBzfhBaDn/QRmPU4lcDlNsaSMp6PXwSUdtNA/4D
	 hDgsrvmFGRPXBq5cUepP/fRvJ2guuVdzbvr7tw1jGSCHQCl45xfr6I55PpFpQX7knh
	 TJrX/sfnMrfo5+/HKAxjY3HYwqE3904ob04VsoH++xYAFEKSEJE3NfqHewqW1F8W97
	 rmrfE/yQaqrfb9q9SnslQ8K3fKD215ry7XWi/9wnvr1OijIgpjYs+0aNgRYqTIdsBb
	 ZZV+5Q1m1FakA==
Subject: Re: [PATCH net-next 4/8] eth: mpnic: implement Tx queue allocation
 and cleanup
From: netdev-bot+sashiko@kernel.org
To: daniel.zahka@gmail.com
Cc: alexanderduyck@fb.com, kuba@kernel.org, kernel-team@meta.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
 john.fastabend@gmail.com, sdf@fomichev.me, dimitri.daskalakis1@gmail.com,
 mohsin.bashr@gmail.com, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 bpf@vger.kernel.org
Date: Thu, 24 Sep 2026 02:05:34 +0000
Message-ID: <179021553452.2160803.1706539646105038044@kernel.org>
In-Reply-To: <20260922-linux-mpnic-v1-4-236844f53072@gmail.com>
References: <20260922-linux-mpnic-v1-4-236844f53072@gmail.com>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] Cached doorbell pointers let queue-head MMIO writes reach BAR0
  after the driver has marked the device as gone.
- [Low] Concern (baseline: rejected): mpnic_alloc_ring_desc() stores
  `count - 1` into the u16 ring->size_mask (line 334) without checking…
- [Low] Concern (baseline: rejected): mpnic_clean_tcq() takes HEAD0 from
  the device-written completion descriptor (line 163) and passes it…

--

eth: mpnic: implement Tx queue allocation and cleanup

This adds the Tx ring structures and allocates queue triads per NAPI
vector, along with their descriptor memory and interrupts. It also adds
Tx completion processing, where one completion reports a work queue head
and can release many packets. Nothing enables the queues in hardware yet.

> diff --git a/drivers/net/ethernet/meta/mpnic/mpnic_txrx.c b/drivers/net/ethernet/meta/mpnic/mpnic_txrx.c
> new file mode 100644
> index 0000000000000..fe360a26a27be
> --- /dev/null
> +++ b/drivers/net/ethernet/meta/mpnic/mpnic_txrx.c
> @@ -0,0 +1,496 @@

[ ... ]

> +static void mpnic_commit_cq_head(struct mpnic_ring *cmpl)
> +{
> +	u32 head = cmpl->head;
> +
> +	/* The tail shadows the last value written to the doorbell, so a
> +	 * completion queue which has not moved costs no MMIO write.
> +	 */
> +	if (cmpl->tail != head) {
> +		cmpl->tail = head;
> +		writeq(head & cmpl->size_mask, cmpl->doorbell);
> +	}
> +}

[Severity: Low]
Can this doorbell write still reach BAR0 after the driver has marked the
device as gone?

mpnic_alloc_napi_vector() reads mpd->uc_addr0 once and stores raw BAR0
addresses in the rings:

    mpnic_ring_init(&nv->qt[0].sub0, &uc_addr[MPNIC_TWQ_TAIL(idx, 0)], idx);
    mpnic_ring_init(&nv->qt[0].cmpl, &uc_addr[MPNIC_TCQ_HEAD(idx)], idx);

When mpnic_rd64() sees all-ones reads, mpnic_mmio_err() in mpnic_pci.c
clears only the accessor pointer:

    WRITE_ONCE(mpd->uc_addr0, NULL);

BAR0 stays mapped through pcim_iomap_region(). mpnic_wr64() checks for
the NULL pointer, but mpnic_commit_cq_head() always writes through
cmpl->doorbell.

So suppose one mpnic_poll() run still has unprocessed completions that
were posted before the failure. The TCQ head doorbell write goes out,
while the mpnic_nv_irq_rearm() write through mpnic_wr64() is dropped.

The scaffolding commit says that once the device is gone, no further
accesses reach the bus. Should that also cover the doorbells?

Later in the series, mpnic_tx_doorbell() and __mpnic_bdq_commit_tail()
use the same cached-pointer pattern. Would a mpnic_present() check help
in those places and here?

The comment in mpnic_alloc_napi_vector() already says the doorbells
cannot notice the window going away, and fbnic does the same thing. The
practical effect is probably limited to posted writes to a dead link.

> +static void mpnic_clean_tcq(struct mpnic_napi_vector *nv,
> +			    struct mpnic_q_triad *qt, int napi_budget)
> +{

[ ... ]

> +	while ((*raw_tcd & cpu_to_le64(MPNIC_TCD_DONE)) == done) {
> +		u64 tcd;
> +
> +		dma_rmb();
> +
> +		tcd = le64_to_cpu(*raw_tcd);
> +		head0 = FIELD_GET(MPNIC_TCD_TYPE0_HEAD0, tcd);

[ ... ]

> +	cmpl->head = head;
> +
> +	if (head0 >= 0)
> +		mpnic_clean_twq0(nv, napi_budget, &qt->sub0, false, head0);
> +}

[Severity: Low]
This isn't a bug with a conforming device, but head0 comes straight from
the completion descriptor the device writes. It goes to
mpnic_clean_twq0() without any check against sub0.tail.

If the device ever reported a head past the posted tail,
mpnic_clean_twq0() would reach an empty slot and dereference NULL:

    struct sk_buff *skb = ring->tx_buf[head];
    ...
    desc_cnt = MPNIC_XMIT_CB(skb)->desc_count;

The completion walk loop is also not bounded by the NAPI budget. In
practice the device cannot post past the CQ head, and that head is only
committed after the loop.

Stale entries from an earlier bringup do not look reachable. The
descriptor memory is freshly zeroed by dma_alloc_coherent(), the head
and tail are reset to 0 later in the series, and at head 0 the expected
DONE bit is 1.

Would a cheap sanity check on head0, or a NULL check on skb, be worth
adding as hardening?

[ ... ]

> +static int mpnic_alloc_ring_desc(struct mpnic_net *mpn,
> +				 struct mpnic_ring *ring, u32 count)
> +{

[ ... ]

> +	ring->size_mask = count - 1;
> +	ring->size = size;

[Severity: Low]
This isn't a bug with the current callers, but count is a u32 while
ring->size_mask is a u16 in struct mpnic_ring. Nothing here checks that
count is a non-zero power of two no larger than 65536.

This cannot be reached today. The only caller passes mpn->txq_size,
which is only ever set to MPNIC_TXQ_SIZE_DEFAULT (1024), and there is
no set_ringparam path.

If a runtime ring size setter is added later, a count that is zero, not
a power of two, or above 65536 would break the masked indexes in
mpnic_clean_twq0() and mpnic_clean_tcq().

Would a WARN_ON_ONCE() or an explicit check here be worthwhile?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260922-linux-mpnic-v1-0-236844f53072%40gmail.com
