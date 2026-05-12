Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEB48385D70
	for <bpf@vger.kernel.org>; Tue, 12 May 2026 17:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778605775; cv=none; b=D7i34kTuTJlaQkYKaQv/5HEhg1zUrRqyTNzIyU8UEPGzHOdYtQjnGZLaRS3pevj6ASWAXsa5NOfHZbrqxHuXpPMeoIsAJDpAUfMCYBR9ipM2PBj/1C7s9IHuJVodes5iNN2pKxS5TqLlfDHPIqg5+4JJD8EoS+jOq0o/JM87ENw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778605775; c=relaxed/simple;
	bh=39EK1kbtnx4ozm2lvUD9hQYNGhVusYhlxaRSXATYwHE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Jdxi7NpTyUG325/qffFXmO6PppxJpAKrPcsLhXG4OdmQ6BIKRLukCEMcszB5EIVrFatMpNkFW8Pe0OuAP/XxoOwWJhZZzG1rTKuSR0Cc0pFsgsvBS9IsdGGPo+y1SzVM79hK50HH9Kj38jHhoihUm2jn9b+G7RVYpoeMdr9iqA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=OUB8C6gb; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="OUB8C6gb"
Message-ID: <39d0cfb5-37bb-456c-bd90-0854b23c74f0@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1778605770;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qE9Dh9/WcPC3xggG0TeIAvtNDXMz6HDbI83KVGqQdgQ=;
	b=OUB8C6gbH+3DP4C1TQdKbG3VyDC8TY7LTDkQhleIW3BBv5PcbxBaxq8E/c4hA1haztISLo
	VS+hNKhQuBHWEtIE0/+QSBt5QkZNNwNfxiKWuZ3iNei0cJ5A3a5fx3p726b1a5i4KjdFBE
	6L5ikuTyvOW38BL3drWLgCmWDDpBm+Y=
Date: Tue, 12 May 2026 10:09:23 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf v3 2/3] bpf: Avoid faultable build ID reads under mm
 locks
To: bot+bpf-ci@kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, eddyz87@gmail.com, memxor@gmail.com
Cc: puranjay@kernel.org, shakeel.butt@linux.dev, mykyta.yatsenko5@gmail.com,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com,
 martin.lau@kernel.org, yonghong.song@linux.dev, clm@meta.com
References: <20260512032906.2670326-3-ihor.solodrai@linux.dev>
 <1f275575e3c2309dc7b7f099c7e5cd47bb25182d94883ca0893cf4aaf03c954c@mail.kernel.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <1f275575e3c2309dc7b7f099c7e5cd47bb25182d94883ca0893cf4aaf03c954c@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 5/11/26 9:16 PM, bot+bpf-ci@kernel.org wrote:
>> diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
>> index 4ef0fd06cea5..c1e96df360c3 100644
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
>                             ^^^^^^^^
> 
> A subsystem pattern flags this as potentially concerning: the code uses
> !vma->vm_file to classify the VMA as anonymous. Per mm-vma.md's VMA
> classification rules, the correct test for anonymous VMAs is
> vma_is_anonymous() (i.e. !vma->vm_ops). Some anonymous VMAs carry a
> vm_file reference (e.g. private mappings of /dev/zero set via
> vma_set_anonymous() while leaving vm_file populated).
> 
> On such VMAs, this code would proceed down the file-backed path and hand
> /dev/zero (or any other vma_set_anonymous()-style driver file) to
> build_id_parse_file() instead of immediately falling back to reporting
> the raw IP. build_id_parse_file() would fail the ELF-magic check and
> return an error, so the practical effect is a wasted pinned-file
> reference and a pointless sleepable read attempt. However, the mm
> subsystem guide directs that this pattern be reported.
> 
> The existing non-sleepable stack_map_get_build_id_offset()/build_id_parse()
> in this same subsystem also uses !vma->vm_file, so the new code is
> consistent with pre-existing style.
> 
>> +			stack_map_build_id_set_ip(&id_offs[i]);
>> +			stack_map_unlock_vma(&lock);
>> +			continue;
>> +		}

This is a minor edge case, resulting in unnecessary sleepable read.
The fix is simple, but would be inconsistent with the surrounding code.

I'd rather leave it as is for now, and if there is a strong reason to
switch to vma_is_anonymous() - then fix it everywhere in stackmap.c

> 
> Mykyta Yatsenko suggested an optimization in v2 that has not been
> implemented: cache vm_start and vm_end, and if the next IP is in range,
> reuse the previous build ID without locking the VMA. This would avoid
> repeated lock/unlock cycles for consecutive IPs in the same VMA.
> 
> The current v3 code only caches the file reference for same-file
> optimization, not the VMA range. See the original discussion at
> https://lore.kernel.org/bpf/8b2cf5ca-182e-4eb2-ab90-8fab9d81f6e1@gmail.com/

The bot failed to notice that the optimization suggested by Mykyta is
implemented in the patch #3.

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
>> +
>>  /*
>>   * Expects all id_offs[i].ip values to be set to correct initial IPs.
>>   * They will be subsequently:
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
> Commit message:
> 
>>     bpf: Avoid faultable build ID reads under mm locks
>>
>>     Sleepable build ID parsing can block in __kernel_read() [1], so the
>>     stackmap sleepable path must not call it while holding mmap_lock or a
>>     per-VMA read lock.
>>     The issue and the fix are conceptually similar to a recent procfs
>>     patch [2].
>>     Resolve each covered VMA with a stable read-side reference, preferring
>>     lock_vma_under_rcu() and falling back to mmap_read_trylock() only long
>>     enough to acquire the VMA read lock. Take a reference to the backing
>>     file, drop the VMA lock, and then parse the build ID through
>>     (sleepable) build_id_parse_file().
>>     [1]: https://lore.kernel.org/all/20251218005818.614819-1-shakeel.butt@linux.dev/
>>     [2]: https://lore.kernel.org/all/20260128183232.2854138-1-andrii@kernel.org/
>>     Fixes: 777a8560fd29 ("lib/buildid: use __kernel_read() for sleepable context")
> 
> The existing Fixes tag points to commit 777a8560fd29 ("lib/buildid: use
> __kernel_read() for sleepable context"), but the bug was actually
> introduced by commit d4dd9775ec24 ("bpf: wire up sleepable
> bpf_get_stack() and bpf_get_task_stack() helpers").
> 
> The d4dd9775ec24 commit introduced the pattern of calling potentially
> sleepable build_id_parse() while holding mm locks via find_vma(). Commit
> 777a8560fd29 only made the latent blocking behavior more severe by using
> __kernel_read(), but the architectural issue of calling sleepable
> functions under locks was introduced earlier.
> 
> Should this be:
> 
>   Fixes: d4dd9775ec24 ("bpf: wire up sleepable bpf_get_stack() and bpf_get_task_stack() helpers")

This is reasonable. Will change Fixes tag in v4.

Going to wait a bit in case there is more feedback from reviewers.

> 
> 
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
> 
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/25711733137

