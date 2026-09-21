Received: from mta0.migadu.com (out-194.mta0.migadu.com [91.218.175.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F262D3BE141
	for <bpf@vger.kernel.org>; Mon, 21 Sep 2026 14:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790000050; cv=none; b=NNLVUXcBqVhhs4rB6vrj7Yw+hXv7ya7yRFpl00olMjOnkrlCVfDHZn4zfVpzKAKXHlQo7yiJdPwsKZTYbz4h2xpR8x7AaRLQKlH1f40FdLgKizWcq1yaImlaVU+J8VdjNR0I18lTNmYWFIFZs4NxyV8OIs+JvrtDhGxgSbc2LxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790000050; c=relaxed/simple;
	bh=5pQC0kqxUSJeFu8J4BFJADFheG0OgG3mpln6pB3C/XI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jghEP3TA7ClF5QEry5YDCcblVUaWrOMWCzZJR2kb/MYS6pF56q95z4PN1PVEpu+lsq9nRLFPToZile25daomWcz+BM1ypjID6MdkJRYlLnTDTItu9ug0HnCa2eu3C6Py0l6I85352Xuab4XskIaoHatZ9Noa2jrMR6wCb/rNRO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=BGaUNser; arc=none smtp.client-ip=91.218.175.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="BGaUNser"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=5pQC0kqxUSJeFu8J4BFJADFheG0OgG3mpln6pB3C/XI=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790000046; v=1; x=1790604846;
 b=BGaUNserVcYMsedGCqyeMkYihdV0CK6TsTMDjb8jbCRSI5OtjPCUcPyNJvI/11WT/dUlWCtJ
 G2w8sQgzsjNlfw/I3DraoXCoO1P2A70LOiVw15IkBFjD6H5vmh2iCttLhK9x208AXQSY7g9g2aI
 6te8KgO7wy1PAy6lg5RmfAps=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id e3566851e24fa24d;
	Mon, 21 Sep 2026 14:14:06 +0000
X-Mizu-Trace-ID: e3566851e24fa24d
X-Migadu-Flow: FLOW_OUT
Message-ID: <0036dd4d-6bb3-4547-9ae7-3601f7adf366@linux.dev>
Date: Mon, 21 Sep 2026 07:14:01 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v3 16/20] libbpf: Carry the exception cleanup
 table through the light skeleton
Content-Language: en-GB
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
References: <20260920054225.864535-1-yonghong.song@linux.dev>
 <20260920054347.872462-1-yonghong.song@linux.dev>
 <20260920060112.1B9011F000FF@smtp.kernel.org>
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20260920060112.1B9011F000FF@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 9/19/26 11:01 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] bpf: Integer overflow in cleanup_info_tot_sz leads to heap buffer overflow
> --
>
> commit ae662736be5da05d165c478a926196fe248e707a
> Author: Yonghong Song <yonghong.song@linux.dev>
>
> libbpf: Carry the exception cleanup table through the light skeleton
>
> This commit updates the light skeleton generator to emit BPF_PROG_LOAD
> instructions that include the exception cleanup table. It stores the cleanup
> records in the loader's bytes blob, calculates the needed buffer size, and
> byte-swaps the records for cross-endian builds.
>
>> diff --git a/tools/lib/bpf/gen_loader.c b/tools/lib/bpf/gen_loader.c
>> index af3a04f161ac1..2345fbdd46f56 100644
>> --- a/tools/lib/bpf/gen_loader.c
>> +++ b/tools/lib/bpf/gen_loader.c
> [ ... ]
>
>> @@ -998,6 +1000,9 @@ static void info_blob_bswap(struct bpf_gen *gen, int func_info, int line_info,
>>   
>>   	for (i = 0; i < gen->core_relo_cnt; i++)
>>   		bpf_core_relo_bswap(cr++);
>> +
>> +	for (i = 0; i < load_attr->cleanup_info_cnt; i++)
>> +		bpf_cleanup_info_bswap(ci++);
> [Severity: High]
> Does this loop write beyond the allocated buffer if cleanup_info_tot_sz
> overflowed during its calculation?
>
> If an untrusted user provides a malicious BPF ELF object with a very large
> .bpf_cleanup section, load_attr->cleanup_info_cnt can be extremely large.
> The loop uses this un-wrapped count to byte-swap entries, writing past the
> end of the buffer if the allocation size was wrapped.
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
> Can this multiplication overflow a 32-bit integer?
>
> If load_attr->cleanup_info_cnt is a huge value (e.g., 0x15555556),
> multiplying it by cleanup_info_rec_size (12) will wrap around a 32-bit
> integer.
>
> This would result in a small wrapped value being assigned to
> cleanup_info_tot_sz (e.g., 0x15555556 * 12 = 4294967304, wrapping to 8).
> The resulting undersized allocation passed to add_data() would then lead
> to the out-of-bounds write in info_blob_bswap().

Overflow is indeed possible. Will fix it, e.g. with cleanup_info_tot_sz as __u64
and later check against INT32_MAX.


