Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EAF43321A1
	for <bpf@vger.kernel.org>; Mon, 15 Jun 2026 21:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781557471; cv=none; b=oxNnhm8RNTWxCZsr/LBttWakXHr7VwU1JAWLBc0zErA+bejujqbVoPRQfKmIKaj1p0KDu07adeCATxUQV8oMHhRYn8htnpvs3rpKijdaZp5xFLOBedCXgXL7LvLDsOfVAClEJyikhqxIxELMlEUEtANZ337PyEHEC+BbbT918Oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781557471; c=relaxed/simple;
	bh=4vh1j6T/ZeMwRqoBeNUlx2x0FlrQwsadp3G2RyPAqdU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Env80sLHF9fTsTrNJuYmotEDbPAKZOkw6r59JMnyNH667uDYs5+153VFRuglq14hCNbLKzfjBL92T5WS9/MpENIIYgsLl9FOARSTg0YVQpqGf90xlFK562sJgqJqaDhuYlP6q3r21QGifQrPI48fVRgC1XfxIBvWCvhIQmZ+Fmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=nYdYHiLj; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="nYdYHiLj"
Message-ID: <dbe1fa76-4275-4d98-956b-1f76ae64dc5c@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1781557456;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BPpNYPZJ7QROTHcAADboOieTHbGsZ81Lygo8gpfzvM4=;
	b=nYdYHiLjBo5bXgSMevvNjwEAWW3WE3e+vY9xhIptEebg/uDgSqAgMks22RqsApEfACUbf1
	XpXdrjseQVAcFWBLKdO60jDPJUHAjB6KOJ+peJHTgQvd/nYm3E06Hh5m0ho/M4goo1Y1ZV
	lhAECzI4VxBRi2hWFwGf31MXxLujmBc=
Date: Mon, 15 Jun 2026 14:04:07 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v3] bpf: Better build_id caching in
 stack_map_get_build_id_offset()
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
References: <20260615195536.1065107-1-ihor.solodrai@linux.dev>
 <20260615201250.D2B0C1F000E9@smtp.kernel.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <20260615201250.D2B0C1F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 6/15/26 1:12 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [High] The non-sleepable path uses `find_vma()` without verifying if the requested `ip` actually falls within the returned VMA, leading to bogus file offsets and leaking the build ID of adjacent mappings.
> --
> 
> commit 61bb9d39eaa120b04f78291638b9b3dcc5b364d9
> Author: Ihor Solodrai <ihor.solodrai@linux.dev>
> 
> bpf: Better build_id caching in stack_map_get_build_id_offset()
> 
> This patch refactors the build ID caching logic in
> stack_map_get_build_id_offset and its sleepable variant into a shared
> structure. It uses two independent slots to cache the last resolved and
> unresolved VMAs, avoiding cache eviction when alternating between regions.
> 
> Link: https://lore.kernel.org/bpf/20260525223948.1920986-1-ihor.solodrai@linux.dev/
> Link: https://lore.kernel.org/bpf/CAEf4Bza2fRDGhLQoPE-EzM7F34xaEJfi5Exmxb-iWVUN3F06=g@mail.gmail.com/
> Link: https://lore.kernel.org/bpf/CAEf4BzZXJFr=1iiVx937ht=4PYQkQHg=eFk810zhMDzXQG3ihw@mail.gmail.com/
> 
>> diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
>> --- a/kernel/bpf/stackmap.c
>> +++ b/kernel/bpf/stackmap.c
> 
> [ ... ]
> 
>> @@ -365,27 +439,30 @@ static void stack_map_get_build_id_offset(struct bpf_stack_build_id *id_offs,
>>  
>>  	for (i = 0; i < trace_nr; i++) {
>>  		u64 ip = READ_ONCE(id_offs[i].ip);
>>  
>> -		if (prev_build_id && range_in_vma(prev_vma, ip, ip)) {
>> -			vma = prev_vma;
>> -			offset = stack_map_build_id_offset(vma->vm_pgoff, vma->vm_start, ip);
>> -			stack_map_build_id_set_valid(&id_offs[i], offset, prev_build_id);
>> +		if (!stack_map_build_id_set_from_cache(&cache, &id_offs[i], ip))
>>  			continue;
>> -		}
>> +
>>  		vma = find_vma(current->mm, ip);
>>  		if (!vma || vma_is_anonymous(vma) ||
>>  		    fetch_build_id(vma, id_offs[i].build_id, may_fault)) {
> 
> [Severity: High]
> This isn't a bug introduced by this patch, but does the use of find_vma()
> here without a bounds check allow an unmapped ip to underflow the offset?
> 
> find_vma() returns the first VMA whose vm_end > ip, but it does not
> guarantee that ip >= vma->vm_start.
> 
> If an unmapped ip is queried, could find_vma() return the next adjacent VMA,
> causing the offset calculation ip - vma->vm_start to underflow? This appears
> like it would report a bogus file offset and leak the build ID of the
> adjacent mapping.
> 

This was raised in v1, ignoring as it's not relevant to the patch.

