Received: from mta0.migadu.com (out-78.mta0.migadu.com [91.218.175.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D12F343D91
	for <bpf@vger.kernel.org>; Sat, 22 Aug 2026 18:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787423280; cv=none; b=P/0ZIJsanNownaxS+yBpjFV5F8lE5j8kTczjZIrvOH2ig4c8kid+EhhMYt6UCPy7g4zqduIeBv4jJ1LEmAsDObp/SklwID00e48mBWeUCANsSLL29rOtdT2wlzU+ApcBlAmlaG/Ah3CpKqw5XIXuA/6DQiRRqzguNsZIl8aCLcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787423280; c=relaxed/simple;
	bh=thd4YQftP12yCx6TE0t6pWFFKHfj668R34Wjtwuo9W0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aq75Uxcr8xE4EgwSQ/HbapV7KV0ztcx3mPyTiENw17LuFLJDopr8aGLERkoIp+PTVLgkntpkLr+eUUEc9ir9dExQy3x77tb1Ji0N1kiDpsVxyxv+neVsMAvVnSk3qThoNcBw5+KrmkOQ1YoWbEoOzU0hZbJkWx9do5fBThsm34s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=KeJYl3x4; arc=none smtp.client-ip=91.218.175.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="KeJYl3x4"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=thd4YQftP12yCx6TE0t6pWFFKHfj668R34Wjtwuo9W0=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787423276; v=1; x=1788028076;
 b=KeJYl3x4kBTEd+OHuoR+a2dmWpAyGyCHi6u9Rpd2grdKXhKYCvijuormIdVbZN6EPy4UYFXC
 M466g7t0WvAVA6o2XwH2mxXabfy6CSacEIo3VOMQFRkoeV73crPGE3SNpy9jMkza5r7IKJlCbQS
 jTzOzqDsixweLiLak6YwCegA=
X-Envelope-To: bpf@vger.kernel.org
Received: from [IPV6:2600:381:d619:d1ec:8d3:1358:3a33:c2e4] (2600:381:d619:d1ec:8d3:1358:3a33:c2e4)
	by smtp.migadu.com with ESMTPS id 7035a39f906b7eac;
	Sat, 22 Aug 2026 18:27:46 +0000
X-Mizu-Trace-ID: 7035a39f906b7eac
X-Migadu-Flow: FLOW_OUT
Message-ID: <e2a7e092-df3c-4f92-8f12-5eb371f004df@linux.dev>
Date: Sat, 22 Aug 2026 11:27:38 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] bpf: reject stack-argument callback subprograms
Content-Language: en-GB
To: Eduard Zingerman <eddyz87@gmail.com>,
 =?UTF-8?B?SsOpcsOpbXkgSmVhbg==?= <Jeremy.Jean@oss.cyber.gouv.fr>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <20260817204812.1637171-1-Jeremy.Jean@oss.cyber.gouv.fr>
 <20260817204812.1637171-2-Jeremy.Jean@oss.cyber.gouv.fr>
 <5d02cbe3-fd71-44e4-a6dd-706233ba248e@linux.dev>
 <9f50810d45db0b60248f106d21b4a278f3ec2156.camel@gmail.com>
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <9f50810d45db0b60248f106d21b4a278f3ec2156.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 8/20/26 3:32 PM, Eduard Zingerman wrote:
> On Tue, 2026-08-18 at 08:23 -0700, Yonghong Song wrote:
>> On 8/17/26 1:48 PM, Jérémy Jean wrote:
>>> Helper callbacks enter BPF subprograms through bpf_callback_t, whose
>>> runtime ABI supplies five arguments. BTF validation nevertheless permits
>>> static callback subprograms to declare more than five arguments when JIT
>>> stack arguments are supported.
>>>
>>> This lets verifier state for a callback use outgoing stack argument slots
>>> prepared at the helper call site. The helper does not pass those slots. On
>>> x86-64, callback loads of arguments seven and later therefore read the
>>> helper native frame instead of the synthetic values checked by the
>>> verifier. KASAN reports a slab OOB write.
>>>
>>> Reject callback subprograms with incoming stack arguments when processing
>>> callback calls.
>>>
>>> Fixes: 0f6bd5e7a804 ("bpf: Support stack arguments for bpf functions")
>>> Assisted-by: Codex:gpt-5
>>> Signed-off-by: Jérémy Jean <Jeremy.Jean@oss.cyber.gouv.fr>
>>> ---
>>>    kernel/bpf/verifier.c | 2 ++
>>>    1 file changed, 2 insertions(+)
>>>
>>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>>> index fdc5fbb1f78c..5fcefc0eaba0 100644
>>> --- a/kernel/bpf/verifier.c
>>> +++ b/kernel/bpf/verifier.c
>>> @@ -9285,6 +9285,8 @@ static int push_callback_call(struct bpf_verifier_env *env, struct bpf_insn *ins
>>>    	err = btf_check_subprog_call(env, subprog, caller->regs);
>>>    	if (err == -EFAULT)
>>>    		return err;
>>> +	if (bpf_in_stack_arg_cnt(&env->subprog_info[subprog]))
>>> +		return -EINVAL;
>> This is not good as user will not know why it failed. Your v1 does have an error message.
>>
>> But this is not needed. Without above verifer.c change, user will get an error message:
>>      func#0 writes 4 stack arg slots, but calls only require 0
>>
>> NACK, see my v1 comment: https://lore.kernel.org/bpf/14a7e7c2-36f7-4aa2-9b20-cc54700a9f1b@linux.dev/
>>
>>>    
>>>    	/* set_callee_state is used for direct subprog calls, but we are
>>>    	 * interested in validating only BPF helpers that can call subprogs as
> Yonghong,
>
> this is a real bug. Here is an example of a program that exposes
> unsafe behavior:
>
>      unsigned long arr[10];
>      
>      __noinline __used
>      static int callback_9args(__u32 index, void *ctx, long a3, long a4,
>                                long a5, long a6, long a7, long a8, long a9)
>      {
>              return arr[a9] % 2;    // verifier sees a9 as 0 and allows this memory access
>      }
>
>      SEC("tc")
>      __description("stack_arg: callback with incoming stack args")
>      __failure
>      __naked void stack_arg_callback_many_args(void)
>      {
>              asm volatile (
>                      "r6 = 0;"
>                      "*(u64 *)(r11 - 32) = 0;"
>                      "*(u64 *)(r11 - 24) = 0;"
>                      "*(u64 *)(r11 - 16) = 0;"
>                      "*(u64 *)(r11 - 8) = 0;"
>                      "r1 = 1;"
>                      "r2 = %[callback_9args];"
>                      "r3 = 0;"
>                      "r4 = 0;"
>                      "call %[bpf_loop];"
>                      "r1 = 1;"
>                      "r2 = 2;"
>                      "r3 = 3;"
>                      "r4 = 4;"
>                      "r5 = 5;"
>                      "*(u64 *)(r11 - 32) = 0;"
>                      "*(u64 *)(r11 - 24) = 0;"
>                      "*(u64 *)(r11 - 16) = 0;"
>                      "*(u64 *)(r11 - 8) = 0;"
>                      "call callback_9args;"   // this hides the callback call from the check in bpf_fixup_call_args()
>                      "r0 = 0;"
>                      "exit;"
>                      :
>                      : __imm_ptr(callback_9args),
>                        __imm(bpf_loop)
>                      : __clobber_common, "r6"
>              );
>      }
>
> Jérémy,
>
> Please update the test case as above, as your test case does not
> really expose the bug. Also, I think that a better fix would be to
> make stack arguments not-init in the callback frame. This way the
> verifier would produce a proper error message.

Okay, I see. The key thing is the below:
    "call callback_9args;"   // this hides the callback call from the check in bpf_fixup_call_args()

So callback_9args appears twice, and bpf_fixup_call_args() only checks the second callback_9args(), right?


