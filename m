Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD6E4351C1E;
	Mon, 28 Sep 2026 00:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790553704; cv=none; b=pM9QBuo/F83xoLluh/JcVvH3J3I+RosVDpcmjIVZRYtwxWa28t+8HvExHUj4JocKuKSFQpVijrpF2l3IomuUw0foysth3swIS+RwZsC7bkFs+PfhRExITeFQdQ3m9OWxK8EliJxitaMlXull6r1fasgwPsPiCqbFdB8dSgmkqpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790553704; c=relaxed/simple;
	bh=dWbF6oP+2D/rP/sG/G3T0/li1T69/60Pq6TWB/+JUCU=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=S8M5bi9d/zCCg/wg1jwXcRa5PaoQVB3ExcLTmS6ebGp9jrEGZE0OnSZGJJJ2UFQK+lZ6a0V6lFrqaKNGGyDq+V0YfMh66SNBVV0RFnbd/QNmWJ2HjKskjF/ziNgUlgSjtnaGzMbrGIBDads12NsKlY8wEizoQQKGZuG/6iWuLDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QBRNBuf9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QBRNBuf9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 401071F00893;
	Mon, 28 Sep 2026 00:01:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790553700;
	bh=7diu9kj64t0BSHjaUwyvl3zx64ACF9IDLTJRdrgGsiY=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=QBRNBuf9Kx1iNPhH4tYM0ntuP5mgsUl3CoyUuEI3dwlcD2bW1IZcKCpNmYbyFBiVJ
	 5wg6mJv+wayTNPp1DIoZoFAPpogkJCTHVVmRYPx7xIRkIUeBTDwO0odQzeWHlgdsM9
	 kG94x7r9y0RGBrw9oV67F9/vviIrvckS9Wh72DCD7QizAO1WkZbmYzKvS9wCCGypAf
	 CinFQbSPP/Pe9kfKdcGxi3XPopDGbuO6XXwY/c6ZS6LeYh5zdQbWmS95r9i2fVSWPV
	 plnxY5EA/HpEc3onvlWFql/yJPYd3Da6SCwbMF9y71m4C6ijisxfhJXFnwJy0cHVgR
	 IhPRkVYW7fKeA==
Subject:
 Re: [PATCH net-next v2 2/8] eth: mpnic: add register init for the device
From: netdev-bot+sashiko@kernel.org
To: daniel.zahka@gmail.com
Cc: alexanderduyck@fb.com, kuba@kernel.org, kernel-team@meta.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
 john.fastabend@gmail.com, sdf@fomichev.me, dimitri.daskalakis1@gmail.com,
 mohsin.bashr@gmail.com, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 bpf@vger.kernel.org
Date: Mon, 28 Sep 2026 00:01:38 +0000
Message-ID: <179055369885.3145.4992800467382356655@kernel.org>
In-Reply-To: <20260924-linux-mpnic-v2-2-4badc9b58b9e@gmail.com>
References: <20260924-linux-mpnic-v2-2-4badc9b58b9e@gmail.com>
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

- [Low] mpnic_dev_init() writes BAR0 CSRs up to MPNIC_OB_ATTR_RDE_P
  (dword 0x9a001a, byte 0x2680068 + 8, about 38.5 MiB into BAR0), and…

--

eth: mpnic: add register init for the device

This commit adds one-time CSR initialization to mpnic_probe() through a
new mpnic_dev_init() in mpnic_init.c. The new code sets static TXB, RXB,
TQS, AXI and relaxed-ordering configuration. It also starts SRAM zeroing
on several blocks and polls until that finishes.

> diff --git a/drivers/net/ethernet/meta/mpnic/mpnic_pci.c b/drivers/net/ethernet/meta/mpnic/mpnic_pci.c
> index 96393e7812418..68a64377e6c5a 100644
> --- a/drivers/net/ethernet/meta/mpnic/mpnic_pci.c
> +++ b/drivers/net/ethernet/meta/mpnic/mpnic_pci.c

[ ... ]

> @@ -108,6 +112,10 @@ static int mpnic_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
>  	pci_set_master(pdev);
>  	pci_save_state(pdev);
>  
> +	err = mpnic_dev_init(mpd);
> +	if (err)
> +		goto err_free_mpd;
> +

[Severity: Low]
Should mpnic_probe() check the size of BAR0 before mpnic_dev_init() runs?

mpnic_probe() maps BAR0 with pcim_iomap_region() but never compares
pci_resource_len(pdev, 0) with the highest CSR offset the driver uses.
Neither mpnic_wr64() nor mpnic_rd64() puts an upper limit on reg:

    if (csr)
        writeq(val, csr + reg);

The highest register mpnic_dev_init() writes is MPNIC_OB_ATTR_RDE_P, from
mpnic_ro_init(). Its byte offset is 0x2680068, about 38.5 MiB into BAR0.
mpnic_desc_sram_init() also issues 4096 writeq() calls at offsets
computed from the loop index:

    for (i = 0; i < MPNIC_MAX_TXQS * 2; i++)
        mpnic_wr64(mpd, MPNIC_TDF_DESC_CFG(i), ...);

A device that matches the PCI ID but reports a smaller BAR0 would make
these accesses land outside the ioremap'd region during probe.

The PCI core normally trusts BAR sizes reported by the device, and fbnic
maps its BARs without a length check too. So this would be defensive
hardening rather than a fix for a known failure. Would a check against
the largest CSR offset in mpnic_probe() be worth adding?

>  	return 0;
>  
>  err_free_mpd:

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260924-linux-mpnic-v2-0-4badc9b58b9e%40gmail.com
