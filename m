Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 312A1382394
	for <bpf@vger.kernel.org>; Sat,  2 May 2026 15:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777737375; cv=none; b=QZIQQCBKk4MiS6rAwUcfwjjhoL73DWQ/8JU/fTKrPRFLwWO4WRBs9Ia4MvLRuRKgY8K9fOTy89K9A7nu65biHQVaTwQmeCnCEmbx3QdPpiGbimEWIgXxyr6Sa6+iS9n3gn7aWxAKuH6OH+jzllGfXNEQmsE358034VPI3ZQwnX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777737375; c=relaxed/simple;
	bh=QPKVJ6yFmbtgZILMv1uzddjkmlqzH2taGl9KXJ2eheU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=BjxmX+R1EFUguwrhgKLosJFNb0ipdYHnVTOCJtbNz4rbSygGN0E8DX4e/uqEL3EcXZ+VfeVxG9fAgY1v8gB8gjwrNdAThIRqJ9TygjcnLnO+zkfBYhpnGPjzg7sHKCxhoehhrOwArRWPQwcePOvPU/Ajh7zdX7uTITmmlLxlOic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tifnt7Km; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tifnt7Km"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4E41C2BCC4;
	Sat,  2 May 2026 15:56:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777737375;
	bh=QPKVJ6yFmbtgZILMv1uzddjkmlqzH2taGl9KXJ2eheU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=Tifnt7KmMhk7Sz0DpPmZ79GJi4O6QmPDcNfZl1ObB4YyozRRjaIHAOio06Azxavfh
	 GWDVWqOyTtfB0yH4gUiLzFXvdYecO3T1i+xTAT9WCoAWlOhbmPJPOaSZzeM2g6D/YD
	 KCgniybODJe+sl+uuFLAPAsGXCrDIuk8IapPbCmxHc/ESQO5whpXYDp9nosBSnTkzB
	 QO2PE4NSf/oBVBSFVfjM/zAb8xho0inx4+rw6Rnp9/gFAM76cj5Qnr+ta4cgqlHwPY
	 QnQlpTIDg3nYBD+smnoEMMYwyxRRc724gIaLTI6vAgGSZk7yxKul+BZcBaUHv1TTCT
	 F1fjG295J8rtQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next 07/12] net: stmmac: dwxgmac2: export symbols
 for XGMAC 3.01a DMA
Reply-To: sashiko@lists.linux.dev
To: "Alex Elder" <elder@riscstar.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260501155421.3329862-8-elder@riscstar.com>
References: <20260501155421.3329862-8-elder@riscstar.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 02 May 2026 15:56:14 +0000
Message-Id: <20260502155614.E4E41C2BCC4@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Bypassing standard DMA address translation via custom op-table over=
rides.
--

commit 6c8a6ba67e29de7e71f5090bcca63c458ee9639d
Author: Daniel Thompson <daniel@riscstar.com>

net: stmmac: dwxgmac2: export symbols for XGMAC 3.01a DMA

This patch exports several DMA operations and descriptor tables from the
dwxgmac2 core to allow platform-specific code to override them. This
override allows the platform code to perform manual DMA address translations
required by the chip's internal AXI bus mappings.

> One consequence of the SoC-like design is that the internal AXI bus
> (used by the XGMAC for DMA) maps the PCI DMA space with a non-zero base
> address. This requires a translation step (happily just simple addition)
> to convert the PCI DMA address to the hardware DMA address.
>=20
> This is pretty funky so rather than push that translation logic into
> the core driver we intend to keep that logic inside the TC956x
> platform code. In order to do that we need to export a few symbols
> to allow us to override some of the DMA and descriptor op tables.

This isn't a bug, but does this approach bypass the standard Linux DMA API?

The standard DMA API natively handles device-specific address offsets, such
as through dma_range_map on the struct device.

Could this address translation be handled using the standard DMA abstractio=
ns
instead of open-coding it via op-table overrides and exporting these intern=
al
symbols?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260501155421.3329=
862-1-elder@riscstar.com?part=3D7
