Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF7222E8B83
	for <bpf@vger.kernel.org>; Thu,  9 Apr 2026 14:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775746282; cv=none; b=Y+v+vGqSRgJxhs5nFhKD4pQe20HGQdgzilwo1dmGg0UM2s+TP0aZbzf+uDS6GcTC3ksrLiUsoXz1PjbSd6FUNB6tlg96uvPdGINRXPcleub1SxRKnFm6azlgM3J1hWeF5doE6lmbDoGgrQHMM6qvy6YyxKWdGjaYq+yRnQFskdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775746282; c=relaxed/simple;
	bh=egI9q0znF73vG3hvf7kbEtPWcbPku7o6x+9QloxXuns=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AJ12auDce8kfqP6Kr8/W78VjLssBvs94qAaaQdKPitEolpQQ/aZ2sX0HqjJcXgBd5C5B7htW/QbK/+7fvPuDXRSBhbqEv/Bgz424IS6Rox5l4h5zwMrKn7iGAYrx1Oz8KOEEXNPPEP+XHxL4WNWFmcMF7L/cZwPG2Yk2caNbAwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HXHKEdv1; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HXHKEdv1"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-43ccda008cdso545292f8f.0
        for <bpf@vger.kernel.org>; Thu, 09 Apr 2026 07:51:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775746278; x=1776351078; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XCFONB0BZGVLwfaMI+ElBjgfDz4mBl9N0XIpJxn0i1E=;
        b=HXHKEdv1+uTx1xyiTI/LTvZFSdmop5o5vLNaRK9e796R8CAt0+xsSIWkL/ohNUMKS5
         5QZm3Z7BVUA5JQcAuDlRwpUUeDdR4rVhc09pGf0EaUB5kOE193wl+pTmpUl8Tlc1XyGt
         rbauLCRZtpiRRf9aaZ6bPBCpsnaGMPURjRuZC0MfALhXXy7VWYjmyz65frSpZLaXtymw
         von3ZESHCoLMRdmRne1zLZqjCf8AEWWAAts+dBuPUTDwXJH/vbKdozeDvYvBpm7a66pk
         XXsQA9h5qjOVEs6/2LuwDYd4DHg8Ah/Nms1BxY2XbJxdRrk05f8PCF4DwzQOAdFN9/VL
         QRAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775746278; x=1776351078;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XCFONB0BZGVLwfaMI+ElBjgfDz4mBl9N0XIpJxn0i1E=;
        b=P7Y712Xwj0CqyBCL4zTc3ZCEZFnSYkBUO2vEk2zU4JNhUoG0fc0fZsR8K7BcbC8uYk
         TFTeI6ykuOxM9HBiJhtZiR/GaX3MK7tVCYC3BFGlZi2oR4tz3x68jlIkKtacUaLLQKSN
         To3vRzSVnh7chfVzBjl8mvbVukWXKi6R/pn9ZaYasDWP4XwwTXOKhCKAVabSe3PDSvsW
         yPt4J5E7cgbpxoFqkbPV7PVqLd1OWjtTQnLcsQRjW9bIZvOr9z99Wo8JUkbFJMkzmH7a
         kgszhfvHi5O8sBHJebJ3hu6BcjbZA+66O4WMa5A+3DzVZMf/ZlRrZ8F6BriMlLVxQ36u
         yFFw==
X-Forwarded-Encrypted: i=1; AJvYcCWy7SyOL96URF/RM69+PHbtxjqO3CqGkxg/JtynBl27cFw5AuwhApR5rKAVycrl4ae9/MU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwpHt3JMWqQ5L3PnZqsvXNoPtXJkIityLD4/2AVYYycWVy5QXu
	38P3UHOaYDOuyHbQmrebPVBf8nTvnGyNGAksrhKIXVUuO4VlJ71R4HZk
X-Gm-Gg: AeBDiev/ivDl6Q6an2rmFxzPOiPYY1Re3FApkPw38omq3enu5OSk844elg0+RZJA5by
	O3XX2sbGvbsZGk82NgHXAg14SUIv+kkIy1+mUN9q+k+EUsgbzME0HHuA+dmUUCi/YPoRc5yuKDQ
	cXnlygQXMlvLEgV1jYET1OeqBRurIQlkuDdmy/Tq0CgZAAUheupMeM+DrCyVFnitSLoi7fbGoZ+
	aRbPsTUga9thf45tdzXVICLfYCY09K8DbFtRgc69526s/EeqauzStEx5JhRltTC02Uk+/5+IQLM
	Hz+NWrgr7dfjLjaAZyvq9HryDA3ZVHAclLq7D7BL2dLGG5FPKp4V/49tlyQZD7ZE6UJIEe/unbd
	6gfty6ecoYUc4qn9X2Uw79uSC9urpqMJUeWko7gxFCcVKnCOl0Ki8Bm9obKxo0Dvv3ar1mPxtXO
	bo6JG83kFgSyYeoD5iOCPOZv2QFqzDKo2X7gmrOoN4rngVJXS4lMd655bM4eV85GJPTetiXKU/k
	Kx5WRHpRWU=
