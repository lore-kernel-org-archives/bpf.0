Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFE753E5A0D
	for <bpf@vger.kernel.org>; Thu, 14 May 2026 14:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778770735; cv=none; b=qyfewP9oNdk/0c5ACJl/Aod5oTaWpJ/Zi7xrYuNaxlua12qOTm8ea65+mnsrZEig4O/vNEUm3bNRPnhaSaLZmQv11OTfXCsU59wZ9JA6d7H6UFUcK5/1wsV8kw0IEkKO8gh2Xoy6HrPmb9xcvHme8ZkfJ4T1jY/E0jdodQThsC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778770735; c=relaxed/simple;
	bh=8ZC3+79Yxue6fFpKj0KpJNbK0AxVS1cBMVtnilmCAYc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R9FSgqvqfWCrfNdycwg2iaedPovxUUxHWXrikJ5d0vt5jbYTX8yPOmeKtnIljs6WCB1QW8w8knDLt2b40zbbPolFCvdQsz/Ef0ilaDXvdFlf9UtAwSijOcRiZANaAdzCaH8EQFRRv0/XVaeRExjbubVssEj6F1QGyeF9Yj6i+Z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L/teZnwy; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L/teZnwy"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-488a88aeec9so90042005e9.2
        for <bpf@vger.kernel.org>; Thu, 14 May 2026 07:58:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778770732; x=1779375532; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ezlw2RI0fogBg6DmCkNoJAM/12GP1CD5Qxxk2BsDjnY=;
        b=L/teZnwy2+AcYmpCKRa2WC4/Ebt0jcM0myKjQ8Pko/Y8BCpx+jglvcfdnRYeZEhHde
         1qd/kA0Elc8E05xGxGFPMKrhC4kFSlNh2i+kwjnHNF5Wf19aIH1UImOvwAwF+3sbsD2J
         2DD3QE0GG0O5bU4hAsSTzVPOVJ+h3Eszkgt5r2sbafHw7POceGdKbb6yiVg13BAjqwHB
         f5D62Iahl0x4umnVivBHPWUZHbWhKr7o9uTWA8Yw84N/OuFbe3kB1p2Y4p0S6+JjdqkO
         qeZq20P6DWpL+Csi/WZpfZC5mVj/ot00IZaHUvsy60bJVOuwz2GDEHQ8P4ujs2ByUFlD
         sETA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778770732; x=1779375532;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ezlw2RI0fogBg6DmCkNoJAM/12GP1CD5Qxxk2BsDjnY=;
        b=Yatk6Ux+ibBX6tXPrsdqB5YifOtuC5vgs59HC5KYHkcRJJiaabIU9vYkNNPz1sZK2S
         65uvxVIQ38lhiIJuRUKQ5zQ3KI7UEh71fBG+eqryCQI6NMbEXNAwTwzEK90xFvkwaicH
         Hlr2hGp4RAMoOlCj9azQnvJ3fBLm7phN5Sk7uLlyA9ILPsyjJ5+T4NPCoIop34Al4LuP
         svSaAj45SghQjU74gJ/UCpTQO2UFTtAhEzDDxMhWw+YF8FCjJQRzaEW0lEmWBSEF0pq7
         w7bWJs5KV/mLFD4fDqxUw+Cr9yypBrneJ4I4VkEFVBE/X+HcLG9Ysa8uCGNTl2up4uot
         MQgA==
X-Forwarded-Encrypted: i=1; AFNElJ8oK8k5A6qX5OexL/y9MWdPj04N73SR63frhsrt1n/rFFa2QgCYJzjezE/rJpjCYrdvxb0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw51LuHByN9aQGNWpyuLD/THfVeuPH63/xVGJSz7BuIakkfVldD
	uj79gqnOUhVzCfQRXi/7tsa5R2of6Qh8upWp4TAPeJa+F6gNMYJ1UX0H
X-Gm-Gg: Acq92OEiEBS8CneRQjIwlLDWzsTOciZId3XOJ06tc2XdQAjFh3ICYwQperdyQFLhY/R
	w9AiKDVfgp6/+1ui7jp8PccDx8mRMk+iNiuQM4rA3P0ib7N66zVHFZJOdpuQ5L2tGJMqAraYtiA
	5abTFbRV3dDKOrF2OWUr/+zPCXVsRglbSHWBooB/ilTKBR5Vud+SY4OKfwM5IicV6x99DSloyT8
	+oHMiV8ezzlLYfnjvZPW0PI6NV3zr5cVKwDIAq+Sr7/th6uifJ+Lx6KhrQa4ABpuejPJ5LZ1bwz
	cN8e/BwNWFSNSEfEw3R41Bvpo5fACUMYdON5WaJb/qUAePUg92EcCVuasutI6TtYv1MwUxbKqeX
	X2CNI9LWhkx89/C/6ttRWeS3TV5sIh1OFDaedEfBkWT/2LkPmpk+l1nZ3jXVqLH8qdgDD43536w
	C8gzLakGuoo3Zv7kU6fA0ebnKGfq0qxLlMjH89Z1BFOwe7ItIWQdvYf/eTKzNsZ4cBLrqej3TIg
	kkwAEffQQ==
