Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9B6F313523
	for <bpf@vger.kernel.org>; Thu,  9 Apr 2026 16:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775752468; cv=none; b=ENoiMbbD2d3dcse9UTRliMavlG8ozXKcjm+TdBXFtMgNyhYJ52fjoY88ebOV2aXMQPrll+vTdWwoU1jgcnasXBwbFo5PTJu303VH74dQYwQJ+8kPi9iifKbLKkWxwqcSUfIbL0hnep+H23Ry6LFCzNHEqNYeG/c9/F0OP1zIgIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775752468; c=relaxed/simple;
	bh=METGK04ryGHcQ/U35h8TONr9BWhZQDq80ytvBImLDX0=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=ttQDMv32j0MPzP/IciLOjZNpdnPDCJrW9MuwucFKBXcCw/8NME3x+yv1miBRWu98L64uAElDIj0BYvVPbBrnLbNZ6bjX35eTKlJ7HWyH58vB2Wsfbc7UiyacaA1FjVZuX3Va+z3ExgZGKuVAEPdlk+iJrz4fXKyEidOxRXBIvd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hUp9J0/W; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hUp9J0/W"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4889e045bc6so11779505e9.2
        for <bpf@vger.kernel.org>; Thu, 09 Apr 2026 09:34:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775752464; x=1776357264; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=jcT3kOCYRfHMctO89ppujl+cc+Eu9ieuBFLCV25N2tc=;
        b=hUp9J0/WS3TK6DAGUXUghRoA3afVdy9WCYgpRhcwvBtJI3rJ9TS4lcUVM2BXVhK8Bb
         bhv7GDjz/Mj+kVLz6lqDQNhWb2kB5+EtJJtUjU2C3GF71HgeT4ZKTKoemG4uS+QCGWD2
         V2sDxxBa8qdRApDsyMt+Yz7M6TpcDvwbYGVxWUXzcThyrmS5VRw4lQKhkRfkYnd4Cdrt
         ZYR2UG0dSgymrbbe2kLiSv02+dV8xC/C34W/5OBcWkMAhbCjbQQKF/NdQqHuN4WcAwD4
         ie90Zn7mP1mpCGp4kZYIxLmg6FRIVAHC3Ys9zLRuAFMx2Kr1Tu0JgJp1bauxRc5Kt8bG
         Bxeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775752464; x=1776357264;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jcT3kOCYRfHMctO89ppujl+cc+Eu9ieuBFLCV25N2tc=;
        b=qaz9DwSC1L/NoLaipE6YS3T+LDrrjQhd3gdESlfpsFLTtM1PJxFzCTTcoxC6gFw6xT
         oIl9LysWP/SFmtcOE1n7Rldjs7Soc2D16PkYUF11ULyYln1JEoFKaBMKWXmfh/ChOnHo
         HcenbIVwYV8H4UhcgS1M5//io/r3nVEhMGONAHRjLDw5BD6VgG3HPpETWPzlQKTs/RP8
         7jlbKzNZOefNHFtIGQlrll61Hvg/GixTcyG7HmUPv4bvRMyX/iNvvKbiIhKGyiWYypnZ
         tcY0x1NJbY55F68fOedD0SEsvpOKBXQql42PWp4VJfJMbaQ3rsmPkwSaKUclSJjQasWE
         ic/g==
X-Forwarded-Encrypted: i=1; AJvYcCWW4tO2hYoJmuMGn8JQT8n7L5RvX4wLa1gzHP8FbMEMzpUtK/59kuH3TebFrmzBYQHNi5k=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWE4UvQHEgZc7ifgo4S5ID7LciVrgeeW8amo6lCYCeYzAY7wKh
	H7gqmRTGRg37flh9UmYACZPJ0msV/80ygvqCLRLw1RGPNVA1DF71yk0V
X-Gm-Gg: AeBDietjg/rqUopF0sxwCLGaFwJ1VqvzywydLrK4pb34tFjwfP7LN5yqLYZ70o0yfVs
	ZuhgOZBT5vfDq2velXjIxFXGHtwFnNb1tgsb/yZQaCM1goClHD+XXoAVLBajKQvkQuW6hqUs/mR
	CjRncgmwGzD75PdRL647d6lHzXxl2/UJ8HW1eyd+A7sxsjznjWpwYY7GM3ETBcXsyK/M57i09qB
	yVbeOXuJawoX43yHHgtCpqLrpWXceBGGuF8KHm2fokCoLHT4ghJCo4u5nKZV9wjhUj4IloHlkMr
	AZT7rr4RiWwL3WqTvrrIVrSbRuBi04X+j94h94yMY4wyNW/SA4OOpVaha0uSpmevvpAJW3drdQn
	8TTt5dN84E/CiwOGL+fpL9h5D8Qsr+nUTovt+GXHAyU23RN0PeB/ooa2syH1aKFWN7v4sGInMri
	vFLYMB72ZMrEfzkxjCmeDsOf/mKGbWwYxRBNQnfdhSnozWsZ6aZGI84k0UpMGDXNoSOEIpCe0Ju
	FFdi0kJ6uBrYQ4zFWvpBw==
