Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4D3A3793BF
	for <bpf@vger.kernel.org>; Fri, 29 May 2026 17:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780074534; cv=none; b=DDopPjasD2JkoYmzxUb1O30uReiUDCxwgyR2ogJCKZNCheV7C/b/2Fi4lnqWSMea/a9IuL3fqf4v7qgUA47Byvp/Uim85Pve5CfrrJ568mZOXeMX7xaUlbeusE6aAwVTHIYUgWeIYR5mYmu9v2XsfasVhDThveiRq55U2KxwUjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780074534; c=relaxed/simple;
	bh=EeO9548ggONK+qGA2Cx/kXmoQJhdIQsIq1DeSRj9BQo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UNkp2W+HQDbQww3EGklNwtmu2ME1JCd14E0STlkaHiuM6sRdnsmcCqQg3J2D5XP1wVu1gUbC8893B1Zt09kla72NhuRbgH5s048RaAQjQnqQWYP4Um5Ds2oNejGYO0M68Rn2FApQ5nONvbpEonIbOsxuiHjjNMF6zgHRZXZHW+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KdeZu+/Y; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KdeZu+/Y"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4891d7164ddso67760915e9.3
        for <bpf@vger.kernel.org>; Fri, 29 May 2026 10:08:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780074531; x=1780679331; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1r/opIlcbAo7ZnxOeh8fVrulnI6XXhLMuiNGbvKW8cA=;
        b=KdeZu+/YDPMZeukTV9czIN0ooPdlPQTfJufBLRfcFHnRTKMDJQ5Vpa3u05o3FzPTzv
         9QmwQRc7anR7HNaUqgoSi09KRdfdecuay2Bl0IWhk/YJpteu5QuioWkg6SqysvULvU4R
         F6PixeUT+JzN8reH5t2K4WLkq9l2PLhg8Zkq+brvC4eGAwVHIx44uAnPUDOoboTCuPJs
         +jB2/sXf1NlHxI1ZbS46WnIQmO8rxp8D7KS/YWZ0NcaVFRc0x9iIVx7526fMAGXDc723
         chUo6adcSmO0UBTrrDJPsy7WNV6XO6FBR7ys9XpIlHo0G2dDt+D5d2YDWmLvGDDDcjwb
         A/iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780074531; x=1780679331;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1r/opIlcbAo7ZnxOeh8fVrulnI6XXhLMuiNGbvKW8cA=;
        b=eNB73QjSSCWWPXG2KSBqfSUZpp2kCzi0krt51yLyS6TSxmrCErF5JA4SxPoQujl5vO
         yI6S4sUHYyaIsADql5RzaKsD21n3OXgD/NE0M8dekXgzK49SGNG1weN4rQ/r0nonU2Oh
         VeoW3A5nQisAmEq8i+3O0SL4YbmW+xgavATwYpBa3O7dwUelTzFhHgf5RhK7GuoGkDLQ
         tJrv1gXU9MZ87TpQbt2pbdRelqc0Y4nSf3qKdaHESEMmWerYv+RywXzTAyni1hiTWObf
         M4FeUXWzxyIXjhtC4r9JIFsBLyc8aj0Al3q3ljByh9S9N1tlx7X0aOUQwhNFePKhlRFe
         NeFA==
X-Forwarded-Encrypted: i=1; AFNElJ+npY7WIDMsHvWU77p4NRbi3ABoV3yKTRRP20UmWEdcY8OhA2ajPoi7wYLWqBul7/Q2TVg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBdXMUDqE+L5V/HI5MgnuVrHtPJOpo73uLoT7NPs/ggFzCZ4GH
	Dsy+LW/WbLBCJHtkAO5c+UWZtQJmpptHaj7EsbOxznYdT3A+8QCbQM2/
