Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D69F130EF92
	for <bpf@vger.kernel.org>; Sat, 30 May 2026 02:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780106693; cv=none; b=ZYB1EW6JtiHRqyCyySpjGSZX1sNjlhulIazoFYRADb984eR6vBUnLx/3HEnC+YWyFC7YrK8B89sfy5GB4lNwEmj5Ik89R9RTv7G1Y2DUVUFSQ2XTlbjCjkRZWeFSkDAh/0jRGS+Ua1IiFmgFMXATvqo0+TDLjbVFR7+3s6SvlhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780106693; c=relaxed/simple;
	bh=NQVLMiGOXlaYEHPVCpYriED4c3IJceu54nBYoBfxes8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fovYJ0q06eFMt17IlXUv3nGLTd030W/Liu+XgE+kmhDGI40IAr4SRcR7KbWnGkYnJ9ZxRoAGazwRfZjg6HQitnrdbF5fhyrLzKn6clMKgc35apRQldsDMxCY8HK2fwOjgO4Zd3haL3LJeO/n8jdAWcjsc46xjrAluCalkq1k0RU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b=VQaX9KEC; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b="VQaX9KEC"
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-8cceaacd07bso10917816d6.3
        for <bpf@vger.kernel.org>; Fri, 29 May 2026 19:04:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1780106691; x=1780711491; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3i1oyBiurpko1znXNZZKAdYDCNtEHVcNnoLsM4FfGuo=;
        b=VQaX9KECh35vM3k78Hfz9mXo1blBP7oPa3v8HwiVXgA4VCAEfH6bB3RyfWzQYfUJea
         cG1Rj2WqVjwnqKYjuJTDiXBeTxiwGSWJheSczdZuQxbRwBFxNOiOvfXj9XOehOtarbzq
         gFc5nEpA1KE1CgXKk1Y6e/gknAGmDLy/AfshxnuoaOfStPjNBipOVZaipayvGhQ72rhM
         FUebGNRiat5EpKgp3eAhkaP0GJil6VescyXJeJz2ZfPBlSAcNZbijzDuQbaNwqNT0bfp
         b/fNoepZE6cRakyXx17wEVvjEE4ItY+RAbaT7o88AKJLcgY91YCxVTiqXa8J4oDbJhyy
         +ePw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780106691; x=1780711491;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3i1oyBiurpko1znXNZZKAdYDCNtEHVcNnoLsM4FfGuo=;
        b=Va+w6q1PyMSc7wyqQ72NHhzYQXnpvb2z6jEYQIzRVCnqStJonRTjhoo/iMdxr4CIbS
         YG8LGpt8e7dPhq+oTWK3CrMmNpENU+EUGsZi+8oxKqIoU0GouUGYMA/P8GLjFUhSYJpK
         Mt0VKvEXJ0L3qZzcLVrtKc/1Q6R5nHALDOLtaHKl541HUyEMDNVZ6Aj7FdxzD4q1nJk5
         E2L5SHl8GrwgQ+C+dgcTc4TSXyPBRG8eWrF9pizsCDFYt7S/RkrvA/BQ9V4GFcdK9Ziq
         0GK2YN8w0GXPIdq9V73hLHQSRMrabHOF1aJt/HpbmNjUYRsY9G3s4vEs7tXckFiEvDd4
         g6mg==
X-Gm-Message-State: AOJu0YyMjbTgcLmYaxjhtXcsAPJC4GR6/iOQi7pxxYltTEHZeDy2hetj
	C0F3wX1604qfyaheRrCzd4mq4H9RvF3YJfnlgAcISfK9zgGQhT1mQk2Se68IGpkAum9y0Pk6HVA
	lpelRvgk=
