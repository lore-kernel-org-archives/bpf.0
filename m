Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EA532F7F1D
	for <bpf@vger.kernel.org>; Mon, 18 May 2026 09:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779097678; cv=none; b=iF6UApXx5iuwK+atiKRGf/Me+PUleMKZRKSqUrzhK8mBj5yqoq5Sdm3N7NWLNQ92OgvyC4gOIxDpbcEQHGIMqqczWc2CcJvsF6W/5H3vgGViTA7hCCuJbeqvHVdmbi36ZfJQnRwidiLH8nhd6/R+UYH40Qw9YwaFdcuOcWgLliA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779097678; c=relaxed/simple;
	bh=kQwAY/l0CYICe34k0IpNyn+TG1YD4kxDzsA4u0x5DHg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PMXvFXPjPsB+VW3Xnt++1yvT/qQRaDxqmWB3QNaTnmmMzYjq4mNFvoL6IoltRwOY59CSpAiTL2VnjJrSVPzBu94vgcLxYVUgNS5AfdelnhBi91ko5yts8OJRF9e+bxs+c54yUAo2fjQd0IJikS5a+W3ma5kqtCv78p5uhmc0Yng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OLrwMiH4; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OLrwMiH4"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-48e56c1bf5dso9192785e9.3
        for <bpf@vger.kernel.org>; Mon, 18 May 2026 02:47:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1779097676; x=1779702476; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=T/EO1D6TrcoAaYAZG0MsX8/FpcPXBdwplKszfXP85PU=;
        b=OLrwMiH4CQtgKscf4/rdKN+2eUNFBwGtIQoIjOQYGsQF170r3tnj1mx0+nuoV0Pp+c
         C32LKxRuFq14cKbZ9wBBnDo0v2eXxJnuKXsXWJ5vjmm7Hg7Oef85al4yfax/KSUwz21w
         c4zdR8W+dV/SJjIOI6sAmfhngxRAtIIcWEX8G+a9B5Vm/Q9HjUwWzglyXVDNnp4g62Fj
         Z0OvszHSolcGTOXOOtutb742fX+BkxOH33esJoJhpUZTl2UyN7Bo4I2PS5G6MPS1SnZw
         nDc9VugIjDR9gsQxfMdeAI3kniNT/VHEozB6shE2A7NpHf31i0khh5PQ+12RrdVKn2lt
         T04A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779097676; x=1779702476;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T/EO1D6TrcoAaYAZG0MsX8/FpcPXBdwplKszfXP85PU=;
        b=jfcXVvQEesvMQ0Qozw7NeFFJVVwajspFPFVXgbuoyPsrYSTrcorUkLMQIa7cKe3do6
         O2DyjXQDzLqdbFgKra2CepBlNE2mVsEtINtWqQ+m0o+EMcTpLa3+Q1svgDofibhvTAbi
         iNPmooDoCTyOEvPxJuHCA1D2s/UeK7oBq+o2ZKPfec0i24iFpGeceMCTdynhF+XNquwU
         0ycr3Ani6rDhErxa4P/frdLN3M13xLGtse0cegRi5FIQT2x9IPZFO8Mzdx//SpaG1MZY
         y5nmt4iHQNRenlzmzTqeK5SYPhurEk7k5RHln6N1BMlFJmlnL3+pzODCblr94Wkx0igW
         YGTQ==
X-Forwarded-Encrypted: i=1; AFNElJ89PnOmgRmqOcXhOmdFIKHKfu6zHOd5JTHrS2xatqew5Q3yiubxvXuiKnDclcwEKLIy54s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yws+xu324fZYl9BOFVdh41+fpO1xw3MBio7WV6ZXSy5xTJkkgJ9
	G3S/0j0KF9eaD0F8utbB9wgsG7iqSdPt/FPlV0K3M6NSoVbwTKQHxhlktGoeOv2M6bM=
