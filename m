Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D60DDDA9
	for <bpf@vger.kernel.org>; Sat, 15 Aug 2026 02:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786760077; cv=none; b=iyKMxcOa2NPvQn9VQQ3zRruZ7fzNz7AmfElxuQiPAceLhGuFxe4PzNR4DaO4PS9BsvhjmEsc+Ad5ql+MubD2Icr5hoduD6UF4JimshdUN3GXjb/fLmzlrXGrSHAVViBSAmkN5I8Vl+4OGFFRNI6Rtrgxfe99O9An37BCbdS6Qp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786760077; c=relaxed/simple;
	bh=AQ08T5wVsEBJdwDImVBc4YYmVQolQgQZHQP7ZpjnXGg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=XK1yeNcwxo8Cyt4X4UW4D2gDNT/NBSQM0Ag6z5zUvLYiQsFdnQkCSA/8L/f5jNiD6qtsrCyIA5L2Nm49yfGFh+4CfrN3FEuqqBJf5Dyqjt4x94auRJzIhrkSW0aurxDPH1DbEDphoBncTn4/1xiYipdh1vYPbIqktGC0Yv9dSL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XbsT18N5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XbsT18N5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85BC01F000E9;
	Sat, 15 Aug 2026 02:14:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786760075;
	bh=a51x79Z3ygZGR7Rn7UG4JfkHYJ4tVYHqpff/Zy+PNsA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XbsT18N5pfy2XctudFSWbZh1tkDriqefkajILQw9ULZJCN0oSOdbSJ1AUcKxJJNmg
	 dGHcOm4mRhNkpjdF+rXTEZBJWJOKGnNDWlIRdxxKOfHxaFdnJsL2AGmdfY2GXdpaPQ
	 OOn+x6HtKnAijIV9WwPh7pbcEkeRJTKTf7ItMFnJd2zzS4aOvZAfGl/Y3dE/JxKmf1
	 7nEqdRYrJZFPTf/iKZ5c3gEAXQZSFRp3XP8y1eelHdITUtQsNt5wzfyXwjktB0k81q
	 i9OveH3q0e34cbevDmCqMOLV/cbSEmyuVQuRELMepoWqYWZIjfZfkiRzfxopbQfmQt
	 dH6Kl70giT9BA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v4 01/15] gve: don't pass in unused parameter
 to gve_adminq_free
Reply-To: sashiko-reviews@lists.linux.dev
To: "Harshitha Ramamurthy" <hramamurthy@google.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260814021406.3044324-2-hramamurthy@google.com>
References: <20260814021406.3044324-1-hramamurthy@google.com>
 <20260814021406.3044324-2-hramamurthy@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 15 Aug 2026 02:14:35 +0000
Message-Id: <20260815021435.85BC01F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Workqueue is destroyed after freeing resources in gve_remove, lead=
ing to resource leaks and UAF if a reset is pending.
- [High] Hardware device resources are not deconfigured before DMA memory i=
s freed in the gve_setup_device_resources error path.
--

--- Patch [1]: [PATCH net-next v4 01/15] gve: don't pass in unused paramete=
r to gve_adminq_free ---
commit 9a4a2e123b2090a5f84279c50fa3476f0a484a87
Author: Harshitha Ramamurthy <hramamurthy@google.com>

gve: don't pass in unused parameter to gve_adminq_free
   =20
Clean up gve_adminq_free to not take in an unused parameter.

> diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/eth=
ernet/google/gve/gve_main.c
> index e4d78ae52dafe..30bf6df4ebc58 100644
> --- a/drivers/net/ethernet/google/gve/gve_main.c
> +++ b/drivers/net/ethernet/google/gve/gve_main.c
> @@ -2506,14 +2506,14 @@ static int gve_init_priv(struct gve_priv *priv, b=
ool skip_describe_device)
>  	bitmap_free(priv->xsk_pools);
>  	priv->xsk_pools =3D NULL;
>  err:
> -	gve_adminq_free(&priv->pdev->dev, priv);
> +	gve_adminq_free(priv);
>  	return err;
>  }

[Severity: High]
This is a pre-existing issue, but does the error path in
gve_setup_device_resources() leave hardware configured with freed DMA
addresses?

If an initialization step fails after configuring the hardware, the error p=
ath
frees the DMA memory without deconfiguring or resetting the hardware:

drivers/net/ethernet/google/gve/gve_main.c:gve_setup_device_resources() {
    ...
    err =3D gve_adminq_configure_device_resources(...);
    ...
abort_with_ntfy_blocks:
	gve_free_notify_blocks(priv);
abort_with_counter:
	gve_free_counter_array(priv);
    ...
}

Can this allow the hardware to asynchronously write to the freed DMA addres=
ses
until it is finally reset later by the gve_adminq_free() call in
gve_init_priv(), causing a use-after-free?

>  static void gve_teardown_priv_resources(struct gve_priv *priv)
>  {
>  	gve_teardown_device_resources(priv);
> -	gve_adminq_free(&priv->pdev->dev, priv);
> +	gve_adminq_free(priv);
>  	bitmap_free(priv->xsk_pools);
>  	priv->xsk_pools =3D NULL;
>  }

[Severity: High]
This is a pre-existing issue, but can the sequence in gve_remove() lead to a
resource leak and use-after-free if a reset is pending?

In gve_remove(), teardown is performed before the workqueue is destroyed, a=
nd
the service task is not cancelled:

drivers/net/ethernet/google/gve/gve_main.c:gve_remove() {
    ...
	gve_teardown_priv_resources(priv);
	destroy_workqueue(priv->gve_wq);
	free_netdev(netdev);
    ...
}

If a device reset is requested or handled by gve_service_task() concurrently
with module removal:

1. unregister_netdev() drops the rtnl_lock.
2. The pending gve_service_task() acquires the lock and allocates new device
   resources during reset recovery.
3. Concurrently, gve_remove() calls gve_teardown_priv_resources() without
   rtnl_lock, racing with the reset teardown/recovery.
4. destroy_workqueue() waits for the service task to complete.
5. gve_remove() calls free_netdev().

Are the newly allocated resources from the reset recovery leaked, leaving t=
he
hardware active to DMA into freed structures?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260814021406.3044=
324-1-hramamurthy@google.com?part=3D1