X-Gm-Gg: Acq92OH1kiOdJghbkhBWG6YT4mGJHOoHN3c78/Jhpl2CsSWk1C1WjUcERNtmexdWeLs
	lSSLkhG5TIuVD+7XXUzVRVS3PmhLsfIN+Y51fIpUXNyredKRwINynkPcTLf8WXh7jfsQsNRa8DA
	NzqaEABWA+sVcfIISmp+7mN0MgrRBimFkYQph4urOl+sDdLRxXWMqdg5IGGe5tTKRY98s/ce2ro
	geoA61+Ch1EtweSsfQp/IqR5LhzYmmwBhhSawof7A51Hot1C2btg29fCJFw+ydiOHwfF5TWVFP0
	FXAgiFK0cnFdOIyzozWAFtWLdAT3vG04//wgh0XbCi7Ay1FIfhdTQ19b4O7ln2pziiQlv8m87HW
	Pkq0Ls5cAH7T/jTYacL7AA3bqcgNnUmFVNgaJ7BwYNm7f1uTWcKNd4DVF3jb7EsVO5MdIiDFN6Q
	tix4MvAD3jvbSxaSmy0GyIAlZsPDLd9W7CBA==
X-Received: by 2002:a05:6214:484a:b0:8cc:f3bb:e15c with SMTP id 6a1803df08f44-8ccf3bbe567mr11957526d6.41.1780106691014;
        Fri, 29 May 2026 19:04:51 -0700 (PDT)
Received: from [172.22.22.28] ([73.62.185.64])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ccea06d4casm32658206d6.16.2026.05.29.19.04.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 May 2026 19:04:50 -0700 (PDT)
Message-ID: <af4bb6db-acb5-4489-9757-75d53d678680@riscstar.com>
Date: Fri, 29 May 2026 21:04:50 -0500
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 11/12] misc: tc956x_pci: add TC956x/QPS615
 support
To: sashiko@lists.linux.dev
Cc: bpf@vger.kernel.org, Daniel Thompson <daniel@riscstar.com>
References: <20260501155421.3329862-12-elder@riscstar.com>
 <20260502155619.BCDFDC19425@smtp.kernel.org>
Content-Language: en-US
From: Alex Elder <elder@riscstar.com>
In-Reply-To: <20260502155619.BCDFDC19425@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/2/26 10:56 AM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 4 potential issue(s) to consider:
> - [High] Dangling `platform_data` pointer and stateless device link lead to Use-After-Free
> - [High] Devres lifecycle violation causes memory leak of device links
> - [High] Reference count leak of PCI peer device
> - [High] Missing `pci_free_irq_vectors()` in error paths and remove function

All issues highlighted here are legitimate, and will be
addressed in the next version of the series.

