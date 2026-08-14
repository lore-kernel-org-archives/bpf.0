Received: from mta1.migadu.com (out-238.mta1.migadu.com [95.215.58.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 825F61F1932
	for <bpf@vger.kernel.org>; Fri, 14 Aug 2026 06:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.238
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786687704; cv=none; b=R4ZJCvPH3eEZiQAfyRZRJN43iBZDqr1EHZAQJbSHJ9A0Vjcy+GIskvxoPsLm1oWMvTwD2QiEtIUS7FEgGeYM8FaxayZyfzEWWrv0Cs/0pKnAcs0SllFrMHt3DkbKbS7DPXm3G6M7Fn0EDTCKi2Sni0y9Jaa7eTcAOb0m1boYVL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786687704; c=relaxed/simple;
	bh=9i2zxi66Aryuca8cLMI1/vE1cNvD9517PwU7dShwtq4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eF553Hsl0Qnlv0j10C22JuwavtxQLaawUPLF8DJRYt6T//gCy+NZ8uaZ9aC4WrnSH7kgpnqoLfJ6AqQXBe2wHVrRUIIfaOwJcxzT50FgDz/Hfvn3EhV2DdIxCcr/dWd9kYMYTkRX/PSn3or+ggnsm3otQyFpMD3TzzDzq2VVY88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=dIIXIJyX; arc=none smtp.client-ip=95.215.58.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="dIIXIJyX"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=9i2zxi66Aryuca8cLMI1/vE1cNvD9517PwU7dShwtq4=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1786687699; v=1; x=1787292499;
 b=dIIXIJyXB+14gVuTme6o2gZXqTPCidjJ6uGLtSccATOfhRjRGfo1AKibv3zu9w89jYZzw+9B
 x/5KPRlHx/29k5OA8KlpEUNsAGmEWz2ynwq4BXsC2nKBLRU0NZZV3OZD+Sy+waN/wbs8B66WJ+A
 jA2XGIhctTmD7ZO8GvLenGuI=
X-Envelope-To: bpf@vger.kernel.org
Received: from [10.22.64.46] (122.11.166.8)
	by smtp.migadu.com with ESMTPS id ac973465bf3f80df;
	Fri, 14 Aug 2026 06:08:09 +0000
X-Migadu-Flow: FLOW_OUT
Message-ID: <d0821525-2ca4-42ca-8858-b6fe732af82e@linux.dev>
Date: Fri, 14 Aug 2026 14:07:56 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v12 01/10] bpf: Drop duplicate blank lines in
 kernel/bpf/
To: bot+bpf-ci@kernel.org, bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, memxor@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, jolsa@kernel.org, john.fastabend@gmail.com,
 qmo@kernel.org, shuah@kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, kernel-patches-bot@fb.com,
 emil@etsalapatis.com, martin.lau@kernel.org, clm@meta.com,
 ihor.solodrai@linux.dev
References: <20260813152324.97937-2-leon.hwang@linux.dev>
 <00f7d1a28671561d7ef689774af280b7aff3c6a0f9ca06212b05df2002f2793d@mail.kernel.org>
Content-Language: en-US
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <00f7d1a28671561d7ef689774af280b7aff3c6a0f9ca06212b05df2002f2793d@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 14/8/26 00:26, bot+bpf-ci@kernel.org wrote:
>> diff --git a/kernel/bpf/backtrack.c b/kernel/bpf/backtrack.c
>> index 40bd04421a991..a2b18a9f1694c 100644
>> --- a/kernel/bpf/backtrack.c
>> +++ b/kernel/bpf/backtrack.c
>> @@ -214,7 +214,6 @@ static inline bool bt_is_reg_set(struct backtrack_state *bt, u32 reg)
>>  	return bt->reg_masks[bt->frame] & (1 << reg);
>>  }
>>
>> -
>>  /* format registers bitmask, e.g., "r0,r2,r4" for 0x15 mask */
>>  static void fmt_reg_mask(char *buf, ssize_t buf_sz, u32 reg_mask)
>>  {
> 
> [ ... ]
> 
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> index 164d16c243ca6..cdb79a66b156f 100644
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
>> @@ -635,7 +635,6 @@ static void __mark_dynptr_reg(struct bpf_reg_state *reg,
>>  			      enum bpf_dynptr_type type,
>>  			      bool first_slot, int id, int parent_id);
>>
>> -
>>  static void mark_dynptr_stack_regs(struct bpf_verifier_env *env,
>>  				   struct bpf_reg_state *sreg1,
>>  				   struct bpf_reg_state *sreg2,
> 
> [ ... ]
> 
>> @@ -18361,8 +18352,6 @@ static void release_insn_arrays(struct bpf_verifier_env *env)
>>  		bpf_insn_array_release(env->insn_array_maps[i]);
>>  }
>>
>> -
>> -
>>  /* The verifier does more data flow analysis than llvm and will not
>>   * explore branches that are dead at run time. Malicious programs can
>>   * have dead code too. Therefore replace all dead at-run-time code
>> @@ -18390,8 +18379,6 @@ static void sanitize_dead_code(struct bpf_verifier_env *env)
>>  	}
>>  }
>>
>> -
>> -
>>  static void free_states(struct bpf_verifier_env *env)
>>  {
>>  	struct bpf_verifier_state_list *sl;
> 
> This isn't a bug, but it looks like one adjacent blank-line pair is still
> left in verifier.c. Inside the kfunc argument loop in check_kfunc_args(),
> around the code that checks:
> 
> 	if (bpf_register_is_null(reg) && type_may_be_null(kf_arg_type))
> 
> there's a blank line pair that appears to fit the same pattern this patch
> removes everywhere else. The changelog states the goal is to drop the
> adjacent blank lines that have accumulated over time, and the patch removes
> 30 blank lines across the directory, but this one instance seems to have
> been overlooked. Was that one intentionally kept, or could it be folded
> into this patch so the whole directory is done in one pass?

Yep, a new droppable blank line.

Thanks,
Leon

> 
> 
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
> 
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/31716447858

