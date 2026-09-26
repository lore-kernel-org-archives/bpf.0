Received: from mta1.migadu.com (out-51.mta1.migadu.com [95.215.58.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C5553A7580
	for <bpf@vger.kernel.org>; Sat, 26 Sep 2026 23:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790466847; cv=none; b=Z6cQsSasJ+/nq+3YsckZPSnmd67vERGFeYQRAMV43qf3bp6F4TwUXhCUQ4O7tQ1EIx15kJDKtGJDyHkrnCx9u+gDLWsjaOaYmzP46naCaJBHsbrBchj8H2ntyDTpAAwitlpA3yO4pgY3JzsA7cbQJCLX+mqy9s4g4fZis85VFiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790466847; c=relaxed/simple;
	bh=jnoEmM6Qt97VgN8QiJcQ9FUn+SKqvZTHZvARRfMvd5Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B0fQ6SH4cTMbFZGElBy0wsQE5Cm9aka4WGBW5/erLCv3sKeJI5JmfIE4r0tcgUDcF0BnzJg9ej67rjtBS67BCgSN+7m+Wn1cPNMgXo4TaKLl3unqP1JALeMWCDbDeaB41ZnK+TrP+UyWM5MRwv535StkFbe1CgHMKBR7fgi7DkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Uu71l1yc; arc=none smtp.client-ip=95.215.58.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Uu71l1yc"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=jnoEmM6Qt97VgN8QiJcQ9FUn+SKqvZTHZvARRfMvd5Q=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790466842; v=1; x=1791071642;
 b=Uu71l1ycIj0yOV6+j6EOtPEijyww68ppYu7nIrmc+/poog9buUXrSuJwe3PdvjplcDZd3LJ5
 s3NV0dN2i59n268f5mHWi+xK+2Tg08/xwA7TLXbnSPFkgo3NjIRbyWqXdCBOMh/wRbq00N2Z2N8
 QHuvh5ykowaAiuOKPkjqFLXw=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 23df2140449d7eee;
	Sat, 26 Sep 2026 23:54:02 +0000
X-Mizu-Trace-ID: 23df2140449d7eee
X-Migadu-Flow: FLOW_OUT
Message-ID: <d19b799a-03d6-4902-91ff-9b97d54c3fd4@linux.dev>
Date: Sat, 26 Sep 2026 16:54:00 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v6 05/21] bpf: Prepare for an exception cleanup
 table before the CFG walk
Content-Language: en-GB
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
References: <20260926050006.2213110-1-yonghong.song@linux.dev>
 <20260926050032.2215748-1-yonghong.song@linux.dev>
 <20260926051638.867681F00893@smtp.kernel.org>
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20260926051638.867681F00893@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 9/25/26 10:16 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] bpf: bpf_throw() bypasses exception_callback_subprog check skipping cleanup pads
> --
>
> commit bfb14bc84bb67f59ae10ca034e824ec0357d7d80
> Author: Yonghong Song <yonghong.song@linux.dev>
>
> bpf: Prepare for an exception cleanup table before the CFG walk
>
> This commit introduces bpf_prepare_cleanup_exceptions() to record landing pads
> for BPF-to-BPF calls and bpf_unwind() within a cleanup record's range. It
> ensures the JIT supports dispatching landing pads and refuses to combine
> tables with an exception callback.
>
>> diff --git a/kernel/bpf/exception.c b/kernel/bpf/exception.c
>> index b19fcbf49b7ef..1ed0370a171b7 100644
>> --- a/kernel/bpf/exception.c
>> +++ b/kernel/bpf/exception.c
>> @@ -7,9 +7,56 @@
>>   #include <linux/filter.h>
>>   #include "exception.h"
>>   
>> +#define verbose(env, fmt, args...) bpf_verifier_log_write(env, fmt, ##args)
>> +
>>   BTF_ID_LIST_SINGLE(bpf_unwind_id, func, bpf_unwind)
>>   BTF_ID_LIST_SINGLE(bpf_unwind_resume_id, func, bpf_unwind_resume)
>>   
>> +static void mark_call_sites(struct bpf_verifier_env *env)
>> +{
>> +	u32 i, j;
>> +
>> +	for (i = 0; i < env->cleanup_info_cnt; i++) {
>> +		struct bpf_cleanup_info *rec = &env->cleanup_info[i];
>> +
>> +		for (j = rec->begin_off; j < rec->end_off; j++) {
>> +			struct bpf_insn *insn = &env->prog->insnsi[j];
>> +
>> +			if (!bpf_pseudo_call(insn) && !bpf_is_unwind_kfunc(insn))
>> +				continue;
> [Severity: Medium]
> Since bpf_throw() is not matched here, does it skip receiving a landing pad?
>
> If a program is loaded with .bpf_cleanup records and calls bpf_throw() without
> specifying a custom exception callback, could this cause it to silently bypass
> the cleanup execution during unwinding, leaking user-defined logical resources
> like map-based counters?

Yes, when bpf_throw() is triggered and landing pad has some resource to be
released, it is possible those resource is not released. Will reject
bpf_throw() if *any* landing pad exists in the program.

>
>> +			env->insn_aux_data[j].cleanup_pad = rec->landing_pad_off + 1;
>> +		}
>> +	}
>> +}
>> +
>> +int bpf_prepare_cleanup_exceptions(struct bpf_verifier_env *env)
>> +{
> [ ... ]
>
>> +	if (!bpf_jit_supports_cleanup_pads() || !env->prog->jit_requested) {
>> +		verbose(env,
>> +			"exception cleanup needs a JIT that can dispatch landing pads\n");
>> +		return -EOPNOTSUPP;
>> +	}
>> +	env->prog->jit_required = 1;
>> +
>> +	if (env->exception_callback_subprog) {
> [Severity: Medium]
> Does this check the state of env->exception_callback_subprog too early?
>
> If a later pass dynamically inserts a default exception callback, could it
> bypass this restriction and result in a mix of exception cleanup tables and
> bpf_throw() usage?

In the beginning of bpf_prepare_cleanup_exceptions(), we have

+       if (!env->cleanup_info_cnt)
+               return 0;

so landing_pad will exist in the prog. With previous explanation, that
means bpf_throw() will be rejected. So reject exception_callback_subprog
too.

>
>> +		verbose(env,
>> +			"exception cleanup table cannot be combined with an exception callback\n");
>> +		return -EINVAL;
>> +	}
>> +
>> +	mark_call_sites(env);
>> +	return 0;
>> +}

