Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC74E382F2B
	for <bpf@vger.kernel.org>; Sat,  2 May 2026 15:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777737377; cv=none; b=JAlDr9hMNUoGRfC2K9wjOB/z0mjhp4h0ULJN21LymPAxZEyx0PLETy6iD79WSC04/BGiBvCnHBvxbMYtn77MxZvowTd/g0NKS/6JUBzXBBBhjlbUTq7322ysGQdgEDWuaSBzmpfsWUqnvuScrZuVm4xvBt2JsQLHuM7KAxPvccA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777737377; c=relaxed/simple;
	bh=J6dF+o+bXxTVddBTRRABSaYMyOCfv+dYYRcLJPWq3Tk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=UkqjUUxf5Ezn+XSd64G2+zGnbSbUAEJ38ErbUD5VkDqxMog6f5wM7JOApDtc/8/4YnIDJ6om13n9o6OJLhwirFE2EDETFQxgjP3idP8dWmGFfRZe78AicdVbIVm9isLpfsH5IOsm2naa5n7VTOSmC1Tl/pMJMQnQHhdvSEcrQdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IC17W6UO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IC17W6UO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51FDCC19425;
	Sat,  2 May 2026 15:56:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777737377;
	bh=J6dF+o+bXxTVddBTRRABSaYMyOCfv+dYYRcLJPWq3Tk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=IC17W6UOxBx8KxrbNkHLiohfBX1rVNGUN13IiXBybUv/kxEl1WDCkjMwxzFFquzcG
	 WCI/sij0X9OlrHAcN0txXU48sRTRiNkpfL+QqS+CZu2qJ+1SyqGDWdkUiDq4EOwe14
	 7quVRk9T7HbcLHohPnadM73Lgfe9QWx/vNnvHDW6pAabDyrP9gEIldWxBXew7GjpqL
	 O0rJvoOSdbC7zk1vl4GgZpLjDYXVyu4ftb3+bqI+zWWGY3SStPx6tCYxkToqV48MYv
	 sRTQUf23Ffy+CCIsZnmU/lOvxaZcIWG3ilaQnYS4FtvjpJRm+PA/PgnotUjWq71Cba
	 Ti//47sYm9+6Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next 03/12] net: pcs: pcs-xpcs: Preserve
 BMCR_ANENBLE during link up
Reply-To: sashiko@lists.linux.dev
To: "Alex Elder" <elder@riscstar.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260501155421.3329862-4-elder@riscstar.com>
References: <20260501155421.3329862-4-elder@riscstar.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 02 May 2026 15:56:16 +0000
Message-Id: <20260502155617.51FDCC19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Unconditionally forcing BMCR_ANENABLE for SGMII interfaces during =
out-of-band link configuration breaks forced and fixed links.
--

commit 3fde24f4d6c6c8c6b563418e32cec40953863f8a
Author: Daniel Thompson <daniel@riscstar.com>

net: pcs: pcs-xpcs: Preserve BMCR_ANENBLE during link up

This commit unconditionally sets the BMCR_ANENABLE bit for SGMII interfaces
during link up. This change was introduced to resolve an issue on a specific
hardware platform where the MAC fails to transmit packets despite negotiati=
ng
the speed correctly.

> diff --git a/drivers/net/pcs/pcs-xpcs.c b/drivers/net/pcs/pcs-xpcs.c
> index b2c84b7e1e11..1d62d5b31c61 100644
> --- a/drivers/net/pcs/pcs-xpcs.c
> +++ b/drivers/net/pcs/pcs-xpcs.c
> @@ -1263,11 +1263,14 @@ static void xpcs_link_up_sgmii_1000basex(struct d=
w_xpcs *xpcs,
>  					 phy_interface_t interface,
>  					 int speed, int duplex)
>  {
> +	u16 an_enable;
>  	int ret;
> =20
>  	if (neg_mode =3D=3D PHYLINK_PCS_NEG_INBAND_ENABLED)
>  		return;
> =20
> +	an_enable =3D (interface =3D=3D PHY_INTERFACE_MODE_SGMII ? BMCR_ANENABL=
E : 0);
> +

Will this break forced and fixed links by enabling auto-negotiation?

This function handles forcing the link state when in-band auto-negotiation
is explicitly disabled, as indicated by the early return for
PHYLINK_PCS_NEG_INBAND_ENABLED. When this function continues, phylink is
requesting out-of-band negotiation or a fixed link.

By unconditionally setting BMCR_ANENABLE here, the hardware might ignore
the fixed speed and duplex bits, instead waiting for auto-negotiation to
complete. If the system uses a fixed link (e.g., MAC-to-MAC) or connects
to a PHY with in-band signaling disabled, SGMII AN base pages will never
arrive.

Could this cause the MAC PCS to wait indefinitely, failing to establish a
link and dropping all traffic?

[ ... ]

>  	ret =3D xpcs_write(xpcs, MDIO_MMD_VEND2, MII_BMCR,
> -			 mii_bmcr_encode_fixed(speed, duplex));
> +			 mii_bmcr_encode_fixed(speed, duplex) | an_enable);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260501155421.3329=
862-1-elder@riscstar.com?part=3D3