X-Received: by 2002:a05:6000:4014:b0:43c:a352:c366 with SMTP id ffacd0b85a97d-43d595c4f98mr6133887f8f.25.1775746277373;
        Thu, 09 Apr 2026 07:51:17 -0700 (PDT)
Received: from ?IPV6:2a02:8109:a307:d900:a778:a387:b2af:188b? ([2a02:8109:a307:d900:a778:a387:b2af:188b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d473b8c1esm28181423f8f.12.2026.04.09.07.51.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Apr 2026 07:51:16 -0700 (PDT)
Message-ID: <ed1470d0-8894-4440-9234-a94e478a39e2@gmail.com>
Date: Thu, 9 Apr 2026 15:51:15 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf v2 2/2] bpf: Avoid faultable build ID reads under mm
 locks
To: Ihor Solodrai <ihor.solodrai@linux.dev>,
 Puranjay Mohan <puranjay@kernel.org>
Cc: Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Alexei Starovoitov <ast@kernel.org>,
 Song Liu <song@kernel.org>, Shakeel Butt <shakeel.butt@linux.dev>,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com
References: <20260409010604.1439087-1-ihor.solodrai@linux.dev>
 <20260409010604.1439087-3-ihor.solodrai@linux.dev>
 <bf91eb90-1b6a-4bad-a0e5-072f9dce7daa@linux.dev>
Content-Language: en-US
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
In-Reply-To: <bf91eb90-1b6a-4bad-a0e5-072f9dce7daa@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/9/26 5:20 AM, Ihor Solodrai wrote:
> 
> 
> On 4/8/26 6:06 PM, Ihor Solodrai wrote:
>> Sleepable build ID parsing can block in __kernel_read() [1], so the
>> stackmap sleepable path must not call it while holding mmap_lock or a
>> per-VMA read lock.
>>
>> The issue and the fix are conceptually similar to a recent procfs
>> patch [2].
>>
>> Resolve each covered VMA with a stable read-side reference, preferring
>> lock_vma_under_rcu() and falling back to mmap_read_lock() only long
>> enough to acquire the VMA read lock. Take a reference to the backing
>> file, drop the VMA lock, and then parse the build ID through
>> (sleepable) build_id_parse_file().
>>
>> [1]: https://lore.kernel.org/all/20251218005818.614819-1-shakeel.butt@linux.dev/
>> [2]: https://lore.kernel.org/all/20260128183232.2854138-1-andrii@kernel.org/
>>
>> Fixes: 777a8560fd29 ("lib/buildid: use __kernel_read() for sleepable context")
>> Assisted-by: Codex:gpt-5.4
>> Suggested-by: Puranjay Mohan <puranjay@kernel.org>
>> Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
>> ---
>>   kernel/bpf/stackmap.c | 139 ++++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 139 insertions(+)
>>
>> diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
>> index 4ef0fd06cea5..de3d89e20a1e 100644
>> --- a/kernel/bpf/stackmap.c
>> +++ b/kernel/bpf/stackmap.c
>> @@ -9,6 +9,7 @@
>>   #include <linux/perf_event.h>
>>   #include <linux/btf_ids.h>
>>   #include <linux/buildid.h>
>> +#include <linux/mmap_lock.h>
>>   #include "percpu_freelist.h"
>>   #include "mmap_unlock_work.h"
>>   
>> @@ -158,6 +159,139 @@ static inline void stack_map_build_id_set_ip(struct bpf_stack_build_id *id)
>>   	memset(id->build_id, 0, BUILD_ID_SIZE_MAX);
>>   }
>>   
>> +enum stack_map_vma_lock_state {
>> +	STACK_MAP_LOCKED_NONE = 0,
>> +	STACK_MAP_LOCKED_VMA,
>> +	STACK_MAP_LOCKED_MMAP,
>> +};
>> +
>> +struct stack_map_vma_lock {
>> +	enum stack_map_vma_lock_state state;
>> +	struct vm_area_struct *vma;
>> +	struct mm_struct *mm;
>> +};
>> +
>> +static struct vm_area_struct *stack_map_lock_vma(struct stack_map_vma_lock *lock, unsigned long ip)
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
> 
> Puranjay and others,
> 
> I tried to test this patch with CONFIG_PER_VMA_LOCK=n, and it turns
> out it's not easy to turn off.
> 
>      config PER_VMA_LOCK
>      	def_bool y
>      	depends on ARCH_SUPPORTS_PER_VMA_LOCK && MMU && SMP
> 
> AFAIU this definition means that PER_VMA_LOCK is automatically true if
> it's dependencies are satisfied. The only practical way to do it
> appears to be disabling SMP, which is probably very unusual.
> 
> So I am thinking, maybe instead of having to manage both mmap and vma
> lock in stackmap.c, we can assume CONFIG_PER_VMA_LOCK=y, and have
> 
>      #ifndef CONFIG_PER_VMA_LOCK
>      return -ENOTSUPP
>      #endif
> 
> somewhere in the stack_map_get_build_id_offset() callstack?
> Say in __bpf_get_stackid()?
> 
> Thoughts?
>

