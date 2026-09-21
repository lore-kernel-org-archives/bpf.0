Received: from mta0.migadu.com (out-110.mta0.migadu.com [91.218.175.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C6954BB7E4
	for <bpf@vger.kernel.org>; Mon, 21 Sep 2026 14:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789999721; cv=none; b=Qv/TzfCne/ssV43U8yX3v5aQjfL/uf/JvMlQFomXJn5MW7IRl1VHKIH+XovM0MugHmirWpv3ppDUO1EfZDpxVa9nHsOZr6YQIkpHlWrPXQzqJu+8H21hbgEtN3q2pUHJZ+zeHsoUVMUa43Vdo0Koo8lMV7nf3REhLZfOK8tN5i4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789999721; c=relaxed/simple;
	bh=HmI19fo1h7M4xaBqEoQ0a/ICse3F5X5A4tr2M7z2DCQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a1fYE7VvTHc/qbUauL5T/PxFyTw8XeDjikXKG50F5p5JwaftZzMLx6hG6Yh25YQt937MPUjOBuHynP21BZl3tNansBuQdLeVCBhfM/NtAY04U9WNK6Wo3FPQipT9y+F5AzDHGlJIlkXZPpTNKoegO914L17Sy/IPixe3ZWIpkx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=KluR7Gz4; arc=none smtp.client-ip=91.218.175.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="KluR7Gz4"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=HmI19fo1h7M4xaBqEoQ0a/ICse3F5X5A4tr2M7z2DCQ=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789999717; v=1; x=1790604517;
 b=KluR7Gz4aZRxhU06O6F8Qv6p8rK2wb4AEM2fsjN7dLQfnhaaeY9xSVuASl87bpO/FNTlCFDf
 y+FiHsZtQSpbAZ8y35pPqGDJ1aMhMs98alziVtG4Gg2xzHN51m8YI/yX3zE2JBJWj4R4C32N3d9
 Nj8KG+rRsx0nN0SpmeVsL90A=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 5078c8f700903afc;
	Mon, 21 Sep 2026 14:08:37 +0000
X-Mizu-Trace-ID: 5078c8f700903afc
X-Migadu-Flow: FLOW_OUT
Message-ID: <4342c781-b8c6-4631-ac95-7a7fdca18c94@linux.dev>
Date: Mon, 21 Sep 2026 07:08:31 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v3 07/20] bpf: Refuse exception cleanup shapes
 bpf_throw() cannot dispatch
Content-Language: en-GB
To: bot+bpf-ci@kernel.org, bpf@vger.kernel.org
Cc: ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
 eddyz87@gmail.com, kernel-team@fb.com, martin.lau@kernel.org,
 mason@kernel.org, ihor.solodrai@linux.dev
References: <20260920054301.867768-1-yonghong.song@linux.dev>
 <13e6a8419b642616c50e7586ebd51734c456d19fcea3e3c6649f79b480093533@mail.kernel.org>
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <13e6a8419b642616c50e7586ebd51734c456d19fcea3e3c6649f79b480093533@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 9/19/26 11:32 PM, bot+bpf-ci@kernel.org wrote:
>> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
>> index 0cd7c27a50fa..382177b80745 100644
>> --- a/include/linux/bpf_verifier.h
>> +++ b/include/linux/bpf_verifier.h
>> @@ -683,6 +683,7 @@ struct bpf_insn_aux_data {
>>   	bool is_iter_next; /* bpf_iter_<type>_next() kfunc call */
>>   	bool cleanup_throw_site; /* call to bpf_throw() */
>>   	bool cleanup_resume_site; /* call to bpf_unwind_resume() */
>> +	bool in_cleanup_pad; /* only runs with an exception in flight */
>>   	/*
>>   	 * 1 + the instruction index of the exception cleanup landing pad this
>>   	 * call site unwinds to, or 0 for none.
> Does the in_cleanup_pad comment accurately describe what the field
> represents at this commit? The comment says "only runs with an exception
> in flight", but cleanup_mark_pad_bodies() marks reachability from a
> landing pad without checking whether the pad is unreachable by ordinary
> control flow.
>
> For example, with a record {begin_off=0, end_off=1, landing_pad_off=1}:
>
>      0: call pcall foo        /* covered by the record */
>      1: r0 = 0                /* landing pad, also insn 0's fall-through */
>      2: call bpf_unwind_resume
>      3: exit
>
> check_cleanup_info() permits this (it only rejects a pad that lies
> *inside* a call-site range). cleanup_reachability() gives pad 1 only
> CLEANUP_REACH_RESUME, cleanup_pad_is_catch() accepts it, and insns 1-2
> get in_cleanup_pad = true. Yet on normal return from foo, execution falls
> into insns 1-2 with no exception in flight.
>
> The next commit (c046fa312ea4 "bpf: Walk the exception unwind in the
> verifier") adds the state->unwinding check that actually refuses this
> shape ("bpf_unwind_resume() at insn %d reached without an exception in
> flight"). Should the field comment say "reachable from a landing pad"
> rather than "only runs with an exception in flight" until that enforcement
> is in place, or does the check belong in this commit since the changelog
> promises to refuse every cleanup shape bpf_throw() cannot dispatch?

You are right. The comment is not good. Let us do:
   bool in_cleanup_pad; /* reachable from an exception cleanup landing pad */

>
>> diff --git a/kernel/bpf/exception.c b/kernel/bpf/exception.c
>> index cc7c8595dd64..4859d6484cc8 100644
>> --- a/kernel/bpf/exception.c
>> +++ b/kernel/bpf/exception.c
> [ ... ]
>
>> @@ -37,6 +162,255 @@ static void cleanup_mark_kfunc_sites(struct bpf_verifier_env *env)
> [ ... ]
>
>> +/* What every instruction can reach along intra-subprog edges, for
>> + * cleanup_pad_is_catch(). One backward walk over a predecessor index, rather
>> + * than a forward walk from each landing pad, which would be quadratic.
>> + */
>> +static int cleanup_reachability(struct cleanup_ctx *ctx)
>> +{
>> +	struct bpf_verifier_env *env = ctx->env;
>> +	u32 len = env->prog->len;
>> +	struct cleanup_cursor c = CLEANUP_CURSOR_INIT;
>> +	u32 *head = NULL, *link = NULL;
>> +	bool *queued = NULL;
>> +	u32 i, sp = 0;
>> +	void *scratch;
>> +	const struct cleanup_alloc_req tab[] = {
>> +		{ (void **)&head,   len,             sizeof(*head) },
>> +		{ (void **)&link,   2 * (size_t)len, sizeof(*link) },
>> +		{ (void **)&queued, len,             sizeof(*queued) },
>> +	};
>> +
>> +	scratch = cleanup_alloc(tab, ARRAY_SIZE(tab));
>> +	if (!scratch)
>> +		return -ENOMEM;
>> +
>> +	/* Index the predecessors, and seed the walk at the terminators. */
>> +	for (i = 0; i < len; i++) {
> [ ... ]
>
>> +	}
>> +
>> +	/* Each instruction re-enters the worklist at most once per bit it
>> +	 * gains, so this is linear in the number of edges.
>> +	 */
>> +	while (sp) {
> This isn't a bug, but could the two multi-line comments in
> cleanup_reachability() follow the BPF comment style with the opening /*
> on its own line? The other multi-line comments added by this series use
> that format, and the guide requires it for files under kernel/bpf/.
>
>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/35492765538

