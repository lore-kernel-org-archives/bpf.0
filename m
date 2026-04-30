Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B69414884C
	for <bpf@vger.kernel.org>; Thu, 30 Apr 2026 18:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777575572; cv=none; b=gypmmmRblc6AbxrCk0cRd6gLXOUX78RbCK4bjoGkb9g5iivi98RTQrHuP4RVO2hS/95o/rC7s+uWfsErAQh2MgVnOxkNg1xRX6hj+n1sI/GTtgddeAR9vWc3XNT+tkF/AIQWTv+zHXLmzCWKCzgzHUoO27ReT/7cHhgamJMHbr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777575572; c=relaxed/simple;
	bh=cmysySsWdjAW2DeVnRVYBWMGCd1+kfk6SX+VT/GiZBo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=eZ2xT6hHerGz7E/1UlzvgrdEUJyiHLSZrzRhsDwkC4pWvtpQiqrhC5zEGYWjEIkye99mKb+J1+sLxunxb8bSQRKICNAoTLEqUMelOkIGHB8uogUbXzUD2GEB/o3kzdwqUQnTm7Ein8K4aLqy2DcBLg7MAIbqKE5nRdhKaitnCxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VvOj8rHl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VvOj8rHl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6051C2BCB3;
	Thu, 30 Apr 2026 18:59:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777575571;
	bh=cmysySsWdjAW2DeVnRVYBWMGCd1+kfk6SX+VT/GiZBo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=VvOj8rHlrGy6LT0daNM8XlNssj9hIFRWZdCUbo3HI+7i7Q/Bd4zU782GGiC55O5Gl
	 +wfNNObaLhk1bXb/n1QgQxIkbVfAEf16ATromG/UDAyw0xbk8Aw9xQlOAWOP5ttEJo
	 l9OHd5tngQYnX3/vaigPZN8OuzSmeMbXxFU33c1kI+mbzjKi6o0frFF03rRUHTmqI0
	 wEzJcZckoTz6h/A5xTrYql6vnpW2IJsAfR+lTunzUqRCAzB4bjnD7cz3eGBVoih3zr
	 uUlDQeeEak3Ia3dBo+SeHQEgkfaAoxE/WkrRIv8jLz9K/Be8zHmCd5QB6cne37a1GQ
	 CbO9JhnXKnZ3w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net, v2] net: mana: Fix crash from unvalidated SHM
 offset read from BAR0 during FLR
Reply-To: sashiko@lists.linux.dev
To: "Dipayaan Roy" <dipayanroy@linux.microsoft.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <afJUszROT+yKjth0@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <afJUszROT+yKjth0@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 30 Apr 2026 18:59:31 +0000
Message-Id: <20260430185931.B6051C2BCB3@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] Incomplete fix: Missing bounds and alignment validation for the do=
orbell page offset (`db_page_off`), leaving the driver vulnerable to out-of=
-bounds MMIO accesses and arbitrary physical memory mapping.
- [High] Missing minimum BAR0 size validation for fixed-offset configuratio=
n registers.
- [Low] Duplicate macro definitions for SMC_APERTURE_BITS and related const=
ants.
- [Low] Dangling sentence fragment in the commit message.
--

commit a719bcc10e344c9685c78dde6408c1022c5a812e
Author: Dipayaan Roy <dipayanroy@linux.microsoft.com>
net: mana: Fix crash from unvalidated SHM offset read from BAR0 during FLR

This commit validates the SHM offset read from BAR0 to prevent out-of-bounds
and unaligned accesses. It computes safely by subtracting from bar0_size
instead of adding.

> without validating the offset read from hardware. If the register
> returns a garbage value that is neither within bar 0 bounds nor aligned
> to the 4-byte granularity, thus causing the alignment fault.

This isn't a bug, but there appears to be a dangling sentence fragment left
over in the commit message.

