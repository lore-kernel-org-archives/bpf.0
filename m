Received: from mta1.migadu.com (out-58.mta1.migadu.com [95.215.58.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22E6035C693
	for <bpf@vger.kernel.org>; Sat, 19 Sep 2026 19:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.58
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789847697; cv=none; b=ZEBvFAiCV5/s4c/g+RimazpjXI7TQflsouYWYeCntS/CC5RSaouP4jOiLcSrUpMnny6fF4vUFkDxjvAuVVF2OGMouyfFDox/eEnwobAv9awBK+lMsVnOGE/q6thb9PeDRbS03f5g4o9SmA3B2A9ATqCP3hMoLKpsSW0KepOejCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789847697; c=relaxed/simple;
	bh=UpURaZtWbRJesNZxcDlHzEUhk6z0xy0v22xCFxKo72k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=roxUdwEGvm903l/gb4dxhkQT4GZ+i93fY7IVlrgJvWITCC8P5Z22wi21KUyRdSzb6wG4LB2YjcgVIeFSmKMTHXyBjGhcZTKW+d8bhHux0n7SuIQSru5r4vU9QAkjIiv6smxwWucyRHnvX/HKN6BznbPFAlkFYWZbfbNKXSohOnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=vNUDajF9; arc=none smtp.client-ip=95.215.58.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="vNUDajF9"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=UpURaZtWbRJesNZxcDlHzEUhk6z0xy0v22xCFxKo72k=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789847692; v=1; x=1790452492;
 b=vNUDajF9m2F46d3YCsVLky8EpFxCgqO1Tu5/5HpJXj5mGvnN4PTZV6Hp07c4pklyUZ78w9s/
 6ZV83Ymwd4/6WXpjiF4/h9kMlSMCXa7m49NlQHH6g9Qk4ZiEPiC4pae+zDeODufHzLaw7ND7rzw
 FVpVkcnJq+PoTqd/qCBVjjpY=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 9f78eb9fe24046e1;
	Sat, 19 Sep 2026 19:54:52 +0000
X-Mizu-Trace-ID: 9f78eb9fe24046e1
X-Migadu-Flow: FLOW_OUT
Message-ID: <09acae72-dfdc-4715-83ba-c6dd2849dba9@linux.dev>
Date: Sat, 19 Sep 2026 12:54:48 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2 10/20] bpf: Dispatch exception cleanup pads
 from bpf_throw()
Content-Language: en-GB
To: bot+bpf-ci@kernel.org, bpf@vger.kernel.org
Cc: ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
 eddyz87@gmail.com, kernel-team@fb.com, martin.lau@kernel.org,
 mason@kernel.org, ihor.solodrai@linux.dev
References: <20260918044248.3289362-1-yonghong.song@linux.dev>
 <eb5c029a500542566d71ececa22da94f0e301c49c95880bfec3fcc5f46c36ea4@mail.kernel.org>
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <eb5c029a500542566d71ececa22da94f0e301c49c95880bfec3fcc5f46c36ea4@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 9/17/26 10:58 PM, bot+bpf-ci@kernel.org wrote:
>> diff --git a/kernel/bpf/exception.c b/kernel/bpf/exception.c
>> index b2bf831242b85..521086d084a35 100644
>> --- a/kernel/bpf/exception.c
>> +++ b/kernel/bpf/exception.c
> [ ... ]
>
>> +static int cmp_u32(const void *a, const void *b)
>> +{
>> +	u32 x = *(const u32 *)a, y = *(const u32 *)b;
>> +
>> +	return x < y ? -1 : x > y;
>> +}
> [ ... ]
>
>> +/* Is @idx in the sorted array @at of @n instruction indices? */
>> +static bool insn_idx_in(const u32 *at, u32 n, u32 idx)
>> +{
>> +	u32 l = 0, r = n;
>> +
>> +	while (l < r) {
>> +		u32 m = l + (r - l) / 2;
>> +
>> +		if (idx < at[m])
>> +			r = m;
>> +		else if (idx > at[m])
>> +			l = m + 1;
>> +		else
>> +			return true;
>> +	}
>> +	return false;
>> +}
> This isn't a bug, but could insn_idx_in() just use bsearch() from
> <linux/bsearch.h>, reusing the cmp_u32() already defined above for the
> sort()? kernel/bpf/fixups.c in this series uses bsearch() for similar
> lookups.

Good point. will do.

>
>> diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
>> index f120ae66dbbcb..134aafa6a6c9b 100644
>> --- a/kernel/bpf/fixups.c
>> +++ b/kernel/bpf/fixups.c
> [ ... ]
>
>> @@ -1113,6 +1120,116 @@ static void bpf_restore_subprog_starts(struct bpf_verifier_env *env, u32 *orig_s
>>   	env->subprog_info[env->subprog_cnt].start = env->prog->len;
>>   }
>>
>> +static int cleanup_info_for_subprog(struct bpf_verifier_env *env, struct bpf_prog *sub,
>> +				    u32 start, u32 end)
>> +{
>> +	struct bpf_cleanup_info *recs;
>> +	u32 i, cnt = 0;
>> +	int err;
>> +
>> +	if (!env->cleanup_info_cnt)
>> +		return 0;
>> +
>> +	err = bpf_cleanup_alloc_info(sub->aux);
>> +	if (err)
>> +		return err;
>> +
>> +	err = cleanup_throw_sites_for_subprog(env, sub, start, end);
>> +	if (err)
>> +		return err;
>> +
>> +	err = cleanup_pad_body_for_subprog(env, sub, start, end);
>> +	if (err)
>> +		return err;
>> +
>> +	for (i = start; i < end; i++)
>> +		if (env->insn_aux_data[i].cleanup_pad)
>> +			cnt++;
>> +	if (!cnt)
>> +		return 0;
>> +
>> +	recs = kvmalloc_array(cnt, sizeof(*recs), GFP_KERNEL_ACCOUNT | __GFP_NOWARN);
>> +	if (!recs)
>> +		return -ENOMEM;
>> +
>> +	for (i = start, cnt = 0; i < end; i++) {
>> +		u32 pad = env->insn_aux_data[i].cleanup_pad;
>> +
>> +		if (!pad)
>> +			continue;
>> +		pad--;
>> +		if (verifier_bug_if(pad < start || pad >= end, env,
>> +				    "insn %u is covered by a landing pad at %u outside its subprog [%u, %u)",
>> +				    i, pad, start, end)) {
>> +			kvfree(recs);
>> +			return -EFAULT;
>> +		}
>> +		recs[cnt].begin_off = i - start;
>> +		recs[cnt].end_off = i - start + 1;
>> +		recs[cnt].landing_pad_off = pad - start;
>> +		cnt++;
>> +	}
>> +	return bpf_cleanup_attach_info(sub->aux, recs, cnt);
>> +}
> [ ... ]
>
>>   static int jit_subprogs(struct bpf_verifier_env *env)
>>   {
>>   	struct bpf_prog *prog = env->prog, **func, *tmp;
> [ ... ]
>
>> @@ -1250,6 +1367,10 @@ static int jit_subprogs(struct bpf_verifier_env *env)
>>   		func[i]->aux->token = prog->aux->token;
>>   		if (!i)
>>   			func[i]->aux->exception_boundary = env->seen_exception;
>> +		err = cleanup_info_for_subprog(env, func[i], subprog_start,
>> +					       env->subprog_info[i + 1].start);
> This isn't a bug, but would passing subprog_end (already computed a few
> lines above from env->subprog_info[i + 1].start) be clearer here? It
> keeps the cleanup table's end bound explicitly tied to the same value
> jit_subprogs() uses for func[i]->len.

Good point. subprog_end is a good choice.

>
>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/35308528711

