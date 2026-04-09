Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AEB8287510
	for <bpf@vger.kernel.org>; Thu,  9 Apr 2026 13:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775740518; cv=none; b=QzIDxw+glMorVf0DI7Yh2BR4c7Lqhk8rp38vaBy4nZ5VilRHDzB0yMejcbZMqQ/Yo/t7dvFt5Luunx+aAGYDuThuH2JKNSTv+hUPhOgNJGOP3fXtl2BXdGmcqgZ2yRo3hAoMzjY4tHc0TSlpYc/tijw2gIzoHJhPx4+LLYIVBzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775740518; c=relaxed/simple;
	bh=F4fu+I+hRLJ6URGwbdPUisqeGvdU+OF0nt23JxKHX2k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oTCUW37iTVG1p108CAzzTvgvtsjd680HVr3M/Db/f1BHYx/P36ze9A/lEw9TUvZpt9gqI3KkBNjRmd3T3qBOy5ODB0fvBdktAukQDf7ACtTletEc8kBI83kFU/QScrC/M56zWE/nfqA4+jabs8nBeN7HNJAqUAtC9sSRO/qVa/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V0vYm6KQ; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V0vYm6KQ"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-488d2079582so5194985e9.2
        for <bpf@vger.kernel.org>; Thu, 09 Apr 2026 06:15:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775740513; x=1776345313; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EoCkZtW9G4UfWdiopt7U3VG4v4IwPUlRb2/onfAwCJg=;
        b=V0vYm6KQC4mY/oq+BQ2YbETsEoww/8IeU74YPPemKVQzb+CPRofBC+F0sosGwY82FR
         HHH5CM8HSUJlhEIXeviNK8lXmsR9CO8BSUbTCDS9tYFe/xz9oGLKnMhk0oquHhCl52Kn
         yyZBzJKaMFqLxQPfVjikQhXmV2QdDZrg9W7SJ240SEHNQoryHWmEdFeoHAHeggaQNvKY
         LGOzJXfA7eTjGcm7ZoY8gZwwavRuC1k0FUBAmTv1DE1+Mv2ds1D55Mp35R7TK2om+9O3
         DKFQSKCoMT6YFSvPMWQ74HyWNEzi2IPhNIA4E4Hh8hyaQYAGL5h9r4C9iWn/70Vx9HmR
         MAiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775740513; x=1776345313;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EoCkZtW9G4UfWdiopt7U3VG4v4IwPUlRb2/onfAwCJg=;
        b=VoJyQkHK515Tps2LM0hrqAqv3Kmhi5lAbrJypJMSGxe60TAy7RKJHxEyZQU+uj+3Sf
         2Dd5645Loqsl2aLHGxD9JA5EnaErpkjyPcScWc80Dfl9h2+fZU9gT223UPWbAew9IMdX
         Ooy8hI9IcXwPzcOaCcOKnxrSwk3+fwBJXctUdMmn+A14iHwb1yh+LSutER3ySwzj73KT
         kEJs/4fCtPG/k0uANRhUdAzm74trFxSD5Mg4rvvaVsXE101yH30Ul3mHHZq9z9QAXdb0
         9IZUxXV/bMDp+B8/I9qOPxz0N7upnV4cF5CrZGChPzjNGoS8B8OW6T8fzh1T3z8GQ0Q5
         iA3A==
X-Forwarded-Encrypted: i=1; AJvYcCUpENgxfEX0LSWP+XmOe4Xq2K0f4hpIC/pR1KLAGkosQn0oPpqnkxXmTcxtB/4Uy8kYhow=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7woroMJW5gyL4ZYfw5Mw1Nsg7HSB1Zx7WcVaxq8+1YuTWp7No
	qI+dm7dYAS+yUDVTBcd1ODcN6KlFBlK/N01gmKGGqeoOgUQcpcMAHYAj
