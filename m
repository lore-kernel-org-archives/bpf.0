Received: from mta0.migadu.com (out-22.mta0.migadu.com [91.218.175.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2915F308F32
	for <bpf@vger.kernel.org>; Wed, 16 Sep 2026 14:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789570603; cv=none; b=pMyhedT9ix5wzq8Yxqcl6GTPHVCbclvpKxEyUyV1kR6MOYLmamD6TA6WUG/BVu9/U2TLMqgjvQnWaStogGrjIrkNtbo8LxBLrC47MVQJwq1facXITeyjpJnVLe7x+KvPZLEkTP6TP3ej7S4OPr/GhBnSAfYcFnv+VHh9TBCm98E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789570603; c=relaxed/simple;
	bh=9GNGVAKTTK8eqix4yOLwD6F6vnU8nqAI6Taa7PAxP8M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b5ZqtZH64m2ijNr99qcuJFP7LJYSXO845kcRMTN6V5ywrUOrzAjWA74rKbvMFDRDPlRvFzR8TZwwow2+ROZvQ/OQAxrF4LWnYuQRtmvT7vXm63JnxXlEpjlVloWbofM3mOKRcE8GKxsAjH0OwwaZgzCS+CLQHtQS5IOhp7epVwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=LpT/lSMI; arc=none smtp.client-ip=91.218.175.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="LpT/lSMI"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=9GNGVAKTTK8eqix4yOLwD6F6vnU8nqAI6Taa7PAxP8M=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789570599; v=1; x=1790175399;
 b=LpT/lSMIym4AlFbkTxCUGTu4jb/WcIw66Plb82/XOV0tpV1tITEUA3sN1ZqwoLZ3wxPET1Rg
 +bovl+g7VRwaB9zMPplKJBg1ms32oO0fGyZiStnyKZongB0M3fMCxiNMKdIupHU8YLGBZZsOH8/
 8Qj1VOCXVhE+bYQeJpt6Ukw4=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 914571e2011362e5;
	Wed, 16 Sep 2026 14:56:39 +0000
X-Mizu-Trace-ID: 914571e2011362e5
X-Migadu-Flow: FLOW_OUT
Message-ID: <c5162a22-a455-4ed3-bed6-4488dbc45fce@linux.dev>
Date: Wed, 16 Sep 2026 22:56:34 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v3] bpftool: Compute map size of light skeletons
 at runtime
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
References: <20260915161450.96249-1-leon.hwang@linux.dev>
 <20260915162834.E2B751F000FF@smtp.kernel.org>
Content-Language: en-US
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <20260915162834.E2B751F000FF@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2026/9/16 00:28, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Low] bpf: compilation failure in skel_internal.h due to non-standard roundup macro
> --
> 
> commit cf9410def9715a95832e67f7002ebd4dabf2d7ad
> Author: Leon Hwang <leon.hwang@linux.dev>
> 
> bpftool: Compute map size of light skeletons at runtime
> 
> This commit addresses an issue with generating light skeletons on
> a host with a different page size from the target. It accomplishes
> this by passing the original map dimensions and dynamically computing
> the mmap size at runtime.
> 
>> diff --git a/tools/lib/bpf/skel_internal.h b/tools/lib/bpf/skel_internal.h
>> index 1f3f332dffbe9..9e16b8e8cb7c9 100644
>> --- a/tools/lib/bpf/skel_internal.h
>> +++ b/tools/lib/bpf/skel_internal.h
> [ ... ]
>> @@ -193,25 +197,39 @@ static inline void skel_free(void *p)
>>  	free(p);
>>  }
>>  
>> -static inline void skel_free_map_data(void *p, __u64 addr, size_t sz)
>> +static inline size_t skel_map_mmap_sz(size_t val_sz, __u32 max_entries)
>>  {
>> -	munmap(p, sz);
>> +	const long page_sz = sysconf(_SC_PAGE_SIZE);
>> +	size_t mmap_sz;
>> +
>> +	mmap_sz = roundup(val_sz, 8) * max_entries;
>> +	mmap_sz = roundup(mmap_sz, page_sz);
> 
> [Severity: Low]
> Does this code rely on the non-standard roundup macro from <sys/param.h>?
> 
> When users include the generated light skeleton header in a project compiled
> with strict C standards (e.g., -std=c99 or -std=c11) without _DEFAULT_SOURCE
> or _GNU_SOURCE, the roundup macro might not be defined. This can cause a
> compilation error due to an implicit declaration of function.

False positive.

By looking into the source code of <sys/param.h>, there's no
_DEFAULT_SOURCE or _GNU_SOURCE guard for the roundup macro.

Thanks,
Leon

