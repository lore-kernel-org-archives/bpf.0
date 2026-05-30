Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7566D30FC1F
	for <bpf@vger.kernel.org>; Sat, 30 May 2026 02:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780106685; cv=none; b=h3FEBNuTcYSt6msC67n6jiyBt8dIRAzlEFW9fcn/YW4q5f6srVcz/7kSaW9QJoTabCwD6vk/MS5D+QsB0GohS1BwDTj7o/G4kNbzFLauO8+QVLQn8uVxCjcorL6H2auMQ6ow+4YH7/91yybQv+XBgAgHDriO9lLOYqDkWpEuFrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780106685; c=relaxed/simple;
	bh=Ie9s9pe/xnUe16vSDSz6R6jzeQVRDbGF/2eXGSM9moY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E4T1n11bE+gSI7RXHd0kubNoMHBip07Q5M/5SAhKct+2Vq36Ds0orF2kMn20CF3IcoBj3t+C+yXIw7UGjFVPDaxPNAMspACsUqeeBeJZ0iH5DAXPix+RXNzVlaHC/AHdkmGhBpNGLR1pgEvzSmCzuctKwwE5MXwhtkmMtry7jLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b=UcRRiz7Y; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b="UcRRiz7Y"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-8ccf6a63a45so152456d6.3
        for <bpf@vger.kernel.org>; Fri, 29 May 2026 19:04:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1780106683; x=1780711483; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rChQttyFsqsEE3YOhXi7hNQOqbKBjIdVvH86ahpWNIo=;
        b=UcRRiz7YTVyUDrCC9qWhf147eSE10KiTrzSXkktv3/PoXC/fzokC/NWC/QnwTEFi8/
         bFFpg0cmbPHeBu7vPFVqoPNcX1UgcLnVg44oH0amC9NxzMrp6NMtJU8DKGu6/4K9eq+D
         MzMq9RAVxE+urT6quH9QNRkoVgOdgMFGc5/ba8yaicBPcVG6FoYU3kUBgDhNoLG0t1W5
         H5fqMQbZD+2b8ETJJlOrk3bVQiYMs/ez+Q9Oi7QqHC145HYFWFoRa5Aq/9lPfshmcXwG
         oeAxwUbiD9nUOWsZJtxSxZk6UesxneWbdY0JXL5TPCuPqILlKzTDj55mi7vX5rx4peIq
         eVnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780106683; x=1780711483;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rChQttyFsqsEE3YOhXi7hNQOqbKBjIdVvH86ahpWNIo=;
        b=hwh+hg/SOAdCTL69/TlGcPkEMvm2rkCSHDfouLFKsnxTzTJqv8b/iB776FG5Xh9wWg
         kOHq8ububH1BWeDMIza7b94BjJKSmrj1kIKu9KdcPmL85YYx8j0w0LK3aj4s9nrB1dv2
         OHADAL/9nsOa8Tn+A50l+PlNQfMih9jDe5AZNAx14lBLBobWRNL8wqqJC7fAycHJhcBQ
         WhIExAQO2JrezHxhEtFFrD/Wcx9gs4/fa5IPwEFZw9zuvPv4ALgzAPWMJtVNGWYZibUs
         GzsvmsF5SYDOxyYSE+aKgKdjHtcCOvvxUJZdtws0xas78NoMFFStv++dSE8FWXQHBvqj
         JE+Q==
X-Gm-Message-State: AOJu0Yw+B+DXFkMM6vfKLimg3iUaM7Pc4gVC5Hf1qKjjYJ8q7Bl4uGX/
	UKpDxCZE/qwXJFBqk2FZDQJK0h532FfKjpQl25moFTqW8/xELxxK6Wv6M3p7ihJpjzI=
