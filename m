Received: from mta1.migadu.com (out-31.mta1.migadu.com [95.215.58.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A41D44CF49C
	for <bpf@vger.kernel.org>; Sat, 17 Oct 2026 05:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.31
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792215526; cv=none; b=mO2epbMxuBSv/NcCjd2arCaLejYbiz8vAkCt326XvwJtCHyIpvfmN37ae9rmwPEHU9wYT9Kaav91xd8qWt9sjLslmVP8G/s5HbOiaJl1Wbdh4MNHh8w4molsS5edF8w7Wm3kJpsWB9e28+z36gmlSHZUdypvTiSPgMsK/s8Tkqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792215526; c=relaxed/simple;
	bh=/MMgUEomUt3Slmm0K00jtTvAyfsiXxPh+UVR6CCYvb4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TX4iIm+iTzzA3xsD2Shv6zCikRpas16HFJ4iX+0U5DzYIolRTo7Y/cxW0MukZdEA47bAHwYdvbM3m0wbRRUKUuYW73E7cJW95xjA+052iKF1SKRUXnKvbnu1V4RJDEQ+LvfpZuROOzhudKpRGjSmMJ+JjqU1vOmRtB0+u8Dk8Eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=q9Pj5HU2; arc=none smtp.client-ip=95.215.58.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="q9Pj5HU2"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=/MMgUEomUt3Slmm0K00jtTvAyfsiXxPh+UVR6CCYvb4=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792215522; v=1; x=1792820322;
 b=q9Pj5HU2WCMBo8Pmqis0vWJAoQYF9vJu1IlNihsyRZNCtQWKRf5WYnTx20KfbgbyFk6OvOhP
 x4K9Tq1xXAHJj/pLlsgyfz5z3UsB8Y1oJg/ezM0aXcv5l9hz+Nbef3kn9VJ6a6+uvfj5BkgFuwf
 yHNyBqr5IDtM1aezz4szKHd8=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id a8c2c243e1971762;
	Sat, 17 Oct 2026 05:38:42 +0000
X-Mizu-Trace-ID: a8c2c243e1971762
X-Migadu-Flow: FLOW_OUT
Message-ID: <4a7080f0-1b1c-4375-b25b-f5a2dd94bbd1@linux.dev>
Date: Fri, 16 Oct 2026 22:38:38 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v12 12/25] bpf: Allow a subprog to end with a
 call that does not return
To: bot+bpf-ci@kernel.org, bpf@vger.kernel.org
Cc: ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
 eddyz87@gmail.com, kernel-team@fb.com, martin.lau@kernel.org,
 mason@kernel.org, ihor.solodrai@linux.dev
References: <20261017025232.1925266-1-yonghong.song@linux.dev>
 <c0fca81fb0b00da256b581c75751323967d8e48a600694286fea6e46ba8f811a@mail.kernel.org>
Content-Language: en-GB
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <c0fca81fb0b00da256b581c75751323967d8e48a600694286fea6e46ba8f811a@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/16/26 8:35 PM, bot+bpf-ci@kernel.org wrote:
>> bpf: Allow a subprog to end with a call that does not return
> TL;DR: Inserting exits after final calls may shift verifier log instruction
> indices for newly accepted programs, which could make libbpf's CO-RE
> relocation lookup miss or name the wrong field. Was this intended?
>
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
> [ ... ]
>
>> @@ -3317,6 +3317,54 @@ static void find_subprog_properties(struct bpf_verifier_env *env)
>>   	}
>>   }
>>
>> +/*
>> + * Put an exit after a call that ends a subprog, so that nothing from the CFG
>> + * walk on has to know a subprog can end that way. check_subprogs() only lets
>> + * such a call be to a callee that never returns, so do_check() never reaches
>> + * the exit.
>> + */
>> +static int add_exits_after_final_calls(struct bpf_verifier_env *env)
>> +{
> [ ... ]
>
>> +		patch[0] = *insn;
>> +		new_prog = bpf_patch_insn_data(env, last, patch, 2);
>> +		if (!new_prog)
>> +			return -ENOMEM;
>> +		env->prog = new_prog;
>> +		/* The patch moved the call's aux data, orig_idx included, to the exit. */
>> +		env->insn_aux_data[last].orig_idx = env->insn_aux_data[last + 1].orig_idx;
> [ ... ]
>
>> +	}
>> +	return 0;
>> +}
> [ ... ]
>
>> @@ -23661,6 +23718,24 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr,
>>   	if (ret < 0)
>>   		goto skip_full_check;
>>
>> +	/*
>> +	 * After everything above has recorded insn offsets, so the patch
>> +	 * adjusts them, and before an offloaded program's per-insn state.
>> +	 */
>> +	ret = add_exits_after_final_calls(env);
>> +	if (ret < 0)
>> +		goto skip_full_check;
>> +
> Does inserting these exits before bpf_check_cfg() and do_check() shift the
> instruction indices that the verifier log reports?

I think this is indeed an issue, esp. for verifier log reporting.

For example, the original function:
    0: call foo
    1: call bpf_unwind
    2: call bpf_unwind_resume

After add_exits_after_final_calls, we will have
    idx  orig_idx
    0    0         call foo
    1    1         bpf_unwind
    2    1         exit
    3    2         call bpf_unwind_resume
    4    2         exit

When verifier trying to report error message, we cannot use 'idx'
any more, we have to use orig_idx. For example, we have
    verbose_linfo(env, env->insn_idx, "; ");
    ...
    verbose(env, "%d: ", env->insn_idx);

here env->insn_idx refers to 'idx' in the above,
but they do not correspond to the original idx.

The actual one may be replacing env->insn_idx to corresponding
orig_idx.

We could have a helper to map idx->orig_idx. This should work.
Do we have a better solution for this?

>
> Until now no pass changed the instruction count before verification, so the
> indices in the log matched the instructions user space loaded.  With this
> patch, every insn behind a subprog that ends with a call moves down by one
> for each exit added in front of it.  The CFG walk and do_check() print
> env->insn_idx, so every message about those insns now carries an index that
> is not in the loaded program.  insn_aux_data[].orig_idx exists for this kind
> of mismatch, but only a few messages use it.
>
> This has a concrete effect on libbpf.  fixup_log_failed_core_relo() in
> tools/lib/bpf/libbpf.c reads the index from the log and uses it to find the
> relocation:
>
>      if (sscanf(line1, "%d: (%*d) call unknown#195896080\n", &insn_idx) != 1)
>          return;
>      relo = find_relo_core(prog, insn_idx);
>
> find_relo_core() needs an exact relo->insn_idx match.  Take a program whose
> main subprog ends with "call _Unwind_Resume" (the prog() example in the
> commit message) and that has a poisoned CO-RE relocation at index N in a
> later subprog.  The kernel now logs that instruction as N+1, so libbpf
> either finds no relocation and leaves the raw "unknown#195896080" message,
> or picks up a different CO-RE relocation sitting at N+1 and names the wrong
> field.
>
> The cleanup-record messages are affected as well.  "resume at insn %d is not
> in a landing pad" and "insn %u ... is in a landing pad" now print shifted
> indices, while bpf_exc_check_info() reports the user's own offsets.
>
> Only programs that this patch newly accepts are affected, since
> add_exits_after_final_calls() patches nothing otherwise.  The commit message
> says the exits are put in "before the CFG walk" but does not mention the
> effect on the log indices.
>
> Was this intended?  Would it make sense to report orig_idx in the do_check()
> messages, or to handle a final call without inserting instructions until
> after verification?
>
>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/38997507726

