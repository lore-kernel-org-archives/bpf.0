Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47B134477E1
	for <bpf@vger.kernel.org>; Thu, 23 Jul 2026 14:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784815932; cv=none; b=ulAWj05VxTSVMzniJjiplix38e9eVbTBgAv3qifJnGvc69tTIkP0xlyl2ecX4cJpeCSRZGM5uGwxvvj/FJGpW90IX4JusKZYcogN581oxRXMp7gd3ir+8JUyP3p1zi6ITwPbthIlQfGcQYQqWyva0GIysJv4TyjVs9gyzWqupsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784815932; c=relaxed/simple;
	bh=umdyUQaqTezmHVMKRY5R1wyVhkoY8KLytGKxWC1/bUw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FANKt21AcAwi6O+6GOHMsPYM1+jJJWWC0sq7LIK2aA/1sMC533/nP1zFEMaQyVKT1xOiShEjbWUQumQibudLybqH6YbdwIX99odvPERRIKUEBCB4JEBNq3IwBX0IcVBihw5k9BEunS+JS8Gan/rFfFhtF6E7qfRTYh1bWoChK78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D/VQGsT3; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D/VQGsT3"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-49548e01d02so4184835e9.0
        for <bpf@vger.kernel.org>; Thu, 23 Jul 2026 07:12:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784815916; x=1785420716; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=R48/gtuAzWAM6tFIR2pFfaUViiWLUSNVgve7iPhvVC0=;
        b=D/VQGsT3CbWipYC/WO94KMjcXcSraYMrBLOwh81/7tZIJpnFa+W0HJF/a7W4ObQU1U
         sKjrzlZmC2m6xCT2FGilZ6ck3sG5Wdjnp41a5wosynhjkEl13lxm5lSE2ul5BJewNrfj
         7SPXuUmQNivbWeZjdg7XEV6Q1RkKoT2Z+2oHWAdjrf22s/Od1xly02yjRso8SW3i5NZI
         T2T2hLwYXRtOI+rXzgN9WZ80rslfDFM/FoW5T21++cE9wOXmwALzCdOScU4ESl5FA2h+
         ZFebyBtPE8pqQ4JAy/BaDAmoTNHiecjY9kexnKy1OhrJ3NJ2zs0tfX0pLCBciSru3AV8
         Gzag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784815916; x=1785420716;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=R48/gtuAzWAM6tFIR2pFfaUViiWLUSNVgve7iPhvVC0=;
        b=G5Qnu4C+7svOMQ9UrErKeYKF4MzkwwgphWzVu+dvGr+XTuff54otfDVT4NwU2Lpo1y
         ZZBUPJu6gxgbcopPMJ674JQxidJcOore2QydLvUadYd+W+lOHihFzJGUiNuG1aC35O1W
         +R6Kb1TZoF26e5myV6fpDFAJ4pP+Z6Ts3HCb9GR3Q0eLiGMLphwzlcJSYdWAYncMhWVX
         lvz5QsiRaSKU5UPCRRJQyc8vlCo9u6ab31IfDhF0HYEbxw4m7yYkR3Yy0l9NvaAyz4bW
         QUfcoUZ0ww+WV10RZ0YdCISX0bdEW9GN6Vj+0sKaeEc4axMHjOrFLC2hfrdk904Qz0c+
         0Qfw==
X-Gm-Message-State: AOJu0Yz1tFL38VM5AUuTvYHG5DJ8Wv3QgYb9PLbIE6eC8/4ouRdlDU6X
	/0Puj4ymMyKzTtguj3VpPjDMWzJfdz5+fVuM8HeNalSi+CH0asRLKqgW
X-Gm-Gg: AR+sD122u2XBSo8NsadsYhfhXqi1/kpkduE7Usl5XL7/ih36abjQGtjzWwlz9x9cij/
	9iwOT8Cxta6C4F98rxzsuGOvrRwGXXzE9xHlZdd6RjlWvHEJm+ArpIPaQ1tKYrGdUugZqdeD42B
	aW5Z12cYjMplfDQZmkXGRqEZHHB0Al26W6I6wjbnxQn/2sIDcJJ7cp3y/64ZdE9U1mOAbEzqsU8
	yAJzwR72U9hI8lUcpzWyRY/v5dON4LwcszTBmgcJPCc90OZgW3UcxYxOwtldIqRQfuvgoCItQKv
	7hx/GaLl1J0A3r9OaG0DY+N6TPpKH5cUoylxQP8I79dwnpmiWvdFcJjCL0RR+Ezw+q/OOC+mdBr
	qCecl9xyC8urNB1Ju12hr+JkGmlrt+uOuUEZgXixB6W2wAuZp/IpERUFEcszI2RtNXV60SRJ72f
	8a0fp1wEhydiV4LRu2pErd+fAow1EgtlX3dghABaOz5Av0886oAw==
