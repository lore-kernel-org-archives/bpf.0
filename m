Received: from mta1.migadu.com (out-193.mta1.migadu.com [95.215.58.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C089D4A3F32
	for <bpf@vger.kernel.org>; Mon, 21 Sep 2026 14:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789999583; cv=none; b=udUA6M1dj/TLT2NeNNThGE4qDKC5Vly5LfdpDYPpZQ5FClgXgmJM5u4k//NwTogT8YDng3KvOHY4BfOCfqc2nX8dWwkgj29C2WUvZfin0mZVIIxiEu5JsC3DAoIq3s+Rpq2z/Xri9XkV4jVausgYjoB80geJPl5IN4P1/chPWOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789999583; c=relaxed/simple;
	bh=cWBlUAbftU+jBJv7iFcN/mByRv8yAW/qvKEepH2a17Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FQnsQ/rD7RLwsyHJfwYPtSk+sGbQ7AhCf9pYCfWF78l82gSr4JuDKhCncjSVio8PHSdy4K1GEZs/ox/cQ/dM4dQjNHSW5ELzlkzlhjn33g6d8ECYH5QSLPUBdFuwzhVhHqFnXIe0AYoF4wUI8lg6sWYTBe3yzZURzE5v08UJDGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=bUz6NViV; arc=none smtp.client-ip=95.215.58.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="bUz6NViV"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=cWBlUAbftU+jBJv7iFcN/mByRv8yAW/qvKEepH2a17Y=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789999579; v=1; x=1790604379;
 b=bUz6NViV14pus6eZ8PR2dJAdIjJkc5Fw6lOXcMcR8OnBdTbq5EsaAvTXc3hWQJbV/9cYY0Nc
 piGvACCh4P5ixyx3Jo9Ev4C331CUiscgGWCzwElGOcJs/+OhZm4UijMlQYsDE3h1FgMAcRxW9q0
 hVM5ab86tA2PQeI8bXT3J8zI=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 1ada509d48e01197;
	Mon, 21 Sep 2026 14:06:19 +0000
X-Mizu-Trace-ID: 1ada509d48e01197
X-Migadu-Flow: FLOW_OUT
Message-ID: <c4dd4121-ec65-49e3-9c67-8bf906092669@linux.dev>
Date: Mon, 21 Sep 2026 07:06:09 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v3 03/20] bpf: Add lookups for exception cleanup
 resumes and landing pads
Content-Language: en-GB
To: bot+bpf-ci@kernel.org, bpf@vger.kernel.org
Cc: ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
 eddyz87@gmail.com, kernel-team@fb.com, martin.lau@kernel.org,
 mason@kernel.org, ihor.solodrai@linux.dev
References: <20260920054241.866442-1-yonghong.song@linux.dev>
 <fb1fb8d9a506beb7657f12aa599bce576b6e97f4329b91ab874e5c4bb595ebb3@mail.kernel.org>
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <fb1fb8d9a506beb7657f12aa599bce576b6e97f4329b91ab874e5c4bb595ebb3@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 9/19/26 11:31 PM, bot+bpf-ci@kernel.org wrote:
>> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
>> index c08505b9ba82..f9bccd3e0f4d 100644
>> --- a/include/linux/bpf_verifier.h
>> +++ b/include/linux/bpf_verifier.h
>> @@ -681,6 +681,11 @@ struct bpf_insn_aux_data {
>>   	bool needs_zext; /* alu op needs to clear upper bits */
>>   	bool non_sleepable; /* helper/kfunc may be called from non-sleepable context */
>>   	bool is_iter_next; /* bpf_iter_<type>_next() kfunc call */
>> +	/*
>> +	 * 1 + the instruction index of the exception cleanup landing pad this
>> +	 * call site unwinds to, or 0 for none.
>> +	 */
>> +	u32 cleanup_pad;
>>   	bool call_with_percpu_alloc_ptr; /* {this,per}_cpu_ptr() with prog percpu alloc */
>>   	u8 alu_state; /* used in combination with alu_limit */
>>   	/* true if STX or LDX instruction is a part of a spill/fill
> [ ... ]
>
>> diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
>> index 2add8001c3ec..dd1a6b5a6afd 100644
>> --- a/kernel/bpf/fixups.c
>> +++ b/kernel/bpf/fixups.c
>> @@ -261,6 +261,11 @@ static void adjust_insn_aux_data(struct bpf_verifier_env *env,
>>   		}
>>   	}
>>
>> +	if (env->cleanup_info_cnt)
>> +		for (i = 0; i < prog_len; i++)
>> +			if (data[i].cleanup_pad > off + 1)
>> +				data[i].cleanup_pad += cnt - 1;
>> +
> Does this miss the case where the original instruction is not placed last
> in the patch buffer? Looking at adjust_insn_aux_data(), there's logic
> earlier in the function that handles non_stack_access when the patched
> instructions contain the original:
>
> kernel/bpf/fixups.c:adjust_insn_aux_data() {
>      for (i = off; i < off + cnt - 1; i++) {
>          /* Expand insni[off]'s seen count to the patched range. */
>          data[i].seen = old_seen;
>          data[i].zext_dst = bpf_insn_def32(new_prog, insn + i) >= 0;
>          if (!memcmp(insn + i, original_insn, sizeof(struct bpf_insn))) {
>              data[i].non_stack_access =
>                  data[off + cnt - 1].non_stack_access;
>              data[off + cnt - 1].non_stack_access = false;
>          } else if (bpf_is_mem_insn(insn + i)) {
>              data[i].non_stack_access = true;
>          }
>      }
> }
>
> The memcmp branch transfers non_stack_access from data[off + cnt - 1] to
> data[i] when it finds the original instruction. A bit further down,
> indirect_target gets similar treatment.
>
> cleanup_pad is a property of one specific call instruction (the landing
> pad this call site unwinds to), not of an instruction slot. When
> bpf_patch_insn_data() parks the original instruction's aux record in
> data[off + cnt - 1] but the patch buffer places the original instruction
> at position i (not last), shouldn't cleanup_pad be transferred the same
> way?
>
> Without this transfer, after such a patch the surviving call instruction
> would have cleanup_pad == 0 (no landing pad) and an unrelated newly
> generated instruction would carry the pad index instead. The CFG edge from
> the call to its pad would disappear, and an exception unwinding through
> that frame would silently skip its cleanup.
>
> A later commit (d710bf82c5e9, "bpf: Dispatch exception cleanup pads from
> bpf_throw()") adds these lines to the memcmp branch:
>
>      data[i].cleanup_pad = data[off + cnt - 1].cleanup_pad;
>      data[off + cnt - 1].cleanup_pad = 0;
>
> Should that transfer belong in this commit, which introduces the field and
> claims to keep it in step?

You are right. We can transfer the above cleanup_pad in this commit to keep
the field consistent.

>
>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/35492765538