X-Gm-Gg: Acq92OFEb449/VIZesJs3mlGm6jzMXfFapuoc02Jn//O17VrgFDfKMVdup8Htbe0O1z
	HatJgSld6OJRp3NbEm54K5JLP0PcemaOFIwFPX/TPhICI/QQtfnIdvpXvJL4FtBZht392BdQJLN
	2xL5V+6/0AZ4UgFY7GnJP64ZEfZWYKFEl86SNY8K8iIME5KiEHevpbyA0On9WJ9UtkV3vdn4Jij
	vxhOlABMVtNCB70VaGRfqGSjGrT5VXA9JUa457soF5EkXBSi9Y3z7SGgH5N+9yIXtVdSRbsuCid
	+8kCgKcdErbyiE8fgeyyNmMhULfbHLxQE1a+Rlovi9Onw+4lc5WI4fXMz6SI/tp/R/MxKbcllZr
	jM3UkaKtkWMaJb6GyXar+O9NXacpovt+78D6Bp0goibvxQRihEVvGYDzxvGKynubwgTpLCz4cC5
	zDkKHfN9m5Rf9zK00cz2x9MT64lez2/I4HSND7sL+/lJ/uzJugEs1AVF2O7z2ILZaZx5mJ6Q2+Q
	OmxCsx9vr1twLBFDrq8sQ==
X-Received: by 2002:a05:600c:818c:b0:490:48df:2793 with SMTP id 5b1f17b1804b1-490a296df9amr7230055e9.26.1780074530662;
        Fri, 29 May 2026 10:08:50 -0700 (PDT)
Received: from ?IPV6:2a01:4b00:bd1f:f500:f867:fc8a:5174:5755? ([2a01:4b00:bd1f:f500:f867:fc8a:5174:5755])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45ef356b129sm6225225f8f.32.2026.05.29.10.08.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 May 2026 10:08:50 -0700 (PDT)
Message-ID: <05c8bdae-83dc-4456-89dd-8e10360b5f92@gmail.com>
Date: Fri, 29 May 2026 18:08:49 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v5 03/11] bpf: Implement resizable hashmap basic
 functions
To: bot+bpf-ci@kernel.org, bpf@vger.kernel.org, ast@kernel.org,
 andrii@kernel.org, daniel@iogearbox.net, kafai@meta.com,
 kernel-team@meta.com, eddyz87@gmail.com, memxor@gmail.com,
 herbert@gondor.apana.org.au
Cc: yatsenko@meta.com, martin.lau@kernel.org, yonghong.song@linux.dev,
 clm@meta.com, ihor.solodrai@linux.dev
References: <20260528-rhash-v5-3-7205191b6c57@meta.com>
 <fd400a6c3c1452ca221fe95e15d160f014605ff826271d4954fc5cb31c08ece9@mail.kernel.org>
Content-Language: en-US
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
In-Reply-To: <fd400a6c3c1452ca221fe95e15d160f014605ff826271d4954fc5cb31c08ece9@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 5/28/26 7:42 PM, bot+bpf-ci@kernel.org wrote:
>> diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
>> index 3dd9b4924ae4..8944c9f070ca 100644
>> --- a/kernel/bpf/hashtab.c
>> +++ b/kernel/bpf/hashtab.c
> 
> [ ... ]
> 
>> +static void rhtab_free_elem(void *ptr, void *arg)
>> +{
>> +	struct bpf_rhtab *rhtab = arg;
>> +	struct rhtab_elem *elem = ptr;
>> +
>> +	bpf_map_free_internal_structs(&rhtab->map, rhtab_elem_value(elem, rhtab->map.key_size));
>> +	bpf_mem_cache_free_rcu(&rhtab->ma, elem);
>> +}
> 
> bpf_map_free_internal_structs only handles timers, workqueues, and
> task_work (not kptrs, list_heads, rb_roots, or refcounted objects). In
> contrast, htab's htab_elem_free calls check_and_free_fields which
> eventually invokes bpf_obj_free_fields for the full field list. As a
> result, when this restriction is later lifted, rhtab_free_elem would
> leak kptrs and skip list/rbtree drains during map teardown.
> 
> The issue is latent at this commit because syscall.c map_check_btf
> rejects all those field types for RHASH maps (map->record is NULL), but
> the follow-up commit that enables the field types must rewrite this
> entire function and add a memalloc destructor with bpf_obj_free_fields.
> 

I'll remove bpf_map_free_internal_structs() from this commit.

