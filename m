Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74F6546AA81
	for <bpf@vger.kernel.org>; Tue,  4 Aug 2026 18:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785869223; cv=none; b=rLNuUyT/lFYD5laYC8prhptXutHpOuArbASlhisK1Iy+5qJPAgj/3j4YzWy+DXqDFAJ6eDYvp/r7sDjqwAxX4fkgGRew09GCatreSyD1VQG3q5VY/9MFtDM9yWtnI9BMHgTeHnCxnLxgHMFbK8NNS5Grog6+vKRm7EQwcLAZH7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785869223; c=relaxed/simple;
	bh=p8zVV+kKesqNHt0+Nl98/9wjVlmfOEW/1aDqsrm3nkM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=GEZdBNvGTn01xt6ROyDG9aRHmwggkoECBYb9vXQc3zw6or+7j7ajOflWr65ggcJs4R5dWzEvhrLcu337QLtedfGJenCs+TE29Q/WCNEX2/Jq/6f60QkfTgAe92AkcP7rh8BEH3uKxzd5jYXHqkL5In+n2SDUV9DhnvvZsokvUU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YgtDqlzC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YgtDqlzC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B8811F00A3D;
	Tue,  4 Aug 2026 18:47:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785869222;
	bh=sQs3TVyyJg4dPp5jpSIY4J19KgCRmuQyXk7NbjmU95g=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YgtDqlzC+Jmlj81CgEGpj3boOgF7iDHiIlMEYybzGngW5av52NNWdPh1jHsLSbntG
	 Z0QT4PY+1vcVh0hH7l9X9IMEC7/oH/14jyz7rt3VZUJTopJpCquwlxwx/avNoFBaJs
	 29BlZR7EDAsccqchYzK0AKx/5/bolsvXxrFYEU8p55jUH59jFtyJ6OOE2FpS49x31y
	 gCVm3uFp9krQW85p8oYwaVOC/DYNUqYVU5xAIt3fGpj4FuqBDdOnr/XVPvNjy05f29
	 um4HnXl8tseiFG4/rr07hXvT02NUKEzwDL19HdFy26Iv8cbtutPEEwaffXPfIyFmHY
	 27cEG2gn2RnRw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v3 09/15] gve: simplify reset logic
Reply-To: sashiko-reviews@lists.linux.dev
To: "Harshitha Ramamurthy" <hramamurthy@google.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260803184630.3813311-10-hramamurthy@google.com>
References: <20260803184630.3813311-1-hramamurthy@google.com>
 <20260803184630.3813311-10-hramamurthy@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 04 Aug 2026 18:47:01 +0000
Message-Id: <20260804184702.3B8811F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] The `while (!service_task_enabled)` loop in `gve_recover` forceful=
ly enables `service_task`, overriding concurrent `disable_work_sync` calls =
from PM suspend, allowing the task to run while the device is suspended.

Pre-existing issues:
- [High] `gve_xsk_pool_enable` and `gve_xsk_pool_disable` unconditionally d=
ereference `priv->xsk_pools`, which is NULL if the device failed to recover=
 from a reset.
--

--- Patch [9]: [PATCH net-next v3 09/15] gve: simplify reset logic ---
commit e14381443089f802adbf14cabd9d5e8b89337630
Author: Joshua Washington <joshwash@google.com>
Subject: gve: simplify reset logic

This commit simplifies the GVE reset logic by removing recursive resets,
avoiding resets during teardown, and separating control plane resource
allocation from device setup. Shared resources are now retained until the
hardware reset completes to prevent premature release.

> diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/eth=
ernet/google/gve/gve_main.c
> index 6f04eefd04166..578520e107930 100644
> --- a/drivers/net/ethernet/google/gve/gve_main.c
> +++ b/drivers/net/ethernet/google/gve/gve_main.c
> @@ -591,7 +591,22 @@ static void gve_free_notify_blocks(struct gve_priv *=
priv)
>  	priv->msix_vectors =3D NULL;
>  }
> =20
> -static int gve_setup_device_resources(struct gve_priv *priv)
> +static void gve_free_control_plane_resources(struct gve_priv *priv)
> +{
> +	bitmap_free(priv->xsk_pools);
> +	priv->xsk_pools =3D NULL;

[Severity: High]
This is a pre-existing issue, but does the driver safely handle a NULL
xsk_pools bitmap if recovery fails?

If gve_recover() fails during a reset (for example, if gve_setup_device()
fails), priv->xsk_pools is left as NULL because it is freed here during
teardown.

Since the netdev remains registered, a subsequent AF_XDP socket bind from
userspace could call gve_xsk_pool_enable() or gve_xsk_pool_disable().
These functions unconditionally dereference the bitmap:

drivers/net/ethernet/google/gve/gve_main.c:gve_xsk_pool_enable() {
    ...
    set_bit(qid, priv->xsk_pools);
    ...
}

Could this lead to an immediate NULL pointer dereference if a user with
sufficient privileges configures AF_XDP on the failed device?

[ ... ]

> -static int gve_reset_recovery(struct gve_priv *priv, bool was_up)
> +static int gve_recover(struct gve_priv *priv, bool setup_queues)
>  {
> +	bool service_task_enabled =3D false;
>  	int err;
> =20
>  	err =3D gve_adminq_init(priv);
>  	if (err) {
>  		dev_err(&priv->pdev->dev,
>  			"Failed to alloc admin queue: err=3D%d\n", err);
> -		goto err;
> +		goto teardown_device;
>  	}
> =20
>  	err =3D gve_adminq_verify_driver_compatibility(priv);
>  	if (err) {
>  		dev_err(&priv->pdev->dev,
>  			"Could not verify driver compatibility: err=3D%d\n", err);
> -		goto err_free_adminq;
> +		goto teardown_device;
>  	}
> =20
>  	err =3D gve_setup_device(priv);
>  	if (err)
> -		goto err_free_adminq;
> -	if (was_up) {
> +		goto teardown_device;
> +
> +	/* In the case of cascading failures, the disable count could be greater
> +	 * than 1. The service task must be enabled before starting queues.
> +	 */
> +	while (!service_task_enabled)
> +		service_task_enabled =3D enable_work(&priv->service_task);

[Severity: High]
Could this loop override a concurrent suspend operation?

If a device reset (gve_reset) runs concurrently with power management
suspend (gve_suspend), gve_suspend increments the service task's disable
count via disable_work_sync() and waits for the rtnl_lock.

If gve_reset holds the rtnl_lock and executes gve_recover(), it drops the
disable count to 0 in this loop. Once gve_reset finishes, gve_suspend
acquires the lock, completes teardown, and suspends the device to D3.

Since the service_task is now enabled, couldn't it be scheduled to run while
the device is suspended? This might result in an MMIO read on a D3 state
device, causing a kernel panic or PCIe AER fatal error.

[ ... ]

> @@ -3017,16 +3025,14 @@ static int gve_suspend(struct device *dev)
>  	struct gve_priv *priv =3D netdev_priv(netdev);
>  	bool was_up =3D netif_running(priv->dev);
> =20
> +	disable_work_sync(&priv->service_task);
> +
>  	priv->suspend_cnt++;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260803184630.3813=
311-1-hramamurthy@google.com?part=3D9
