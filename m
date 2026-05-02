Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5E3513D51E
	for <bpf@vger.kernel.org>; Sat,  2 May 2026 15:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777737374; cv=none; b=Ib99k5aFJgurlYomBHF0ZvkYGSPBVZJFO1G8g0bfIm7EpNlBZW2oy6W635+OGmXnoCO1Ejdcp5UNPnXyvabyhYkv3zG5K9GVcNRnUXPrr7RBVQBZ+SZxUqoVGjNrAhp9mxalSWAxwzNz0OS3o+UCk+SDolNOSOQ5iSlw+7lOeUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777737374; c=relaxed/simple;
	bh=eeI8kQ34XZsUDsOH14O1ZI5TP1s8TQcrVWF/H8mnnbE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=OAsxhaPfwTvZRbTQ8rOaBZIQ8njhxLjjmwh1Zx7VkGV1eDaK6Tffx/EJ1srlcqEDgxECnRU9Pmv8eUltY+29NMjDvjmXQsIrc4Zw14h49i8RVqHjgn0ypEOMF2xcNHKgjH0iGV3kHFnr5mY0VcUf8gRZoVRdLmWY1ozbfmFCzhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D406Qbh5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D406Qbh5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E6D5C19425;
	Sat,  2 May 2026 15:56:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777737373;
	bh=eeI8kQ34XZsUDsOH14O1ZI5TP1s8TQcrVWF/H8mnnbE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=D406Qbh5A9B+ozjI7g5gdtEfybwWo16ODgm6DZrAEsOBqHWJ32+MCPkCrH7Tr5tWT
	 VhAWIbBUJk7g10XlPfozdRGPrBiOSPndMYrarJOzVVLXCOzBQ3nZciFXa11uxbnZA2
	 uvYAuOg9mXomlXaOaxeJoMzNa49W4fa1ZZN6mO59YrTFoDj0wDIg8hzb+66UsKYDEv
	 rwwp/tPGEJCCErJ5/0U7mxPhcPlLTogYMZ5kLqDgiYVOAB7KbqVYdg9526sh4fp8m8
	 QfkbqQ65PreZdsm1/lD0t8XVUmlnmnNL9mA/oJmPPO3imzaraA/W1TqFz0gDx/QP1v
	 UkIPCCg4iS0xQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next 01/12] net: pcs: pcs-xpcs-regmap: support XPCS
 memory-mapped MDIO bus via regmap
Reply-To: sashiko@lists.linux.dev
To: "Alex Elder" <elder@riscstar.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260501155421.3329862-2-elder@riscstar.com>
References: <20260501155421.3329862-2-elder@riscstar.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 02 May 2026 15:56:12 +0000
Message-Id: <20260502155613.5E6D5C19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] devm_xpcs_regmap_register violates devm lifecycle semantics and ca=
uses a resource leak.
--

commit 0a11082b5acea20f4d45fbd6df8fb9ec06db752d
Author: Daniel Thompson <daniel@riscstar.com>

net: pcs: pcs-xpcs-regmap: support XPCS memory-mapped MDIO bus via regmap

This commit introduces helpers to allow a driver to register an XPCS using a
regmap for the memory-mapped MDIO bus. It adds the devm_xpcs_regmap_register
function to manage the bus registration and interface abstractions.

> diff --git a/drivers/net/pcs/pcs-xpcs-regmap.c b/drivers/net/pcs/pcs-xpcs=
-regmap.c
> new file mode 100644
> index 000000000000..20a54a360595
> --- /dev/null
> +++ b/drivers/net/pcs/pcs-xpcs-regmap.c

[ ... ]

> +struct dw_xpcs *devm_xpcs_regmap_register(struct device *dev,
> +					  const struct xpcs_regmap_config *config)
> +{

[ ... ]

> +	ret =3D devm_mdiobus_register(dev, pxpcs->bus);
> +	if (ret) {
> +		dev_err(dev, "Failed to create MDIO bus\n");
> +		return ERR_PTR(ret);
> +	}
> +
> +	return xpcs_create_mdiodev(pxpcs->bus, 0);

Could this cause a resource leak on driver unbind?

The devm_xpcs_regmap_register() function uses the devm_ prefix, implying an=
 API
contract where the returned dw_xpcs object will be automatically managed and
cleaned up.

Internally, it calls xpcs_create_mdiodev(), which allocates the dw_xpcs
structure and increments the reference count of the underlying mdio_device.
These resources normally must be explicitly freed via xpcs_destroy().

Should this function register a devres cleanup action (for example, using
devm_add_action_or_reset()) to invoke xpcs_destroy() during unbind?

> +}
> +EXPORT_SYMBOL_GPL(devm_xpcs_regmap_register);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260501155421.3329=
862-1-elder@riscstar.com?part=3D1
