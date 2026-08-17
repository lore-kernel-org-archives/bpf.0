Received: from mta1.migadu.com (out-221.mta1.migadu.com [95.215.58.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50B4D4457CF
	for <bpf@vger.kernel.org>; Mon, 17 Aug 2026 15:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786981219; cv=none; b=HZwZwiyuDbOvpWGKOvaQg1jZ1YYQgb9PXGZE7XHJIn2WqfegKuTvnzlrytcQlZ0ED1aSp9Vzr5tY6AcdEDwmebQYl1Pu9xVLU8AxofJyBKDuPalijRsZClL0gi2f+jt6p9LhAjYPjpXUaa73pggtvC/9LoX8ZnSDdfD6ALzPjoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786981219; c=relaxed/simple;
	bh=FJgFdu/ffLhe8fA1YtSM6rw0vqDXM7Ut1m2HBm00pPg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EoMI1YG1PRlOxwgL2nR0YMg0TGl4JGrRT3J/kD1AOI35FDmXA+KHLQy43CkuYTo2P7qte4uFcdGBhYOHOpB0+Y428P/ZOq88LER9RAgdXlPtgVUy5srH7+lURdxiQH2NKFLzx6kWKFoTK3rZsqW8GZsAg1d1Z+L/r0AGhS0IeYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=L5dytUmf; arc=none smtp.client-ip=95.215.58.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="L5dytUmf"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=FJgFdu/ffLhe8fA1YtSM6rw0vqDXM7Ut1m2HBm00pPg=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1786981214; v=1; x=1787586014;
 b=L5dytUmfnVwG55zYXUrSRxNwv6/hum8rcfxMX7tjYmLCnm6CPQ/NSEg2UR8IF2AfgyEpsJNh
 1ByXrpt+nTDNfm1ocuc+rO3WjhnHexOF8uMP1FsRkEs5Pf3Db+OMBO2zsqrSayfSrX3U5t7CX4Z
 DCdW0wuQ9DkDyK4Ztz/GIlZA=
X-Envelope-To: bpf@vger.kernel.org
Received: from [IPV6:2a03:83e0:1151:15:1c5e:37e8:36:dd37] (2620:10d:c090:500::7:5604)
	by smtp.migadu.com with ESMTPS id 88af39c8beda6d5a;
	Mon, 17 Aug 2026 15:40:13 +0000
X-Migadu-Flow: FLOW_OUT
Message-ID: <83cf5ba4-810d-44e5-a298-7b81c9dcced8@linux.dev>
Date: Mon, 17 Aug 2026 08:40:11 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v6 05/10] bpf: Account R2 of register-pair
 returns in live register analysis
Content-Language: en-GB
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
References: <20260817042141.2286086-1-yonghong.song@linux.dev>
 <20260817042207.2289995-1-yonghong.song@linux.dev>
 <20260817044342.66D1E1F000E9@smtp.kernel.org>
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20260817044342.66D1E1F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 8/16/26 9:43 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 3 potential issue(s) to consider:
> - [Critical] When a BPF program with 16-byte returns falls back to the interpreter (e.g., if JIT is disabled), the interpreter silently discards the upper 8 bytes (R2) of the return value, causing runtime data corruption.
> - [High] The verifier fails to propagate or initialize BPF_REG_2 back to the caller for subprograms and kfuncs returning 16-byte values, rendering the feature unusable.
> - [High] The verifier fails to validate the safety of BPF_REG_2 at the exit of global subprograms returning 16-byte values, allowing potential pointer leaks or returning uninitialized memory.
> --
>
> --- Patch [5]: [PATCH bpf-next v6 05/10] bpf: Account R2 of register-pair returns in live register analysis ---
> commit 1e84baf022beac38fd11fa1a392f1c5622154586
> Author: Yonghong Song <yonghong.song@linux.dev>
>
> bpf: Account R2 of register-pair returns in live register analysis
>
> This commit updates the live register analysis to account for subprograms
> returning a 16-byte register pair. It modifies compute_insn_live_regs()
> to mark BPF_REG_2 as read during BPF_EXIT when a subprogram returns a
> register pair.
>
>> diff --git a/kernel/bpf/liveness.c b/kernel/bpf/liveness.c
>> index 74fc4b3f80d6e..71f998c6eb888 100644
>> --- a/kernel/bpf/liveness.c
>> +++ b/kernel/bpf/liveness.c
> [ ... ]
>> @@ -2191,7 +2193,7 @@ static void compute_insn_live_regs(struct bpf_verifier_env *env,
>>   			break;
>>   		case BPF_EXIT:
>>   			def = 0;
>> -			use = r0;
>> +			use = ret_reg_pair ? (r0 | r2) : r0;
>>   			break;
> [Severity: High]
> How does the verifier propagate BPF_REG_2 back to the caller for subprograms
> and kfuncs returning 16-byte values?
>
> In kernel/bpf/verifier.c:prepare_func_exit(), only BPF_REG_0 is copied from
> the callee's state to the caller's state:
>
> kernel/bpf/verifier.c:prepare_func_exit() {
> 	...
> 	/* return to the caller whatever r0 had in the callee */
> 	bpf_diag_mod_begin(env, &caller->regs[BPF_REG_0], r0, BPF_DIAG_MOD_WRITE);
> 	caller->regs[BPF_REG_0] = *r0;
> 	bpf_diag_mod_end(env);
> 	...
> }
>
> Similarly, when returning from a non-void global subprogram or a kfunc, only
> BPF_REG_0 is initialized as a scalar. For instance, in check_func_call():
>
> kernel/bpf/verifier.c:check_func_call() {
> 	...
> 	/* All non-void global functions return a 64-bit SCALAR_VALUE. */
> 	if (!returns_void) {
> 		mark_reg_unknown(env, caller->regs, BPF_REG_0);
> 		bpf_diag_mod_end(env);
> 	}
> 	...
> }
>
> And in check_kfunc_call():
>
> kernel/bpf/verifier.c:check_kfunc_call() {
> 	...
> 	if (btf_type_is_scalar(t)) {
> 		mark_reg_unknown(env, regs, BPF_REG_0);
> 	...
> }
>
> Since clear_caller_saved_regs() marks R1-R5 as NOT_INIT prior to the call,
> would this leave the caller's BPF_REG_2 uninitialized, causing the verifier
> to reject legitimate reads of the upper 8 bytes of the return value?

This should be okay. The BPF_REG_2 is introduced in later patch
   bpf: Add verifier support for 16-byte returns in R0:R2

>
> [Severity: High]
> Is the safety of BPF_REG_2 validated at the exit of global subprograms
> returning 16-byte values?
>
> In kernel/bpf/verifier.c:check_global_subprog_return_code(), the return code
> validation is only performed for BPF_REG_0:
>
> kernel/bpf/verifier.c:check_global_subprog_return_code() {
> 	...
> 	return check_global_ret_scalar_reg(env, BPF_REG_0);
> }
>
> Could this omit BPF_REG_2 for register-pair returns, potentially allowing a
> global subprogram to return an unreferenced pointer, a map value pointer, or
> uninitialized memory without being caught by the verifier?

The same as above. The BPF_REG_2 is introduced in later patch
   bpf: Add verifier support for 16-byte returns in R0:R2


>
> [Severity: Critical]
> What happens if a BPF program with 16-byte returns falls back to the
> interpreter?
>
> If JIT is not requested, bpf_compute_subprog_ret_regs() exits early without
> setting env->prog->jit_required = 1:
>
> kernel/bpf/verifier.c:bpf_compute_subprog_ret_regs() {
> 	...
> 	if (!env->prog->jit_requested || bpf_prog_is_offloaded(env->prog->aux))
> 		return 0;
> 	...
> }
>
> This permits the program to fall back to the interpreter. However, the
> interpreter handles subprogram calls via JMP_CALL_ARGS, which only propagates
> BPF_R0:
>
> kernel/bpf/core.c:___bpf_prog_run() {
> 	...
> 	JMP_CALL_ARGS:
> 		BPF_R0 = interpreters_args[insn->off](BPF_R1, BPF_R2, BPF_R3,
> 						      BPF_R4, BPF_R5,
> 						      insn + insn->imm + 1);
> 		CONT;
> 	...
> }
>
> Since the PROG_NAME_ARGS macro generates functions that return a single u64,
> does the interpreter silently discard the upper 8 bytes (R2) of the return
> value, causing data corruption at runtime?
>
>>   		case BPF_CALL:
>>   			def = ALL_CALLER_SAVED_REGS;

In such case (jit not requested), verifier will fail. For example,
suppose the subprog will return R0:R2, but in interpreter mode, only
R0 is returned. R2 is not initialized. In caller, when trying to
return R2, but R2 is not initialized, so verifier will fail.

