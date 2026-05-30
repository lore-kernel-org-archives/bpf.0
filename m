Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75F3530FC1F
	for <bpf@vger.kernel.org>; Sat, 30 May 2026 02:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780106664; cv=none; b=TXqtWzCqp2n9fSu1xD1YMeFcjM7IdZuApYkpTj9DVBDrylPhEI4iaaEU6/lJ5XL/u8EWEzeuC04wza3HajOeQaMYqTj/ug697K1G1qV8M0uecirEgbEo7HoC4VhtUdNdICn5q/+EBmeTam6XyERmLcAzKQ5bzl2/VGFZU+HnyzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780106664; c=relaxed/simple;
	bh=Q5/8ElMLDJgNYwlQ2LGLb6j53lsW1p6vkcz7k1ddeec=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rD1vAPGiLCGInLCMLNWdXfycylhgaNqJ5Vfz7TOcq6cU6YnoPo//BfaN8u/VWWwUD+oMagVoz50lnOx1CujHt9g7qPqBBBzfenIiaxn7tVJDgmD7Z00w536AESyokFUL+sS2t4Gb39g2/pposQj2y8afX0vOJLI6/XBIYoYuB78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b=JXzPLIzN; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b="JXzPLIzN"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-50e5bea4045so113728691cf.3
        for <bpf@vger.kernel.org>; Fri, 29 May 2026 19:04:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1780106661; x=1780711461; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RBgFnM5hRehl1dFk/oIpPjf+IKV6ZRSVJWJqumFIFU8=;
        b=JXzPLIzNM1e3qVw470HCMaezfRi2RRyx1KmDM7vq9O/TE3df0DxZShzt6zEakizao+
         ORAB/pKzGV5KpcHsr2G6tRJoyAeccmiddfd4F0QisNmPaUr4AicG6x2v0PWEYGE0jiTf
         0eQlosW4mLXnSjK7L8/V6eTX5hzTThKzUyZzI+uwHaoAqfGGhBzF2w+nG3fV7SPSU6T+
         PlJzU2pTzYapLEGsAtsA5JH3NaUVa/GbIZTDfGEFDSoDw6EFdPKqiAoVbCEm7t7yjMNj
         MNE3Z8bgh1RRJtGTVYhQY0Vx2Bgu1L+PSADXTEEfv+CjuZbw4sutro89II9YXineFGoI
         8SAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780106661; x=1780711461;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RBgFnM5hRehl1dFk/oIpPjf+IKV6ZRSVJWJqumFIFU8=;
        b=TGYXDQebONUS6EJt2oFHJx3/oJm2vToMxjjP6maZ2QilZ5EQ92lNwJO779r6TNjLo5
         7IDh1g1LYd6Zlw9yRL+ZrxhaBILS5TFQ72ZZz2mDFvj6PIlgau56ffsZz31YGWpsfP3w
         CqWGUSl2zGdwrAHpu+v3qp2kVE+tXqZ6PeYdmydRiRfwXslLvtIaiKycptRmvLVq5eyb
         bBiNLwn6l01RJ6Oxfcn/ryWiUBbeGgoEpZ92xccNm1yZmDoHSJ1jxEzY7AxtdhbBpXhT
         qYQBP356Qml/k0gU2a1I72EtwwTk2aEj/jZ/Bj3e23GiWcS5FZxrW6IGwI1qK9qXMyJ/
         k0tg==
X-Gm-Message-State: AOJu0YwcN6pBMSOsDOwnLGsYpXrg7SWkEVfYaf/VDJjGUpZ6499fNX7Z
	uyYVC7NtEPW4NClD2akLQwqjFcK4P4XyxaLlHfpPwA8P97RDeUw4UtP5mG1xQmmcIXU=
