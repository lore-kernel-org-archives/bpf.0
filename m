Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C0554DD6C7
	for <bpf@vger.kernel.org>; Wed,  3 Jun 2026 23:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780531173; cv=none; b=aZj+uDlIlwIapoN6PsVvwDmrbM79hnbOcj7x/P6UiY2baADAmW4EvGlM/33kzPa3ju7iscfCOCpMW3HaLm4YiZuEQ7OBFAU8UIcYNgJppDs9qqSsNhSfQCg89q+p//uzVgVlZ4oZ5W8XGAfqPPFbu7nQMB1v8ZVZ3YrgLXNsaJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780531173; c=relaxed/simple;
	bh=ZbZ0pWyD201VkbycYUqYZCTpYjJJXSHecKMAZ3A5LN4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=I17XTD35lhxrHvvznOWkylVnigKgDALuAMO1Ymn3QJkdMP7FpDj1XlFBT1ZVI5Bu14M7PgDEaj1ZPSQU3bVfikKIiwD0wJHLxPFirySeiwmPdRv3zxAQp7WobrOhiWxmP7o/teKwI6VNrtmD9Tmzi/pWJZ4k55eeSB95x3D6VSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ig2bpqTu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ig2bpqTu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B038A1F00893;
	Wed,  3 Jun 2026 23:59:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780531171;
	bh=EAZWKChEFTWkeNmvUzW/SpDyVoBLaFNSpoh2T85cyF0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ig2bpqTuc0grSDE9oDniimvHZ1x7uNpgNcdn3ppnNnQeOPGCHNo27QRn/u1LjODgo
	 FkMw2F+KbR0AgGnsBlQ/PpuVFChm8zM63/n8JNJPMxJ+zNjzud3pXXxlHz2EBGgRg+
	 4MRXSeFyiOfaqA6grd9K0EMViW1bD7W4MVE9TJfXRoZ/oNxdV21jMR9hddWk1Ocq7Y
	 GONTYZ1yuR3xFUXjWu5OxSsLoQYKxSglyaTe9NhnEJqzUYOqBDWBIT84ylxYUgcstg
	 L+36RvczNOXcQOQ7qvejd4PMuFeOcwVY5fcNe9vxDVQlWzO7geo2czZCzSeW8epqY8
	 9U2nPzd6jxKHg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v2 13/15] gve: setup and teardown management
 interrupts
Reply-To: sashiko-reviews@lists.linux.dev
To: "Harshitha Ramamurthy" <hramamurthy@google.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260602235900.3050782-14-hramamurthy@google.com>
References: <20260602235900.3050782-14-hramamurthy@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 03 Jun 2026 23:59:31 +0000
Message-Id: <20260603235931.B038A1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The workqueue `priv->gve_wq` is destroyed before the management IR=
Q is freed in `gve_remove()`, leading to a use-after-free if the interrupt =
fires during device teardown.
- [High] `stats_report_task` is not canceled when freeing the stats report,=
 leading to a NULL pointer dereference if the interface is reset while down.
--

commit bb3bcdd68440531b8ea4f0e46ef000aabc8d097d
Author: Joshua Washington <joshwash@google.com>

gve: setup and teardown management interrupts
   =20
Introduce control ops to setup/teardown control plane IRQs. Admin
queue-specific functionality is moved to admin queue files.

> diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/eth=
ernet/google/gve/gve_main.c
> index 7b034b439cebb..8005373e91bde 100644
> --- a/drivers/net/ethernet/google/gve/gve_main.c
> +++ b/drivers/net/ethernet/google/gve/gve_main.c
> @@ -267,14 +267,6 @@ static void gve_free_stats_report(struct gve_priv *p=
riv)
>  	priv->stats_report =3D NULL;
>  }

[Severity: High]
This is a pre-existing issue, but does this function fail to cancel
the stats_report_task?

gve_free_stats_report() calls timer_delete_sync(&priv->stats_report_timer),
but it does not call cancel_work_sync(&priv->stats_report_task).

If the user enables stats reporting while the interface is down, the timer
starts. If a reset is triggered while the interface is down, gve_reset() sk=
ips
gve_queues_stop() (where the task is normally canceled) and proceeds to
teardown.

gve_free_control_plane_resources() then calls gve_free_stats_report(), which
frees priv->stats_report and sets it to NULL.

If the stats_report_task was queued just before the timer was deleted, it w=
ould
execute asynchronously and call gve_handle_report_stats(), which unconditio=
nally
dereferences priv->stats_report->stats.

Could this lead to a NULL pointer dereference?

[ ... ]

> @@ -499,6 +491,7 @@ static int gve_alloc_notify_blocks(struct gve_priv *p=
riv)
> =20
>  static void gve_teardown_notify_blocks(struct gve_priv *priv)
>  {
> +	const struct gve_ctrl_ops *ops =3D priv->ctrl_ops;
>  	int i;
> =20
>  	if (!priv->ntfy_blocks)
> @@ -518,29 +511,24 @@ static void gve_teardown_notify_blocks(struct gve_p=
riv *priv)
>  		block->irq_requested =3D false;
>  	}
> =20
> -	if (priv->mgmt_irq_requested) {
> -		free_irq(priv->msix_vectors[priv->mgmt_msix_idx].vector, priv);
> -		priv->mgmt_irq_requested =3D false;
> -	}
> +	ops->teardown_mgmt_irq(priv);

[Severity: High]
This isn't a bug introduced by this patch, but is it possible for the
management IRQ to fire after the workqueue is destroyed?

In gve_remove() in drivers/net/ethernet/google/gve/gve_main.c,
destroy_workqueue(priv->gve_wq) is called before gve_teardown_device(priv).

gve_teardown_device() eventually reaches this code to tear down the managem=
ent
IRQ. Because the IRQ is still active and unmasked after destroy_workqueue(),
an interrupt could fire during this window.

If that happens, gve_mgmnt_intr() calls:
    queue_work(priv->gve_wq, &priv->service_task);

Could this result in a use-after-free regression on the destroyed workqueue
pointer?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260602235900.3050=
782-1-hramamurthy@google.com?part=3D13
