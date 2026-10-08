Received: from mta0.migadu.com (out-75.mta0.migadu.com [91.218.175.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CFB93D34A2
	for <bpf@vger.kernel.org>; Thu,  8 Oct 2026 15:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.75
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791475120; cv=none; b=LM7EVoYJtrgR9seJPp+0aTNh45096p9oWmZdPQ+XBn4CpCl5POKkvpTWNxsSCQy1q6a9OFyluwN9ovgpAvi0morNh6jD69At+PUtJKxMbKxl4dGruaRjt0mE+40Wgivr9lWN/xNmrwu3xjENYWCSUlzoSYYaqyZk5TREvfPW9SQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791475120; c=relaxed/simple;
	bh=ZVUiW/1nP2zUt3FbgBmMgYG2aB8NNhzx4UIMz7G+lEc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C/WY9xjMJe4nOeUqgPvi1zx9WlhYfN9hvSemLEvvoSfoODmJmjSNsqSPPc2olNNUjylicQvWLpNjlHTRAAd73OmUCeVVYcmYd2o/FjHX0C8QoA6V9srLTS9Ko8QmZ2z/srnqemDaEr710BeXtsPr28nxbZLgJwMiZ4RklINWCwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=K6wbqH9b; arc=none smtp.client-ip=91.218.175.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="K6wbqH9b"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=ZVUiW/1nP2zUt3FbgBmMgYG2aB8NNhzx4UIMz7G+lEc=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791475113; v=1; x=1792079913;
 b=K6wbqH9bKwsOEhfbETNtk/tgCdeR6rC4tRolK5jW3vGWF7zkQ6Wotwrs1b2X8qA5wYT8SUQd
 3o/zcP7CffwGL2TrrLc7zZMHNgiCx4zwJofQdfIDiQEv3U8Fs/Xovv/SWalCzY1miQrR0YM0pa5
 zH3BS1WCmkbDfunFHmgDvZnQ=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 91a68359b3fdaedd;
	Thu, 08 Oct 2026 15:58:33 +0000
X-Mizu-Trace-ID: 91a68359b3fdaedd
X-Migadu-Flow: FLOW_OUT
Message-ID: <47ea84dd-47df-4b9c-80d4-3422a3a53f03@linux.dev>
Date: Thu, 8 Oct 2026 17:58:33 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v9 04/23] bpf: Keep a call site's landing pad in
 insn_aux_data, add lookups
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
References: <20261008074959.2993751-1-yonghong.song@linux.dev>
 <20261008075020.2996443-1-yonghong.song@linux.dev>
 <sashiko-outbox-163795@kernel.org>
Content-Language: en-GB
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <sashiko-outbox-163795@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/8/26 10:01 AM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] bpf: adjust_insn_aux_data() fails to shift cleanup_pad for BPF_PATCH_MOVE_TARGET
> --
>
> commit 1bdc64eca7dc9ba53a20b6b6c4d0e4448bdd4aa8
> Author: Yonghong Song <yonghong.song@linux.dev>
>
> bpf: Keep a call site's landing pad in insn_aux_data, add lookups
>
> A call site's landing pad, if any, is kept in insn_aux_data as
> cleanup_pad, so the three places that move instructions --
> bpf_patch_insn_data(), verifier_remove_insns() and bpf_opt_remove_nops()
> -- keep it in step. Add lookups for it and for calls to bpf_unwind() and
> bpf_unwind_resume(); their users come in later patches.
>
>> diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
>> index 206cc9a614a95..64baee1a37e60 100644
>> --- a/kernel/bpf/fixups.c
>> +++ b/kernel/bpf/fixups.c
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
> [Severity: Medium]
> Does this logic fail to adjust the landing pad when mode is
> BPF_PATCH_MOVE_TARGET?
>
> By unconditionally using off + 1, this appears to assume
> BPF_PATCH_KEEP_TARGET semantics.
>
> If bpf_patch_insn_data() is called with BPF_PATCH_MOVE_TARGET and the landing
> pad is located exactly at the patched instruction, data[i].cleanup_pad would
> be equal to off + 1 (the 1-based index). The condition
> data[i].cleanup_pad > off + 1 evaluates to false, meaning the landing pad
> index is not shifted.
>
> As a result, the landing pad remains pointing at the newly inserted
> instructions instead of following the original instruction shifted to
> off + cnt - 1.
>
> Could this cause the unwinder to jump to the wrong instruction offset,
> potentially leading to state corruption during an exception unwind?

This won't happen. The below is v7 reply to sashiko. v8 does not pop
up this issue. and now v9 it comes back.

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


