Received: from mta1.migadu.com (out-33.mta1.migadu.com [95.215.58.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA00653D9D9
	for <bpf@vger.kernel.org>; Thu, 15 Oct 2026 15:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792077586; cv=none; b=KCsSULuPy0SDfqr/ihbTDgUUtIrlc3c0CxmB6hDSZC4OTU52lVhXuIEihXDZQcTj+zxyd1l40tI/BKYjDp+MqAbb2r9Y7Rcp+hRbIZPD6i6dxU7V2lSzQde+oc1LU50jh0qRf6WdFHd9nyI/g+sLGwGVyBaG2sNw4UPGcqqxtCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792077586; c=relaxed/simple;
	bh=qbY6kvDH/2+oRdCEb1ZhmIErB5IAJqIK89g8OGQnl7E=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=aEpNqPAMX5BTTqHrO/Sx8ei+VZzOOyzzDkBQo1/ECHHZg4DKL0aiYBv2QMcZ6XxINZKovtNKE/uTBk5FVk4HOnoUdsLA7GxyZock9p7UR89FVYeDl4TCIj6E1S3e3rDGRHEwrUthGowZDSC1VFhruhnbq5FBNGdz/MZvM3DtW3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=oadIllxm; arc=none smtp.client-ip=95.215.58.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="oadIllxm"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=qbY6kvDH/2+oRdCEb1ZhmIErB5IAJqIK89g8OGQnl7E=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792077579; v=1; x=1792682379;
 b=oadIllxmx4mTxpmJKLNwWp3m8F2vizzMih2ITCvwCXfYibij2v/FejtWbnXL+GyM2KUbIDgU
 SfbXgzdzY4Cx3fKN5CnIf2JbOUgJ/kis0OuWOkzmgcX6IGp35WkS+inFKCqByR+BeBWQ9pcurPd
 roxLEVyjEj3T0O+TwhjQhGaA=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 7dafc8ac16a73e5f;
	Thu, 15 Oct 2026 15:19:39 +0000
X-Mizu-Trace-ID: 7dafc8ac16a73e5f
X-Migadu-Flow: FLOW_OUT
Message-ID: <2b3389e9-53c0-4437-b5d3-7a11d60f91b7@linux.dev>
Date: Thu, 15 Oct 2026 08:19:34 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v11 04/26] bpf: Keep a call site's landing pad in
 insn_aux_data, add lookups
To: sashiko-reviews@lists.linux.dev, bpf@vger.kernel.org
References: <20261015040143.854070-1-yonghong.song@linux.dev>
 <20261015040204.856062-1-yonghong.song@linux.dev>
 <sashiko-outbox-172243@kernel.org>
Content-Language: en-GB
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <sashiko-outbox-172243@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 10/14/26 9:16 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] bpf: adjust_insn_aux_data misses cleanup_pad on BPF_PATCH_MOVE_TARGET
> --
>
> commit 407d61973b5e3b7df47dda20c8cb86db0ad2e4ca
> Author: Yonghong Song <yonghong.song@linux.dev>
>
> bpf: Keep a call site's landing pad in insn_aux_data, add lookups
>
> A call site's landing pad, if any, is kept in insn_aux_data as
> cleanup_pad. adjust_insn_aux_data(), which every instruction patch goes
> through, and verifier_remove_insns() keep it in step, and
> bpf_opt_remove_nops() moves a pad off a nop to the next instruction
> before removing the nop. Add lookups for it and for calls to
> bpf_unwind() and bpf_unwind_resume(); their users come in later patches.
>
>> diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
>> index b2fa7e8bedf3a..18c563abd988f 100644
>> --- a/kernel/bpf/fixups.c
>> +++ b/kernel/bpf/fixups.c
> [ ... ]
>> @@ -244,11 +244,18 @@ static void adjust_insn_aux_data(struct bpf_verifier_env *env,
>>   			data[i].non_stack_access =
>>   				data[off + cnt - 1].non_stack_access;
>>   			data[off + cnt - 1].non_stack_access = false;
>> +			data[i].cleanup_pad = data[off + cnt - 1].cleanup_pad;
>> +			data[off + cnt - 1].cleanup_pad = 0;
>>   		} else if (bpf_is_mem_insn(insn + i)) {
>>   			data[i].non_stack_access = true;
>>   		}
>>   	}
>>   
>> +	if (env->cleanup_info_cnt)
>> +		for (i = 0; i < prog_len; i++)
>> +			if (data[i].cleanup_pad > off + 1)
>> +				data[i].cleanup_pad += cnt - 1;
>> +
> [Severity: High]
> If bpf_convert_ctx_accesses() inserts a prologue at the start of a subprogram
> (offset 0) by calling __bpf_patch_insn_data() with BPF_PATCH_MOVE_TARGET,
> the original instruction shifts from index 0 down to index cnt - 1.
>
> Because of the strictly greater-than condition here (> off + 1), if a call
> site's landing pad is exactly at offset 0 (cleanup_pad == 1), the condition
> evaluates to false and the index won't be shifted.
>
> Could this cause the cleanup pad to point to the newly inserted prologue
> instead of the intended instruction, potentially leading to stack or
> context corruption during an exception unwind?

As mentioned in previous comments, landing_pad cannot be in the beginning
of a subprogram. For example:
    landing_pad_start:
       insn 0: r1 = r6
               ...
               call bpf_unwind_resume

The verifier will go to insn 0 and assuming it is NOT in landing_pad
and eventually it will hit bpf_unwind_resume() and the verifier will
reject it since it thinks bpf_unwind_resume() is out of landing pad.

This patch should be okay.

>