> [ ... ]
> 
>> +static int rhtab_delete_elem(struct bpf_rhtab *rhtab, struct rhtab_elem *elem, void *copy,
>> +			     u64 flags)
>> +{
>> +	int err;
>> +
>> +	/*
>> +	 * disable_instrumentation() mitigates the deadlock for programs running in NMI context.
>> +	 * rhashtable locks bucket with local_irq_save(). Only NMI programs may reenter
>> +	 * rhashtable code, bpf_disable_instrumentation() disables programs running in NMI, except
>> +	 * raw tracepoints, which we don't have in rhashtable.
>> +	 */
>> +	bpf_disable_instrumentation();
>> +	err = rhashtable_remove_fast(&rhtab->ht, &elem->node, rhtab_params);
>> +	bpf_enable_instrumentation();
> 
> Does bpf_disable_instrumentation prevent the softirq deadlock scenario?
> 
> The v4 bot review noted that if a syscall holds the bucket lock and
> is interrupted by hardware IRQ that schedules softirq (e.g., XDP or TC
> program), the softirq would deadlock trying to acquire the same bucket
> lock. bpf_disable_instrumentation only prevents NMI-based tracing
> programs, not softirq programs triggered by hardware IRQs.

bucket lock does local_irq_save(), so XDP or TC programs 
cannot run during the critical section, only NMI can, which is 
handled by the bpf_disable_instrumentation().

> 
> Alexei Starovoitov suggested in v1 that update/delete operations should
> check 'if (irqs_disabled()) return -EBUSY' to prevent this class of
> deadlock. That check is not present in this version.
> 
> Reference: https://lore.kernel.org/bpf/faddde9d9654bea549cb0acf434a4dcd06217d795a0717af028a61e453ce8ea6@mail.kernel.org/
> 
>> +
>> +	if (err)
>> +		return err;
>> +
>> +	if (copy) {
>> +		rhtab_read_elem_value(&rhtab->map, copy, elem, flags);
>> +		check_and_init_map_value(&rhtab->map, copy);
>> +	}
>> +
>> +	bpf_mem_cache_free_rcu(&rhtab->ma, elem);
>> +	return 0;
>> +}
> 
> The element is freed with bpf_mem_cache_free_rcu without calling
> bpf_obj_free_fields or check_and_free_fields on the value. Compare with
> htab's free_htab_elem which calls check_and_free_fields before freeing.
> 
> Once special fields are enabled for RHASH maps (by a later commit),
> deleting an element with kptrs, list_heads, or rb_roots would leak those
> resources. The later commit that enables special fields adds
> rhtab_check_and_free_fields here.

When special fields are enabled, they are handled by this code as well.

> 
> [ ... ]
> 
>> +static long rhtab_map_update_existing(struct bpf_map *map, struct rhtab_elem *elem, void *value,
>> +				      u64 map_flags)
>> +{
>> +	void *old_val = rhtab_elem_value(elem, map->key_size);
>> +
>> +	if (map_flags & BPF_NOEXIST)
>> +		return -EEXIST;
>> +
>> +	if (map_flags & BPF_F_LOCK)
>> +		copy_map_value_locked(map, old_val, value, false);
>> +	else
>> +		copy_map_value(map, old_val, value);
>> +	return 0;
>> +}
> 
> copy_map_value deliberately skips special-field offsets so it doesn't
> clobber kptr/timer/list_head pointers. After this in-place update
> returns, the element's value contains the new scalar bytes but still
> holds the OLD kptrs, timers, and work-queue handles at the special
> offsets.
> 
> Arraymap and htab both invoke bpf_obj_free_fields or cancel timers on
> the old value after the scalar copy to release the per-element
> resources. The follow-up commit that enables special fields adds
> rhtab_check_and_free_fields after the copy to match this pattern.
> 

In this commit special fields are not yet supported. There is a separate
commit implementing it.

