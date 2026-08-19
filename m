Received: from mta0.migadu.com (out-212.mta0.migadu.com [91.218.175.212])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEA4141DEDA
	for <bpf@vger.kernel.org>; Wed, 19 Aug 2026 15:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.212
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787155037; cv=none; b=m8mTMb1Ps/r1Ew4tJ8FPpS9xJ2Rew4UvkuE4Rpm6cFFpK0WGbi8Jh758m7QiOv+HZScc/N+G8PmuVSQKHUnbkOiF1flO8Sv/vBtTU6u9bJbTb0Y6EH3WqD8I/QiRGuE5FlOLTSc3jtXmpvpHa2A4Xpze/St7RXpc+HYA9/Jn/AA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787155037; c=relaxed/simple;
	bh=qHG+hNfD/uDO9DvYun5lVZsVldtATReTviIlNvAUeEM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qKA/9JdW3mbhaNLRlhPiCQQ5tWgiaaS8QzBJUZnNXaVc/wZDOvpq0hUs+3NK7zpgshQxkN/MhPVQSiOkoX96XGKgdk2T7W3sjVWrlnDzvvEuhY3oyPdPlRHP6l7FLIueeZmfK/BMHoaOva3kOg3ho2KPI14jb/EVBise2a/+7WU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Zi2wUJLv; arc=none smtp.client-ip=91.218.175.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Zi2wUJLv"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=qHG+hNfD/uDO9DvYun5lVZsVldtATReTviIlNvAUeEM=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787155033; v=1; x=1787759833;
 b=Zi2wUJLvkX9PmS0qXDul13uYeaShv5bKoX4QpmbQTyz/3/gatDHLBwub6TLj5g/3HSYk24AB
 PXWDlrZ5/nGRGjEKN0t3kDfvYwI9cktgMbL4UvKPQ2GJYW4bD5uBNwosCFRSk55GGoz1qdX90KJ
 f5IGvKRiEeM5pqe2q3bB49lQ=
X-Envelope-To: bpf@vger.kernel.org
Received: from [IPV6:2a03:83e0:1151:15:1c5e:37e8:36:dd37] (2620:10d:c090:500::7:5d0e)
	by smtp.migadu.com with ESMTPS id ae428da0d1733840;
	Wed, 19 Aug 2026 15:57:13 +0000
X-Mizu-Trace-ID: ae428da0d1733840
X-Migadu-Flow: FLOW_OUT
Message-ID: <892727cf-36a7-4b87-9f1f-344fe9bc4872@linux.dev>
Date: Wed, 19 Aug 2026 08:57:08 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v7 05/10] bpf: Account R2 of register-pair
 returns in live register analysis
Content-Language: en-GB
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
References: <20260819055239.3293449-1-yonghong.song@linux.dev>
 <20260819055304.3296353-1-yonghong.song@linux.dev>
 <20260819062041.B92D41F000E9@smtp.kernel.org>
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20260819062041.B92D41F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 8/18/26 11:20 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] The verifier fails to properly model execution for BPF subprograms and kfuncs returning >8 bytes (register pairs), specifically by not restoring R2 to the caller and not verifying R2 initialization.
> --
>
> --- Patch [5]: [PATCH bpf-next v7 05/10] bpf: Account R2 of register-pair returns in live register analysis ---
> commit 1cab80ee79c6b836ae7862851a98688dd786f8f2
> Author: Yonghong Song <yonghong.song@linux.dev>
>
> bpf: Account R2 of register-pair returns in live register analysis
>
> This commit modifies live register analysis to mark R2 as read at BPF_EXIT
> when a subprogram returns a register pair, such as an __int128. This
> prevents a callee's R2 from being considered dead and incorrectly pruned
> from checkpointed states.
>
>> diff --git a/kernel/bpf/liveness.c b/kernel/bpf/liveness.c
>> index 74fc4b3f80d6e..71f998c6eb888 100644
>> --- a/kernel/bpf/liveness.c
>> +++ b/kernel/bpf/liveness.c
> [ ... ]
>
>> @@ -2191,7 +2193,7 @@ static void compute_insn_live_regs(struct bpf_verifier_env *env,
>>   			break;
>>   		case BPF_EXIT:
>>   			def = 0;
>> -			use = r0;
>> +			use = ret_reg_pair ? (r0 | r2) : r0;
> [Severity: High]
> Does the verifier also need to be updated to properly model execution for
> BPF subprograms and kfuncs returning > 8 bytes?
>
> While this patch handles the liveness side, it looks like
> kernel/bpf/verifier.c only copies or initializes BPF_REG_0 (and not
> BPF_REG_2) to the caller's state in several places.
>
> In prepare_func_exit():
>
> 		/* return to the caller whatever r0 had in the callee */
> 		bpf_diag_mod_begin(env, &caller->regs[BPF_REG_0], r0, BPF_DIAG_MOD_WRITE);
> 		caller->regs[BPF_REG_0] = *r0;
>
> In check_func_call():
>
> 		/* All non-void global functions return a 64-bit SCALAR_VALUE. */
> 		if (!returns_void) {
> 			mark_reg_unknown(env, caller->regs, BPF_REG_0);
> 			bpf_diag_mod_end(env);
> 		}
>
> In check_kfunc_call():
>
> 	if (btf_type_is_scalar(t)) {
> 		mark_reg_unknown(env, regs, BPF_REG_0);
>
> And in check_global_subprog_return_code():
>
> 	if (subprog_returns_void(env, subprog))
> 		return 0;
>
> 	return check_global_ret_scalar_reg(env, BPF_REG_0);
>
> If a program attempts to read the upper half (R2) of a 16-byte return value,
> will it be rejected by the verifier with an R2 !read_ok error?
>
> Additionally, for global subprograms returning 16-byte types, could the lack
> of R2 initialization checks allow uninitialized memory to be passed back to
> the kernel?

We should be okay, later patch "bpf: Add verifier support for 16-byte returns in R0:R2"
will add R2 support properly.

>
>>   			break;
>>   		case BPF_CALL:
>>   			def = ALL_CALLER_SAVED_REGS;

