Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D44B339FD9
	for <bpf@vger.kernel.org>; Fri, 24 Apr 2026 16:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777047472; cv=none; b=IQoGFuaJWrpQydL8zoHXdauqRDeiJCQyB09swJhKuJbtT89kBJJF7G3kh33Xeyo1jzqqK7wcSmOcKlN4QtCGyNjRnJI5btymPioAX74aeqZ2VyOWs02yE1xpaPG6bpcyRhSv3NwciSJH++ImSD0WGeUFKGyceKKCS5FGrtdNC98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777047472; c=relaxed/simple;
	bh=rrx42cICgo9eHmx8+pU3fqUvq+kyUPfTDQdStzqJxb4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Qz6LInVDIKJoqzuOF1y8Li7bVl3sepFIb355iunfhpNzS6LMbXBnFTQyxj395h2psjsiOA1PwJbFjQhgY+zfu/xo9icp55s4VKUx5haMWeNHC4kNWjZOVvh4Lc9+9cYTZ59agW4ONHW1Nl7abvcMWb0VivY1nFFjqO+YAU/r/0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VnJ5aG9L; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VnJ5aG9L"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76D4DC19425;
	Fri, 24 Apr 2026 16:17:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777047472;
	bh=rrx42cICgo9eHmx8+pU3fqUvq+kyUPfTDQdStzqJxb4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=VnJ5aG9LKR89RAyourv5H6DLY8nI17w3tw+ESigXDz2r6s/ARc2Us1eGR3ZbtL6Kk
	 sx6FUMtmrXoHfcYkFiXziNqGv9Mo/HIdlzmasbneOi7y17iqFu3O+MchvSavCqUyNe
	 DtaNmdz7mstVj50r7uceEGmnz5CjdcXoyBJx3Xr6b9KY1E5A7lkOAhqmmB5beEEIhu
	 TJCmS9+9kmw81EYE7IG6rIKgSVYonsHLhSjBwuPMD5ZFB484J84uIxFj+wuW6TXslg
	 e4OGH7VynjohHjwScS+JKmcwpVnOwVJ7EKlt7aQTCauqiPjUta6jsPw7CfL7vP3MaT
	 M0FkAyLEbEonw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net] net: mana: hardening: Validate SHM offset from BAR0
 register to prevent crash due to alignment fault
Reply-To: sashiko@lists.linux.dev
To: "Dipayaan Roy" <dipayanroy@linux.microsoft.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <aepF3NwyANeklkfD@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <aepF3NwyANeklkfD@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 24 Apr 2026 16:17:51 +0000
Message-Id: <20260424161752.76D4DC19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Sashiko AI review found 4 potential issue(s):
- [High] The bounds checks fail to account for the size of the accessed mem=
ory regions, allowing out-of-bounds MMIO reads.
- [High] The alignment check for `sriov_base_off` is insufficient and will =
trigger the exact arm64 alignment fault the patch attempts to fix.
- [High] Pre-existing incomplete bounds check for the doorbell page offset =
allows out-of-bounds MMIO accesses.
- [Medium] The bounds check for `sriov_base_off + sriov_shm_off` is vulnera=
ble to integer overflow.
--

commit 41b032a76edad75d2aeb45ec344d5df13479815a
Author: Dipayaan Roy <dipayanroy@linux.microsoft.com>

net: mana: hardening: Validate SHM offset from BAR0 register to prevent cra=
sh due to alignment fault

This commit validates the SHM and SRIOV base offsets read from the hardware
registers in the MANA driver to ensure they are within the BAR0 bounds and
aligned to 4 bytes. This aims to prevent alignment faults during hardware
recovery when registers might contain garbage values.

> diff --git a/drivers/net/ethernet/microsoft/mana/gdma_main.c b/drivers/ne=
t/ethernet/microsoft/mana/gdma_main.c
> --- a/drivers/net/ethernet/microsoft/mana/gdma_main.c
> +++ b/drivers/net/ethernet/microsoft/mana/gdma_main.c

[ ... ]

