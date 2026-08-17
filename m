Received: from mta1.migadu.com (out-62.mta1.migadu.com [95.215.58.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8909643E9DF
	for <bpf@vger.kernel.org>; Mon, 17 Aug 2026 15:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786981619; cv=none; b=oDDeyllCcgpm5sKdVfRUdGAlwnFODiR4P2XyXW6AgV3p9jr1eOaqGnDQq5hb6yeelvDBHWOCR2QOgyTsPfAiCaa7gAXyh/kg1Qru1hW/fzUvrjZ79XCeiR5MkVRDKLmchPzOjMRbiQdqMDrKefhjIkRUIAY8VJhcsW33t2qJaok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786981619; c=relaxed/simple;
	bh=bH8NMsZMqgWb1UyHTEUuzyiTZF99ul2jDrncq/tEb6A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lc0F8LF/eK8lk72rONL5JEM9mXLj7dS3sr2WeMZvsrtr53HyMcZlxsjdWvVrSmRr/VHoH94IrN3MZGi2dPFWsYLu+R+7WYeqsut+oKeBtoO9rjE4Pr20159G033ZSN+mHALcx82kcWMjZpN1Ha117fAQCvyVzos5p1BEhHSZcFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=VXZmWtvy; arc=none smtp.client-ip=95.215.58.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="VXZmWtvy"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=bH8NMsZMqgWb1UyHTEUuzyiTZF99ul2jDrncq/tEb6A=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1786981615; v=1; x=1787586415;
 b=VXZmWtvyKoY7qN08yKVlHHyO+4jp+tLCNdKk5cINwSUMl9iqV6Zy8xnwpqjTZbgqqEvfn1nV
 7NBFXLCOUcA07S9qFcPLKoaEPrjvin/Wvt2KvzMh5LDGZflF3vSLaCQ/TSlfUAV1rGXCfthZ1Zp
 hmA2zGCb1GcFztP/e8MHFxjw=
X-Envelope-To: bpf@vger.kernel.org
Received: from [IPV6:2a03:83e0:1151:15:1c5e:37e8:36:dd37] (2620:10d:c090:500::7:5604)
	by smtp.migadu.com with ESMTPS id 319b38dac8cf5a3f;
	Mon, 17 Aug 2026 15:46:55 +0000
X-Migadu-Flow: FLOW_OUT
Message-ID: <fd735f9f-74ab-435a-93b8-0541c1ea8a32@linux.dev>
Date: Mon, 17 Aug 2026 08:46:53 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v6 06/10] bpf: Add verifier support for 16-byte
 returns in R0:R2
Content-Language: en-GB
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
References: <20260817042141.2286086-1-yonghong.song@linux.dev>
 <20260817042212.2291498-1-yonghong.song@linux.dev>
 <20260817044220.46F201F000E9@smtp.kernel.org>
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20260817044220.46F201F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 8/16/26 9:42 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] The newly added support for kfuncs returning structs by value is mathematically unreachable.
> --
>
> --- Patch [6]: [PATCH bpf-next v6 06/10] bpf: Add verifier support for 16-byte returns in R0:R2 ---
> commit 438f13b526c411cf77d7536a3436a0cc4625dbe4
> Author: Yonghong Song <yonghong.song@linux.dev>
>
> bpf: Add verifier support for 16-byte returns in R0:R2
>
> This patch adds BPF verifier support for handling 16-byte returns in the
> R0:R2 register pair, utilizing LLVM 23 capabilities. It models this
> register pair at calls to global/static subprograms and kfuncs, allowing
> kfuncs to return structs composed of scalars.
>
> Link: https://github.com/llvm/llvm-project/pull/190894
> Link: https://github.com/llvm/llvm-project/pull/206876
>
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
> [ ... ]
>
>> @@ -13967,10 +13997,25 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
>>   	}
>>   
>>   	if (btf_type_is_scalar(t)) {
>> -		mark_reg_unknown(env, regs, BPF_REG_0);
>> +		mark_kfunc_ret_regs(env, regs, t->size);
>>   		if (meta.btf == btf_vmlinux && (meta.func_id == special_kfunc_list[KF_bpf_res_spin_lock] ||
>>   		    meta.func_id == special_kfunc_list[KF_bpf_res_spin_lock_irqsave]))
>>   			__mark_reg_const_zero(env, &regs[BPF_REG_0]);
>> +	} else if (btf_type_is_struct(t)) {
> [Severity: Medium]
> Is this newly added code for kfunc struct returns actually reachable
> during program load?
>
> Looking at how kfuncs are processed earlier in the verifier,
> bpf_add_kfunc_call() calls btf_distill_func_proto(), which appears to
> still explicitly reject struct return types:
>
> kernel/bpf/btf.c:btf_distill_func_proto() {
>      ...
>      if (ret < 0 || btf_type_is_struct(t)) {
>          bpf_log(log,
>              "The function %s return type %s is unsupported.\n",
>              tname, btf_type_str(t));
>          return -EINVAL;
>      }
>      ...
> }
>
> Since btf_distill_func_proto() is called during program load before
> check_kfunc_call() is ever reached, won't any BPF program calling a
> struct-returning kfunc be unconditionally rejected, making this new
> branch dead code?

The next patch "bpf: Enable aggregate return types up to 16 bytes"
will enable to have successful prog load.

>
>> +		/*
>> +		 * The returned struct comes back as raw register bits modeled
>> +		 * as an unknown scalar, so it must contain only scalars:
>> +		 * otherwise a pointer field would be laundered into a scalar
>> +		 * and escape provenance and reference tracking.
>> +		 */
>> +		if (!__btf_type_is_scalar_struct(env, desc_btf, t, 0)) {
>> +			verbose(env,
>> +				"kernel function %s returns %s %s that is not composed of scalars\n",
>> +				func_name, btf_type_str(t),
>> +				btf_name_by_offset(desc_btf, t->name_off));
>> +			return -EINVAL;
>> +		}
>> +		mark_kfunc_ret_regs(env, regs, t->size);
>>   	} else if (btf_type_is_ptr(t)) {
>>   		ptr_type = btf_type_skip_modifiers(desc_btf, t->type, &ptr_type_id);
> [ ... ]
>