X-Gm-Gg: Acq92OHFP/xk3I50ApLX7N1/L3cipUnKt93DDn1orLyvBw3GlXgpk8nzEhs4n/yosLx
	nvyAF5NOyqMQrMIRia0YB1zpdZaJUf2ZsecvADVXJ+hQ0NG9aHSX8Bd75EQw0xOAHV5dd/bUlij
	7F0qnQZFIXFi3grNpuWRl/ngmqyVBOwQ28yE1Ne98mM2xa996VLq39WrnAi7ITHicje/HG4wqG3
	On1vF/Uvr31JRS8eYpQBneHTxTKSEmbyfXJZ1ONag/u+NcaC0w7fQncmIwOL3JUimHyeO2OQMBA
	kEeOq7q+azNLUtTiCsn5omDtMIPq32zcaiQ9Wl/82C0Z9YxrU7s+pUQMIhjB8DzEVzsF6uWt7mJ
	7aVg6/rVzbEEbZoeL0ISqV6xDyNYf6JKaL5Y39rTG1DE1b+MV0ZdvoSh+yApGO9TZGFfQiOmsGm
	/pnCH6IyWS4pvx1JOdS39Teh0zhHn9RZdLOFHrx7lmv0Qr
X-Received: by 2002:a05:6214:4905:b0:8ca:2413:607a with SMTP id 6a1803df08f44-8ccefb25d5emr41623066d6.5.1780106683407;
        Fri, 29 May 2026 19:04:43 -0700 (PDT)
Received: from [172.22.22.28] ([73.62.185.64])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ccea06d4casm32658206d6.16.2026.05.29.19.04.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 May 2026 19:04:43 -0700 (PDT)
Message-ID: <8bd1ea39-b392-4b99-a70f-1815557e48ae@riscstar.com>
Date: Fri, 29 May 2026 21:04:42 -0500
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 09/12] gpio: tc956x: add TC956x/QPS615 support
To: sashiko@lists.linux.dev
Cc: bpf@vger.kernel.org, Daniel Thompson <daniel@riscstar.com>
References: <20260501155421.3329862-10-elder@riscstar.com>
 <20260502155618.2E65FC19425@smtp.kernel.org>
Content-Language: en-US
From: Alex Elder <elder@riscstar.com>
In-Reply-To: <20260502155618.2E65FC19425@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/2/26 10:56 AM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 5 potential issue(s) to consider:
> - [High] Function signature mismatch for `tc956x_gpio_set` causing build failures.
> - [High] Sleeping in atomic context bug on PREEMPT_RT due to `can_sleep = false`.
> - [Medium] Uninitialized stack variable used if `regmap_read()` fails.
> - [Medium] Ignored `regmap_update_bits()` return value can cause incorrect hardware state.
> - [Low] Kconfig depends on a non-existent symbol.
> --
> 
> commit ff81a192de0fcb35d3c4b8a32cad777cd0bff29e
> Author: Alex Elder <elder@riscstar.com>
> 
> gpio: tc956x: add TC956x/QPS615 support
> 
> This commit adds support for the GPIO controller embedded in the Toshiba
> TC956x Ethernet-AVB/TSN bridge. It implements an auxiliary device driver
> for the GPIO block using regmap.
> 
>> diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
>> --- a/drivers/gpio/Kconfig
>> +++ b/drivers/gpio/Kconfig
> [ ... ]
>> +config GPIO_TC956X
>> +	tristate "Toshiba TC956X GPIO support"
>> +	depends on TOSHIBA_TC956X_PCI
> 
> Does TOSHIBA_TC956X_PCI exist in the tree at this point? Reference to a
> non-existent config symbol causes silent build failures. If it is added
> later in the patch series, this temporarily leaves the driver unselectable
> and breaks bisectability.

In version 2 of the series, the patch that defines TOSHIBA_TC956X_PCI
will come earlier than this one in the series.