X-Received: by 2002:a05:600c:4e89:b0:495:63e4:7f78 with SMTP id 5b1f17b1804b1-49573ccd115mr41000795e9.10.1784815916032;
        Thu, 23 Jul 2026 07:11:56 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1126:4:b876:739d:6f1f:1b78? ([2620:10d:c092:500::4:c44e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4956b7483f0sm129549595e9.3.2026.07.23.07.11.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Jul 2026 07:11:54 -0700 (PDT)
Message-ID: <b8541508-5046-448c-b32d-40c7ad79b1e9@gmail.com>
Date: Thu, 23 Jul 2026 15:11:54 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] bpf: htab: Reduce memory use of hash maps
To: "T.J. Mercier" <tjmercier@google.com>, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com,
 memxor@gmail.com, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, jolsa@kernel.org, emil@etsalapatis.com
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260722203801.1854941-1-tjmercier@google.com>
Content-Language: en-US
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
In-Reply-To: <20260722203801.1854941-1-tjmercier@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/22/26 9:37 PM, T.J. Mercier wrote:
> Memory is expensive and scarce these days. This series reduces the
> memory use of BPF hash maps by eliminating the per-element overheads
> below. This saves up to 50% of per-element memory use for standard and
> PCPU hash maps. The memory use of LRU hash maps is unaffected.
> 

I understand that these savings calculations do not account for the element 
value overhead of per-CPU maps, which make up most of the map memory
consumption. Realistically we won't see any memory savings for per-CPU maps.

> Map Type & Configuration            | Old size | New size | Savings
> ------------------------------------|----------|----------|--------
> Standard (key <= 8 B, val <= 8 B)   |   64 B   |   32 B   | 50.0%
> Per-CPU (prealloc) (key <= 8 B)     |   64 B   |   32 B   | 50.0%
> Per-CPU (non-prealloc) (key <= 8 B) |   64 B   |   40 B   | 37.5%
> LRU (Any key/value size)            |    -     |    -     | 00.0%
> 
> 1) Unused LRU / PCPU fields in standard and PCPU hash maps (patch 1)
> struct htab_elem is used for all hash map types, and includes fields
> that are not always used (bpf_lru_node, ptr_to_pptr). For standard
> (non-LRU, non-PCPU) hash maps the 24 bytes for the bpf_lru_node (union)
> are entirely overhead and can be eliminated. Non-preallocated PCPU maps
> only need the 8 byte ptr_to_pptr which is currently unioned with the
> unneeded 24 byte bpf_lru_node, so 16 bytes of overhead can be
> eliminated. Preallocated PCPU maps don't need ptr_to_pptr, so 24 bytes
> of overhead can be saved.
> 
> 2) Hash caching for small keys (patch 2)
> For hash maps with small key sizes (<= 8 bytes), comparing keys only
> requires a single instruction (64 bit), or a few (32 bit). Currently the
> 4 byte hash value (8 byte aligned) is used for this, but offers no
> performance advantage in this case and can be eliminated.
> 
> The implementation splits htab_elem into dedicated structures for the
> different map types (htab_elem_lru, htab_elem_pcpu, htab_elem) which
> share a common initial sequence, but contain additional map-type
> specific fields where necessary. This means the placement of the key for
> each element varies with the map type, and key_offset is added to
> bpf_htab for this purpose.
> 
> While using key_offset and conditional hash checks adds new pointer
> dereferences and branching during element traversal,
> run_bench_htab_mem.sh shows no significant performance regression across
> 10 runs on my 3995WX.
> 
> Benchmark (all in kops/sec)  | Avg. Before | StDev | Avg. After | StDev
> -----------------------------|-------------|-------|------------|------
> prealloc overwrite           | 115.11      | 4.10  | 115.45     | 5.24
> prealloc batch_add_batch_del | 127.14      | 4.32  | 127.06     | 2.32
> prealloc add_del_on_diff_cpu | 23.22       | 0.93  | 22.91      | 1.60
> normal overwrite             | 78.52       | 3.05  | 80.40      | 3.25
> normal batch_add_batch_del   | 45.37       | 0.69  | 47.71      | 0.66
> normal add_del_on_diff_cpu   | 12.02       | 0.73  | 12.48      | 0.70
> 
> T.J. Mercier (2):
>   bpf: htab: Split htab_elem_lru and htab_elem_pcpu off of htab_elem
>   bpf: htab: Reduce elem_size by 8 bytes for small key sizes
> 
>  kernel/bpf/hashtab.c                          | 339 ++++++++++++------
>  kernel/bpf/map_in_map.c                       |  13 +
>  kernel/bpf/map_in_map.h                       |   2 +
>  .../selftests/bpf/progs/map_ptr_kern.c        |   2 +-
>  4 files changed, 252 insertions(+), 104 deletions(-)
> 
> 
> base-commit: cfce77b63375dac81d53f2f85593c548415206b7

