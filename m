Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3012E2D1F40
	for <bpf@vger.kernel.org>; Sat, 30 May 2026 02:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780106677; cv=none; b=akoxDUdBcla7rpcPyLhm1FiQ0VuCC51CAwnY/Jibt+JRJevaUse0BupkFZBDIAyNFAFFAjDFhLKn312/7W8qWsmbS7Hw9Pz9pQ1Te0jZXOq9R9FyFNvUxbPLJb6yp/TpwroTSFMnO2Slx20PIwGAgrDqyMntoIR1adyMRYKd3kE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780106677; c=relaxed/simple;
	bh=Y/uAtYU0hGHBj2ZxgA+qT2r6bUkE3/pceK4oBwgGrCw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OrXSHhdbwLiglMfd+72MFbM8zJMxAsiZZIs4e8qHHZ2kGqIbfdoGwZ1NRf7bIi9Gdn2VDRDLgi4jP/0oS1UkYjt9WQHpDvgpJqEK8vAPUbx6xALgZP97EFGrjR6c4laZhM2HBb06ZRj3M6byH40BJX3lOMTbU8Y0OYoScSo2SOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b=iShJyuRF; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b="iShJyuRF"
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-8b5232009a6so198517266d6.1
        for <bpf@vger.kernel.org>; Fri, 29 May 2026 19:04:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1780106675; x=1780711475; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Eg7o6FQ/jNrjMIrB2Cy8BBpIF+AjjaCmovvjHcE87cQ=;
        b=iShJyuRFP0q3sTs+oSQikMfNHylsPBKKuGkZLixirQUPpZhUFfEYrcokx5OhrLZWSP
         fBRaWmYI0tfSLM19Ny+OJANf3pdtUMrsMWWUwHQOhA8oOx1NIsTr3rIESs8ae86FsUPa
         mFiCfgkfr+rec1S33RCvMSWMd7lMe1bNqHAFfxEfdRzso7C/rTOoyTPX67k9dmN7qoqs
         7A52vSCESq3Vh16oMGF8rcyEBU3Qm0io+ZWsoA0DfJDbiTfFXz4medemI9NvzPVv2s32
         0NVbpv6ybZTK2FEGbZx9I72VM2yfVjvv8ypXZEW3lw2tvsGfCXcNgOtwXeG7UV5bSQ8k
         5eNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780106675; x=1780711475;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Eg7o6FQ/jNrjMIrB2Cy8BBpIF+AjjaCmovvjHcE87cQ=;
        b=TT0+2mdAsh6wSWsoWX86c1yvy6r69vBlYyFbcl+M+gaTuRuWelwe5hHqmZu+TAUK8u
         Kgn75T1dkvrgaCY0zqjhZL9EjL5VOIRyJJneHy8CNQRdHRB++PO2XB2AOctWhY3adbjR
         Jw0NLJlbMDBrMp82kY7mzVbzx5hqoUeAwLengv74RiOWW+ueIzqmTDAF8QIppBMWys/z
         2z253djI+GanM3qePp1tqbZLKqfIGHhMNwOfQuJIAGnWIDqITlRqrEx8qaKchDY4/5VA
         D908BSADOy0CbHvNSYHjMNMN7B3l0ajsmYYor8nzAL0aPfDRAL2AGC9gbbTeRkeC1mR1
         hRTA==
X-Gm-Message-State: AOJu0YwOiMyAClMcEDtk3e7Y2t7wWaQwRrnQ2dw/IcjIQQ3DuhNETJoj
	fgSm2nf8Vk8uXtCWbbvJsbJ7sXXKjRTipnhb8TVKfZ7FtlOYiEC+AMBab3LmHwLLWVE=
X-Gm-Gg: Acq92OGBbA862wFjTIn/jUGqF4zr0hXM+2WF5y7k8XJBPUMkWuv1+zyOfbMuS372FlS
	VUpQAO+PQLt7ZW24siSWX6teUX++B2kMIxp3Q4VW1b5WrthjJhSdT+iU8ATS7u2HwCgho8ahcQ8
	QaaCvnMD8l4zsrw0SxSKm+80xQwftQLfxoGsCBeZfu+noswLaR8yOdtjcRpRmJAyNyH6K3ticYH
	CFsb/Zo3OULLESDygsOxu8FCpx9DGUdPr3QQIj0xTl0WzUXtf5C7YN+pQh8rJ6/01jgrJgv+//+
	0SMxT9GndhbiyefVyQdXEkIe9N+9Q+cFQVDgCdU/5S9riR3aHnjww24Ea7k2oAQiuwew/f23QH1
	4A31Oi/UCEynGSosPDkyvpd40oGbj3ume1TWbUUuhCaGZWnOdKJdvph+4cqxH3yQuZ63A4V2Y2t
	kN82mLVXOimIc7EMTlm1ezCXL1ntoRSiIzlg==
X-Received: by 2002:a05:6214:540f:b0:8cc:d744:3251 with SMTP id 6a1803df08f44-8ccefb35c5dmr43536076d6.7.1780106675215;
        Fri, 29 May 2026 19:04:35 -0700 (PDT)
Received: from [172.22.22.28] ([73.62.185.64])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ccea06d4casm32658206d6.16.2026.05.29.19.04.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 May 2026 19:04:34 -0700 (PDT)
Message-ID: <1606fde8-7b42-4e43-a1c4-20fbe23956e6@riscstar.com>
Date: Fri, 29 May 2026 21:04:34 -0500
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 07/12] net: stmmac: dwxgmac2: export symbols for
 XGMAC 3.01a DMA
To: sashiko@lists.linux.dev
Cc: bpf@vger.kernel.org, Daniel Thompson <daniel@riscstar.com>
References: <20260501155421.3329862-8-elder@riscstar.com>
 <20260502155614.E4E41C2BCC4@smtp.kernel.org>
Content-Language: en-US
From: Alex Elder <elder@riscstar.com>
In-Reply-To: <20260502155614.E4E41C2BCC4@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/2/26 10:56 AM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Low] Bypassing standard DMA address translation via custom op-table overrides.
> --
> 
> commit 6c8a6ba67e29de7e71f5090bcca63c458ee9639d
> Author: Daniel Thompson <daniel@riscstar.com>
> 
> net: stmmac: dwxgmac2: export symbols for XGMAC 3.01a DMA
> 
> This patch exports several DMA operations and descriptor tables from the
> dwxgmac2 core to allow platform-specific code to override them. This
> override allows the platform code to perform manual DMA address translations
> required by the chip's internal AXI bus mappings.
> 
>> One consequence of the SoC-like design is that the internal AXI bus
>> (used by the XGMAC for DMA) maps the PCI DMA space with a non-zero base
>> address. This requires a translation step (happily just simple addition)
>> to convert the PCI DMA address to the hardware DMA address.
>>
>> This is pretty funky so rather than push that translation logic into
>> the core driver we intend to keep that logic inside the TC956x
>> platform code. In order to do that we need to export a few symbols
>> to allow us to override some of the DMA and descriptor op tables.
> 
> This isn't a bug, but does this approach bypass the standard Linux DMA API?
> 
> The standard DMA API natively handles device-specific address offsets, such
> as through dma_range_map on the struct device.
> 
> Could this address translation be handled using the standard DMA abstractions
> instead of open-coding it via op-table overrides and exporting these internal
> symbols?

I'm answering this on Daniel's behalf.  He tried setting up
the DMA range mapping but it did not have the desired effect.
He suspects that the involvement of an IOMMU affects what the
range map can do for peripherals.

Guidance on how to do this better is welcome.

					-Alex
