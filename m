Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F8813FAE07
	for <bpf@vger.kernel.org>; Fri, 15 May 2026 08:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778833517; cv=none; b=u6ONUZv6Ae6wep81q/AVuFc+L0Brtcj7Qk4u52S21NjVXdrOe+qLHgxsV14m9wbcn2OLyL1NG8FjT8gQoFdcRdvjIB27VaMv/Z+wpD0PPyUsl5Swr+0XhqT1R7OFg4eQEb29fiUOrfMRYjkxYBjDdQ15kUne8gryyHxMwkbKfUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778833517; c=relaxed/simple;
	bh=x7M8QMRLEdW4Rrh+jkBoFBRBtP4oSw/c9kEx6akVmCc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Npox8hnCBsFuqNStcdikfkLlKCPZ4C5gS3LYU+Tb1If8d2XND7DNQRLEinDWu1C3J6l2fOVLLpEe7VqddGT8l6F1YbNYVedFUvJJr9QjFGAkLNqE1ka43lWtJIyun16Gvc19IpgE1ztvXhZy497Pp5JPnDwjZoqimFRvVyVCv6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CYGt7kLH; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CYGt7kLH"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-44b052142e1so4962187f8f.1
        for <bpf@vger.kernel.org>; Fri, 15 May 2026 01:25:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1778833514; x=1779438314; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=B8R9wMI16Tg8iAgIRKSdM3jyUIf/EyyLOvedUo+31Xs=;
        b=CYGt7kLHSS2S0vz6UYTjOiFc+6gmfJJuZAhKUQCpJrSGAu04qsPGT3ZjJoRYqJkC7Q
         ZfTovfnnheBgbieDa0eF2Bd36NAYAS6Ny+pPxKPkmjCL/DX/PdaF/O1uQG4X4s1jKH3B
         7K/4p94A8FpJVcUxpRMqsO8HQKAGvsJTUUtvYF2YZdd+rchtECuBxdYJ+t+iQ/qLEybx
         0x7mvfS8R9W9kTzZ0573NRlV7Wxs4uqxzuvsHZBHQwB4/NQ4IAzsN7tu3/hRkghZxGFf
         KxSAm9GGqVVrK1PISzmHGd3KNPVv3WSwlzKLdzFerikad/6W8JDjgLEp8R/aGLeYmK4n
         Oaiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778833514; x=1779438314;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B8R9wMI16Tg8iAgIRKSdM3jyUIf/EyyLOvedUo+31Xs=;
        b=iGly1+8BqH/dA/+V2PQZpdLI30nnSlx3AmrBEcY9ctCgiEmZIL2DZBDB7pgRJX03kY
         9abZtca0bb4gx6VN+JgNeE+Yo11XvFIGJe7rpEmABkRT8+YCfHVuRJdwivLT1qdXLqxQ
         RhU1otPTceh0e3BNxjJ60MXFMrj0LzR6SK/OAZbZRoa9ShJ0yxnjs3HjdlVX51Nn5hMt
         h+DFpG3poam32dZJvtc6WyBXMeR9izwvKpZfso2V6w3w6AhiGfRQ5xUtouLMNAnOPLy/
         AseH9JSyIhqbeHhI3lE7r14pyuODrPnDfSyKNNJtWtus7imdnSuxxLa1bPM/RqsG+His
         voPg==
X-Forwarded-Encrypted: i=1; AFNElJ9laUaVQnBLQIKWH2rgECsNfCdvyeKsnugBBUkXysAHFbqui1pyiS4ifNk2GVE6VGm2KHA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxt7cEVzbu6tJSGQ+NHR/3oQgIvRkdCjCNrndh5Bx+luMItWvEt
	sz6vHlKtBJpZDFyghjR62e6wNEWNGyUvx88+t9yc3MJBvmmC7iVJWRZr2YnjoQoYEO4=
X-Gm-Gg: Acq92OEOCtqYGod0SzHa7WxqBiiBqjSN+D7L5B/9YNiC9VuHwWalsHC2xfpfGUFjonF
	LSr3e/NgaTpvaB3Zqe+gDG5/2Dhe+2WUmM36Y6Exq7nTgP1uD9IQ5HyHwpBs10WATXx15jcQH0Y
	ClWC8O1GoMFhO+AsCVW3scOsz9XmvPebHLszlInKhPi5niH2/5hWUiUicHiHqDMff0BqABlzhwt
	qYCSnp3DpTa2z86W3eiUNSBFZgv5ysNR5pr0xKWEMf7xOhE1P5oq68cSeoV/vsWUJzf4WKkoLgA
	DQ1gKb77sAo5aogmo5WnR1mXWjACkcDNaj7pItviPNKFh2nvzPm5pafI44MNNU/RSKAJ64dVC/W
	6A2vVnZB/7LsWpE5eOdVD6zBWo8d3862UjMN/5Kl4Msgg/ogeg5lvQPF/uXxzlbjsiWX/8ab3fb
	itNAzhCrjuQuczK/P77ndmFoa0b94hlOmsePEaw0g=
