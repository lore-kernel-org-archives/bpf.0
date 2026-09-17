Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CACB5038F9
	for <bpf@vger.kernel.org>; Thu, 17 Sep 2026 16:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789661412; cv=none; b=kxxFNiKZY4ASOrF3PdH7hgsC8DlKIOVF2bJNDD+HpcE31MVxi+JcNa5gboK//cbTgLwqjx76yYi4sAcLIXAhJlHTnGr2EpdGIOMn73YXu4fghzybgKOtCCAz8FoZcP6ptJha6AWpMn4UYqHbY1Ay4tPRK+yIqzum1CRrf0YeDmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789661412; c=relaxed/simple;
	bh=El3eFx2WKoUGiyPHoRHrgvZ38tvXbwJ/GcEtCnjo+Wo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NT/FfCQc597DzBpvAZhKy9Ju6XzBh3ce2apDwiKpMyyTIAbjqC85YR1F1VVKOsZbM/W8Q/BYvj1VJnqWKN1e+TGVGusEc7Y54eZUmONW3Tvx2WxcSw98h1MDG5mKPVfSvEojAEtEDY773XgPHU/UUqcP0eIG3Fgra9kyhZ2QnVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DrCyJ16L; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DrCyJ16L"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49b912e64ccso7335975e9.0
        for <bpf@vger.kernel.org>; Thu, 17 Sep 2026 09:10:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789661409; x=1790266209; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JCtOntWTjPZc4BpViwhdQjZl7CARnN18qaHDaorAHCY=;
        b=DrCyJ16LWoctQ7/aUuQi+uDLcrTnhYRId3nOP68Z2SbFn+agBMiK+XPWM1Uoirdgk4
         8vlxYxPsYQGb+B49A59PXoTVCcLNB0kmemcpKJHysEmeulorDCwKLft1y6W2QU2ySiRN
         HFpAZy/FeqI9nSIkPCCgaTf0GUPddMqEhYyJN4c4YLy0LtObkPn4vlBjenEBnNhadKJ0
         mu9EpZOoZe0of1Hm/XYCPh86hAc6bvXGicQZWGp/NCEyY5KSGSe0qL8ozLHR2NkNIKvi
         xDfpduaD2R4pEnzEnT+W6zVk5TYPC7z7x7fVl/bjXODzamAhDXrxQD+HMGt+laFM8OeP
         xbqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789661409; x=1790266209;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JCtOntWTjPZc4BpViwhdQjZl7CARnN18qaHDaorAHCY=;
        b=nW9nEFLbv949kc0I64E+znzZybbqycQ8j8ggHSz7xyEQn7FcpW4ENOjpnusXtPiW2c
         PMGGTZ7tRAop1DzeSC0n5+mhYBoFecPSbslNAnKc+SAF0q8ky7SkxHoYIv1yP8uFUvdD
         +0MuQhzQGGXwhvHjDneBShpKjNnobPOPDRgqoNP6jjwlqIhEzjvnkk9k2RtnqX8qJemH
         0aNDX9YEiEmJsdsLktCRrjYbHwa2CvdMtOBecA5/S70ypc6Cpw0nVac7d7jVsJx7zs9p
         yLkl8UffQ2dx4gRXyqQ6GQV7MFBXmSGEKsVjfJflT3NkaICmQO6rnCOD82fcOA+NpSwJ
         WAeg==
X-Gm-Message-State: AFuF++lo3q60R6WlMV2rQ3juWOC5JKNRVHUlHXOR5sXcniddiSFheCqm
	vaILuniognG+lmQTgpnIfMgOnxBX/0d6sRelhAwWWJB9R33ykgTruHQE
X-Gm-Gg: AYBFou0GW3vdvGaPzDVBc/i0oqd9ep5yKvzKAjGnHUJPztH1/O0q5VzelX7Q0bp52nH
	fztNztGA7wdR1UPc7foCnEsZaqXk+NsgLSvGkj7WPpsULeC2kyCnaONAHCbABKAqHhwkp+qTem9
	YFjlGZoZOdMRkZjehTp2nFcljDfgbPpcowpwQW3T0FQbbrzgvnjnCjczgV71vcM89RuE6bLjY/Q
	A1rkW3FwAHGpsj/U3pU69RWtYBOZtagfl4n4CsUJXRz5kEXHHLkt/RGcOxPlX00GGzY81/dZwSO
	HyxbdoZgIjNYoK7jgMxVp/f4dYCpjhcGf0uLg1IL9x3DEYZjJeCKs9B7F2LS/3OHUZvV+5I/lKR
	ET4z+B38COsmNnhIz4SKEzXphebVYoRqx2gc0Y5mTNi65NIhzw83dt9Ay//+xBZbrGPos1rtYwr
	OjSr7qAbKmX+j0QLMGCAwJ2yNMeJahsr9v8neGOXaJrwbApo6SM1X3KkAVZeCBU0VmJLykj19lp
	Dbi2Ywr5F4elEhyo0SE2La7HYweZk5eN1lY
