Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B565A314A6F;
	Thu, 24 Sep 2026 02:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790215536; cv=none; b=ZOG/GEtRwdMWyhJqmXWohlec3EvV7SB+vo95Jqzh0oPkO50TxutOkIBdnfr2ONTcMonFTzFMRT7NyZNCeqBdH3S9Bmi86k2yfpa+4MIuKo/jW2LGaGyY0VZyAMwUE1Oe9RhXWVsOmp9W3t0kkYk55O6nlxI7ZXfuEdVxyiCbTC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790215536; c=relaxed/simple;
	bh=LSTmqoAPgDEphguCxDzuLrV4z7S59cRXqgno2ecaTQo=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HkseeYOiS1V86VbFErWzq1HcMv4zmJmzUvrq0t77D7QEq+Vx8IBt8oIPOOTM6mUUHBJqycBoho2up7/P7aIiSZ7LpnLT3TGHYXoGMeO144oKHOc/8PPuiv9cmAkSH8ZPfH3n7jrKyYX0NlpWJrEgmIK5FFidTTKKWaI5eZQpxOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ScmCMjVe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ScmCMjVe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63A681F000FF;
	Thu, 24 Sep 2026 02:05:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790215534;
	bh=noqM9s6yQpmsxRTZLEMpl+Qp1hAhVjiVnUkBsZRmBjA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=ScmCMjVe35rzpKFAEvuy3GSmQ6ZgZwCXCFBW2xA+8XoUBfpxdu6cHZ/W39cYeS5ek
	 FD3AZ5AxTj3b4CL7p7gcReoC2AYHGNmdJFW96CNBUHuUcdW8JS35dcieLzlr+3g/5R
	 On2jwjWJTvMRCRXjBqemwWp3HpcUDhIKa4FBzCsS7EBrqajuuuh05f0uyqcJqQxcgQ
	 LmGHX3ysN5iHROYBDXnuZi3qcflW8zDAJNj7VyDz0u/091PMLTKTJI8qA7CmulDeSN
	 lQ1NMg1FCKWLdmSDUxUXJcKATJyHBvmVrfzYTEBH1vupmmbzFCQDwet9+pxo6hQPKR
	 RoXfE+1Em+pQQ==
Subject: Re: [PATCH net-next 2/8] eth: mpnic: add register init for the device
From: netdev-bot+sashiko@kernel.org
To: daniel.zahka@gmail.com
Cc: alexanderduyck@fb.com, kuba@kernel.org, kernel-team@meta.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
 john.fastabend@gmail.com, sdf@fomichev.me, dimitri.daskalakis1@gmail.com,
 mohsin.bashr@gmail.com, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 bpf@vger.kernel.org
Date: Thu, 24 Sep 2026 02:05:32 +0000
Message-ID: <179021553292.2160803.15849497453510759239@kernel.org>
In-Reply-To: <20260922-linux-mpnic-v1-2-236844f53072@gmail.com>
References: <20260922-linux-mpnic-v1-2-236844f53072@gmail.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] pci: missing pci_resource_len() check in mpnic_probe() allows
  OOB MMIO access
- [Medium] The 1 MiB Tx buffer is split between MAC and BMC differently
  in TXB and in TQS.

--

eth: mpnic: add register init for the device

This commit adds one-time CSR initialization to mpnic_probe() through a
new mpnic_dev_init(). It programs the TXB, RXB, TQS, descriptor SRAM,
AXI and relaxed ordering settings, starts the on-chip SRAM
initializations and polls until they complete.

> diff --git a/drivers/net/ethernet/meta/mpnic/mpnic_init.c b/drivers/net/ethernet/meta/mpnic/mpnic_init.c
> new file mode 100644
> index 0000000000000..f8ebb19766731
> --- /dev/null
> +++ b/drivers/net/ethernet/meta/mpnic/mpnic_init.c
> @@ -0,0 +1,553 @@

[ ... ]

> +/* A total of 1 MiB worth of Tx credits is available, in units of 128 B.
> + * The BMC gets a guaranteed share of them whether or not the host is
> + * routing anything its way, everything else goes to MAC TC0.
> + */
> +#define MPNIC_TXB_BMC_PVT_CRDT_INIT_VAL		800
> +#define MPNIC_TXB_P0_MAC_PVT_CRDT_INIT_VAL	\
> +	(SZ_1M / 128 - 2 * MPNIC_TXB_BMC_PVT_CRDT_INIT_VAL)

[ ... ]

> +/* The 1 MiB Tx buffer is partitioned between the MAC and the BMC in units
> + * of 1 KiB. The BMC portion is fixed at 100 KB.
> + */
> +#define MPNIC_TQS_GLBL_TXB_CRDT_BMC	100
> +#define MPNIC_TQS_GLBL_TXB_CRDT_MAC	(SZ_1M / SZ_1K - \
> +					 MPNIC_TQS_GLBL_TXB_CRDT_BMC)

[ ... ]

