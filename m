Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EE62382F2B
	for <bpf@vger.kernel.org>; Sat,  2 May 2026 15:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777737378; cv=none; b=EV8Po3wAA5rz5rWPL2w0OBM/m7b4No6M2LckAQMK9Bjixkyhx9DW6hH0QloncsGngFxLabfmB2iJzikIxWriMBST0LO4lLQ8+rDXxcfr9jLXhlUT2ElEkP6HILqJQRMHuWMi9BXjQEdv5hia5DqIW2EhkoyMUo2TKYFTK948GpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777737378; c=relaxed/simple;
	bh=fwkaiDzOmgv4OmRIlzriCd3RkFsQGVlLeZFs8PrK3XM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Cw+okX2ADhXf+jJZQSFDEntytU4tFCUPO9qaG6VQHFZp6Wxo+6zPH2wtJQZeUdx5nSHgoP6qM5ti4ic4MISAe0V/IY0BM1fNwXjl9kFm4OA0vTIuZiFnDZW1ZW+kQwQwB5sBGkGUd3rWQjXL1VHmDp4kDJdkfUjOnaC0AKy9ofc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cKNNLDQq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cKNNLDQq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E65FC19425;
	Sat,  2 May 2026 15:56:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777737378;
	bh=fwkaiDzOmgv4OmRIlzriCd3RkFsQGVlLeZFs8PrK3XM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=cKNNLDQqtb8vckJ4NPjjOuCIGCn4WX7KJkVwQa0rxWD60me9qM2zXMrubaz5zBpV1
	 s7r5Gw8YlGMQ9DH1e+ffpcC1ttlGI674POlHqmhAKC+JAsB/O3ioM+3L+IEo98xllT
	 vyKsQrjZmK+0ohfunfN7VkPXt8m0v+p7L1OwMIyHhEE0aw9JWvkG5p2RRo2eWx7ZY/
	 mEtTr9CKzSeyLpbswfwYGYq3eerxAkY6tprDhLwFxPhNbBz9X4TWuKJF8ekJHLVocd
	 Khr50vXAl/y2Rnm60DCTdQ1BamaPmkREhMC/msiZRwt29LfThl0yzWLBOv0hBWejWC
	 GTnsGV7vtnO8Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next 09/12] gpio: tc956x: add TC956x/QPS615 support
Reply-To: sashiko@lists.linux.dev
To: "Alex Elder" <elder@riscstar.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260501155421.3329862-10-elder@riscstar.com>
References: <20260501155421.3329862-10-elder@riscstar.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 02 May 2026 15:56:17 +0000
Message-Id: <20260502155618.2E65FC19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:
- [High] Function signature mismatch for `tc956x_gpio_set` causing build fa=
ilures.
- [High] Sleeping in atomic context bug on PREEMPT_RT due to `can_sleep =3D=
 false`.
- [Medium] Uninitialized stack variable used if `regmap_read()` fails.
- [Medium] Ignored `regmap_update_bits()` return value can cause incorrect =
hardware state.
- [Low] Kconfig depends on a non-existent symbol.
--

commit ff81a192de0fcb35d3c4b8a32cad777cd0bff29e
Author: Alex Elder <elder@riscstar.com>

gpio: tc956x: add TC956x/QPS615 support

This commit adds support for the GPIO controller embedded in the Toshiba
TC956x Ethernet-AVB/TSN bridge. It implements an auxiliary device driver
for the GPIO block using regmap.

> diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
> --- a/drivers/gpio/Kconfig
> +++ b/drivers/gpio/Kconfig
[ ... ]
> +config GPIO_TC956X
> +	tristate "Toshiba TC956X GPIO support"
> +	depends on TOSHIBA_TC956X_PCI

Does TOSHIBA_TC956X_PCI exist in the tree at this point? Reference to a
non-existent config symbol causes silent build failures. If it is added
later in the patch series, this temporarily leaves the driver unselectable
and breaks bisectability.

