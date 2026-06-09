Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEB0927A476
	for <bpf@vger.kernel.org>; Tue,  9 Jun 2026 01:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780967916; cv=none; b=gDsEUrgwzr2a9H0LI0VaY1m3O0bY0DgzAvmaescOZMzxVyLsN3+TyKfVnByCgP3jAHIY76V91W8mri2+Mxzp/fIjg3KhYanuQgXSROCKavc3H/6gRG6NXiOm8R7V6qa0oigZrqdWsSoLhroo7aquLPorupGK9p3oIFsXrGrAFTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780967916; c=relaxed/simple;
	bh=sGK3hwn2qHPcZkjRJJf8rBVN85/E5VCFDjzm/xk9mwo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NonF9qIWaUSTA7EIW9RvRDqeVXHEGUozmMvgQrNZeawRxCUnyywMfgSUpyA5gG4anvzCiYCW/tqTcvPRBlk/YocykPeSHQ3zatA1dGng5bn1JVxp3E6htyBzDBsDxefi2IOryz31jMRCHB1F9khs0o6sVI0aa7MmoU7a2S2qcW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=NVZjn09p; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="NVZjn09p"
Message-ID: <118b0bc7-5126-465d-993c-3b25e331e2cf@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780967912;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=D8KMExNi2wmjBe7v5rMlIf0mRJBDL+8crWsrdtMEV2Q=;
	b=NVZjn09p98DmFNJ8/W+u+koK0uPZNFT0uz96otWrLWchtYjZVJlr1Zt7E2gKNCpHWPgK/k
	pS8cMM6sLseSs3N4IK8WUTLoIVRP1b0Nf9BM76zmx9yDgDV8YchrItWhDTr/4so48rmQWs
	9SYc4CJ4ekRPmBvpsGpBxwIoDMJ8uLU=
Date: Mon, 8 Jun 2026 18:18:24 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf v5 1/2] bpf: Fix kfunc implicit arg inject type
 detection to prevent invalid pointer deref
To: Eduard Zingerman <eddyz87@gmail.com>, chenyuan_fl@163.com
Cc: andrii@kernel.org, ast@kernel.org, bot+bpf-ci@kernel.org,
 bpf@vger.kernel.org, chenyuan@kylinos.cn, clm@meta.com,
 daniel@iogearbox.net, jolsa@kernel.org, linux-kernel@vger.kernel.org,
 martin.lau@kernel.org, martin.lau@linux.dev, memxor@gmail.com,
 song@kernel.org, yonghong.song@linux.dev
References: <20260602093836.2632714-1-chenyuan_fl@163.com>
 <20260608142618.3064380-1-chenyuan_fl@163.com>
 <20260608142618.3064380-2-chenyuan_fl@163.com>
 <eab4e479-2023-49b8-9915-1c8ef2356837@linux.dev>
 <49c36dc0f52bd05d0f8c055e3d3e96992ae716a6.camel@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <49c36dc0f52bd05d0f8c055e3d3e96992ae716a6.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 6/8/26 6:00 PM, Eduard Zingerman wrote:
