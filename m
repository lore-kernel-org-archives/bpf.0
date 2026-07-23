Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 227072931D9
	for <bpf@vger.kernel.org>; Thu, 23 Jul 2026 00:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784767831; cv=none; b=V9slrbZI4swzUs/LBGrapKoWR3pHp7yb25XrwvDin0bOJ2vH+yj9ZjQ1e1Wujt3CF3gB+2rmyo7hs/J72fSsaab5iGTDAur7cOxJA/seGRSvj8AAH1COGR1kUBB0ObI5wYlaXBMP5iKAtEVopnCrLM9VyMXuq/wuwbF5MF4O81w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784767831; c=relaxed/simple;
	bh=qrcVV5NuQDIXgcvhV8X73prtKA5K5yPjsBqgtrCTqY0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Hf1/RlERc6/ODE8V4bltPpehCQ5MW9T9qSZbMUKHjuaWd+qSdTrE1APGnmhq0w6pTNO1w0ZxzwThjaWeWocDNrt+rGI4DiAxUhW5DMw2eJtxQRZJGoW8rQA4TalwhEc0Mrf2+SYpq0SXRP+3HmzfdRZW8qzBmgs0zedjj+QQKWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=iFPB0e1h; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="iFPB0e1h"
Message-ID: <96de438b-2637-4d42-b65d-7ec8a37e89a8@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784767828;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=v6cZUZnkdCx64NXcrSiMNf/3VHLEYUKEG9qRg6czPsA=;
	b=iFPB0e1hOWxlKFnpH1GzZcVcHD+ufOsiVCG+93mVaQUO4N29ovkzoH4IioEqEMP5Lc3D8x
	T1I12yCNrfTWk54rfeN/yNaSClSClo0PI5dq4FZVnDdFuk53R1igYmGoWdmCsTAd8CRtwH
	xOqWB4FFZvdDGrFDgp+vhfI4N9sQ0bQ=
Date: Wed, 22 Jul 2026 17:50:08 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v1 1/8] resolve_btfids: Implement generic
 ensure_mem() to grow arrays
To: sashiko-reviews@lists.linux.dev
Cc: linux-input@vger.kernel.org, bpf@vger.kernel.org,
 dmitry.torokhov@gmail.com
References: <20260722233518.778854-1-ihor.solodrai@linux.dev>
 <20260722233518.778854-2-ihor.solodrai@linux.dev>
 <20260722234842.68B271F000E9@smtp.kernel.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <20260722234842.68B271F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 7/22/26 4:48 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] Strict aliasing violation via `void **` casting leading to potential Use-After-Free.
> --
> 
> --- Patch [1]: [PATCH bpf-next v1 1/8] resolve_btfids: Implement generic ensure_mem() to grow arrays ---
> commit b5970d9bf6b1262c4ad812706df67f4a14ee5411
> Author: Ihor Solodrai <ihor.solodrai@linux.dev>
> 
> resolve_btfids: Implement generic ensure_mem() to grow arrays
> 
> This commit factors out array growth logic from push_*() helpers into a
> generic ensure_mem() macro and function. It uses a void ** cast to update
> the array pointer upon reallocation.
> 
>> diff --git a/tools/bpf/resolve_btfids/main.c b/tools/bpf/resolve_btfids/main.c
>> index f8a91fa7584f4..183466ddc5f97 100644
>> --- a/tools/bpf/resolve_btfids/main.c
>> +++ b/tools/bpf/resolve_btfids/main.c
>> @@ -201,6 +201,35 @@ static int eprintf(int level, int var, const char *fmt, ...)
>>  #define pr_info(fmt, ...) \
>>  	eprintf(0, verbose, pr_fmt(fmt), ##__VA_ARGS__)
>>  
>> +/*
>> + * Grow *data so it can hold at least cnt elements of elem_sz bytes each.
>> + * *cap is the capacity in elements and is updated on growth.
>> + */
>> +static int __ensure_mem(void **data, u32 *cap, u32 cnt, size_t elem_sz)
>> +{
>> +	u32 new_cap, old_cap = *cap;
>> +	void *arr;
>> +
>> +	if (cnt <= old_cap)
>> +		return 0;
>> +
>> +	new_cap = max(old_cap + 256, old_cap * 2);
>> +	if (new_cap < cnt)
>> +		new_cap = cnt;
>> +
>> +	arr = realloc(*data, elem_sz * new_cap);
>> +	if (!arr)
>> +		return -ENOMEM;
>> +
>> +	*data = arr;
> 
> [Severity: Medium]
> Will this assignment violate strict aliasing rules? Because void * and u32 *
> are incompatible types, modifying the pointer through a void ** pointer
> violates C strict aliasing.
> 
> While core kernel code is compiled with -fno-strict-aliasing, programs under
> tools/ are compiled with standard optimizations including -fstrict-aliasing.
> If __ensure_mem() is inlined, could the compiler assume that this assignment
> does not modify the original typed pointer?

ensure_mem() is modeled on libbpf's own libbpf_ensure_mem(), which is
called exactly this way throughout libbpf with typed pointers cast to
(void **), built under the same tools/ flags.

The pattern is long-established and hasn't caused issues in practice.
Callers re-read the struct member after the call. Wontfix.

> 
>> +	*cap = new_cap;
>> +
>> +	return 0;
>> +}
>> +
>> +#define ensure_mem(arr_ptr, cap_ptr, cnt) \
>> +	__ensure_mem((void **)(arr_ptr), (cap_ptr), (cnt), sizeof(**(arr_ptr)))
> 
> [...]
> 