X-Gm-Gg: AeBDieu0nGHweFVHfxpJiz1Hz8v6GPp4MlNOpwEXyfy15ScCZXNV6CtOyMv/Q5rrKKV
	9ivmCfIWZfFF3WvCZ/yO2hEof8F/hIos/ygMRLmb1qb7EdSdoC0/B8teickvI+BY53r0lx1l9ZZ
	Vw5jf/xFHYGh4EXruNx0m6K0oB4HKOt9YyzpeVOK2bTx0ZSaJHUX2kd3JpAZcqeRkMGLYCEd7G/
	nIROlN8InDVhAXBvd7Zul/GcCISMLAv1Ean2joTsVLz2nvrKcCm1AXJqKp1CoHiu7BytKsfeb1g
	YlcOsgPAr721NLx7J4FCuN2l2NhkU5nQjYPlrpiVw05OilhV3wEPjogKf9D3IFwjI6MW7RCrrrx
	9Ppj64BRzzbE37tSFm2wTcoll1MzSB9m80Eg4vnbdE1+sIso0C36flkiNamr5RLSwlDq2sNiogg
	BDiZDkbB3TfmA5vBUGTFep6q6mePMy7ZPQSD78+esAEDOtxtUaMj1uQQ9neCGLTGA4x+9YHa4vv
	9K91U8K5gU=
X-Received: by 2002:a05:600c:2d91:b0:488:a2ac:a334 with SMTP id 5b1f17b1804b1-488a2aca406mr165144005e9.3.1775740513149;
        Thu, 09 Apr 2026 06:15:13 -0700 (PDT)
