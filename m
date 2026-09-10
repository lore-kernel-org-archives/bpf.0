Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD209595732
	for <bpf@vger.kernel.org>; Thu, 10 Sep 2026 19:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789067520; cv=none; b=avl0h2m3EawkL4PttkBwMM+SFYANo3PPogqCrMpS4/8yuxJQCsikd0Yc2uR5UuEBiwyad6xlIZp1L27HxB/Kug/jnZ1/i6dxh1yN3xS7I6QhMsR0stFs9+XQR04Yg+dm2N/UrhSmJqcnEjIFow/3CABXw9/513Fr3xMwlz1BE7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789067520; c=relaxed/simple;
	bh=s8XQqwCuZAJnWmuPiYLduJYb7gN6gbr3eLfGW626nCA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=nfNXGK8dvDXnU+2AXXvTIS8G+mvN4oEC5InQgLdQsPyFs6h1kepJw6B06ByxHX8VPLQBrOzYbB07tVwhv0TSWhIeop//W5bdJ62QDqDZctcyZRTePrBO7gOCCJxpadv6KMQTs+Jf+oEbSgrQsQc3UjOeFMdltAn1Xr7Jd3y9r4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PMtL/gL5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PMtL/gL5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 715221F000FF;
	Thu, 10 Sep 2026 19:11:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789067518;
	bh=3Dm6YuJeeQhOsxtaAr/OgQRYgT7uk6NNVnyMZ6GEW3c=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PMtL/gL5HHj8PqiO6UUraJzr8nf+QNye+pdSsqvniwMIhsYKmuVIyaNxH5NJSK1sE
	 hQ3lP9AqPiTdAk+Q4PLjgWClkwneJ3loV0EjB5NVpNcHiTkPlOgAEM3MLMz3XsFoKr
	 dwT71XEO28VgfcByQEYb1gf9rFYxc66US2mqcwVV0u9glroNGdzhGmlfSwRF4O1JP1
	 RciDM3dWie94e4rZXiH1baDiQobyJ16ktvaQw05hzqPHskyg2Fpes7VDwb27/ORdMP
	 sGjimrCOwtjlKk9w6fjf/OTfI1oFmuRPNTTEz/248d4YR+QVpxT6TiWwVou+EymzMm
	 r4Qg9okRRoIig==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v6 12/12] gve: add link status/speed ctrl ops
Reply-To: sashiko-reviews@lists.linux.dev
To: "Harshitha Ramamurthy" <hramamurthy@google.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260909191136.3811892-13-hramamurthy@google.com>
References: <20260909191136.3811892-1-hramamurthy@google.com>
 <20260909191136.3811892-13-hramamurthy@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 10 Sep 2026 19:11:58 +0000
Message-Id: <20260910191158.715221F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] AdminQ commands that allocate a DMA buffer, send it to the dev=
ice, and free it on timeout create a DMA-after-free vulnerability.
--

commit e2461d13b564589c9ca69a35d656bc9e72b3ea2b
Author: Joshua Washington <joshwash@google.com>

gve: add link status/speed ctrl ops

This commit refactors the link status check to use a control plane operatio=
n.
It introduces new operations for retrieving the link status and speed in AQ
mode, reading from the device status register.

> diff --git a/drivers/net/ethernet/google/gve/gve_ethtool.c b/drivers/net/=
ethernet/google/gve/gve_ethtool.c
> index dd1c44fedc771..a3220c6514382 100644
> --- a/drivers/net/ethernet/google/gve/gve_ethtool.c
> +++ b/drivers/net/ethernet/google/gve/gve_ethtool.c
> @@ -749,12 +749,11 @@ static int gve_get_link_ksettings(struct net_device=
 *netdev,
>  	int err =3D 0;
> =20
>  	if (priv->link_speed =3D=3D 0)
> -		err =3D gve_adminq_report_link_speed(priv);
> +		err =3D priv->ctrl_ops->report_link_speed(priv);

[Severity: Critical]
This is a pre-existing issue, but does gve_adminq_report_link_speed() have a
DMA-after-free vulnerability when the AdminQ command times out?

Looking at the underlying implementation in gve_adminq_report_link_speed() =
in
drivers/net/ethernet/google/gve/gve_adminq.c:

    err =3D gve_adminq_execute_cmd(priv, &gvnic_cmd);

    priv->link_speed =3D be64_to_cpu(*link_speed_region);
    dma_free_coherent(&priv->pdev->dev, sizeof(*link_speed_region),
                      link_speed_region, link_speed_region_bus);
    return err;

If the hardware fails to respond within the loop in gve_adminq_wait_for_cmd=
(),
gve_adminq_execute_cmd() returns -ENOTRECOVERABLE. The driver then
unconditionally calls dma_free_coherent() on the link_speed_region buffer
while the hardware might still be processing the request.

If the hardware is merely slow and completes the operation after the driver=
's
timeout, it will perform a DMA write to the freed IOVA. This IOVA may have
been reallocated by the kernel for other purposes, leading to memory
corruption.

A similar pattern appears to exist in gve_adminq_execute_extended_cmd() whe=
re
the inner_cmd DMA buffer is unconditionally freed on failure:

    err =3D gve_adminq_execute_cmd(priv, &cmd);

    dma_free_coherent(&priv->pdev->dev, cmd_size, inner_cmd, inner_cmd_bus);
    return err;

Could this memory corruption be triggered by local users querying link
settings via ethtool if the vNIC is temporarily unresponsive?

> =20
>  	cmd->base.speed =3D priv->link_speed;
> =20
>  	cmd->base.duplex =3D DUPLEX_FULL;
> -
>  	return err;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260909191136.3811=
892-1-hramamurthy@google.com?part=3D12