I looks like you are right, it should be safe to drop 
CONFIG_PER_VMA_LOCK=n case, I understand all platforms that care about 
BPF going to have it enabled.

>> +	if (!vma_start_read_locked(vma)) {
>> +		mmap_read_unlock(mm);
>> +		return NULL;
>> +	}
>> +	mmap_read_unlock(mm);
>> +#else
>> +	lock->state = STACK_MAP_LOCKED_MMAP;
>> +	lock->vma = vma;
>> +	return vma;
>> +#endif
>> +
>> +vma_locked:
>> +	lock->state = STACK_MAP_LOCKED_VMA;
>> +	lock->vma = vma;
>> +	return vma;
>> +}
>> +
>> +static void stack_map_unlock_vma(struct stack_map_vma_lock *lock)
>> +{
>> +	struct vm_area_struct *vma = lock->vma;
>> +	struct mm_struct *mm = lock->mm;
>> +
>> +	switch (lock->state) {
>> +	case STACK_MAP_LOCKED_VMA:
>> +		if (WARN_ON_ONCE(!vma))
>> +			break;
>> +		vma_end_read(vma);
>> +		break;
>> +	case STACK_MAP_LOCKED_MMAP:
>> +		if (WARN_ON_ONCE(!mm))
>> +			break;
>> +		mmap_read_unlock(mm);
>> +		break;
>> +	default:
>> +		break;
>> +	}
>> +
>> +	lock->state = STACK_MAP_LOCKED_NONE;
>> +	lock->vma = NULL;
>> +}
>> +
>> +static void stack_map_get_build_id_offset_sleepable(struct bpf_stack_build_id *id_offs,
>> +						    u32 trace_nr)
>> +{
>> +	struct mm_struct *mm = current->mm;
>> +	struct stack_map_vma_lock lock = {
>> +		.state = STACK_MAP_LOCKED_NONE,
>> +		.vma = NULL,
>> +		.mm = mm,
>> +	};
>> +	struct file *file, *prev_file = NULL;
>> +	unsigned long vm_pgoff, vm_start;
>> +	struct vm_area_struct *vma;
>> +	const char *prev_build_id;
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
>> +
>> +		file = vma->vm_file;
>> +		vm_pgoff = vma->vm_pgoff;
>> +		vm_start = vma->vm_start;
>> +
>> +		if (file == prev_file) {
>> +			memcpy(id_offs[i].build_id, prev_build_id, BUILD_ID_SIZE_MAX);
>> +			stack_map_unlock_vma(&lock);
>> +			goto build_id_valid;
>> +		}
>> +
>> +		file = get_file(file);
>> +		stack_map_unlock_vma(&lock);
>> +
>> +		/* build_id_parse_file() may block on filesystem reads */
>> +		if (build_id_parse_file(file, id_offs[i].build_id, NULL)) {
>> +			stack_map_build_id_set_ip(&id_offs[i]);
>> +			fput(file);
>> +			continue;
>> +		}
>> +
>> +		if (prev_file)
>> +			fput(prev_file);
>> +		prev_file = file;
>> +		prev_build_id = id_offs[i].build_id;
>> +
>> +build_id_valid:
>> +		id_offs[i].offset = (vm_pgoff << PAGE_SHIFT) + ip - vm_start;
>> +		id_offs[i].status = BPF_STACK_BUILD_ID_VALID;
>> +	}
>> +
>> +	if (prev_file)
>> +		fput(prev_file);
>> +}
>> +
>>   /*
>>    * Expects all id_offs[i].ip values to be set to correct initial IPs.
>>    * They will be subsequently:
>> @@ -178,6 +312,11 @@ static void stack_map_get_build_id_offset(struct bpf_stack_build_id *id_offs,
>>   	const char *prev_build_id;
>>   	int i;
>>   
>> +	if (may_fault && has_user_ctx) {
>> +		stack_map_get_build_id_offset_sleepable(id_offs, trace_nr);
>> +		return;
>> +	}
>> +
>>   	/* If the irq_work is in use, fall back to report ips. Same
>>   	 * fallback is used for kernel stack (!user) on a stackmap with
>>   	 * build_id.
> 
> 