> [ ... ]
> 
>> +static long rhtab_map_update_elem(struct bpf_map *map, void *key, void *value, u64 map_flags)
>> +{
>> +	struct bpf_rhtab *rhtab = container_of(map, struct bpf_rhtab, map);
>> +	struct rhtab_elem *elem, *tmp;
>> +
>> +	if (unlikely((map_flags & ~BPF_F_LOCK) > BPF_EXIST))
>> +		return -EINVAL;
>> +
>> +	if ((map_flags & BPF_F_LOCK) && !btf_record_has_field(map->record, BPF_SPIN_LOCK))
>> +		return -EINVAL;
> 
> Similar deadlock question as rhtab_delete_elem: does
> bpf_disable_instrumentation (used later in this function) prevent the
> softirq deadlock where a syscall holds the bucket lock and is interrupted
> by hardware IRQ that schedules softirq?
> 
> Reference: https://lore.kernel.org/bpf/faddde9d9654bea549cb0acf434a4dcd06217d795a0717af028a61e453ce8ea6@mail.kernel.org/
> 
> [ ... ]
> 
>> +	elem = bpf_mem_cache_alloc(&rhtab->ma);
>> +	if (!elem)
>> +		return -ENOMEM;
>> +
>> +	memcpy(elem->data, key, map->key_size);
>> +	copy_map_value(map, rhtab_elem_value(elem, map->key_size), value);
> 
> bpf_mem_cache_alloc returns memory that is not zeroed at special-field
> offsets (the cache may recycle freed objects). copy_map_value
> deliberately skips those offsets. The freshly inserted element's value
> therefore has uninitialized bytes at every special-field offset (timer
> pointer, kptr, list_head, rb_root, etc.).
> 
> The canonical pattern is to call check_and_init_map_value after
> copy_map_value to zero-initialize or call the field-specific init for
> every special-field offset. htab does this in alloc_htab_elem and
> pcpu_init_value. The follow-up commit adds check_and_init_map_value
> here.

Right, the missing pieces for special fields support are added later.

> 
> [ ... ]
> 
>> +
>> +BTF_ID_LIST_SINGLE(rhtab_map_btf_ids, struct, bpf_rhtab)
>> +const struct bpf_map_ops rhtab_map_ops = {
>> +	.map_meta_equal = bpf_map_meta_equal,
>> +	.map_alloc_check = rhtab_map_alloc_check,
>> +	.map_alloc = rhtab_map_alloc,
>> +	.map_free = rhtab_map_free,
>> +	.map_get_next_key = rhtab_map_get_next_key,
>> +	.map_release_uref = rhtab_map_free_internal_structs,
>> +	.map_lookup_elem = rhtab_map_lookup_elem,
>> +	.map_lookup_and_delete_elem = rhtab_map_lookup_and_delete_elem,
>> +	.map_update_elem = rhtab_map_update_elem,
>> +	.map_delete_elem = rhtab_map_delete_elem,
>> +	.map_gen_lookup = rhtab_map_gen_lookup,
>> +	.map_btf_id = &rhtab_map_btf_ids[0],
>> +};
> 
> rhtab_map_ops does not define a .map_mem_usage callback. At this commit,
> kernel/bpf/syscall.c __map_create enforces:
> 
>   if (!ops->map_mem_usage)
>     return -EINVAL;
> 
> This check sits before map_alloc. As a result, every attempt to create a
> BPF_MAP_TYPE_RHASH map fails with -EINVAL at the bpf(BPF_MAP_CREATE)
> syscall. No code path inside rhtab_map_alloc / rhtab_map_update_elem /
> etc. is reachable from user space.
> 
> The commit's stated runtime semantics (use rhashtable_lookup_likely for
> lookups, in-place updates) are untestable because no map of this type
> can exist. The bpf_map_show_fdinfo path also relies on
> map->ops->map_mem_usage(map) without a NULL check, so even if the create
> check were bypassed, /proc/[pid]/fdinfo/[map_fd] would NULL-deref.
> 
> The follow-up commit 'bpf: Implement iteration ops for resizable
> hashtab' adds rhtab_map_mem_usage and wires .map_mem_usage =
> rhtab_map_mem_usage in rhtab_map_ops. Each patch must compile and
> introduce a working feature when applied to a kernel that bisects to it.
> This commit is the first to expose BPF_MAP_TYPE_RHASH to user space (it
> touches uapi bpf.h and the syscall.c switch), so this missing callback
> breaks bisection.

