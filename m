Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D953D3126DF
	for <bpf@vger.kernel.org>; Fri, 24 Jul 2026 14:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784903753; cv=none; b=kcrv/6srvs2e42D5ky3vvrluImInMf9bwxJ6u/7sAxCaZaabU3i5EoeqXQmwjuOw6Lb0nnAOqvdoc7dhj1EcmHxP2mZ4o1v4dXvTtY+SR25J0CXvaO5O9YoxSx2cVfmCxVRQl1Gkjs8XDCedVwtH+rQOBd5xLSNe2SF9dHOD20w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784903753; c=relaxed/simple;
	bh=7oS8vM6iAnANmbP0WQb5EPFQcVXRX1c0I5kp2CKZf3w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iXtNkuLuD3SrQGqjCoFk8H+Rja3lO98CReQT2NBW2kC4nZ8STtkq1AQBi8gPNAoaeNTrYUrI5SthzYc5KR46aJSSRn+9HWHIOrKUEqW5H4PBdx2/smk7TnWJyIvyxEPFlpLX10d+T+VHqfchvb+PMLyg8I16gMevPyCDmozgT6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nt9K+5x4; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nt9K+5x4"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4955de8797cso4042075e9.3
        for <bpf@vger.kernel.org>; Fri, 24 Jul 2026 07:35:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784903750; x=1785508550; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=T2AmyK6VS5hlMIK1jljsVPuXvNOj4MYXZ8JpEwO/0IE=;
        b=Nt9K+5x4IqR/ltj2xzsH9XgXM5t3JtS3Iw5k3pqlrdsIMBHpuCFdmNgvET/WkfMMYS
         eN7PjNezTV6X7G/boE/wWV4WB3/tWmkAP7dGEkLccvr3ygwp63/sHTI6XGJlZhyeSDuK
         U+9L9lKGEnl0UgfqP9OSO1QlIARw17b6dX1QMIO7ZAfAlsE95V7PD4FFIDFNe4uQ3uSe
         RDTdrCTW3yO5L8YSbsJwT4Bui2ZxSjRKYvaAacTwSFOEts+TXokrz27Qxnd4aza2Wmvz
         ESXFNHACcn3VG53GijD2xPQ7/rS+674+RkfEIPrFvbANblIregcTR4GzV5yEHLQc82vP
         D4Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784903750; x=1785508550;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=T2AmyK6VS5hlMIK1jljsVPuXvNOj4MYXZ8JpEwO/0IE=;
        b=deini6//m9N6ZnAfqmO5RwnMjOsMFMypuVq81G/5i828FFNNwmCQS3fTfQp6jeGY49
         iWyhbu0iPqlGbI9VAfstYvk5N2F0IaRlpJSJZfvzugrmVB2AQJDXqnwCbj21I086io5L
         aC5avqieTQ/A0Q67OMrLDeYBhapZ/ekHOosSLMY3n67SxdCADdJII3QEz2yzRyjhjhcT
         pflrhc16X+yurGVr7CtbDuExqbJTpzx1y/kfWr+fvh6yZX7q6MO2VXVjKRNS3qlRVI87
         4FEB4u4fpScR5XdW3MCD5635Tqe1bARXmTIkY4/aVdRmTbM/EywOA3ppqm0apeVm/Nmy
         eeXA==
X-Forwarded-Encrypted: i=1; AHgh+RrBEg/U7o85DidPGMadBntqZKy0h2JkH+sT5/E6oyYcKMZ2IeNR3qwsiSuQgBhMwKDhESk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjWk9JzgbSMqu+DMmfkARHbRarCJGqvMTkdtBZjxDJWoKKnFiX
	xtP74PBW3DXG+Xe6Ax1mt2u3kqYu5BJu97+jwuBkgw0gWQAq7QcZv8kJ
