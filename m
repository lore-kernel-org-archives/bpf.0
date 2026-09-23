Received: from mta1.migadu.com (out-19.mta1.migadu.com [95.215.58.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32A59175D53
	for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 03:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790132864; cv=none; b=gvI3ztqa7aodTtN2OpEn9tfwmccbjkt31B4wJJMOAflRYKRHn6K6iYEKGCJW2E0DPeleIr6jolo9+Uj8SDZHYDTIbMgjagHDWEJgeFAewm9+ljcIdqk9rI888Sz35x/DSTO6TQH3wWGMcqFBJ5BKhgNAxdhgxy5b4b1fRUrjJAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790132864; c=relaxed/simple;
	bh=wf0CHBw4cKiVlJ/wkHP2hlDYGCOAGwXlOwG7ZyzTrKw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s2/HfFp1STMCGjfRVmT9TghHtKYIyn5/t4xVii7URHcqN2qGPtaa0h0AvoowbV5U5pqbiWFFwQ36taeAgaZZhHy24dr60MY1P0/GvEpPbHGd3RIqvn9Qm9SzDntrrdQicSrZX/edrBoX8syG6Hm1E1RfZnitEE1ci3J8K8rlbHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=YIk7KV8q; arc=none smtp.client-ip=95.215.58.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="YIk7KV8q"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=wf0CHBw4cKiVlJ/wkHP2hlDYGCOAGwXlOwG7ZyzTrKw=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790132858; v=1; x=1790737658;
 b=YIk7KV8qfRDcd4VYApLtQEIzSYKCU2RhRAsQ5AynTChti6tWgRD+DVmiVSrpdiKvFHhqgodN
 r8BSZNdcLyjqxbPlIqTGmzRcdGz16r28Tzdlp2bniRO0u73tpyijCD6Dl247ymGoG4/44j1Flyx
 iedI3zjBaZkg+1GqA5jMGhUQ=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 062157555e449c9e;
	Wed, 23 Sep 2026 03:07:38 +0000
X-Mizu-Trace-ID: 062157555e449c9e
X-Migadu-Flow: FLOW_OUT
Message-ID: <e2905d50-0afd-49a3-818a-681bbd665f84@linux.dev>
Date: Tue, 22 Sep 2026 20:07:35 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v4 04/20] bpf: Prepare for an exception cleanup
 table before the CFG walk
Content-Language: en-GB
To: Eduard Zingerman <eddyz87@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com
References: <20260921210033.1715000-1-yonghong.song@linux.dev>
 <20260921210053.1717603-1-yonghong.song@linux.dev>
 <8fd3e980749f4a5ac10ff5d3d1704e42c1bda643.camel@gmail.com>
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <8fd3e980749f4a5ac10ff5d3d1704e42c1bda643.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 9/22/26 11:27 AM, Eduard Zingerman wrote:
> On Mon, 2026-09-21 at 14:00 -0700, Yonghong Song wrote:
>> Some plumbing work is done before bpf_check_cfg(). More specifically,
>> insn_aux_data records cleanup_throw_site for every bpf_throw() and
>> cleanup_resume_site for every bpf_unwind_resume() -- the two calls a JIT
>> lowers its own way rather than as calls -- and cleanup_pad, the landing pad
>> a frame resumes at, for every call within the [begin_off, end_off) range of
>> a cleanup record. Subsequent commits consume all three.
>>
>> Marking the two calls here, rather than recognising them in the JIT, is
>> what makes the recognition exact: by the time a JIT runs,
>> bpf_fixup_kfunc_call() has rewritten every other kfunc's imm into an offset
>> from __bpf_call_base, and a BTF id compared against one of those offsets
>> could match an unrelated call.
>>
>> bpf_prepare_cleanup_exceptions() runs before bpf_check_cfg(), because what
>> it produces is what the CFG walk consumes. It refuses a table on an
>> offloaded program, on a program whose JIT cannot dispatch landing pads or
>> which the JIT was not asked to compile, and on a program that also installs
>> an exception callback -- two different answers to what runs on the way out.
>> bpf_jit_supports_cleanup_pads() is weak here and says no; the arch patches
>> provide the real ones.
>>
>> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
>> ---
> Acked-by: Eduard Zingerman <eddyz87@gmail.com>
>
> Just a few nits.
>
> ...
>
>> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
>> index 325a80ffcbe2..fdee9da6b45d 100644
>> --- a/include/linux/bpf_verifier.h
>> +++ b/include/linux/bpf_verifier.h
>> @@ -686,6 +686,8 @@ struct bpf_insn_aux_data {
>>   	bool needs_zext; /* alu op needs to clear upper bits */
>>   	bool non_sleepable; /* helper/kfunc may be called from non-sleepable context */
>>   	bool is_iter_next; /* bpf_iter_<type>_next() kfunc call */
>> +	bool cleanup_throw_site; /* call to bpf_throw() */
>> +	bool cleanup_resume_site; /* call to bpf_unwind_resume() */
> Nit: There are 12 bools here now, followed by a 25 bits hole,
>       let's move `orig_idx` before or after flags and convert
>       all the flags to bit fields. I think it can reduce the structure
>       size from 144 to 136 bytes.

I will make these bool as bitfield to reduce the struct size.

>       Also, why not simply `throw_call` and `resume_call`?

Will do.

>
>>   	bool call_with_percpu_alloc_ptr; /* {this,per}_cpu_ptr() with prog percpu alloc */
>>   	u8 alu_state; /* used in combination with alu_limit */
>>   	/* true if STX or LDX instruction is a part of a spill/fill
> ...
>
>> diff --git a/kernel/bpf/exception.c b/kernel/bpf/exception.c
>> index 4b3ac93e98c1..67af78baa558 100644
>> --- a/kernel/bpf/exception.c
>> +++ b/kernel/bpf/exception.c
>> @@ -18,6 +18,66 @@ static bool insn_is_unwind_resume(const struct bpf_insn *insn)
>>   	       insn->imm == bpf_unwind_resume_id[0];
>>   }
>>   
>> +static void cleanup_mark_kfunc_sites(struct bpf_verifier_env *env)
> Nit: the 'cleanup_' prefix in function names triggers me a bit,
>       as it is usually used when there are some cleanup actions are
>       taken by the function. Maybe drop or reword it a bit?

Yes, I will try to avoid cleanup_ prefix then. For static functions,
I will not have cleanup_ prefix or may use exc_ prefix.
For global function, I will bpf_cleanup_ as prefix.

>
>> +{
>> +	u32 i;
>> +
>> +	for (i = 0; i < env->prog->len; i++) {
>> +		struct bpf_insn *insn = &env->prog->insnsi[i];
>> +
>> +		if (bpf_is_throw_kfunc(insn))
>> +			env->insn_aux_data[i].cleanup_throw_site = true;
>> +		else if (insn_is_unwind_resume(insn))
>> +			env->insn_aux_data[i].cleanup_resume_site = true;
>> +	}
>> +}
> ...