X-Gm-Gg: Acq92OFTOKu/MKbghrIci6xvQGblXtXEITOPZ3aPpZWWaW7ayZLl6g2SwJp7iMyYOn6
	5uHwvlT8yB6K7EiGvefnPg8KktDwQK2zZMEcqYXpGsLvtGpIpsdBeVHhHo1q0+xb1GazqiZPvCC
	1uafR6/18L9JQiSwkvMMSInFdOWr/hT8qrWvK8nhbxheE1tTCtKchUfJUkf6LympVLFGtok6Gju
	lgQZTq2JzyVS6lABi3TEbiezt6SWR2kyEpDaTKlqkyhIpNfSkuPMdbbTl5zNrGSJe003BdM9W1R
	3B5ViZjLG9il2R8YcZtU+IVcI1F5Tikh7mW9ijcKTiKQs01td7W97vTBAeb+4lpJfeGlT+pw0RE
	cgZuIQi10jKBV8gmJDvnMx+tax3zYQ4vcB6YpARoRQGSI/cK1kKmlYaZz/Oue3qZ5365gRb4s5A
	eQAhyt2W3c79Zs7UZNPUElgkA9fmeE
X-Received: by 2002:a05:600c:34d4:b0:48f:e245:394e with SMTP id 5b1f17b1804b1-48fe631f631mr226307655e9.27.1779097675702;
        Mon, 18 May 2026 02:47:55 -0700 (PDT)
Received: from [192.168.1.3] ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4900c16c744sm58005165e9.3.2026.05.18.02.47.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 May 2026 02:47:55 -0700 (PDT)
Message-ID: <ef5688a7-3e1d-47be-aca7-cc6e564e059c@linaro.org>
Date: Mon, 18 May 2026 10:47:53 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/6] tools/build: selftests: Allow versioning LLVM lld
To: sashiko-reviews@lists.linux.dev
Cc: dmitry.torokhov@gmail.com, linux-perf-users@vger.kernel.org,
 bpf@vger.kernel.org, linux-input@vger.kernel.org
References: <20260518-james-perf-llvm-version-v2-5-f12cc4f031d8@linaro.org>
 <20260518093237.90640C2BCC6@smtp.kernel.org>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20260518093237.90640C2BCC6@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 18/05/2026 10:32 am, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] Empty USE_LD variable causes clang build failure in selftests when ld.lld is not in PATH.
> --
> 
> commit 371ca22c55bb0fa6502ac06f7b33d63418ad16ff
> Author: James Clark <james.clark@linaro.org>
> 
> tools/build: selftests: Allow versioning LLVM lld
> 
> This commit adds an LLD variable to Makefile.include to allow versioning of
> LLVM's linker, keeping it consistent with the rest of the LLVM toolchain. It
> modifies the BPF selftests Makefile to resolve the full path of the linker
> using the command -v shell utility.
> 
>> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
>> index 6ef6872adbc3e..836e783f0170e 100644
>> --- a/tools/testing/selftests/bpf/Makefile
>> +++ b/tools/testing/selftests/bpf/Makefile
> 
> [ ... ]
> 
>> @@ -245,9 +245,9 @@ $(OUTPUT)/%:%.c
>>   
>>   # LLVM's ld.lld doesn't support all the architectures, so use it only on x86
>>   ifeq ($(SRCARCH),$(filter $(SRCARCH),x86 riscv))
>> -LLD := lld
>> +USE_LD := $(shell command -v $(LLD))
> 
> Does this cause the build to fail if the toolchain directory is not in the
> system PATH?
> 
> If a user explicitly specifies the compiler using an absolute path like
> CLANG=/path/to/clang, but does not add the toolchain directory to their PATH,
> the command -v utility will return an empty string.

If they don't use LLVM= and use CLANG= with an absolute path then they 
need to set all the tools with an absolute path. That's the problem that 
setting the path with a prefix for all tools with LLVM= solved.

I suppose this could _technically_ be a regression, but so could adding 
any new build rule that added a new tool that wouldn't be set in 
someones existing build command. Being that strict would mean we can't 
ever add new tools so I don't think this is an issue. And I don't think 
there's a way to solve this and also respect the documented rules of LLVM=

> 
> This would cause USE_LD to be empty, leading to a malformed argument like
> -fuse-ld= being passed to clang later in the Makefile, which then fails with
> an invalid linker name error.
> 
> Previously, passing the hardcoded lld allowed clang to natively resolve the
> linker relative to its own binary location. Is there a way to support both
> versioned linker names and absolute compiler paths without relying entirely
> on the system PATH?
> 
> [ ... ]
> 

