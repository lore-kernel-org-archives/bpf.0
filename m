Received: from mta0.migadu.com (out-150.mta0.migadu.com [91.218.175.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41B82442B32
	for <bpf@vger.kernel.org>; Mon, 17 Aug 2026 15:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786980342; cv=none; b=nKIkNv5fES53+0L3VF6xBf1YHySSvuOLjxa0QU9W3w0924ihmDT3Yw4mnwThtuXeVC4hnBbd04wAJGOnCRZKkPIAqcegyQmK5h0P4xtjIEuTkWEOO6gSY3pN1/zmdL6dQKPEfZtNDrGCiPwLrs2siF4T1CRCsDXckKv45s2P21A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786980342; c=relaxed/simple;
	bh=bXOd8kpK155zzyeISgqb97p6lTwhlPIf7DGpfNTuzzc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a8BJ77UwqC1kwVHCUt+lrWiO3Izoa1KbQLDvwh7bvyj+bFeOg82rTHwN8hZodDbVKUfH53hyBsBazPzk5RmfIYRzsDS0W4H2sgER+CPk6xlMw9GLDWNGLoVf/swU5nJgVSpg6SvVSXOF2RA47Omf5GCZjTWcdQIaHRD7EDzDCJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=PiLaCXAU; arc=none smtp.client-ip=91.218.175.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="PiLaCXAU"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=bXOd8kpK155zzyeISgqb97p6lTwhlPIf7DGpfNTuzzc=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1786980338; v=1; x=1787585138;
 b=PiLaCXAUUQcRkVPsv+venj1CVfziuiSqh3sq1nnDUZ35H/63WXbJLF1ea0+/kIV/m3kkHgDt
 ZyYCcgoW2oYWAj9MoxfBxpse/O1TXTtZ8XBf4icvAMd5lHsfXUob7bBticuiExmRydA5RlvZmNK
 E9SlqUHJlOOXnKqP/fUlYFQ8=
X-Envelope-To: bpf@vger.kernel.org
Received: from [IPV6:2a03:83e0:1151:15:1c5e:37e8:36:dd37] (2620:10d:c090:500::7:5604)
	by smtp.migadu.com with ESMTPS id bc701301e2e389d9;
	Mon, 17 Aug 2026 15:25:38 +0000
X-Migadu-Flow: FLOW_OUT
Message-ID: <4a5a3d48-2c36-4e27-86ce-e7bd5b796593@linux.dev>
Date: Mon, 17 Aug 2026 08:25:36 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v6 03/10] bpf: Wire up JIT support for 16-byte
 kfunc returns
Content-Language: en-GB
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
References: <20260817042141.2286086-1-yonghong.song@linux.dev>
 <20260817042156.2287455-1-yonghong.song@linux.dev>
 <20260817043753.89D311F000E9@smtp.kernel.org>
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20260817043753.89D311F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 8/16/26 9:37 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] The BPF verifier fails to initialize BPF_REG_2 for 16-byte scalar kfunc returns, breaking the feature.
> --
>
> --- Patch [3]: [PATCH bpf-next v6 03/10] bpf: Wire up JIT support for 16-byte kfunc returns ---
> commit 70077e00d2d0c46ef0daa85eb2612ed7fbf545ef
> Author: Yonghong Song <yonghong.song@linux.dev>
> bpf: Wire up JIT support for 16-byte kfunc returns
>
> This commit wires up JIT support for 16-byte kfunc returns in BPF, such as
> large structs or 128-bit integers. It adds support to the x86-64, arm64, and
> riscv64 JITs to return the second half of the value in BPF_REG_2, and adds
> verifier checks to reject larger returns on unsupported architectures.
>
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> index f1f1268d29c66..54aca6c305061 100644
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
> [ ... ]
>> @@ -2920,6 +2920,18 @@ int bpf_add_kfunc_call(struct bpf_verifier_env *env, u32 func_id, u16 offset)
>>   	err = btf_distill_func_proto(&env->log, kfunc.btf, kfunc.proto, kfunc.name, &func_model);
>>   	if (err)
>>   		return err;
>> +	if (func_model.ret_size > 8) {
>> +		if (kfunc.flags && (*kfunc.flags & KF_FASTCALL)) {
>> +			verbose(env, "kfunc %s with >8-byte return is not supported with KF_FASTCALL\n",
>> +				kfunc.name);
>> +			return -EOPNOTSUPP;
>> +		}
>> +		if (!bpf_jit_supports_kfunc_ret_reg_pair()) {
>> +			verbose(env, "kfunc %s with >8-byte return is not supported by JIT\n",
>> +				kfunc.name);
>> +			return -EOPNOTSUPP;
>> +		}
>> +	}
> [Severity: Medium]
> While this patch adds JIT support and basic verifier checks for >8-byte
> returns, does the verifier correctly initialize BPF_REG_2 for 16-byte scalar
> returns?
>
> Looking at check_kfunc_call() in kernel/bpf/verifier.c, it seems only
> BPF_REG_0 is marked as initialized for scalar returns:
>
>      if (btf_type_is_scalar(t)) {
>          mark_reg_unknown(env, regs, BPF_REG_0);
>          if (meta.btf == btf_vmlinux &&
>              (meta.func_id == special_kfunc_list[KF_bpf_res_spin_lock] || ...
>
> Since BPF caller-saved registers (including BPF_REG_2) are marked as NOT_INIT
> earlier in check_kfunc_call(), a BPF program attempting to access the upper
> 64 bits of a 16-byte scalar (like an __int128) in BPF_REG_2 would be rejected
> with a verifier read error.
>
> Should check_kfunc_call() also initialize BPF_REG_2 when the return size is
> greater than 8 bytes?

We should be okay here. The actual BPF_REG_2 will be used in
   commit "bpf: Add verifier support for 16-byte returns in R0:R2"

