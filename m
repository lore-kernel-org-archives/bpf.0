Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795444035;
	b=H+8OliwTe7EjTPj5mUuRqjucDzXZVQhSUDeA7xOW+xq68CCoLZjPAclaiOb0k5xPOYiQ
	 y5hwBCURTifuq07rl9pv9cMG0KBeOeFBwk76OzksR0ISyoDa9rBjkCczAE87cSVWKczNd
	 6cpxMNt9l7T8N9yjTQneUY5HRBhcLXT4abWJuwDu7KrsHLJEzrwjuKcudaz3Wkc2Aqw6h
	 ixuEeXKYbYF6MeWwQE59yoVtGMPSyeHVDYqAfZXHuT2tDTRwr032VD7TRqOj7LZSDZYm4
	 B1FRFkYyIMUDY+shiBQCWufimrmQoxSZ9BzXjxuJ+6Oiot1kBCFHoVqsoPj2QWjS4Qg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795444035;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=KHB/XI4cKY1r8Bk1cluPtbj8UheyxZWHTnaL5PnDwJ0=;
	b=HsF7JdEGU+30dywajDVmOQ8ij9lxn/hQvV/t6JmYX6yNBOKJQGCsVY6QqImoPDAQyDxc
	 C90rZnSLezzmOimQawnpYssO7NqIWUoRz5/QzmVmEOFB7WvGMyq34/Ugm8kdrmbWf4ZZY
	 SF66y8UIwQc39Gz29dKE9RlsLh5kLeSQs0mucILTZL1/+jUScwAH/elFr5IcwwEPQv8Qs
	 D/rUQJtTVnekKmcAr3Bpjp4MQEHLFTT88gWwJ8V8czddpwe9oCQRMMjpih6WpOn6klGBl
	 V/WAen3FJoq5tDzI02gasBAsJiiFIJ3wb3BTTUERnC+OHx9kkOLq0c7DZnuVmpNQWrw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CJELoYmX;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73305606A31E;
	Mon, 23 Nov 2026 14:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CJELoYmX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E29D91F000C6;
	Mon, 23 Nov 2026 14:27:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795444035;
	bh=KHB/XI4cKY1r8Bk1cluPtbj8UheyxZWHTnaL5PnDwJ0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=CJELoYmX/EDhq0BWS8Gj5oaSsjEeUFBwlcdk4dUw3JvbNG0GjW48yGzHkXMi7QdH5
	 kIj2Q4irawJdO/wOls7zTG2BOXO3I6ZDxrvERilOJ/g0tofdr42tQIXt4DF9tviNf5
	 BUywKElXkp22vw3BhFrWLFVZ/+WeROQ0tpt0iR/fGvJsWcAWQDTtmt4qp6MEwf6sCX
	 uzfFJj4A+cp5DUjpcTDC7Sa+oCvnu3yVIxlb925PJR6VwwFC2MlQoHaP9rpTfkGb0R
	 VT2pfoWu08nRUPcMo3TG+RzCAXmB7X5PAsOYdV/h4jOzvA22rtrDt2d3HQEEi+XsvB
	 D2t7yKP7R9bBg==
Subject: Re: [PATCH net v3 1/4] igb: don't disable rings that don't exist when
 disabling an XSK pool
From: netdev-bot+sashiko@kernel.org
To: antonio@mandelbit.com
Cc: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
 przemyslaw.kitszel@intel.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 janislacis06@gmail.com, ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
 john.fastabend@gmail.com, sdf@fomichev.me, sriram.yagnaraman@ericsson.com,
 kurt@linutronix.de, maciej.fijalkowski@intel.com, hkallweit1@gmail.com,
 joe@dama.to, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org
Date: Mon, 23 Nov 2026 14:27:13 +0000
Message-ID: <179544403344.3135.6737096159492443262@kernel.org>
In-Reply-To: <20261119140412.163202-2-antonio@mandelbit.com>
References: <20261119140412.163202-2-antonio@mandelbit.com>
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

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider.

Critical: 0 · High: 2 (2) · Medium: 0 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The fix only covers the RX side.
- [High] The new guard `qid < adapter->num_rx_queues` in
  igb_xsk_pool_disable() is not serialized against the code that writes…
- [Low] Commit message accuracy (discarded by baseline).

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but `if_running`
  in igb_xsk_pool_disable() (and in igb_xsk_pool_enable()) uses…
- [High] This problem wasn't introduced by this patch, but the error
  paths of igb_xsk_pool_disable() (igb_xsk.c:162-165) and…

--