> @@ -73,10 +74,25 @@ static int mana_gd_init_pf_regs(struct pci_dev *pdev)
>  	gc->phys_db_page_base =3D gc->bar0_pa + gc->db_page_off;
> =20
>  	sriov_base_off =3D mana_gd_r64(gc, GDMA_SRIOV_REG_CFG_BASE_OFF);
> +	if (sriov_base_off >=3D gc->bar0_size ||
> +	    !IS_ALIGNED(sriov_base_off, sizeof(u32))) {

Does this alignment check ensure readq() won't fault? The code immediately
uses this offset for mana_gd_r64() which performs an 8-byte read. Since
GDMA_PF_REG_SHM_OFF is 0x70 (a multiple of 8), if sriov_base_off is only
4-byte aligned (e.g., 0x4), wouldn't the readq() address be unaligned and
trigger the exact same arm64 alignment fault this patch aims to fix?

Also, is it possible for the subsequent mana_gd_r64() read to access memory
outside the BAR? This checks if sriov_base_off is strictly less than
gc->bar0_size, but mana_gd_r64() reads 8 bytes at
sriov_base_off + GDMA_PF_REG_SHM_OFF. If sriov_base_off is valid but near
the end of the BAR, will this result in an out-of-bounds MMIO read?

> +		dev_err(gc->dev,
> +			"SRIOV base offset 0x%llx out of range or unaligned (BAR0 size 0x%llx=
)\n",
> +			sriov_base_off, (u64)gc->bar0_size);
> +		return -EPROTO;
> +	}
> =20
>  	sriov_base_va =3D gc->bar0_va + sriov_base_off;
> -	gc->shm_base =3D sriov_base_va +
> -			mana_gd_r64(gc, sriov_base_off + GDMA_PF_REG_SHM_OFF);
> +
> +	sriov_shm_off =3D mana_gd_r64(gc, sriov_base_off + GDMA_PF_REG_SHM_OFF);
> +	if (sriov_base_off + sriov_shm_off >=3D gc->bar0_size ||

Can sriov_base_off + sriov_shm_off integer overflow?

If sriov_shm_off is a large garbage value from the hardware, the sum could
wrap around to a small value, bypassing this check while silently aliasing
another hardware register. Should this be written as
sriov_shm_off >=3D gc->bar0_size - sriov_base_off?

> +	    !IS_ALIGNED(sriov_shm_off, sizeof(u32))) {

[ ... ]

> @@ -111,7 +128,16 @@ static int mana_gd_init_vf_regs(struct pci_dev *pdev)
>  	gc->db_page_base =3D gc->bar0_va + gc->db_page_off;
>  	gc->phys_db_page_base =3D gc->bar0_pa + gc->db_page_off;

This isn't a bug introduced by this patch, but earlier in this function
there is a check for the doorbell offset:

	if (gc->db_page_off >=3D gc->bar0_size) {
		...

Does this check properly account for the size of the doorbell page? If
db_page_off is valid but less than gc->db_page_size from the end of the BAR,
will subsequent doorbell accesses fall outside the mapped BAR0 memory regio=
n?

> -	gc->shm_base =3D gc->bar0_va + mana_gd_r64(gc, GDMA_REG_SHM_OFFSET);
> +	shm_off =3D mana_gd_r64(gc, GDMA_REG_SHM_OFFSET);
> +	if (shm_off >=3D gc->bar0_size ||

Does this bounds check ensure that subsequent reads don't go out of bounds?

shm_off is used to set gc->shm_base, and the commit message mentions
mana_smc_poll_register() accesses gc->shm_base up to offset 0x1c (28 bytes).
If shm_off passes this check but is near the end of the BAR
(e.g., gc->bar0_size - 4), will the driver perform an out-of-bounds MMIO
read?

> +	    !IS_ALIGNED(shm_off, sizeof(u32))) {
> +		dev_err(gc->dev,
> +			"SHM offset 0x%llx out of range or unaligned (BAR0 size 0x%llx)\n",
> +			shm_off, (u64)gc->bar0_size);
> +		return -EPROTO;
> +	}
> +
> +	gc->shm_base =3D gc->bar0_va + shm_off;
> =20
>  	return 0;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/aepF3NwyANeklkfD@li=
nuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net?part=3D1