> 
> [ ... ]
>> diff --git a/drivers/gpio/gpio-tc956x.c b/drivers/gpio/gpio-tc956x.c
>> --- /dev/null
>> +++ b/drivers/gpio/gpio-tc956x.c
> [ ... ]
>> +static int tc956x_gpio_get_direction(struct gpio_chip *gc, unsigned int offset)
>> +{
>> +	struct tc956x_gpio *gpio = gpiochip_get_data(gc);
>> +	u32 reg;
>> +	u32 val;
>> +
>> +	if (test_bit(offset, gpio->input_only))
>> +		return GPIO_LINE_DIRECTION_IN;
>> +
>> +	reg = offset < 32 ? GPIO_EN0_OFFSET : GPIO_EN1_OFFSET;
>> +
>> +	regmap_read(gpio->regmap, reg, &val);
> 
> If regmap_read() fails, does it leave the stack variable val uninitialized?
> Should the return value be checked before evaluating val in the next line?

In this case, we know we are using an MMIO-based regmap, and
since we have no clock, regmap_mmio_read() always returns 0.

>> +	if (val & BIT(offset % 32))
>> +		return GPIO_LINE_DIRECTION_IN;
>> +
>> +	return GPIO_LINE_DIRECTION_OUT;
>> +}
> [ ... ]
>> +static int tc956x_gpio_direction_output(struct gpio_chip *gc,
>> +					unsigned int offset, int value)
>> +{
>> +	struct tc956x_gpio *gpio = gpiochip_get_data(gc);
>> +	u32 vreg;
>> +	u32 dreg;
>> +	u32 mask;
> [ ... ]
>> +	/* Set output value first, then direction */
>> +	regmap_update_bits(gpio->regmap, vreg, mask, value ? mask : 0);
> 
> If this first regmap_update_bits() fails, should the function bail out
> early? Ignoring the error and proceeding to change the direction to output
> anyway could actively drive an unintended logic level onto the pin.

Again, we do not expect regmap_update_bits() to return an error
for an MMIO-based regmap.

>> +
>> +	return regmap_update_bits(gpio->regmap, dreg, mask, 0);
>> +}
>> +
>> +static int tc956x_gpio_get(struct gpio_chip *gc, unsigned int offset)
>> +{
>> +	u32 reg = offset < 32 ? GPIO_IN0_OFFSET : GPIO_IN1_OFFSET;
>> +	struct tc956x_gpio *gpio = gpiochip_get_data(gc);
>> +	u32 val;
>> +
>> +	regmap_read(gpio->regmap, reg, &val);
> 
> Similar to tc956x_gpio_get_direction(), does this leave val uninitialized
> and return unpredictable states if regmap_read() fails?

This should not fail, so we expect val will be initialized.

> 
>> +
>> +	return val & BIT(offset % 32) ? 1 : 0;
>> +}
>> +
>> +static int tc956x_gpio_set(struct gpio_chip *gc, unsigned int offset, int value)
> 
> Does the set function pointer in struct gpio_chip expect a void return
> type? Assigning a function returning int could trigger an incompatible
> pointer type compiler error or cause Control Flow Integrity panics at
> runtime.

I might be missing something but I don't understand this comment.
In any case, the next version of the code implements the GPIO
controller using the gpio-regmap framework.

> 
>> +{
>> +	u32 reg = offset < 32 ? GPIO_OUT0_OFFSET : GPIO_OUT1_OFFSET;
>> +	struct tc956x_gpio *gpio = gpiochip_get_data(gc);
>> +	u32 mask = BIT(offset % 32);
>> +
>> +	return regmap_update_bits(gpio->regmap, reg, mask, value ? mask : 0);
>> +}
> [ ... ]
>> +static int tc956x_gpio_probe(struct auxiliary_device *adev,
>> +			     const struct auxiliary_device_id *id)
>> +{
> [ ... ]
>> +	gc->base = -1;
>> +	gc->ngpio = TC956X_GPIO_COUNT;
>> +	gc->can_sleep = false;
> 
> Is it safe to set can_sleep to false while using a regmap? By default,
> MMIO regmaps use spinlock_t for synchronization, which becomes a sleepable
> rt_mutex on PREEMPT_RT kernels. Calling these GPIO methods from an atomic
> context on PREEMPT_RT could cause a panic.

Here too, even if this were an issue, the issue will move into
the gpio-regmap code with the new version of the code.

					-Alex

> 
>> +
>> +	dev_set_drvdata(dev, gpio);
>> +
>> +	return devm_gpiochip_add_data(dev, gc, gpio);
>> +}
> 