X-Gm-Gg: AR+sD11UIPUFKtNIE+klKqkfcl5EWtUMSgC61AE9lDogkchpFa5tISqZFIRRHaYzMH7
	Uy6hyvXC6RP86QuylIv0EDBGQieNf53B4+d39ECfg4RdjtX1XWFBp7bPaU03TmsGHna0G77b97v
	fZPntRMbIT6LWIZOkYY9jZl1+Nsi2RNKcNjui1ornAF2MZwm7kzpuPW8y0Bpn9N8XmfeMcyGLms
	72eOZefVBSFSMY+G2E6HitP5drvWvwZFDjEm6o3h5zAKiZgeQoxFY7qNVcPBLxAoXKh7CQihhQ5
	EvUMWnhZiJGE/MmKcW6K0klftfYqu4SnNbP1Rd1AKE6XEqUWn3IxZ34YpsjuZBTSnGHhLo6Xhkf
	zgclLa35XY+nnx2wP/Mk1MBpBBzp8JF5Qo55aYurUx4o77Zhu6fU1sjxBd+hT8Hn/1yKNvwH9Gp
	rYXuvtyzGRzg8iMiXK7H9Af9Z1GEMLZb8Ts3P2AT+LqQvoQiDH+yr3ExnhJ9aZsg==
X-Received: by 2002:a05:600c:46c8:b0:495:6713:9aa3 with SMTP id 5b1f17b1804b1-4957a6e9f55mr52267595e9.30.1784903749664;
        Fri, 24 Jul 2026 07:35:49 -0700 (PDT)
Received: from ?IPV6:2a01:4b00:bd1f:f500:f867:fc8a:5174:5755? ([2a01:4b00:bd1f:f500:f867:fc8a:5174:5755])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f85bb5127sm23724640f8f.10.2026.07.24.07.35.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Jul 2026 07:35:49 -0700 (PDT)
Message-ID: <dc95818f-eb75-4389-be28-b1128126b92c@gmail.com>
Date: Fri, 24 Jul 2026 15:35:48 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] bpf: htab: Reduce memory use of hash maps
To: "T.J. Mercier" <tjmercier@google.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 eddyz87@gmail.com, memxor@gmail.com, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, jolsa@kernel.org, emil@etsalapatis.com,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260722203801.1854941-1-tjmercier@google.com>
 <b8541508-5046-448c-b32d-40c7ad79b1e9@gmail.com>
 <CABdmKX3Jhrb3G3_25CN+TAG8oSgOqJwr0xi8XUC8c7RsCS=h-A@mail.gmail.com>
Content-Language: en-US
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
In-Reply-To: <CABdmKX3Jhrb3G3_25CN+TAG8oSgOqJwr0xi8XUC8c7RsCS=h-A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 7/23/26 6:22 PM, T.J. Mercier wrote:
> On Thu, Jul 23, 2026 at 7:11 AM Mykyta Yatsenko
> <mykyta.yatsenko5@gmail.com> wrote:
>>
>> On 7/22/26 9:37 PM, T.J. Mercier wrote:
>>> Memory is expensive and scarce these days. This series reduces the
>>> memory use of BPF hash maps by eliminating the per-element overheads
>>> below. This saves up to 50% of per-element memory use for standard and
>>> PCPU hash maps. The memory use of LRU hash maps is unaffected.
>>>
>>
>> I understand that these savings calculations do not account for the element
>> value overhead of per-CPU maps, which make up most of the map memory
>> consumption. Realistically we won't see any memory savings for per-CPU maps.
> 
> Yes, I did not look at BPF_MAP_TYPE_PERCPU_ARRAY at all. 95% of the
> memory used by all of our BPF maps comes from hashmaps affected by
> these changes. We only have 7 BPF_MAP_TYPE_PERCPU_ARRAY maps and they
> consume only about 12 KiB. (I know a few of those PCPU arrays are just
> to avoid 128 / 256 byte BPF stack allocations.)
> 
> 