> diff --git a/drivers/net/ethernet/microsoft/mana/gdma_main.c b/drivers/ne=
t/ethernet/microsoft/mana/gdma_main.c
> index 098fbda0d128..d8e816882f02 100644
> --- a/drivers/net/ethernet/microsoft/mana/gdma_main.c
> +++ b/drivers/net/ethernet/microsoft/mana/gdma_main.c
> @@ -43,8 +43,9 @@ static u64 mana_gd_r64(struct gdma_context *g, u64 offs=
et)
>  static int mana_gd_init_pf_regs(struct pci_dev *pdev)
>  {
>  	struct gdma_context *gc =3D pci_get_drvdata(pdev);
> -	void __iomem *sriov_base_va;
> +	u64 remaining_barsize;
>  	u64 sriov_base_off;
> +	u64 sriov_shm_off;
> =20
>  	gc->db_page_size =3D mana_gd_r32(gc, GDMA_PF_REG_DB_PAGE_SIZE) & 0xFFFF;

Is gc->bar0_size guaranteed to be large enough before this initial read?

If a device exposes an unusually small BAR0, could this read from the fixed
GDMA_PF_REG_DB_PAGE_SIZE offset result in an out-of-bounds MMIO access
before the dynamic offset validations are reached?

[ ... ]

> @@ -73,10 +74,28 @@ static int mana_gd_init_pf_regs(struct pci_dev *pdev)
>  	gc->phys_db_page_base =3D gc->bar0_pa + gc->db_page_off;
> =20
>  	sriov_base_off =3D mana_gd_r64(gc, GDMA_SRIOV_REG_CFG_BASE_OFF);
> +	if (sriov_base_off >=3D gc->bar0_size ||
> +	    gc->bar0_size - sriov_base_off <
> +		GDMA_PF_REG_SHM_OFF + sizeof(u64) ||
> +	    !IS_ALIGNED(sriov_base_off, sizeof(u64))) {
> +		dev_err(gc->dev,
> +			"SRIOV base offset 0x%llx out of range or unaligned (BAR0 size 0x%llx=
)\n",
> +			sriov_base_off, (u64)gc->bar0_size);
> +		return -EPROTO;
> +	}

While this cleanly fixes the bounds and alignment checks for sriov_base_off,
should similar checks be applied to db_page_off which is read just above
this section?

In mana_gd_init_pf_regs():
        gc->db_page_off =3D mana_gd_r64(gc, GDMA_PF_REG_DB_PAGE_OFF);

        if (gc->db_page_off >=3D gc->bar0_size) {
                dev_err(gc->dev, ...);
                return -EPROTO;
        }

Could this leave a regression with out-of-bounds MMIO accesses or alignment
faults if gc->bar0_size - gc->db_page_off is smaller than the required
doorbell page size?

> diff --git a/include/net/mana/shm_channel.h b/include/net/mana/shm_channe=
l.h
> index 5199b41497ff..dbabcfb95daf 100644
> --- a/include/net/mana/shm_channel.h
> +++ b/include/net/mana/shm_channel.h
> @@ -4,6 +4,12 @@
>  #ifndef _SHM_CHANNEL_H
>  #define _SHM_CHANNEL_H
> =20
> +#define SMC_APERTURE_BITS 256
> +#define SMC_BASIC_UNIT (sizeof(u32))
> +#define SMC_APERTURE_DWORDS (SMC_APERTURE_BITS / (SMC_BASIC_UNIT * 8))
> +#define SMC_LAST_DWORD (SMC_APERTURE_DWORDS - 1)
> +#define SMC_APERTURE_SIZE  (SMC_APERTURE_BITS / 8)
> +
>  struct shm_channel {
>  	struct device *dev;
>  	void __iomem *base;

Does exporting these macros to the header file result in duplicate
definitions?=20

It looks like the original definitions might still be present in
drivers/net/ethernet/microsoft/mana/shm_channel.c.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/afJUszROT+yKjth0@li=
nuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net?part=3D1
