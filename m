Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A248833D50B
	for <bpf@vger.kernel.org>; Thu, 22 Jan 2026 16:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769098735; cv=none; b=p8roJ7eUYeIRar0LyOnhxE1WMX4iGeh116ajxWI2olb2hOMja0+NX6lE8Bl6Wb4IFD0j/FfqO/Yho6O6j+OyWmrwg+dWSIN1giIil7a2uL3Au0iYPs7n8hTeR/pl0OPkL5yBo4rjNDDlFVTFD7Txlbq13PQLyNJBHhWv58v0C9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769098735; c=relaxed/simple;
	bh=6m84fXPYmIa6Srtu3bxD2w8mWJXJVIDWmpFHfgiRMRE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eIJ7IpfMh14Nv1YAocVcPNy8BImuPCkuTR/vNXeF/mi/JtTlrg3Ew327HdUHmYzgsYchPKFF4Q1OB6cZMfRaN9yAl3IR8kYs15QKVwhOZKMJ8YHiVjebE0pW3iACLbmujSwdlBiz0ktVC4xT0Iq63cap5mAIDoWSZtmkvUHTIMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=weJ6tGLO; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="weJ6tGLO"
Message-ID: <3fdcdea9-3f09-452e-bd6c-717294f288d6@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1769098723;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1EOwjbCVT+0F4GYVG0LrpQ7Dngd0/bAjkROIFVneHsQ=;
	b=weJ6tGLOaV+I4C/T9wKLsclE7bboyZWX5QwkSJzAO9QQfe2hkkUhvoOsjPGRTXS8NSx012
	qC0g5pqwEmLKZoTo3Aqu+kaEmdZClRPT+jdAmxrg0Xd/8yPAfY2kBtqKZvF3L91vZhetco
	hvyrEVbHHoKDy8d4VLH9bDFuWho5X9o=
Date: Fri, 23 Jan 2026 00:18:28 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 1/2] bpf: Disallow BPF_F_LOCK with mixed special
 fields and centralize flag checks
To: bot+bpf-ci@kernel.org, bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
 andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, shuah@kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 kernel-patches-bot@fb.com, martin.lau@kernel.org, clm@meta.com,
 ihor.solodrai@linux.dev
References: <20260122153120.69249-2-leon.hwang@linux.dev>
 <df8fb7dc501dd081fcba56b592cba94e5aecd614ea4d3b595155dec551ecbca5@mail.kernel.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <df8fb7dc501dd081fcba56b592cba94e5aecd614ea4d3b595155dec551ecbca5@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 2026/1/23 00:02, bot+bpf-ci@kernel.org wrote:
>> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
>> index 5936f8e2996f..c5863487ee73 100644
>> --- a/include/linux/bpf.h
>> +++ b/include/linux/bpf.h
>> @@ -3935,9 +3935,16 @@ static inline int bpf_map_check_op_flags(struct bpf_map *map, u64 flags, u64 all
>>  	if ((u32)flags & ~allowed_flags)
>>  		return -EINVAL;
>>
>> +	/* BPF_NOEXIST and BPF_EXIST are mutually exclusive. */
>> +	if ((flags & (BPF_NOEXIST | BPF_EXIST)) == (BPF_NOEXIST | BPF_EXIST))
>> +		return -EINVAL;
>> +
>>  	if ((flags & BPF_F_LOCK) && !btf_record_has_field(map->record, BPF_SPIN_LOCK))
>>  		return -EINVAL;
>>
>> +	if ((flags & BPF_F_LOCK) && btf_record_has_field(map->record, ~BPF_SPIN_LOCK))
>> +		return -EOPNOTSUPP;
>> +
>>  	if (!(flags & BPF_F_CPU) && flags >> 32)
>>  		return -EINVAL;
> 
> [ ... ]
> 
>> diff --git a/kernel/bpf/bpf_local_storage.c b/kernel/bpf/bpf_local_storage.c
>> index e2fe6c32822b..80b50091cbbf 100644
>> --- a/kernel/bpf/bpf_local_storage.c
>> +++ b/kernel/bpf/bpf_local_storage.c
>> @@ -493,13 +493,6 @@ bpf_local_storage_update(void *owner, struct bpf_local_storage_map *smap,
>>  	unsigned long flags;
>>  	int err;
>>
>> -	/* BPF_EXIST and BPF_NOEXIST cannot be both set */
>> -	if (unlikely((map_flags & ~BPF_F_LOCK) > BPF_EXIST) ||
>> -	    /* BPF_F_LOCK can only be used in a value with spin_lock */
>> -	    unlikely((map_flags & BPF_F_LOCK) &&
>> -		     !btf_record_has_field(smap->map.record, BPF_SPIN_LOCK)))
>> -		return ERR_PTR(-EINVAL);
>                 ^^^^
> 
> This validation was removed from bpf_local_storage_update() but it appears
> that no call to bpf_map_check_op_flags() was added in the local storage map
> update functions. For array and hash maps, calls to bpf_map_check_op_flags()
> were added in array_map_update_elem() and htab_map_update_elem(). However,
> the local storage update functions like bpf_cgrp_storage_update_elem(),
> bpf_fd_inode_storage_update_elem(), and bpf_fd_sk_storage_update_elem() pass
> map_flags directly to bpf_local_storage_update() without calling
> bpf_map_check_op_flags() first.
> 
> The syscall path does call bpf_map_check_op_flags() in map_update_elem() with
> allowed_flags set to ~0, which catches the NOEXIST/EXIST mutual exclusion and
> BPF_F_LOCK validation. But with allowed_flags=~0, the check for unknown flags
> ((u32)flags & ~allowed_flags) always passes zero, meaning unknown flags like
> 8 or 16 would not be rejected.
> 

Correct.

Such flags should indeed be rejected in the local storage update path.

Thanks,
Leon


> The old check (map_flags & ~BPF_F_LOCK) > BPF_EXIST rejected any unknown flag
> bits. Is there a missing call to bpf_map_check_op_flags() in the local storage
> update functions that should specify the allowed flags?
> 
>> -
>>  	if (gfp_flags == GFP_KERNEL && (map_flags & ~BPF_F_LOCK) != BPF_NOEXIST)
>>  		return ERR_PTR(-EINVAL);
> 
> [ ... ]
> 
> 
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
> 
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/21254704407