BTW, did you look into BPF_MAP_TYPE_RHASH? It does not
yield much memory savings compared to normal hashmap, but performance
is better in some scenarios.

Link: https://lore.kernel.org/all/20260605-rhash-v7-0-5b8e05f8630d@meta.com/

> 
> 
> 
>>> Map Type & Configuration            | Old size | New size | Savings
>>> ------------------------------------|----------|----------|--------
>>> Standard (key <= 8 B, val <= 8 B)   |   64 B   |   32 B   | 50.0%
>>> Per-CPU (prealloc) (key <= 8 B)     |   64 B   |   32 B   | 50.0%
>>> Per-CPU (non-prealloc) (key <= 8 B) |   64 B   |   40 B   | 37.5%
>>> LRU (Any key/value size)            |    -     |    -     | 00.0%
>>>
>>> 1) Unused LRU / PCPU fields in standard and PCPU hash maps (patch 1)
>>> struct htab_elem is used for all hash map types, and includes fields
>>> that are not always used (bpf_lru_node, ptr_to_pptr). For standard
>>> (non-LRU, non-PCPU) hash maps the 24 bytes for the bpf_lru_node (union)
>>> are entirely overhead and can be eliminated. Non-preallocated PCPU maps
>>> only need the 8 byte ptr_to_pptr which is currently unioned with the
>>> unneeded 24 byte bpf_lru_node, so 16 bytes of overhead can be
>>> eliminated. Preallocated PCPU maps don't need ptr_to_pptr, so 24 bytes
>>> of overhead can be saved.
>>>
>>> 2) Hash caching for small keys (patch 2)
>>> For hash maps with small key sizes (<= 8 bytes), comparing keys only
>>> requires a single instruction (64 bit), or a few (32 bit). Currently the
>>> 4 byte hash value (8 byte aligned) is used for this, but offers no
>>> performance advantage in this case and can be eliminated.
>>>
>>> The implementation splits htab_elem into dedicated structures for the
>>> different map types (htab_elem_lru, htab_elem_pcpu, htab_elem) which
>>> share a common initial sequence, but contain additional map-type
>>> specific fields where necessary. This means the placement of the key for
>>> each element varies with the map type, and key_offset is added to
>>> bpf_htab for this purpose.
>>>
>>> While using key_offset and conditional hash checks adds new pointer
>>> dereferences and branching during element traversal,
>>> run_bench_htab_mem.sh shows no significant performance regression across
>>> 10 runs on my 3995WX.
>>>
>>> Benchmark (all in kops/sec)  | Avg. Before | StDev | Avg. After | StDev
>>> -----------------------------|-------------|-------|------------|------
>>> prealloc overwrite           | 115.11      | 4.10  | 115.45     | 5.24
>>> prealloc batch_add_batch_del | 127.14      | 4.32  | 127.06     | 2.32
>>> prealloc add_del_on_diff_cpu | 23.22       | 0.93  | 22.91      | 1.60
>>> normal overwrite             | 78.52       | 3.05  | 80.40      | 3.25
>>> normal batch_add_batch_del   | 45.37       | 0.69  | 47.71      | 0.66
>>> normal add_del_on_diff_cpu   | 12.02       | 0.73  | 12.48      | 0.70
>>>
>>> T.J. Mercier (2):
>>>   bpf: htab: Split htab_elem_lru and htab_elem_pcpu off of htab_elem
>>>   bpf: htab: Reduce elem_size by 8 bytes for small key sizes
>>>
>>>  kernel/bpf/hashtab.c                          | 339 ++++++++++++------
>>>  kernel/bpf/map_in_map.c                       |  13 +
>>>  kernel/bpf/map_in_map.h                       |   2 +
>>>  .../selftests/bpf/progs/map_ptr_kern.c        |   2 +-
>>>  4 files changed, 252 insertions(+), 104 deletions(-)
>>>
>>>
>>> base-commit: cfce77b63375dac81d53f2f85593c548415206b7
>>