X-Received: by 2002:a05:600c:3b20:b0:489:5022:39a4 with SMTP id 5b1f17b1804b1-48fc9a0cb7cmr121507175e9.9.1778770732031;
        Thu, 14 May 2026 07:58:52 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1126:4:9cef:93b1:6db4:786b? ([2620:10d:c092:500::4:5c83])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45d9ec3b18fsm6906090f8f.11.2026.05.14.07.58.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 May 2026 07:58:51 -0700 (PDT)
Message-ID: <6b4e0918-79a5-49ae-a172-c7d6df558dec@gmail.com>
Date: Thu, 14 May 2026 15:58:49 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf v3 3/3] bpf: Cache build IDs in sleepable stackmap
 path
To: Ihor Solodrai <ihor.solodrai@linux.dev>,
 Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Eduard Zingerman
 <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Puranjay Mohan <puranjay@kernel.org>,
 Shakeel Butt <shakeel.butt@linux.dev>, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel-team@meta.com
References: <20260512032906.2670326-1-ihor.solodrai@linux.dev>
 <20260512032906.2670326-4-ihor.solodrai@linux.dev>
Content-Language: en-US
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
In-Reply-To: <20260512032906.2670326-4-ihor.solodrai@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 5/12/26 4:29 AM, Ihor Solodrai wrote:
> Stack traces often contain adjacent IPs from the same VMA or from
> different VMAs backed by the same ELF file. Cache the last successfully
> parsed build ID together with the resolved VMA range and backing file
> so the sleepable build-ID path can avoid repeated VMA locking and file
> parsing in common cases.
> 
> Suggested-by: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
> Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
> ---
>  kernel/bpf/stackmap.c | 51 ++++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 48 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
> index c1e96df360c3..318ce9ed0dd5 100644
> --- a/kernel/bpf/stackmap.c
> +++ b/kernel/bpf/stackmap.c
> @@ -226,13 +226,34 @@ static void stack_map_get_build_id_offset_sleepable(struct bpf_stack_build_id *i
>  		.vma = NULL,
>  		.mm = mm,
>  	};
> -	unsigned long vm_pgoff, vm_start;
> +	struct {
> +		struct file *file;
> +		const char *build_id;
> +		unsigned long vm_start;
> +		unsigned long vm_end;
> +		unsigned long vm_pgoff;
> +	} cache = {};
> +	unsigned long vm_pgoff, vm_start, vm_end;
>  	struct vm_area_struct *vma;
>  	struct file *file;
>  	u64 ip;
>  
>  	for (u32 i = 0; i < trace_nr; i++) {
>  		ip = READ_ONCE(id_offs[i].ip);
> +
> +		/*
> +		 * Range cache fast path: if ip falls within the previously
> +		 * resolved VMA range, reuse the cache build_id without
> +		 * re-acquiring the VMA lock.
> +		 */
> +		if (cache.build_id && ip >= cache.vm_start && ip < cache.vm_end) {
> +			memcpy(id_offs[i].build_id, cache.build_id, BUILD_ID_SIZE_MAX);
> +			vm_start = cache.vm_start;
> +			vm_end = cache.vm_end;
> +			vm_pgoff = cache.vm_pgoff;
> +			goto build_id_valid;
> +		}
> +
>  		vma = stack_map_lock_vma(&lock, ip);
>  		if (!vma || !vma->vm_file) {
>  			stack_map_build_id_set_ip(&id_offs[i]);
> @@ -240,9 +261,22 @@ static void stack_map_get_build_id_offset_sleepable(struct bpf_stack_build_id *i
>  			continue;
>  		}
>  
> -		file = get_file(vma->vm_file);
> +		file = vma->vm_file;
>  		vm_pgoff = vma->vm_pgoff;
>  		vm_start = vma->vm_start;
> +		vm_end = vma->vm_end;
> +
> +		if (file == cache.file) {
> +			/*
> +			 * Same backing file as previous (e.g. different VMAs
> +			 * of the same ELF binary). Reuse the cache build_id.
> +			 */
> +			memcpy(id_offs[i].build_id, cache.build_id, BUILD_ID_SIZE_MAX);
> +			stack_map_unlock_vma(&lock);
> +			goto build_id_valid;
> +		}
> +
> +		file = get_file(file);
>  		stack_map_unlock_vma(&lock);
>  
>  		/* build_id_parse_file() may block on filesystem reads */
> @@ -251,11 +285,22 @@ static void stack_map_get_build_id_offset_sleepable(struct bpf_stack_build_id *i
>  			fput(file);
>  			continue;
>  		}
> -		fput(file);
>  
> +		if (cache.file)
> +			fput(cache.file);
> +		cache.file = file;
> +		cache.build_id = id_offs[i].build_id;
> +
> +build_id_valid:
> +		cache.vm_start = vm_start;
> +		cache.vm_end = vm_end;
> +		cache.vm_pgoff = vm_pgoff;

nit: Maybe we can also put 
if (cache.build_id != id_offs[i])
	memcpy(id_offs[i].build_id, cache.build_id, BUILD_ID_SIZE_MAX); 
here? So all writes to the id_offs[i] are at the same place for clearer structure?

Overall it looks correct. Did you try to run it to see if we hit this cache at all?
Acked-by: Mykyta Yatsenko <yatsenko@meta.com>

>  		id_offs[i].offset = (vm_pgoff << PAGE_SHIFT) + ip - vm_start;
>  		id_offs[i].status = BPF_STACK_BUILD_ID_VALID;
>  	}
> +
> +	if (cache.file)
> +		fput(cache.file);
>  }
>  
>  /*

