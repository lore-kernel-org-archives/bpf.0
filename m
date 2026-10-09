Received: from mta0.migadu.com (out-134.mta0.migadu.com [91.218.175.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1F84351C11
	for <bpf@vger.kernel.org>; Fri,  9 Oct 2026 15:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791558618; cv=none; b=LiMitltpcna5HPzQh4SWxB2xhtWZw3BZtlisIB3zCRVqSrLIIimEp0R//6D6mMOqZRXPZYbz4yqpvjDZMpvUp2MFH+AH2I2jWxd1FXcdGrBZS/BPcKEtBOK19wUju07OE+BM3LR83xxuT5RrHQKy5oGPZt7aLN9znc0Yz+NHihA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791558618; c=relaxed/simple;
	bh=JXHbvHdJ+pNlt3vZOl2uWCmVdhCz9quuyejIJCOTWEg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gpe+InQMhQa7AMYLbR9qa+Puu7e77YNedFk88Gx4ru0LsfF+eyyfIR2Sv+Y7FIv+ZDrh8A42ZdQISM9/dbWFn72oHhwce7xBpSoElPSKE2ZG8yYIyUujatH2kVV1P+6mXlvAmBQxpHx7MFdCH6slN1IkeyuxFeg4drMSy9zC8bI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=uzTR9S3t; arc=none smtp.client-ip=91.218.175.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="uzTR9S3t"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=JXHbvHdJ+pNlt3vZOl2uWCmVdhCz9quuyejIJCOTWEg=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791558614; v=1; x=1792163414;
 b=uzTR9S3tWdpmvKVi/POT6bcg+A6ayDsw4977BA3XTL+L0h9ilP8S2B75Xde/MPGpkXNBo5Bc
 b2hVESuIpPx+YbWqKm4fBs+CjznOjHGW3g+n4vhjuv6/V3sjXYSjIkIh07zN/Biu9JJuza6flMS
 /kRRsurbsNOHJ0aLI9h0Q+EY=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 6ffb09638a1a6eac;
	Fri, 09 Oct 2026 15:10:13 +0000
X-Mizu-Trace-ID: 6ffb09638a1a6eac
X-Migadu-Flow: FLOW_OUT
Message-ID: <6a42f97c-66ac-4f44-90be-79e3359b2444@linux.dev>
Date: Fri, 9 Oct 2026 17:10:12 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v10 04/24] bpf: Keep a call site's landing pad in
 insn_aux_data, add lookups
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
References: <20261009041447.17092-1-yonghong.song@linux.dev>
 <20261009041508.23246-1-yonghong.song@linux.dev>
 <sashiko-outbox-164829@kernel.org>
Content-Language: en-GB
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <sashiko-outbox-164829@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 10/9/26 6:28 AM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] bpf: adjust_insn_aux_data fails to shift cleanup_pad for BPF_PATCH_MOVE_TARGET
> --
>
> commit 8654da066c194611f7e2de5fef00da7ac62a0070
> Author: Yonghong Song <yonghong.song@linux.dev>
>
> bpf: Keep a call site's landing pad in insn_aux_data, add lookups
>
> This commit tracks a call site's landing pad in insn_aux_data as cleanup_pad.
> It updates adjust_insn_aux_data(), verifier_remove_insns(), and
> bpf_opt_remove_nops() to keep this data in sync when instructions are patched
> or removed.
>
>> diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
>> index 206cc9a614a95..64baee1a37e60 100644
>> --- a/kernel/bpf/fixups.c
>> +++ b/kernel/bpf/fixups.c
> [ ... ]
>
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
> [Severity: High]
> Does this check properly account for the BPF_PATCH_MOVE_TARGET patch mode?
>
> When bpf_patch_insn_data() is called with BPF_PATCH_MOVE_TARGET (for example,
> when inserting a prologue), the original instruction is shifted to the end of
> the newly inserted sequence. If a landing pad points exactly to the patched
> instruction:
>
>      data[i].cleanup_pad == off + 1
>
> This condition would evaluate to false, leaving the cleanup_pad unadjusted.
>
> As a result, if a subprogram with a landing pad at its first instruction
> receives a prologue, wouldn't the unwinder incorrectly jump to the prologue
> instead of the original instruction?
>
> Could this lead to stack or frame pointer corruption by re-executing prologue
> stack setups during unwinding? Other locations handling jumps typically use a
> ternary to handle this, such as checking if it is greater than:
>
>      (mode == BPF_PATCH_MOVE_TARGET) ? off : off + 1

Looks like there are no new change with BPF_PATCH_MOVE_TARGET, so I think
we do not need to do the above. The below is the comment in v9:

====

Okay, commit "bpf: Retarget indirect jump targets across prologue prepends"
introduced BPF_PATCH_MOVE_TARGET and merged last Friday. It solved three
cases for ops->gen_epilogue, ops->gen_prologue || env->seen_direct_write, and
stack slots for subprogs. ops->gen_epilogue has been rejected in patch 5.
We cannot allow ops->gen_epilogue since it may silently exit.
For other cases in "bpf: Retarget indirect jump targets across prologue prepends",
The above commit should already handle this.

For the other two, cleanup_pad == off + 1 cannot happen, because MOVE only
patches an entry insn and a landing pad cannot start at insn 0: the entry is
always walked outside a pad first, so reaching it again from an unwind
fails bpf_exc_check_insn() with "insn %u runs both inside and outside a
landing pad". Pads after off are shifted by the existing `> off + 1`, and a
covered call at off moves with its insn_aux_data.

====

