Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACAFF2F90C5
	for <bpf@vger.kernel.org>; Sat, 15 Aug 2026 02:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786760079; cv=none; b=Vaz571WcOC6pGt1AejITSBLdlH7kQpPpPjoFkp0zYmvOEeUZJ9qZNb9QDdCnURXovMmhMdRZc2C2T4LN5cc8r1n6rbxKa3rPL0B/lZNPAP14dn6xTytOoLQ+3blU/kPtR+ETK/7+xEG6QKsjh/PHYicWJLRv/L3v19Si0r86qSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786760079; c=relaxed/simple;
	bh=F9mgh4zq9F8kWDC9QMCt97EX1pU0AqEPl4ZUJ3johv8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=A6/dztMV8QSggVOS1Fx1P1J1W1MhEbudBH+fpRqAYrWBhg9sDIH6uOPphmUrcvDTpJcoCQTYG7bI0AkcAtr64+9VDM0WaJ1rxE89fMeBwRsu670keHkPF7oYmfkGKrzWHmiqGRl8j6v7zGXvxgpDAPj/bdCry7QGDtSQR3AKsTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cbk0RmW/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cbk0RmW/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48A091F00A3A;
	Sat, 15 Aug 2026 02:14:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786760078;
	bh=9sDG0zo610DIrV4vijSap5NZH+xcU4ljLOGCR8+RbGg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cbk0RmW/neLsYJcohPSTJ9buyQBau/6d7TN+JM/4dHISpICWg++pCGJ+DKd03iJVA
	 gBkN6O9VzbBzFEfuTKVCDASzo5mMY4m9pDjSonnkEGgApZYgBkJegONfp7pdleidHr
	 phSNaTikM61Gt9BUtUpkqBX2PeqS9BLe1emFGgMM9vERMy9/8BmocOZEzmAWuNSp7C
	 WCDYo/+yy/lQDd+DN10yFXuX/IOP3J0zQ2FKXuLW2hjVG3M2cRXdJEM7BCPf6sv/np
	 ZVP169vQ2/2MRFIwgcLsKwfwktM+nHIj/MKdXdP0hx5t2SMoe7UPpmEXf368+bNWw4
	 vZpb1t50VjgJQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v4 06/15] gve: introduce ctrl ops to set
 vectors and Qs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Harshitha Ramamurthy" <hramamurthy@google.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260814021406.3044324-7-hramamurthy@google.com>
References: <20260814021406.3044324-1-hramamurthy@google.com>
 <20260814021406.3044324-7-hramamurthy@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 15 Aug 2026 02:14:37 +0000
Message-Id: <20260815021438.48A091F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Refactoring of device info leaves `priv->default_num_queues` uni=
nitialized, bypassing the device's suggested queue limits.
--

--- Patch [6]: [PATCH net-next v4 06/15] gve: introduce ctrl ops to set vec=
tors and Qs ---
commit 69a42c3a205dae467269f4679a52b92e85d73da9
Author: Harshitha Ramamurthy <hramamurthy@google.com>

gve: introduce ctrl ops to set vectors and Qs

This patch introduces control operations for Adminq mode by attaching the
adminq_ prefix to the existing functions placed in the gve_adminq.c file.
It adds set_num_queues and set_num_ntfy_blks to the control operations to
set maximum and default TX/RX queues in the initialization flow.

> diff --git a/drivers/net/ethernet/google/gve/gve_adminq.c b/drivers/net/e=
thernet/google/gve/gve_adminq.c
> index fc5482215588a..d0b7ce8ff4c5f 100644
> --- a/drivers/net/ethernet/google/gve/gve_adminq.c
> +++ b/drivers/net/ethernet/google/gve/gve_adminq.c
> @@ -1616,7 +1616,7 @@ int gve_set_num_ntfy_blks(struct gve_priv *priv)
>  	return 0;
>  }
> =20
> -void gve_set_num_queues(struct gve_priv *priv)
> +void gve_adminq_set_num_queues(struct gve_priv *priv)
>  {
>  	priv->tx_cfg.max_queues =3D
>  		min_t(int, priv->tx_cfg.max_queues, priv->num_ntfy_blks / 2);

[Severity: Medium]
Are we certain priv->default_num_queues is properly initialized before being
used further down in this function?

Looking at device probe initialization, it appears a prior refactoring pars=
es
the device descriptor into priv->device_info.default_tx_queues via
gve_fill_device_info(), but the explicit assignment to
priv->default_num_queues was removed:

drivers/net/ethernet/google/gve/gve_adminq.c:gve_fill_device_info() {
	...
	default_num_queues =3D be16_to_cpu(descriptor->default_num_queues);
	device_info->default_tx_queues =3D default_num_queues;
	device_info->default_rx_queues =3D default_num_queues;
	...
}

Because priv->default_num_queues evaluates to 0, does this check fail in
gve_adminq_set_num_queues():

drivers/net/ethernet/google/gve/gve_adminq.c:gve_adminq_set_num_queues() {
	...
	if (priv->default_num_queues > 0) {
		priv->tx_cfg.num_queues =3D min_t(int, priv->default_num_queues,
						priv->tx_cfg.num_queues);
	...
}

Would this unconditionally allocate the absolute maximum number of queues
available (up to priv->num_ntfy_blks / 2) and completely bypass the default
limits suggested by the hardware?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260814021406.3044=
324-1-hramamurthy@google.com?part=3D6
