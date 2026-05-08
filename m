Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 517913ACF15
	for <bpf@vger.kernel.org>; Fri,  8 May 2026 23:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778281437; cv=none; b=cqqjv0Qovdnw6hprLLFW6TnF+LUovzUX9PjcNucTJG+es+f+71abWoeMgIopvmOGlbqa+6Jr6ja9c9RFCwAf0DT9YAOdHLXft91zTEJlzcd4J0hSuIbL0kFxBDTryS+gxcfxwNr7C5nTKApfUkXBd5P8qdan7Y+tr84hyvBNdT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778281437; c=relaxed/simple;
	bh=SHxByHZQmT4UGrzaS26bXhPeiR30fEZjj+wWb9WI66k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c5n4y7dMYJvJ8JbOmOBh350GCyyBzntbAE4vm4ajcGRlBngKQ2E8pCcD6m/7E/8MIFIi1rcI+itI6Wl2fKYd7jxQyXdHF6mnrXENhtmjt8wCTSA61E00i1B3EsLZvma4/eLVoHnTHZh8TogkuiF4FHRkZsbRLCc1LGkP+5/jAO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KR94VIh2; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KR94VIh2"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-36622412e97so1439393a91.2
        for <bpf@vger.kernel.org>; Fri, 08 May 2026 16:03:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778281435; x=1778886235; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=E5VVY1EE6OCfiIdGNty7YuXQqh1L1/YOFUIxh8m6Zvc=;
        b=KR94VIh2bycTNAp0NbanZWzshYGORAzS+4UnO5O3LKKpzuJ8rj283u3txKnwUKF02G
         FJdTwIH24ZuULGo4/yfXDA7j63RAsHOqm2B5xoWssq9kBE/M8ZVz5Xn1I0bs+HgD75qU
         Prbjw0cjXhrwJ4/mPR+aItzrbvS1g123NXTfmDesWq+3Q/42d3GWO0S2mScrNoHMFcxi
         mTPFXZRP9rzV2wz2adCEsLwAVqDMYurHQI4zyHQ9j9q2RRBo2z0sfEvAGcGW3r2/MosF
         fW3xqOZt2FguMbBCJDNbojlQJGSe/rFq8cSLivVthRP+fqo2HUtKAa8ERkL2tqBwDsXp
         xUdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778281435; x=1778886235;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E5VVY1EE6OCfiIdGNty7YuXQqh1L1/YOFUIxh8m6Zvc=;
        b=b1lBkEK/1h59QhDgP2fZ/luAUzCDJjKJ0YodBx0zArT2EXiuQh+ataHbnHclnpWaac
         eaInxZB1/TDquBGWJWnu6SfKkquUztxOktetOwzEMZy5WAm4yrSIR5N3GLl6x2rVsWPr
         c+MfPmb9mlklPOxMywSa9RfDaWXkxLqpZZJyY3aqAAyDpaGZ49dDaE6Uue6y3Si9MldS
         xMWmu9wwYbRW2a2wS2yGf1Zv31fljdOEeyBZUjsVpl7GvHwW7NWA0nmRXIB02lWNHO3q
         eIPzljlpgT/Ce2VBqCA7fLj5TIhoaVFqfCzRSLkK1yyq9ZPFZuZzZQ5sLX0Xw2XOsaxZ
         4K+g==
X-Gm-Message-State: AOJu0YzjzHPuCWzL4oZ+4RzS8g99hwmVnuRC7B9wtkMgt2gL2oyFWDh4
	ovxlctZxsZrQll7CWlfyXMRQ7YJNjATRxC+a/lhCdxQHiobY9cQ2NTo4MYuc+rCH
X-Gm-Gg: Acq92OHKZVuA+qlpa55MzZoUnfbKMw1BaEtfEj9S+hdmKIFpjI31yku1scy9c/2r8KZ
	8kFktU49WshqegpTQT0UJzpI6/0aDsHqI74Lfofwdkpn6y5N2w+H96IV7N94O3T8gMhEsfY9qfU
	hVFWI60s9kfhRGfi0CbiB9zmyI0EWjUr/dO7ZEsN6GiD6uYPeLPjoO+Hv0lZsvTlb/47/m059FT
	eFQQsqtXhOFsJQZLYaTHsKwX0csrsIgrgNo2K8/Rk1bAFKn0i2/MmBc9we9GNvD3iZKq3WKwA7O
	X3jn6s3rM5IKOF4a2cK48Zoy3pVk5SYVFQZiRKmTNviPRce4ykWff9Q8BQY58dwlMIfYFXy/ghY
	9iyb+v1m7l/FEJGQZxhPqLE3wQiFOYRJ2xfXpvcCRYLHLTAH/emKAFImItXiiIfKiR8BRzec2eG
	IgpOdN9nKpvy+9irRRPdLRdq8FXSoafb4B+G74gQ==
