Received: from mta1.migadu.com (out-169.mta1.migadu.com [95.215.58.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F01803BFAEE
	for <bpf@vger.kernel.org>; Fri,  2 Oct 2026 21:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790977719; cv=none; b=kvRCzwwNTQZ//kdr/QKVmyMbd+nkIOZRIwcIZJva9d4addCZhfQV2ev09kWJi4CKNsCeqxI/VJVe/jv5S6O8eqOSqvJ+45LG/4RlVOQKcXGSF4snNMp/NFrTHjAbrekbfY3T2OLO6scI0IF3Y5zwlHURox8yYw7We30ZiYXb1F8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790977719; c=relaxed/simple;
	bh=Px2zDx3k2WzgHIJFNOO646cnRMzlphlulsCZZRiMXh8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I63enz7VsyV9q7sarKnCOU/3K+uIBsqISIXzex0Q7EGgE+LISvcdMeOG6chpV78i50PAm7jA7829IWUVyjLrD0guXIYU78sqCbsOcc4OnOeX+Ynmd2fqpVNom1YKVUiXN86hfEnEOzkdIFx7/48ikhuq9bGse7lQVhumWlL72sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=SB+/H0rX; arc=none smtp.client-ip=95.215.58.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="SB+/H0rX"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=Px2zDx3k2WzgHIJFNOO646cnRMzlphlulsCZZRiMXh8=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790977713; v=1; x=1791582513;
 b=SB+/H0rX/T8MOMa8L7LROqnp6tV/5qU+09BuUAgGp6Tl6ZQF6MrS9eQKcCCWhvGkvO4yMzo9
 8e2DFp5T4tRXPpolSoBuKH4zh+79x4da8d4ovn7g8nSKkHSyVsLP2ImOr3PczB0BusCX7izpewq
 DD6VTtkEloK+VjY7wJFwRIu4=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id a2388ac972f022f0;
	Fri, 02 Oct 2026 21:48:33 +0000
X-Mizu-Trace-ID: a2388ac972f022f0
X-Migadu-Flow: FLOW_OUT
Message-ID: <2434faf2-bda5-46a4-80a1-c812ba33740d@linux.dev>
Date: Fri, 2 Oct 2026 22:48:32 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v8 11/22] bpf: Dispatch cleanup pads by rewriting
 return addresses
Content-Language: en-GB
To: bot+bpf-ci@kernel.org, bpf@vger.kernel.org
Cc: ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
 eddyz87@gmail.com, kernel-team@fb.com, martin.lau@kernel.org,
 mason@kernel.org, ihor.solodrai@linux.dev
References: <20261001133103.1340994-1-yonghong.song@linux.dev>
 <b58f9d00b6f644f682dd854f6e70f63f9e7dcf21deed32913df3838bf0947b21@mail.kernel.org>
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <b58f9d00b6f644f682dd854f6e70f63f9e7dcf21deed32913df3838bf0947b21@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/1/26 7:31 AM, bot+bpf-ci@kernel.org wrote:
>> bpf: Dispatch cleanup pads by rewriting return addresses
> TL;DR: Design question, not a bug: bpf_exc_attach_main_prog() in
> bpf_prog_jit_compile() builds a table for single-function programs that seems
> never to be read, so it and its error paths could possibly be dropped.
>
>> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
>> index d813fdde29e3..60905643cb9c 100644
>> --- a/kernel/bpf/core.c
>> +++ b/kernel/bpf/core.c
> [ ... ]
>
>> @@ -2632,9 +2633,14 @@ static struct bpf_prog *bpf_prog_jit_compile(struct bpf_verifier_env *env, struc
>>   {
>>   #ifdef CONFIG_BPF_JIT
>>   	struct bpf_prog *orig_prog;
>> +	int ret;
>>   
>> -	if (!bpf_prog_need_blind(prog))
>> +	if (!bpf_prog_need_blind(prog)) {
>> +		ret = bpf_exc_attach_main_prog(env, prog);
>> +		if (ret)
>> +			return ERR_PTR(ret);
>>   		return bpf_int_jit_compile(env, prog);
>> +	}
>>   
>>   	orig_prog = prog;
>>   	prog = bpf_jit_blind_constants(env, prog);
>> @@ -2648,6 +2654,12 @@ static struct bpf_prog *bpf_prog_jit_compile(struct bpf_verifier_env *env, struc
>>   		goto out_restore;
>>   	}
>>   
>> +	ret = bpf_exc_attach_main_prog(env, prog);
>> +	if (ret) {
>> +		bpf_jit_prog_release_other(orig_prog, prog);
>> +		return ERR_PTR(ret);
>> +	}
>> +
>>   	prog = bpf_int_jit_compile(env, prog);
>>   	if (prog->jited) {
>>   		bpf_jit_prog_release_other(prog, orig_prog);
> this isn't a bug, but is the table that bpf_exc_attach_main_prog() builds
> for a single-function program read anywhere?
>
> It only attaches a table when there are no subprograms:
>
> kernel/bpf/fixups.c:bpf_exc_attach_main_prog() {
>      if (!env || env->subprog_cnt > 1)
>          return 0;
>      return exc_info_for_subprog(env, prog, 0, prog->len);
> }
>
> The only reader of the table that I can find is bpf_unwind_rewrite(), and it
> returns at the first BPF frame before it does the pad lookup:
>
> kernel/bpf/helpers.c:bpf_unwind_rewrite() {
>      ...
>      if (ctx->cnt == 1)
>          return bpf_is_subprog(prog);
>
>      rec = bpf_exc_pad_for_ip(prog, ip);
>      ...
> }
>
> With no subprograms, the main frame is the only BPF frame, so it is always
> the one with ctx->cnt == 1 and bpf_exc_pad_for_ip() is not reached for it.
> The bpf_unwind() calls in such a program are already sent to their pad by
> the jump that bpf_exc_patch_unwind_calls() inserts.
>
> If that is right, could bpf_exc_attach_main_prog() and its two call sites in
> bpf_prog_jit_compile(), with the new 'return ERR_PTR(ret)' paths, be dropped
> so that bpf_prog_jit_compile() stays as it was?

You are right. So dead code. Will remove.

>
>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/36872142096

