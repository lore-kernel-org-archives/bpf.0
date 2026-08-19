Received: from mta1.migadu.com (out-112.mta1.migadu.com [95.215.58.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 215613BED78
	for <bpf@vger.kernel.org>; Wed, 19 Aug 2026 16:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787155273; cv=none; b=tuUmPFoee9ettMIJ6tyWohqXOCf3cA+nS/IsK/WCKrlCNkl4vk/QjFUQAicmJR9pQPZJJJG0+3RN/2gbvVXYQhOtmdYcSxxP4/LznxqnU9ct+/vllqeDk6xxoA0G1SpJ9KqL5i9QnZGzpbIR6rpN8YZ6YzEmpeXEean8pBhKJwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787155273; c=relaxed/simple;
	bh=/4p+VVa305dJaK3Y0s6o85s7xff+p4asIjcMJoggyjM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tWBLAmc8htMAKvuNEFFiqsgv1w/xwBMsAkVf1oEqA5DKXNIqQYF4GKZ4O+OYc0O5MJfpv4AINhGDr0JhuvIZTl7ft+/u6dVwAVxPlwtFf5OyciSCN9pgL/roTU/dMwIA62k8Wg8P3NNCjSQ/RrIpU2x34E/yACN6tFhB08ZL838=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=q/CWHUVh; arc=none smtp.client-ip=95.215.58.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="q/CWHUVh"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=/4p+VVa305dJaK3Y0s6o85s7xff+p4asIjcMJoggyjM=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787155268; v=1; x=1787760068;
 b=q/CWHUVhoQ5hLsDPQt5KETnxgfYiGTeZljHEiVcqikqNoW2dgVG00bYx/WNzGVPz6fYDRJQ8
 uxWN5knBMUvbjw1VLY+BWUmy2Dmkj12EKebj2Mlkg0v2XBRC33fVyN9SB1PbJSB1CnXEmVKeQlj
 Lb85Po9NXNUDrDEZ3J1rJaHg=
X-Envelope-To: bpf@vger.kernel.org
Received: from [IPV6:2a03:83e0:1151:15:1c5e:37e8:36:dd37] (2620:10d:c090:500::7:5d0e)
	by smtp.migadu.com with ESMTPS id a49fe7c89178272e;
	Wed, 19 Aug 2026 16:01:08 +0000
X-Mizu-Trace-ID: a49fe7c89178272e
X-Migadu-Flow: FLOW_OUT
Message-ID: <85a4607e-aa71-43f1-96db-33f25ef15173@linux.dev>
Date: Wed, 19 Aug 2026 09:01:06 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v7 06/10] bpf: Add verifier support for 16-byte
 returns in R0:R2
Content-Language: en-GB
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
References: <20260819055239.3293449-1-yonghong.song@linux.dev>
 <20260819055309.3297684-1-yonghong.song@linux.dev>
 <20260819061414.070A61F000E9@smtp.kernel.org>
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20260819061414.070A61F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 8/18/26 11:14 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] The newly added support for kfuncs returning structs is completely unreachable due to an overlooked check in btf_distill_func_proto, and hides a critical missing size limit.
> --
>
> --- Patch [6]: [PATCH bpf-next v7 06/10] bpf: Add verifier support for 16-byte returns in R0:R2 ---
> commit c9e349733faae615b87f8da3417558d2ede26348
> Author: Yonghong Song <yonghong.song@linux.dev>
>
> bpf: Add verifier support for 16-byte returns in R0:R2
>
> LLVM 23 added support for returning a value in two registers for an
> __int128, or a struct/union whose size is greater than 8 but not more than
> 16 bytes. See LLVM patches [1] and [2].
>
> Before LLVM 23 the BPF backend could not return these values at all.
>
> [ ... ]
>
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> index 991782b402f20..d79f0c069795c 100644
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
> [ ... ]
>
>> @@ -13965,10 +13995,25 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
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
> [Severity: Medium]
> Is this new struct return handling reachable?
>
> Looking at early program loading, btf_distill_func_proto() unconditionally
> rejects struct return types:
>
> kernel/bpf/btf.c:btf_distill_func_proto() {
>      ...
> 	if (ret < 0 || btf_type_is_struct(t)) {
> 		bpf_log(log,
> 			"The function %s return type %s is unsupported.\n",
> 			tname, btf_type_str(t));
> 		return -EINVAL;
> 	}
>      ...
> }
>
> As a result, wouldn't programs be rejected before check_kfunc_call() is
> executed?
>
> Additionally, if this code were reachable, does it lack a bounds check on
> t->size?
>
> Because kfuncs use the C ABI, returning a large struct requires a hidden
> 'sret' pointer. Without a size limit, returning a struct larger than 16 bytes
> might bypass the BPF return pair logic, as the BPF JIT would pass the
> attacker-controlled BPF R1 as this pointer.
>
> Could this potentially allow a kfunc to overwrite arbitrary kernel memory?

Patch 7 "bpf: Enable aggregate return types up to 16 bytes" will
have proper guard (e.g. return type must be <= 16 bytes). So we
should be fine here.

>
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
>>   		err = check_special_kfunc(env, &meta, regs, insn_aux, ptr_type, desc_btf);

