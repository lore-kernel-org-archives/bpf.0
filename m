Received: from mta0.migadu.com (out-176.mta0.migadu.com [91.218.175.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0491E383C94
	for <bpf@vger.kernel.org>; Thu,  8 Oct 2026 16:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791475640; cv=none; b=sfH0qrCC7jpGcxbDtudp+kgLQLgLMVg/qSunZnndJReVYwysIVL7ffPuhJxtXAb6Tpk8uzQSv0opK9Kxos65VgNy4XaQLG29818jSHdDBPBTOYKdUqxD+Blo3BUr32HpIUE+FkIBkfXgfhYpz2LXaggjH/cmAVbMy6eD49GAmAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791475640; c=relaxed/simple;
	bh=BbmPCGD72JTlgvKuIvLx+w3utAzN81PLh3AgjYtChWc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VCL4UUwRWuaPClD94miPDMa3VO/MUzoUpBzNgAg1IJY44lgZIRwYWtpVpiXxQezFGV2uKXW78L+cCS/BTU/zksR9yOynrTB9nfCBYIgJI071viOrK+HE7Ficj38tOWRPAQ1UNBzWe7p6MRWe8pY7ysvTdWus18aNyAArKYn3oWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=jSxfS4VW; arc=none smtp.client-ip=91.218.175.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="jSxfS4VW"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=BbmPCGD72JTlgvKuIvLx+w3utAzN81PLh3AgjYtChWc=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791475636; v=1; x=1792080436;
 b=jSxfS4VWbxKnsWgZYigMflyR03Pe2fUpSg+wV2FNyvPm2r6Hsjps19M09U7/KHXNcIj1pdmm
 3KnngHb+zUjtUWne1RU3Z61BpTV4euxHULESNnR/NCvwgyHH/7gux7LLcMdy5Qqd4xPxhhEGTd7
 i7AXgLm3ye7Ngbwj83UpQkk4=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 6a8f37804265d9ac;
	Thu, 08 Oct 2026 16:07:16 +0000
X-Mizu-Trace-ID: 6a8f37804265d9ac
X-Migadu-Flow: FLOW_OUT
Message-ID: <c341e9a9-1d66-4ac6-b53e-64711d160ca8@linux.dev>
Date: Thu, 8 Oct 2026 18:07:09 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v9 07/23] bpf: Verify an unwind through landing
 pads and epilogues
To: bot+bpf-ci@kernel.org, bpf@vger.kernel.org
Cc: ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
 eddyz87@gmail.com, kernel-team@fb.com, martin.lau@kernel.org,
 mason@kernel.org, ihor.solodrai@linux.dev
References: <20261008075035.2998664-1-yonghong.song@linux.dev>
 <86f392fa0a39a0734d7b9264127865d733789042fe70a29725aa7a37aaa03a45@mail.kernel.org>
Content-Language: en-GB
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <86f392fa0a39a0734d7b9264127865d733789042fe70a29725aa7a37aaa03a45@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/8/26 10:57 AM, bot+bpf-ci@kernel.org wrote:
>> bpf: Verify an unwind through landing pads and epilogues
> TL;DR: In backtrack_insn(), if a landing pad directly follows a global call,
> the normal return may take the new pad branch, which doesn't clear R2, so a
> precise R2 could trigger verifier_bug() and -EFAULT.
>
>> diff --git a/kernel/bpf/backtrack.c b/kernel/bpf/backtrack.c
>> --- a/kernel/bpf/backtrack.c
>> +++ b/kernel/bpf/backtrack.c
> [ ... ]
>
>> @@ -434,6 +459,24 @@ static int backtrack_insn(struct bpf_verifier_env *env, int idx, int subseq_idx,
>>   					return -EFAULT;
>>   			}
>>
>> +			if (bpf_exc_pad_of_call(env, idx) == subseq_idx) {
>> +				/*
>> +				 * We came from the landing pad of a call to a
>> +				 * global subprog, branched to from the state
>> +				 * the call returns in: as on its return, no
>> +				 * frame was entered here. The call clobbered
>> +				 * r0-r5; r6-r9 and the stack are the caller's
>> +				 * own and keep going back from here.
>> +				 */
>> +				bt_clear_reg(bt, BPF_REG_0);
>> +				if (bt_reg_mask(bt) & BPF_REGMASK_ARGS) {
>> +					verifier_bug(env, "landing pad unexpected regs %x",
>> +						     bt_reg_mask(bt));
>> +					return -EFAULT;
>> +				}
>> +				return 0;
>> +			}
>> +
>>   			/* callx calls static subprogs only */
>>   			if (subprog >= 0 && bpf_subprog_is_global(env, subprog)) {
>>   				/* check that jump history doesn't have any
> [ ... ]
>
> Is comparing subseq_idx with the call's pad enough to tell that the walk
> came over the pad edge?

Not sure. For global subprog, next insn could be a follow-up or could be
a landing pad, as you analysed below.

In such cases, for global subprog, it will go to non-landing pad first
and will return. This will cause problems as global subprog and landing
pad connection got lost. This is a bug and will fix it in the next revision.
Basically, we can remove "if (bpf_exc_pad_of_call(env, idx) == subseq_idx)"
and deal with it under "if (subprog >= 0 && bpf_subprog_is_global(env, subprog))".

>
> bpf_exc_check_info() accepts a record [c, c+1) -> c+1, because its pad check
> treats end_off as exclusive.  With that layout the pad is the insn right
> after the call:
>
>      c:     call global_subprog
>      c + 1: pad
>
> In that case the normal return of the global call also has subseq_idx ==
> idx + 1 == pad, so it now goes through the new pad branch instead of the
> global call branch below it.
>
> The pad branch clears only BPF_REG_0, while the global call branch also
> clears R2.  For a global subprog that returns in the R0:R2 pair
> (bpf_ret_reg_pair()), the normal return path really does define R2 as a
> scalar.
>
> If precision on R2 reaches the call insn over that edge, for example from
> propagate_precision() when the path is pruned against a checkpoint where R2
> is precise, the pad branch finds R2 still set in the mask:
>
>      bt_clear_reg(bt, BPF_REG_0);
>      if (bt_reg_mask(bt) & BPF_REGMASK_ARGS) {
>          verifier_bug(env, "landing pad unexpected regs %x", ...);
>          return -EFAULT;
>      }
>
> That fires verifier_bug(), which is a WARN_ONCE under CONFIG_DEBUG_KERNEL
> plus -EFAULT, rather than handling the edge as a normal global return as
> happened before this patch.
>
> Should the pad branch also clear R2, which is NOT_INIT on the real pad path
> anyway, or should it apply only when subseq_idx != idx + 1?
>
> I did not find a later patch in the series that touches backtrack_insn()
> again to address this.
>
>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/37747693645

