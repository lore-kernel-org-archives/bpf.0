Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9315C4A2A4C;
	Fri, 18 Sep 2026 07:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789718276; cv=none; b=jPTmcpW5e8pYIWDjSkscv0G+Cmgp2ngrGRpp9ikLaHYhbNvf0HNjOkmfhi789s5tQ8TtMhQ6Xi1JZeVddJ3Zq+OoxUWO8sTEAPCkbjv7JNXOIANPQImKYlU/dMQjnoThdc28m3XIShMIAhssvMmpmw8aAZFVC7nm7/5U5ClDI0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789718276; c=relaxed/simple;
	bh=7Wv+UbIeSFmm7bcATNljXdJylA+L0Mr4gxLgjI6klPQ=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=c1aFlVO9DdUoAHJLsbHFbnMHkrj5UO1NkIDivOk5sx2OO88ck7KEew+REk/7cG4m6llRKyVM/fIBexPkC0wlOCALUr2ei2sj2rPV/Qqwe8h1fnNqcGknKmUE1fr1P+FIWlZfudAGkInUiULHg9a5Wz0jrvyRXmU1ORBYTXhXYFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IyPaBQu6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IyPaBQu6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7EB11F00899;
	Fri, 18 Sep 2026 07:57:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789718270;
	bh=5tXCa/wriYd5B+xhhAyoHOKmK8huoqb9xhLKBDUrDMk=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=IyPaBQu6JyHYNw8nGwfDsi/uRN7BNR5iYEdoLJ8k4tFZGYZCZr1UAxKYI4ZjgVT2X
	 blynIPHl8zsKluR2p/88F7zwksUeMzL+/dg0EtnzdA9G7itUXeDRth9q58cHTVJ9t9
	 0Nj/WtghQ77jLWV9d/PTrBs5pxbrcm0obcAJgPV4UERq9yXNcc9GKIe+EKYybMtpcb
	 zOh8T53/Q63yaYFQa4Xuj9qSL/g36A94WSXJx3oliCwUF4Ovce+RiuqJr6PS5hrNgf
	 Jlk6UIFge1CDB8vFx5gvsn62BNXYo2F8dIToHGNZ50NYaJmBwtXXr7aGq8HVfQPsT+
	 7w/fjIX8rauzA==
Subject: Re: [PATCH net-next v7 08/12] gve: split up notify block allocation
 and setup paths
From: netdev-bot+sashiko@kernel.org
To: hramamurthy@google.com
Cc: netdev@vger.kernel.org, joshwash@google.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
 john.fastabend@gmail.com, sdf@fomichev.me, jordanrhee@google.com,
 willemb@google.com, nktgrg@google.com, maolson@google.com, thostet@google.com,
 jacob.e.keller@intel.com, debarghyak@google.com, kees@kernel.org,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 przemyslaw.kitszel@intel.com
Date: Fri, 18 Sep 2026 07:57:48 +0000
Message-ID: <178971826826.22033.2672059641817523646@kernel.org>
In-Reply-To: <20260916165533.2187434-9-hramamurthy@google.com>
References: <20260916165533.2187434-9-hramamurthy@google.com>
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
issue(s) to consider:

Critical: 0 · High: 1 · Medium: 0 · Low: 1

- [High] Reset path now frees the notify-block MSI-X IRQs and zeroes
  block->irq *before* the NAPI/queue teardown that consumes block->irq,…
- [Low] Reported for completeness, but I could not confirm a functional
  defect: the concern claims the new alloc/setup/teardown/free split…

--

gve: split up notify block allocation and setup paths

This splits gve_alloc_notify_blocks() into an allocation half and a new
gve_setup_notify_blocks()/gve_teardown_notify_blocks() pair so that MSI-X
vectors can be requested after the IRQ doorbell offsets are known. New
irq_requested and mgmt_irq_requested flags track which irqs were taken, and
gve_reset_device() now tears the notify blocks down.

> diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/ethernet/google/gve/gve_main.c
> index 8cd82d92d3b09..7119b5a9ae41b 100644
> --- a/drivers/net/ethernet/google/gve/gve_main.c
> +++ b/drivers/net/ethernet/google/gve/gve_main.c
> @@ -429,6 +429,24 @@ int gve_napi_poll_dqo(struct napi_struct *napi, int budget)
>  	return work_done;
>  }
>  
> +static void gve_free_notify_blocks(struct gve_priv *priv)
> +{
> +	pci_disable_msix(priv->pdev);
> +	if (priv->irq_db_indices) {
> +		dma_free_coherent(&priv->pdev->dev,
> +				  priv->num_ntfy_blks *
> +				  sizeof(*priv->irq_db_indices),
> +				  priv->irq_db_indices,
> +				  priv->irq_db_indices_bus);
> +		priv->irq_db_indices = NULL;
> +	}
> +
> +	kvfree(priv->ntfy_blocks);
> +	priv->ntfy_blocks = NULL;
> +	kvfree(priv->msix_vectors);
> +	priv->msix_vectors = NULL;
> +}
> +
>  static const struct cpumask *gve_get_node_mask(struct gve_priv *priv)
>  {
>  	if (priv->numa_node == NUMA_NO_NODE)

[ ... ]

> @@ -497,15 +504,65 @@ static int gve_alloc_notify_blocks(struct gve_priv *priv)

[ ... ]

> +static void gve_teardown_notify_blocks(struct gve_priv *priv)
> +{
> +	int i;
> +
> +	if (!priv->ntfy_blocks)
> +		return;

[Severity: Low]

This isn't a bug in the current tree, but the early return here keys on
priv->ntfy_blocks while the management vector release further down depends
only on priv->msix_vectors and priv->mgmt_irq_requested:

	if (priv->mgmt_irq_requested) {
		free_irq(priv->msix_vectors[priv->mgmt_msix_idx].vector, priv);
		priv->mgmt_irq_requested = false;
	}

All three gve_free_notify_blocks() call sites currently run after
gve_teardown_notify_blocks() (or before any request_irq()), so
priv->ntfy_blocks and priv->msix_vectors are still valid whenever the
teardown runs and nothing is leaked.

Would it be worth guarding each resource with the flag that describes it,
so the ordering contract is expressed in the code rather than left to the
callers, given the mailbox mode is meant to reuse this skeleton?

> +
> +	for (i = 0; i < priv->num_ntfy_blks; i++) {
> +		struct gve_notify_block *block = &priv->ntfy_blocks[i];
> +
> +		if (!block->irq_requested)
> +			continue;
> +
> +		irq_set_affinity_hint(priv->msix_vectors[i].vector,
> +				      NULL);
> +		free_irq(priv->msix_vectors[i].vector, block);
> +		block->irq = 0;
> +		block->irq_requested = false;
> +	}
> +
> +	if (priv->mgmt_irq_requested) {
> +		free_irq(priv->msix_vectors[priv->mgmt_msix_idx].vector, priv);
> +		priv->mgmt_irq_requested = false;
> +	}
> +}

[ ... ]

> @@ -761,6 +770,7 @@ static void gve_teardown_control_plane_resources(struct gve_priv *priv)
>   */
>  static void gve_reset_device(struct gve_priv *priv)
>  {
> +	gve_teardown_notify_blocks(priv);
>  	gve_teardown_control_plane_resources(priv);
>  	gve_adminq_free(priv);
>  }

[Severity: High]

Can this end up calling disable_irq(0) on the reset path?

gve_reset() has this ordering:

	disable_work(&priv->service_task);
	gve_reset_device(priv);
	gve_queues_stop(priv);
	gve_queues_mem_remove(priv);
	gve_free_control_plane_resources(priv);

With the new first statement in gve_reset_device(), the vectors are
released and block->irq is cleared before gve_queues_stop() runs:

		free_irq(priv->msix_vectors[i].vector, block);
		block->irq = 0;
		block->irq_requested = false;

gve_queues_stop() then walks gve_tx_stop_rings()/gve_rx_stop_rings(), and
the per-ring stop only checks that the ring is still attached to a block,
which gve_turndown() does not clear:

drivers/net/ethernet/google/gve/gve_rx.c:gve_rx_stop_ring_gqi() {
	if (!gve_rx_was_added_to_block(priv, idx))
		return;

	gve_remove_napi(priv, ntfy_idx);
	...
}

and gve_remove_napi() uses block->irq without validating it:

drivers/net/ethernet/google/gve/gve_utils.c:gve_remove_napi() {
	struct gve_notify_block *block = &priv->ntfy_blocks[ntfy_idx];

	disable_irq(block->irq);
	netif_napi_del_locked(&block->napi);
}

gve_rx_stop_ring_dqo(), gve_tx_stop_ring_gqi() and gve_tx_stop_ring_dqo()
reach gve_remove_napi() the same way.

Before this patch the irqs were freed in gve_free_notify_blocks(), reached
from gve_free_control_plane_resources(), which gve_reset() calls after
gve_queues_stop(), so block->irq was still the real vector at that point.

On x86 virq 0 has a descriptor created during early boot, so disable_irq(0)
would mask that unrelated line and increment its disable depth once per
still-attached queue with no matching enable_irq(); where no descriptor
exists the call returns -EINVAL and the intended synchronization against
the driver's own vector is simply skipped.

The reset path is reachable from the service task on a device-requested
reset and from gve_tx_timeout() -> gve_schedule_reset(), so it can be
driven by ordinary queue stalls rather than only by administrative action.

Would keeping gve_teardown_notify_blocks() after gve_queues_stop(), or
skipping the disable_irq() when block->irq is 0, address this?

The same ordering is still in place at the end of the series, so it does
not look like a later patch fixes it.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260916165533.2187434-1-hramamurthy%40google.com
