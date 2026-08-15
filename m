Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4636B24DFF9
	for <bpf@vger.kernel.org>; Sat, 15 Aug 2026 02:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786760082; cv=none; b=kXHtoyVbur0yj8ukuX9NLBNnJ7EiA1gSHsj601LOCSRd0BqlupQjzmp5ySEJhjQi8U+zraDLHdK9opsIYB80VA0OgRIP8B/PJCHs8PPkvPLM+V9yqVGeAs0acDbTZc+SjM0lObW4QTuy6q6NBAEGdaoeF2mFyKfEm1ONBZnzRbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786760082; c=relaxed/simple;
	bh=027zoHNUO4M584yzExSKqPv4FJrfLXdn4Qrc4uT9lXw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=R1HoGqn4b65+ZNr/VRjJwEVvKwQLxZjwUj+XanObjXoSEG9M3uGu4IRCzHVJuxPrjN22XSM3wwHS4AQPR16ExKbuRHNroUgwF24jYbAKXgl9kgaoyef9Dl1swkfRMNyJD4C20JTwO6zIZ7kBPHCfvGxQrFzvy2j4nNY8wScs7UU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TfMDNxZx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TfMDNxZx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0493D1F00A3D;
	Sat, 15 Aug 2026 02:14:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786760081;
	bh=Z5LWpWkKqK4gnGm1CYlvC6UQwbJ4l79cnktvhT4wutw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TfMDNxZxzZ7dJhiA905Uwm4e+aw9hRvXKCyY85S1FMbsu0Wi72EQxXibXI8yqckah
	 ydIZQBjdjUhKfENpDQHzivl9HeRC6T/HXy7PwGW1yCJ0VCc1VObyX2cl2bq35Zl3UJ
	 Jl7xPbNbliL4pNEpAULRJxIyOXplLcKO+h0RdoS+iZhhvuWSgs56SRM/zPxQYvaGYq
	 EhQ/II6hhg8DAQVm8MEZXLj4jOTuL3zFbFeM69jKGL7nKsWS1hBLnJYVjjRkSvIhV1
	 j6pwiUtGaM1WDHPgFMT2shuKoPmbtcUvFUAHspUqy2vHt8e/itxXoqzaIm3kXmfuK0
	 WDtHtEO1z4N5A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v4 15/15] gve: add link status/speed ctrl ops
Reply-To: sashiko-reviews@lists.linux.dev
To: "Harshitha Ramamurthy" <hramamurthy@google.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260814021406.3044324-16-hramamurthy@google.com>
References: <20260814021406.3044324-1-hramamurthy@google.com>
 <20260814021406.3044324-16-hramamurthy@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 15 Aug 2026 02:14:40 +0000
Message-Id: <20260815021441.0493D1F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] DMA Use-After-Free due to missing device reset on Admin Queue =
command timeout.
--

--- Patch [15]: [PATCH net-next v4 15/15] gve: add link status/speed ctrl o=
ps ---
commit bafe15595d2df2fbd631b0f3f40244e39beaf6e5
Author: Joshua Washington <joshwash@google.com>

gve: add link status/speed ctrl ops

This commit refactors the link status check to use a control plane op and
introduces a new op for retrieving the link status in AQ mode from the devi=
ce
status register. It also adds an op for retrieving link speed in AQ mode wh=
ich
calls into gve_adminq_report_link_speed.

> diff --git a/drivers/net/ethernet/google/gve/gve_ethtool.c b/drivers/net/=
ethernet/google/gve/gve_ethtool.c
> index 8199738ba979e..a3220c6514382 100644
> --- a/drivers/net/ethernet/google/gve/gve_ethtool.c
> +++ b/drivers/net/ethernet/google/gve/gve_ethtool.c

[ ... ]

> @@ -749,12 +749,11 @@ static int gve_get_link_ksettings(struct net_device=
 *netdev,
>  	int err =3D 0;
> =20
>  	if (priv->link_speed =3D=3D 0)
> -		err =3D gve_adminq_report_link_speed(priv);
> +		err =3D priv->ctrl_ops->report_link_speed(priv);

[Severity: Critical]
This isn't a bug introduced by this patch, but while reviewing the use of
the report_link_speed control operation, I noticed a pre-existing
regression when handling Admin Queue timeouts.

Could the underlying gve_adminq_report_link_speed() function corrupt memory
if the device responds late?

In drivers/net/ethernet/google/gve/gve_adminq.c,
gve_adminq_report_link_speed() unconditionally frees the DMA region:

    err =3D gve_adminq_execute_cmd(priv, &gvnic_cmd);

    priv->link_speed =3D be64_to_cpu(*link_speed_region);
    dma_free_coherent(&priv->pdev->dev, sizeof(*link_speed_region),
                      link_speed_region, link_speed_region_bus);

If the hardware is delayed and gve_adminq_execute_cmd() returns a timeout,
the DMA memory is freed without synchronously resetting or quiescing the
device.

If the hardware later completes the command, could it write the link speed
into the now-freed DMA address and corrupt newly allocated memory?

A similar unconditional free after timeout happens in
gve_adminq_execute_extended_cmd():

    err =3D gve_adminq_execute_cmd(priv, &cmd);

    dma_free_coherent(&priv->pdev->dev, cmd_size, inner_cmd, inner_cmd_bus);

Since an unprivileged user can trigger this path via ethtool, does the
hardware need to be reset before freeing these DMA buffers, or should the
buffers be leaked until a reset is guaranteed?

> =20
>  	cmd->base.speed =3D priv->link_speed;
> =20
>  	cmd->base.duplex =3D DUPLEX_FULL;
> -
>  	return err;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260814021406.3044=
324-1-hramamurthy@google.com?part=3D15
