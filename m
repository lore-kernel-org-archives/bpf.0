Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25D64382394
	for <bpf@vger.kernel.org>; Wed, 15 Jul 2026 14:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784126810; cv=none; b=B4yTkTepWxR7V63zEVs4PpuULN/89lbHjCRhGfy8dRO+SCnXPv1l7gxzjbESWZGrGB864+GfVl0xzq7tuI8od5ARbF9LTn2ghL9rOvX8fDu3xx6jVlc98ZQvawl7atgj1v6VV6wHlpCDFy2BuTzPaDSzYC0nM0z06ry4u86iEN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784126810; c=relaxed/simple;
	bh=mo64BaUYAihjdcVVKQcSfM6eK8LWt+arXGZ+s8lWgfA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E+RZ5hVjDEus2SLXonlhvk9/x9E2yavuo1EwldgnUzxt63R68PZOW5ZuZW/5ajXuW4l/ECQI2T0MW3i7UhHAE4R4E/2+Z7dWPRyv42E41QxNdIFWbg+NCgSVvZYav2VFiTbVUZMMSGQDNV9LsRPWq4VmggeFkv8Mi/5iD7R+ZF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Wm0338i7; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Wm0338i7"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-69a50189d25so9857658a12.3
        for <bpf@vger.kernel.org>; Wed, 15 Jul 2026 07:46:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1784126806; x=1784731606; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xqdxpiRH6Z2ScU/4HRU79Jz4czUFiYR0vIxP6WbDz1c=;
        b=Wm0338i7irtGkRSuNQvmQHZWfN4mOL3eE83FtdJlP4x0/0bjfgwPnPYeP4cCxPrkk6
         rrV+2wOtsOwaWdLfJOurOKJqcORt89jQGO3kQ4DLMVAI/RhTujm+H4zmR3IINt71swvR
         R6TAbD+jLK9uUW4wvWyQT73zhNPj6OQd3WjLGsYtDmuB0SXmCB9OwZSbQ+gTphqOtCBe
         BW+iy6+1d2vuvJFq901J32wk81APqGB2n7ItuDJk8lRhG7sn/S9IO/uebkXfMOIen1QR
         RjPxgarqxgmirS5yXXCr70dXq7pXuyI8df3ftS0ojqzC2gUdv6J6Y/lnVOCoDhCUc6XT
         x92Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784126806; x=1784731606;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xqdxpiRH6Z2ScU/4HRU79Jz4czUFiYR0vIxP6WbDz1c=;
        b=F6IO77ya8a721svHVdDTpuW1Qk9BCvLApvFEA6QdvvLi+F7N4zbqpfq7sCmUB5SDoF
         OGlmvPO7xUotIM432x8qaT5Se5GPGdgK1S+Toba6bi5juODIyQhZwR/P5HGVUlPO7D3x
         lAGIFT4SnqVNci2pf2EKKHvv2Si+cWPa2GMWA1vdCJCHCY0oOZgXvHMR/9AoUXWxkZW0
         0QEGgpZBhfxSdwfvi956dgb28Nl3nWO3qGNKqXalz0pougeyccPKg3sCMPZ9Co3Bp1NC
         sKdnbSPEII6nFsA9xGUk4Jkzgc1dSwGuirJa8l7XI5jASp4Cta3uLyiGGmNgOoHl3RYs
         1x1Q==
X-Forwarded-Encrypted: i=1; AHgh+RpdtrEcJHTxWjp8758Bc5+pNqpLME/N3KkATxwnNLbl8q5eMxyrS2fLOdS1UIB0tEEnV1M=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYDFV4W9N6kfoeM0Xz7nkOTx1qsqpAUi7+cWMhGtCWReHG5koF
	hXwGJ3Qyh2kv7nIqRyKOykOj/5UA1mRdRbtAjcGFVNnsvyFnLpWK+pBwuLp9ucbpgHY=
