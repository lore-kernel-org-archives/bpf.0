Received: from mta0.migadu.com (out-3.mta0.migadu.com [91.218.175.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A2A7376481
	for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 03:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790133694; cv=none; b=YvGewuwcyOSa3PGHkNLQ+r1opKDQWS8IFGLTmBerjc/j/r8KpHnmiaLEGG/3JkbV3+i9YzEk2IM/jk69ojkHLAQNP+2j6VYD12Ki/9HX0FdL/LA4unmI8G6589hiRvXaK3bw8XcZbnx9heRLD32L2xlN4NSq6daTpEBPBBHZbx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790133694; c=relaxed/simple;
	bh=VE5F9cUcqTPF4dkuQDtGIlBIYtzoHC4F+69/bBoS+Zc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jvSAr+Lr45fnt5a+Fi87Po7hnYrTGekrKUUnd9qbeUK2MtlbcbfzuaszcwPhAnKA2S2goQfukzAXRpZSU/hmLK5WV66B5OjuG0LXbXlsmwcRkw/NRDCeGkZT3nNu+o3DmqOif42pOJ+zeSHAXmnhyXOE0bhUyZGrpTQzmMuJ2jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=q05XCEYN; arc=none smtp.client-ip=91.218.175.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="q05XCEYN"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=VE5F9cUcqTPF4dkuQDtGIlBIYtzoHC4F+69/bBoS+Zc=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790133689; v=1; x=1790738489;
 b=q05XCEYNQq6BtXgS3w+Kbxvy91hxjOQGxagseA89ey0vzC0jJzuqh1OBaQxgjjJFfsT3kDHe
 wzsbV2EAd4Ua2aD8xtq94VW+fg9gYfGWCljbmAewCd+Z0NGnuT9OUrOdh15EbWn9PgSC8sXxHRe
 2+ET5SIZai2xBSHTV+krTcGc=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 18f3e6da7363152f;
	Wed, 23 Sep 2026 03:21:29 +0000
X-Mizu-Trace-ID: 18f3e6da7363152f
X-Migadu-Flow: FLOW_OUT
Message-ID: <562907ea-47ce-402e-9d44-a6eae4aad552@linux.dev>
Date: Tue, 22 Sep 2026 20:21:26 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v4 08/20] bpf: Walk the exception unwind in the
 verifier
Content-Language: en-GB
To: Eduard Zingerman <eddyz87@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com
References: <20260921210033.1715000-1-yonghong.song@linux.dev>
 <20260921210114.1720196-1-yonghong.song@linux.dev>
 <70b068fdd15117a681fadb7cec5daa13e36d544c.camel@gmail.com>
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <70b068fdd15117a681fadb7cec5daa13e36d544c.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 9/22/26 4:43 PM, Eduard Zingerman wrote:
> On Mon, 2026-09-21 at 14:01 -0700, Yonghong Song wrote:
>
> ...
>
>> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
>> index aa631bb45f76..076739d4d974 100644
>> --- a/include/linux/bpf_verifier.h
>> +++ b/include/linux/bpf_verifier.h
> ...
>
>> @@ -991,6 +994,7 @@ struct bpf_verifier_env {
>>   	} cfg;
>>   	struct backtrack_state bt;
>>   	struct bpf_jmp_history_entry *cur_hist_ent;
>> +	u8 unwind_frames; /* scratch: frames the unwind popped to reach the next insn */
> Instead of maintaining this variable across calls to do_check() and
> unwind_step(), I think it should be possible to do bpf_push_jmp_history()
> in the uwind_step() itself.

Yes, bpf_push_jmp_history() is doable. But I think my next patch with
unwind_frames and cur_unwind_frames will be simpler. We can discuss this
in detail after posting next revision.

>
>>   	/* Per-callsite copy of parent's converged at_stack_in for cross-frame fills. */
>>   	struct arg_track **callsite_at_stack;
>>   	u32 pass_cnt; /* number of times do_check() was called */
>> diff --git a/kernel/bpf/backtrack.c b/kernel/bpf/backtrack.c
> ...
>
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> index 680ae191aa3f..2bc08c18ebc8 100644
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
> ...
>
>> @@ -18510,9 +18513,108 @@ enum {
>>   	INSN_IDX_UPDATED = 2,
>>   };
>>   
>> -static int process_bpf_exit_full(struct bpf_verifier_env *env,
>> -				 bool *do_print_state,
>> -				 bool exception_exit)
>> +static u32 unwind_pop_frame(struct bpf_verifier_env *env)
>> +{
> This function duplicates the code in prepare_func_exit(),
> I'd suggest renaming it to `pop_frame` and calling it from
> prepare_func_exit() as well.

Good point. We want to avoid duplication.

>
>> +	struct bpf_verifier_state *state = env->cur_state;
>> +	struct bpf_func_state *callee = state->frame[state->curframe];
>> +	u32 callsite = callee->callsite;
>> +	struct bpf_func_state *caller;
>> +
>> +	caller = state->frame[state->curframe - 1];
>> +	account_processed_insns(env, callee, caller);
>> +	free_func_state(callee);
>> +	state->frame[state->curframe--] = NULL;
>> +	invalidate_outgoing_stack_args(env, caller);
>> +	return callsite;
>> +}
> ...

