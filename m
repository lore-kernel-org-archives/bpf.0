Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5895431619B
	for <bpf@vger.kernel.org>; Wed, 15 Apr 2026 16:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776269004; cv=none; b=pWK9vX8w9TNxcgB4hPlMy6w8TXoDRu7cqlNBG67dtvf7YAxCRwNY/aK8NIe3jB4mITzMyo88dC+Ffaen2dHNPrPMO0uR8i9XS0d2JYkEpiq7Ri9c34nSgugLoXGE6KbwlNmRNht44bMKVAG24erO2OT7CnSZ3Fzc06xMULZ2Hzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776269004; c=relaxed/simple;
	bh=RERTq8I3MIF1yMkiB6wZkHJkgJHv+ltcECYK8aKlT20=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EpnYQtuifXZByPZ0acFgB6OU3tRLrmEiOVTw0GkFfo8tgVyEo5YzcIXsdnTSgOjm4jGjZ1GH3+TqoLPItarlFeBGLElOm+tXgGI/z1BpwCWOxlxF8Vy5zCEjYQAqnDiKg6DXauZ/wlroQ0+YQoSXZb0vZ9ubvrljNsTSTQ8gy1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iUrotkQn; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iUrotkQn"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-43d70c30767so2338191f8f.0
        for <bpf@vger.kernel.org>; Wed, 15 Apr 2026 09:03:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776269001; x=1776873801; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6aoMj0PyvdjaOSOF6R9+rApmF70RjoEgTTBHQu7dCmw=;
        b=iUrotkQniuAiCMCpz95adUmYDNrzHKU2fxsPMf7eBiy4Z9bDYwsQWIYUpEoFVoWRgH
         maFcP7yd0a4kQm6Mh9o1knr284/KwvRAzUrMZQqeMuZg8RKofPbMXFfLaQck3ffO/R/f
         0ZFs3HKCPIfMLyvDYENyY+uaqjWF46NGp625Eea36YHYRq47cvZL17f9XDqfDLvsazid
         OuUSyQP1PNuqjvhAT+iWlaCOIwfDviUkpyUV9cAf2XzPyyIihAJTjJnahcjhADM/KIgm
         rvgqvXC62AG6Vw6Gf+JOHBpUydwEwMGP5FyjyQn3AsLxSRWc/+N9vzQ79oij+lha4PQT
         hrOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776269001; x=1776873801;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6aoMj0PyvdjaOSOF6R9+rApmF70RjoEgTTBHQu7dCmw=;
        b=LWUQyBmPm/B0/kxq9on0v1cvUXKNqqVNIXXOJRo/BQHmQYeP77L+6nuUL0nTnzdSlz
         kYU4TIs4WU1VcQ+bmpfAvyKbOTN5cWGWkHCNgzYmN7bPXdKqYer6uEZ2OSyVRK87KF5s
         RN6F9E7141o0nLj7v5m1VnIBcu9F8Ym/pk4xV7cR5SrZ3habyh0Rp1pmNxti2W2YqrKC
         u8TH50/D7P43hflL9Ews6AivplC2w/4KricdggxC28Okd1WoVtgynKibRZg65bTogS4i
         dMiW3CuwI2vwbbqLZtBWlqLS/G6UXmoa2iI4befz6PDpAOLKTeRac5Lv70k/s7DZH6dM
         Z4Pw==
X-Gm-Message-State: AOJu0YzikHVbjDW/l0hK5bNfrV5Gd7+SNT2qPQOgaX/zsXlEBXSlfkaQ
	IOgLQ/Tia4coD1KRrCPKIGm9imj/uspBou6dsy75CZU2YiHELJPu8JwN
X-Gm-Gg: AeBDiethjjv+SWkdBiFHbO4WRN8xqbtIGZEkydr+kMPxdcPcORFxcJwemkMs2eBlCYI
	ITySH1K+Gd5+1rvX6KThopVmPY8GDymLAiTXbpdH9l7zyGoNRDay0+db6MYc60+Q/Ww4gNAKndt
	FGL9p98Q1ibzs29zWBF80EG+DKfzCR58Yzuxb7tf6vootnqKwgbFnen39fwb3DcjlCPyY/V1ysc
	B88YnF/hFaZ6di7xLVUgsGNp7aGMyH9kzh4mh0Sr/u9mu0lg1XHJRZhaET582kmJ4tHTl2tWXSK
	5FbF+sRtQqlmvu7+MsPHgmnvA83XqSI983cMatZl0IAM2uUAghTJcvHKbi6RkKB930SnMCLqL7Y
	nDnFMnovQiXo2n5JWJtrwy5lznKZ7vnreEtP8SLGJa8blbxgnSGFcMt066DxoudgyLpyOAMme7Z
	ctW/NVHy3AbR6UhIYdtOUrd9oAI43Si4b1xVRyd0cvYgIQfW8AhLRTwmyvH2kH
