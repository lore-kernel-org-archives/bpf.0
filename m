Received: from mta0.migadu.com (out-91.mta0.migadu.com [91.218.175.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9FAE2C15A0
	for <bpf@vger.kernel.org>; Sat, 19 Sep 2026 17:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789839770; cv=none; b=XJ9QNDFtB1rmE1uPjwvaJ7cMQpRmxTajkqeQp6HOpNwiUZh3MhDOZDTiHcGMOEeSuKvVzhdBbvhymLbzzMIYSMV8bHUqkUEfnbn+6FmKitMxuOjxkVg+UcSpQj96b4+okq883QGiXMyy5hrQZdVtOPXqepT5rslhfUYwbaTked8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789839770; c=relaxed/simple;
	bh=zOeeRnT0rswrqDiHwBLoEV5dx48OemSKG90rAMorN7A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rk+TfpJJio7o5bljXAaCBLK8TBBR2ouSrkbMy69C+Iv1vAokV+e+WAs06sVp8llCTFK81/Oq5JvBKWkrYHOQ9+LVs2zmfxQeQC135Mo4/OWhqDSxwG+sA91wy86rbbIYo+ylJ1Sa7fsw/IGH5izow9xmlF5KKxwUM6totmxTtFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=fARD/YEa; arc=none smtp.client-ip=91.218.175.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="fARD/YEa"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=zOeeRnT0rswrqDiHwBLoEV5dx48OemSKG90rAMorN7A=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789839765; v=1; x=1790444565;
 b=fARD/YEaayZ3lYxisb14g5hC5ec6p40SlEnuzE3uZ8CGWh5qNwcz4KpPl1fbSgyKOAGKNSYb
 yjLqQeWdlL6l3thM/AIT1ER4gmM7AuwFUQBOkBUDiZipcMXIFMBp6gFT1gAROQw9vi9uX74fdLj
 zIMG/sgnixaDA4uY6WuDtfbs=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 5e8de4e3a749d7b8;
	Sat, 19 Sep 2026 17:42:45 +0000
X-Mizu-Trace-ID: 5e8de4e3a749d7b8
X-Migadu-Flow: FLOW_OUT
Message-ID: <b26afda4-a84a-4aa9-bd8e-0d56d1daafb8@linux.dev>
Date: Sat, 19 Sep 2026 10:42:41 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2 03/20] bpf: Add lookups for exception cleanup
 resumes and landing pads
Content-Language: en-GB
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bot+bpf-ci@kernel.org,
 bpf@vger.kernel.org
Cc: ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
 eddyz87@gmail.com, kernel-team@fb.com, martin.lau@kernel.org,
 mason@kernel.org, ihor.solodrai@linux.dev
References: <20260918044211.3286855-1-yonghong.song@linux.dev>
 <5dacf8db0cf086b921c09c3b65da5bff0d1957eb96a3a11906781a6a80c02c2d@mail.kernel.org>
 <DLJ0XC51BJVC.3P80YCN4K6KP6@gmail.com>
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <DLJ0XC51BJVC.3P80YCN4K6KP6@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 9/18/26 9:55 PM, Alexei Starovoitov wrote:
> On Fri Sep 18, 2026 at 5:44 AM UTC, bot+bpf-ci wrote:
>>> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
>>> index c08505b9ba821..f9bccd3e0f4db 100644
>>> --- a/include/linux/bpf_verifier.h
>>> +++ b/include/linux/bpf_verifier.h
>>> @@ -681,6 +681,11 @@ struct bpf_insn_aux_data {
>>>   	bool needs_zext; /* alu op needs to clear upper bits */
>>>   	bool non_sleepable; /* helper/kfunc may be called from non-sleepable context */
>>>   	bool is_iter_next; /* bpf_iter_<type>_next() kfunc call */
>>> +	/*
>>> +	 * 1 + the instruction index of the exception cleanup landing pad this
>>> +	 * call site unwinds to, or 0 for none.
>>> +	 */
>>> +	u32 cleanup_pad;
>>>   	bool call_with_percpu_alloc_ptr; /* {this,per}_cpu_ptr() with prog percpu alloc */
>>>   	u8 alu_state; /* used in combination with alu_limit */
>> [ ... ]
>>
>>> diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
>>> index 2add8001c3ec3..82b00fac6bd6a 100644
>>> --- a/kernel/bpf/fixups.c
>>> +++ b/kernel/bpf/fixups.c
>>> @@ -261,6 +261,11 @@ static void adjust_insn_aux_data(struct bpf_verifier_env *env,
>>>   		}
>>>   	}
>>>
>>> +	if (env->cleanup_info_cnt)
>>> +		for (i = 0; i < prog_len; i++)
>>> +			if (data[i].cleanup_pad > off + 1)
>>> +				data[i].cleanup_pad += cnt - 1;
>>> +
>> [ ... ]
>>
>>> @@ -549,6 +554,7 @@ static int verifier_remove_insns(struct bpf_verifier_env *env, u32 off, u32 cnt)
>>>   	struct bpf_insn_aux_data *aux_data = env->insn_aux_data;
>>>   	unsigned int orig_prog_len = env->prog->len;
>>>   	int err;
>>> +	u32 i;
>>>
>>>   	if (bpf_prog_is_offloaded(env->prog->aux))
>>>   		bpf_prog_offload_remove_insns(env, off, cnt);
>>> @@ -573,6 +579,17 @@ static int verifier_remove_insns(struct bpf_verifier_env *env, u32 off, u32 cnt)
>>>   		sizeof(*aux_data) * (orig_prog_len - off - cnt));
>>>   	env->insn_aux_data_len -= cnt;
>>>
>>> +	if (env->cleanup_info_cnt) {
>>> +		for (i = 0; i < env->insn_aux_data_len; i++) {
>>> +			u32 pad = aux_data[i].cleanup_pad;
>>> +
>>> +			if (pad > off + cnt)
>>> +				aux_data[i].cleanup_pad = pad - cnt;
>>> +			else if (pad > off)
>>> +				aux_data[i].cleanup_pad = 0;
>>> +		}
>>> +	}
>>> +
>>>   	return 0;
>>>   }
>> Can this logic handle NOP removal correctly? When bpf_opt_remove_nops()
>> calls verifier_remove_insns(env, i, 1) to remove a single fall-through
>> goto +0, if a cleanup record names that instruction as its landing pad,
>> then pad == off + 1, so pad > off is true and cleanup_pad becomes 0.
>>
>> But removing the NOP leaves the pad's next instruction at the same
>> index, so the correct landing pad index stays unchanged rather than
>> being zeroed. For example:
>>
>>      off:     some_call with cleanup_pad = off+1
>>      off+1:   goto +0  (NOP landing pad)
>>      off+2:   actual cleanup code
>>
>> After removing the NOP at off+1:
>>
>>      off:     some_call (cleanup_pad should still be off+1)
>>      off+1:   actual cleanup code (was at off+2)
>>
>> The `else if (pad > off)` arm erases the record instead of preserving
>> it. Nothing rejects NOP landing pads during validation - a goto +0 has
>> code 0x05, not 0x00, so check_cleanup_info() accepts it.
>>
>> The ordering makes the loss escape validation: bpf_check_cleanup_exceptions()
>> runs before bpf_opt_remove_nops(), so the verifier proves the cleanup
>> path releases acquired references, but then the NOP removal zeroes
>> cleanup_pad, and later cleanup_info_for_subprog() sees `if (!pad)
>> continue;` and omits the record from the runtime table. The program is
>> accepted but bpf_throw() finds no pad for that call site and skips the
>> cleanup, leaking whatever the pad was supposed to release.
>>
>> Does the `else if (pad > off)` arm need to distinguish removals that
>> consume the landing pad instruction itself versus removals that happen
>> before it?
> bot is correct here.
> pls fix

Agree with bot about for two different cases. Will fix.

>
> pw-bot: cr