X-Gm-Gg: Acq92OGxfMQN3SxaNOmkpVdidI/o1J1AH1Wr4bb1+6PO32wFiDufCt/nxkdmwI2BFed
	bSdCoc6DaiK3atKWkHdNf/OwsDQC5ov35CKF4qZ7ZyRaTX/sRtmz1ObS8LVDbyD+a9IyEiAkKar
	hV58Y/HiSmFTWj7/Ak3rcI8bKLUnhmkiLlJgtiJJIQy5+6lE1i0mfePtq9Fq8FaM4qxCFXF+5dH
	3dbLMItmQ5ejtH5WjnN0uCsGH/dVZx8YzZrePB7USDHmJv5982oOnW9PYzwjvMGD1/c36qeMCZJ
	1TS7fz7f7k22AtBtHMbdmW/8zDdM1KqO78O5pnKHBxDZFF+BD8kS0G6cMrfzul+WI14l2+BUr8s
	BQYbxNN5cCjq/hhbjYm0w51yNUi3AAIQhfSGvrmlr9u0nCdoNO87ItkyJcHK21YK4aWT5AlCFNa
	ACjIz5Df41yrKPVK+5Nyu74X7cyVlJJnm74g==
X-Received: by 2002:a05:622a:6843:10b0:516:ea2d:7c5a with SMTP id d75a77b69052e-5173a8232d8mr24645891cf.41.1780106661510;
        Fri, 29 May 2026 19:04:21 -0700 (PDT)
Received: from [172.22.22.28] ([73.62.185.64])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ccea06d4casm32658206d6.16.2026.05.29.19.04.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 May 2026 19:04:20 -0700 (PDT)
Message-ID: <b41e4246-869d-41ef-ab30-44c29e10efdf@riscstar.com>
Date: Fri, 29 May 2026 21:04:19 -0500
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 01/12] net: pcs: pcs-xpcs-regmap: support XPCS
 memory-mapped MDIO bus via regmap
To: sashiko@lists.linux.dev
Cc: bpf@vger.kernel.org, Daniel Thompson <daniel@riscstar.com>
References: <20260501155421.3329862-2-elder@riscstar.com>
 <20260502155613.5E6D5C19425@smtp.kernel.org>
Content-Language: en-US
From: Alex Elder <elder@riscstar.com>
In-Reply-To: <20260502155613.5E6D5C19425@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/2/26 10:56 AM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] devm_xpcs_regmap_register violates devm lifecycle semantics and causes a resource leak.
> --
> 
> commit 0a11082b5acea20f4d45fbd6df8fb9ec06db752d
> Author: Daniel Thompson <daniel@riscstar.com>
> 
> net: pcs: pcs-xpcs-regmap: support XPCS memory-mapped MDIO bus via regmap
> 
> This commit introduces helpers to allow a driver to register an XPCS using a
> regmap for the memory-mapped MDIO bus. It adds the devm_xpcs_regmap_register
> function to manage the bus registration and interface abstractions.
> 
>> diff --git a/drivers/net/pcs/pcs-xpcs-regmap.c b/drivers/net/pcs/pcs-xpcs-regmap.c
>> new file mode 100644
>> index 000000000000..20a54a360595
>> --- /dev/null
>> +++ b/drivers/net/pcs/pcs-xpcs-regmap.c
> 
> [ ... ]
> 
>> +struct dw_xpcs *devm_xpcs_regmap_register(struct device *dev,
>> +					  const struct xpcs_regmap_config *config)
>> +{
> 
> [ ... ]
> 
>> +	ret = devm_mdiobus_register(dev, pxpcs->bus);
>> +	if (ret) {
>> +		dev_err(dev, "Failed to create MDIO bus\n");
>> +		return ERR_PTR(ret);
>> +	}
>> +
>> +	return xpcs_create_mdiodev(pxpcs->bus, 0);
> 
> Could this cause a resource leak on driver unbind?

Yes it could.  This will be fixed by checking the return value here,
and if it does not indicate an error, setting up a devm action
to call xpcs_destroy() on the dw_xpcs structure created.

					-Alex

> The devm_xpcs_regmap_register() function uses the devm_ prefix, implying an API
> contract where the returned dw_xpcs object will be automatically managed and
> cleaned up.
> 
> Internally, it calls xpcs_create_mdiodev(), which allocates the dw_xpcs
> structure and increments the reference count of the underlying mdio_device.
> These resources normally must be explicitly freed via xpcs_destroy().
> 
> Should this function register a devres cleanup action (for example, using
> devm_add_action_or_reset()) to invoke xpcs_destroy() during unbind?
> 
>> +}
>> +EXPORT_SYMBOL_GPL(devm_xpcs_regmap_register);
> 

