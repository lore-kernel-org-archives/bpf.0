Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A57F46DFE7
	for <bpf@vger.kernel.org>; Tue,  4 Aug 2026 18:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785869227; cv=none; b=Iken9fnoGh3Rw8uGuZ+s4U3Uj9M75HrW2PqW4OQUTm8Iurwnoz2H+Ws7tz1zdPHgjFhLzEwxKn42g13P1w+V18tsSBLQjfLb1bXTmsXbcnri3Z6OvdYCJgA4Owt3Ca4gjIkAWuea0tDeLnLOlmdZmEE2uoHq4ZSSkfXi6QJR3SM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785869227; c=relaxed/simple;
	bh=xgWApBgMVfsQadbqb5IsGc9ICiY610daptDG2+jfmPs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=utWBmhiHwszZkuzS2dYZ2aCLBD7i4ATuStzKTGFc5stqC3vwgtZFKID32HP+RTNTAvNYxPnvW7QhRAgbCpaqa+khz8oPTLfMK8asHUa2m84r+7ZcpGzmAw4RM6zW1Q+jVCH3Cw8uhJF/yKm0cbdXZd3FhQDN9sWh6kd/0w+Zv7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mfk0x8p5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mfk0x8p5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A4031F00A3A;
	Tue,  4 Aug 2026 18:47:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785869226;
	bh=pkICV7oYN/EpPwbGQRivqIw3Y5lRLfhbKJ2bHRL+XzE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mfk0x8p53p5pfTvXueMezfyu/VsSLIkfVQV0JRleHgHEVOzDy6eWWyUkMqGEG6KVu
	 YreTpob2NcO19hNwx+7iLiu+MxETqP19By6no5vEY3cIDi5QOcfAPWDuJTwQyDEanp
	 hprDE6diZqTb/LUB5NqQnSzoMbOIJWL+u/wldr8AmPcTiZZwqeIGgjD/DBTrTED28E
	 I5DARKfgZEv7WTavWiuVz6v0d7hupCthodc5Gx06uk7tNgIpjOrx43KfItEPkKGNwd
	 a8aUoEgTY+IhGrLoVcqj47VzfcFSJ3nYGSvon0w2ehJUe+D6ugKpUpYxjs8smcpgbT
	 QqF8lVCeiQYmw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v3 15/15] gve: add link status/speed ctrl ops
Reply-To: sashiko-reviews@lists.linux.dev
To: "Harshitha Ramamurthy" <hramamurthy@google.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260803184630.3813311-16-hramamurthy@google.com>
References: <20260803184630.3813311-1-hramamurthy@google.com>
 <20260803184630.3813311-16-hramamurthy@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 04 Aug 2026 18:47:05 +0000
Message-Id: <20260804184706.3A4031F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Ethtool operations can trigger a Use-After-Free on the admin queue=
 memory if the device fails a reset or is torn down.
- [High] Temporary DMA buffer is freed on command timeout without canceling=
 the hardware operation, leading to potential DMA-after-free memory corrupt=
ion.
--

--- Patch [15]: [PATCH net-next v3 15/15] gve: add link status/speed ctrl o=
ps ---
commit 4e6d0e28f03e61bed3005f52fb8ced4997d772eb
Author: Joshua Washington <joshwash@google.com>

gve: add link status/speed ctrl ops
   =20
Refactor link status check to use a control plane op. Introduce
new op for retrieving the link status in AQ mode, and add an op
for retrieving link speed which calls into gve_adminq_report_link_speed.

> diff --git a/drivers/net/ethernet/google/gve/gve_ethtool.c b/drivers/net/=
ethernet/google/gve/gve_ethtool.c
> --- a/drivers/net/ethernet/google/gve/gve_ethtool.c
> +++ b/drivers/net/ethernet/google/gve/gve_ethtool.c
> @@ -749,12 +749,11 @@ static int gve_get_link_ksettings(struct net_device=
 *netdev,
>  	int err =3D 0;
> =20
>  	if (priv->link_speed =3D=3D 0)
> -		err =3D gve_adminq_report_link_speed(priv);
> +		err =3D priv->ctrl_ops->report_link_speed(priv);

[Severity: High]
This isn't a bug introduced by this patch, but I wanted to ask about the
lifecycle of the admin queue here.

When the device is suspended or fails a reset, gve_teardown_device()
is called, which invokes gve_adminq_free(). This frees priv->adminq and
destroys the DMA pool, but leaves the priv->adminq pointer dangling.

If ethtool triggers gve_get_link_ksettings() while the device is in this
state, we unconditionally call report_link_speed(). This results in:

gve_get_link_ksettings()
  priv->ctrl_ops->report_link_speed() (gve_adminq_report_link_speed)
    gve_adminq_execute_cmd()
      gve_adminq_issue_cmd()

In gve_adminq_issue_cmd(), the freed priv->adminq buffer is accessed and
written to without checking gve_get_admin_queue_ok().

Can this lead to a use-after-free if ethtool accesses the link settings
during a failed reset or after device teardown?

[Severity: High]
This is also a pre-existing issue, but while looking at
gve_adminq_report_link_speed() being called here, I noticed a potential
DMA-after-free.

In gve_adminq_report_link_speed(), a temporary buffer is allocated via
dma_alloc_coherent() and its bus address is passed to the NIC. If
gve_adminq_execute_cmd() times out (for example, if
gve_adminq_kick_and_wait() returns -ENOTRECOVERABLE), the function
immediately calls dma_free_coherent() on the error path to free the region.

Since the hardware is not reset or instructed to abort the command before
the memory is freed, what happens if the hardware later wakes up and
executes the delayed command?

Will it DMA the 8-byte link speed into the freed memory, potentially
corrupting whatever structure now occupies that address?

>  	cmd->base.speed =3D priv->link_speed;
> =20
>  	cmd->base.duplex =3D DUPLEX_FULL;
> -
>  	return err;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260803184630.3813=
311-1-hramamurthy@google.com?part=3D15