> +static void mpnic_txb_init(struct mpnic_dev *mpd)
> +{
> +	int i;
> +
> +	mpnic_wr64(mpd, MPNIC_TXB_BMC, MPNIC_TXB_BMC_PVT_CRDT_INIT_VAL);
> +
> +	/* Zero the private credits of every traffic class, then hand the
> +	 * unreserved ones to MAC TC0.
> +	 */
> +	for (i = 0; i < MPNIC_TXB_P0_CNT; i++)
> +		mpnic_wr64(mpd, MPNIC_TXB_P0(i), 0);
> +	mpnic_wr64(mpd, MPNIC_TXB_P0(MPNIC_TXB_TC_IDX_MAC_0),
> +		   MPNIC_TXB_P0_MAC_PVT_CRDT_INIT_VAL);
> +	mpnic_wr64(mpd, MPNIC_TXB_P0(MPNIC_TXB_TC_IDX_BMC),
> +		   MPNIC_TXB_BMC_PVT_CRDT_INIT_VAL);

[ ... ]

> +static void mpnic_tqs_init(struct mpnic_dev *mpd)
> +{

[ ... ]

> +	/* Only port 0 is used. A single traffic class is in use as well, so
> +	 * give all of the Tx buffer credits to TC0.
> +	 */
> +	mpnic_wr64(mpd, MPNIC_TQS_GLBL_P0_0,
> +		   FIELD_PREP(MPNIC_TQS_GLBL_P0_0_TXB_MAX_CRDTS_0,
> +			      MPNIC_TQS_GLBL_TXB_CRDT_MAC));
> +	mpnic_wr64(mpd, MPNIC_TQS_GLBL_P0_1, 0);
> +	mpnic_wr64(mpd, MPNIC_TQS_GLBL_BMC,
> +		   FIELD_PREP(MPNIC_TQS_GLBL_BMC_TXB_MAX_CRDTS,
> +			      MPNIC_TQS_GLBL_TXB_CRDT_BMC));

[Severity: Medium]
Do TXB and TQS split the 1 MiB Tx buffer the same way?

On the TXB side, mpnic_txb_init() writes MPNIC_TXB_BMC_PVT_CRDT_INIT_VAL
(800 x 128 B = 100 KiB) to both MPNIC_TXB_BMC and
MPNIC_TXB_P0(MPNIC_TXB_TC_IDX_BMC). MAC TC0 then gets:

  SZ_1M / 128 - 2 * 800 = 6592 credits = 824 KiB

On the TQS side, mpnic_tqs_init() programs
MPNIC_TQS_GLBL_P0_0_TXB_MAX_CRDTS_0 with:

  SZ_1M / SZ_1K - 100 = 924 (1 KiB units) = 924 KiB

That lets the scheduler use 100 KiB more for TC0 than TXB reserved as
TC0 private credit.

Suppose TXB_MAX_CRDTS limits how much data the scheduler can have
outstanding in the TC0 TXB pool. Could a Tx burst that fills TC0 then
overrun the pool once the Tx datapath is running?

If the BMC only needs a single 100 KiB share, as the TQS comment says,
does the "2 *" in MPNIC_TXB_P0_MAC_PVT_CRDT_INIT_VAL leave 100 KiB of Tx
buffer unused?

The TXB comment says "everything else goes to MAC TC0", but the code
subtracts the BMC share twice, so the two don't match either.

[ ... ]

> diff --git a/drivers/net/ethernet/meta/mpnic/mpnic_pci.c b/drivers/net/ethernet/meta/mpnic/mpnic_pci.c
> --- a/drivers/net/ethernet/meta/mpnic/mpnic_pci.c
> +++ b/drivers/net/ethernet/meta/mpnic/mpnic_pci.c
> @@ -108,6 +112,10 @@ static int mpnic_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
>  	pci_set_master(pdev);
>  	pci_save_state(pdev);
>  
> +	err = mpnic_dev_init(mpd);
> +	if (err)
> +		goto err_free_mpd;
> +
>  	return 0;
>  
>  err_free_mpd:
>

[Severity: High]
mpnic_dev_init() reaches much further into BAR 0 than anything the
driver touched before. Before this patch, the furthest access was
MPNIC_BDQ_SPARE in mpnic_rd64(). Now the TXB, RXB, RPC, ROF, TOF and
PEMO_WRAPPER blocks are all programmed.

The highest one is MPNIC_OB_ATTR_RDE_P in mpnic_ro_init(). It is
0x9a001a in u32 units, so the writeq() lands at byte offset 0x2680068.
BAR 0 therefore has to be at least ~38.5 MiB for this sequence to stay
inside the mapping.

mpnic_probe() maps BAR 0 with pcim_iomap_region(), which accepts
whatever length the device advertised. Nothing checks
pci_resource_len(pdev, 0) against the register file the driver is
about to use. mpnic_wr64() and mpnic_rd64() only test that uc_addr0
is non-NULL, then add the register index unconditionally.

Suppose a device presents a BAR 0 smaller than that. It could be a
misconfigured board, or something spoofing this ID behind
Thunderbolt/USB4. Won't the first out-of-range writeq() in
mpnic_dev_init() fault on an unmapped address during probe, or
scribble over whatever happens to be mapped after the BAR?

Could mpnic_probe() reject the device with -ENODEV before calling
mpnic_dev_init() when pci_resource_len(pdev, 0) is too small? Does the
hardware have a documented BAR 0 size that could serve as the bound?
That seems better than deriving one from the highest CSR currently
defined in mpnic_csr.h, which will keep moving as more blocks are
added.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260922-linux-mpnic-v1-0-236844f53072%40gmail.com