X-Gm-Gg: AfdE7cn4kSDDYZDqI9rKze0EGvI6ipN0cfjj92zILyJMqKau7RbpfVQLqHFZVXYIX7X
	zE4XNeyqyLNLXJc+tRAIbQg5UyQKdnGdXeDa6sz3yoFuTcY6fYvJb+MDvWEzf2wEzpIRoDHyCTR
	iP5IAy6hx0b2qKaCPonu+rLbmElWNNiFAljRiVk8CScb0ypjUx4TGur1cxKgrvQlddWHFa1Vmah
	rJ8q+BjwvBWd9jMNGlSd6LoOgO0enDOWqJTyMiOBjUt7gtkvh1T1YFHmBWy4+8aLcgj1nb7d/GH
	k9ob5NQClyG8SQtUONk87RE6irBh23uq/wcwSuiOnAYe0tLu7w3CNDDVdESh7Oz54ppXzrBi4u6
	7mtZKRmXiQX0Y8prU0Qfzv3B92ppZT7HuCLYhxUpf77HM70V5fq7Z5k+vNxffD7B9E9xhaU7MLf
	O/8i4ysKPyzh5/TdbVvdYjVW4=
X-Received: by 2002:a17:907:9451:b0:c16:7402:1abc with SMTP id a640c23a62f3a-c167949a4ccmr216570466b.47.1784126805726;
        Wed, 15 Jul 2026 07:46:45 -0700 (PDT)
Received: from [172.27.236.118] ([212.187.182.162])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c16873187absm45796466b.38.2026.07.15.07.46.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Jul 2026 07:46:45 -0700 (PDT)
Message-ID: <617b1d89-35f5-4dee-9aeb-eac7a0d34d38@linaro.org>
Date: Wed, 15 Jul 2026 15:46:44 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/5] tools/build: selftests: Allow versioning LLVM lld
To: sashiko-reviews@lists.linux.dev, Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: linux-perf-users@vger.kernel.org, bpf@vger.kernel.org
References: <20260715-james-perf-llvm-version-v3-0-8854bfe5af7e@linaro.org>
 <20260715-james-perf-llvm-version-v3-4-8854bfe5af7e@linaro.org>
 <20260715124513.8DA9E1F000E9@smtp.kernel.org>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20260715124513.8DA9E1F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 15/07/2026 13:45, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [Medium] Bypassing Clang's internal linker path resolution causes silent linker version mismatches for out-of-path toolchains.
> - [Low] Unbalanced parenthesis in the `USE_LD_ERR` error messages.
> --
> 
> --- Patch [4]: [PATCH v3 4/5] tools/build: selftests: Allow versioning LLVM lld ---
> commit cdccb2d14502b0641ebfd4e8ddb945bdb605ed46
> Author: James Clark <james.clark@linaro.org>
> 
> tools/build: selftests: Allow versioning LLVM lld
> 
> This commit updates the BPF selftests Makefile to use the LLD variable
> from Makefile.include to ensure consistency with the rest of the LLVM
> toolchain. It explicitly resolves paths to the linker via shell commands
> and passes the result to clang's -fuse-ld flag.
> 
>> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
>> --- a/tools/testing/selftests/bpf/Makefile
>> +++ b/tools/testing/selftests/bpf/Makefile
>> @@ -264,30 +264,34 @@ $(OUTPUT)/%:%.c
>>   
>>   # LLVM's ld.lld doesn't support all the architectures, so use it only on x86
>>   ifeq ($(SRCARCH),$(filter $(SRCARCH),x86 riscv))
>> -LLD := lld
>> +USE_LD := $(shell command -v $(LLD))
> 
> [Severity: Medium]
> Will this shell resolution cause silent linker version mismatches if a user
> builds with an out-of-path compiler (e.g., CLANG=/path/to/clang) without
> setting LLVM= or modifying the system PATH?
> 
> Previously, passing -fuse-ld=lld allowed clang to natively resolve the ld.lld
> binary relative to its own executable path. Bypassing clang's internal linker
> path resolution with `shell command -v` might cause the build to pick up a
> system linker (like /usr/bin/ld.lld) instead of the bundled one.
> 

I can just drop this patch. I assumed $LLD should behave like the other 
tools, but it's only used here where the compiler already picks it's 
sibling linker with the correct version.

>> +USE_LD_ERR = linker '$(LLD)' not found - add it to PATH, or pass LLVM=/path/ or LLD=/abs/ld.lld)
> 
> [Severity: Low]
> Is there an extra closing parenthesis at the end of this error message string?
> 
>>   else
>> -LLD := $(shell command -v $(LD))
>> +USE_LD := $(shell command -v $(LD))
>> +USE_LD_ERR = linker '$(LD)' not found - add it to PATH, or pass LLVM=/path/ or LD=/abs/ld)
> 
> [Severity: Low]
> Is there also an unbalanced closing parenthesis here?
> 
>>   endif
> 

