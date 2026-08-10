Received: from mta0.migadu.com (out-11.mta0.migadu.com [91.218.175.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 985D7415F2C
	for <bpf@vger.kernel.org>; Mon, 10 Aug 2026 16:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786380276; cv=none; b=vE6bC/T+92nI7/KtUHW1hDo+h5fLx2l/9+HM9hMr2P1AO0qolgv/Ib8RuNZ334/UDKGddi20xBZcFmm42PCvZwChDCKZl/ovTJ7Hv0ywb93vzuNuKTe/G/w2ZWZx+/QsfJuaYAnWUj687sPhsFIeFKmkhnAaI5DQxB8Xo2vTNog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786380276; c=relaxed/simple;
	bh=P19N8uMlqnT83++aFQt+ZwhTQG1tlI0sXkg9DISendo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eWrYREs1TontS/vI4HL3bA4nfFyssah/NbIdwGKhneq8ezVPGcCazq8RdzfLanJ/+1Ybnc58r/8tn3Jh2dz7ti68Z1K2gB6bPbtL8KUuslvcezmc23BKkIT67fHrozhDBoLD/qvctlsd8QAqT8TXoOW2fjg1G+yaDp9U5fxa/bY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Nt1DeoIk; arc=none smtp.client-ip=91.218.175.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Nt1DeoIk"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=P19N8uMlqnT83++aFQt+ZwhTQG1tlI0sXkg9DISendo=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1786380272; v=1; x=1786985072;
 b=Nt1DeoIkkiWKNbhm9Mdv5v6mHDa4yPhJEnApdfN+zvaRWk8Ytdgm200y4c8EjaFGvRc7npwY
 WklbULJD/FA73eKHNSBuI0r92cRA6BE8Vehf9nYrnwUgAbdbPCVCZwS0LbfbZK9OQNws4NzFHcm
 8IbGcQ/EYvit0qE56zdzUDoA=
X-Envelope-To: bpf@vger.kernel.org
Received: from [IPV6:2a03:83e0:1151:15:1c5e:37e8:36:dd37] (2620:10d:c090:500::5:2f4a)
	by mta12.migadu.com with ESMTPS id b1c0dccbab71e666;
	Mon, 10 Aug 2026 16:44:32 +0000
X-Migadu-Scanner: mta12.migadu.com
Authentication-Results: mta12.migadu.com;
	none
Message-ID: <a3b12cca-05c3-4ee1-91b7-848aa97e409b@linux.dev>
Date: Mon, 10 Aug 2026 09:44:22 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v3 07/13] bpf: Add verifier support for 16-byte
 returns in R0:R2
Content-Language: en-GB
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
References: <20260808190322.1896580-1-yonghong.song@linux.dev>
 <20260808190358.1899615-1-yonghong.song@linux.dev>
 <20260808194120.31A171F000E9@smtp.kernel.org>
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20260808194120.31A171F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 8/8/26 12:41 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [High] Kfuncs returning structs by value can leak uninitialized kernel registers or stack memory via struct padding.
> - [Low] Multi-line comments do not follow the mandatory BPF subsystem style.
> --
>
> --- Patch [7]: [PATCH bpf-next v3 07/13] bpf: Add verifier support for 16-byte returns in R0:R2 ---
> commit 655df23f6a36d32f4e8e39dbf37f70004e7dee82
> Author: Yonghong Song <yonghong.song@linux.dev>
> Subject: bpf: Add verifier support for 16-byte returns in R0:R2
>
> LLVM 23 added support for returning a value in two registers for an
> __int128, or a struct/union whose size is greater than 8 but not more than
> 16 bytes. This patch adds handling for returns greater than 8 bytes in
> BPF subprogram returns and kfunc returns.
>
> Link: https://github.com/llvm/llvm-project/pull/190894
> Link: https://github.com/llvm/llvm-project/pull/206876
>
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> index 0c070957a52b7..41c47bcc3b0a2 100644
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
> [ ... ]
>> @@ -9849,8 +9870,21 @@ static int prepare_func_exit(struct bpf_verifier_env *env, int *insn_idx)
>>   			return -EFAULT;
>>   		}
>>   	} else {
>> -		/* return to the caller whatever r0 had in the callee */
>> -		caller->regs[BPF_REG_0] = *r0;
>> +		/* return to the caller whatever the callee had in the
>> +		 * return register(s)
>> +		 */
>> +		for (i = 0; i < nregs; i++)
>> +			caller->regs[ret_regs[i]] = callee->regs[ret_regs[i]];
>> +
>> +		/* R2 carries only the upper half of a register pair return
>> +		 * value. A stack pointer must not escape the callee (see the
>> +		 * R0 case above), but there is no need to reject the whole
>> +		 * program for it: hand the caller an uninitialized R2 instead,
>> +		 * so that only a caller actually using the returned pointer
>> +		 * fails.
>> +		 */
> [Severity: Low]
> This isn't a bug, but do these multi-line comments follow the modern BPF
> subsystem style? The opening /* typically needs to be on its own line.

Will fix in the next revision.

>
> [ ... ]
>> @@ -10747,6 +10781,18 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
>>   	return 0;
>>   }
>>   
>> +/* Mark the register(s) holding a @size byte kfunc return value as unknown
>> + * scalars. Both halves of a register pair are treated the same way.
>> + */
>> +static void mark_kfunc_ret_regs(struct bpf_verifier_env *env,
> [Severity: Low]
> This isn't a bug, but here is another instance where the multi-line comment
> might need the opening /* on its own line.

Will fix in the next revision.

>
> [ ... ]
>> @@ -13223,10 +13269,25 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
>>   	}
>>   
>>   	if (btf_type_is_scalar(t)) {
>> -		mark_reg_unknown(env, regs, BPF_REG_0);
>> +		mark_kfunc_ret_regs(env, regs, t->size);
>>   		if (meta.btf == btf_vmlinux && (meta.func_id == special_kfunc_list[KF_bpf_res_spin_lock] ||
>>   		    meta.func_id == special_kfunc_list[KF_bpf_res_spin_lock_irqsave]))
>>   			__mark_reg_const_zero(env, &regs[BPF_REG_0]);
>> +	} else if (btf_type_is_struct(t)) {
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
> [Severity: High]
> Could this leak uninitialized kernel registers or stack memory via struct
> padding?
>
> When a kfunc returns a struct by value, __btf_type_is_scalar_struct() checks
> that the defined members are scalars, but it doesn't appear to check for or
> enforce zero padding.
>
> Since mark_kfunc_ret_regs() marks the entire return registers (BPF R0 and R2)
> as initialized SCALAR_VALUE based on t->size, wouldn't a BPF program be able
> to read uninitialized padding bytes left by the native C compiler?

We are fine here. The return value will do proper sign/zero extensions.
Seehttps://reviews.llvm.org/D131598

