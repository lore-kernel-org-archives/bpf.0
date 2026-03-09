Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB79D3E715E
	for <bpf@vger.kernel.org>; Mon,  9 Mar 2026 17:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773076297; cv=none; b=OE5BizvCCdT0S08BieT042mawTBaCYQ03Vi8HkFQCroccGPljcsjN1X5zEM2Y5nJFhRc0nTF14yR3T8qxIzWep7B5rZQGUeSN5mllVQgoydAq1JDDDWVLdt0V6PqDNjAnP/NxDqdy+Fz6NnEV5+x0894kYljC0amKIOqyBASrUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773076297; c=relaxed/simple;
	bh=f0huRW/o2Yl+yhhX2oDpx8yBIJNOIVW8OYRf2bSpmTQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=roCDZBuvToc2NUNZvU+kW/XWUc7g2qfXMruMrD3e14H6rbLPDcaj2fr0vdWtFzs2HguJ9Zy9DCwjJFZeVcNDwp6ROfjTPTi++rGbHCSYEA7zQVUFmt+M74L9sBd3WFiC4dnxJ2ScP2Mmpix1EuoMw0d8SYE3nbDoEb+uaU/z2HA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PMr1F0MJ; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PMr1F0MJ"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4853c3c2fe7so7406625e9.0
        for <bpf@vger.kernel.org>; Mon, 09 Mar 2026 10:11:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773076294; x=1773681094; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZcooeCahgh7uL6j47FMIpmrETXsGHHNp545RD8LqrL0=;
        b=PMr1F0MJ3pMHNez/lmqsMngQZotWN1BJwqhQnVeocsPFua8Vkb2xoFpGxng4mDKIS7
         Xok/R39brvqcYuqZ+3DytAYCZryKQXQkh0lGcuoNOlDw6tspVTuhVS7Ldl4yteYxCcNR
         SPdFoBDD/9yojJK5cjcQfnPR2aKbCfsjwYE7LhqWseH4jhY86VThjlNfrELgn85uwR4n
         mNFZio8lw9ZtmJHgvCHo+Yeqpj02yuNQ8zi5+Y3gUcqm9i7p1u8J1v2fTLhBQNwPqlCr
         X385/J86sKAci+TxDR3LozVOdYRgPomG0EQhhWffYmtLhlaL6SGo5qkh7tT2Out/t9QA
         Cd+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773076294; x=1773681094;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZcooeCahgh7uL6j47FMIpmrETXsGHHNp545RD8LqrL0=;
        b=iUckG6kM1cVPMHj29y9NYpfwUSp8Gol/0VRLPbvzk/stAlaLLMJnfJziI2HyP6W+F9
         DC8+KyHulY6UjIR2xQ1OUuvWkrPxgB56P2zBxe+IknYb70vnHsZbY41xtqgkfSoYVoMT
         LLsLGcLjrTZt6ycamRI2CSaI4JnEj1bpXo6A31ZXrPBKFepAKuC+rLiIZBiEfbbzWzjE
         GyoaJHfK/Nr7SeNStf8DwhRccQv1lzAqmXwwT1Q/Q3iiwjttleikWKBj52D2+OBcgUyD
         M/W8WB0jbc/tUNf2PAnQdezqTX4fXI+PFH8SUohXgOtytB5wyECNIAO6NKw1sP/ogwF4
         KvXg==
X-Forwarded-Encrypted: i=1; AJvYcCVh5EpF8tNv7zElBQTZ4Jw8avFlJggBrlL35KwVQMj6KrorsKvkZ3dFZuQSOVJM/pYuS7o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6W41h8mOPRanJQlK/1FGMMgjAE/+5Rf+4Dqsp8J84r3pulQhI
	VGvIQqOwyx8pf+VKoNuM0cucacOK66facHASM74G55vdNaYRkBTojprx
X-Gm-Gg: ATEYQzzttNsRfCao7qmJ29+Rx0trLGbIKu+hDKUYvTddFSX/bDj8Z8drQY9fVMqtBLo
	KJ0zDMtiXLqJJXFqRyBUoRsONrdu9IGw6NISI2aWez6VuUiU3pXJtHEFQqs7/5HCn0TL/ar1R4l
	M1xF/i7HxKQaIqIb2Lt7v4WvzNGKaXf7oFA6+WbuQgeqMrKJeo3wuWL9rr4qUdxmSVNXddO5H8i
	Z6v3XRxRBfOPQpD2CwsXhzVa6VqjRwGXJKSVEp7i1aCoEW0SAUepLGx1uT1f3Kb+MZvNAfgQp93
	FvapC8FR4aIrSoHkcT9oXLnn7Azzj1iuG2lnEdTdDN+DVYYeZcCv2GoriydKYrYsQEWxXAyz+71
	zoZXHdB2mEno3FatAS/gvRiRFymqNGyq/gnYGjacZzkLdCeZ98tBw01MaB5DuJXGG3woqyaFUZv
	XfT0/4p9abCOtAPjeHXQ==
X-Received: by 2002:a05:600c:3b13:b0:47f:f952:d207 with SMTP id 5b1f17b1804b1-48526969359mr228870095e9.19.1773076293829;
        Mon, 09 Mar 2026 10:11:33 -0700 (PDT)
