Received: from mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4E683932CA
	for <bpf@vger.kernel.org>; Fri,  9 Oct 2026 16:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791562347; cv=none; b=cUboGw4DEuGTzLZQKpxGxEOLu2UrABVrq/5psexAEKiVq+fV32nO9+7BET0i1kot+xGMQqvV6YKfjrWQ7Jkqrh72zDQeIuzdbyN0MAijiSSKcopgBFrz36eMco6h4i1qYXAsOEy32D52/xthoGkbq9sKJXB50rYOvPeSxBiI5K8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791562347; c=relaxed/simple;
	bh=747TmAvyl8viWqs5riM3RgFcXeMoyHrrMImVgSIWeCY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V9vfoUcCI4mfBtYmisdQBqHWCh6WetIhOh31JGdgKSPiJA8729s7f4dzfarKik+84R5Ee6Qdhldz2pOJVovI6nFIkTWI/8fqwOvvUXcf9J26YivgtiJOwqKDA2o7D/iufWpjPPq5Vd7l4hQIcsxEZ+zcZ4OFSm7skiHLTzBvJEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=X+TeH90e; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="X+TeH90e"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=747TmAvyl8viWqs5riM3RgFcXeMoyHrrMImVgSIWeCY=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791562342; v=1; x=1792167142;
 b=X+TeH90ec8NeojvqWB16YdLhz/Hu+TFMeWJl33Ye7y15uifANz6YwP7fUjdEUOmJj1VXOXVY
 2kksspB5lF+V0chFQzvMGGnJ9ya3yZOAZiCMEKyBJhqDRYHuIrRJW5UKKJyHfj1AQWLCypd4R/3
 uCoAejgCx2o7khfIx6fq2vcA=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id a2c0977c8bee8875;
	Fri, 09 Oct 2026 16:12:22 +0000
X-Mizu-Trace-ID: a2c0977c8bee8875
X-Migadu-Flow: FLOW_OUT
Message-ID: <2bf493a9-a910-43ca-8008-bff5f03a55f8@linux.dev>
Date: Fri, 9 Oct 2026 18:12:18 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v10 11/24] bpf: Prepare JITed programs for
 dispatching cleanup pads
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
References: <20261009041447.17092-1-yonghong.song@linux.dev>
 <20261009041544.29907-1-yonghong.song@linux.dev>
 <sashiko-outbox-164846@kernel.org>
Content-Language: en-GB
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <sashiko-outbox-164846@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 10/9/26 6:35 AM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] bpf: backward jump offsets in bpf_exc_patch_unwind_calls are corrupted by bpf_adj_branches
> --
>
> commit b2a75ebf7c80cc3231a5eb34881ba1928dafcd3b
> Author: Yonghong Song <yonghong.song@linux.dev>
>
> bpf: Prepare JITed programs for dispatching cleanup pads
>
> This patch prepares JITed programs to dispatch exception cleanup pads.
> It updates the verifier to patch bpf_unwind() calls with a sequence that
> clears r0 and jumps to the exception pad or exits.
>
>> diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
>> index 64baee1a37e60..1cc025c45ecda 100644
>> --- a/kernel/bpf/fixups.c
>> +++ b/kernel/bpf/fixups.c
> [ ... ]
>> @@ -1733,6 +1805,48 @@ static int may_goto_expand(struct bpf_insn *insn_buf, int off, int stack_off,
> [ ... ]
>> +/*
>> + * Follow each bpf_unwind() call with 'r0 = 0; exit', or with
>> + * 'r0 = 0; goto pad' where a record covers the call.
>> + */
>> +int bpf_exc_patch_unwind_calls(struct bpf_verifier_env *env)
>> +{
>> +	int insn_cnt = env->prog->len;
>> +	struct bpf_insn insn_buf[3];
>> +	struct bpf_prog *new_prog;
>> +	int i, off, delta = 0;
>> +
>> +	if (!bpf_prog_may_unwind(env))
>> +		return 0;
>> +
>> +	for (i = 0; i < insn_cnt; i++) {
>> +		int call = i + delta, pad;
>> +		struct bpf_insn *insn = env->prog->insnsi + call;
>> +
>> +		if (!bpf_is_unwind_kfunc(insn))
>> +			continue;
>> +
>> +		insn_buf[0] = *insn;
>> +		insn_buf[1] = BPF_MOV64_IMM(BPF_REG_0, 0);
>> +		insn_buf[2] = BPF_EXIT_INSN();
>> +		pad = bpf_exc_pad_of_call(env, call);
>> +		if (pad >= 0) {
>> +			/* The goto is at call + 2; a pad after the call moves down by 2. */
>> +			if (pad > call)
>> +				pad += 2;
>> +			off = pad - (call + 3);
>> +			insn_buf[2] = off == (s16)off ? BPF_JMP_A(off) : BPF_JMP32_A(off);
> [Severity: High]
> Does this manually calculated offset get corrupted if the landing pad is located
> before the unwind call (pad < call)?

I think this cannot happen. See below.

>
> bpf_patch_insn_data() is called immediately after this, which delegates to
> bpf_adj_branches() to adjust all relative offsets in the program.
>
> When bpf_adj_branches() processes the newly inserted goto instruction, it
> evaluates it as if it were a shifted original instruction (because
> curr >= end_new evaluates to true). If the jump is backwards,
> bpf_adj_branches() might erroneously subtract the insertion delta (2) from the
> already-correct offset.
>
> Could this result in the jump target being shifted 2 instructions before the
> actual landing pad, potentially leading to the execution of unintended or
> unverified bytecode during exception unwinding?

The offset is already right, and no change for bpf_adj_branches().
The goto is inside the patch [call, call + 3). bpf_adj_delta_to_off()
only rewrites a jump that sits before pos or at or after end_new,
i.e. one that was outside the patch.

>
>> +		}
>> +
>> +		new_prog = bpf_patch_insn_data(env, call, insn_buf, 3);
>> +		if (!new_prog)
>> +			return -ENOMEM;
>> +		delta += 2;
>> +		env->prog = new_prog;
>> +	}
>> +	return 0;
>> +}

