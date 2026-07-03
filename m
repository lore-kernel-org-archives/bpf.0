Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB344282F3F
	for <bpf@vger.kernel.org>; Fri,  3 Jul 2026 15:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783094187; cv=none; b=Md7egTJf3hJzXmLqnuiXcs/wR7Dh1WbK+rDrYwRN6liFT08ScgUaSD0cSEw45229PfNI0tYKV+Q42ioGUueNlLgWFv7sFQx/cxgwbVnbxn99c6gQLXlB1mfyzRZO6UbFwCct7Fcy6c3dh5R0OBGEFxNT391tJ3OrzKhhzqU4m3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783094187; c=relaxed/simple;
	bh=7sBrm5XyJ0fx2Fu9/C3ULlJ6LHP4USyTXAVDwwD4auU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Tss/nvIFrHxSfeqmjLS3IGX99XIjv7SSfVIIF4keCIZH+75760E1cajbAPfnHFzS7/3f5hNnWp+c0GEtvVb1XfPZ8bZA2Og4SCc2B0e0PgyE/Hm2hXZ/8qfNDOm4Mf5fd6rVnBgHPmCsYzXrjAkIKeWhYvYijDUh1t+dnvjRgs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [36.44.120.111])
	by gateway (Coremail) with SMTP id _____8Dx_+um20dq72IBAA--.6821S3;
	Fri, 03 Jul 2026 23:56:22 +0800 (CST)
Received: from [192.168.0.111] (unknown [36.44.120.111])
	by front1 (Coremail) with SMTP id qMiowJCx_8Kk20dqWTG+AA--.32425S3;
	Fri, 03 Jul 2026 23:56:21 +0800 (CST)
Message-ID: <7d326e51-976c-2962-aa01-a545e2f64259@loongson.cn>
Date: Fri, 3 Jul 2026 23:56:26 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH bpf-next v7 1/2] bpf: Introduce jit_required flag and
 refactor kfunc path
Content-Language: en-US
To: KaFai Wan <kafai.wan@linux.dev>, sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>
References: <20260702143656.28845-1-yangtiezhu@loongson.cn>
 <20260702143656.28845-2-yangtiezhu@loongson.cn>
 <20260702145855.07C6B1F000E9@smtp.kernel.org>
 <7cce1695-eaa2-816b-2877-9cb2f117aa27@loongson.cn>
 <4a0ac2692d2a76ab0479c2bf20dbf26a17636d67.camel@linux.dev>
From: Tiezhu Yang <yangtiezhu@loongson.cn>
In-Reply-To: <4a0ac2692d2a76ab0479c2bf20dbf26a17636d67.camel@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJCx_8Kk20dqWTG+AA--.32425S3
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoWfGFWfCFyfGF45AF13Wry8Zwc_yoWDXF4rpF
	ykJFyjkrW0gr1Fgr17tF47AryUtr1UXw17KrWDJFyFkr4qqFyvqr1UW34a9anIyr48Ga1x
	Zw40qFy7uw1UZFXCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUB2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
	AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
	AVWUtwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI4
	8JMxk0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_
	Jr0_Gr1l4IxYO2xFxVAFwI0_JF0_Jw1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8Gjc
	xK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0
	cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8V
	AvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E
	14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUc0eHDUUUU

