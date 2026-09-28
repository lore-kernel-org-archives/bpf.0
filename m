Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0A753B1EEF;
	Mon, 28 Sep 2026 00:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790553706; cv=none; b=N2BM6rSE+IMzpCtXMRAf6EnBD9NLH5X/6fnkTVFGC6pf3Zubfg/pp4NWGNYC+3GnGH7oC54yvo4FV/a0n7CkICTpncFnGepLHCfSB45cre0JdmyM3omxjvlzs00AiMxf3Ag+sDwj+mJwm14BXD0ZIeI4fDszkQGBFkrdCUYWaEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790553706; c=relaxed/simple;
	bh=0Wu46LZd/S6aBQjWWEuOJcLcCG6ax3IEiv2AYF/9S/Y=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WE1tQbZz9kdxqLixJfp/w8tBEnuzhlIfUIFFIYdoQgxtaRLpfxkHFmbV03F64h6IYGohO5+ZwBQFhan01CQBow0Eh41/e0HKoXU72vPnlFPxLOSzvx7ePqDCA8EfAc7fhiJ9uFRnMO9F8fvX0xpg4g36JKAGqG/5nj19kkWV1qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TSSCFrVR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TSSCFrVR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B604C1F00898;
	Mon, 28 Sep 2026 00:01:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790553701;
	bh=UMU4Ti/Az2TBlyVkYvUgq1zKOL+XERG4tXtmgpgDKUA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=TSSCFrVRBVt+k/4Fkgf1rXJioXmfFYIZHwmzzAr5FW+9RM7IcOE6e9+pkkiURaw/X
	 BB1NYfCjRCv1niveup2U84O6M4k5TNXVMQ/arlgqTMzMQjGQIVgD1CUf7ni7N5euAR
	 bzUm9m1MtJbJcPAnNCLxgk9Dd+txerx71EUbZjeFq1UDmKaCpC1OXA/DUEjU3bV6c/
	 B2QbsCq9VKLg1CcvSfzFftFbEqaawZIcPka+ab6iuXc4szZV3rU6PtMPSKFoBE92pa
	 Hxi2G9PgZ601YGiOOXHuC7LqvGvAwDxpa82TH3YmHEH1Ck1PuVv86gAtW0lAzC1sp6
	 ICDMRi6I1ra3A==
Subject: Re: [PATCH net-next v2 3/8] eth: mpnic: allocate MSI-X vectors
From: netdev-bot+sashiko@kernel.org
To: daniel.zahka@gmail.com
Cc: alexanderduyck@fb.com, kuba@kernel.org, kernel-team@meta.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
 john.fastabend@gmail.com, sdf@fomichev.me, dimitri.daskalakis1@gmail.com,
 mohsin.bashr@gmail.com, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 bpf@vger.kernel.org
Date: Mon, 28 Sep 2026 00:01:40 +0000
Message-ID: <179055370029.3145.13976204260796634034@kernel.org>
In-Reply-To: <20260924-linux-mpnic-v2-3-4badc9b58b9e@gmail.com>
References: <20260924-linux-mpnic-v2-3-4badc9b58b9e@gmail.com>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] The driver frees its MSI-X vectors both by hand and through
  devres.

--

eth: mpnic: allocate MSI-X vectors

This commit adds mpnic_irq.c, which allocates one MSI-X vector for FW
interrupts and one vector per online CPU for the completion queues. The
allocation happens in mpnic_probe(). The vectors are freed on the probe
error path and in mpnic_remove().

> diff --git a/drivers/net/ethernet/meta/mpnic/mpnic_irq.c b/drivers/net/ethernet/meta/mpnic/mpnic_irq.c
> new file mode 100644
> index 0000000000000..bcc33655cbbea
> --- /dev/null
> +++ b/drivers/net/ethernet/meta/mpnic/mpnic_irq.c

[ ... ]

> +void mpnic_free_irqs(struct mpnic_dev *mpd)
> +{
> +	struct pci_dev *pdev = to_pci_dev(mpd->dev);
> +
> +	mpd->num_irqs = 0;
> +	pci_free_irq_vectors(pdev);
> +}

[Severity: Low]
Is it safe to call pci_free_irq_vectors() here when mpnic_probe() enables
the device with pcim_enable_device()?

pcim_enable_device() sets pdev->is_managed. Because of that,
pci_alloc_irq_vectors() in mpnic_alloc_irqs() ends up in
pcim_setup_msi_release():

drivers/pci/msi/msi.c:pcim_setup_msi_release() {
    ...
	if (!pci_is_managed(dev) || dev->is_msi_managed)
		return 0;

	ret = devm_add_action(&dev->dev, pcim_msi_release, dev);
    ...
}

The kernel-doc for pci_free_irq_vectors() says not to do this:

 * WARNING: Do not call this function if the device has been enabled
 * with pcim_enable_device(). In that case, IRQ vectors are automatically
 * managed via pcim_msi_release() and calling pci_free_irq_vectors() can
 * lead to double-free issues.

With this patch, both the err_free_irqs path in mpnic_probe() and
mpnic_remove() call mpnic_free_irqs()->pci_free_irq_vectors(). Devres
then runs pcim_msi_release()->pci_free_irq_vectors() a second time.

Today the second call does nothing, because pci_disable_msix() returns
early when !dev->msix_enabled. That makes it an internal guard, though,
not part of the API contract. The TODO in pcim_setup_msi_release() also
says the implicit managed mode is slated for removal.

The pattern is still present at the end of the series.

Could the driver pick one owner for the vectors? It could drop the manual
pci_free_irq_vectors() and let devres free them. Or it could stop relying
on the implicit managed mode, so the explicit free is the only one.

> +
> +int mpnic_alloc_irqs(struct mpnic_dev *mpd)
> +{

[ ... ]

> diff --git a/drivers/net/ethernet/meta/mpnic/mpnic_pci.c b/drivers/net/ethernet/meta/mpnic/mpnic_pci.c
> index 68a64377e6c5a..127b71b44b0fb 100644
> --- a/drivers/net/ethernet/meta/mpnic/mpnic_pci.c
> +++ b/drivers/net/ethernet/meta/mpnic/mpnic_pci.c
> @@ -112,12 +112,18 @@ static int mpnic_probe(struct pci_dev *pdev, const struct pci_device_id *ent)

[ ... ]

> +err_free_irqs:
> +	mpnic_free_irqs(mpd);
>  err_free_mpd:
>  	kfree(mpd);
>  
> @@ -132,6 +138,7 @@ static void mpnic_remove(struct pci_dev *pdev)
>  {
>  	struct mpnic_dev *mpd = pci_get_drvdata(pdev);
>  
> +	mpnic_free_irqs(mpd);
>  	kfree(mpd);
>  }

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260924-linux-mpnic-v2-0-4badc9b58b9e%40gmail.com
