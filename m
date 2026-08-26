Received: from mta1.migadu.com (out-59.mta1.migadu.com [95.215.58.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7CDE38238C
	for <bpf@vger.kernel.org>; Wed, 26 Aug 2026 17:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.59
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787764158; cv=none; b=rPSwRscpivdJKWqfUnYeiqQrKSzI/ARFq8iDTEDXFJ3sM374+Sc+tDjuHI8P6Bvixbrqjr8kBrBXKn7XyM7/1ZyEqOTq6TyWy4N6moZ3Sdxec8CnqFuU1JiRN9ckHu+M583yLo+m0sGRZotlHpdmZssJDqVV1w8q5viXeC7GcjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787764158; c=relaxed/simple;
	bh=yRptlCddIvKwIVZvoFDJxj9tMJw2EsA8DqoO5SRLE7Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Lk7CBiDYtWKDZp7dnZXOMIuI3jWX6HRW5fGc0Sf+o4IGCILkSq04ipejdB7RZXr9TE3nwlBmm9W7UlhIb8vNjB0XhU5NDv0p8WkDKEbZJtBW2MiVj7deZ7J9irDFp4osFp4ExyogWmyhFdcZsJSLkWD1/cLNwl87bl+nL+gpgmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=G5xdld2E; arc=none smtp.client-ip=95.215.58.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="G5xdld2E"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=yRptlCddIvKwIVZvoFDJxj9tMJw2EsA8DqoO5SRLE7Q=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787764133; v=1; x=1788368933;
 b=G5xdld2EhPmNEZ/BLK6Pug+8fllAiKzrbQPn/o5IL1qiET4NzMzuN5c1A2vf7hxweJzSWXbj
 /erWJtAIGj3v0WKd52mvNFEblJ8zEPL2Ykn1c8ri8Owbnq35iqUQcitTzmoe13zcQzp6hHqHPIW
 dXXPKkCRpDW/+dAHW2ciJa44=
X-Envelope-To: bpf@vger.kernel.org
Received: from [IPV6:2a03:83e0:1151:15:1c5e:37e8:36:dd37] (2620:10d:c090:500::7:2cdc)
	by smtp.migadu.com with ESMTPS id f01e58e0d40ca4de;
	Wed, 26 Aug 2026 17:08:53 +0000
X-Mizu-Trace-ID: f01e58e0d40ca4de
X-Migadu-Flow: FLOW_OUT
Message-ID: <47991bc5-5f31-4cf0-a979-245e75d6bad7@linux.dev>
Date: Wed, 26 Aug 2026 10:08:49 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2 01/10] bpf: Record each half of a paired
 return value in verifier diagnostics
Content-Language: en-GB
To: bot+bpf-ci@kernel.org, bpf@vger.kernel.org
Cc: ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
 eddyz87@gmail.com, kernel-team@fb.com, martin.lau@kernel.org, clm@meta.com,
 ihor.solodrai@linux.dev
References: <20260825205417.1320403-1-yonghong.song@linux.dev>
 <0406cb29c1419b2bdf8ab69ca7c14ffe6a5dacde23a387b9b43071e6017cf423@mail.kernel.org>
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <0406cb29c1419b2bdf8ab69ca7c14ffe6a5dacde23a387b9b43071e6017cf423@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 8/25/26 2:59 PM, bot+bpf-ci@kernel.org wrote:
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> index e036ae20bf6b9..9aa29c3670087 100644
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
>> @@ -10403,10 +10403,14 @@ static int prepare_func_exit(struct bpf_verifier_env *env, int *insn_idx)
>>   		 * return to the caller whatever the callee had in the
>>   		 * return register(s)
>>   		 */
>> -		bpf_diag_mod_begin(env, &caller->regs[BPF_REG_0], r0, BPF_DIAG_MOD_WRITE);
>> -		for (i = 0; i < nregs; i++)
>> -			caller->regs[ret_regs[i]] = callee->regs[ret_regs[i]];
>> -		bpf_diag_mod_end(env);
>> +		for (i = 0; i < nregs; i++) {
>> +			u32 regno = ret_regs[i];
>> +
>> +			bpf_diag_mod_begin(env, &caller->regs[regno], &callee->regs[regno],
>> +					   BPF_DIAG_MOD_WRITE);
>> +			caller->regs[regno] = callee->regs[regno];
>> +			bpf_diag_mod_end(env);
>> +		}
>>   	}
>>
>>   	/* for callbacks like bpf_loop or bpf_for_each_map_elem go back to callsite,
> This fix looks correct for prepare_func_exit(). Should check_func_call()
> and check_kfunc_call() get the same per-return-register diagnostic scope,
> or is R2 intentionally left out there?
>
> Commit 0630ad00d96d introduced the same pattern in three places, and this
> patch addresses only prepare_func_exit().
>
> In check_func_call(), the global-subprog path has:
>
>      bpf_diag_mod_begin(env, &caller->regs[BPF_REG_0], NULL, BPF_DIAG_MOD_WRITE);
>      ...
>      nregs = bpf_ret_reg_pair(env, subprog) ? 2 : 1;
>      for (i = 0; i < nregs; i++)
>              mark_reg_unknown(env, caller->regs, ret_regs[i]);
>      bpf_diag_mod_end(env);
>
> When nregs is 2, mark_reg_unknown() writes into caller->regs[BPF_REG_2],
> but the scope target is caller->regs[BPF_REG_0], so the write emits no
> BPF_DIAG_HISTORY_MOD event.
>
> Similarly in check_kfunc_call():
>
>      bpf_diag_mod_begin(env, &regs[BPF_REG_0], NULL, BPF_DIAG_MOD_WRITE);
>      ...
>      mark_kfunc_ret_regs(env, regs, t->size);   /* writes R0 and, for 8 < size <= 16, R2 */
>      ...
>      bpf_diag_mod_end(env);
>
> When t->size is between 8 and 16 bytes, mark_kfunc_ret_regs() writes the
> second half into R2, but again with no MOD event.
>
> In both cases R2 does get a BPF_DIAG_MOD_CALLER_SAVED scrub record, so
> the history shows R2 as clobbered by the call but never shows it being
> written with the second half of the return value.

Yes, I need to add these two cases for bpf_diag_mod.

>
>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/32899532405

