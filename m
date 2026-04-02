Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC9FF32E6BD
	for <bpf@vger.kernel.org>; Thu,  2 Apr 2026 14:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775140985; cv=none; b=rW6RvDK97rbniIF6QeSdHPGoj0dOgsGvDRmh0oeoInKKg0MIIY72qDhHHmPOrYzvPGZw0Hlc3xnMghreJmc9ThmUtsOiDzY8weBQuq2tx0G29NANYLqFrmb0NiTeS4ciaPI5/9455i/Mcm/NLgm7QuZ23E0dc41LYDE41822UIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775140985; c=relaxed/simple;
	bh=3wfuJNTSXoVkXx9A8DRCcvIYwNTrkuUczKwDji/tQlE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PqlPSjvcD0dilRu8zJDMQAhd/1pQG/5TAv3MdBru7rhYYSwRFO1KcEQwHygHRk0XOO5hxe446YFyQabb4Y/p2TqEkCmSyKeI4uWMiJp6sTAZZ82NF/ExKV/kA01ACMY017dwHvbkH4bgpDAo7REXdxrniMyfPVFIkbZ+6g3XVBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=FEqgir/3; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="FEqgir/3"
Message-ID: <79e2d926-46de-4b83-af90-2f56f4f780d8@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1775140981;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ise2sW/npENttVdwKUo01p2L2SUEX7Q4fjgwOlsDxzA=;
	b=FEqgir/3BsYHQ9KCHgloREuBNyTHqvtY1S8M2711xqLjQENEmL99K7Pprz2l41HfZPxXCn
	wBrkzS4a0VychCB5tvHPzk+TFOrUplYvO+acaTx/ia3JU8JkgwSakeyI+Pk0PpUTG+Pk+5
	DaFf7H4mGEJrQ0oklgmz55CXikwrRpw=
Date: Thu, 2 Apr 2026 07:42:50 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 03/10] bpf: Support stack arguments for bpf
 functions
To: bot+bpf-ci@kernel.org, bpf@vger.kernel.org
Cc: ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
 jose.marchesi@oracle.com, kernel-team@fb.com, martin.lau@kernel.org,
 eddyz87@gmail.com, clm@meta.com, ihor.solodrai@linux.dev
References: <20260402012742.3917613-1-yonghong.song@linux.dev>
 <02581856b17c3d0ea793c988f905388c2855a7fcbc488df8228621462ffdd2ab@mail.kernel.org>
Content-Language: en-GB
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <02581856b17c3d0ea793c988f905388c2855a7fcbc488df8228621462ffdd2ab@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 4/1/26 8:18 PM, bot+bpf-ci@kernel.org wrote:
>> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
>> index 090aa26d1c98..a260610cd1c1 100644
>> --- a/include/linux/bpf_verifier.h
>> +++ b/include/linux/bpf_verifier.h
> [ ... ]
>
>> @@ -319,6 +324,10 @@ struct bpf_func_state {
>>   	 * `stack`. allocated_stack is always a multiple of BPF_REG_SIZE.
>>   	 */
>>   	int allocated_stack;
>> +
>> +	u16 stack_arg_depth; /* Size of incoming + max outgoing stack args in bytes. */
>> +	u16 incoming_stack_arg_depth; /* Size of incoming stack args in bytes. */
>> +	struct bpf_stack_arg_state *stack_arg_slots;
>>   };
> The new stack_arg_slots state is part of bpf_func_state and is
> properly copied in copy_stack_state() and freed in free_func_state(),
> but stacksafe() does not compare it during state pruning.
>
> stacksafe() only iterates the regular stack:
>
> kernel/bpf/verifier.c:stacksafe() {
>      for (i = 0; i < old->allocated_stack; i++) {
>          ...
>          old->stack[spi].slot_type[...]
>          ...
>      }
>      return true;
> }
>
> It never examines old->stack_arg_slots or cur->stack_arg_slots. This
> means func_states_equal() -> stacksafe() treats two states as
> equivalent even when they differ in their stack arg slot contents.
>
> Could this allow the verifier to incorrectly prune a path where
> outgoing stack arg slots are uninitialized? For example, if a BPF
> program has two paths to a call instruction -- one that writes the
> outgoing stack args and one that does not -- the verifier could
> explore the initialized path first, save the state at a checkpoint,
> then prune the uninitialized path as equivalent. The initialization
> check in set_callee_state():
>
> kernel/bpf/verifier.c:set_callee_state() {
>      for (i = 0; i < callee_incoming_slots; i++) {
>          int caller_spi = i + caller_incoming_slots;
>
>          if (!is_stack_arg_slot_initialized(caller, caller_spi)) {
>              verbose(env, "stack arg#%d not properly initialized\n",
>                  i + 1 + MAX_BPF_FUNC_REG_ARGS);
>              return -EINVAL;
>          }
>          callee->stack_arg_slots[i] = caller->stack_arg_slots[caller_spi];
>      }
> }
>
> would never run on the pruned path, potentially allowing the callee
> to receive uninitialized data.
>
> It seems like stacksafe() needs a companion loop for stack_arg_slots,
> similar to how it walks the regular stack, to maintain verifier
> soundness for this new state.

You are absolutely correct. Indeed, we should do some checking for
stack_arg_slots along side stacksafe(). I will fix it in the next
revision.

>
>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/23879588767

