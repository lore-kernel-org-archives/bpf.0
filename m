Received: from mta0.migadu.com (out-240.mta0.migadu.com [91.218.175.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD1D02CCC6
	for <bpf@vger.kernel.org>; Sat, 19 Sep 2026 20:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789849631; cv=none; b=O0Uq9HlOt7vflU1lmUH1YRrxRa4cb4H66JCCZVGIsZiWi10z+bprEZBxABdzS0sPicRV7enWchji18/592GLuW+YvBAaLQslDxEhLydxScco3UUgmikZLYiRB2ci/StKvy1aqM3fGb5B6EsoBx0DSBaCLIXAFqE2jof99yDbKQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789849631; c=relaxed/simple;
	bh=O2l+KgxSHzLRaaKI95s07XnoTMBwmg9M7/+OF5kLzNE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l1Y+8XfqGD4tZwTRVmsQWYB2C75wJTVpD9fISlt7kw6MiYEJ3veda0l3qesEmXm2qpPMfEahml37undpyRfOFLCbhhEAiODePAU3fDv9D6WK8rYiiErQFEq2rbPFbQOhiUDlLDh1mvEeYjOEbbjMIGGwH7zQ+MOhxdH2zK+Qeq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=GNzWTXDa; arc=none smtp.client-ip=91.218.175.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="GNzWTXDa"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=O2l+KgxSHzLRaaKI95s07XnoTMBwmg9M7/+OF5kLzNE=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789849626; v=1; x=1790454426;
 b=GNzWTXDajiBSuR7nbpL2m+mvIyi+7n7ImryFjBHh6/wGkjQG1sJHR1N9afad+oGjsNeZjd88
 8GgNmF63OviS6oQXs5cxiPKis2DMq2mwfpOLTlPg/1hVh0dq+WyLo4PQ7oHkvowkZ4u+Jnj6pBg
 s4auT0FHZRXv4Sqlg1QRGOls=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id faf54840bab87a35;
	Sat, 19 Sep 2026 20:27:06 +0000
X-Mizu-Trace-ID: faf54840bab87a35
X-Migadu-Flow: FLOW_OUT
Message-ID: <bb5e5965-45c3-4402-9c35-5c8e9226755f@linux.dev>
Date: Sat, 19 Sep 2026 13:27:00 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2 16/20] libbpf: Carry the exception cleanup
 table through the light skeleton
Content-Language: en-GB
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
References: <20260918044156.3283973-1-yonghong.song@linux.dev>
 <20260918044322.3292575-1-yonghong.song@linux.dev>
 <20260918050217.599711F000FF@smtp.kernel.org>
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20260918050217.599711F000FF@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 9/17/26 10:02 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] libbpf: integer overflow in cleanup_info_tot_sz leads to heap OOB read/write
> --
>
> commit b9300a1f6022da2aa8b343e05882b46e9f329c64
> Author: Yonghong Song <yonghong.song@linux.dev>
>
> libbpf: Carry the exception cleanup table through the light skeleton
>
> This patch modifies the light skeleton generation to carry the exception
> cleanup table (cleanup_info), similar to func_info and line_info. It updates
> bpf_gen__prog_load() to allocate space for the records, set up union bpf_attr,
> and perform endianness swapping for cross-compiled cases.
>
>> diff --git a/tools/lib/bpf/gen_loader.c b/tools/lib/bpf/gen_loader.c
>> index af3a04f161ac1..2345fbdd46f56 100644
>> --- a/tools/lib/bpf/gen_loader.c
>> +++ b/tools/lib/bpf/gen_loader.c
> [ ... ]
>> @@ -998,6 +1000,9 @@ static void info_blob_bswap(struct bpf_gen *gen, int func_info, int line_info,
>>   
>>   	for (i = 0; i < gen->core_relo_cnt; i++)
>>   		bpf_core_relo_bswap(cr++);
>> +
>> +	for (i = 0; i < load_attr->cleanup_info_cnt; i++)
>> +		bpf_cleanup_info_bswap(ci++);
> [Severity: High]
> Could this loop result in an out-of-bounds heap read and write?
>
> If an attacker crafts a BPF ELF object with an extremely large .bpf_cleanup
> section, load_attr->cleanup_info_cnt can be very large. If the allocation
> size calculated in bpf_gen__prog_load() overflowed, this loop will process
> hundreds of millions of elements in an undersized buffer.
>
> This could cause memory corruption when cross-compiling (gen->swapped_endian
> is true).

It is user's problem if they intentionally want to have of lots and lots of
.bpf_cleanup section.

>
>>   }
>>   
>>   void bpf_gen__prog_load(struct bpf_gen *gen,
>> @@ -1011,8 +1016,11 @@ void bpf_gen__prog_load(struct bpf_gen *gen,
>>   			       load_attr->line_info_rec_size;
>>   	int core_relo_tot_sz = gen->core_relo_cnt *
>>   			       sizeof(struct bpf_core_relo);
>> +	int cleanup_info_tot_sz = load_attr->cleanup_info_cnt *
>> +				  load_attr->cleanup_info_rec_size;
> [Severity: High]
> Does this unbounded 32-bit integer multiplication risk an overflow?
>
> If load_attr->cleanup_info_cnt is excessively large, multiplying it by
> cleanup_info_rec_size could wrap around modulo 2^32 to a small positive
> integer. This would result in add_data() allocating an undersized heap
> buffer for the cleanup info blob.
>
> Combined with the loop in info_blob_bswap(), this could lead to crashes
> or potentially arbitrary code execution when processing untrusted files
> using the light skeleton generator.

We should be okay. Similar to line_info, core_relo, etc., all of them
(including cleanup_info) will have a guard in add_data which ensures
the total size must be smaller than INT32_MAX.

>

