Received: from mta0.migadu.com (out-231.mta0.migadu.com [91.218.175.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B189236605E
	for <bpf@vger.kernel.org>; Fri, 18 Sep 2026 03:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789702573; cv=none; b=nEUtHfJbhFCFK5V4mKrfqX5UBZxvmCcbx7SrTu7l7PmVTnKKqsChvGgk9VxPnjyZmezSI0RBE+8y6Sb4upGAfa0vpGmOCZ+Lj2+sIXcIzd0w/u0a7N3h5dC/MRM/srGt37vH7iatleuPO+TvsWXPPer2rpofAv/ZNT1Q2PpFzQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789702573; c=relaxed/simple;
	bh=4KVEdLH0QLlVdKzrz7jznkzMNkIiQyt/FIvzp/arJCg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ITceLJ5o5rSVl8KnSt1OBlOovZMx7TPCo8SNfrFiCxuwFNqNFpiAb3cLTxxlnFPkUpUoGh0Z/lZpQkr44mPBAWtYIHp23LvkCHE0229L0mapYkgd1Fi8epXxEHXajZLLBSdffc3sOgM6aE/ZXwDNacwDBdm+U/QTU1p3QJU3o6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=uTgemkOG; arc=none smtp.client-ip=91.218.175.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="uTgemkOG"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=4KVEdLH0QLlVdKzrz7jznkzMNkIiQyt/FIvzp/arJCg=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789702569; v=1; x=1790307369;
 b=uTgemkOGK0ZnaEcJve6Dof0l30kofuSR55U2pNbTY8JVm3j3iDFeKX+CTo+s9gSS3sWuN5aI
 JL3eN3nnieN51mPu1RA9bj5z28a0IxcS8FbSZuvhZRgbWnqkd0yOXHfdNGChb68N7RJGm9qZmKm
 2BXWLca1jnmoMrt5KcRcZA8A=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 63b6a10738dd193f;
	Fri, 18 Sep 2026 03:36:09 +0000
X-Mizu-Trace-ID: 63b6a10738dd193f
X-Migadu-Flow: FLOW_OUT
Message-ID: <f11de278-f76e-4117-bab8-fe5d9ad897d6@linux.dev>
Date: Thu, 17 Sep 2026 20:36:07 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 05/20] bpf: Make exception landing pads reachable
 in the CFG
Content-Language: en-GB
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
References: <20260917055645.3926444-1-yonghong.song@linux.dev>
 <20260917055710.3929202-1-yonghong.song@linux.dev>
 <20260917062234.CD78D1F000FF@smtp.kernel.org>
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20260917062234.CD78D1F000FF@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 9/16/26 11:22 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] bpf: bpf_unwind_resume() retains fallthrough edge in CFG walk
> --
>
> commit 663c539069f6d8aab713a59c4d2aa7c90391da34
> Author: Yonghong Song <yonghong.song@linux.dev>
>
> bpf: Make exception landing pads reachable in the CFG
>
> This commit updates the verifier's CFG walk and liveness analysis to account
> for exception landing pads. It adds edges from calls within a cleanup record's
> range to that record's landing pad. The commit message also states that
> bpf_unwind_resume() reaches nothing after it and should have no successors.
>
>> diff --git a/kernel/bpf/cfg.c b/kernel/bpf/cfg.c
>> index 842c7d1eabccc..9f8b8b54d5ea7 100644
>> --- a/kernel/bpf/cfg.c
>> +++ b/kernel/bpf/cfg.c
> [ ... ]
>> @@ -158,17 +159,57 @@ static int push_insn(int t, int w, int e, struct bpf_verifier_env *env)
> [ ... ]
>>   static int visit_func_call_insn(int t, struct bpf_insn *insns,
>>   				struct bpf_verifier_env *env,
>>   				bool visit_callee)
>>   {
>> -	int ret, insn_sz;
>> +	int ret, insn_sz, pad_ret;
>>   	int w;
>>   
>> +	pad_ret = visit_cleanup_pad_edge(t, env);
>> +	if (pad_ret < 0)
>> +		return pad_ret;
>> +
>>   	insn_sz = bpf_is_ldimm64(&insns[t]) ? 2 : 1;
>>   	ret = push_insn(t, t + insn_sz, FALLTHROUGH, env);
> [Severity: High]
> Does this unconditionally push a fallthrough edge for all call instructions,
> failing to account for non-returning kfuncs like bpf_unwind_resume()?
>
> If the compiler places a bpf_unwind_resume() call at the very end of the
> program (the end of the .text section) without any trailing instructions, will
> the CFG walk attempt to push a fallthrough edge out of bounds and incorrectly
> reject valid BPF programs with a 'jump out of range' error?

This won't happen. See verifier.c like below:

                         if (code != (BPF_JMP | BPF_EXIT) &&
                             code != (BPF_JMP32 | BPF_JA) &&
                             code != (BPF_JMP | BPF_JA)) {
                                 verbose(env, "last insn is not an exit or jmp\n");
				...
			}

>
>>   	if (ret)
>> -		return ret;
>> +		return merge_visit_ret(pad_ret, ret);
>>   
>>   	mark_prune_point(env, t + insn_sz);
> [ ... ]
>> diff --git a/kernel/bpf/liveness.c b/kernel/bpf/liveness.c
>> index 44ecdc5b4ec2d..9cfd05f970bc9 100644
>> --- a/kernel/bpf/liveness.c
>> +++ b/kernel/bpf/liveness.c
> [ ... ]
>> @@ -256,6 +258,9 @@ bpf_insn_successors(struct bpf_verifier_env *env, u32 idx)
>>   	succ = env->succ;
>>   	succ->cnt = 0;
>>   
>> +	if (unlikely(bpf_is_unwind_resume_kfunc(insn)))
>> +		return succ;
>> +
> [Severity: High]
> This correctly applies the logic mentioned in the commit message (that
> bpf_unwind_resume() reaches nothing after it and has no successors) to the
> liveness algorithm. Should visit_func_call_insn() in kernel/bpf/cfg.c be
> updated with similar logic to avoid pushing a fallthrough edge?

The same as above, bpf_unwind_resume() cannot be the last insn in the prog.

>
>>   	opcode_info = &opcode_info_tbl[BPF_CLASS(insn->code) | BPF_OP(insn->code)];
>>   	insn_sz = bpf_is_ldimm64(insn) ? 2 : 1;
>>   	if (opcode_info->can_fallthrough)

