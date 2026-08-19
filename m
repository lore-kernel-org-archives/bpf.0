Received: from mta1.migadu.com (out-154.mta1.migadu.com [95.215.58.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A602450909
	for <bpf@vger.kernel.org>; Wed, 19 Aug 2026 16:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787155484; cv=none; b=gXLqGnK8fnHKjmalbx4mC6O5AkRKfxJARGRTyYGVBImSbkl++BnJXvaVut1jGHf+I4swvDq3ezUnXKacnOfFVk7sjWEfsEeBsBtj3A1+oetLNizlZjyp48gJ1P1OMB3NImDjD3yGSbJiQ0f1btCA3FIJDASuK6bPeUafvYe5C9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787155484; c=relaxed/simple;
	bh=ZlBrOXJ6PHWTt554K7ifaS0Y0oPCZpnfxyqBMbg/th0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=daClccAZ7EVJmAh1/rV9D++2wcuGfR1gHIk7S7aMkBen14gpzVe6tN9WX7z2Q7AeTzpV2UGyBfhlMlLmyJWqcGq8rKgcOjKiypYJv6wKebiwqghBUraEAQtvmC7Jes21i92igl9ODIFCOOkd7GJ9WGzPkEvtxIGxCD1E67+j7vQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=QUO8nzU+; arc=none smtp.client-ip=95.215.58.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="QUO8nzU+"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=ZlBrOXJ6PHWTt554K7ifaS0Y0oPCZpnfxyqBMbg/th0=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787155480; v=1; x=1787760280;
 b=QUO8nzU+/T0pI4f1M0vFDjhx+7w5cLCFNEjl5qb+qPOC7QrxyhV54q4jYFidSahBXBfFJexy
 3iHw1Q+UIv2wkfKMj4Meig84p8bl67mAv4sVqfRPwzb5iC/SviwMeNSqDhhbLyvw9rf83+zMd9T
 1OiZGNcwUTcpORddwZIWZiwc=
X-Envelope-To: bpf@vger.kernel.org
Received: from [IPV6:2a03:83e0:1151:15:1c5e:37e8:36:dd37] (2620:10d:c090:500::7:5d0e)
	by smtp.migadu.com with ESMTPS id 5a70adfd73f1071f;
	Wed, 19 Aug 2026 16:04:39 +0000
X-Mizu-Trace-ID: 5a70adfd73f1071f
X-Migadu-Flow: FLOW_OUT
Message-ID: <6be499cd-b78b-4958-ab95-6d11107e85c2@linux.dev>
Date: Wed, 19 Aug 2026 09:04:38 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v7 07/10] bpf: Enable aggregate return types up
 to 16 bytes
Content-Language: en-GB
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
References: <20260819055239.3293449-1-yonghong.song@linux.dev>
 <20260819055314.3298664-1-yonghong.song@linux.dev>
 <20260819061323.66C1A1F000E9@smtp.kernel.org>
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20260819061323.66C1A1F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 8/18/26 11:13 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] BPF extension programs (BPF_PROG_TYPE_EXT) bypass return value verification for BPF_REG_2 when replacing a function that returns a 16-byte struct, allowing uninitialized memory or kernel pointers to leak.
> --
>
> --- Patch [7]: [PATCH bpf-next v7 07/10] bpf: Enable aggregate return types up to 16 bytes ---
> commit 19d85b11c1fe37fb0f420056e54cf29ffa04a0bb
> Author: Yonghong Song <yonghong.song@linux.dev>
>
> bpf: Enable aggregate return types up to 16 bytes
>
> Relax btf_distill_func_proto() to accept a by-value struct or union that
> the R0:R2 convention added in earlier patches can carry.
>
>> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
>> index 5e9f6a4875244..58b81c6f5288c 100644
>> --- a/kernel/bpf/btf.c
>> +++ b/kernel/bpf/btf.c
> [ ... ]
>> @@ -7993,6 +7993,19 @@ static int btf_validate_return_type(struct bpf_verifier_env *env, struct btf *bt
>>   	if (btf_type_is_void(t) || btf_type_is_int(t) || btf_is_any_enum(t))
>>   		return 0;
>>   
>> +	if (btf_type_is_struct(t) && t->size <= 16) {
>> +		/*
>> +		 * A global function's caller models the return as an opaque
>> +		 * scalar pair, so it may only return scalars by value. A local
>> +		 * function is verified inline, so a pointer field stays tracked
>> +		 * and needs no such restriction.
>> +		 */
>> +		bool local_func = subprog && !is_global;
>> +
>> +		if (local_func || btf_type_is_scalar_struct(env, btf, t, 0))
>> +			return 0;
>> +	}
>> +
>>   	return -EOPNOTSUPP;
>>   }
> [Severity: High]
> Does this allow BPF_PROG_TYPE_EXT extension programs to bypass return value
> verification for BPF_REG_2?
>
> Since this patch enables global functions to return structs up to 16 bytes, a
> BPF_PROG_TYPE_EXT program can now replace such a function. This is allowed by
> bpf_check_attach_target() because attach_uses_trampoline_retval() is false for
> extension programs.
>
> However, during verification of the extension program,
> bpf_compute_subprog_ret_regs() explicitly skips subprog 0 (the extension
> program itself), which leaves ret_reg_pair as false:
>
> kernel/bpf/verifier.c:bpf_compute_subprog_ret_regs() {
> 	/*
> 	 * Skip the main program: its return value is the program's exit code,
> 	 * read out of R0, so it never uses the register pair. An extension does
> 	 * have a real prototype for subprog 0, but bpf_check_attach_target()
> 	 * refuses to replace a function returning more than 8 bytes.
> 	 */
> 	for (subprog = 1; subprog < env->subprog_cnt; subprog++) {
>          ...
> }
>
> Because ret_reg_pair is false, process_bpf_exit_full() later invokes
> check_return_code(..., BPF_REG_0) for subprog 0 instead of checking the full
> register pair. Could this fail to validate R2 on exit, potentially allowing an
> uninitialized or sensitive kernel pointer to leak to the caller?

We should be okay here. If freplace replacing the original subprog 0, it
is up to users to check the result if the freplace returning R0:R2.

>

