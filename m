Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2A8E194C96
	for <bpf@vger.kernel.org>; Fri,  8 May 2026 21:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778276146; cv=none; b=p6KvofhbNHH8eaBaTgnSCIFqK1baN9+SwcGNjS6zdqQRxwiEsWBA1lWVN4/iGkYUKHiZe8WgWvPv9kqlFsU3vqJ+G8fje/jP/ERf4Ym3g3+pZ8WV1oAtoXZuAa2btaHwpMxRs0lDFzfuOD/pKRLt8+Xj6OPo8h3oaUjYqQAMRmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778276146; c=relaxed/simple;
	bh=7993DJHV93Vx55/Rf+P/gpLbSOfjAJpRe9lGpUBlq4o=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ZcaD4KRNDEkqexYlcf+PQvFNWFWva+t/Jc/q0UiXFhdAee4XHZDAoWjWwsAy9OWYIH6Q+FAVxkJYxr+q3BhkP/fp/klMlxmGR05oBbsG4dWfIYvuuwC17/HHLKgEZueGe1OpG8HCOT9uMzZsncY050Rz/4aIi2s9iR+kSATvwvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=taH5YgzF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="taH5YgzF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60980C2BCB0;
	Fri,  8 May 2026 21:35:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778276145;
	bh=7993DJHV93Vx55/Rf+P/gpLbSOfjAJpRe9lGpUBlq4o=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=taH5YgzFqYVSwvnGQgXEVhsN0MGMWzMsvsXmpRRc5fm6uRWZitd86uTXAxIotqc1O
	 p1/YlMsOZQ9U41NtTi7yQa6lhi7/CN1l6k9Uz4A1LSApU5otBY+uDZ0KGFX78np3W6
	 nzuLpbpqNxEwn/s1o34VbkSf9HWsH1+tdKjDO6O65qwyB5kaJznyYBcyHeMylbxuzt
	 LULDkebIdslCkYFj6a4XWHcTU9AVwjkYuFdaRp275gnUPepB0V1k/heJj52Fng5AHg
	 ZpDc+hnJyaS+Pou31+egfYZUtcbjLMylzhwV4LcsmxsfyG2dUtYzy2toXX+5Ozhi3h
	 91MHCoCAiiSaA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next,v9 2/2] net: mana: force full-page RX buffers
 via ethtool private flag
Reply-To: sashiko@lists.linux.dev
To: "Dipayaan Roy" <dipayanroy@linux.microsoft.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260508142921.497921-3-dipayanroy@linux.microsoft.com>
References: <20260508142921.497921-3-dipayanroy@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 08 May 2026 21:35:44 +0000
Message-Id: <20260508213545.60980C2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Forcing `apc->port_is_up =3D true` in the `mana_attach` error path=
 causes a guaranteed NULL pointer dereference in the reset worker.
--

commit d36beb9b51f56b9797284c9fa1dd515410680980
Author: Dipayaan Roy <dipayanroy@linux.microsoft.com>
Subject: net: mana: force full-page RX buffers via ethtool private flag

This patch adds an ethtool private flag full-page-rx that allows the
user to force one RX buffer per page, bypassing the page_pool fragment path
on ARM64 platforms with 4K PAGE_SIZE.

> diff --git a/drivers/net/ethernet/microsoft/mana/mana_ethtool.c b/drivers=
/net/ethernet/microsoft/mana/mana_ethtool.c
> index 7e79681634db3..f22bbb3259489 100644
> --- a/drivers/net/ethernet/microsoft/mana/mana_ethtool.c
> +++ b/drivers/net/ethernet/microsoft/mana/mana_ethtool.c
[ ... ]
> @@ -590,6 +609,88 @@ static int mana_get_link_ksettings(struct net_device=
 *ndev,
[ ... ]
> +static int mana_set_priv_flags(struct net_device *ndev, u32 priv_flags)
> +{
[ ... ]
> +		err =3D mana_attach(ndev);
> +		if (err) {
> +			netdev_err(ndev, "mana_attach failed: %d\n", err);
> +			apc->priv_flags =3D old_priv_flags;
> +
> +			/* Restore 'port_is_up' so the reset work handler
> +			 * can properly detach/attach. Without this,
> +			 * the handler sees port_is_up=3Dfalse and skips
> +			 * queue allocation, leaving the port dead.
> +			 */
> +			apc->port_is_up =3D true;
> +			schedule_port_reset =3D true;
> +		}

Can this cause a NULL pointer dereference in the reset worker?

If mana_attach() fails, its error path cleans up the partially allocated st=
ate.
Specifically, if mana_alloc_queues() fails, it calls mana_cleanup_port_cont=
ext(),
which frees the tx_qp array and sets apc->tx_qp =3D NULL.

When apc->port_is_up is forced to true and the reset work is scheduled here:

mana_set_priv_flags()
  err =3D mana_attach(ndev);
  if (err) {
      ...
      apc->port_is_up =3D true;
      schedule_port_reset =3D true;
  }

The reset worker will eventually call mana_detach(). Because apc->port_is_up
is true, mana_detach() will attempt to deallocate the queues:

mana_detach()
  apc->port_st_save =3D apc->port_is_up;
  ...
  if (apc->port_st_save) {
      err =3D mana_dealloc_queues(ndev);

If mana_dealloc_queues() unconditionally iterates over apc->num_queues and
accesses apc->tx_qp[i], does this lead to an immediate kernel panic since
apc->tx_qp was already set to NULL during the earlier cleanup?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260508142921.4979=
21-1-dipayanroy@linux.microsoft.com?part=3D2