X-Received: by 2002:a17:903:2c0d:b0:2b2:42da:25cb with SMTP id d9443c01a7336-2bc7aa11bc7mr1368075ad.19.1778281434605;
        Fri, 08 May 2026 16:03:54 -0700 (PDT)
Received: from ?IPV6:2604:3d08:9582:1100::c7c9? ([2604:3d08:9582:1100::c7c9])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2baf1d52ef9sm33484415ad.35.2026.05.08.16.03.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 May 2026 16:03:54 -0700 (PDT)
Message-ID: <8bd97ad9-5b28-47d2-9e84-5be4adea481e@gmail.com>
Date: Fri, 8 May 2026 16:03:53 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 05/19] unwind_user/sframe: Add support for reading
 .sframe contents
To: Jens Remus <jremus@linux.ibm.com>, Steven Rostedt <rostedt@kernel.org>,
 Josh Poimboeuf <jpoimboe@kernel.org>
Cc: bpf@vger.kernel.org, sashiko@lists.linux.dev
References: <20260505121718.3572346-6-jremus@linux.ibm.com>
 <20260505185932.C708CC2BCB4@smtp.kernel.org>
 <4e5d51f0-8f4c-4a07-9141-8b26d2c90fc6@linux.ibm.com>
Content-Language: en-US
From: Indu Bhagat <ibhagatgnu@gmail.com>
In-Reply-To: <4e5d51f0-8f4c-4a07-9141-8b26d2c90fc6@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2026-05-06 07:34, Jens Remus wrote:
> On 5/5/2026 8:59 PM, sashiko-bot@kernel.org wrote:
>> Thank you for your contribution! Sashiko AI review found 5 potential issue(s) to consider:
>> - [Critical] Division by zero in `__find_fre` when `fde->rep_size` is 0.
>> - [High] `mtree_insert_range` is called with an exclusive end boundary, preventing contiguous SFrame sections.
>> - [High] Unbounded linear search over user-controlled memory in `__find_fre` can cause hard lockups in atomic context.
>> - [High] Integer overflows in SFrame header parsing allow bypass of bounds checks on 32-bit architectures.
>> - [Medium] Generic SFrame unwinding code uses `unsafe_get_user()` for unaligned accesses, breaking strict-alignment architectures.
>> --
>>
>> commit 159c92acf3c961aecc6383f6c3f35a955591abf3
>> Author: Josh Poimboeuf <jpoimboe@kernel.org>
>>
>> unwind_user/sframe: Add support for reading .sframe contents
>>
>> This commit adds support for reading .sframe section contents to facilitate
>> user space stack unwinding. It introduces the sframe_find() interface which
>> uses user_read_access_begin() and unsafe_*() accessors for performance.
>> Support is included for SFrame V3, internal FDE representations, and
>> PC-relative offsets.
>>
>> Link: https://lore.kernel.org/all/77c0d1ec143bf2a53d66c4ecb190e7e0a576fbfd.1737511963.git.jpoimboe@kernel.org/
>> Link: https://lore.kernel.org/all/b35ca3a3-8de5-4d32-8d30-d4e562f6b0de@linux.ibm.com/
>>
>>> diff --git a/kernel/unwind/sframe.c b/kernel/unwind/sframe.c
>>> index fdb2a49085638..c60aa527984a1 100644
>>> --- a/kernel/unwind/sframe.c
>>> +++ b/kernel/unwind/sframe.c
>>> @@ -15,9 +15,338 @@
>>>   #include <linux/unwind_user_types.h>
>>>   
>>>   #include "sframe.h"
>>> +#include "sframe_debug.h"
>>
>> [ ... ]
>>
>>> +static __always_inline int __read_fre(struct sframe_section *sec,
>>> +				      struct sframe_fde_internal *fde,
>>> +				      unsigned long fre_addr,
>>> +				      struct sframe_fre_internal *fre)
>>> +{
>> [ ... ]
>>> +	if (fre_addr + addr_size + 1 > sec->fres_end)
>>> +		return -EFAULT;
>>> +
>>> +	UNSAFE_GET_USER_INC(ip_off, cur, addr_size, Efault);
>>
>> Will this cause alignment faults on architectures with strict alignment
>> requirements?
>>
>> The .sframe format uses packed structures and variable-length datawords. The
>> cur pointer might be unaligned here, and UNSAFE_GET_USER_INC() performs
>> 16-bit or 32-bit reads via unsafe_get_user().
> 
> IIUC this should not be an issue for x86-64, s390, and arm64.
> 
>> [ ... ]
>>
>>> +static __always_inline int __find_fre(struct sframe_section *sec,
>>> +				      struct sframe_fde_internal *fde,
>>> +				      unsigned long ip,
>>> +				      struct unwind_user_frame *frame)
>>> +{
>>> +	unsigned char fde_pctype = SFRAME_V3_FDE_PCTYPE(fde->info);
>>> +	struct sframe_fre_internal *fre, *prev_fre = NULL;
>>> +	struct sframe_fre_internal fres[2];
>>> +	unsigned long fre_addr;
>>> +	bool which = false;
>>> +	unsigned int i;
>>> +	u32 ip_off;
>>> +
>>> +	ip_off = ip - fde->func_addr;
>>> +
>>> +	if (fde_pctype == SFRAME_FDE_PCTYPE_MASK)
>>> +		ip_off %= fde->rep_size;
>>
>> Can a malicious user provide an SFrame section with a rep_size of 0?
>>
>> Since fde->rep_size is populated directly from the user-provided
>> _fda.rep_size without validation, a 0 value here would trigger a
>> divide-by-zero exception and a kernel panic.
> 
> Good catch!  I would add a check in __read_fde():
> 
> diff --git a/kernel/unwind/sframe.c b/kernel/unwind/sframe.c
> @@ -67,6 +67,7 @@ static __always_inline int __read_fde(struct sframe_section *sec,
>          unsigned long fde_addr, fda_addr, func_addr;
>          struct sframe_fde_v3 _fde;
>          struct sframe_fda_v3 _fda;
> +       unsigned char fde_pctype;
> 
>          fde_addr = sec->fdes_start + (fde_num * sizeof(struct sframe_fde_v3));
>          unsafe_copy_from_user(&_fde, (void __user *)fde_addr,
> @@ -82,6 +83,10 @@ static __always_inline int __read_fde(struct sframe_section *sec,
>          unsafe_copy_from_user(&_fda, (void __user *)fda_addr,
>                                sizeof(struct sframe_fda_v3), Efault);
> 
> +       fde_pctype = SFRAME_V3_FDE_PCTYPE(_fda.info);
> +       if (fde_pctype == SFRAME_FDE_PCTYPE_MASK && !_fda.rep_size)
> +               return -EINVAL;
> +
>          fde->func_addr  = func_addr;
>          fde->func_size  = _fde.func_size;
>          fde->fda_off    = _fde.fres_off;
> 

Yes, I think this is good to add.

>>
>>> +
>>> +	fre_addr = sec->fres_start + fde->fres_off;
>>> +
>>> +	for (i = 0; i < fde->fres_num; i++) {
>>
>> Can this loop cause a hard lockup in atomic context?
>>
>> fde->fres_num is a 32-bit value copied from user space without validation.
>> Since sframe_find() is designed to be called by unwinders in NMI context, an
>> attacker could provide a very large number of valid entries. Executing
>> billions of iterations and unsafe_get_user() calls could stall the CPU
>> and trigger the hard lockup detector.
> 
> Please advise.
> 
>>
>>> +		int ret;
>>> +
>>
>> [ ... ]
>>
>>> @@ -120,8 +449,10 @@ int sframe_add_section(unsigned long sframe_start, unsigned long sframe_end,
>>>   	sec->text_end		= text_end;
>>>   
>>>   	ret = sframe_read_header(sec);
>>> -	if (ret)
>>> +	if (ret) {
>>> +		dbg_print_header(sec);
>>>   		goto err_free;
>>> +	}
>>
>> Can shdr.fre_len cause an integer overflow on 32-bit architectures during
>> header parsing?
>>
>> If a malicious user provides a large fre_len in the header, fres_end
>> (calculated as fres_start + shdr.fre_len) could wrap around the 32-bit
>> address space. This would bypass the bounds check in sframe_read_header(),
>> allowing fres_start and fdes_start to point into kernel memory. Later, when
>> __read_fde() and __find_fre() use unsafe_get_user(), this could lead to
>> arbitrary kernel memory disclosure.
> 
> SFrame is currently only supported on 64-bit architectures (i.e. x86-64,
> arm64, s390 64-bit).  So unsigned long fres_end should always be 64-bit.
> Do we need to add the following to the header parsing?
> 
> if (fdes_start >= fdes_end || fres_start >= fres_end) {
> 	dbg_sec("inconsistent FDE/FRE start/end address\n");
> 	return -EINVAL;
> }
> 
>>
>>>   
>>>   	ret = mtree_insert_range(sframe_mt, sec->text_start, sec->text_end, sec, GFP_KERNEL);
>>
>> Does passing sec->text_end directly as the last parameter to
>> mtree_insert_range() break contiguous mappings?
>>
>> mtree_insert_range() expects the last boundary to be inclusive, but
>> sec->text_end represents the exclusive end address of the executable segment.
>> If user space maps seamlessly contiguous text segments, the insertion for the
>> second segment might overlap with the claimed end of the first, causing it to
>> fail with -EEXIST.
> 
> Addressed in previous patch.
> 
>>
>>>   	if (ret) {
>>>   		dbg("mtree_insert_range failed: text=%lx-%lx\n",
>>
> 
> Thanks and regards,
> Jens