Received: from localhost ([2620:10d:c092:400::5:f6fb])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4852470c697sm90230555e9.31.2026.03.09.10.11.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 10:11:33 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
To: Puranjay Mohan <puranjay@kernel.org>, bpf@vger.kernel.org
Cc: Puranjay Mohan <puranjay@kernel.org>, Puranjay Mohan
 <puranjay12@gmail.com>, Alexei Starovoitov <ast@kernel.org>, Andrii
 Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau <martin.lau@kernel.org>, Eduard Zingerman
 <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 kernel-team@meta.com
Subject: Re: [PATCH bpf v2 4/4] bpf: return VMA snapshot from task_vma iterator
In-Reply-To: <20260309155506.23490-5-puranjay@kernel.org>
References: <20260309155506.23490-1-puranjay@kernel.org>
 <20260309155506.23490-5-puranjay@kernel.org>
Date: Mon, 09 Mar 2026 17:11:32 +0000
Message-ID: <87fr69lygr.fsf@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Puranjay Mohan <puranjay@kernel.org> writes:

> Holding the per-VMA lock across the BPF program body creates a lock
> ordering problem when helpers acquire locks that depend on mmap_lock:
>
>   vm_lock -> i_rwsem -> mmap_lock -> vm_lock
>
> Snapshot VMA fields under the per-VMA lock in _next(), then drop the
> lock before returning. The BPF program accesses only the snapshot.
>
> Copy vm_start, vm_end, vm_flags, vm_pgoff, vm_page_prot, vm_file, and
> vm_mm. vm_file is reference-counted with get_file() under the lock and
> released via fput() on the next iteration or in _destroy(). vm_mm uses
> the mm pointer already held via mmget().
>
> Fixes: 4ac454682158 ("bpf: Introduce task_vma open-coded iterator kfuncs")
> Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
> ---
>  kernel/bpf/task_iter.c | 34 ++++++++++++++++++++++------------
>  1 file changed, 22 insertions(+), 12 deletions(-)
>
> diff --git a/kernel/bpf/task_iter.c b/kernel/bpf/task_iter.c
> index e20c85e06afa..f04d6e310fd3 100644
> --- a/kernel/bpf/task_iter.c
> +++ b/kernel/bpf/task_iter.c
> @@ -799,7 +799,7 @@ const struct bpf_func_proto bpf_find_vma_proto = {
>  struct bpf_iter_task_vma_kern_data {
>  	struct task_struct *task;
>  	struct mm_struct *mm;
> -	struct vm_area_struct *locked_vma;
> +	struct vm_area_struct snapshot;
>  	u64 last_addr;
>  };
>  
> @@ -895,8 +895,8 @@ __bpf_kfunc int bpf_iter_task_vma_new(struct bpf_iter_task_vma *it,
>  		goto err_cleanup_iter;
>  	}
>  
> -	kit->data->locked_vma = NULL;
>  	kit->data->last_addr = addr;
> +	memset(&kit->data->snapshot, 0, sizeof(kit->data->snapshot));
>  	return 0;
>  
>  err_cleanup_iter:
> @@ -954,23 +954,33 @@ bpf_iter_task_vma_find_next(struct bpf_iter_task_vma_kern_data *data)
>  __bpf_kfunc struct vm_area_struct *bpf_iter_task_vma_next(struct bpf_iter_task_vma *it)
>  {
>  	struct bpf_iter_task_vma_kern *kit = (void *)it;
> -	struct vm_area_struct *vma;
> +	struct vm_area_struct *snap, *vma;
>  
>  	if (!kit->data) /* bpf_iter_task_vma_new failed */
>  		return NULL;
>  
> -	if (kit->data->locked_vma)
> -		vma_end_read(kit->data->locked_vma);
> +	snap = &kit->data->snapshot;
> +
> +	if (snap->vm_file) {
> +		fput(snap->vm_file);
> +		snap->vm_file = NULL;
> +	}
>  
>  	vma = bpf_iter_task_vma_find_next(kit->data);
> -	if (!vma) {
> -		kit->data->locked_vma = NULL;
> +	if (!vma)
>  		return NULL;
> -	}
>  
> -	kit->data->locked_vma = vma;
> +	snap->vm_start = vma->vm_start;
> +	snap->vm_end = vma->vm_end;
> +	snap->vm_mm = kit->data->mm;
> +	snap->vm_page_prot = vma->vm_page_prot;
> +	snap->flags = vma->flags;
It looks like there a supported way to copy flags: vm_flags_init() here.
> +	snap->vm_pgoff = vma->vm_pgoff;
> +	snap->vm_file = vma->vm_file ? get_file(vma->vm_file) : NULL;
> +
>  	kit->data->last_addr = vma->vm_end;
> -	return vma;
> +	vma_end_read(vma);
> +	return snap;
>  }
>  
>  __bpf_kfunc void bpf_iter_task_vma_destroy(struct bpf_iter_task_vma *it)
> @@ -978,8 +988,8 @@ __bpf_kfunc void bpf_iter_task_vma_destroy(struct bpf_iter_task_vma *it)
>  	struct bpf_iter_task_vma_kern *kit = (void *)it;
>  
>  	if (kit->data) {
> -		if (kit->data->locked_vma)
> -			vma_end_read(kit->data->locked_vma);
> +		if (kit->data->snapshot.vm_file)
> +			fput(kit->data->snapshot.vm_file);
>  		bpf_iter_mmput(kit->data->mm);
>  		put_task_struct(kit->data->task);
>  		bpf_mem_free(&bpf_global_ma, kit->data);
> -- 
> 2.47.3
