Received: from mta0.migadu.com (out-83.mta0.migadu.com [91.218.175.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4421F26CE05
	for <bpf@vger.kernel.org>; Mon, 17 Aug 2026 03:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.83
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786938269; cv=none; b=hQFtxljvKiJ3q2QiEvxd1djYztWgW0GHPE+XRj1vDL0xJ+ONh9WhTPk7UALakZgTtbNULoqvH10/8GIVqcJgIv0DG8RFRp3LjOgncgkBhIDCLHAcPyLuYGqnGdlDLWG/Ino1YKrEGBRy9J26VfuOirS0bmBhEsY5LpMe9AAZ9qU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786938269; c=relaxed/simple;
	bh=ONUXVn4EcDphDo7KsaCHdSqV/EGEjLfMgyUFh3WJBzo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EvnQ1YgmkWb1gKr9bShBKQukLxS0i5U5JwxT9uZ+ONoIuCOoW9jl0ZUHtiVbUeUnOKfRAgEbCQjAXE7Zq7fevfb9ew7L0Tn2EAkCvmUmKgQD3FavYzK9kJEr1uLJOXwud6i14G/W9p8+Fs3i1hbhKIZQBlcNn26cL6LMFjEVPBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=AyPjH8TR; arc=none smtp.client-ip=91.218.175.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="AyPjH8TR"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=ONUXVn4EcDphDo7KsaCHdSqV/EGEjLfMgyUFh3WJBzo=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1786938264; v=1; x=1787543064;
 b=AyPjH8TR5wmajXEvBhjA87oJNCVsW7hMCIDlMvl7ZQNKVK3r9f+7ldlVL2khlR7CnoQ3Wji4
 18CvPzkzMX1K9GBnW6IiqO7N/0iJ24N6sk2u2vDYt8AEOsT5Qqx8NRL4qj4zgwWUzSj9ja9nGno
 4i5TrQe9bW6kFDSnhAPMu4ig=
X-Envelope-To: bpf@vger.kernel.org
Received: from [IPV6:2600:382:861c:7f36:14e1:cf55:e233:293b] (2600:382:861c:7f36:14e1:cf55:e233:293b)
	by smtp.migadu.com with ESMTPS id 06c9bd7da7b32600;
	Mon, 17 Aug 2026 03:44:24 +0000
X-Migadu-Flow: FLOW_OUT
Message-ID: <1a5bd4c5-8138-48da-b48d-6290d38428f0@linux.dev>
Date: Sun, 16 Aug 2026 20:44:22 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v5 06/11] bpf: Add verifier support for 16-byte
 returns in R0:R2
Content-Language: en-GB
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
References: <20260813200210.1991507-1-yonghong.song@linux.dev>
 <20260813200240.1995795-1-yonghong.song@linux.dev>
 <20260814022633.B578E1F00A3A@smtp.kernel.org>
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20260814022633.B578E1F00A3A@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 8/13/26 7:26 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] The newly added support for kfuncs and global subprograms returning structs up to 16 bytes by value is unreachable dead code because existing BTF validation logic unconditionally rejects struct return types.
> --
>
> --- Patch [6]: [PATCH bpf-next v5 06/11] bpf: Add verifier support for 16-byte returns in R0:R2 ---
> commit 9e421b8a810e50b00fab2bcdb9c1dbd32e705d84
> Author: Yonghong Song <yonghong.song@linux.dev>
>
> bpf: Add verifier support for 16-byte returns in R0:R2
>
> This commit adds verifier support for returning values in both R0 and R2 for
> types greater than 8 bytes and up to 16 bytes. It models the register pair
> for global and static subprograms as well as kfunc calls.
>
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> index 161d77791bc62..0c68ab3bd6cec 100644
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
> [ ... ]
>
>> @@ -13265,10 +13295,25 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
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
> Is this new logic for kfuncs returning structs actually reachable?
>
> Looking at btf_distill_func_proto() in kernel/bpf/btf.c, it unconditionally
> rejects struct return types, meaning programs would fail to load early on:
>
> 	if (ret < 0 || btf_type_is_struct(t)) {
> 		bpf_log(log,
> 			"The function %s return type %s is unsupported.\n",
> 			tname, btf_type_str(t));
> 		return -EINVAL;
> 	}
>
> Similarly, btf_validate_return_type() blocks global subprograms from returning
> structs:
>
> 	/* We always accept void or scalars. */
> 	if (btf_type_is_void(t) || btf_type_is_int(t) || btf_is_any_enum(t))
> 		return 0;
>
> 	return -EOPNOTSUPP;
>
> Does this mean the new struct return handling logic is dead code, and only
> static subprograms or __int128 returns can actually use the new convention?

The next patch will actually enable "aggregate return types up to 16 bytes".

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