[ ... ]
> diff --git a/drivers/gpio/gpio-tc956x.c b/drivers/gpio/gpio-tc956x.c
> --- /dev/null
> +++ b/drivers/gpio/gpio-tc956x.c
[ ... ]
> +static int tc956x_gpio_get_direction(struct gpio_chip *gc, unsigned int =
offset)
> +{
> +	struct tc956x_gpio *gpio =3D gpiochip_get_data(gc);
> +	u32 reg;
> +	u32 val;
> +
> +	if (test_bit(offset, gpio->input_only))
> +		return GPIO_LINE_DIRECTION_IN;
> +
> +	reg =3D offset < 32 ? GPIO_EN0_OFFSET : GPIO_EN1_OFFSET;
> +
> +	regmap_read(gpio->regmap, reg, &val);

If regmap_read() fails, does it leave the stack variable val uninitialized?
Should the return value be checked before evaluating val in the next line?

> +	if (val & BIT(offset % 32))
> +		return GPIO_LINE_DIRECTION_IN;
> +
> +	return GPIO_LINE_DIRECTION_OUT;
> +}
[ ... ]
> +static int tc956x_gpio_direction_output(struct gpio_chip *gc,
> +					unsigned int offset, int value)
> +{
> +	struct tc956x_gpio *gpio =3D gpiochip_get_data(gc);
> +	u32 vreg;
> +	u32 dreg;
> +	u32 mask;
[ ... ]
> +	/* Set output value first, then direction */
> +	regmap_update_bits(gpio->regmap, vreg, mask, value ? mask : 0);

If this first regmap_update_bits() fails, should the function bail out
early? Ignoring the error and proceeding to change the direction to output
anyway could actively drive an unintended logic level onto the pin.

> +
> +	return regmap_update_bits(gpio->regmap, dreg, mask, 0);
> +}
> +
> +static int tc956x_gpio_get(struct gpio_chip *gc, unsigned int offset)
> +{
> +	u32 reg =3D offset < 32 ? GPIO_IN0_OFFSET : GPIO_IN1_OFFSET;
> +	struct tc956x_gpio *gpio =3D gpiochip_get_data(gc);
> +	u32 val;
> +
> +	regmap_read(gpio->regmap, reg, &val);

Similar to tc956x_gpio_get_direction(), does this leave val uninitialized
and return unpredictable states if regmap_read() fails?

> +
> +	return val & BIT(offset % 32) ? 1 : 0;
> +}
> +
> +static int tc956x_gpio_set(struct gpio_chip *gc, unsigned int offset, in=
t value)

Does the set function pointer in struct gpio_chip expect a void return
type? Assigning a function returning int could trigger an incompatible
pointer type compiler error or cause Control Flow Integrity panics at
runtime.

> +{
> +	u32 reg =3D offset < 32 ? GPIO_OUT0_OFFSET : GPIO_OUT1_OFFSET;
> +	struct tc956x_gpio *gpio =3D gpiochip_get_data(gc);
> +	u32 mask =3D BIT(offset % 32);
> +
> +	return regmap_update_bits(gpio->regmap, reg, mask, value ? mask : 0);
> +}
[ ... ]
> +static int tc956x_gpio_probe(struct auxiliary_device *adev,
> +			     const struct auxiliary_device_id *id)
> +{
[ ... ]
> +	gc->base =3D -1;
> +	gc->ngpio =3D TC956X_GPIO_COUNT;
> +	gc->can_sleep =3D false;

Is it safe to set can_sleep to false while using a regmap? By default,
MMIO regmaps use spinlock_t for synchronization, which becomes a sleepable
rt_mutex on PREEMPT_RT kernels. Calling these GPIO methods from an atomic
context on PREEMPT_RT could cause a panic.

> +
> +	dev_set_drvdata(dev, gpio);
> +
> +	return devm_gpiochip_add_data(dev, gc, gpio);
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260501155421.3329=
862-1-elder@riscstar.com?part=3D9