X-Received: by 2002:a05:600c:354b:b0:49f:bd3c:bc1f with SMTP id 5b1f17b1804b1-49fbd3cbd0dmr45437715e9.26.1789661408374;
        Thu, 17 Sep 2026 09:10:08 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1126:4:b38f:24e6:c510:eeb1? ([2620:10d:c092:500::6:e617])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4870bf34440sm16321490f8f.25.2026.09.17.09.10.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Sep 2026 09:10:07 -0700 (PDT)
Message-ID: <15342d9c-d823-427d-9ce8-04cf48c6854b@gmail.com>
Date: Thu, 17 Sep 2026 17:10:06 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v4 0/2] bpf: htab: Reduce memory use of hash maps
To: "T.J. Mercier" <tjmercier@google.com>, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com,
 memxor@gmail.com, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, jolsa@kernel.org, emil@etsalapatis.com
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260812231905.2956588-1-tjmercier@google.com>
Content-Language: en-US
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
In-Reply-To: <20260812231905.2956588-1-tjmercier@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/13/26 12:19 AM, T.J. Mercier wrote:
> Memory is expensive and scarce these days. This series reduces the
> memory use of BPF hash maps by eliminating the per-element overheads
> below. This saves up to 50% of per-element memory use for standard and
> PCPU hash maps. The memory use of LRU hash maps is unaffected.
> 
> Map Type & Configuration            | Old size | New size | Savings
> ------------------------------------|----------|----------|--------
> Standard (key <= 8 B, val <= 8 B)   |   64 B   |   32 B   | 50.0%
> Per-CPU (prealloc) (key <= 8 B)     |   64 B   |   32 B   | 50.0%
> Per-CPU (non-prealloc) (key <= 8 B) |   64 B   |   40 B   | 37.5%
> LRU (Any key/value size)            |    -     |    -     | 00.0%
> 

T.J. are you still interested landing this? Maybe respin the series?
Alexei was away back when you sent this.

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
> For hash maps with small key sizes (<= word size), comparing keys only
> requires a single instruction. Currently the 4 byte hash value (8 byte
> aligned and padded) is used for this, but offers no performance
> advantage in this case and can be eliminated.
> 
> The implementation splits htab_elem into dedicated structures for the
> different map types (htab_elem_lru, htab_elem_pcpu, htab_elem) which
> share a common initial sequence (struct htab_node), but contain
> additional map-type specific fields where necessary. This means the
> placement of the key for each element varies with the map type, and
> key_offset is added to bpf_htab for this purpose.
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
> ---
> Changes in v4:
> Removed inline from new functions per BPF CI (netdev/source_inline).
> 
> From Mykyta Yatsenko:
> Factor out duplicate lookup_elem code into __lookup_elem_raw.
> Use offsetof instead of sizeof for key_offset assignments in
> htab_map_alloc (patch 1).
> Eliminate branching and htab_elem casting in htab_elem_hash /
> htab_elem_set_hash.
> 
> Changes in v3:
> From Sashiko on torn reads/writes:
> Use a local unsigned long and READ_ONCE / WRITE_ONCE instead of memcmp /
> memcpy for atomic key comparisons for hashless elements.
> 
> Changes in v2:
> Make maximum key_size for !has_hash depend on word size for atomicity
> on 32-bit.
> 
> From Mykyta Yatsenko:
> Put the htab_elem* common initial sequence in its own struct (htab_node)
> and reuse it across all element types that share it. Eliminate
> associated BUILD_BUG_ON additions.
> Replace both the hash and key fields with data[].
> Store has_hash in struct bpf_htab, and avoid per-element reads of it.# Please edit the description for the branch
> 
> T.J. Mercier (2):
>   bpf: htab: Split htab_elem_lru and htab_elem_pcpu off of htab_elem
>   bpf: htab: Reduce elem_size by 8 bytes for small key sizes
> 
>  kernel/bpf/hashtab.c                          | 418 ++++++++++++------
>  kernel/bpf/map_in_map.c                       |  13 +
>  kernel/bpf/map_in_map.h                       |   2 +
>  .../selftests/bpf/progs/map_ptr_kern.c        |   2 +-
>  4 files changed, 289 insertions(+), 146 deletions(-)
> 
> 
> base-commit: cfce77b63375dac81d53f2f85593c548415206b7

