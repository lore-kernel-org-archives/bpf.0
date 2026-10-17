Received: from mta0.migadu.com (out-60.mta0.migadu.com [91.218.175.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD28F4CF465
	for <bpf@vger.kernel.org>; Sat, 17 Oct 2026 05:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.60
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792214645; cv=none; b=cosDewg0ipoqXn9nyamM251N+RvkdAZ3h113s3Sl1E7gBqlo5rsZcUDHU/9XqIy53rFH4E0YiLgeUg6hJNb1CLxBkC7ZNz3B7bqfFatNeVp5g+lKWydrqIBfRZ67bAtvqxR04m5JJXuNtSMFL87ICg+z7IE11vp/8kL1xQCaT/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792214645; c=relaxed/simple;
	bh=V71HwRlcRmnhrJOuBbvoS0H+bd9OgyZZDE0JcqZgMpU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=sF2tICf5FpNPA8W+lxNClIi+4X93MiiK0ttJjCM9h02Hku+3sxQZAkLdAJz6ATnQ9/WhNwbFJobs3NP+/RWL4O31G8mYgeF1pYYmmkrhEqla2xNnLlN5NeW6azDBZ6WeQ5P4eJGfwcwMVEnAef+dJUX/8h6gCshtHzut1yZgkSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=tRE97Lal; arc=none smtp.client-ip=91.218.175.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="tRE97Lal"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=V71HwRlcRmnhrJOuBbvoS0H+bd9OgyZZDE0JcqZgMpU=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792214640; v=1; x=1792819440;
 b=tRE97LaluRTgCsNeh9EqlZGAyr1nt73KdSCMJVpbO1FwMkP9CUMe9fBP6o93APrUMg45hoC7
 PRCP/Hv/dDT1Mu42hKhS7uDBa6Vv4+SLKFdUvDT3IOF3FkQq29cBq/JmPgBZ5zqQ6ERrmi4Q1k/
 wwaPXaUqLkyppNU8Kvy+ps1U=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 6f4c53a09c9c65fa;
	Sat, 17 Oct 2026 05:24:00 +0000
X-Mizu-Trace-ID: 6f4c53a09c9c65fa
X-Migadu-Flow: FLOW_OUT
Message-ID: <05918478-1564-4e6f-874a-1a3c4c084097@linux.dev>
Date: Fri, 16 Oct 2026 22:23:58 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v12 07/25] bpf: Refuse a callback that can unwind
To: sashiko-reviews@lists.linux.dev, bpf@vger.kernel.org
References: <20261017025129.1914859-1-yonghong.song@linux.dev>
 <20261017025206.1920523-1-yonghong.song@linux.dev>
 <sashiko-outbox-175238@kernel.org>
Content-Language: en-GB
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <sashiko-outbox-175238@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/16/26 8:19 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] bpf: missing might_unwind propagation to callback in bpf_check_cfg()
> --
>
> commit 1785732c5b5ae17b86f08f6a94449da36fb9c958
> Author: Yonghong Song <yonghong.song@linux.dev>
>
> bpf: Refuse a callback that can unwind
>
> This commit adds bpf_exc_check_callback() and calls it in
> push_callback_call() to reject callback subprograms that have
> might_unwind set.
>
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> index fce2baa6272d1..fcf0d0fe0f2ff 100644
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
>> @@ -11191,6 +11191,10 @@ static int push_callback_call(struct bpf_verifier_env *env, struct bpf_insn *ins
>>   	 * callbacks
>>   	 */
>>   	env->subprog_info[subprog].is_cb = true;
>> +	err = bpf_exc_check_callback(env, subprog);
>> +	if (err)
>> +		return err;
>> +
>>   	if (bpf_pseudo_kfunc_call(insn) &&
>>   	    !is_callback_calling_kfunc(insn->imm)) {
>>   		verifier_bug(env, "kfunc %s#%d not marked as callback-calling",
> [Severity: High]
> Can a callback subprogram that transitively calls bpf_unwind() bypass
> bpf_exc_check_callback() with env->subprog_info[subprog].might_unwind
> still false?
>
> In bpf_check_cfg(), direct calls (BPF_PSEUDO_CALL), function address
> loads (BPF_PSEUDO_FUNC), and read-only map function pointer loads
> (insn_func_ptrs()) are explored in a single DFS sharing
> env->cfg.insn_state[]:
>
> kernel/bpf/cfg.c:merge_callee_effects() {
> 	caller = bpf_find_containing_subprog(env, t);
> 	callee = bpf_find_containing_subprog(env, w);
> 	caller->changes_pkt_data |= callee->changes_pkt_data;
> 	caller->might_sleep |= callee->might_sleep;
> 	caller->might_throw |= callee->might_throw;
> 	caller->might_unwind |= callee->might_unwind;
> }
>
> merge_callee_effects() relies on callee w already being EXPLORED when
> returning to caller t. However, if subprogram H has a conditional branch
> whose fallthrough loads a read-only map containing the address of
> callback cb via insn_func_ptrs() (or loads cb via BPF_PSEUDO_FUNC when H
> is explored from a cleanup pad before main's fallthrough) and whose jump
> target calls bpf_unwind(), while cb calls H via BPF_PSEUDO_CALL:
>
> 1. bpf_check_cfg() enters H (marking insn_state[w_H] = DISCOVERED) and
>     explores H's fallthrough first, before visiting H's bpf_unwind()
>     branch, so H->might_unwind is still false.
>
> 2. H's fallthrough visits cb via visit_func_ptrs_insn() or
>     visit_func_call_insn().
>
> 3. When cb visits its BPF_PSEUDO_CALL to H, merge_callee_effects() sees
>     H->might_unwind == false, and push_insn() sees
>     (insn_state[w_H] & 0xF0) == DISCOVERED and returns DONE_EXPLORING.
>     Thus cb finishes CFG exploration with cb->might_unwind == false
>     before H explores its bpf_unwind() branch and sets
>     H->might_unwind = true.
>
> 4. At the end of bpf_check_cfg(), mark_callx_might_unwind() checks
>     addr_taken_subprog_might_unwind():
>
> kernel/bpf/cfg.c:mark_callx_might_unwind() {
> 	if (!addr_taken_subprog_might_unwind(env))
> 		return;
>      ...
> }
>
>     Because the address-taken subprogram cb still has might_unwind == false,
>     addr_taken_subprog_might_unwind() returns false and skips the
>     fixed-point propagation loop.

The previous patch 6 indeed has a bug and this may cause
addr_taken_subprog_might)unwind() return false and this will cause
issues. Fixing patch 6 issue should fix the issue.

>
> 5. Neither sort_subprogs_topo() nor check_max_stack_depth() rejects the
>     program because insn_func_ptrs() edges are not call edges and async
>     BPF_PSEUDO_FUNC callbacks are skipped in stack depth checks.
>
> When push_callback_call() then calls bpf_exc_check_callback(env, cb),
> env->subprog_info[cb].might_unwind is false, allowing the unwinding
> callback to pass verification and cause a verifier/runtime control-flow
> mismatch or jump to a zero epilogue_ip when bpf_unwind() is invoked at
> runtime.
>