X-Received: by 2002:a05:6000:4205:b0:43d:772d:2b61 with SMTP id ffacd0b85a97d-43eb10ceeadmr19592f8f.15.1776268999156;
        Wed, 15 Apr 2026 09:03:19 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1126:4:cbe8:6434:118f:886d? ([2620:10d:c092:500::5:3ecd])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43ead3d5f06sm6539936f8f.17.2026.04.15.09.03.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Apr 2026 09:03:18 -0700 (PDT)
Message-ID: <235f4a5d-c5fc-4980-a075-284e966c4fc6@gmail.com>
Date: Wed, 15 Apr 2026 17:03:17 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 5/6] selftests/bpf: Test BTF sanitization
 rejection for invalid vlen
To: sashiko@lists.linux.dev, Alan Maguire <alan.maguire@oracle.com>
Cc: bpf@vger.kernel.org
References: <20260414195019.684531-6-alan.maguire@oracle.com>
 <20260414222624.A722AC19425@smtp.kernel.org>
Content-Language: en-US
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
In-Reply-To: <20260414222624.A722AC19425@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 4/14/26 11:26 PM, sashiko-bot@kernel.org wrote:
> Sashiko AI review found 3 potential issue(s):
> - [Low] Leaking the BTF object on unexpected success of sanitization.
> - [Low] Lack of error checks for BTF construction calls.
> - [Low] Using `BTF_MAX_VLEN` as the `byte_sz` argument in `btf__add_datasec()`.
> --
> 
> commit 9c5af444155b34aa840793bf185bc0c0aaa04f3f
> Author: Alan Maguire <alan.maguire@oracle.com>
> 
> selftests/bpf: Test BTF sanitization rejection for invalid vlen
>      
> This patch adds a selftest to verify that BTF objects with extended vlen
> are properly rejected by kernels that do not support the extended feature.
> It simulates the lack of support using the feature cache and checks if
> sanitization fails when the vlen limit is surpassed.
> 
>> diff --git a/tools/testing/selftests/bpf/prog_tests/btf_sanitize.c b/tools/testing/selftests/bpf/prog_tests/btf_sanitize.c
>> index 652b51efafc27..f41cea5a769a2 100644
>> --- a/tools/testing/selftests/bpf/prog_tests/btf_sanitize.c
>> +++ b/tools/testing/selftests/bpf/prog_tests/btf_sanitize.c
> [ ... ]
>> @@ -95,3 +95,65 @@ void test_btf_sanitize_layout(void)
>> +static void test_btf_sanitize_extended(void)
>> +{
> [ ... ]
>> +	btf = btf__new_empty();
>> +	if (!ASSERT_OK_PTR(btf, "empty_btf"))
>> +		goto out;
>> +	btf__add_int(btf, "int", 4, BTF_INT_SIGNED);
>> +	btf__add_var(btf, "var1", 0, 1);
> 
> Are we missing error checks on these btf__add_*() calls?
> 
> If any of these allocations silently fail, the test might proceed with an
> incomplete BTF object that hasn't actually surpassed the vlen limit. This
> would cause the subsequent bpf_object__sanitize_btf() call to unexpectedly
> succeed, failing the test for the wrong reason.
> 
>> +	btf__add_datasec(btf, "datasec1", BTF_MAX_VLEN);
> 
> Is it intentional to use BTF_MAX_VLEN for the byte_sz argument here?
> 
> BTF_MAX_VLEN is a bitmask representing the maximum number of items, not a byte
> size. Using a proper calculated byte size like 0x10000 * 4 might be clearer.
> 
>> +	for (i = 0; i <= 0xffff; i++)
>> +		btf__add_datasec_var_info(btf, 2, i * 4, 4);
>> +
>> +	/* Sanitization should fail here as vlen surpasses unextended limit. */
>> +	sanitized = bpf_object__sanitize_btf(skel->obj, btf);
>> +	if (!ASSERT_ERR_PTR(sanitized, "bpf_object__sanitize_btf_should_fail")) {
>> +		sanitized = NULL;
> 
> If the first bpf_object__sanitize_btf() call unexpectedly succeeds, sanitized
> will hold a valid pointer.
> 
> Doesn't setting it to NULL before the goto out path leak the memory, since
> btf__free(sanitized) will be called with a NULL pointer at the end of the
> function?
> 

This is no leak, but setting to NULL is not needed, because btf__free() 
checks IS_ERR_OR_NULL(btf).

>> +		goto out;
>> +	}
>> +	/* Now switch extended feature on and ensure success. */
> 