X-Received: by 2002:a05:6000:2c12:b0:452:87de:d3a6 with SMTP id ffacd0b85a97d-45e5c6048d1mr3580229f8f.33.1778833514418;
        Fri, 15 May 2026 01:25:14 -0700 (PDT)
Received: from [192.168.1.3] ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45d9ec3ac86sm13115730f8f.14.2026.05.15.01.25.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 May 2026 01:25:14 -0700 (PDT)
Message-ID: <69034d26-e886-48f2-a20b-524854a5c00f@linaro.org>
Date: Fri, 15 May 2026 09:25:13 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/6] tools/build: selftests: Allow versioning LLVM lld
To: sashiko-reviews@lists.linux.dev
Cc: dmitry.torokhov@gmail.com, bpf@vger.kernel.org,
 linux-input@vger.kernel.org, linux-perf-users@vger.kernel.org
References: <20260514-james-perf-llvm-version-v1-5-6cac1a9a4c8d@linaro.org>
 <20260514184543.C6400C2BCB3@smtp.kernel.org>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20260514184543.C6400C2BCB3@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 14/05/2026 7:45 pm, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] Using `-fuse-ld=ld.lld` breaks compilation of BPF selftests with GCC.
> --
> 
> commit 18e1876d18fad631b521da817483ba47293a9020
> Author: James Clark <james.clark@linaro.org>
> 
> tools/build: selftests: Allow versioning LLVM lld
> 
> This commit updates Makefile.include to add an LLD variable, matching the
> rest of the LLVM toolchain. It modifies the BPF selftests Makefile to use
> this new LLD variable instead of hardcoding lld.
> 
>> diff --git a/tools/scripts/Makefile.include b/tools/scripts/Makefile.include
>> index 380ad84ac51e6..5c2d505cba62b 100644
>> --- a/tools/scripts/Makefile.include
>> +++ b/tools/scripts/Makefile.include
> [ ... ]
>> @@ -91,6 +92,7 @@ else
>>     # Some tools still require Clang, LLC and/or LLVM utils
>>     $(call allow-override,CLANG,clang)
>>     $(call allow-override,LLC,llc)
>> +  $(call allow-override,LLD,ld.lld)
> 
> Could setting LLD to ld.lld when not using LLVM cause issues for BPF
> selftests compilation with GCC?
> 

$(LLD) is only used in one place, and it's used with $(CLANG) so this is 
impossible.

>>     $(call allow-override,LLVM_CONFIG,llvm-config)
>>     $(call allow-override,LLVM_OBJCOPY,llvm-objcopy)
>>     $(call allow-override,LLVM_STRIP,llvm-strip)
>> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
>> index 6ef6872adbc3e..44ba829e5d4dd 100644
>> --- a/tools/testing/selftests/bpf/Makefile
>> +++ b/tools/testing/selftests/bpf/Makefile
>> @@ -245,9 +245,9 @@ $(OUTPUT)/%:%.c
>>   
>>   # LLVM's ld.lld doesn't support all the architectures, so use it only on x86
>>   ifeq ($(SRCARCH),$(filter $(SRCARCH),x86 riscv))
>> -LLD := lld
>> +USE_LD := $(LLD)
>>   else
>> -LLD := $(shell command -v $(LD))
>> +USE_LD := $(shell command -v $(LD))
>>   endif
>>   
>>   # Filter out -static for liburandom_read.so and its dependent targets so that static builds
>> @@ -258,7 +258,7 @@ $(OUTPUT)/liburandom_read.so: urandom_read_lib1.c urandom_read_lib2.c liburandom
>>   		     $(filter-out -static,$(CFLAGS) $(LDFLAGS)) \
>>   		     $(filter %.c,$^) $(filter-out -static,$(LDLIBS)) \
>>   		     -Wno-unused-command-line-argument \
>> -		     -fuse-ld=$(LLD) -Wl,-znoseparate-code -Wl,--build-id=sha1 \
>> +		     -fuse-ld=$(USE_LD) -Wl,-znoseparate-code -Wl,--build-id=sha1 \
> 
> When LLVM=1 is not set, CC defaults to gcc. The Makefile uses
> $(CC) ... -fuse-ld=$(USE_LD) to link liburandom_read.so.
> 
> Because USE_LD evaluates to ld.lld, gcc receives -fuse-ld=ld.lld.
> 
> However, GCC's command-line option parser is strictly hardcoded to accept
> only specific linker names (lld, bfd, gold, mold). It does not recognize
> -fuse-ld=ld.lld or absolute paths, and fails with an error like:
> 
> gcc: error: unrecognized command-line option '-fuse-ld=ld.lld'; did you mean '-fuse-ld=lld'?
> 
> Does this regression break the default GCC build of BPF selftests on x86
> and riscv architectures?
> 

Same as above. $(CC) is not used with $(LLD). You'd probably want to use 
$(LD) in a $(CC) build command anyway.


