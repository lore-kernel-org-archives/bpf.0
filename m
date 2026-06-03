Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA7154DD6C9
	for <bpf@vger.kernel.org>; Wed,  3 Jun 2026 23:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780531171; cv=none; b=g9giFIdc7fbymguTk+1mJ7BHL7+5Kc/dJB+e07ukr3HWSJmGVqVAiyWxWbPwS+FZRzrPCXpQ86Uf/12uBc/XgXHXlFHVl9dS5HYB7WKYGwyD5sSQ3JDUeLaqRp7HCY93uosxwKG5DpzhFVkUXcHSBRAab4FvPBL0Q2SWqnY+ANo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780531171; c=relaxed/simple;
	bh=GYWyQjC0RSHYDcAGBg0CvtNtUktu2PzAYdWOzXyM3J0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=CmvO2ZZsDdDyaQ8FVAoNvrlFEXzgEOmnVNS9/dPEbFZ08R2beRI8rxTOEJWRVzDahXSlE+v8PQemDdUJvALpM9fXk4zAU0LRpRrsVrMc4QcibxD+WuvtGLPO4VfRCpuH8df5QfaGyiRYVKo0TgbPjDZ4SnZ0J21Soeo2sEEE/NI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MzcXhT9n; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MzcXhT9n"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 733D31F00898;
	Wed,  3 Jun 2026 23:59:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780531170;
	bh=9rEZldMf34vTBf+0AL3/KS6JbwUXCxMpS0iCAPvXPIk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MzcXhT9nEwna++SiEwbBHMyIAg74p2t6Svxs/NZAqWK+7/TZ7QDKh5vRqoJuDhr9+
	 gjI/Wg9ywcDASGMGDjhrE+bKyRsXKz2Y9rkDs6GZ/rxRlzLdJBsK5j/AxaUWLGhMUV
	 tMY3DF/KrpjEtQo8b+H239SuBxWCgrXKI2QkoTKl1VYl1955tAkCSCDvGrMjVnWIcD
	 dPxfpFYLob8APKu/rTPETmuA+Zg7zvW71Ua5pEMIbPCGZToHS1h2m7jP2lY5Wt4hKz
	 6yo/Hlsq5zKkhWNREb+F17lYBZiCHOKTJDoXEZWozxasddkNA+088gnVZUqh1MBneJ
	 0Q0MVIWZaip8g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v2 11/15] gve: split up notify block allocation
 and setup paths
Reply-To: sashiko-reviews@lists.linux.dev
To: "Harshitha Ramamurthy" <hramamurthy@google.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260602235900.3050782-12-hramamurthy@google.com>
References: <20260602235900.3050782-12-hramamurthy@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 03 Jun 2026 23:59:30 +0000
Message-Id: <20260603235930.733D31F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] The management interrupt can trigger a Use-After-Free by queueing =
work on a destroyed workqueue during device removal.
--

commit 3245301c6f7eba646dce95ef2e71441d61e4f037
Author: Joshua Washington <joshwash@google.com>

gve: split up notify block allocation and setup paths

Before this patch, notify block allocation and setup occurred in the same
method. This all occurred before gve_adminq_configure_device_resources,
which populates the irq_db_indicies array, a DMA region with BAR offsets
for MSI-X vectors. The coming mailbox mode will require notify blocks to be
set up only after receiving the IRQ doorbell offsets. This ordering also
works for admin queue mode, so it is updated to match.

> diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/eth=
ernet/google/gve/gve_main.c
> index 0e88a04348490..2f92dc8176305 100644
> --- a/drivers/net/ethernet/google/gve/gve_main.c
> +++ b/drivers/net/ethernet/google/gve/gve_main.c
[ ... ]
> @@ -743,6 +752,7 @@ static void gve_teardown_control_plane_resources(stru=
ct gve_priv *priv)
> =20
>  static void gve_teardown_device(struct gve_priv *priv)
>  {
> +	gve_teardown_notify_blocks(priv);

[Severity: High]
In gve_remove(), the patch series reordered the teardown sequence to call
destroy_workqueue() before gve_teardown_device():

drivers/net/ethernet/google/gve/gve_main.c:gve_remove() {
	...
	unregister_netdev(netdev);
	destroy_workqueue(priv->gve_wq);
	gve_teardown_device(priv);
	...
}

Because gve_teardown_device() (via gve_teardown_notify_blocks()) is what
calls free_irq() to release the management interrupt, the interrupt remains
active while and after the workqueue is destroyed.

If a management interrupt fires during this window, gve_mgmnt_intr() will
execute:

drivers/net/ethernet/google/gve/gve_main.c:gve_mgmnt_intr() {
	...
	queue_work(priv->gve_wq, &priv->service_task);
	return IRQ_HANDLED;
}

Can this sequence trigger a use-after-free by enqueuing work on the destroy=
ed
workqueue?

>  	gve_teardown_control_plane_resources(priv);
>  	gve_adminq_free(priv);
>  	/*

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260602235900.3050=
782-1-hramamurthy@google.com?part=3D11
