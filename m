Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 174664DD6CA
	for <bpf@vger.kernel.org>; Wed,  3 Jun 2026 23:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780531171; cv=none; b=RJE7q6ihyp59D7Qv5IYqKN6NMdejwa8+cZQiUwBE6xdJ+V6AErupeLbqJjvDMTHobmr/qDhH0VMoUfL5vbO+85RPSss/jgBsuO3WsKCKriNd37q9CBSuEW0yXC3qMapU+mEmQfSwwjCh+w2KMsWQECpMMCJdFX+AOiVmYMbaNzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780531171; c=relaxed/simple;
	bh=Qym5TZMwLp+TtyzTX1ptG90K4ZDNChnkP+uQ84B7t28=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=D4xckBOem3yYjGtTFIdQqLbqiRAqj4D5s29zk6kuw/1wXThgV2pq770CpsJ7WpRlU8u0Liz614AazEkz0JPxEysjiYzzJs5OCidMRyLkNhlzCRZlnvkRUrB0CQHfWSur0DanI+Q6v2riUTgRFTLzLJ/oi4z6lsW+6hJ52VbP5DM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IwY5zVik; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IwY5zVik"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D53AA1F00893;
	Wed,  3 Jun 2026 23:59:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780531170;
	bh=09qxSlVi7hymfFnOI859di57KJhrGqD+zy3curRGD1U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=IwY5zVikcRf25TyCcME+3DveZh8JlPZLC7z/YOIohORdYq6Rhtaa1vsruy0M8c8Zk
	 HRGQ5YGWho6qnDmv+AmbcrxglSaLjuwLk0tcmkWV3o10bjBqv+MepDprUtLzynAEjM
	 iy5oECY/4isHktN9Qjb2NvE2otRUNDxF1ZXCp5brECDJlp7qdsNdQzAgOrUfoSfC6o
	 Y4puODZggSNrTeCxAFkIUimjAY9gJt/x8sci9DPoaVD9fEYzQEIrgB1PLX8etjT9tJ
	 svsBX+zECnfkmE0oqOisX/gqiEmS047UkqzGoQWmPCQBQv4iPHmYLz0+m/eAjULcVJ
	 NB20rcZrHgpwA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v2 09/15] gve: simplify reset logic
Reply-To: sashiko-reviews@lists.linux.dev
To: "Harshitha Ramamurthy" <hramamurthy@google.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260602235900.3050782-10-hramamurthy@google.com>
References: <20260602235900.3050782-10-hramamurthy@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 03 Jun 2026 23:59:29 +0000
Message-Id: <20260603235929.D53AA1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [Critical] In `gve_remove()`, the workqueue is destroyed before interrupt=
s are unregistered, leading to a Use-After-Free if an interrupt fires and q=
ueues work.
- [High] Missing state check in `gve_reset()` leads to Use-After-Free of `p=
riv->adminq` when called concurrently or after system suspend/shutdown.

Pre-existing issues:
- [High] XDP rxq info is leaked when gve_queues_start fails during an in-pr=
ogress reset, leaving dangling pointers in the network stack.
--

commit d54cafae24e9e84884315921d064dc0a6c4c8cc6
Author: Joshua Washington <joshwash@google.com>

gve: simplify reset logic

This commit simplifies the reset logic in the GVE driver by removing
recursive resets, avoiding resets during teardown, and decomposing allocati=
on
and setup steps.

> diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/eth=
ernet/google/gve/gve_main.c
> index 746ff69a28ddc..f94f3536be4c6 100644
> --- a/drivers/net/ethernet/google/gve/gve_main.c
> +++ b/drivers/net/ethernet/google/gve/gve_main.c
> @@ -1419,10 +1448,11 @@ static int gve_queues_start(struct gve_priv *priv,
>  reset:
>  	if (gve_get_reset_in_progress(priv))
>  		goto stop_and_free_rings;
> -	gve_reset_and_teardown(priv, true);
> -	/* if this fails there is nothing we can do so just ignore the return */
> -	gve_reset_recovery(priv, false);
> -	/* return the original error */
> +
> +	/* Attempt to reset. If reset is successful, gve_queues_start was
> +	 * successful.
> +	 */
> +	err =3D gve_reset(priv, false);
>  	return err;
>  stop_and_free_rings:
>  	gve_tx_stop_rings(priv, gve_num_tx_queues(priv));
>  	gve_rx_stop_rings(priv, priv->rx_cfg.num_queues);

[Severity: High]
This is a pre-existing issue, but in the stop_and_free_rings error path
inside gve_queues_start(), the rx arrays are freed via
gve_queues_mem_remove(priv) without unregistering the XDP rxq structures.=20

Could this leak xdp_rxq info and leave dangling pointers in the network
stack?

[ ... ]

> @@ -2549,54 +2547,52 @@ static int gve_reset_recovery(struct gve_priv *pr=
iv, bool was_up)
[ ... ]
> -int gve_reset(struct gve_priv *priv, bool attempt_teardown)
> +int gve_reset(struct gve_priv *priv, bool skip_queue_setup)
>  {
>  	bool was_up =3D netif_running(priv->dev);
>  	int err;
> =20
> +	if (gve_get_reset_in_progress(priv))
> +		return 0;
> +
>  	dev_info(&priv->pdev->dev, "Performing reset\n");
>  	gve_clear_do_reset(priv);
>  	gve_set_reset_in_progress(priv);
> -	/* If we aren't attempting to teardown normally, just go turndown and
> -	 * reset right away.
> -	 */
> -	if (!attempt_teardown) {
> -		gve_turndown(priv);
> -		gve_reset_and_teardown(priv, was_up);
> -	} else {
> -		/* Otherwise attempt to close normally */
> -		if (was_up) {
> -			err =3D gve_close(priv->dev);
> -			/* If that fails reset as we did above */
> -			if (err)
> -				gve_reset_and_teardown(priv, was_up);
> -		}
> -		/* Clean up any remaining resources */
> -		gve_teardown_priv_resources(priv);
> +
> +	if (was_up) {
> +		gve_queues_stop(priv);
> +		gve_destroy_rings(priv);
> +		gve_unregister_qpls(priv);
>  	}

[Severity: High]
If a background task executes gve_reset() after gve_suspend() or
gve_shutdown() has already freed priv->adminq, wouldn't this unconditional
call to gve_destroy_rings(priv) write to the freed admin queue ring buffer?

The previous code appeared to verify that device rings were still okay
before attempting to tear them down.

[ ... ]

> @@ -2977,8 +2973,8 @@ static void gve_remove(struct pci_dev *pdev)
>  	void __iomem *reg_bar =3D priv->reg_bar0;
> =20
>  	unregister_netdev(netdev);
> -	gve_teardown_priv_resources(priv);
>  	destroy_workqueue(priv->gve_wq);
> +	gve_teardown_device(priv);
>  	priv->ctrl_ops->unmap_db_bar(priv);
>  	free_netdev(netdev);
>  	pci_iounmap(pdev, reg_bar);

[Severity: Critical]
Since gve_teardown_device() is responsible for freeing the notify blocks and
interrupts, does tearing down the workqueue first expose us to a
use-after-free if gve_mgmnt_intr() fires and calls
queue_work(priv->gve_wq, &priv->service_task)?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260602235900.3050=
782-1-hramamurthy@google.com?part=3D9