igb: don't disable rings that don't exist when disabling an XSK pool

The patch adds a qid < adapter->num_rx_queues bound to the if_running
condition in igb_xsk_pool_disable(). With it, the function stops
disabling and re-enabling rings the device doesn't have. The goal is to
stop a NULL ring from reaching igb_txrx_ring_disable() when the stack
knows about more queues than the device has.

Link: https://lore.kernel.org/netdev/20261116153041.3002666-2-antonio@mandelbit.com/

> xsk_get_pool_from_qid() checks the queue id against the stack's real
> queue counts, which can be higher than the number of rings the device
> has, e.g. after igb falls back from MSI-X to MSI on resume.

[Severity: Low]
This is minor. At this commit, a successful resume goes through
__igb_open(netdev, true), which re-syncs the real queue counts:

    err = netif_set_real_num_tx_queues(adapter->netdev,
                                       adapter->num_tx_queues);

The MSI-X to MSI example only leaves stale counts after the later patch
"igb: fix RTNL assertion when resuming from runtime suspend". That patch
makes __igb_resume() call __igb_open(netdev, true, !rpm), which skips the
re-sync on runtime resume until igb_rtnl_resume_task() runs.

The guard also covers the runtime-suspended-while-up state. There,
igb_free_q_vectors() has set num_rx_queues = 0 while netif_running() is
still true.

Could the commit message and the new code comment mention that
dependency, or use the runtime-suspended case as the example?

> diff --git a/drivers/net/ethernet/intel/igb/igb_xsk.c b/drivers/net/ethernet/intel/igb/igb_xsk.c
> index ce4a7b58cad2f..8ed82bb1def9a 100644
> --- a/drivers/net/ethernet/intel/igb/igb_xsk.c
> +++ b/drivers/net/ethernet/intel/igb/igb_xsk.c
> @@ -148,7 +148,12 @@ static int igb_xsk_pool_disable(struct igb_adapter *adapter, u16 qid)
>  		return -EINVAL;
>  
>  	rx_ring = adapter->rx_ring[qid];
> -	if_running = netif_running(adapter->netdev) && igb_xdp_is_enabled(adapter);
> +	/* The stack can know more queues than the device has, e.g. after a
> +	 * fallback to fewer queues on resume: skip the rings it doesn't have.
> +	 */
> +	if_running = netif_running(adapter->netdev) &&
> +		     igb_xdp_is_enabled(adapter) &&
> +		     qid < adapter->num_rx_queues;

[Severity: High]
Is checking only num_rx_queues enough here? igb_txrx_ring_disable() and
igb_txrx_ring_enable() also use the TX ring:

    struct igb_ring *tx_ring = adapter->tx_ring[qid];
    ...
    set_bit(IGB_RING_FLAG_TX_DISABLED, &tx_ring->flags);

igb can run with fewer TX rings than RX rings. From
igb_set_interrupt_capability():

    adapter->num_rx_queues = adapter->rss_queues;
    if (adapter->vfs_allocated_count)
        adapter->num_tx_queues = 1;
    else
        adapter->num_tx_queues = adapter->rss_queues;

igb_get_max_rss_queues() allows 2 RSS queues on an 82576 with VFs.

Here is a possible sequence:

1. With SR-IOV off (e.g. 4 queues), bind a zero-copy AF_XDP socket to
   qid 1. igb_xsk_pool_enable() accepts it.

2. Write to sriov_numvfs:
   igb_pci_sriov_configure()->igb_enable_sriov()->igb_sriov_reinit().
   igb_clear_interrupt_scheme() sets tx_ring[1] to NULL, and
   igb_init_interrupt_scheme() allocates rx_ring[0..1] but only
   tx_ring[0]. The pool registered at qid 1 stays in place.

3. Close the socket:
   xp_release_deferred()->xp_disable_drv_zc()->ndo_bpf()->
   igb_xsk_pool_disable(adapter, 1).
   xsk_get_pool_from_qid() returns the pool because
   1 < real_num_rx_queues. The new guard passes because
   1 < num_rx_queues. igb_txrx_ring_disable() then calls set_bit() on
   NULL->flags with rtnl held.

The commit message says this matches "as igb_xsk_pool_enable() and
igb_xsk_wakeup() already check". However, igb_xsk_wakeup() bounds qid
by the TX count:

    if (qid >= adapter->num_tx_queues)
        return -EINVAL;

igb_xsk_pool_enable() also checks real_num_tx_queues. Should this guard
require qid < adapter->num_tx_queues as well, or NULL-check both ring
pointers? No later patch in the series touches igb_xsk_pool_disable().

