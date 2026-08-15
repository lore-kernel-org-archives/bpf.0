Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 454791632E7
	for <bpf@vger.kernel.org>; Sat, 15 Aug 2026 02:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786760078; cv=none; b=bFo/hgwp9uvc9jI64rFqawKPrpXDHQFih66U7oZyFMGJPqPgig/qR9zXH6Jn8u4oZT/ast4QmG+Ru4dj9PlEPMh2kIVuBIYfdTyUwSxJ4A/3x/4ZgCvWw9/pu0l9wsietL3dzQC8LD0DvjdcYlUOORwDyhE6qzKpEbFoMlfZZx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786760078; c=relaxed/simple;
	bh=IZJcoff1SlO9WeTMgOpy7j/C8AEPiD50ySlJQtmEBu8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=DSH43nbovN2lc93Xs8653Te6aPBI+llnEpBKBDYdDkKG7PVX2GPmDGt0A0I8iLkN9zevz9vxXm2dxRJf8BtQ5/uQjVLVahNndKGyGHcENxVVlBFeIvlNWwL51lv+yLujhCunWbJSQnUy/BERi1/trxkrqmNDeedBJ39o1sdcXno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iwy6ORNQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iwy6ORNQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E34CA1F00A3D;
	Sat, 15 Aug 2026 02:14:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786760077;
	bh=SrHac5vP3MDkMLMFd7V72dHpVEylgKyMEMhI5A0yI6w=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=iwy6ORNQ2AUtmK7V6MgGabrbK5p3aOyrEYd5PCQxztYOluSOMmlM9YyCgF/0geM69
	 zCYg3g3tfsLx4KF5laphzFF4eUH/nJViGCHObhMZ0Rm6LvjjNFU0Uv+JR2cn8X2txt
	 JginloJrEW1Z9d1CX1U8KWiLo+8YTBccM9KT/5J/qxNQjthUDVong8jmfVoKIkCdgP
	 drvl3c28KfJD36Jo+3nbzysuS1mxNZvHdH/4wvd0bVMl78Gey+WtdJRc9XL0eS0YmY
	 rkmUe6CzhmBOm7mm4hk8iblz7maKrBX6+CMIM2U08rU072dpBmwkpbZmURxPYeD8dt
	 /droWZ59Prhzw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v4 09/15] gve: simplify reset logic
Reply-To: sashiko-reviews@lists.linux.dev
To: "Harshitha Ramamurthy" <hramamurthy@google.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260814021406.3044324-10-hramamurthy@google.com>
References: <20260814021406.3044324-1-hramamurthy@google.com>
 <20260814021406.3044324-10-hramamurthy@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 15 Aug 2026 02:14:36 +0000
Message-Id: <20260815021436.E34CA1F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Dangling pointers for `priv->tx` and `priv->rx` are left behind if=
 `gve_create_rings()` fails during interface open, leading to a Use-After-F=
ree.
- [High] The `gve_recover` function unconditionally forces the `service_tas=
k` work item to become enabled, breaking synchronization guarantees in powe=
r management and teardown paths and leading to a `WARN_ON_ONCE` or hardware=
 fault.
--

--- Patch [9]: [PATCH net-next v4 09/15] gve: simplify reset logic ---
commit 49cb37f017cb334dfcf8209cde2a7c5d05f9e88e
Author: Joshua Washington <joshwash@google.com>
Subject: gve: simplify reset logic

This commit simplifies the reset logic in the GVE driver by removing
recursive resets and restructuring the teardown and deallocation steps.
It ensures that the driver can execute a hardware reset even if control
plane operations fail, and consolidates the recovery path.

> diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/eth=
ernet/google/gve/gve_main.c
> --- a/drivers/net/ethernet/google/gve/gve_main.c
> +++ b/drivers/net/ethernet/google/gve/gve_main.c
> @@ -2515,93 +2543,81 @@ static int gve_init_priv(struct gve_priv *priv)
> [ ... ]
> +static int gve_recover(struct gve_priv *priv, bool setup_queues)
> +{
> +	bool service_task_enabled =3D false;
> +	int err;
> +
> +	err =3D gve_adminq_init(priv);
> +	if (err) {
> +		dev_err(&priv->pdev->dev,
> +			"Failed to alloc admin queue: err=3D%d\n", err);
> +		goto teardown_device;
> +	}
> +
> +	err =3D gve_adminq_verify_driver_compatibility(priv);
> +	if (err) {
> +		dev_err(&priv->pdev->dev,
> +			"Could not verify driver compatibility: err=3D%d\n", err);
> +		goto teardown_device;
> +	}
> +
> +	err =3D gve_setup_device(priv);
> +	if (err)
> +		goto teardown_device;
> +
> +	/* In the case of cascading failures, the disable count could be greater
> +	 * than 1. The service task must be enabled before starting queues.
> +	 */
> +	while (!service_task_enabled)
> +		service_task_enabled =3D enable_work(&priv->service_task);

[Severity: High]
Does this loop risk breaking the synchronization guarantees of power
management callbacks?

Functions like gve_suspend(), gve_shutdown(), and gve_remove() explicitly
synchronize and disable the background work by calling disable_work_sync()
to ensure the task does not execute while hardware resources are unavailabl=
e:

gve_suspend() {
    disable_work_sync(&priv->service_task);
    ...
    if (was_up)
        gve_close(priv->dev);
    ...
}

If gve_close() fails during one of these callbacks (for example, due to an
adminq timeout), it triggers a fallback to gve_reset() which in turn calls
gve_recover(). Won't this loop unconditionally undo the intentional
disable_work_sync(), leaving the device in suspend or shutdown with the
service task fully active?

Additionally, on the subsequent gve_resume(), gve_recover() is called again.
Since the disable depth would already be 0, wouldn't calling enable_work()=
=20
here trigger a WARN_ON_ONCE(!offqd->disable) in the core workqueue subsyste=
m?

> +
> +	if (setup_queues) {
> +		err =3D gve_open(priv->dev);

[Severity: High]
If gve_create_rings() fails during this nested gve_open() call, could it
leave dangling pointers for priv->tx and priv->rx?

When gve_create_rings() fails during an initial gve_open(), it triggers
gve_reset(). Because the interface is marked as starting, gve_reset()
performs cleanup via gve_queues_mem_remove() (which properly nullifies
priv->tx and priv->rx) and then calls gve_recover() to restart the queues.

Inside gve_recover(), this nested call to gve_open() allocates new ring
memory and updates the priv->tx and priv->rx pointers. If queue creation
fails again, gve_queues_start() detects that reset_in_progress is true (set
by the outer gve_reset) and jumps to the stop_and_free_rings label:

gve_queues_start() {
...
stop_and_free_rings:
    gve_tx_stop_rings(priv, gve_num_tx_queues(priv));
    gve_rx_stop_rings(priv, priv->rx_cfg.num_queues);
free_rings:
    gve_queues_mem_free(priv, tx_alloc_cfg, rx_alloc_cfg);
    return err;
}

The stop_and_free_rings path frees the memory using gve_queues_mem_free(),
but doesn't appear to nullify priv->tx and priv->rx like
gve_queues_mem_remove() does. Could this lead to a use-after-free if
another context like ethtool -S checks if (priv->tx) and dereferences
these pointers?

> +		if (err)
> +			goto disable_work;
> +	}
> +
> +	return 0;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260814021406.3044=
324-1-hramamurthy@google.com?part=3D9
