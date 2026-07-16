Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9691428C869
	for <bpf@vger.kernel.org>; Thu, 16 Jul 2026 03:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784172163; cv=none; b=O8qPYEjiKtehJ/wc1qifB96Z9Qr3K2DvVGnJYw5m2rSIA2Davyu+1d9hEyN7gcpGk2ACgFx869PrkaaFwsgA+rSJqwnJuwtIpULndq0TD3RQBlcqIzHxMBxcR0DCHQocdREt4XkLHcmMPcW6NVbZvbfp2mL/aFTYmbomBCIg7jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784172163; c=relaxed/simple;
	bh=DmPDwCB7cRxaqJSSwtK+D86EPWypl5ZqOPDeWF0WwL0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HhEsTFH2YedCYgj2m+xU8gcDe/GjS9QWxqmTpJBl3fyAq5m4n40ufnOpUr04qlSbpL/RZf7ubHqws8isNojXMeaXMN7l9KIt27GnbWrHPq0ATO45GTV5DZD2TJ4IJR1rtf/jytjhTHtC7B3IdeODSW+gEK1K3MtV1cLkYc5nA+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.170])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4h0yyD4YX7zKHMLY
	for <bpf@vger.kernel.org>; Thu, 16 Jul 2026 11:21:56 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id E64914056D
	for <bpf@vger.kernel.org>; Thu, 16 Jul 2026 11:22:29 +0800 (CST)
Received: from [10.67.110.68] (unknown [10.67.110.68])
	by APP4 (Coremail) with UTF8SMTPA id gCh0CgB3p1h0TlhqATCaBQ--.46335S2;
	Thu, 16 Jul 2026 11:22:29 +0800 (CST)
Message-ID: <57c27d24-8e93-47eb-8c9b-0959b71d805e@huaweicloud.com>
Date: Thu, 16 Jul 2026 11:22:28 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2 1/2] bpf: Reject callback subprogs invoke
 tailcall
Content-Language: en-US
To: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
 sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
References: <20260714024459.420075-1-pulehui@huaweicloud.com>
 <20260714024459.420075-2-pulehui@huaweicloud.com>
 <20260714025645.101971F000E9@smtp.kernel.org>
 <87ech5wumg.fsf@all.your.base.are.belong.to.us>
From: Pu Lehui <pulehui@huaweicloud.com>
In-Reply-To: <87ech5wumg.fsf@all.your.base.are.belong.to.us>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgB3p1h0TlhqATCaBQ--.46335S2
X-Coremail-Antispam: 1UD129KBjvJXoWxuw13WFyDuw45uF4Dtw1DKFg_yoW7tryfpF
	93WasFgryDXF1IkFnFkF4xXayrt398JF4UJr1rA3W3Aw1DCryDGFZ0gFWruFWUur4Sv3y0
	vr40vwsxJw1kCaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUgvb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY
	6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17
	CEb7AF67AKxVWUXVWUAwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF
	0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIx
	AIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIev
	Ja73UjIFyTuYvjxUzsqWUUUUU
X-CM-SenderInfo: psxovxtxl6x35dzhxuhorxvhhfrp/


