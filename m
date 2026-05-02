Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E39C8202997
	for <bpf@vger.kernel.org>; Sat,  2 May 2026 02:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777690071; cv=none; b=qdNNND5t55DZoyeJGeXURJcInf/B1wRikfAdY0EE4ikvPsKXB6CvlrEEX6kuHjTe4zfAE9S9R8YxE4ID9QCtdM4OSiOoWAbJB+wRmfV95iF/98SGZ/SHqtQm+/4nbgbHKXc4lbytyC/0JpJytPvDeFGvGspb5H7wPWdkMWWCEZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777690071; c=relaxed/simple;
	bh=4oMbvMfjkuqoxIne0a0L/6Ft0yq2vdSI+xjLg96u4YI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=QPd5Cj8Qj9UqIsjicG2S9aG9rBDMs4sEx76/Ou7bUWmAOfQyhGzZuMUxPv07Uy0BRCg0PFFKLVKvyQNfbmwLy3ZT/d83/BJQ8i1LF/0xFUuT/9T1YV4j9TmlW3fTI/c5F3AraBLH8JXZPIhCBYtfCxanSWDia/R3nVjJAgBe2tY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AgaPZL/0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AgaPZL/0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53DA2C2BCB4;
	Sat,  2 May 2026 02:47:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777690070;
	bh=4oMbvMfjkuqoxIne0a0L/6Ft0yq2vdSI+xjLg96u4YI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=AgaPZL/0z1z3I1SByJuqaEIQG40U+HnYMJ8rN/mml52ntiKGS+FOedMBzf8Y5ODLy
	 OgkMyZtczKKN64Ob0/PjM7L/iBxk6ZUr2zA2BSjyQH7Ep/q5sA5XR89l4JIutl0m6T
	 pQbMNt7tTIIWoyY3lYFUPGcPqhQJsPUqEx6pCm2LME6KC44W1qLxf3T/QMKBk4VxgR
	 FaHXtxxiAZ0BL6JoA6C9q3gz1dBIwbZPXqNmSzNRAEcZojoGcqLNh6EFBcBv9sOzkn
	 ssnvLCkd327NHhPcC1ptGtAqzSQb0Uy2sBdcv8EivP5luQUjeP5LRDslJYXLNmxbsC
	 OyYNF5u1qWgnA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net, v3] net: mana: Fix crash from unvalidated SHM
 offset read from BAR0 during FLR
Reply-To: sashiko@lists.linux.dev
To: "Dipayaan Roy" <dipayanroy@linux.microsoft.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <afQUMClyjmBVfD+u@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <afQUMClyjmBVfD+u@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 02 May 2026 02:47:49 +0000
Message-Id: <20260502024750.53DA2C2BCB4@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] The hardware register `db_page_off` lacks alignment and sufficient=
 upper-bound checks, leaving it vulnerable to the exact same FLR garbage-va=
lue kernel crash the patch aims to fix.
--

commit 51ede83a20aa96b2dface8ca0c0ba00d88085dc6
Author: Dipayaan Roy <dipayanroy@linux.microsoft.com>

net: mana: Fix crash from unvalidated SHM offset read from BAR0 during FLR

This commit adds validation for shared memory and SR-IOV base offsets read
from hardware registers during Function Level Reset recovery. It ensures the
values are within bar0 bounds and properly aligned to prevent arm64 alignme=
nt
faults or out-of-bounds mmio accesses when reading garbage values.

> diff --git a/drivers/net/ethernet/microsoft/mana/gdma_main.c b/drivers/ne=
t/ethernet/microsoft/mana/gdma_main.c
> index 098fbda0d128a..d8e816882f02c 100644
> --- a/drivers/net/ethernet/microsoft/mana/gdma_main.c
> +++ b/drivers/net/ethernet/microsoft/mana/gdma_main.c
> @@ -73,10 +74,28 @@ static int mana_gd_init_pf_regs(struct pci_dev *pdev)
>  	gc->phys_db_page_base =3D gc->bar0_pa + gc->db_page_off;

Should the doorbell offset (db_page_off) also receive the same hardening
against garbage values?

Looking at the existing code just above this hunk, db_page_off is read from
hardware and only validated against the strict upper bound of gc->bar0_size:

        gc->db_page_off =3D mana_gd_r64(gc, GDMA_PF_REG_DB_PAGE_OFF);
        if (gc->db_page_off >=3D gc->bar0_size) {
        ...

If the hardware temporarily returns an unaligned garbage value, or a value
that leaves not enough space for the doorbell page (e.g., gc->bar0_size - 2=
),
this check will pass. Subsequent doorbell writes to gc->db_page_base + offs=
et
via writeq() could trigger an unaligned mmio access or out-of-bounds write.

On arm64, unaligned accesses to Device memory strictly trigger a kernel pan=
ic
(alignment fault), which is the exact Function Level Reset recovery issue t=
his
patch aims to fix for the shared memory offsets.

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

[ ... ]

> @@ -111,7 +131,17 @@ static int mana_gd_init_vf_regs(struct pci_dev *pdev)
>  	gc->db_page_base =3D gc->bar0_va + gc->db_page_off;
>  	gc->phys_db_page_base =3D gc->bar0_pa + gc->db_page_off;

A similar incomplete check exists for the VF doorbell offset read from
GDMA_REG_DB_PAGE_OFFSET just above this hunk. Does this offset also need
to be aligned and leave sufficient space in bar0?

> -	gc->shm_base =3D gc->bar0_va + mana_gd_r64(gc, GDMA_REG_SHM_OFFSET);
> +	shm_off =3D mana_gd_r64(gc, GDMA_REG_SHM_OFFSET);
> +	if (shm_off >=3D gc->bar0_size ||
> +	    gc->bar0_size - shm_off < SMC_APERTURE_SIZE ||
> +	    !IS_ALIGNED(shm_off, sizeof(u32))) {

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/afQUMClyjmBVfD+u@li=
nuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net?part=3D1
