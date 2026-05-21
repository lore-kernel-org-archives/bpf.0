Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ECC932B125
	for <bpf@vger.kernel.org>; Thu, 21 May 2026 13:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779369387; cv=none; b=pqGw7kVIsUpPxssIyMXnGimytgAj/2vPuPb5p7WWzrI79sSecZrG75WSxWnHIRCjgiubaaXe0qoP4T7PBuPbSZvOpUfUqYUtXbJXudP23T2nx3MGvV+16gEJDg+1wxdI5c6kkizbthZoxlgzkQNMTE2/A4atvor01/+MwwLC0k4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779369387; c=relaxed/simple;
	bh=SaPZiPenwdTzqGiHu7Uj+sL3JfcCMs0SGRnnVz4i/yQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HIY9GPuoDU7F2I4seThRSiGAORETuRoIrBEQeDWRpfHeOxxUIyD5QkR9zfP/KRT/fCxtwyyCG+l7OeZ1uUGFMV6DnLHjuHV/0BFnLX0lZ29+2IbFIlATOP0NlTB5fsueh5AlAk+L7yfteM+l4YtaS238hA4hJ2h14vMonGDgw4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nId4Y6+i; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nId4Y6+i"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-67c2d57a5ceso9729136a12.3
        for <bpf@vger.kernel.org>; Thu, 21 May 2026 06:16:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1779369385; x=1779974185; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RqVGYnj73pC8tzdaFr6gsyXtunlM26AM6XUG51yicB0=;
        b=nId4Y6+iuVJiUKUZVsYGDDRF+POui5/LWGoUhN4nVQyf+jbFs9i+JJ8lYxr+QDKP6z
         RMljv/X9d4TDsd+BEfHXNjecU8ieeePM5JPiu7xo1CvBJTPiqS08/Qy39opzi3uOCUgf
         oy9IbK1qppoUdh2YJmVoSV2DJqYPSijJ298XmAZNlQlIvUYIpXtPbqq+AQKOr26q7Vly
         QG52VeEdL/ez4J7u0Pe8f6uErkwzaP3SWcfOhJ5vx4n0sl7ZQEKWO6K+by9OBAut6Eta
         M5ipzH0zcCxXpJkswih9Ee3K9vPlpbHSjwnXzpQLxvUQbY67nCzIKnYOZ6S9jirqtQa4
         FVfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779369385; x=1779974185;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RqVGYnj73pC8tzdaFr6gsyXtunlM26AM6XUG51yicB0=;
        b=mJyLswPv4SrtJOQBmwIBkpZ9Md3rRGTUuqeOxx5JPje+FpViybOcvJ3BZAalLiEpY/
         0LGlP2cTy1ZSb6WMxkmibCufTKAYW4OTfazWkCSw6xK6We/b1Qnw9N6dyPAtyDz4x8BM
         PczW2ZS8LrM4ATnIbB5EUdL2QXgdvLlpg50uG9IBZtGGDoS2TvZS0cJnpw/AFZ0RvtWa
         S8whlnH56k/yypG7G62amxtLNecB5uwIBpiG111DVPJXralY37YNzvL7QfBDmlwLs0ww
         9+zJW08KYYeR9rzttEAPC+m1geWRO77oCFCiedm9uK53C9A0qIpFJSKAcGwcUpOZwr2Q
         rB8w==
X-Forwarded-Encrypted: i=1; AFNElJ9g4mr+RsKGEKY7O07xDsUGh1gPCwwme88ZXya43tzv8LqMc9KQmGeGy3fcfAQ8vAZj+tI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGOR2M7XoIMBTymVAn+75YMK9cUYYb6ll1Zgn0kJuVz9cov01q
	eonJdaseHRoPt8yC0y4FuOfFXosa7CFR05OSqDy7hnIGlzmtkBN3CRZOkVTlI7XeZA5FIZtFI8q
	jwq1Po5Q=
X-Gm-Gg: Acq92OHr/J7h3FVOmVxvqueUK9w+fugftnxN8yB364QLUvqJf85+XVIB9VNDyg4Yb8U
	THR/asNJueIkMh8zCJbJBsT2N3O5DfqD4EQSEeAfVh3q8b8UuXVsyuWnX0ifIqlli6kun22lB0H
	KAT/FLNXmwz7IrMGqXek7vs6nRDXR8+3I02xvlA2sB6AwPUBf60FzLVotG4UjjGAlWxLgA4Pe/U
	HZP94yG0++qnUhmrxGDZ2jvWLLrSjLFHVZsY1+Pw9S7ocvLHF6H/ZTI68eC2vSdDtHUaYxJ15hL
	w70x8VwFkwqIjbdJ1xLHXzTQmajpCi58VBSoQoqzBS6xBTGWliroLImgH8hcJc++3+3zxccIYzy
	1yV267/sOxFZbFx3/hvyWeORxriAdvPO9zmLg8nTOLueQaA/xeZyZsDrH+Ot8zmojstxxjKK8aR
	MOkRI1bKuASoQEwvD7js4tgYEIrsdWuj/3VPpyjr8=
