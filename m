Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55CA83644DB
	for <bpf@vger.kernel.org>; Thu, 11 Jun 2026 05:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781154743; cv=none; b=l8GrKxslu/tnyhr9KoXQpGW8XYK7o81g/y/FW+p0nDQyjswKFSniqE0iJDkvYn6ubl+IMd26fo5Lt/QQleE1ccKFG5+qe3Qhj8xun4t5HyXH6mSab12+OuWZKweBi5eYX/TXM6nDeg/O8HM280GF5f9szyiBHu2WfqCqFP+V9Kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781154743; c=relaxed/simple;
	bh=k0+j2sm99fCvPQ/6mNnsH2tYyyOHiWaUgz6NZSF+TV4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=baznG30WBbbtrXha36ULHJy3ToOog+55fhCjy5vrnTfezDiga4cRh9O5Pm0Rohs4JiXBpAQwt7zqgaXtT1w6TIB3GNS/bPlqA7fGJiRJsj8yJRDMcdB/UEiPRnhYSkZUTEjiwYAZ+VCZbpRiOeTv7fDvl+20ptdwc89ROqA0fqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=eVKFia+Z; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="eVKFia+Z"
Message-ID: <c8b799df-8a38-4a15-a3f4-a71585c9c205@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1781154736;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=94Q9AfOeLhB/iFBRtkQjrGcdH58ZKIXSV7BybBRKTeo=;
	b=eVKFia+ZWWGmEyj1k9LSmGg47PGqqNAJB0rdMm6j+EXgxG38UUxHD9PZ/3VCU0Im7+RQx9
	XvpW7NMWLVKDrUYJblJ3Lhn9aGbTUI6As8jOsgM4Q6rUSQYkj3LFIg8vP1OfpRGlvOO31J
	gWYe2gPvjlNkZOkVDdgBxYjI3BQeR8M=
Date: Thu, 11 Jun 2026 13:12:11 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v5 8/9] selftests/bpf: Add test to verify xlated
 insns for global percpu data
Content-Language: en-US
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
References: <20260608145113.65857-9-leon.hwang@linux.dev>
 <20260608152120.8B9181F00893@smtp.kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <20260608152120.8B9181F00893@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 8/6/26 23:21, sashiko-bot@kernel.org wrote:
[...]
>> +static __u64 ld_imm64_to_u64(const struct bpf_insn *insn)
>> +{
>> +	return ((__u64) insn[1].imm << 32) | (__u64) insn[0].imm;
> 
> [Severity: Low]
> Does this code inadvertently sign-extend the lower 32 bits?
> 
> The imm field in struct bpf_insn is a signed 32-bit integer (__s32). Casting
> it directly to __u64 performs sign extension. If insn[0].imm were to contain
> a value with its most significant bit set, it would be sign-extended,
> corrupting the resulting 64-bit value.
> 
> Should this cast to __u32 first before casting to __u64, like
> (__u64)(__u32)insn[0].imm?
> 

Ack.

Will add (__u32).

>> +}
>> +
>> +static void test_global_percpu_data_xlated(void)
>> +{
>> +	struct bpf_insn ld_imm64_raw[2], ld_imm64_xlated[2], mov64_percpu_reg, *insns = NULL;
> [ ... ]
>> +	prog = skel->progs.verifier_percpu_read;
>> +	idx = find_ld_imm64(bpf_program__insns(prog), bpf_program__insn_cnt(prog), ld_imm64_raw);
>> +	if (!ASSERT_GE(idx, 0, "find_ld_imm64 raw"))
>> +		goto out;
>> +
>> +	err = test_global_percpu_data__load(skel);
>> +	if (!ASSERT_OK(err, "test_global_percpu_data__load"))
>> +		goto out;
>> +
>> +	err = get_xlated_program(bpf_program__fd(prog), &insns, &cnt);
>> +	if (!ASSERT_OK(err, "get_xlated_program"))
>> +		goto out;
>> +	if (!ASSERT_GT(cnt, idx + 2, "xlated insn count"))
>> +		goto out;
> 
> [Severity: Low]
> Is this bounds check using the correct index variable?
> 
> At this point, idx holds the index from the raw BPF program. Because the
> BPF verifier can insert instructions, the index in the translated program
> might differ from the raw index.
> 
> Could this bounds check be moved after idx is updated below, since
> &insns[idx + 2] is accessed later using the translated index?
> 
Ack.

Will check cnt using the new idx.

Thanks,
Leon