Received: from ?IPV6:2a02:8109:a307:d900:a778:a387:b2af:188b? ([2a02:8109:a307:d900:a778:a387:b2af:188b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488cd10af88sm24178525e9.12.2026.04.09.06.15.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Apr 2026 06:15:12 -0700 (PDT)
Message-ID: <debb9f27-443a-4277-b252-de8efc09697a@gmail.com>
Date: Thu, 9 Apr 2026 14:15:10 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf v6 3/3] bpf: return VMA snapshot from task_vma
 iterator
To: Puranjay Mohan <puranjay@kernel.org>, bpf@vger.kernel.org
Cc: Puranjay Mohan <puranjay12@gmail.com>, Alexei Starovoitov
 <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau <martin.lau@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, kernel-team@meta.com
References: <20260408154539.3832150-1-puranjay@kernel.org>
 <20260408154539.3832150-4-puranjay@kernel.org>
Content-Language: en-US
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
In-Reply-To: <20260408154539.3832150-4-puranjay@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/8/26 4:45 PM, Puranjay Mohan wrote:
> Holding the per-VMA lock across the BPF program body creates a lock
> ordering problem when helpers acquire locks that depend on mmap_lock:
> 
>    vm_lock -> i_rwsem -> mmap_lock -> vm_lock
> 
> Snapshot the VMA under the per-VMA lock in _next() via memcpy(), then
> drop the lock before returning. The BPF program accesses only the
> snapshot.
> 
> The verifier only trusts vm_mm and vm_file pointers (see
> BTF_TYPE_SAFE_TRUSTED_OR_NULL in verifier.c). vm_file is reference-
> counted with get_file() under the lock and released via fput() on the
> next iteration or in _destroy(). vm_mm is already correct because
> lock_vma_under_rcu() verifies vma->vm_mm == mm. All other pointers
> are left as-is by memcpy() since the verifier treats them as untrusted.
> 
> Fixes: 4ac454682158 ("bpf: Introduce task_vma open-coded iterator kfuncs")
> Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
> Acked-by: Andrii Nakryiko <andrii@kernel.org>
> ---
Acked-by: Mykyta Yatsenko <yatsenko@meta.com>
>   kernel/bpf/task_iter.c | 42 ++++++++++++++++++++++++++++++------------
>   1 file changed, 30 insertions(+), 12 deletions(-)
> 
> diff --git a/kernel/bpf/task_iter.c b/kernel/bpf/task_iter.c
> index 87e87f18913d..e791ae065c39 100644
> --- a/kernel/bpf/task_iter.c
> +++ b/kernel/bpf/task_iter.c
> @@ -808,7 +808,7 @@ static inline void bpf_iter_mmput_async(struct mm_struct *mm)
>   struct bpf_iter_task_vma_kern_data {
>   	struct task_struct *task;
>   	struct mm_struct *mm;
> -	struct vm_area_struct *locked_vma;
> +	struct vm_area_struct snapshot;
>   	u64 next_addr;
>   };
>   
> @@ -842,7 +842,7 @@ __bpf_kfunc int bpf_iter_task_vma_new(struct bpf_iter_task_vma *it,
>   
>   	/*
>   	 * Reject irqs-disabled contexts including NMI. Operations used
> -	 * by _next() and _destroy() (vma_end_read, bpf_iter_mmput_async)
> +	 * by _next() and _destroy() (vma_end_read, fput, bpf_iter_mmput_async)
>   	 * can take spinlocks with IRQs disabled (pi_lock, pool->lock).
>   	 * Running from NMI or from a tracepoint that fires with those
>   	 * locks held could deadlock.
> @@ -885,7 +885,7 @@ __bpf_kfunc int bpf_iter_task_vma_new(struct bpf_iter_task_vma *it,
>   		goto err_cleanup_iter;
>   	}
>   
> -	kit->data->locked_vma = NULL;
> +	kit->data->snapshot.vm_file = NULL;
>   	kit->data->next_addr = addr;
>   	return 0;
>   
> @@ -947,26 +947,45 @@ bpf_iter_task_vma_find_next(struct bpf_iter_task_vma_kern_data *data)
>   	return vma;
>   }
>   
> +static void bpf_iter_task_vma_snapshot_reset(struct vm_area_struct *snap)
> +{
> +	if (snap->vm_file) {
> +		fput(snap->vm_file);
> +		snap->vm_file = NULL;
> +	}
> +}
> +
>   __bpf_kfunc struct vm_area_struct *bpf_iter_task_vma_next(struct bpf_iter_task_vma *it)
>   {
>   	struct bpf_iter_task_vma_kern *kit = (void *)it;
> -	struct vm_area_struct *vma;
> +	struct vm_area_struct *snap, *vma;
>   
>   	if (!kit->data) /* bpf_iter_task_vma_new failed */
>   		return NULL;
>   
> -	if (kit->data->locked_vma) {
> -		vma_end_read(kit->data->locked_vma);
> -		kit->data->locked_vma = NULL;
> -	}
> +	snap = &kit->data->snapshot;
> +
> +	bpf_iter_task_vma_snapshot_reset(snap);
>   
>   	vma = bpf_iter_task_vma_find_next(kit->data);
>   	if (!vma)
>   		return NULL;
>   
> -	kit->data->locked_vma = vma;
> +	memcpy(snap, vma, sizeof(*snap));
> +
> +	/*
> +	 * The verifier only trusts vm_mm and vm_file (see
> +	 * BTF_TYPE_SAFE_TRUSTED_OR_NULL in verifier.c). Take a reference
> +	 * on vm_file; vm_mm is already correct because lock_vma_under_rcu()
> +	 * verifies vma->vm_mm == mm. All other pointers are untrusted by
> +	 * the verifier and left as-is.
> +	 */
> +	if (snap->vm_file)
> +		get_file(snap->vm_file);
> +
>   	kit->data->next_addr = vma->vm_end;
> -	return vma;
> +	vma_end_read(vma);
> +	return snap;
>   }
>   
>   __bpf_kfunc void bpf_iter_task_vma_destroy(struct bpf_iter_task_vma *it)
> @@ -974,8 +993,7 @@ __bpf_kfunc void bpf_iter_task_vma_destroy(struct bpf_iter_task_vma *it)
>   	struct bpf_iter_task_vma_kern *kit = (void *)it;
>   
>   	if (kit->data) {
> -		if (kit->data->locked_vma)
> -			vma_end_read(kit->data->locked_vma);
> +		bpf_iter_task_vma_snapshot_reset(&kit->data->snapshot);
>   		put_task_struct(kit->data->task);
>   		bpf_iter_mmput_async(kit->data->mm);
>   		bpf_mem_free(&bpf_global_ma, kit->data);

