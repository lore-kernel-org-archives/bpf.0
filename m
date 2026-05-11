Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE92842EED9
	for <bpf@vger.kernel.org>; Mon, 11 May 2026 16:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778517377; cv=none; b=m+3Bs6CR+EhBORN22VCEiIK6Z2DSPUSODX4ZeW3s2YCfAXW6rM17sf+aOBQD/o0YpS1ZINSyzteCsAiEaPyqjxwbIgWEpP+ZItD76HHL5GRieELzQBm/LWpp2Uqh7KP8ghdnvKerUHgBNzzepAlbE2wsSwuFn7A6BLNY0Mx+/2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778517377; c=relaxed/simple;
	bh=YJ0ftYYgPjarcxdKBzSw487gJxXom0sL8P9lhd9wlPA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UNfCcXFPFFYA4tzMS77rZFN45Cax1Wv459TKNPscyrQDzbJh4TIss5nEIyIK3PzFpAmhXLYZ56rdyDl3HCd95uFTQKlyBRA8d0iYzfZtGrEwWGaZDAAn/ygzg9eelUauUJizHpk3q/y30qqGgEgWIoH0Z22N3pXg9zxuVlb3u/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ZB7T5AwG; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ZB7T5AwG"
Message-ID: <9356e57e-8df9-4e51-8aaf-a7d0381d1b86@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1778517374;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ML1UeSYw77Imq5+S01Kywk7Ack8Ag4r47/RCyrJ/Nno=;
	b=ZB7T5AwGsH2LvVt9MdrOhjrHTzBYiRfebrFgFbP6N8KF35mnYjALQBVXVZZRKXYZBUL/r9
	4S9ScwWS246O8QP0MZW6mTYst+Ze8hSVvpZt3EqqtgRxayWBSF8aPNkCvC568xh4vC7RfA
	gBbIwWRJN/qOeAppPDJXtr4Gvw0hFco=
Date: Mon, 11 May 2026 09:35:43 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v3 09/24] bpf: Extend liveness analysis to track
 stack argument slots
Content-Language: en-GB
To: bot+bpf-ci@kernel.org, bpf@vger.kernel.org
Cc: ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
 jose.marchesi@oracle.com, kernel-team@fb.com, martin.lau@kernel.org,
 eddyz87@gmail.com, clm@meta.com, ihor.solodrai@linux.dev
References: <20260511053348.1885300-1-yonghong.song@linux.dev>
 <a38eef1ada649253e764e4dab338620553a332ef32440feacf0541d443ba8fed@mail.kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <a38eef1ada649253e764e4dab338620553a332ef32440feacf0541d443ba8fed@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 5/11/26 8:19 AM, bot+bpf-ci@kernel.org wrote:
>> diff --git a/kernel/bpf/const_fold.c b/kernel/bpf/const_fold.c
>> --- a/kernel/bpf/const_fold.c
>> +++ b/kernel/bpf/const_fold.c
>> @@ -58,6 +58,14 @@ struct const_arg_info unknown = { .state = CONST_ARG_UNKNOWN, .val = 0 };
>>   	u8 opcode = BPF_OP(insn->code) | BPF_SRC(insn->code);
>>   	int r;
>>
>> +	/* Stack arg stores (r11-based) are outside the tracked register set. */
>> +	if (is_stack_arg_st(insn) || is_stack_arg_stx(insn))
>> +		return;
>> +	if (is_stack_arg_ldx(insn)) {
>> +		ci_out[insn->dst_reg] = unknown;
>> +		return;
>> +	}
>> +
>>   	switch (class) {
>>   	case BPF_ALU:
>>   	case BPF_ALU64:
>> diff --git a/kernel/bpf/liveness.c b/kernel/bpf/liveness.c
>> --- a/kernel/bpf/liveness.c
>> +++ b/kernel/bpf/liveness.c
> [ ... ]
>
>> @@ -1576,19 +1651,19 @@ struct arg_track none = { .frame = ARG_NONE };
>>   		goto err_free;
>>
>>   	for (i = 0; i < len; i++) {
>> -		for (r = 0; r < MAX_BPF_REG; r++)
>> +		for (r = 0; r < MAX_AT_TRACK_REGS; r++)
>>   			at_in[i][r] = unvisited;
>>   		for (r = 0; r < MAX_ARG_SPILL_SLOTS; r++)
>>   			at_stack_in[i][r] = unvisited;
>>   	}
>>
>> -	for (r = 0; r < MAX_BPF_REG; r++)
>> +	for (r = 0; r < MAX_AT_TRACK_REGS; r++)
>>   		at_in[0][r] = none;
>>
>>   	/* Entry: R10 is always precisely the current frame's FP */
>>   	at_in[0][BPF_REG_FP] = arg_single(depth, 0);
>>
>> -	/* R1-R5: from caller or ARG_NONE for main */
>> +	/* R1-R5 and outgoing stack args: from caller or ARG_NONE for main */
>>   	if (callee_entry) {
>>   		for (r = BPF_REG_1; r <= BPF_REG_5; r++)
>>   			at_in[0][r] = callee_entry[r];
> The comment says "R1-R5 and outgoing stack args" but the following code
> only copies R1-R5 from callee_entry to at_in[0]. The outgoing stack arg
> slots at at_in[0][MAX_BPF_REG..MAX_AT_TRACK_REGS-1] remain at ARG_NONE
> (set by the earlier loop).
>
> Looking further down in the function, the incoming stack args from the
> caller are actually placed in the separate at_stack_arg_entry[] array:
>
> 	/* Entry: incoming stack args from caller, or ARG_NONE for main */
> 	for (r = 0; r < MAX_STACK_ARG_SLOTS; r++)
> 		at_stack_arg_entry[r] = callee_entry ? callee_entry[MAX_BPF_REG + r] : none;
>
> The comment conflates the outgoing stack arg state carried in
> at_in[0][MAX_BPF_REG + r] (which always starts at ARG_NONE and gets
> updated later by arg_track_xfer when the subprog performs stack-arg
> stores) with the incoming stack arg state (stored in
> at_stack_arg_entry[], read back via stack-arg ldx).
>
> Should the comment be revised to only mention R1-R5, since the incoming
> stack args are handled separately below?

Yes. Will fix the comment. The old comment is a leftover from the v2.

>
>> @@ -1598,6 +1673,10 @@ struct arg_track none = { .frame = ARG_NONE };
>>   	for (r = 0; r < MAX_ARG_SPILL_SLOTS; r++)
>>   		at_stack_in[0][r] = none;
>>
>> +	/* Entry: incoming stack args from caller, or ARG_NONE for main */
>> +	for (r = 0; r < MAX_STACK_ARG_SLOTS; r++)
>> +		at_stack_arg_entry[r] = callee_entry ? callee_entry[MAX_BPF_REG + r] : none;
>> +
> [ ... ]
>
>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/25652623893

