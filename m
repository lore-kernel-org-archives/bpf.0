Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50AC9212548
	for <bpf@vger.kernel.org>; Wed, 13 May 2026 17:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778692801; cv=none; b=EmxAzOqLQMHbWy5HpuvzENCKwV1dYjFxP/eGuQ0rkkpGjHHNG9DIIwwXl4avfPsPMmhiAwTpXcIKDrbIq0tcQ1K5DU3g+zV3/Euxln/ZE+4jZoNi3iTL11xicF01GFiioyE3bML7zhx2K55pOrqffIepUt0i1SW7X4a+xc0WLHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778692801; c=relaxed/simple;
	bh=C/omiLM/r7V93VaTAIE+KF7mnPxoyr9AFcoTKaoSLac=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IAQP8V8iIl68Gz5OUbkRRZBqSj9+bj1usHzVjeMP5Tnr9AOvN8CWMtGE/e7Rm/s7qRF2lctRFXoe0p6TrC+LMuab4DXrDtIY4XBmSdFx15Hi40gZicuajrkPEj/SC9eFQujdaJk+gnT4oTbuDU2CLAM56Cvuetk50gY7UFULCEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=FALyrhD8; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="FALyrhD8"
Message-ID: <8cabc830-7aa1-4830-bc97-8756145d45f8@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1778692795;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YHy9TjdQ1GyBjJIO3lOl0MZgD404LiUSrXXuRuDKq9U=;
	b=FALyrhD8efWX1wYEaET+8Rt0RfIVLebNwd8gwNBVwEi5UUu37oIOCayhZ1cZycpvblRXgl
	C7dBf0vpgZA6t5XtFb2QsgEwCk8aaJeYGh6H6vcxhMOx5kuxP2GnRoNCydhrhZFM2dBwwr
	tqeQ8MNsdeqrSRM98SbTPcB4/d2SizE=
Date: Wed, 13 May 2026 10:19:50 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf v3 2/3] bpf: Avoid faultable build ID reads under mm
 locks
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
References: <20260512032906.2670326-3-ihor.solodrai@linux.dev>
 <20260513040354.ED092C2BCC7@smtp.kernel.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <20260513040354.ED092C2BCC7@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 5/12/26 9:03 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 3 potential issue(s) to consider:
> - [High] Sleepable build ID parsing unconditionally fails on systems where CONFIG_PER_VMA_LOCK is disabled.
> - [High] Incorrect VMA classification using `!vma->vm_file` violates MM API and risks unsafe driver reads.
> - [High] Missing caching causes a severe performance regression due to redundant file I/O for IPs within the same VMA.

Sashiko essentially repeated the issues flagged by BPF CI bot,
which I already replied to. Same in the second message.

Ignoring these for now.

> --
> 
> commit 8402e095f9b6a82fa06a32af10007e005d6c5e76
> Author: Ihor Solodrai <ihor.solodrai@linux.dev>
> bpf: Avoid faultable build ID reads under mm locks
> 
> This commit updates the stackmap sleepable path to avoid calling
> build_id_parse_file() while holding mmap_lock or a per-VMA read lock. It
> achieves this by acquiring a stable read-side reference to the backing file,
> dropping the VMA lock, and then parsing the build ID.
> 
> Link: https://lore.kernel.org/all/20251218005818.614819-1-shakeel.butt@linux.dev/
> Link: https://lore.kernel.org/all/20260128183232.2854138-1-andrii@kernel.org/
> 
>> diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
>> index 4ef0fd06cea58..c1e96df360c3f 100644
>> --- a/kernel/bpf/stackmap.c
>> +++ b/kernel/bpf/stackmap.c
> 
> [ ... ]
> 
>> @@ -158,6 +159,105 @@ static inline void stack_map_build_id_set_ip(struct bpf_stack_build_id *id)
>>  	memset(id->build_id, 0, BUILD_ID_SIZE_MAX);
>>  }
>>  
>> +struct stack_map_vma_lock {
>> +	bool vma_locked;
>> +	struct vm_area_struct *vma;
>> +	struct mm_struct *mm;
>> +};
>> +
>> +static struct vm_area_struct *
>> +stack_map_lock_vma(struct stack_map_vma_lock *lock, unsigned long ip)
>> +{
> 
> [ ... ]
> 
>> +	vma = vma_lookup(mm, ip);
>> +	if (!vma) {
>> +		mmap_read_unlock(mm);
>> +		return NULL;
>> +	}
>> +
>> +#ifdef CONFIG_PER_VMA_LOCK
>> +	if (!vma_start_read_locked(vma)) {
>> +		mmap_read_unlock(mm);
>> +		return NULL;
>> +	}
>> +	mmap_read_unlock(mm);
>> +#else
>> +	mmap_read_unlock(mm);
>> +	return NULL;
>> +#endif
> 
> Does this unconditionally fail on systems where CONFIG_PER_VMA_LOCK is
> disabled?
> 
> Looking at the fallback block, it unlocks the mmap_read_lock and returns
> NULL. Will this cause stack_map_get_build_id_offset_sleepable() to always
> receive a NULL VMA and fail to extract any build IDs on architectures lacking
> per-VMA lock support?
> 
> [ ... ]
> 
>> +static void stack_map_get_build_id_offset_sleepable(struct bpf_stack_build_id *id_offs,
>> +						    u32 trace_nr)
>> +{
>> +	struct mm_struct *mm = current->mm;
>> +	struct stack_map_vma_lock lock = {
>> +		.vma_locked = false,
>> +		.vma = NULL,
>> +		.mm = mm,
>> +	};
>> +	unsigned long vm_pgoff, vm_start;
>> +	struct vm_area_struct *vma;
>> +	struct file *file;
>> +	u64 ip;
>> +
>> +	for (u32 i = 0; i < trace_nr; i++) {
> 
> I see this is addressed in a later commit in the series ("bpf: Cache build
> IDs in sleepable stackmap path"), but is there a risk of a performance
> regression here?
> 
> The original non-sleepable path cached the previous VMA and build ID. Since
> that caching logic is missing here, will adjacent stack frames from the same
> binary repeatedly trigger file reference acquisitions and blocking reads for
> every single IP?
> 
>> +		ip = READ_ONCE(id_offs[i].ip);
>> +		vma = stack_map_lock_vma(&lock, ip);
>> +		if (!vma || !vma->vm_file) {
> 
> Is checking vma->vm_file sufficient to determine if the mapping is
> file-backed?
> 
> Anonymous VMAs, such as private mappings of /dev/zero or driver mappings
> calling vma_set_anonymous(), can legitimately have vm_file set.
> 
> Could passing these anonymous VMAs to build_id_parse_file() invoke
> __kernel_read() on a driver's read handler, leading to unintended side
> effects or hangs?
> 
> Would it be safer to use !vma_is_anonymous(vma) instead?
> 
>> +			stack_map_build_id_set_ip(&id_offs[i]);
>> +			stack_map_unlock_vma(&lock);
>> +			continue;
>> +		}
>> +
>> +		file = get_file(vma->vm_file);
>> +		vm_pgoff = vma->vm_pgoff;
>> +		vm_start = vma->vm_start;
>> +		stack_map_unlock_vma(&lock);
>> +
>> +		/* build_id_parse_file() may block on filesystem reads */
>> +		if (build_id_parse_file(file, id_offs[i].build_id, NULL)) {
>> +			stack_map_build_id_set_ip(&id_offs[i]);
>> +			fput(file);
>> +			continue;
>> +		}
> 

