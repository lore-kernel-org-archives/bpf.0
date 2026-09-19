Received: from mta0.migadu.com (out-249.mta0.migadu.com [91.218.175.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B480E377AB4
	for <bpf@vger.kernel.org>; Sat, 19 Sep 2026 19:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789846360; cv=none; b=Ue/J03RRDBOyZwz1U9Faw4JdvF42GFO3OvCCspPdnZw7vec9aQ8gJ4LRHCyPCTPohQZBLWTqax18IepwTXeIq1ajLpkBzks8H64pUVVj4pfHiE34RefpSVyLcLfP/aQuLU1zxc4XCBsu1G8RZI+iYuu0GG5wAxjB8xatIyoJT80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789846360; c=relaxed/simple;
	bh=jFCYFf4wh4M6j+z8YckGEDoF4XU+4mVBq3jbOhk1KVI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PaUUhlH3rh8RG0YLytAGaaODBzYwujmmMIxng1Opze2uWL8g+UihaxiZ+pVdibIYRMsR1DkHCl6eEPU3I0Eu0hysYmLzshxKZcgAXbFqBxoPw7DOb1FJuqPJP51qmsTwa74qKnm/Sl3WaFtJapQHRXzZyglv9tq12Fim5M5G+Ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=i+Qry1Fb; arc=none smtp.client-ip=91.218.175.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="i+Qry1Fb"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=jFCYFf4wh4M6j+z8YckGEDoF4XU+4mVBq3jbOhk1KVI=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789846354; v=1; x=1790451154;
 b=i+Qry1FbgKXVAOJObTFvWvmuB/xuE21ut8jvQ8hmHqeZt/D0odqXw9hMhNWsI02DMu8jvILs
 DisqOOEzEW49LYVN2ay0kuN4JsrUengb5KOcMPYTdmSRgN+Fj1tGNMu0ybK52eIm9+RPTOcXBJs
 /0NlBDeRvYljCJIBMG1Vsp3Q=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 1793d1eb6f95d2f8;
	Sat, 19 Sep 2026 19:32:24 +0000
X-Mizu-Trace-ID: 1793d1eb6f95d2f8
X-Migadu-Flow: FLOW_OUT
Message-ID: <bd29b455-dce5-4708-8fe7-e8baf437ed66@linux.dev>
Date: Sat, 19 Sep 2026 12:32:17 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2 05/20] bpf: Make exception landing pads
 reachable in the CFG
Content-Language: en-GB
To: bot+bpf-ci@kernel.org, bpf@vger.kernel.org
Cc: ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
 eddyz87@gmail.com, kernel-team@fb.com, martin.lau@kernel.org,
 mason@kernel.org, ihor.solodrai@linux.dev
References: <20260918044221.3287431-1-yonghong.song@linux.dev>
 <f6f9de46294b24824fb67c5246d73bc720391d52e5dd4cf36af398a215fbb414@mail.kernel.org>
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <f6f9de46294b24824fb67c5246d73bc720391d52e5dd4cf36af398a215fbb414@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 9/17/26 10:44 PM, bot+bpf-ci@kernel.org wrote:
>> diff --git a/kernel/bpf/liveness.c b/kernel/bpf/liveness.c
>> index 44ecdc5b4ec2d..9cfd05f970bc9 100644
>> --- a/kernel/bpf/liveness.c
>> +++ b/kernel/bpf/liveness.c
>> @@ -8,6 +8,8 @@
>>   #include <linux/slab.h>
>>   #include <linux/sort.h>
>>
>> +#include "exception.h"
>> +
>>   #define verbose(env, fmt, args...) bpf_verifier_log_write(env, fmt, ##args)
>>
>>   struct per_frame_masks {
>> @@ -256,6 +258,9 @@ bpf_insn_successors(struct bpf_verifier_env *env, u32 idx)
>>   	succ = env->succ;
>>   	succ->cnt = 0;
>>
>> +	if (unlikely(bpf_is_unwind_resume_kfunc(insn)))
>> +		return succ;
>> +
> Should this early return be gated on env->cleanup_info_cnt?
>
> bpf_unwind_resume() is an unconditionally registered generic kfunc with no
> KF_ flag restricting it to programs that carry a cleanup table. Its body
> is empty, so at run time the call simply returns and execution continues
> at the next instruction.

This should be okay without env->cleanup_info_cnt guard. Eventually if
bpf_unwind_resume() is not in cleanup region, a verifier error message
will be in the log.

>
> visit_insn() in cfg.c still gives the call a fallthrough edge, and at this
> commit nothing in do_check() rejects a bpf_unwind_resume() call that is not
> the tail of a cleanup landing pad. So any CAP_BPF program with no cleanup
> table can call bpf_unwind_resume() and keep executing after it.
>
> For such a program, bpf_insn_successors() reports zero successors, so
> bpf_compute_live_registers() treats everything after the call as dead. The
> register-cleaning side fails closed (a poisoned slot is rejected), but the
> 32-bit zero-extension side fails open:
>
> insn_aux[i].zext_dst for an insn preceding the call is only set when the
> hi half of the defined register is live-after, so it stays false, and
> bpf_opt_subreg_zext_lo32_rnd_hi32() (kernel/bpf/fixups.c:706) then does
> 'if (!aux[adj_idx].zext_dst) { if (!rnd_hi32) continue; ... }' and emits
> no BPF_ZEXT_REG.
>
> On architectures where bpf_jit_needs_zext() is true and kfunc calls are
> supported (s390, riscv64, powerpc64, parisc, x86-32), the upper 32 bits of
> a register the verifier proved to be 32-bit bounded are left with stale
> JIT-defined contents, which defeats the range checks the verifier derived
> for it.
>
> Compare with the pad lookup ten lines below:
>
>>   	opcode_info = &opcode_info_tbl[BPF_CLASS(insn->code) | BPF_OP(insn->code)];
>>   	insn_sz = bpf_is_ldimm64(insn) ? 2 : 1;
>>   	if (opcode_info->can_fallthrough)
>> @@ -264,6 +269,13 @@ bpf_insn_successors(struct bpf_verifier_env *env, u32 idx)
>>   	if (opcode_info->can_jump)
>>   		succ->items[succ->cnt++] = idx + bpf_jmp_offset(insn) + 1;
>>
>> +	if (unlikely(env->cleanup_info_cnt)) {
>> +		int pad = bpf_cleanup_pad_of_call(env, idx);
>> +
>> +		if (pad >= 0)
>> +			succ->items[succ->cnt++] = pad;
>> +	}
> which gates the pad lookup on cleanup_info_cnt, and with
> visit_cleanup_pad_edge() in kernel/bpf/cfg.c which returns DONE_EXPLORING
> when !env->cleanup_info_cnt.
>
> Would gating the early return on env->cleanup_info_cnt fix this?  That
> would be sound because a program that carries a cleanup table is
> additionally constrained (bpf_jit_supports_cleanup_pads() plus, from commit
> fa6890df61539 onward, the requirement that a resume sit at the end of a
> landing pad), whereas a program with cleanup_info_cnt == 0 must keep the
> ordinary fallthrough successor of the call.

As I mentioned, previous gating with "env->cleanup_info_cnt" is not
necessary.

>
>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/35308528711

