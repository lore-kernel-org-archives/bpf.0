Received: from mta0.migadu.com (out-166.mta0.migadu.com [91.218.175.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2C83260580
	for <bpf@vger.kernel.org>; Mon,  5 Oct 2026 03:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791169850; cv=none; b=TfJm4gcU5wjRTPvZsxsGslHYgO2kcQtnYsLj3ov7SKDH9EQbJROp9TUP8SbQVqXxTEBxgJsRrQ9gYzKOOHakjwfhzaNdEGUQV+kJ+EpUFXA0CH3dvHo6S9UWSE8VrhUAkuDUszqJqahQklbZIzYNDKcj1wCpRGZVUoTiP7+gNjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791169850; c=relaxed/simple;
	bh=X6h7tvpAdrFpkO+odF64DwkjPJ6152t0iAfzxo4AEfo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eM6FySGQA0fa9iwXjz5+O2ZYUry4bodUz1zL64srYdSbqAaGK00lFQlQp1kSKNBXPrJMbblBlw/sZ8jMQgDHEBOaUn+rrkLz6MXFft6tdZYIG+yjyvaGuxynPmN5YX4BOVKALB9SQb3QQ9Th8Wh3IfnpvGzNFrV22Cbri5COSpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ssH4mDS3; arc=none smtp.client-ip=91.218.175.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ssH4mDS3"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=X6h7tvpAdrFpkO+odF64DwkjPJ6152t0iAfzxo4AEfo=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791169845; v=1; x=1791774645;
 b=ssH4mDS3ugiu5GEfdoOMbMKpt7HeCAchijKTwJrQM/5wS4cCy9tB/2Aff+jcFTKIe27jDVcb
 CgtmmBtuRZlfqI+XXWpqMRyFGMXwHscikAVXxUNXLOQjICoS8xUqA4lIaQj2jwBjLLVaNd2Stoq
 724EkjTsCqaSSE5ICSYXZol8=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id a6876dbd3675bb7b;
	Mon, 05 Oct 2026 03:10:22 +0000
X-Mizu-Trace-ID: a6876dbd3675bb7b
X-Migadu-Flow: FLOW_OUT
Message-ID: <7b661c7e-3d01-4361-8d0c-84c97866b404@linux.dev>
Date: Mon, 5 Oct 2026 11:10:18 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf v4 1/3] bpf: Fix incorrect handling of user flags in
 bpf_percpu_array_update
To: Masoud Aghasi <maghasi@disroot.org>, bpf@vger.kernel.org
Cc: andrii@kernel.org, eddyz87@gmail.com, ast@kernel.org,
 daniel@iogearbox.net, memxor@gmail.com, martin.lau@linux.dev,
 song@kernel.org, yonghong.song@linux.dev, jolsa@kernel.org,
 emil@etsalapatis.com, ihor.solodrai@linux.dev
References: <20261004111007.3216186-1-maghasi@disroot.org>
 <20261004111007.3216186-2-maghasi@disroot.org>
Content-Language: en-US
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <20261004111007.3216186-2-maghasi@disroot.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Masoud,

Please wait some time, say 24 hours, for human reviews before sending
the next revision.

On 4/10/26 19:10, Masoud Aghasi wrote:
> For BPF_MAP_TYPE_PERCPU_ARRAY map, bpf_percpu_array_update()
> is not considering the possibility of a combination of
> (BPF_NOEXIST, BPF_EXIST) flags with (BPF_F_CPU, BPF_F_ALL_CPUS) flags.
> This causes the (BPF_NOEXIST, BPF_EXIST) flags to lose their effect
> in some cases.

[...]

> @@ -438,7 +438,8 @@ int bpf_percpu_array_update(struct bpf_map *map, void *key, void *value,
>  	u32 size;
>  	int cpu, off = 0;
>  
> -	if (unlikely((map_flags & BPF_F_LOCK) || (u32)map_flags > BPF_F_ALL_CPUS))
> +	if (unlikely((map_flags & BPF_EXIST) && (map_flags & BPF_NOEXIST)) ||
> +	    unlikely((u32)map_flags & ~(BPF_EXIST | BPF_NOEXIST | BPF_F_CPU | BPF_F_ALL_CPUS)))

Probably, we can add these two macros in include/linux/bpf.h.

#define BPF_EXIST_FLAGS (BPF_EXIST | BPF_NOEXIST)
#define BPF_CPU_FLAGS (BPF_F_CPU | BPF_F_ALL_CPUS)

Then, this 'if' can be simplified to

if (unlikely(((map_flags & BPF_EXIST_FLAGS) == BPF_EXIST_FLAGS) ||
	     ((u32)map_flags & ~(BPF_EXIST_FLAGS | BPF_CPU_FLAGS)))

Also simplify htab_map_check_update_flags() in the next patch by the
same way.

Thanks,
Leon

>  		/* unknown flags */
>  		return -EINVAL;
>  
> @@ -446,7 +447,7 @@ int bpf_percpu_array_update(struct bpf_map *map, void *key, void *value,
>  		/* all elements were pre-allocated, cannot insert a new one */
>  		return -E2BIG;
>  
> -	if (unlikely(map_flags == BPF_NOEXIST))
> +	if (unlikely(map_flags & BPF_NOEXIST))
>  		/* all elements already exist */
>  		return -EEXIST;
>  

