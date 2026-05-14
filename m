Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E02D1355814
	for <bpf@vger.kernel.org>; Thu, 14 May 2026 20:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778791086; cv=none; b=Ph9aTX2DXPO0th9DgTnb9b78fM4chSWz60rNU/liGYPGB6KCAGobbZwBM9GgP8SNc4fXtGFgia3AhNVKXRrmuxqaYd6LsIgJjNB5qSSb+9MIdts98PSZagaQptieXhEGr0LChMyuPKEnsHtW9w8UbLNwO3gU1wp0BZ13tkMxcM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778791086; c=relaxed/simple;
	bh=go01oXcceTeotLSc8FBnfn/ift3sy3rW0XxYWSob+oI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rZPTbanbjCgUaE5gLrsla4oS2aCtBnIy+iqWYFTlqBTvW6LBhmjZQw2O3g90hz1DFgAS2l9jlLVrIjM6W6oAJMPfe6XDu60UzLON3YmOOmsBdw+RgFw/qenSAAinpI/Mph2fUXz4AVK5FSL2V+jFb6NUXUJLmQ0i1oI8frhlyus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=k1w13OXd; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="k1w13OXd"
Message-ID: <3091f0f2-eaf0-469b-8221-55e8ef3c6812@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1778791081;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Z/h6ShPXwqAubj3ugdzXRuezfp6udXhwHKqFbqwWq08=;
	b=k1w13OXdmbqbua2Euz5iHCTjCOA4F/lYiMJiN2W9HtE4wkhBjxeu9IgEXxPGRUtnrkzCMP
	HDYPyoUfHSXv3V4NTjhdlLdpKFl4wY2iv5nJu3wh4nfAm6VVhgtgMceXIRtvEzjXDwaipa
	qZ6Pq9gPfUBw5KQ9wOr1Dl/NjQUaRtw=
Date: Thu, 14 May 2026 13:37:43 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf v4 2/3] bpf: Avoid faultable build ID reads under mm
 locks
To: bot+bpf-ci@kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, eddyz87@gmail.com, memxor@gmail.com
Cc: puranjay@kernel.org, shakeel.butt@linux.dev, mykyta.yatsenko5@gmail.com,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com,
 martin.lau@kernel.org, yonghong.song@linux.dev, clm@meta.com
References: <20260514184727.1067141-3-ihor.solodrai@linux.dev>
 <baab29c5bbb2d4b6885da72ef98a1b7da439c4479166c587de704f3587f51ae8@mail.kernel.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <baab29c5bbb2d4b6885da72ef98a1b7da439c4479166c587de704f3587f51ae8@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 5/14/26 12:37 PM, bot+bpf-ci@kernel.org wrote:
>> diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
>> index 4ef0fd06cea5..c1e96df360c3 100644
>> --- a/kernel/bpf/stackmap.c
>> +++ b/kernel/bpf/stackmap.c
>> @@ -9,6 +9,7 @@
>>  #include <linux/perf_event.h>
>>  #include <linux/btf_ids.h>
>>  #include <linux/buildid.h>
>> +#include <linux/mmap_lock.h>
>>  #include "percpu_freelist.h"
>>  #include "mmap_unlock_work.h"
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
>> +	struct mm_struct *mm = lock->mm;
>> +	struct vm_area_struct *vma;
>> +
>> +	if (WARN_ON_ONCE(!mm))
>> +		return NULL;
>> +
>> +	vma = lock_vma_under_rcu(mm, ip);
>> +	if (vma)
>> +		goto vma_locked;
>> +
>> +	if (!mmap_read_trylock(mm))
>> +		return NULL;
>> +
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
>> +vma_locked:
>> +	lock->vma_locked = true;
>> +	lock->vma = vma;
>> +	return vma;
>> +}
>> +
>> +static void stack_map_unlock_vma(struct stack_map_vma_lock *lock)
>> +{
>> +	struct vm_area_struct *vma = lock->vma;
>> +
>> +	if (lock->vma_locked) {
>> +		if (WARN_ON_ONCE(!vma))
>> +			goto out;
>> +		vma_end_read(vma);
>> +	}
>> +out:
>> +	lock->vma_locked = false;
>> +	lock->vma = NULL;
>> +}
>> +
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
>> +		ip = READ_ONCE(id_offs[i].ip);
>> +		vma = stack_map_lock_vma(&lock, ip);
>> +		if (!vma || !vma->vm_file) {
>> +			stack_map_build_id_set_ip(&id_offs[i]);
>> +			stack_map_unlock_vma(&lock);
>> +			continue;
>> +		}
> 
> Is the vm_file check here correct for classifying anonymous VMAs?
> Per mm-vma.md, vma->vm_file is not a reliable indicator of file-backed
> status. Some anonymous VMAs carry a vm_file reference, such as private
> mappings of /dev/zero set via vma_set_anonymous() which sets vm_ops
> = NULL but leaves vm_file populated.
> 
> The canonical test is vma_is_anonymous(vma) (checking !vma->vm_ops).
> For a private /dev/zero mapping, this code would pass /dev/zero to
> build_id_parse_file() instead of immediately falling back to the raw IP.
> 
> This was flagged in v3 review by bot+bpf-ci@kernel.org and acknowledged
> by the author as a minor edge case but left unchanged for consistency
> with existing code elsewhere in stackmap.c:
> 
> https://lore.kernel.org/bpf/1f275575e3c2309dc7b7f099c7e5cd47bb25182d94883ca0893cf4aaf03c954c@mail.kernel.org/
> 
> Should this be switched to vma_is_anonymous(), or is it preferable to
> keep the current pattern and address it later across all of stackmap.c?

I wonder why the bots are so concerned.

If they get support of at least one human I'll respin with an
additional patch adding vma_is_anonymous() checks.


> 
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
>> +		fput(file);
>> +
>> +		id_offs[i].offset = (vm_pgoff << PAGE_SHIFT) + ip - vm_start;
>> +		id_offs[i].status = BPF_STACK_BUILD_ID_VALID;
>> +	}
>> +}
> 
> [ ... ]
> 
>> @@ -178,6 +278,11 @@ static void stack_map_get_build_id_offset(struct bpf_stack_build_id *id_offs,
>>  	const char *prev_build_id;
>>  	int i;
>>
>> +	if (may_fault && has_user_ctx) {
>> +		stack_map_get_build_id_offset_sleepable(id_offs, trace_nr);
>> +		return;
>> +	}
>> +
>>  	/* If the irq_work is in use, fall back to report ips. Same
>>  	 * fallback is used for kernel stack (!user) on a stackmap with
>>  	 * build_id.
> 
> 
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
> 
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/25879521172

