Received: from mta0.migadu.com (out-234.mta0.migadu.com [91.218.175.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D547527FB37
	for <bpf@vger.kernel.org>; Sat, 12 Sep 2026 17:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789233404; cv=none; b=QVFpRn2FbnVmCHl9s+oCnNXM0huRZZAV8DaqWPCuIkyVfK6Mo44dToVhFvU9X9OfkF0UK8m9oLFcbK7IHFQ++lNXkCz2D9KGZh2fhD9HxqiFbEr0Go43Kh8mzMwEBoHUnSL4fU8fELsSuvEEcWPBudkuHSNjrP/7zDFbiRq0HkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789233404; c=relaxed/simple;
	bh=SEzEOZ78ov7w69ZLE20MVwM5sot3Zk82zzEL4jOoFcg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b3NvnVGIzJmvpB3V9AG5o6UPnKwXMxbRy0Gw6Vnp+o2mX9hTPVoevY2AXgWkeYTVQSEgCLXCbwWeaqTfZCWIrJdaew62lG9F0hiPT5uSu5bz8a/EUjdmpoJ9OheiIhgxX4spFPjq+wHzltZMDGdxUtKWv+arWEdNOZngNWGVg3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=S822D7AS; arc=none smtp.client-ip=91.218.175.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="S822D7AS"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=SEzEOZ78ov7w69ZLE20MVwM5sot3Zk82zzEL4jOoFcg=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789233400; v=1; x=1789838200;
 b=S822D7ASiXpsx84uwCLqLABNMSvK7x4bGSLwNtjyewoAM1SgBrktmxO8haN4QLHaneKh0kOj
 3Tm7zeZxSyCtfYmqZS2G5cgDKDU/TI2Merk2b8MTi+2sCf5RyOQUaILv1nRnAoxC9rlNRNq2y/c
 9+V3x9/9z+DDPzploB9JJbPY=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 5c3635024129d5d1;
	Sat, 12 Sep 2026 17:16:40 +0000
X-Mizu-Trace-ID: 5c3635024129d5d1
X-Migadu-Flow: FLOW_OUT
Message-ID: <15f9423f-ade6-4c29-a42c-d89c276f1b7b@linux.dev>
Date: Sat, 12 Sep 2026 10:16:38 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v3 11/15] bpf, arm64: Move kfunc arguments into
 the arm64 calling convention
Content-Language: en-GB
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
References: <20260911154914.2004336-1-yonghong.song@linux.dev>
 <20260911155010.2011265-1-yonghong.song@linux.dev>
 <20260911161933.01B9B1F000FF@smtp.kernel.org>
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20260911161933.01B9B1F000FF@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 9/11/26 9:19 AM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
>
> Pre-existing issues:
> - [High] The ARM64 BPF trampoline incorrectly saves and restores 16-byte aligned arguments, violating AAPCS64 alignment rules.
> --
>
> commit cd40aa31f4bf1158416008f7fcb9c0b7717dda3f
> Author: Yonghong Song <yonghong.song@linux.dev>
>
> bpf, arm64: Move kfunc arguments into the arm64 calling convention
>
> Do the proper move from the BPF calling convention to the arm64 calling
> convention to satisfy the native requirement. AAPCS64 only ever moves an
> argument to a higher slot, so the moves need one scratch register to carry
> an eightbyte from one stack slot to another, and never the one a
> convention moving an argument down would need.
>
>> diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
>> index 3aa3ea0bc30bb..bbde7c0836ae5 100644
>> --- a/arch/arm64/net/bpf_jit_comp.c
>> +++ b/arch/arm64/net/bpf_jit_comp.c
> [ ... ]
>
>> @@ -2534,7 +2598,13 @@ struct arg_aux {
>>   static int calc_arg_aux(const struct btf_func_model *m,
>>   			 struct arg_aux *a)
>>   {
>> -	int stack_slots, nregs, slots, i;
>> +	int stack_slots, nregs, slots, i, total;
>> +
>> +	/* arm64 supports up to MAX_BPF_FUNC_ARGS argument slots */
>> +	for (i = 0, total = 0; i < m->nr_args; i++)
>> +		total += (m->arg_size[i] + 7) / 8;
>> +	if (total > MAX_BPF_FUNC_ARGS)
>> +		return -ENOTSUPP;
>>   
>>   	/* verifier ensures m->nr_args <= MAX_BPF_FUNC_ARGS */
>>   	for (i = 0, nregs = 0; i < m->nr_args; i++) {
> [Severity: High]
> This isn't a bug introduced by this patch, but since the series introduces
> support for by-value 16-byte arguments, this previously dormant ABI violation
> in the BPF trampoline appears to now be actively reachable.
>
> Does calc_arg_aux() fail to account for skipped registers due to alignment
> requirements?
>
> If a user attaches a BPF program to a kernel function (or struct_ops
> callback) that takes a 16-byte aligned argument (e.g., __int128 or
> by-value struct) preceded by an odd number of register-sized arguments,
> the native AAPCS64 caller places the 16-byte argument in an even/odd
> register pair (like x2 and x3, skipping x1).
>
> However, the nregs calculation here simply increments by slots without
> checking for skipped odd registers:
>
> arch/arm64/net/bpf_jit_comp.c:calc_arg_aux() {
>      ...
>      for (i = 0, nregs = 0; i < m->nr_args; i++) {
>          slots = (m->arg_size[i] + 7) / 8;
>          if (nregs + slots <= 8) /* passed through register ? */
>              nregs += slots;
>      ...
> }
>
> This strictly sequential register handling seems to propagate to both
> save_args() and restore_args() in the trampoline, where arguments are
> read and written sequentially without skipping odd registers:
>
> arch/arm64/net/bpf_jit_comp.c:save_args() {
>      ...
>      slots = (m->arg_size[i] + 7) / 8;
>      while (slots-- > 0) {
>          ...
>          emit(A64_STR64I(reg, A64_SP, bargs_off), ctx);
>          reg++;
>          bargs_off += 8;
>      }
>      ...
> }
>
> arch/arm64/net/bpf_jit_comp.c:restore_args() {
>      ...
>      for (reg = 0; reg < nregs; reg++) {
>          emit(A64_LDR64I(reg, A64_SP, bargs_off), ctx);
>          bargs_off += 8;
>      }
>      ...
> }
>
> Could this cause data corruption for arguments passed to BPF programs
> attached via fentry, fexit, or struct_ops when 16-byte arguments are
> involved?
>
Yes, this is a bug. I will need to consider 16-byte alignment.
Will fix.

