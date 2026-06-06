Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A76E7233947;
	Sat,  6 Jun 2026 01:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780707687; cv=none; b=OTkTjZeXGUSMhTinB5j6Jq+hhtl1p240+5OJ/yM6Fzx9L1a9qm0w3+Pufc1fjq2a2TuHLJlm9mxs/1eOQmSl14RRSgdLpTN6UpnC2LBTZzJ+i5RXZJrn6FxzeGEbF8u0x2tC7b96mpwT5dZKuO+dPAEmeHHZ7rlXqh7oTOwbJwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780707687; c=relaxed/simple;
	bh=EO4q6i3jXdWTe6oVb5UC52qvKDWdl20Kvh4JdH7qre4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=LG0iOG/VeZl0sSxL18EpHb+HYoXHV2vozwhfJ4wCW7ci8IhHnV408/sXx2zlDMIp0E4XmyE5P2fT6+lKwQGSnVD+N080oVAojNdruFjNl8PDLTdJMhotCXqkI7bqvuGPl7NXHekXnSqIjBXJVfqOPK2EzVadoSEV38BRE7uKGyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jCA0dQ+x; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jCA0dQ+x"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1D381F00893;
	Sat,  6 Jun 2026 01:01:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780707686;
	bh=oP+jNgVBecQGFs1d0ULqwhZV8edXNeyWW92ngkrESQA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jCA0dQ+xpCGFn3FQNYrxayjAz1UG7MlHjYLdm729YWM+2qUkz587WA6pIh9ncWBfE
	 EYJ3tpuQ32y3m2fgqGYxYRU6qDJEOulNrYi7Y3Rbbne/D8w9cngbF+T2jMzLe3hHdo
	 IQuk5zEQH6/uLedYmn44Hin7tlDifuIUEiXPmuKze0R4aiUNSbqdM1hxpwZaVZDmhU
	 QiS9MT2o48NW1MzL9TTysloYaLAWUFYcJIxkXAT+d6Xzg5dDoofGGhwSzJC9bTojQ3
	 TW/aGF5FifqbfsIEA5DSTTBh83aoyFEOlsnMS0hy03VzBUtp9ktoD8aMg7f9L5otPt
	 ERVUNMArmZRhw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v2 12/14] gpio: tc956x: add TC956x/QPS615
 support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alex Elder" <elder@riscstar.com>
Cc: robh@kernel.org, bpf@vger.kernel.org, devicetree@vger.kernel.org, conor+dt@kernel.org
In-Reply-To: <20260605010022.968612-13-elder@riscstar.com>
References: <20260605010022.968612-13-elder@riscstar.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 06 Jun 2026 01:01:25 +0000
Message-Id: <20260606010125.F1D381F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] API Misuse: `fixed_direction_output` completely breaks direction q=
uerying and fails to enforce input-only pins.
- [Low] Build failure due to assignment to non-existent member `fixed_direc=
tion_mask` in `struct gpio_regmap_config`.
--

commit 5da78e90b4b1867131b8f557ae59d72ce4db9776
Author: Alex Elder <elder@riscstar.com>

gpio: tc956x: add TC956x/QPS615 support

This commit adds a generic regmap-based GPIO driver for the Toshiba TC956x
Ethernet-AVB/TSN bridge. The device acts as an auxiliary device to the PCIe
endpoint function driver.

> diff --git a/drivers/gpio/gpio-tc956x.c b/drivers/gpio/gpio-tc956x.c
> new file mode 100644
> index 0000000000000..0dc6b1028d970
> --- /dev/null
> +++ b/drivers/gpio/gpio-tc956x.c
[ ... ]
> +static int tc956x_gpio_probe(struct auxiliary_device *adev,
> +			     const struct auxiliary_device_id *id)
> +{
[ ... ]
> +	config.reg_stride =3D GPIO_REG_STRIDE;
> +	config.ngpio_per_reg =3D GPIO_PER_REG;
> +	config.init_valid_mask =3D tc956x_gpio_init_valid_mask;
> +	config.fixed_direction_mask =3D fixed;

[Severity: Low]
Is fixed_direction_mask a valid member of struct gpio_regmap_config?
It does not appear to be defined in include/linux/gpio/regmap.h, which
could lead to a build failure here.

> +	config.fixed_direction_output =3D zeroes;

[Severity: High]
Does providing an all-zeroes bitmap to fixed_direction_output achieve the
intended input-only constraints?

Looking at gpio_regmap_get_direction() in drivers/gpio/gpio-regmap.c:

	if (gpio->fixed_direction_output) {
		if (test_bit(offset, gpio->fixed_direction_output))
			return GPIO_LINE_DIRECTION_OUT;
		else
			return GPIO_LINE_DIRECTION_IN;
	}

Providing a non-NULL fixed_direction_output causes the API to bypass
hardware direction queries for all pins, unconditionally reporting all
37 pins as inputs.

Furthermore, since reg_dir_in_base is also provided, the API will still
allow users to configure these supposedly input-only pins as outputs
because it does not check fixed_direction_output during set_direction
operations.

> +
> +	gpio_regmap =3D devm_gpio_regmap_register(dev, &config);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260605010022.9686=
12-1-elder@riscstar.com?part=3D12
