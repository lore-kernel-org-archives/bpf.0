Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CB1430569A
	for <bpf@vger.kernel.org>; Sat, 15 Aug 2026 02:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786760080; cv=none; b=VsqzWZJxMeD2kbodeF4digedxRZBFDNDVRlKGb+V4NKuk/UBMk42/ByZdu1QrKEwFbbpfXLhIJdq9p3QVgOIDZTyGeYss/Hm7OeVYqK8CGPCq+k/xvCtsnkqBsZhxt2wCi6XZ1TpmDYUJrnjMVf9XrsSlwwGcAsCPMv+xSVwsYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786760080; c=relaxed/simple;
	bh=b5D6UV4AlDWhoaYVpxbJ3HAyl0nrnigSdNOCjeO88bE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=LAyi4L9V3Yk8Uvx2ryrWdutR8XF6vJaTGl8rDuM3DxC3ZcIqRoTrfoJIfpOvTNv8QKjsUEoaeKnXr4VikS1n+kCCt3jxFCXSatLY5yF7kCROEaq+SHj4BEuIxdomy7/OVQ0RNYPN5WWFuqzGL14xuZeVOvqwPj/GwrLpbFmfTVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ODw5Ixc4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ODw5Ixc4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFF7D1F00A3D;
	Sat, 15 Aug 2026 02:14:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786760079;
	bh=tm7H+OO+xm+OmXheK9mAOQANmrtTCZXjiDC/nsD2BbA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ODw5Ixc47l09H8Iz5WsSWig49aZmBpuQj7BBG9gcNeA1zAPVxV/4A07UwZLzXKfYH
	 OfiNrHsZ5FAwPHLr5htARigsJ6zGO+PB61d1CIHjnedR6USyDR4bjhAt8TI/Pn84sR
	 EiePwu84uaE3nIWgo4uEESsnllevjjbLHjBnEoTZdAVu1LtPZwOfrrBHxUhN/11zAT
	 3Osj06qLfI//TcGmN4tucg7JOj7r68rUuBViuI8Sh4uv99fL1r27tTvwjyhNZxefgv
	 Ewk4+Tiplb/b28NrzSWyzC+I3zxjFQ9VTcoJes3Q7RGSszO88812UEmydETcodBgn1
	 I8eMxFudvRhoQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v4 05/15] gve: introduce control plane
 operations structure
Reply-To: sashiko-reviews@lists.linux.dev
To: "Harshitha Ramamurthy" <hramamurthy@google.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260814021406.3044324-6-hramamurthy@google.com>
References: <20260814021406.3044324-1-hramamurthy@google.com>
 <20260814021406.3044324-6-hramamurthy@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 15 Aug 2026 02:14:38 +0000
Message-Id: <20260815021438.EFF7D1F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Workqueue flushed after private resources are freed, leading to me=
mory leaks and Use-After-Free.
--

--- Patch [5]: [PATCH net-next v4 05/15] gve: introduce control plane opera=
tions structure ---
commit 21d462ce52db670852717f6c821149b6dd730ea9
Author: Harshitha Ramamurthy <hramamurthy@google.com>

gve: introduce control plane operations structure

To abstract out the difference in implementation of control plane operations
between the existing Adminq ABI and the upcoming Mailbox ABI, introduce a n=
ew
gve_ctrl_ops structure which will contain the basic operations.

> diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/eth=
ernet/google/gve/gve_main.c
> --- a/drivers/net/ethernet/google/gve/gve_main.c
> +++ b/drivers/net/ethernet/google/gve/gve_main.c
[ ... ]
> @@ -3000,14 +3005,13 @@ static void gve_remove(struct pci_dev *pdev)
>  {
>  	struct net_device *netdev =3D pci_get_drvdata(pdev);
>  	struct gve_priv *priv =3D netdev_priv(netdev);
> -	__be32 __iomem *db_bar =3D priv->db_bar2;
>  	void __iomem *reg_bar =3D priv->reg_bar0;
> =20
>  	unregister_netdev(netdev);
>  	gve_teardown_priv_resources(priv);
>  	destroy_workqueue(priv->gve_wq);
> +	priv->ctrl_ops->unmap_db_bar(priv);
>  	free_netdev(netdev);
> -	pci_iounmap(pdev, db_bar);
>  	pci_iounmap(pdev, reg_bar);
>  	pci_release_regions(pdev);
>  	pci_disable_device(pdev);

[Severity: High]
This is a pre-existing issue, but is it possible that tearing down private
resources before destroying the workqueue causes memory leaks and a use
after free?

If a service task is pending during gve_remove() and a reset was requested
via management IRQ, destroy_workqueue() will flush and execute it.=20

The service task executes gve_reset() which can re-allocate resources and
re-register MSI-X interrupts.

Since gve_teardown_priv_resources() has already run, these newly allocated
resources won't be torn down before free_netdev() frees the priv pointer.

If the active MSI-X interrupt fires afterwards, would the interrupt handler
end up accessing the freed priv pointer?

It looks like this same ordering issue also exists in the probe error
handling path.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260814021406.3044=
324-1-hramamurthy@google.com?part=3D5