[Severity: High]
Is this check serialized against the resume path that writes
num_rx_queues and the ring arrays?

igb_xsk_pool_disable() holds only rtnl. __igb_resume() calls
igb_init_interrupt_scheme() without rtnl on runtime resume, and before
rtnl_lock() on system resume. Inside it, igb_set_interrupt_capability()
publishes num_rx_queues = rss_queues before igb_alloc_q_vector() fills
tx_ring[] and rx_ring[].

When the device is runtime-suspended with the interface up,
igb_free_q_vectors() has set num_rx_queues = 0 and the rings are NULL,
but netif_running() is still true. Runtime resume can start
asynchronously, for example from a PME on link-up:

CPU0 (XSK release, rtnl held)
igb_xsk_pool_disable()
    rx_ring = adapter->rx_ring[qid];      /* NULL */

CPU1 (runtime resume)
igb_init_interrupt_scheme()
    igb_set_interrupt_capability()
        adapter->num_rx_queues = adapter->rss_queues;

CPU0
    qid < adapter->num_rx_queues          /* now true */
    igb_txrx_ring_disable()
        tx_ring = adapter->tx_ring[qid];
        set_bit(IGB_RING_FLAG_TX_DISABLED, &tx_ring->flags);

If the rings are still NULL, this oopses. If they were just allocated,
napi_disable() races with napi_enable() and ring setup on CPU1.
igb_realloc_rx_buffer_info() is also called later with the stale local
rx_ring, which is NULL.

Can the NULL ring this patch is meant to prevent still reach
igb_txrx_ring_disable() through this window? The missing serialization
in __igb_resume() predates this patch, and later patches in the series
keep it.

>  	if (if_running)
>  		igb_txrx_ring_disable(adapter, qid);

[Severity: High]
This isn't a bug introduced by this patch, but netif_running() plus a
queue count bound doesn't show that the NAPI is enabled. Can
igb_txrx_ring_disable() end up calling napi_disable() on a NAPI that
was never enabled, or is already disabled?

netif_napi_add() sets NAPI_STATE_SCHED and NAPI_STATE_NPSVC.
napi_disable_locked() then waits on them with no timeout:

    while (val & (NAPIF_STATE_SCHED | NAPIF_STATE_NPSVC)) {
        usleep_range(20, 200);

There are two ways to reach that state:

- In __igb_resume(), igb_init_interrupt_scheme() succeeds but
  __igb_open(netdev, true) fails before napi_enable(), for example in
  igb_setup_all_tx_resources(). __LINK_STATE_START and xdp_prog stay
  set.

- igb_xdp_setup() and igb_sriov_reinit() ignore an igb_open() failure
  after igb_close(), and igb_down() has already called napi_disable().

Closing an AF_XDP socket on such a qid then runs
xp_release_deferred()->igb_xsk_pool_disable()->igb_txrx_ring_disable()->
napi_disable(), which loops forever with rtnl held.
igb_xsk_pool_enable() uses the same condition.

Would checking __IGB_DOWN, as igb_xsk_wakeup() does, be a more reliable
indicator here?

[Severity: High]
This is a pre-existing issue, but what happens when
igb_realloc_rx_buffer_info() fails further down in
igb_xsk_pool_disable()?

    if (if_running) {
        err = igb_realloc_rx_buffer_info(rx_ring, false);
        if (err)
            return err;

        igb_txrx_ring_enable(adapter, qid);
    }

By this point igb_txrx_ring_disable() has set IGB_RING_FLAG_TX_DISABLED,
zeroed TXDCTL/RXDCTL and called napi_disable(). The error return skips
igb_txrx_ring_enable(), and rx_ring->xsk_pool and tx_ring->xsk_pool
still point to the pool.

xp_disable_drv_zc() only warns:

    if (err)
        WARN(1, "Failed to disable zero-copy!\n");

The core then clears and frees the pool, so the ring is left with a
dangling xsk_pool pointer.

Any later igb_down(), from igb_close(), reset_task or igb_xdp_setup(),
calls napi_disable() on the already-disabled NAPI and blocks forever
with rtnl held. Binding a new XSK socket to that qid hangs the same way
through igb_txrx_ring_disable().

igb_xsk_pool_enable() has the same imbalance after
igb_realloc_rx_buffer_info(rx_ring, true) fails:

    if (err) {
        xsk_pool_dma_unmap(pool, IGB_RX_DMA_ATTR);
        return err;
    }

>

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261119140412.163202-1-antonio%40mandelbit.com