> --
> 
> commit 7eab7fd4b209226034d88bc445ad71c833dda6b7
> Author: Alex Elder <elder@riscstar.com>
> 
> misc: tc956x_pci: add TC956x/QPS615 support
> 
> This commit introduces support for the Toshiba TC956x Ethernet AVB/TSN
> bridge, configuring its PCI functions and creating auxiliary devices to
> support the XGMAC interfaces.
> 
> diff --git a/drivers/misc/tc956x_pci.c b/drivers/misc/tc956x_pci.c
> --- /dev/null
> +++ b/drivers/misc/tc956x_pci.c
> 
> [ ... ]
> 
>> +static struct tc956x_chip *chip_get(struct pci_dev *pdev)
>> +{
> 
> [ ... ]
> 
>> +	/* Function 1 has to get the chip structure from function 0 */
>> +	peer = pci_get_slot(pdev->bus, PCI_DEVFN(PCI_SLOT(devfn), 0));
>> +	if (!peer)
>> +		return ERR_PTR(-ENXIO);
> 
> Does this leak the pci_dev reference count?

Yes it does, and this will be fixed in the next version of the patch.

> 
> pci_get_slot() returns a device with its reference count incremented, but I
> do not see a matching pci_dev_put(peer) in either the success path or when
> returning -EPROBE_DEFER below.
> 
>> +
>> +	/* If function 0 hasn't set up the chip yet, try again later */
>> +	chip = dev_get_platdata(&peer->dev);
>> +	if (!chip)
>> +		return ERR_PTR(-EPROBE_DEFER);
>> +
>> +	/* Mark function 1's device as dependent on function 0 */
>> +	link = device_link_add(dev, &peer->dev, DL_FLAG_STATELESS);
> 
> Is DL_FLAG_STATELESS safe to use here?

We believe this is safe to use here.  If it is created successfully
a devm action is set up (for function 1) to remove the link.

> Stateless links do not enforce unbind ordering. If function 0 is unbound by
> the user, its devres will free the chip structure and unmap the MMIO regions
> while function 1 remains bound. Will function 1 cause a use-after-free if it
> accesses the freed chip state or unmapped MMIO space?
> 
>> +	if (!link)
>> +		return ERR_PTR(-ENODEV);
>> +
>> +	ret = devm_add_action_or_reset(&peer->dev, chip_link_del, link);
> 
> Should this cleanup action be attached to dev (function 1) instead of
> peer->dev (function 0)?

Yes, this was a very good catch.  The name of the peer
variable will be changed to be "slot0" to emphasize which
device we're dealing with.

> 
> If function 1's probe fails downstream, its own devres list is rolled back,
> but this cleanup action remains attached to function 0. Will this leak the
> device link and accumulate duplicate devres actions on function 0 each time
> function 1 defers its probe?
> 
>> +	if (ret)
>> +		return ERR_PTR(ret);
>> +
>> +	return chip;
>> +}
> 
> [ ... ]
> 
>> +static int
>> +tc956x_function_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>> +{
> 
> [ ... ]
> 
>> +	/* We called pcim_enable_device() so this will be freed automatically */
>> +	ret = pci_alloc_irq_vectors(pdev, 1, 1, PCI_IRQ_MSI);
>> +	if (ret < 1)
>> +		return dev_err_probe(dev, ret ? : -EIO,
>> +				     "failed to allocate IRQ vectors\n");
> 
> Is this comment accurate?

Looking at it now, it appears the comment is not accurate.

All error paths that follow will free this IRQ vector.
And the driver remove function will do so as well.

> According to PCI subsystem guidelines, pci_alloc_irq_vectors() requires
> explicit manual cleanup. Should the error paths below and the remove function
> call pci_free_irq_vectors(pdev) to prevent leaking system IRQ resources?
> 
>> +
>> +	ret = pci_irq_vector(pdev, 0);
>> +	if (ret < 1)
>> +		return dev_err_probe(dev, ret ? : -EIO, "failed to get IRQ\n");
>> +	msigen_irq = ret;
>> +
>> +	ret = chip_init(chip, pdev);
>> +	if (ret)
>> +		return dev_err_probe(dev, ret, "failed to initialize chip\n");
>> +
>> +	/* We're ready; the other function can now probe */
>> +	dev->platform_data = chip;
>> +
>> +	ret = function_xgmac_adev_add(pdev, chip, msigen_irq);
>> +	if (ret)
>> +		return dev_err_probe(dev, ret, "failed to add xgmap device\n");
> 
> If function_xgmac_adev_add() fails, devm_kzalloc() will automatically free
> the chip structure upon exit, but dev->platform_data is not cleared.
> 
> Will function 1's chip_get() retrieve this dangling pointer via
> dev_get_platdata() and cause a use-after-free when it probes later?

This too was a good catch.  The platform_data for function 0
will not be assigned a non-null value until it has completed
its probe successfully.

> 
>> +
>> +	return 0;
>> +}
>> +
>> +static void tc956x_function_remove(struct pci_dev *pdev)
>> +{
>> +	struct tc956x_chip *chip = dev_get_platdata(&pdev->dev);
>> +
>> +	pci_clear_master(pdev);
>> +
>> +	if (&pdev->dev == chip->dev)
>> +		chip_msigen_disable(chip);
>> +}
> 
> Does this function need a call to pci_free_irq_vectors(pdev) to clean up the
> allocated IRQ vectors before returning?

This will be added, as mentioned above.

					-Alex