> On Mon, 2026-06-08 at 17:54 -0700, Ihor Solodrai wrote:
>> On 6/8/26 7:26 AM, chenyuan_fl@163.com wrote:
>>> From: Yuan Chen <chenyuan@kylinos.cn>
>>>
>>> When a module kfunc declares an implicit struct bpf_prog_aux * argument,
>>> the verifier must identify it so the kernel injects env->prog->aux into
>>> the correct register at runtime.  The original check used
>>> is_kfunc_arg_prog_aux() which calls btf_types_are_same() to compare the
>>> module BTF type against vmlinux.
>>>
>>> Root Cause
>>>
>>> This issue was triggered by pahole 1.30 generating module BTF with
>>> incorrect type information, which caused the kernel's distilled base
>>> BTF deduplication for modules to fail.  As a result, the module retained
>>> its own copy of struct bpf_prog_aux with a different BTF ID than
>>> vmlinux's definition.  While pahole 1.31 fixed the BTF generation issue,
>>> the kernel must be robust against such inconsistencies: a BTF mismatch
>>> should result in a clean rejection, not a kernel crash or information
>>> disclosure.
>>>
>>> When the distilled base dedup fails and btf_types_are_same() cannot
>>> match the module's bpf_prog_aux type against vmlinux's,
>>> is_kfunc_arg_prog_aux() returned false and the code fell through
>>> silently without setting arg_prog.  The kfunc then received whatever
>>> value was in the argument register and dereferenced it as a
>>> bpf_prog_aux pointer, leading to:
>>>
>>>   BUG: kernel invalid pointer dereference, address: 00000000000009e2
>>>   RIP: bpf_prog_get_assoc_struct_ops+0xa/0xc0
>>>   RDI: 0x000000000000046d (stale register value)
>>>
>>> In the observed crash the stale value was the process PID, causing a
>>> dereference within the unmapped NULL page.  However, an attacker able
>>> to control the register value -- for example by writing a BPF program
>>> that explicitly sets R2 before calling a KF_IMPLICIT_ARGS kfunc --
>>> could redirect the dereference to arbitrary kernel memory, turning
>>> this into an information disclosure.  The fix ensures the verifier
>>> either validates and injects the correct bpf_prog_aux pointer, or
>>> rejects the program outright -- no silent fallthrough that could
>>> be exploited.
>>>
>>> Crash Stack Trace
>>>
>>>   PID: 1133     TASK: ffff8881057d3900  CPU: 3    COMMAND: "test_progs"
>>>    #0 machine_kexec at ffffffff812f6e26
>>>    #1 __crash_kexec at ffffffff8145a788
>>>    #2 crash_kexec at ffffffff8145ac24
>>>    #3 oops_end at ffffffff812bb67c
>>>    #4 page_fault_oops at ffffffff813053a1
>>>    #5 exc_page_fault at ffffffff828e60a1
>>>    #6 asm_exc_page_fault at ffffffff810012a6
>>>       [exception RIP: bpf_prog_get_assoc_struct_ops+10]
>>>       RIP: ffffffff815c024a  RSP: ffffc90001b57e48  RFLAGS: 00010283
>>>       RAX: ffff8881057d3900  RBX: ffffc90001b57e68  RCX: ffff8881057d3900
>>>       RDX: 0000607d4d1768b8  RSI: 000000000000046d  RDI: 000000000000046d
>>>    #7 bpf_kfunc_multi_st_ops_test_1_assoc at ffffffffc0013a85 [bpf_testmod]
>>>    #8 bpf_trace_run2 at ffffffff814f8332
>>>    #9 __traceiter_sys_enter at ffffffff81415f45
>>>   #10 trace_syscall_enter at ffffffff81416735
>>>   #11 do_syscall_64 at ffffffff828e06a1
>>>
>>> Fix
>>>
>>> Split the combined is_kfunc_arg_ignore() || is_kfunc_arg_implicit()
>>> check in check_kfunc_args() so that an implicit argument reaching
>>> is_kfunc_arg_implicit() without being handled by a prior handler is
>>> rejected with -EFAULT, instead of silently skipped.  Existing implicit
>>>       args in bpf_fixup_kfunc_call() (obj_new, percpu_obj_new, obj_drop,
>>>       percpu_obj_drop, refcount_acquire, list_push, rbtree_add) are
>>>       explicitly allowed.
>>>
>>> Suggested-by: Eduard Zingerman <eddyz87@gmail.com>
>>> Fixes: 64e1360524b9 ("bpf: Verifier support for KF_IMPLICIT_ARGS")
>>> Signed-off-by: Yuan Chen <chenyuan@kylinos.cn>
>>> ---
>>>  kernel/bpf/verifier.c | 20 +++++++++++++++++++-
>>>  1 file changed, 19 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>>> index 8ed484cb1a8a..91aaed7a5eeb 100644
>>> --- a/kernel/bpf/verifier.c
>>> +++ b/kernel/bpf/verifier.c
>>> @@ -11885,9 +11885,27 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
>>>  			continue;
>>>  		}
>>>  
>>> -		if (is_kfunc_arg_ignore(btf, &args[i]) || is_kfunc_arg_implicit(meta, i))
>>> +		if (is_kfunc_arg_ignore(btf, &args[i]))
>>>  			continue;
>>>  
>>> +		if (is_kfunc_arg_implicit(meta, i)) {
>>> +			/* kfuncs with implicit args (e.g. 'off' parameter)
>>> +			 * handled during verification in bpf_fixup_kfunc_call():
>>> +			 * obj_new, percpu_obj_new, obj_drop, percpu_obj_drop,
>>> +			 * refcount_acquire, list_push, rbtree_add. Don't flag them. */
>>> +			if (is_bpf_obj_new_kfunc(meta->func_id) ||
>>> +			    is_bpf_percpu_obj_new_kfunc(meta->func_id) ||
>>> +			    is_bpf_obj_drop_kfunc(meta->func_id) ||
>>> +			    is_bpf_percpu_obj_drop_kfunc(meta->func_id) ||
>>> +			    is_bpf_refcount_acquire_kfunc(meta->func_id) ||
>>> +			    is_bpf_list_push_kfunc(meta->func_id) ||
>>> +			    is_bpf_rbtree_add_kfunc(meta->func_id))
>>
>> Is the goal here to have a nice error message?
>>
>> I think this will fail for other functions like bpf_wq_set_callback().
>> For a proper check, the list must include every single kfunc with KF_IMPLICIT_ARGS, no?
>>
>> If we go this route, then the list of flagged kfuncs can be collected automatically.
>> I'm not sure we actually want to do this.
> 
> The calls to functions with implicit arguments are patched by
> bpf_fixup_kfunc_call(). As far as I understand, this function:
> - handles functions with implicit bpf_prog_aux generically
> - handles the functions listed above on a case-by-case basis.
> 
> The goal is not to have a nice error message, but to prevent runtime
> from reading garbage from a register.

In check_kfunc_args() we only needed to know whether the arg is implicit,
independent of its type, which is_kfunc_arg_implicit() already does. To skip it.

For vmlinux kernel kfuncs this should be enough, I think.

To properly harden against reading garbage for a *module* kfunc, I think the 
verifier would have to check for the specific BTF type, e.g. "are we patching a 
struct bpf_prog_aux pointer?".

It could be done immediately before patching, but at that point the verification is
complete, right?..

Other than that we'd have to somehow pass through from check_kfunc_args() to
bpf_fixup_kfunc_call() information like "arg 1 of this kfunc can be patched to prog_aux" etc.
We sort of do that already with the meta->arg_prog = true

In a module one can define arbitrary kfuncs and add KF_IMPLICIT_ARGS to them, so
proper hardening needs to be generic.

I think this boils down to whether we want to error-check module kfuncs or not.
Not sure what the verifier strategy is here, but my understanding is that in general
a custom module can easily make kernel read garbage, and it's not a kernel's problem.

> 
>>
>>> +				continue;
>>> +			verbose(env, "%s unrecognized implicit argument, possible BTF mismatch\n",
>>> +				reg_arg_name(env, argno));
>>> +			return -EFAULT;
>>> +		}
>>> +
>>>  		t = btf_type_skip_modifiers(btf, args[i].type, NULL);
>>>  
>>>  		if (btf_type_is_scalar(t)) {

