Received: from mta0.migadu.com (out-106.mta0.migadu.com [91.218.175.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E08672F691D
	for <bpf@vger.kernel.org>; Tue, 22 Sep 2026 03:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790047878; cv=none; b=PKUAm+0UPKWHT+tCIL/bjo+tBw1wbg0wYkupD972D66Egq95Fz89EE77dTPBAHVQICKYfZZnkF9TM6ALwJ960hqjezzBpEiFwnmojfiHxX0OkZJkUooGONhAiWprq3xW0tX7gdTY45u3dgCRoOVCvWKqFXrw7mp6RvuSJPSmua0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790047878; c=relaxed/simple;
	bh=GJEVAnQb2NU7oziu9tvIJH9KLjoutTY5ghGGc1XkzrU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AtCu2GjP+vsBF9+MtdF0zsYP3Igz8iw0j3X6Tgj6jGe5DQiut3IFs3WkfffIFaQKkehcMw2N8Mg1ZBuA5D9tYvn7vhIuAMQp6kQN3gi01VjwHQkL2WLXpSjKtWD1i0DCCFQRk20WBiDlqZeizZPMXqZMypY7RzTd1BKCBAKzBbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=oluowWvg; arc=none smtp.client-ip=91.218.175.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="oluowWvg"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=GJEVAnQb2NU7oziu9tvIJH9KLjoutTY5ghGGc1XkzrU=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790047865; v=1; x=1790652665;
 b=oluowWvgguLrFsszR/8hKiFhXFGCe0BzzrQwwsOB5jmxc7twb6a2JvBwprlpBAbuI5J5imip
 Ep+hXkSIdbMkFOtfgZMiqXvHopZ4hGgub9RiyEGt1VzrhrWliVxWgeO5xA/nMkvgh0MakNbj3I6
 RlTi4EfPcp8DB8MrtXXrY5Sg=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 9dd5d47682f9f508;
	Tue, 22 Sep 2026 03:31:05 +0000
X-Mizu-Trace-ID: 9dd5d47682f9f508
X-Migadu-Flow: FLOW_OUT
Message-ID: <1aaa4005-1b58-494f-9096-2e755af67a42@linux.dev>
Date: Mon, 21 Sep 2026 20:31:00 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v4 02/20] bpf: Add the bpf_unwind_resume() kfunc
Content-Language: en-GB
To: bot+bpf-ci@kernel.org, bpf@vger.kernel.org
Cc: ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
 eddyz87@gmail.com, kernel-team@fb.com, martin.lau@kernel.org,
 mason@kernel.org, ihor.solodrai@linux.dev
References: <20260921210043.1715958-1-yonghong.song@linux.dev>
 <7a3a8b5ec143ca475962d1842d00ec33e41910f570925704d202f50bd375113e@mail.kernel.org>
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <7a3a8b5ec143ca475962d1842d00ec33e41910f570925704d202f50bd375113e@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 9/21/26 2:56 PM, bot+bpf-ci@kernel.org wrote:
>> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
>> index 501c7ce35cba..55c59f8b4c43 100644
>> --- a/kernel/bpf/helpers.c
>> +++ b/kernel/bpf/helpers.c
>> @@ -3445,6 +3445,19 @@ __bpf_kfunc void bpf_throw(u64 cookie)
>>   	WARN(1, "A call to BPF exception callback should never return\n");
>>   }
>>
>> +/*
>> + * Terminator of a compiler-emitted cleanup landing pad. The compiler names
>> + * this _Unwind_Resume, the base unwind ABI's entry point for carrying an
>> + * unwind on once a frame's cleanups have run. To match kernel kfunc
>> + * convention, the kernel calls it bpf_unwind_resume and libbpf maps the
>> + * compiler's name onto it.
>> + */
>> +__bpf_kfunc void bpf_unwind_resume(void)
>> +{
>> +	/* Never reached: a JIT emits the way out of a landing pad instead. */
>> +	WARN_ONCE(1, "A JIT should have replaced the exception cleanup resume\n");
>> +}
>> +
> Does this WARN become reachable at this commit?
>
> The kfunc is registered for BPF_PROG_TYPE_TRACING, BPF_PROG_TYPE_SCHED_CLS,
> BPF_PROG_TYPE_XDP, BPF_PROG_TYPE_STRUCT_OPS, BPF_PROG_TYPE_SYSCALL and
> BPF_PROG_TYPE_CGROUP_SKB via generic_kfunc_set in kfunc_init().
>
> A program of any of those types can emit a plain call to bpf_unwind_resume
> and load, since there appears to be no verifier handling for the kfunc at
> this commit. Searching for 'unwind_resume' at 53430aa9b73a in kernel/bpf/
> and include/linux/ returns only the two lines this patch adds.
> bpf_is_unwind_resume_kfunc(), kernel/bpf/exception.c, and
> process_cleanup_resume() do not exist yet.
>
> No JIT lowers the call at this commit either. bpf_jit_supports_cleanup_pads()
> and the x86/arm64 dispatch land later in the series (eeb1e94ae895,
> 3240611f5542). So the call really does reach the C function.
>
> Running such a program, for example a BPF_PROG_TYPE_SYSCALL program via
> BPF_PROG_TEST_RUN (which needs only CAP_BPF), would produce a WARN splat
> and panic the box on panic_on_warn=1.
>
> Contrast this with the neighbouring bpf_throw(), whose WARNs are
> unreachable because check_kfunc_call() gates it in kernel/bpf/verifier.c:
>
> 	if (meta.func_id == special_kfunc_list[KF_bpf_throw]) {
> 		if (!bpf_jit_supports_exceptions()) {
> 			verbose(env, "JIT does not support calling kfunc %s#%d\n", ...);
> 			return -ENOTSUPP;
> 		}
> 		env->seen_exception = true;
> 		...
> 	}
>
> The rest of the series does eventually add the equivalent gates.
> cleanup_check_resumes() rejects "bpf_unwind_resume() at insn %u is not
> in an exception cleanup landing pad" and process_cleanup_resume() rejects
> "bpf_unwind_resume() at insn %d reached without an exception in flight,"
> but they are not in this commit. For the 17 commits between this one and
> the end of the series, the WARN is reachable.
>
> Since the gating mechanism is known and exists later, should the kfunc
> registration be deferred until the verifier check is in place? Or should
> this commit carry a minimal check_kfunc_call() rejection of the call
> (as bpf_throw does) rather than relying on a JIT that does not exist yet?

Okay, let us remove below:
     BTF_ID_FLAGS(func, bpf_unwind_resume)
so bpf_unwind_resume() can still be used in the code, but actually it
will be used at runtime much later.

>
>> @@ -4981,6 +4994,7 @@ BTF_ID_FLAGS(func, bpf_task_get_cgroup1, KF_ACQUIRE | KF_RCU | KF_RET_NULL)
>>   BTF_ID_FLAGS(func, bpf_task_from_pid, KF_ACQUIRE | KF_RET_NULL)
>>   BTF_ID_FLAGS(func, bpf_task_from_vpid, KF_ACQUIRE | KF_RET_NULL)
>>   BTF_ID_FLAGS(func, bpf_throw)
>> +BTF_ID_FLAGS(func, bpf_unwind_resume)
>>   #ifdef CONFIG_BPF_EVENTS
>>   BTF_ID_FLAGS(func, bpf_send_signal_task)
>>   #endif
>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/35656368472

