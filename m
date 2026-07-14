Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7407B363089
	for <bpf@vger.kernel.org>; Tue, 14 Jul 2026 01:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783993376; cv=none; b=F3EcE+btZ5O4ctc2XeTuziu0JNsUIMglFYb/z6236R0VHsMM5C7+CcdryxjV9XWT8qG6WiYNbgb5kew+siFWmkaH4KcNbAQ8ZcIAvF2R4URHZMEQ5PCN6RZHMXbl+rH4MxL1jkxeoGNgsp3zFn5yBbSFgh/KD0TFR/TGim8hKz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783993376; c=relaxed/simple;
	bh=YcBoxF87fN6vTFYPMiERcfKTFCKgR+xteHn79Xb4K2E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=au6xWDYIJH3MgebAuplpyEcfIt1qaKaJo7CbPCUiOQtnwdKVl6cNRwy4aeNEdRIB8gYKVxT6KthnBcQtzo4Lb41RCHyqmdNyqVoz5m0Aknn1ZweS+P7Tm++p+M9lOQVhW1arq5rWMyKtUDbXuBnX4hhY948xO7oQAt9afU+JVek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=GMJtFZ6y; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="GMJtFZ6y"
Message-ID: <2f3eb675-44e6-45ee-b17a-23cfe944f532@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783993362;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XSFxdIFWDkLbL5AfaItlOrUyRxksuabmyXSi4riEpkY=;
	b=GMJtFZ6yIG7u2QEkwM3BzX4sBzouxIclWPw3g6a1nGdxuJLRn+MVk07pIjD9oPWFcWlBLj
	PVS4WGal1lJqsAoWyh6gdOphCcukz/SRcsvHyUtBeOmi1KxOIAdlyi7jf1ms7yOtCqxKV2
	8QJCcdoUDM4Afn6Sn4eycbDzGM6PHJ8=
Date: Tue, 14 Jul 2026 09:42:29 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v9 3/9] libbpf: Probe percpu data feature
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
References: <20260713154024.30851-1-leon.hwang@linux.dev>
 <20260713154024.30851-4-leon.hwang@linux.dev>
 <20260713161726.C4B491F000E9@smtp.kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
Content-Language: en-US
In-Reply-To: <20260713161726.C4B491F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 14/7/26 00:17, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] The capability probe for percpu data incorrectly emits warnings and returns a negative error code when map creation fails on older kernels, breaking the silent probing expectation and causing double warnings.
> --
> 
> --- Patch [3]: [PATCH bpf-next v9 3/9] libbpf: Probe percpu data feature ---
> commit 4bf6930d4ace160491d05ec9880c9cadc9f81bc7
> Author: Leon Hwang <leon.hwang@linux.dev>
> 
> libbpf: Probe percpu data feature
> 
> This commit adds a dedicated feature probe to libbpf for detecting whether
> the kernel supports global percpu data. It checks this capability by
> attempting to create a simple percpu array map and loading a basic socket
> filter program that accesses it.
> 
>> diff --git a/tools/lib/bpf/features.c b/tools/lib/bpf/features.c
>> index b7e388f99d0bb..ef9581c113035 100644
>> --- a/tools/lib/bpf/features.c
>> +++ b/tools/lib/bpf/features.c
> 
> [ ... ]
> 
>> @@ -620,6 +620,38 @@ static int probe_bpf_syscall_common_attrs(int token_fd)
> 
> [ ... ]
> 
>> +static int probe_kern_percpu_data(int token_fd)
>> +{
> 
> [ ... ]
> 
>> +	map = bpf_map_create(BPF_MAP_TYPE_PERCPU_ARRAY, "libbpf_percpu", sizeof(int), 8, 1,
>> +			     &map_opts);
>> +	if (map < 0) {
>> +		pr_warn("Error in %s(): %s. Couldn't create simple percpu_array map.\n",
>> +			__func__, errstr(map));
>> +		return map;
>> +	}
> 
> [Severity: Medium]
> Should this probe silently return 0 instead of propagating the negative error
> code and printing a warning when bpf_map_create() fails?
> 
> When running on older kernels that genuinely lack BPF_MAP_TYPE_PERCPU_ARRAY
> support, this code will print the pr_warn() above and return a negative error
> code.
> 
> Because the caller feat_supported() expects 0 to cleanly indicate a missing
> feature, returning a negative value causes feat_supported() to print a second
> warning: "Detection of kernel kernel supports percpu data support failed".
> 
> Does this unintentionally pollute the logs with double warnings when apps are
> safely falling back on older kernels?
> 


Cite my reply in v5 [1]:

Since percpu_array map is a basic map in bpf, this map creation should
likely succeed. If it fails, the kernels are too old to use such new libbpf.

[1]
https://lore.kernel.org/bpf/66d40066-94a7-4710-8e0f-d18f8c1bf21f@linux.dev/

Thanks,
Leon