X-Received: by 2002:a05:600c:a110:b0:488:966f:70a7 with SMTP id 5b1f17b1804b1-488ccf8cffemr49982195e9.2.1775752463819;
        Thu, 09 Apr 2026 09:34:23 -0700 (PDT)
Received: from ?IPV6:2a02:8109:a307:d900:a778:a387:b2af:188b? ([2a02:8109:a307:d900:a778:a387:b2af:188b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d63de2a69sm49233f8f.4.2026.04.09.09.34.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Apr 2026 09:34:23 -0700 (PDT)
Message-ID: <8b2cf5ca-182e-4eb2-ab90-8fab9d81f6e1@gmail.com>
Date: Thu, 9 Apr 2026 17:34:19 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Subject: Re: [PATCH bpf v2 2/2] bpf: Avoid faultable build ID reads under mm
 locks
To: Ihor Solodrai <ihor.solodrai@linux.dev>,
 Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Song Liu <song@kernel.org>
Cc: Puranjay Mohan <puranjay@kernel.org>,
 Shakeel Butt <shakeel.butt@linux.dev>, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel-team@meta.com
References: <20260409010604.1439087-1-ihor.solodrai@linux.dev>
 <20260409010604.1439087-3-ihor.solodrai@linux.dev>
Content-Language: en-US
In-Reply-To: <20260409010604.1439087-3-ihor.solodrai@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 4/9/26 2:06 AM, Ihor Solodrai wrote:
> Sleepable build ID parsing can block in __kernel_read() [1], so the
> stackmap sleepable path must not call it while holding mmap_lock or a
> per-VMA read lock.
> 
> The issue and the fix are conceptually similar to a recent procfs
> patch [2].
> 
> Resolve each covered VMA with a stable read-side reference, preferring
> lock_vma_under_rcu() and falling back to mmap_read_lock() only long
meganit: falling back to mmap_read_trylock()?
> enough to acquire the VMA read lock. Take a reference to the backing
> file, drop the VMA lock, and then parse the build ID through
> (sleepable) build_id_parse_file().
> 
> [1]: https://lore.kernel.org/all/20251218005818.614819-1-shakeel.butt@linux.dev/
> [2]: https://lore.kernel.org/all/20260128183232.2854138-1-andrii@kernel.org/
> 
> Fixes: 777a8560fd29 ("lib/buildid: use __kernel_read() for sleepable context")
> Assisted-by: Codex:gpt-5.4
> Suggested-by: Puranjay Mohan <puranjay@kernel.org>
> Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
> ---
>   kernel/bpf/stackmap.c | 139 ++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 139 insertions(+)
> 
> diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
> index 4ef0fd06cea5..de3d89e20a1e 100644
> --- a/kernel/bpf/stackmap.c
> +++ b/kernel/bpf/stackmap.c
> @@ -9,6 +9,7 @@
>   #include <linux/perf_event.h>
>   #include <linux/btf_ids.h>
>   #include <linux/buildid.h>
> +#include <linux/mmap_lock.h>
>   #include "percpu_freelist.h"
>   #include "mmap_unlock_work.h"
>   
> @@ -158,6 +159,139 @@ static inline void stack_map_build_id_set_ip(struct bpf_stack_build_id *id)
>   	memset(id->build_id, 0, BUILD_ID_SIZE_MAX);
>   }
>   
> +enum stack_map_vma_lock_state {
> +	STACK_MAP_LOCKED_NONE = 0,
> +	STACK_MAP_LOCKED_VMA,
> +	STACK_MAP_LOCKED_MMAP,
> +};
> +
> +struct stack_map_vma_lock {
> +	enum stack_map_vma_lock_state state;
> +	struct vm_area_struct *vma;
> +	struct mm_struct *mm;
> +};
> +
> +static struct vm_area_struct *stack_map_lock_vma(struct stack_map_vma_lock *lock, unsigned long ip)
> +{
> +	struct mm_struct *mm = lock->mm;
> +	struct vm_area_struct *vma;
> +
> +	if (WARN_ON_ONCE(!mm))
> +		return NULL;
> +
> +	vma = lock_vma_under_rcu(mm, ip);
> +	if (vma)
> +		goto vma_locked;
> +
> +	if (!mmap_read_trylock(mm))
> +		return NULL;
> +
> +	vma = vma_lookup(mm, ip);
> +	if (!vma) {
> +		mmap_read_unlock(mm);
> +		return NULL;
> +	}
> +
> +#ifdef CONFIG_PER_VMA_LOCK
> +	if (!vma_start_read_locked(vma)) {
> +		mmap_read_unlock(mm);
> +		return NULL;
> +	}
> +	mmap_read_unlock(mm);
> +#else
> +	lock->state = STACK_MAP_LOCKED_MMAP;
> +	lock->vma = vma;
> +	return vma;
> +#endif
> +
> +vma_locked:
> +	lock->state = STACK_MAP_LOCKED_VMA;
> +	lock->vma = vma;
> +	return vma;
> +}
> +
> +static void stack_map_unlock_vma(struct stack_map_vma_lock *lock)
> +{
> +	struct vm_area_struct *vma = lock->vma;
> +	struct mm_struct *mm = lock->mm;
> +
> +	switch (lock->state) {
> +	case STACK_MAP_LOCKED_VMA:
> +		if (WARN_ON_ONCE(!vma))
> +			break;
> +		vma_end_read(vma);
> +		break;
> +	case STACK_MAP_LOCKED_MMAP:
> +		if (WARN_ON_ONCE(!mm))
> +			break;
> +		mmap_read_unlock(mm);
> +		break;
> +	default:
> +		break;
> +	}
> +
> +	lock->state = STACK_MAP_LOCKED_NONE;
> +	lock->vma = NULL;
> +}
> +
> +static void stack_map_get_build_id_offset_sleepable(struct bpf_stack_build_id *id_offs,
> +						    u32 trace_nr)
> +{
> +	struct mm_struct *mm = current->mm;
> +	struct stack_map_vma_lock lock = {
> +		.state = STACK_MAP_LOCKED_NONE,
> +		.vma = NULL,
> +		.mm = mm,
> +	};
> +	struct file *file, *prev_file = NULL;
> +	unsigned long vm_pgoff, vm_start;
> +	struct vm_area_struct *vma;
> +	const char *prev_build_id;
> +	u64 ip;
> +
> +	for (u32 i = 0; i < trace_nr; i++) {
> +		ip = READ_ONCE(id_offs[i].ip);

I'm not sure if I understand why READ_ONCE is necessary here.

> +		vma = stack_map_lock_vma(&lock, ip);
> +		if (!vma || !vma->vm_file) {
> +			stack_map_build_id_set_ip(&id_offs[i]);
> +			stack_map_unlock_vma(&lock);
> +			continue;
> +		}
> +
> +		file = vma->vm_file;
> +		vm_pgoff = vma->vm_pgoff;
> +		vm_start = vma->vm_start;
> +
> +		if (file == prev_file) {

What if instead of caching prev_file, we cache vm_start and vm_end, and 
if the next IP is in range, reuse previous build id. This should 
optimize this code further, avoiding locks on the vma used on previous 
iteration.

> +			memcpy(id_offs[i].build_id, prev_build_id, BUILD_ID_SIZE_MAX);
> +			stack_map_unlock_vma(&lock);
> +			goto build_id_valid;
> +		}
> +
> +		file = get_file(file);
> +		stack_map_unlock_vma(&lock);
> +
> +		/* build_id_parse_file() may block on filesystem reads */
> +		if (build_id_parse_file(file, id_offs[i].build_id, NULL)) {
> +			stack_map_build_id_set_ip(&id_offs[i]);
> +			fput(file);
> +			continue;
> +		}
> +
> +		if (prev_file)
> +			fput(prev_file);
> +		prev_file = file;
> +		prev_build_id = id_offs[i].build_id;
> +
> +build_id_valid:
> +		id_offs[i].offset = (vm_pgoff << PAGE_SHIFT) + ip - vm_start;
> +		id_offs[i].status = BPF_STACK_BUILD_ID_VALID;
> +	}
> +
> +	if (prev_file)
> +		fput(prev_file);
> +}
> +
>   /*
>    * Expects all id_offs[i].ip values to be set to correct initial IPs.
>    * They will be subsequently:
> @@ -178,6 +312,11 @@ static void stack_map_get_build_id_offset(struct bpf_stack_build_id *id_offs,
>   	const char *prev_build_id;
>   	int i;
>   
> +	if (may_fault && has_user_ctx) {
> +		stack_map_get_build_id_offset_sleepable(id_offs, trace_nr);
> +		return;
> +	}
> +
>   	/* If the irq_work is in use, fall back to report ips. Same
>   	 * fallback is used for kernel stack (!user) on a stackmap with
>   	 * build_id.