X-Received: by 2002:a17:906:5a41:b0:bd0:6dbe:22b1 with SMTP id a640c23a62f3a-bdc121ba82amr126088266b.12.1779369384498;
        Thu, 21 May 2026 06:16:24 -0700 (PDT)
Received: from [192.168.1.3] ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45eaa92de9asm2799089f8f.17.2026.05.21.06.16.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 May 2026 06:16:24 -0700 (PDT)
Message-ID: <e060c4cf-59fe-42f0-bb05-adb520a6c80a@linaro.org>
Date: Thu, 21 May 2026 14:16:23 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/6] tools/build: selftests: Allow versioning LLVM lld
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
 Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: sashiko-reviews@lists.linux.dev, dmitry.torokhov@gmail.com,
 linux-perf-users@vger.kernel.org, bpf@vger.kernel.org,
 linux-input@vger.kernel.org
References: <20260518-james-perf-llvm-version-v2-5-f12cc4f031d8@linaro.org>
 <20260518093237.90640C2BCC6@smtp.kernel.org>
 <ef5688a7-3e1d-47be-aca7-cc6e564e059c@linaro.org> <ag4QkPOCQ5LWy-U3@x1>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <ag4QkPOCQ5LWy-U3@x1>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 20/05/2026 8:50 pm, Arnaldo Carvalho de Melo wrote:
> On Mon, May 18, 2026 at 10:47:53AM +0100, James Clark wrote:
>>
>>
>> On 18/05/2026 10:32 am, sashiko-bot@kernel.org wrote:
>>> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
>>> - [Medium] Empty USE_LD variable causes clang build failure in selftests when ld.lld is not in PATH.
>>> --
>>>
>>> commit 371ca22c55bb0fa6502ac06f7b33d63418ad16ff
>>> Author: James Clark <james.clark@linaro.org>
>>>
>>> tools/build: selftests: Allow versioning LLVM lld
>>>
>>> This commit adds an LLD variable to Makefile.include to allow versioning of
>>> LLVM's linker, keeping it consistent with the rest of the LLVM toolchain. It
>>> modifies the BPF selftests Makefile to resolve the full path of the linker
>>> using the command -v shell utility.
>>>
>>>> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
>>>> index 6ef6872adbc3e..836e783f0170e 100644
>>>> --- a/tools/testing/selftests/bpf/Makefile
>>>> +++ b/tools/testing/selftests/bpf/Makefile
>>>
>>> [ ... ]
>>>
>>>> @@ -245,9 +245,9 @@ $(OUTPUT)/%:%.c
>>>>    # LLVM's ld.lld doesn't support all the architectures, so use it only on x86
>>>>    ifeq ($(SRCARCH),$(filter $(SRCARCH),x86 riscv))
>>>> -LLD := lld
>>>> +USE_LD := $(shell command -v $(LLD))
>>>
>>> Does this cause the build to fail if the toolchain directory is not in the
>>> system PATH?
>>>
>>> If a user explicitly specifies the compiler using an absolute path like
>>> CLANG=/path/to/clang, but does not add the toolchain directory to their PATH,
>>> the command -v utility will return an empty string.
>>
>> If they don't use LLVM= and use CLANG= with an absolute path then they need
>> to set all the tools with an absolute path. That's the problem that setting
>> the path with a prefix for all tools with LLVM= solved.
>>
>> I suppose this could _technically_ be a regression, but so could adding any
>> new build rule that added a new tool that wouldn't be set in someones
>> existing build command. Being that strict would mean we can't ever add new
>> tools so I don't think this is an issue. And I don't think there's a way to
>> solve this and also respect the documented rules of LLVM=
> 
> Hey, this touches several tools and libs, did you get acks besides the
> one from Ian?
> 
> - Arnaldo

Only the build bpf failure report from Ihor on V1 but nothing from 
anyone on V2. Ihor did you get a chance to look at this version?

Thanks
James