I'll move map_mem_usage to this commit. 

> 
> [ ... ]
> 
>> +static int rhtab_map_get_next_key(struct bpf_map *map, void *key, void *next_key)
>> +{
>> +	return -EOPNOTSUPP;
>> +}
> 
> rhtab_map_get_next_key always returns -EOPNOTSUPP, meaning userspace
> cannot iterate keys of a BPF_MAP_TYPE_RHASH map via the standard syscall
> API, and tools like bpftool dump cannot list rhtab map contents.
> 
> The series previously added rhashtable_next_key API which provides
> best-effort iteration, but it was never wired up.

Implemented in the next commit.

> 
> Reference: https://lore.kernel.org/bpf/faddde9d9654bea549cb0acf434a4dcd06217d795a0717af028a61e453ce8ea6@mail.kernel.org/
> 
> [ ... ]
> 
> Multiple map_ops are registered as functional callbacks but are stubs
> that were removed in v5. However, in v5 many callbacks that should be
> present are missing entirely (map_seq_show_elem, map_for_each_callback,
> map_mem_usage, BATCH_OPS, iter_seq_info).
> 
> While returning -EOPNOTSUPP is graceful (no crash), registering ops
> pointers that fail rather than relying on the dispatcher's NULL check
> defeats the verifier's compile-time validation: the verifier will accept
> BPF programs that call bpf_for_each_map_elem on an rhtab map, only to
> fail at runtime. Should these callbacks be NULL instead?
> 
> Reference: https://lore.kernel.org/bpf/faddde9d9654bea549cb0acf434a4dcd06217d795a0717af028a61e453ce8ea6@mail.kernel.org/
> 
> [ ... ]
> 
>> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
>> index 8d4ea700aac6..12c07310016a 100644
>> --- a/kernel/bpf/syscall.c
>> +++ b/kernel/bpf/syscall.c
> 
> [ ... syscall.c changes for map_extra and map_lookup_and_delete_elem allowlist ... ]
> 
> The commit message states: 'Updates modify values in place under RCU
> rather than allocating a new element... This trades read consistency for
> performance: concurrent readers may see partial updates. Users requiring
> consistent reads should use BPF_F_LOCK.'
> 
> The rhtab implementation in kernel/bpf/hashtab.c is wired for BPF_F_LOCK:
> rhtab_map_update_elem checks btf_record_has_field(map->record,
> BPF_SPIN_LOCK), and rhtab_read_elem_value / rhtab_map_update_existing
> call copy_map_value_locked when BPF_F_LOCK is set.
> 
> However, this patch does not add BPF_MAP_TYPE_RHASH to the BPF_SPIN_LOCK
> allow-list in map_check_btf at kernel/bpf/syscall.c (the case
> BPF_SPIN_LOCK block that lists HASH, ARRAY, CGROUP_STORAGE, SK_STORAGE,
> INODE_STORAGE, TASK_STORAGE, CGRP_STORAGE).
> 
> When a user attempts to create an RHASH map whose value type contains a
> struct bpf_spin_lock (the only way to enable BPF_F_LOCK on a map),
> __map_create calls map_check_btf, the BPF_SPIN_LOCK case checks the
> allow-list, does not find BPF_MAP_TYPE_RHASH, and returns -EOPNOTSUPP.
> The map cannot be created.
> 
> Therefore the BPF_F_LOCK code paths in rhtab_map_* are unreachable in
> this commit, contradicting the commit message. A user bisecting a tree
> at this commit and trying to use the documented BPF_F_LOCK feature on an
> RHASH map will get -EOPNOTSUPP at map creation time.
> 
> The follow-up commit 'bpf: Allow special fields in resizable hashtab'
> adds BPF_MAP_TYPE_RHASH to both the BPF_SPIN_LOCK and
> BPF_TIMER/BPF_WORKQUEUE/BPF_TASK_WORK switch cases in map_check_btf.
> 
> 
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
> 
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/26592533594

