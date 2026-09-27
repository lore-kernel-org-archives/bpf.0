Received: from mta1.migadu.com (out-216.mta1.migadu.com [95.215.58.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 155D9215075
	for <bpf@vger.kernel.org>; Sun, 27 Sep 2026 03:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790478427; cv=none; b=oYMXrjOzO2WobXo9n38xu1cOXrlMcsr6yLnqzUVHbQL14bxJKFlFZlua0oULNEbbMBkxHWjjJFhYibbKwfdKHPexOmz079P52eF/ayU4dVqNQFj2h2ORQJBSqlcNuz3FdJJaanjsa6gJQ2zO9XpzReFstMb7tAnXch+Jaxbg5Ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790478427; c=relaxed/simple;
	bh=aSsCkNVBzts7NVFFSDZCGGuI3H8CXU9IKpaXzGylRAo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FKyQUmerrO76EYZ4mlP9cJ66PKdhx/p85lxOhAn5SejxcxGDXU5GdsqdaMVaYh86h4+r2q5hMMaO7Ny0AM2LVChpRWdNVoq/NfzTI99AzFn1Gd2LjvOCt6alfUsaW9OhBnqNIYPMtGu4QE8FXTGPwCrYU+t00m0lsDa9MPszoEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=RbKjZkT8; arc=none smtp.client-ip=95.215.58.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="RbKjZkT8"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=aSsCkNVBzts7NVFFSDZCGGuI3H8CXU9IKpaXzGylRAo=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790478421; v=1; x=1791083221;
 b=RbKjZkT8Ea93SkwMrZpPpKpHL3wuZdehUL2jqNlMtfyNGHJ15v/C/s1HnzmOt8dzLn8pG54d
 QvqietoiOPq4JqirSfTEhhLACA+HOW4Vy3s+Litou1JNrGqX04H/pLYsZGOTBnzNhy2cQ0k/i4s
 6kJXc0L5ICXyZtRXsXMA5sWI=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id d2f0a114ac974d92;
	Sun, 27 Sep 2026 03:07:01 +0000
X-Mizu-Trace-ID: d2f0a114ac974d92
X-Migadu-Flow: FLOW_OUT
Message-ID: <dd286a79-f423-4bcd-9e81-5babb25d572a@linux.dev>
Date: Sat, 26 Sep 2026 20:06:58 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v6 08/21] bpf: Refuse a landing pad that does not
 resume
Content-Language: en-GB
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
References: <20260926050006.2213110-1-yonghong.song@linux.dev>
 <20260926050047.2216836-1-yonghong.song@linux.dev>
 <20260926051719.48E4B1F00893@smtp.kernel.org>
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20260926051719.48E4B1F00893@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 9/25/26 10:17 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 3 potential issue(s) to consider:
> - [Critical] bpf: bpf_unwind bypasses resource leak checks when no landing pad is present
> - [High] bpf: bpf_unwind_resume creates invalid ghost paths by returning to caller's normal path
> - [Medium] bpf: Speculative branches to landing pads bypass nospec recovery
> --
>
> commit 3aafeed4814ca53533c421881eb0f30857cc42a0
> Author: Yonghong Song <yonghong.song@linux.dev>
> Subject: bpf: Refuse a landing pad that does not resume
>
> This commit restricts exception landing pads in BPF to only support cleanup
> pads that resume via bpf_unwind_resume(). It adds checks in the verifier
> to ensure that instructions are not reached both inside and outside a pad,
> and it refuses unsupported program exits within a pad.
>
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
>> @@ -19197,6 +19202,7 @@ static int process_bpf_unwind(struct bpf_verifier_env *env, int *insn_idx)
>>   	int pad = bpf_exc_pad_of_call(env, *insn_idx);
>>   
>>   	if (pad < 0)
>>   		return PROCESS_BPF_EXIT;
> [Severity: Critical]
> Does this early return in process_bpf_unwind() bypass resource leak checks?
>
> If a program acquires a resource like a bpf_spin_lock and throws an
> exception where there is no landing pad, it appears this directs the verifier
> to pop the state without calling check_resource_leak(), allowing the
> program to leak the lock at runtime.

This issue is covered in previous patch. Indeed, check_resource_leak()
is needed.

>
> [ ... ]
>
>> @@ -19450,6 +19461,7 @@ static int do_check_insn(struct bpf_verifier_env *env, bool *do_print_state)
>>   				 */
>>   				mark_reg_unknown(env, cur_regs(env), BPF_REG_0);
>>   				mark_reg_known_zero(env, cur_regs(env), BPF_REG_0);
>> +				cur_func(env)->in_pad = false;
>>   				return process_bpf_exit_full(env, do_print_state, false);
> [Severity: High]
> Could passing false to process_bpf_exit_full() here instruct the verifier to
> continue at the callsite's normal return path instead of unwinding to the
> caller's landing pad?

The above code is under branch:
	if (bpf_is_unwind_resume_kfunc(insn)) {
		...
                 mark_reg_unknown(env, cur_regs(env), BPF_REG_0);
                 mark_reg_known_zero(env, cur_regs(env), BPF_REG_0);
                 return process_bpf_exit_full(env, do_print_state, false);		
	}
So control is ready to return to either bpf prog (including main) or
exit the prog itself. This one (cur_func(env)->in_pad = false)
is irrelevant.

>
> Because push_cleanup_pad_branch() eagerly pushed the caller's landing pad
> with the pre-call state, returning to the normal success path might merge
> the post-cleanup state incorrectly and cause a divergence between verifier
> control flow and runtime execution.

This is possible. This is addressed in previous commit. The idea is
the state (related to resources) at the beginning of the function
must be the same as when bpf_unwind_resume() does resource checking.

>
>>   			}
> [ ... ]
>
>> @@ -19578,6 +19590,12 @@ static int do_check(struct bpf_verifier_env *env)
>>   			}
>>   		}
>>   
>> +		if (unlikely(env->cleanup_info_cnt)) {
>> +			err = bpf_exc_check_insn(env, insn);
>> +			if (err)
>> +				return err;
> [Severity: Medium]
> When do_check() returns an error from bpf_exc_check_insn() due to a
> speculative visit to a landing pad, does it bypass the subsequent
> error_recoverable_with_nospec() check entirely?
>
> If the verifier speculatively explores a dead branch targeting a landing pad,
> this might cause the verifier to fatally abort instead of properly recovering
> by inserting a speculation barrier.
>
Yes, error_recoverable_with_nospec() should help to resolve the issue.

>> +		}
>> +

