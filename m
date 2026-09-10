Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 815585921E2
	for <bpf@vger.kernel.org>; Thu, 10 Sep 2026 19:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789067520; cv=none; b=G1lAhSWqffJuWYgw/aUUEnmOG6rTHxRehps0i5G2mdEK+Ryq77TLQm9tDWND93G9T1ApGVZjgV8Dibyb+K2Yrf5XYHVi90so76Bc3enmQbGuS54gsCiQTbtAfiDM52KODpOXBkJq5WTCm7orY+b3QoWc93Hl7aqgKjHJGilAhpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789067520; c=relaxed/simple;
	bh=Y8ruwgxCpOqRXkr7H+RTrti9NnM0WbhmqtQl1qe/AS8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=a+lHrTy0O7uXXqAIjUACXQeCBLU+ikYjiBQ5wOW4hZoG98JxhZ8uaqZUDqH4d5Y8MvWV6YiV8eIVQw0+Aq/V/3ZSnnGTvm4wMmtdi/FCW3mwY3XjvRQjiyVws3Efr+Qukn6hQKbkHzogD2ApWA7znQ4dPlT7NM4m1yPV3zKqyBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U08ABAVl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U08ABAVl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCC421F00893;
	Thu, 10 Sep 2026 19:11:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789067517;
	bh=5H4HOLDijXlCQoYYa+YNxn3NAjqNRtoOi7pQJJ32Mnw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=U08ABAVl2QZYbUvzuZaBVIVFZXs009t4fsd/5GOrX6NgGGfiTSxM3/uyoBHnvm8pQ
	 sU6f1D5RufkyF8S4cnwgdXfXfRP41VXdF/hsKvLda0C2bzj1066tQ/2vWGlPizRmsG
	 wplG9eRiAHQ3uaFj8Tjks1aCsCZv3IyzsvmONOrGVFsMwChWqHunlZtGDAN3AYgeP1
	 3NgvJG96pdIdo17XtYUJbZ5Ob6yaVsZT4XYB/wDhSNiQFjN290xYjg1KQgCnH7o15H
	 SstfO2tjrgwzkijxCZ2Za0XvYhnT5A476Cgh0PgGysV4Ser0/AUhlMi2gUZoa7MyCw
	 xkzI+9/cPjbiA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v6 08/12] gve: split up notify block allocation
 and setup paths
Reply-To: sashiko-reviews@lists.linux.dev
To: "Harshitha Ramamurthy" <hramamurthy@google.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260909191136.3811892-9-hramamurthy@google.com>
References: <20260909191136.3811892-1-hramamurthy@google.com>
 <20260909191136.3811892-9-hramamurthy@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 10 Sep 2026 19:11:57 +0000
Message-Id: <20260910191157.BCC421F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing cancel_work_sync() for stats_report_task leads to NULL Poi=
nter Dereference during device teardown.
--

commit c59c716d20178f6c3e44afb298f8d5eeb8f487be
Author: Joshua Washington <joshwash@google.com>

    gve: split up notify block allocation and setup paths
   =20
    Before this patch, notify block allocation and setup occurred in the sa=
me
    method. This all occurred before gve_adminq_configure_device_resources,
    which populates the irq_db_indicies array, a DMA region with BAR offsets
    for MSI-X vectors.

> diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/eth=
ernet/google/gve/gve_main.c
> index cc27141240fd1..d2f974a0cc877 100644
> --- a/drivers/net/ethernet/google/gve/gve_main.c
> +++ b/drivers/net/ethernet/google/gve/gve_main.c

[ ... ]

> @@ -749,6 +758,7 @@ static void gve_teardown_control_plane_resources(stru=
ct gve_priv *priv)
> =20
>  static void gve_teardown_device(struct gve_priv *priv)
>  {
> +	gve_teardown_notify_blocks(priv);
>  	gve_teardown_control_plane_resources(priv);

[Severity: High]
This is a pre-existing issue, but does the device teardown path properly
cancel the stats_report_task?

If a user enables stats reporting while the interface is down,
stats_report_timer is armed and enqueues stats_report_task into the
workqueue. If the device is subsequently unbound, gve_teardown_device()
calls gve_teardown_control_plane_resources(), which eventually calls
gve_free_stats_report().

In drivers/net/ethernet/google/gve/gve_main.c:gve_free_stats_report():

	timer_delete_sync(&priv->stats_report_timer);
	dma_free_coherent(&priv->pdev->dev, priv->stats_report_len,
			  priv->stats_report, priv->stats_report_bus);
	priv->stats_report =3D NULL;

This deletes the timer and frees the memory, but leaves the pending task in
the workqueue.

Then gve_remove() continues and flushes the workqueue:

	gve_teardown_device(priv);
	destroy_workqueue(priv->gve_wq);

When the workqueue is flushed, stats_report_task will execute
gve_handle_report_stats(), which dereferences priv->stats_report:

void gve_handle_report_stats(struct gve_priv *priv)
{
	struct stats *stats =3D priv->stats_report->stats;

Could this lead to a NULL pointer dereference? Should cancel_work_sync() be
called on stats_report_task before freeing priv->stats_report?

>  	gve_adminq_free(priv);
>  	/*

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260909191136.3811=
892-1-hramamurthy@google.com?part=3D8
