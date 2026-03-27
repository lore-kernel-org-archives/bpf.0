Received: from mail-qk1-f228.google.com (mail-qk1-f228.google.com [209.85.222.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70D322BE7DB
	for <bpf@vger.kernel.org>; Fri, 27 Mar 2026 18:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.228
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774635605; cv=pass; b=bRRIgx9jR9UBTJOs2wA/TcxFMD2r18IrCUIZAZPNb1Y26ouJC482lYQC5y0pcV8n0afk+DubYAGe0dE/IHAWgpJT+mYB7/ssAySGrHYG6WiufmoAQZF5bEBL73gGUaGtmophGsveoOe6rVdHcoLxSQ769+NvN/af68vO+bMj67Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774635605; c=relaxed/simple;
	bh=w1KBg8FYcLyXYzyB3YYf1W1Zitqxp6MB39xlkq9jsXQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y56HFsjWgR6qK1pBm2B8E+t3Bopo0wc7bLaNT0YvBcQJWea30v4wgR93xlsLlsbCX7oHFHiv/2ESJvmwl9VA30RmcgjxnAcmFREEB44PfGa4IQOk0mohlSFG2T1Q2JLTZqVmTkuG4APsDL2wm2UJg824TJEW7PaWq24D/CYtIyA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=fetbc0VK; arc=pass smtp.client-ip=209.85.222.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="fetbc0VK"
Received: by mail-qk1-f228.google.com with SMTP id af79cd13be357-8cd7ecedf2cso259893785a.3
        for <bpf@vger.kernel.org>; Fri, 27 Mar 2026 11:20:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774635601; x=1775240401;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3afQH8ommadsbw8DeWCAmAFa9gBh4EFmZQ2HyVWUnpw=;
        b=lKE2ZoGga9BwkjSFN51jkmLxSIxnNQBpJyU0xyDascT7dMqX/2ZCNI2cLDLS80VRfD
         5iK72a0OUPNaAjlz2H1AXAf5OfO3Vh1KAOnhpDLjBeiOIyYE/qtS9MZ+ozSuIqVUZhGs
         Uf4uGO9elsZ1iSAkv+fsWWbqkbKBdI8t1SJ+YHeZzfUnqvZR/DOycwBkYk4U184p1eZb
         iW8G+ahQqcNtSVzA8TK1yQLwUeIeZNOuagQ7YAa6z+R+P4h6Ee93VL78UVwe/Pmembks
         RuUbgIk5I882pyaqVCwn+b0iOtIervNATh2pmFd+5Uwc6XUtV3PaDu2cQk1VyTEI3h3B
         sXyg==
X-Forwarded-Encrypted: i=2; AJvYcCUxBDxRLUB+u2r1vp7upuQaFkdmA8opneF2tAEkKzE944sam9jfcpkPe+XyekPm+LvwdP8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz05UfGmuC2biG/ghD5r0aNnoq18RuNPcZ5CMaEiXOtx7rpA1/D
	kyfJrjM2PPAk5/wedCc4QLqH9FVRpaxZy4qQ6dci2ZIl4ntvbh/3hV8sZpCC76S57Phoypv0GW2
	/AdqfbbycPpKjXtbc8jIpM29JmqIXG53T2iSlVxW/al3nacKX7QlqMq62nKzQUx5jHM+VGcGZVB
	WQAS5D/EYQGw/PvDjNGxlnzUxyDib7aayexzYVJCNZkJwX8WZq/OOwKsrp8lZYdCLN2So8+PyOq
	Mb8NbjU5bPzqA==
X-Gm-Gg: ATEYQzwCLhOfBVn9+2hOYogetV147CwIzv7V0x7P1SLbMb/4tKSaAt7aw5xw375M1Hp
	ni84Sc2obKbEoiOMaYIPJBXKoJZ7SD5rrRIEeHrQxdGhsnfNOk9dfeCUt+H4k6Mzx3rfPnP75wk
	TkycwhUoEpds+dYpvKcFEqWeC22nPQQO1bGhuSg7t6a5boOMkktfkCadjqVif+RUB4vi/JuBJfN
	zctQXTaNCaIGL1g16wDTpyC3EWq5HqbiloQA2oD5rhmsa4s4PBaGeRLx/TgbuClYt82qG4Y2AhV
	DDAcpGb3eknhqtiRqS591K7k5X1uxfP0fxjCb00bW82OyUgzLM2CTQsNfPir79KbqNtq5lOBx3y
	yz9AhQByjC3+6iJleGbzm6I3mwytcD3m2PLDxZeVKsn3/7B8c8wgONEuSJp5tfy51PGHMBIdLAP
	rjlJIVGfweFm8=
X-Received: by 2002:a05:620a:4555:b0:8cd:871c:909d with SMTP id af79cd13be357-8d01c82b71bmr489184085a.53.1774635600477;
        Fri, 27 Mar 2026 11:20:00 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com ([144.49.247.127])
        by smtp-relay.gmail.com with ESMTPS id af79cd13be357-8d00e228ec6sm47521285a.0.2026.03.27.11.19.59
        for <bpf@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 27 Mar 2026 11:20:00 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-43b4085da48so2130729f8f.2
        for <bpf@vger.kernel.org>; Fri, 27 Mar 2026 11:19:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774635599; cv=none;
        d=google.com; s=arc-20240605;
        b=J8HwMpvs4fdQb6cLLE5PmT4A9YMgMYqu7C9f5Jj6bb/8JSAhcS1+PNoFY4r4gWvJtW
         34cr64StnsYvX//lNQePadGe5stRjXJWpoPwcXRpqY9MksNy+bUFCrgQ7UlWGGAhNJHX
         ts2NAHir09JnO2/taeOPtIFQsBZavSThlGL8SIoPbnDGwpSptM9fRSw9JPWuv62iv1Eq
         Vv9AZs4WDI3RwyJc/z00KRnzo/JOXFFOjXIUkI5yFSBD2Xu1TEv6DEHRCxjJli1sD6Xh
         N5u6x5/k220ABZ3ORS1p+5lovHZ3G0qEoIHWDKvNUhOyb3uSap2xs8k/EKTSyF3Hx3jP
         EMrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=3afQH8ommadsbw8DeWCAmAFa9gBh4EFmZQ2HyVWUnpw=;
        fh=a/kswWwkHmLx8QDaiZJWn/ce2EL1k0WMXe0yVaqwqyk=;
        b=MfNemqtoaMTH9FC65wVO90NcE2sA+g42+e2998FIPAXmBImSinaWmxBpCzzgYVF//K
         21+mbRmL/SChin4gSm/VLJZrLJ+wjBMpoaQlMDMvc2v0bpEsVQ/gPn4poyPyaAJSCmh4
         F9yQaO5b7g4bWBf2DmkPCndJMXz5/tG7jjQdF7ymUwqjfYqEalnkZlM0mX5/Y8nG9W13
         P0uhrME6R9yHdzL3ZGi+jFMWIoDQB74UC0Os8bmKIdS4rJ5OxcZw/aeQO690sQn0nfPC
         PVSku+JsW7RIa+zGz7iFudK3NvD46lh3McUHuunU9Sbns5IJycrS6qUoZ2D8M10nIj0z
         toTA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1774635599; x=1775240399; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3afQH8ommadsbw8DeWCAmAFa9gBh4EFmZQ2HyVWUnpw=;
        b=fetbc0VKHwzd0cNVV+lrfX0OgKZZTd7IgRuR2BZT4Yyyt7tT4wj89IeZM498sPKjix
         2F7JQxXnegAmtT1KPCxtAabBJZsx+1Vk7Kd8DqTWdfcTTg/Zg7Le2ELC8B3JvTIhW/Sw
         6B7zEkU23QUIPtaEeQujZ1K/kP2WiFBN+PNmM=
X-Forwarded-Encrypted: i=1; AJvYcCUsXrxM8ddZZdAeteZCp+BQtrXom1lm5yzm7zeF37I/9M8ICsPhKPaqBhG2zMjMfvIBr74=@vger.kernel.org
X-Received: by 2002:a05:6000:4313:b0:43b:9416:1aeb with SMTP id ffacd0b85a97d-43b9ea66f50mr5832678f8f.45.1774635269762;
        Fri, 27 Mar 2026 11:14:29 -0700 (PDT)
X-Received: by 2002:a05:6000:4313:b0:43b:9416:1aeb with SMTP id
 ffacd0b85a97d-43b9ea66f50mr5832607f8f.45.1774635269058; Fri, 27 Mar 2026
 11:14:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260320211921.1202058-1-jitendra.vegiraju@broadcom.com>
 <20260320211921.1202058-5-jitendra.vegiraju@broadcom.com> <acVlC3v0Hyt94XDN@shell.armlinux.org.uk>
In-Reply-To: <acVlC3v0Hyt94XDN@shell.armlinux.org.uk>
From: Jitendra Vegiraju <jitendra.vegiraju@broadcom.com>
Date: Fri, 27 Mar 2026 11:14:15 -0700
X-Gm-Features: AQROBzAQdeoF2TsC6pyuhb-C5pK3pms_hQQEO1sZdWHFtgUcfgs96hzmHlgqKOM
Message-ID: <CAMdnO-J8xV7KtO12CxhzktxnJ=s1kwZYfCPCgkTv3sS8Fpv5kQ@mail.gmail.com>
Subject: Re: [PATCH net-next v8 4/6] Add PCI driver support for BCM8958x
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org, alexandre.torgue@foss.st.com, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	mcoquelin.stm32@gmail.com, bcm-kernel-feedback-list@broadcom.com, 
	richardcochran@gmail.com, ast@kernel.org, daniel@iogearbox.net, 
	hawk@kernel.org, john.fastabend@gmail.com, rohan.g.thomas@altera.com, 
	linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org, 
	andrew+netdev@lunn.ch, horms@kernel.org, sdf@fomichev.me, 
	siyanteng@cqsoftware.com.cn, prabhakar.mahadev-lad.rj@bp.renesas.com, 
	weishangjuan@eswincomputing.com, wens@kernel.org, vladimir.oltean@nxp.com, 
	lizhi2@eswincomputing.com, boon.khai.ng@altera.com, 
	maxime.chevallier@bootlin.com, chenchuangyu@xiaomi.com, 
	yangtiezhu@loongson.cn, ovidiu.panait.rb@renesas.com, chenhuacai@kernel.org, 
	florian.fainelli@broadcom.com, quic_abchauha@quicinc.com
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000007ecbf8064e058c6c"

--0000000000007ecbf8064e058c6c
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Russell,

On Thu, Mar 26, 2026 at 9:56=E2=80=AFAM Russell King (Oracle)
<linux@armlinux.org.uk> wrote:
>
> On Fri, Mar 20, 2026 at 02:19:19PM -0700, Jitendra Vegiraju wrote:
> > +static const struct property_entry fixed_link_properties[] =3D {
> > +     PROPERTY_ENTRY_U32("speed", 10000),
> > +     PROPERTY_ENTRY_BOOL("full-duplex"),
> > +     PROPERTY_ENTRY_BOOL("pause"),
> > +     { }
> > +};
> > +
> > +static const struct software_node parent_swnode =3D {
> > +     .name =3D "phy-device",
> > +};
> > +
> > +static const struct software_node fixed_link_swnode =3D {
> > +     .name =3D "fixed-link",           /* MUST be named "fixed-link" *=
/
> > +     .parent =3D &parent_swnode,
> > +     .properties =3D fixed_link_properties,
> > +};
> > +
> > +static const struct software_node *brcm_swnodes[] =3D {
> > +     &parent_swnode,
> > +     &fixed_link_swnode,
> > +     NULL
> > +};
>
> Looking at this structure, I'm not sure it's correct. You seem to have:
>
> pci_device
> - "phy-device" swnode attached here (which describes the PCI device,
>   which isn't any kind of PHY)
>         - "fixed-link" attached as a child
>
> The "fixed-link" is a property for the local network device which
> signifies that there isn't a PHY attached or there's an inaccessible
> PHY that only operates with one set of settings.
>
> Maybe rename "phy-device" to "ethernet"?
>
Sure, that make sense. I will rename it as "ethernet"
> > +
> > +struct brcm_priv_data {
> > +     void __iomem *mbox_regs;    /* MBOX  Registers*/
> > +     void __iomem *misc_regs;    /* MISC  Registers*/
> > +     void __iomem *xgmac_regs;   /* XGMAC Registers*/
> > +};
> > +
> > +struct dwxgmac_brcm_pci_info {
> > +     int (*setup)(struct pci_dev *pdev, struct plat_stmmacenet_data *p=
lat);
> > +};
> > +
> > +static void misc_iowrite(struct brcm_priv_data *brcm_priv,
> > +                      u32 reg, u32 val)
> > +{
> > +     iowrite32(val, brcm_priv->misc_regs + reg);
> > +}
> > +
> > +static void dwxgmac_brcm_common_default_data(struct plat_stmmacenet_da=
ta *plat)
> > +{
> > +     int i;
> > +
> > +     plat->force_sf_dma_mode =3D true;
> > +     plat->mac_port_sel_speed =3D SPEED_10000;
> > +     plat->clk_ptp_rate =3D 125000000;
> > +     plat->clk_ref_rate =3D 250000000;
> > +     plat->tx_coe =3D true;
> > +     plat->rx_coe =3D STMMAC_RX_COE_TYPE1;
> > +     plat->rss_en =3D 1;
> > +     plat->max_speed =3D SPEED_10000;
> > +
> > +     /* Set default value for multicast hash bins */
> > +     plat->multicast_filter_bins =3D HASH_TABLE_SIZE;
>
> Already the default setup by stmmac_plat_dat_alloc().
Ack.
>
> > +
> > +     /* Set default value for unicast filter entries */
> > +     plat->unicast_filter_entries =3D 1;
>
> Already the default setup by stmmac_plat_dat_alloc().
>
Ack
> > +
> > +     /* Set the maxmtu to device's default */
> > +     plat->maxmtu =3D BRCM_MAX_MTU;
> > +
> > +     /* Set default number of RX and TX queues to use */
> > +     plat->tx_queues_to_use =3D BRCM_TX_Q_COUNT;
> > +     plat->rx_queues_to_use =3D BRCM_RX_Q_COUNT;
> > +
> > +     plat->tx_sched_algorithm =3D MTL_TX_ALGORITHM_SP;
> > +     for (i =3D 0; i < plat->tx_queues_to_use; i++) {
> > +             plat->tx_queues_cfg[i].use_prio =3D false;
>
> Already false.
>
Ack
> > +             plat->tx_queues_cfg[i].prio =3D 0;
>
> Already zero.
>
Ack
> > +             plat->tx_queues_cfg[i].mode_to_use =3D MTL_QUEUE_AVB;
>
> Since MTL_QUEUE_AVB is zero, this is already the case.
>
> > +     }
>
> All three points taken together mean that this loop is not required
> as all these members are being explicitly set to values of zero,
> which they already hold.
>
Ack
> > +
> > +     plat->rx_sched_algorithm =3D MTL_RX_ALGORITHM_SP;
> > +     for (i =3D 0; i < plat->rx_queues_to_use; i++) {
> > +             plat->rx_queues_cfg[i].use_prio =3D false;
>
> Already false.
>
Ack
> > +             plat->rx_queues_cfg[i].mode_to_use =3D MTL_QUEUE_AVB;
>
> Since MTL_QUEUE_AVB is zero, this is already the case.
>
Ack
> > +             plat->rx_queues_cfg[i].pkt_route =3D 0x0;
>
> Already zero.
>
Ack
> > +             plat->rx_queues_cfg[i].chan =3D i;
>
> stmmac_plat_dat_alloc() already initialises plat->rx_queues_cfg[].chan.
>
> > +     }
>
> Taking all these points together, it means that this loop also isn't
> required, since you're not changing anything that hasn't already been
> setup.
>
True, That will eliminate some redundant lines.
> > +}
> > +
> > +static int dwxgmac_brcm_default_data(struct pci_dev *pdev,
> > +                                  struct plat_stmmacenet_data *plat)
> > +{
> > +     /* Set common default data first */
> > +     dwxgmac_brcm_common_default_data(plat);
> > +     plat->core_type =3D DWMAC_CORE_25GMAC;
> > +     plat->bus_id =3D 0;
>
> The underlying devm_kzalloc() which allocates "plat" will clear the
> struct to zeros, so this assignment to bus_id shouldn't be necessary.
>
> > +     plat->phy_addr =3D 0;
>
> You said there's no MDIO bus, so I don't think you need to initialise
> plat->phy_addr. stmmac_plat_dat_alloc() will set this to -1.
>
Ack
> > +     plat->phy_interface =3D PHY_INTERFACE_MODE_XGMII;
> > +
> > +     plat->dma_cfg->pbl =3D DEFAULT_DMA_PBL;
> > +     plat->dma_cfg->pblx8 =3D true;
> > +     plat->dma_cfg->aal =3D false;
> > +     plat->dma_cfg->eame =3D true;
> > +
> > +     plat->axi->axi_wr_osr_lmt =3D 31;
> > +     plat->axi->axi_rd_osr_lmt =3D 31;
> > +     plat->axi->axi_fb =3D false;
>
> devm_kzalloc() which is used to allocate plat->axi in the probe function
> will zero out this structure, so axi_fb will already be false.
>
Ack
> > +     plat->axi->axi_blen_regval =3D DMA_AXI_BLEN64;
> > +     return 0;
> > +}
> > +
> > +static struct dwxgmac_brcm_pci_info dwxgmac_brcm_pci_info =3D {
> > +     .setup =3D dwxgmac_brcm_default_data,
> > +};
>
> It looks to me like this is a copy of stmmac_pci.c / dwmac-intel.c etc.
> Do you know for certain that you're going to need to do different
> setups depending on the PCI device?
>
> What's the reasoning for the split between
> dwxgmac_brcm_common_default_data() and dwxgmac_brcm_default_data() ?
>
We intend to eventually add support for another device with a
different setup function.
If the preference is to keep it simple until the additional
indirection is needed, I will
remove the setup function abstraction.

> > +
> > +static void brcm_config_misc_regs(struct pci_dev *pdev,
> > +                               struct brcm_priv_data *brcm_priv)
> > +{
> > +     pci_write_config_dword(pdev, XGMAC_PCIE_CFG_MSIX_ADDR_MATCH_LOW,
> > +                            XGMAC_PCIE_CFG_MSIX_ADDR_MATCH_LO_VALUE);
> > +     pci_write_config_dword(pdev, XGMAC_PCIE_CFG_MSIX_ADDR_MATCH_HIGH,
> > +                            XGMAC_PCIE_CFG_MSIX_ADDR_MATCH_HI_VALUE);
> > +
> > +     misc_iowrite(brcm_priv, XGMAC_PCIE_MISC_MSIX_ADDR_MATCH_LO_OFFSET=
,
> > +                  XGMAC_PCIE_MISC_MSIX_ADDR_MATCH_LO_VALUE);
> > +     misc_iowrite(brcm_priv, XGMAC_PCIE_MISC_MSIX_ADDR_MATCH_HI_OFFSET=
,
> > +                  XGMAC_PCIE_MISC_MSIX_ADDR_MATCH_HI_VALUE);
> > +
> > +     /* Enable Switch Link */
> > +     misc_iowrite(brcm_priv, XGMAC_PCIE_MISC_MII_CTRL_OFFSET,
> > +                  XGMAC_PCIE_MISC_MII_CTRL_PAUSE_RX |
> > +                  XGMAC_PCIE_MISC_MII_CTRL_PAUSE_TX |
> > +                  XGMAC_PCIE_MISC_MII_CTRL_LINK_UP);
> > +}
> > +
> > +static int brcm_config_multi_msi(struct pci_dev *pdev,
> > +                              struct plat_stmmacenet_data *plat,
> > +                              struct stmmac_resources *res)
> > +{
> > +     int ret;
> > +     int i;
> > +
> > +     ret =3D pci_alloc_irq_vectors(pdev, BRCM_XGMAC_MSI_VECTOR_MAX,
> > +                                 BRCM_XGMAC_MSI_VECTOR_MAX,
> > +                                 PCI_IRQ_MSI | PCI_IRQ_MSIX);
> > +     if (ret < 0) {
> > +             dev_err(&pdev->dev, "%s: multi MSI enablement failed\n",
> > +                     __func__);
> > +             return ret;
> > +     }
> > +
> > +     /* For RX MSI */
> > +     for (i =3D 0; i < plat->rx_queues_to_use; i++)
> > +             res->rx_irq[i] =3D
> > +                     pci_irq_vector(pdev,
> > +                                    BRCM_XGMAC_MSI_RX_VECTOR_START + i=
 * 2);
> > +
> > +     /* For TX MSI */
> > +     for (i =3D 0; i < plat->tx_queues_to_use; i++)
> > +             res->tx_irq[i] =3D
> > +                     pci_irq_vector(pdev,
> > +                                    BRCM_XGMAC_MSI_TX_VECTOR_START + i=
 * 2);
> > +
> > +     res->irq =3D pci_irq_vector(pdev, BRCM_XGMAC_MSI_MAC_VECTOR);
> > +
> > +     plat->flags |=3D STMMAC_FLAG_MULTI_MSI_EN;
> > +     plat->flags |=3D STMMAC_FLAG_TSO_EN;
> > +     plat->flags |=3D STMMAC_FLAG_SPH_DISABLE;
> > +     return 0;
> > +}
> > +
> > +static int brcm_pci_resume(struct device *dev, void *bsp_priv)
> > +{
> > +     struct pci_dev *pdev =3D to_pci_dev(dev);
> > +
> > +     brcm_config_misc_regs(pdev, bsp_priv);
>
> Is it worth declaring struct pdev for one place that it's used?
>
>         brcm_config_misc_regs(to_pci_dev(dev), bsp_priv);
>
> should work just as well.
>
Ack. Will change it.
> > +
> > +     return stmmac_pci_plat_resume(dev, bsp_priv);
> > +}
> > +
> > +static int dwxgmac_brcm_pci_probe(struct pci_dev *pdev,
> > +                               const struct pci_device_id *id)
> > +{
> > +     struct dwxgmac_brcm_pci_info *info =3D
> > +             (struct dwxgmac_brcm_pci_info *)id->driver_data;
> > +     struct plat_stmmacenet_data *plat;
> > +     struct brcm_priv_data *brcm_priv;
> > +     struct stmmac_resources res;
> > +     struct device *dev;
> > +     int rx_offset;
> > +     int tx_offset;
> > +     int vector;
> > +     int ret;
> > +
> > +     dev =3D &pdev->dev;
>
> As you go to the effort of declaring a struct device pointer, and
> assign it, do you think it would be a good idea to either use it for
> all &pdev->dev instances below, or just get rid of the two instances
> that you actually use "dev" ?
>
> I count six instances of "&pdev->dev" below vs two making use of "dev"
> directly.
>
Ack. I will change it.
> > +
> > +     brcm_priv =3D devm_kzalloc(&pdev->dev, sizeof(*brcm_priv), GFP_KE=
RNEL);
> > +     if (!brcm_priv)
> > +             return -ENOMEM;
> > +
> > +     plat =3D stmmac_plat_dat_alloc(dev);
> > +     if (!plat)
> > +             return -ENOMEM;
> > +
> > +     plat->axi =3D devm_kzalloc(&pdev->dev, sizeof(*plat->axi), GFP_KE=
RNEL);
> > +     if (!plat->axi)
> > +             return -ENOMEM;
> > +
> > +     /* This device is directly attached to the switch chip internal t=
o the
> > +      * SoC using XGMII interface. Since no MDIO is present, register
> > +      * fixed-link software_node to create phylink.
> > +      */
> > +     software_node_register_node_group(brcm_swnodes);
> > +     device_set_node(dev, software_node_fwnode(&parent_swnode));
> > +
> > +     /* Disable D3COLD as our device does not support it */
> > +     pci_d3cold_disable(pdev);
> > +
> > +     /* Enable PCI device */
> > +     ret =3D pcim_enable_device(pdev);
> > +     if (ret) {
> > +             dev_err(&pdev->dev, "%s: ERROR: failed to enable device\n=
",
> > +                     __func__);
> > +             return ret;
>
> What about cleaning up the swnodes ?
>
As you commented on patch5, I will squash the two patches.
> > +     }
> > +
> > +     pci_set_master(pdev);
> > +
> > +     memset(&res, 0, sizeof(res));
> > +     res.addr =3D pcim_iomap_region(pdev, 0, pci_name(pdev));
> > +     if (IS_ERR(res.addr))
> > +             return dev_err_probe(&pdev->dev, PTR_ERR(res.addr),
> > +                                  "failed to map IO region\n");
>
> Convention is to have a blank line here.
>
Ack.
> > +     /* MISC Regs */
> > +     brcm_priv->misc_regs =3D res.addr + BRCM_XGMAC_IOMEM_MISC_REG_OFF=
SET;
> > +     /* MBOX Regs */
> > +     brcm_priv->mbox_regs =3D res.addr + BRCM_XGMAC_IOMEM_MBOX_REG_OFF=
SET;
> > +     /* XGMAC config Regs */
> > +     res.addr +=3D BRCM_XGMAC_IOMEM_CFG_REG_OFFSET;
> > +     brcm_priv->xgmac_regs =3D res.addr;
> > +
> > +     plat->suspend           =3D stmmac_pci_plat_suspend;
> > +     plat->resume            =3D brcm_pci_resume;
> > +     plat->bsp_priv =3D brcm_priv;
> > +
> > +     ret =3D info->setup(pdev, plat);
> > +     if (ret)
> > +             return ret;
>
> What about cleaning up the swnodes ?
>
Patch 5 addressed this.
> > +
> > +     pci_write_config_dword(pdev, XGMAC_PCIE_CFG_MSIX_ADDR_MATCH_LOW,
> > +                            XGMAC_PCIE_CFG_MSIX_ADDR_MATCH_LO_VALUE);
> > +     pci_write_config_dword(pdev, XGMAC_PCIE_CFG_MSIX_ADDR_MATCH_HIGH,
> > +                            XGMAC_PCIE_CFG_MSIX_ADDR_MATCH_HI_VALUE);
> > +
> > +     misc_iowrite(brcm_priv, XGMAC_PCIE_MISC_MSIX_ADDR_MATCH_LO_OFFSET=
,
> > +                  XGMAC_PCIE_MISC_MSIX_ADDR_MATCH_LO_VALUE);
> > +     misc_iowrite(brcm_priv, XGMAC_PCIE_MISC_MSIX_ADDR_MATCH_HI_OFFSET=
,
> > +                  XGMAC_PCIE_MISC_MSIX_ADDR_MATCH_HI_VALUE);
> > +
> > +     /* SBD Interrupt */
> > +     misc_iowrite(brcm_priv, XGMAC_PCIE_MISC_MSIX_VECTOR_MAP_SBD_ALL_O=
FFSET,
> > +                  XGMAC_PCIE_MISC_MSIX_VECTOR_MAP_SBD_ALL_VALUE);
> > +     /* EP_DOORBELL Interrupt */
> > +     misc_iowrite(brcm_priv,
> > +                  XGMAC_PCIE_MISC_MSIX_VECTOR_MAP_EP2HOST_DBELL_OFFSET=
,
> > +                  XGMAC_PCIE_MISC_MSIX_VECTOR_MAP_EP2HOST_DBELL_VALUE)=
;
> > +     /* EP_H0 Interrupt */
> > +     misc_iowrite(brcm_priv,
> > +                  XGMAC_PCIE_MISC_MSIX_VECTOR_MAP_EP2HOST0_OFFSET,
> > +                  XGMAC_PCIE_MISC_MSIX_VECTOR_MAP_EP2HOST0_VALUE);
> > +     /* EP_H1 Interrupt */
> > +     misc_iowrite(brcm_priv,
> > +                  XGMAC_PCIE_MISC_MSIX_VECTOR_MAP_EP2HOST1_OFFSET,
> > +                  XGMAC_PCIE_MISC_MSIX_VECTOR_MAP_EP2HOST1_VALUE);
> > +
> > +     rx_offset =3D XGMAC_PCIE_MISC_MSIX_VECTOR_MAP_RX0_PF0_OFFSET;
> > +     tx_offset =3D XGMAC_PCIE_MISC_MSIX_VECTOR_MAP_TX0_PF0_OFFSET;
> > +     vector =3D BRCM_XGMAC_MSI_RX_VECTOR_START;
> > +     for (int i =3D 0; i < BRCM_MAX_DMA_CHANNEL_PAIRS; i++) {
> > +             /* RX Interrupt */
> > +             misc_iowrite(brcm_priv, rx_offset, vector++);
> > +             /* TX Interrupt */
> > +             misc_iowrite(brcm_priv, tx_offset, vector++);
> > +             rx_offset +=3D 4;
> > +             tx_offset +=3D 4;
> > +     }
>
> It looks like this device can program the MSI vector numbers. Does
> it make sense to interleave them, or would it be simpler to have
> all the receive vectors and then all the transmit vectors?
>
> This also hard-codes the fact that BRCM_XGMAC_MSI_TX_VECTOR_START
> is one more than BRCM_XGMAC_MSI_RX_VECTOR_START, which isn't nice
> given that you use these macros when claiming the MSI vectors.
>
Thanks for your input. I will remove the vector interleaving.
> > +
> > +     /* Enable Switch Link */
> > +     misc_iowrite(brcm_priv, XGMAC_PCIE_MISC_MII_CTRL_OFFSET,
> > +                  XGMAC_PCIE_MISC_MII_CTRL_PAUSE_RX |
> > +                  XGMAC_PCIE_MISC_MII_CTRL_PAUSE_TX |
> > +                  XGMAC_PCIE_MISC_MII_CTRL_LINK_UP);
> > +     /* Enable MSI-X */
> > +     misc_iowrite(brcm_priv, XGMAC_PCIE_MISC_PCIESS_CTRL_OFFSET,
> > +                  XGMAC_PCIE_MISC_PCIESS_CTRL_EN_MSI_MSIX);
> > +
> > +     ret =3D brcm_config_multi_msi(pdev, plat, &res);
> > +     if (ret) {
> > +             dev_err(&pdev->dev,
> > +                     "%s: ERROR: failed to enable IRQ\n", __func__);
> > +             goto err_disable_msi;
> > +     }
> > +
> > +     ret =3D stmmac_dvr_probe(&pdev->dev, plat, &res);
> > +     if (ret)
> > +             goto err_disable_msi;
> > +
> > +     return ret;
> > +
> > +err_disable_msi:
> > +     pci_free_irq_vectors(pdev);
>
> This is still buggy. What about cleaning up the swnodes?
Patch 5 addressed this. I will squash patches 4 and 5 in V9.
>
> > +
> > +     return ret;
> > +}
> > +
> > +static void dwxgmac_brcm_pci_remove(struct pci_dev *pdev)
> > +{
> > +     stmmac_dvr_remove(&pdev->dev);
> > +     pci_free_irq_vectors(pdev);
> > +     device_set_node(&pdev->dev, NULL);
> > +     software_node_unregister_node_group(brcm_swnodes);
>
> As the remove function does way more cleanup than the probe function,
> this is a sign that the probe function is buggy. This is exactly why
> I suggested using ->init and ->exit in the previous review. I seem
> to have been ignored on that though... and the problem I already
> pointed out remains.
As mentioned above, I will squash patches 4 and 5.
>
> Thanks.
>
> --
> RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

--0000000000007ecbf8064e058c6c
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
tJVewHuOmXgWQxNWV7Oiszu1d9xAcqyj65s1PrEIIaHnxEM3eTK+teecLEy8QymZjjDTrCHg4x36
2AczdlQAIiq5TSAucGja5VP8g1zTnfL/RAxEZvLS471GABptArolXY2hMVHdVEYcTduZlu8aHARc
phXveOB5/l3bPqpMVf2aFalv4ab733Aw6cPuQkbtwpMFifp9Y3s/0HGBfADomK4OeDTDJfuvCp8g
a907E48SjOJBGkh6c6B3ace2XH+CyB7+WBsoK6hsrV5twAXSe7frgP4lN/4Cm2isQl3D7vXM3PBQ
ddI2aZzmewTfbgZptt4KCUhZh+t7FGB6ZKppQ++Rx0zsGN1s71MtjJnhXvJyPs9UyL1n7KQPTEX/
07kwIwdMjxC/hpbZmVq0mVccpMy7FYlTuiwFD+TEnhmxGDTVTJ267fcfrySVBHioA7vugeXaX3yL
SqGQdCWnsz5LyCxWvcfI7zjiXJLwefechLp0LWEBIH5+0fJPB1lfiy1DUutGDJTh9WZHeXfVVFsf
rSQ3y0VaTqBESMjYsJnFFYQJ9tZJScBluOYacW6gqPGC6EU+bNYC1wpngwVayaQQMIIGbTCCBFWg
AwIBAgIMGHX6KxYK3WW2YyprMA0GCSqGSIb3DQEBCwUAMFIxCzAJBgNVBAYTAkJFMRkwFwYDVQQK
ExBHbG9iYWxTaWduIG52LXNhMSgwJgYDVQQDEx9HbG9iYWxTaWduIEdDQyBSNiBTTUlNRSBDQSAy
MDIzMB4XDTI0MDkyNTEzNTAzMVoXDTI2MDkyNjEzNTAzMVowgbMxCzAJBgNVBAYTAlVTMRMwEQYD
VQQIEwpDYWxpZm9ybmlhMREwDwYDVQQHEwhTYW4gSm9zZTEZMBcGA1UEYRMQTlRSVVMrREUtNjYx
MDExNzEWMBQGA1UEChMNQlJPQURDT00gSU5DLjEaMBgGA1UEAxMRSml0ZW5kcmEgVmVnaXJhanUx
LTArBgkqhkiG9w0BCQEWHmppdGVuZHJhLnZlZ2lyYWp1QGJyb2FkY29tLmNvbTCCASIwDQYJKoZI
hvcNAQEBBQADggEPADCCAQoCggEBAKWV+9PYvG4njqRsbQas79f8Q46VL7b1ZxvWT6ik6VMbdRZx
tfpfZalVXksqcb02/N1H7UA9V04cV2q97FkSr/KxeFLMetPb3cVJZICg23IRO2NTPdmgPFzwkPTo
35h9h/OYLgh3/9a1nTsC2xqJa8GtohD5+42rsskGcI57U4n1r1L4R5IL9ypSqDxX/xVEAdGI5FTj
VgvoZC6iuEbnez+yO8TT3wun9b/PQowOB5P0CwIFv7ERW0S1s6B8yrbsoaTrz0vQaEA786k1pZkg
ykC1+zXq/iTyZuPP4B4RkzFd43Pw+GAH0Tt2nx5V4rNisJHeAVNU92Gj01cEg0I+FnsCAwEAAaOC
Ad8wggHbMA4GA1UdDwEB/wQEAwIFoDCBkwYIKwYBBQUHAQEEgYYwgYMwRgYIKwYBBQUHMAKGOmh0
dHA6Ly9zZWN1cmUuZ2xvYmFsc2lnbi5jb20vY2FjZXJ0L2dzZ2NjcjZzbWltZWNhMjAyMy5jcnQw
OQYIKwYBBQUHMAGGLWh0dHA6Ly9vY3NwLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjZzbWltZWNhMjAy
MzBlBgNVHSAEXjBcMAkGB2eBDAEFAwEwCwYJKwYBBAGgMgEoMEIGCisGAQQBoDIKAwIwNDAyBggr
BgEFBQcCARYmaHR0cHM6Ly93d3cuZ2xvYmFsc2lnbi5jb20vcmVwb3NpdG9yeS8wCQYDVR0TBAIw
ADBBBgNVHR8EOjA4MDagNKAyhjBodHRwOi8vY3JsLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjZzbWlt
ZWNhMjAyMy5jcmwwKQYDVR0RBCIwIIEeaml0ZW5kcmEudmVnaXJhanVAYnJvYWRjb20uY29tMBMG
A1UdJQQMMAoGCCsGAQUFBwMEMB8GA1UdIwQYMBaAFAApNp5ceroPry1QLdugI4UYsKCSMB0GA1Ud
DgQWBBRq5Jlxz3MqC+zEgUxK566xEc2g3DANBgkqhkiG9w0BAQsFAAOCAgEARXrmeeWA31pp9Tr0
M6mOlMv+Pr2raES4GzPSyftvxf6tBQCBNaqi6LSbyusDYOj3mG9bp6VeVn+68OxNY9iNAk+ujtId
f3+30BlZOQ1v8z9u2peUOUtWI60y2MxhdH0X0n2H+BCGvUOFqs5z440jqqy1HsscZTXHB7FEZmVP
fyD+0Z6cxyh7WNC6+BgLiFwf8iqmAbu7Yb1sGTUGyS5gfYEjJbF2PJfwNUcJDd7eS4w5Ju5mK5y7
spgjH2/JmDgbkpSk9JyuWfjGZIg4ah/q2nb6UMd1XJb6gLQZuzPOI3SgXPvd8MHGjKZrX2BHOBSC
bJJ8rp4w4a9QMS6dde2MFObusxkZAft4tUnwo+ProchHs7iA85sL7sWEZhAmjmKKCpECpEfZm0+/
hpvKQV3AZp5vBstb4IVL8QmLj8beDVHYnNhEicsSiG1wW7zSYyBnmGbFRrFQIJnJDWPjTZOlVEyp
T1ShrXRCtqJpOt6rgg+rFEY3D8j6/bAkJXnmKnE2LZ0YyrrKk7eC6UfNNimx38w3NWchtcGY8zJn
Y/1/C9Jv/mWm/2lK8nvusOFxhKmbG83Hx8toQdZ5F1kYk6zAWjfB7lwXr/En9mCmLieJ18hen9EK
qbYyUkmCmuoLi5GXFMJy+iQv6DgMVQ7CACagybU6FUrmL9lVa+A6caBEEh4xggJXMIICUwIBATBi
MFIxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMSgwJgYDVQQDEx9HbG9i
YWxTaWduIEdDQyBSNiBTTUlNRSBDQSAyMDIzAgwYdforFgrdZbZjKmswDQYJYIZIAWUDBAIBBQCg
gccwLwYJKoZIhvcNAQkEMSIEIG5b/hS7ReVuWm5TJGyJCTXdIodj8yC6gyjMbqI7DCLKMBgGCSqG
SIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI2MDMyNzE4MTk1OVowXAYJKoZI
hvcNAQkPMU8wTTALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG
9w0DBzALBgkqhkiG9w0BAQcwCwYJYIZIAWUDBAIBMA0GCSqGSIb3DQEBAQUABIIBAI58f1AMKeEm
uPwA4BrFJJtHEE2JIQ8dOcRLUJRj2mDfl4dySjzrSj7WBVYBpxdaonQ52SrasZ9qQCmRqhiSuqSQ
kp3fOa3hGAZ9fVElwoK6LNZjzpSeBNqmOyUfDDyercphBnxah7wASGLROiSUEvthT+z9YaOnZIja
inw8QgQvASikV3TKNn4bRveWB9ma9wFeeobEklA8EmgewFDCvzzPEwUKMfmUhP0qaWmIC3nI+EzX
BV0p2oCR6H311PX+Dg3geFqC4/HTRKglps8mcO9C4iMOxlcidpSSMXN568bmNXidEs3XqRn35BQY
v0ajaKNFmit9xlOxOwyyfxua7t4=
--0000000000007ecbf8064e058c6c--
