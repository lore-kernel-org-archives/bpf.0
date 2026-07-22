Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C11363DBD76
	for <bpf@vger.kernel.org>; Wed, 22 Jul 2026 03:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784691425; cv=none; b=lbwJ9MjpCVTmjI3HF0X3a/6V9LGewi8XTzAOgE8YlAwhXpPF7HLxhMwmRuKMBEzzXzgna5mPkkSqtiFr+bvk+8SRRFutcpggfBl3pSabt9Lju+L0huhuCMLGnejZwDL2Mkm3RQrN8eNzv11ZwV/glIJF0ZBZH5w240LixCUdRvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784691425; c=relaxed/simple;
	bh=AkRHW82ZRYnw5D0pqPMbtGWFR/5KPevf4o2wq0Q2+YI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jEu41GjqWU9duH++qO29VNdLv2nTDerbBHLZ8wsnL4Eo4JMQgd3/vlMqFbjQhC06X/Ocif5ZHS1yGu9t/FJxSypQonvbM1OtuI2nMMaXgHDhcD3bPsSZCkUKxwxyoy9yuya0cOz8IRhSfBL52Mdl4SCuHcONxpSxqxBYEL/3Jws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VMCwMVq+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VMCwMVq+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E5A71F000E9;
	Wed, 22 Jul 2026 03:37:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784691423;
	bh=UjSYC/TfPfhE8wafKi4yUwLPjuufxUdLZ19AVEf5R8Q=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VMCwMVq+8jdByve6myHGVc8Rq+i6iUVciu9Jd8NFzxFFdv8tDHJHODQpPCWyA01Is
	 j4fONm89NhCMXqxYjxD6tGqjbNqw7zwvpVoHREutYT9qbW3rR6tvcUrM3o7F3GtBxD
	 F53HDbtdOPVjh8gHW7Nni8a43BAekYCsIcv+wR1dC1WyKuwBcTdfhCo/tlVj5NaeAk
	 F5OA+17PsUBVTWqCAiSDLl5UU/GHo5RUKw55Nf3IL7TFG0b+jxFtZAPz+bF+YjLdOn
	 g/ZK1lVoudR3QHcT9wUcfMzh6jgNjRUTUeouTt6RHrj/KUJHsaqyYQLExKqriUzmoK
	 +sv128qpUNltQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v3] e1000e: Fix out-of-bounds MMIO access by
 validating BAR0 size
Reply-To: sashiko-reviews@lists.linux.dev
To: "Pu Lehui" <pulehui@huaweicloud.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260722031603.1471127-1-pulehui@huaweicloud.com>
References: <20260722031603.1471127-1-pulehui@huaweicloud.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 22 Jul 2026 03:37:02 +0000
Message-Id: <20260722033703.2E5A71F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The newly introduced minimum BAR0 length check `E1000_MMIO_LEN_MIN=
` is too small because it fails to account for flash registers mapped into =
the GbE memory space for newer MACs, leaving the driver vulnerable to the s=
ame OOB MMIO access panics it attempts to fix.
--

--- Patch [1]: [PATCH net v3] e1000e: Fix out-of-bounds MMIO access by vali=
dating BAR0 size ---
commit 9c24a014d2bfbd3a6822ff92be6a5c7aceb588d4
Author: Pu Lehui <pulehui@huawei.com>
Subject: e1000e: Fix out-of-bounds MMIO access by validating BAR0 size

This patch adds a check during e1000_probe() to validate that the device's
BAR0 size is large enough to cover the highest register offset (E1000_SYSST=
MPH)
accessed by the driver. This is intended to fix a kernel panic caused by
out-of-bounds MMIO reads when dealing with small BAR0 allocations.

> diff --git a/drivers/net/ethernet/intel/e1000e/regs.h b/drivers/net/ether=
net/intel/e1000e/regs.h
> index 6c0cd8cab3ef2..1e875227eef24 100644
> --- a/drivers/net/ethernet/intel/e1000e/regs.h
> +++ b/drivers/net/ethernet/intel/e1000e/regs.h
[ ... ]
> @@ -242,4 +242,7 @@
>  /* PHY registers */
>  #define I82579_DFT_CTRL	PHY_REG(769, 20)
> =20
> +/* Smallest BAR0 that covers every register the driver accesses */
> +#define E1000_MMIO_LEN_MIN	(E1000_SYSSTMPH + sizeof(u32))

[Severity: High]
This isn't a bug introduced by this patch, but does this minimum length
cover all register accesses for newer MACs?

For MAC types e1000_pch_spt and newer, the driver accesses flash registers
mapped at E1000_FLASH_BASE_ADDR (0xE000). For example, during flash read:

drivers/net/ethernet/intel/e1000e/ich8lan.c:e1000_init_nvm_params_ich8lan()=
 {
    ...
    hw->flash_address =3D hw->hw_addr + E1000_FLASH_BASE_ADDR;
    ...
}

And then later accesses like:

drivers/net/ethernet/intel/e1000e/ich8lan.c:e1000_read_flash_data32_ich8lan=
() {
    ...
    *data =3D er32flash(ICH_FLASH_FDATA0);
    ...
}

This results in an access at offset 0xE010 (57360 bytes).

Since E1000_MMIO_LEN_MIN is currently based on E1000_SYSSTMPH
(0xB64C + 4 =3D 46672 bytes), could a malicious or mocked PCI device expose=
 a
BAR0 size of 12 pages (49152 bytes), pass this new check, and still trigger
an out-of-bounds MMIO read panic when accessing the flash space?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260722031603.1471=
127-1-pulehui@huaweicloud.com?part=3D1