On 7/3/26 21:51, KaFai Wan wrote:
> On Fri, 2026-07-03 at 10:57 +0800, Tiezhu Yang wrote:
>> On 2026/7/2 下午10:58, sashiko-bot@kernel.org wrote:
>>> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
>>> - [Medium] The `bpf_fixup_call_args()` function and `bpf_prog_has_kfunc_call()` macro were not
>>> updated to use the new `jit_required` flag, leading to inconsistent interpreter fallback
>>> behavior for pruned kfuncs.
>>> --
>>>
>>> commit 5a3f8861c2b6916fe194f97a407cb7265f545fd0
>>> Author: Tiezhu Yang <yangtiezhu@loongson.cn>
>>>
>>> bpf: Introduce jit_required flag and refactor kfunc path
>>>
>>> Introduce a 'jit_required' bitfield flag at the end of the
>>> flags group in struct bpf_prog. This bit tracks whether a
>>> program strictly requires the JIT compiler.
>>>
>>>> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
>>>> index 649cce41e13f3..5fcd19ccb41a9 100644
>>>> --- a/kernel/bpf/core.c
>>>> +++ b/kernel/bpf/core.c
>>>> @@ -2619,8 +2619,7 @@ struct bpf_prog *__bpf_prog_select_runtime(struct bpf_verifier_env *env,
>>>> struct
>>>>    	if (fp->bpf_func)
>>>>    		goto finalize;
>>>>    
>>>> -	if (IS_ENABLED(CONFIG_BPF_JIT_ALWAYS_ON) ||
>>>> -	    bpf_prog_has_kfunc_call(fp))
>>>> +	if (IS_ENABLED(CONFIG_BPF_JIT_ALWAYS_ON) || fp->jit_required)
>>>>    		jit_needed = true;
>>>>    
>>>>    	if (!bpf_prog_select_interpreter(fp))
>>>
>>> [Severity: Medium]
>>> Since bpf_prog_has_kfunc_call() was replaced here with fp->jit_required,
>>> should bpf_fixup_call_args() in kernel/bpf/fixups.c also be updated to use
>>> the new flag?
>>>
>>> Currently, bpf_fixup_call_args() still calls bpf_prog_has_kfunc_call(). If
>>> a program has a pruned kfunc (allocating kfunc_tab but leaving
>>> jit_required=0) and JIT falls back to the interpreter, wouldn't
>>> bpf_fixup_call_args() incorrectly reject the program with -EINVAL?
>>>
>>> kernel/bpf/fixups.c:bpf_fixup_call_args() {
>>>       ...
>>> 	bool has_kfunc_call = bpf_prog_has_kfunc_call(prog);
>>>       ...
>>> 	if (has_kfunc_call) {
>>> 		verbose(env, "calling kernel functions are not allowed in non-JITed
>>> programs\n");
>>> 		return -EINVAL;
>>> 	}
>>>       ...
>>> }
>>>
>>> Should bpf_prog_has_kfunc_call() in kernel/bpf/verifier.c be updated to
>>> check prog->jit_required, or removed entirely in favor of checking the flag
>>> directly?
>>
>> I think it is wrong to remove bpf_prog_has_kfunc_call() entirely,
> 
> I think it is ok to remove bpf_prog_has_kfunc_call() but with some changes. see below.
> 
>> because using prog->jit_required directly in bpf_fixup_call_args()
>> would cause false positives.
>>
>> I tested the following changes:
>>
>> ```
>> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
>> index 4e2b059d71f3..3a2fc194e2bb 100644
>> --- a/include/linux/bpf.h
>> +++ b/include/linux/bpf.h
>> @@ -3171,7 +3171,6 @@ const struct bpf_func_proto
>> *bpf_base_func_proto(enum bpf_func_id func_id,
>>                                                    const struct bpf_prog
>> *prog);
>>    void bpf_task_storage_free(struct task_struct *task);
>>    void bpf_cgrp_storage_free(struct cgroup *cgroup);
>> -bool bpf_prog_has_kfunc_call(const struct bpf_prog *prog);
>>    const struct btf_func_model *
>>    bpf_jit_find_kfunc_model(const struct bpf_prog *prog,
>>                            const struct bpf_insn *insn);
>> @@ -3510,11 +3509,6 @@ static inline void bpf_task_storage_free(struct
>> task_struct *task)
>>    {
>>    }
>>
>> -static inline bool bpf_prog_has_kfunc_call(const struct bpf_prog *prog)
>> -{
>> -       return false;
>> -}
>> -
>>    static inline const struct btf_func_model *
>>    bpf_jit_find_kfunc_model(const struct bpf_prog *prog,
>>                            const struct bpf_insn *insn)
>> diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
>> index 94e0457a0aa3..7fb92b5fa415 100644
>> --- a/kernel/bpf/fixups.c
>> +++ b/kernel/bpf/fixups.c
>> @@ -1378,7 +1378,6 @@ int bpf_fixup_call_args(struct bpf_verifier_env *env)
>>    #ifndef CONFIG_BPF_JIT_ALWAYS_ON
>>           struct bpf_prog *prog = env->prog;
>>           struct bpf_insn *insn = prog->insnsi;
>> -       bool has_kfunc_call = bpf_prog_has_kfunc_call(prog);
>>           int depth;
>>    #endif
>>           int i, err = 0;
>> @@ -1404,7 +1403,7 @@ int bpf_fixup_call_args(struct bpf_verifier_env *env)
>>                           return err;
>>           }
>>    #ifndef CONFIG_BPF_JIT_ALWAYS_ON
>> -       if (has_kfunc_call) {
>> +       if (prog->jit_required) {
>>                   verbose(env, "calling kernel functions are not allowed
>> in non-JITed programs\n");
> 
> we can change the log for general purpose. patch #2 and future case will hit this too.
> 
>>                   return -EINVAL;
>>           }
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> index f496b45b9da4..3dbed3047254 100644
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
>> @@ -2770,11 +2770,6 @@ int bpf_add_kfunc_call(struct bpf_verifier_env
>> *env, u32 func_id, u16 offset)
>>           return 0;
>>    }
>>
>> -bool bpf_prog_has_kfunc_call(const struct bpf_prog *prog)
>> -{
>> -       return !!prog->aux->kfunc_tab;
>> -}
>> -
>>    static int add_subprog_and_kfunc(struct bpf_verifier_env *env)
>>    {
>>           struct bpf_subprog_info *subprog = env->subprog_info;
>> ```
>>
>> Here is the local test log:
>>
>> ```
>> fedora@linux:~$ cat test_panic.c
>>     #include <linux/bpf.h>
>>     #include <bpf/bpf_helpers.h>
>>
>>     SEC("kprobe/sys_getpid")
>>     int test_panic(void *ctx)
>>     {
>>     	struct task_struct *task;
>>
>>     	task = (struct task_struct *)bpf_get_current_task();
>>     	if (task)
>>     		bpf_printk("Task address: %p\n", task);
>>
>>     	return 0;
>>     }
>>
>>     char LICENSE[] SEC("license") = "GPL";
>> fedora@linux:~$ clang -target bpf -O2 -g -c test_panic.c -o test_panic.o
>> fedora@linux:~$ sudo sysctl -w net.core.bpf_jit_enable=0
>> [sudo] password for fedora:
>> net.core.bpf_jit_enable = 0
>> fedora@linux:~$ sudo bpftool prog load test_panic.o
>> /sys/fs/bpf/test_panic autoattach
>> libbpf: prog 'test_panic': BPF program load failed: Invalid argument
>> libbpf: prog 'test_panic': -- BEGIN PROG LOAD LOG --
>> calling kernel functions are not allowed in non-JITed programs
>> processed 10 insns (limit 1000000) max_states_per_insn 0 total_states 1
>> peak_states 1 mark_read 0
>> -- END PROG LOAD LOG --
>> libbpf: prog 'test_panic': failed to load: -22
>> libbpf: failed to load object 'test_panic.o'
>> Error: failed to load object file
>> ```
>>
>> This change incorrectly rejects programs that only contain normal
>> inlined helper calls with -EINVAL.
> 
> Was it tested after compiling together with patch #2? seems patch #2 works.

Yes.

>>
>> Instead, I think bpf_prog_has_kfunc_call() should be updated to check
>> prog->jit_required, like so:
>>
>> ```
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> index f496b45b9da4..1f5824c1c691 100644
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
>> @@ -2772,7 +2772,7 @@ int bpf_add_kfunc_call(struct bpf_verifier_env
>> *env, u32 func_id, u16 offset)
>>
>>    bool bpf_prog_has_kfunc_call(const struct bpf_prog *prog)
>>    {
>> -       return !!prog->aux->kfunc_tab;
>> +       return prog->jit_required && !!prog->aux->kfunc_tab;
> 
> bpf_get_current_task() is a helper, not kfunc. test_panic has no kfunc, prog->aux->kfunc_tab
> is null. so we get -ENOTSUPP(-524)

Yes, I tested it.

>>    }
>>
>>    static int add_subprog_and_kfunc(struct bpf_verifier_env *env)
>> ```
>>
>> Here is the local test log:
>>
>> ```
>> fedora@linux:~$ cat test_panic.c
>>     #include <linux/bpf.h>
>>     #include <bpf/bpf_helpers.h>
>>
>>     SEC("kprobe/sys_getpid")
>>     int test_panic(void *ctx)
>>     {
>>     	struct task_struct *task;
>>
>>     	task = (struct task_struct *)bpf_get_current_task();
>>     	if (task)
>>     		bpf_printk("Task address: %p\n", task);
>>
>>     	return 0;
>>     }
>>
>>     char LICENSE[] SEC("license") = "GPL";
>> fedora@linux:~$ clang -target bpf -O2 -g -c test_panic.c -o test_panic.o
>> fedora@linux:~$ sudo sysctl -w net.core.bpf_jit_enable=0
>> [sudo] password for fedora:
>> net.core.bpf_jit_enable = 0
>> fedora@linux:~$ sudo bpftool prog load test_panic.o
>> /sys/fs/bpf/test_panic autoattach
>> libbpf: prog 'test_panic': BPF program load failed: unknown error (-524)
>> libbpf: prog 'test_panic': -- BEGIN PROG LOAD LOG --
>> processed 10 insns (limit 1000000) max_states_per_insn 0 total_states 1
>> peak_states 1 mark_read 0
>> -- END PROG LOAD LOG --
>> libbpf: prog 'test_panic': failed to load: -524
>> libbpf: failed to load object 'test_panic.o'
>> Error: failed to load object file
>> ```
>>
>> This ensures that pruned kfuncs (allocating kfunc_tab but leaving
>> jit_required=0) safely return false, at the same time, this check
>> perfectly isolates normal inlined helper paths.
> 
> pruned kfuncs well handled in patch [1], see details in check_kfunc_call() and fixup_kfunc_call().
> 
> [1] https://lore.kernel.org/bpf/20211002011757.311265-3-memxor@gmail.com/
>>
>> Let me wait for more review comments and will send v8 next week.

Thanks,
Tiezhu