On 2026/7/14 21:47, Björn Töpel wrote:
> sashiko-bot@kernel.org writes:
> 
>> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
>> - [High] The patch inadvertently allows async and exception callbacks to execute tail calls, bypassing verifier protections and reintroducing the TCC register clobbering vulnerability.
>> - [High] The unified `is_cb` check introduces a DFS state leakage that incorrectly rejects valid BPF programs containing both a tail call and an unrelated synchronous callback.
>> --
>>
>> --- Patch [1]: [PATCH bpf-next v2 1/2] bpf: Reject callback subprogs invoke tailcall ---
>> commit d260c3afbc5fedfa9c5c074686a31f057a21a53a
>> Author: Pu Lehui <pulehui@huawei.com>
>>
>> bpf: Reject callback subprogs invoke tailcall
>>
>> This patch rejects tailcalls inside all subprograms of synchronous callbacks
>> to prevent clobbering the TCC limit register on some JIT compilers. It also
>> consolidates async and exception callback checks into a single unified
>> is_cb check.
>>
>>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>>> index 03e2202cca13d..3f6c8b8fc04d0 100644
>>> --- a/kernel/bpf/verifier.c
>>> +++ b/kernel/bpf/verifier.c
>>> @@ -5258,10 +5258,6 @@ static int check_max_stack_depth_subprog(struct bpf_verifier_env *env, int idx,
>>>   		if (verifier_bug_if(sidx < 0, env, "callee not found at insn %d", next_insn))
>>>   			return -EFAULT;
>>>   		if (subprog[sidx].is_async_cb) {
>>> -			if (subprog[sidx].has_tail_call) {
>>> -				verifier_bug(env, "subprog has tail_call and async cb");
>>> -				return -EFAULT;
>>> -			}
>>
>> [Severity: High]
>> Does removing this explicit check allow async and exception callbacks to
>> execute tail calls when they contain no further subprogram calls?
>>
>> Because async and exception callbacks are evaluated as the root of their own
>> call graphs by check_max_stack_depth_subprog() (with idx > 0), the local
>> tail_call_reachable variable remains false throughout the evaluation loop if
>> the callback makes no normal subprogram calls.
>>
>> When the loop ends, the new unified is_cb check is bypassed because
>> tail_call_reachable is false, and the fallback check is skipped because !idx
>> is false for async callbacks. Can this bypass the TCC limit protections and
>> lead to infinite tailcalls?

Tailcall is meaningless for async/exception callback or its subprogs 
because the `ctx` cannot be passed along.

As for sync callback, callback is also a subprog, and if it calls 
tailcall, local tail_call_reachable will be marked as `true`, and then 
reject in the follow is_cb check.

But it will be reject early on the following path or more earlier:
check_helper_call
   if (func_id == BPF_FUNC_tail_call) {
     if (env->cur_state->curframe) {
       mark_reg_unknown(env, regs, BPF_REG_0); <-- R0 is unknown
       prepare_func_exit
         if (callee->in_callback_fn) {
           /* callback_ret_range is precise */
           if (!retval_range_within(callee->callback_ret_range, r0))
             goto reject;
         }
     }
   }

>>
>>>   			/* async callbacks don't increase bpf prog stack size unless called directly */
>>>   			if (!bpf_pseudo_call(insn + i))
>>>   				continue;
>>> @@ -5302,8 +5298,8 @@ static int check_max_stack_depth_subprog(struct bpf_verifier_env *env, int idx,
>>>   	 */
>>>   	if (tail_call_reachable) {
>>>   		for (tmp = idx; tmp >= 0; tmp = dinfo[tmp].caller) {
>>> -			if (subprog[tmp].is_exception_cb) {
>>> -				verbose(env, "cannot tail call within exception cb\n");
>>> +			if (subprog[tmp].is_cb) {
>>> +				verbose(env, "cannot tail call within callback\n");
>>>   				return -EINVAL;
>>>   			}
>>
>> [Severity: High]
>> Can the local tail_call_reachable variable leak across unrelated subprograms
>> during the verifier's Depth-First Search?
>>
>> If a BPF program first calls a subprogram containing a tail call, the DFS
>> will set tail_call_reachable = true and mark it true for all ancestors.
>> When backtracking from the callee to the main program, tail_call_reachable
>> is restored to the ancestor's state:
>>
>> kernel/bpf/verifier.c:check_max_stack_depth_subprog() {
>>      ...
>> 	/* reset tail_call_reachable to the parent's actual state */
>> 	tail_call_reachable = subprog[idx].tail_call_reachable;
>>
>> 	goto continue_func;
>>      ...
>> }
>>
>> If the program subsequently sets up a synchronous callback (e.g., via
>> bpf_loop()), the loop jumps back up without resetting tail_call_reachable to
>> false. When it reaches the end of the callback subprogram,
>> tail_call_reachable will still be true from the leaked state.
>>
>> Will this cause the new unified is_cb check to incorrectly reject perfectly
>> valid BPF programs that contain both a tail call and an unrelated synchronous
>> callback?
> 
> Don't about "high severity", but this seems legit. It seems like we can
> get "random" (depending of ordering) rejects of legit program, no? ...at
> least the LLM I asked could construct a fix/PoC for it...
> 
> 
> Björn

Sorry for the delay, I've been caught up with some other work. Thanks 
Björn for pointing this out.
Yes, the following reasonable bpf prog will be rejected:

        subprog -> tailcall
main <
        bpf_loop -> callback
	
The root cause is that the local tail_call_reachable variable retains 
its old state when the verifier digs into a new call site. It needs to 
be properly synchronized with the callee's state; otherwise, the new 
call chain will be incorrectly marked as tailcall-reachable even if it 
doesn't contain any tailcalls.

I think it a pre-existing issue. Even in scenarios without callbacks, 
unrelated call sites will be wrongly marked as tailcall-reachable. For 
instance, in the following case, subprog1 and subprog2 will inherit the 
incorrect state:

        subprog0->tailcall
main <
        subprog1->subprog2
	
I will add new fix in the next.

