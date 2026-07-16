Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 545C93876CE
	for <bpf@vger.kernel.org>; Thu, 16 Jul 2026 12:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784204433; cv=none; b=IvyRj1CUlXqEC3r9jS0Apdp6iuHdXtcGZGcN/WEQssgHtTUiygwA+I0QnjuXf1X31np4F1Ikzom7KHxcYTq6aWZefYo/fVibs7qxJfrjp4+pY6q6IGeuk//hYTnKRntxE71sFa8XNXL5CRwuqg03OWRF9t1zPFn9dcsMG7K5Nhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784204433; c=relaxed/simple;
	bh=JmiPUvKPXK7uICHoJ6QARw/aUUqKkfAYRdjqZhFZj9k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DmgI5lNdLrB9BtW+cDRJ2XP+a+U/BQC5mMuFpAu5nhoDYX19K9HufImfy4vxn3ck/R1xjnF36nGPR9GZOTRvlNIEY3QbUx6yA1UGwk6HmG+DcfEX9QnIJW/VuXJR7+0O9ehvhAAOtMQNeiriFrisdqZqi4WJr0E75jZvjXu9UsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.177])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4h1Btr1dMCzKHLsh
	for <bpf@vger.kernel.org>; Thu, 16 Jul 2026 20:19:48 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 246834058D
	for <bpf@vger.kernel.org>; Thu, 16 Jul 2026 20:20:22 +0800 (CST)
Received: from [10.67.110.68] (unknown [10.67.110.68])
	by APP4 (Coremail) with UTF8SMTPA id gCh0CgDXBliEzFhq0EDHBQ--.592S2;
	Thu, 16 Jul 2026 20:20:22 +0800 (CST)
Message-ID: <c2c325cf-8ce2-4cbf-aed7-cd9c22b922da@huaweicloud.com>
Date: Thu, 16 Jul 2026 20:20:20 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v3 2/3] bpf: Reject callback subprogs invoke
 tailcall
Content-Language: en-US
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
References: <20260716120157.835937-1-pulehui@huaweicloud.com>
 <20260716120157.835937-3-pulehui@huaweicloud.com>
 <20260716121115.53BBB1F000E9@smtp.kernel.org>
From: Pu Lehui <pulehui@huaweicloud.com>
In-Reply-To: <20260716121115.53BBB1F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgDXBliEzFhq0EDHBQ--.592S2
X-Coremail-Antispam: 1UD129KBjvJXoWxuryktr15Jw18Gw1DWF47CFg_yoW5tw1UpF
	Z7WasrXry8Xa12v3ZFkF4xAFWrJrs5JFW7Gr48CF13AF1qkryDWFZ0grWF9Fyj9rs8tay0
	vr4UZFZxJw1vyaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUgvb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_
	Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1V
	AY17CE14v26r1Y6r17MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAI
	cVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42
	IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIev
	Ja73UjIFyTuYvjxUzsqWUUUUU
X-CM-SenderInfo: psxovxtxl6x35dzhxuhorxvhhfrp/



On 2026/7/16 20:11, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] Direct tail calls inside async and exception callbacks are no longer rejected, bypassing the Tail Call Counter (TCC) limit and potentially causing infinite tail calls or crashes.
> --
> 
> --- Patch [2]: [PATCH bpf-next v3 2/3] bpf: Reject callback subprogs invoke tailcall ---
> commit 99ae0587c85d574b41c654707864af3b7ff51fa8
> Author: Pu Lehui <pulehui@huawei.com>
> 
>      bpf: Reject callback subprogs invoke tailcall
> 
> This commit aims to fix infinite tailcalls by rejecting tailcalls inside
> all subprograms of synchronous callbacks. It also consolidates the existing
> async and exception callback checks into a single unified check.
> 
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> index 782d939c38cdc..62d46b4c9962f 100644
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
>> @@ -5237,10 +5237,6 @@ static int check_max_stack_depth_subprog(struct bpf_verifier_env *env, int idx,
>>   		if (verifier_bug_if(sidx < 0, env, "callee not found at insn %d", next_insn))
>>   			return -EFAULT;
>>   		if (subprog[sidx].is_async_cb) {
>> -			if (subprog[sidx].has_tail_call) {
>> -				verifier_bug(env, "subprog has tail_call and async cb");
>> -				return -EFAULT;
>> -			}
> 
> [Severity: High]
> Does removing this explicit check allow direct tailcalls inside async and
> exception callbacks to bypass validation?
> 
> If an async or exception callback does not make any subprogram calls (acting
> as a root subprogram), the local variable tail_call_reachable will remain
> false, as it is only set to true when traversing into or returning from a
> callee subprogram.

callback is also subprog, and as mentioned before:

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

> 
>>   			/* async callbacks don't increase bpf prog stack size unless called directly */
>>   			if (!bpf_pseudo_call(insn + i))
>>   				continue;
>> @@ -5281,8 +5277,8 @@ static int check_max_stack_depth_subprog(struct bpf_verifier_env *env, int idx,
>>   	 */
>>   	if (tail_call_reachable) {
>>   		for (tmp = idx; tmp >= 0; tmp = dinfo[tmp].caller) {
>> -			if (subprog[tmp].is_exception_cb) {
>> -				verbose(env, "cannot tail call within exception cb\n");
>> +			if (subprog[tmp].is_cb) {
> 
> Because tail_call_reachable evaluates to false for callbacks without
> subprogram calls, will this unified check be completely bypassed?
> 
> Since these callbacks are invoked directly by the kernel rather than via a
> BPF-to-BPF call, the Tail Call Counter register might be uninitialized. Could
> this bypass the TCC limit and lead to infinite tailcalls?
> 
>> +				verbose(env, "cannot tail call within callback\n");
>>   				return -EINVAL;
>>   			}
>>   			if (subprog[tmp].stack_arg_cnt) {
> 

