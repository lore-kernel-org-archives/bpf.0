Received: from mta0.migadu.com (out-145.mta0.migadu.com [91.218.175.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F1B73DB320
	for <bpf@vger.kernel.org>; Tue, 29 Sep 2026 21:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790719125; cv=none; b=a94AnHKHPOs04YgRaugub5R/p/PA22zRiALKkHGtCP8Bp1AvCcQ3LZniQ6iV9PVpWl7VpM0/YoBCaC5PzVRDu7Jk4E26qNZkvWljSWqV4qLkk8zCTMLMmlyhA05x9g1AFjAQ2bTEIDBTcqQl4Aoik07K0FRg1oFfgM4e1IpVRpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790719125; c=relaxed/simple;
	bh=AT+k59Jf7Yel+lrU/ubCyWe4HYVGDfMZZyk4c3IEoMw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rAm/NLDF3YPqHlQfkpb+w6VY8JbOyyxn0WKZ1Ju4eo+b7Z7ZpOyufKmiFe+hEy4g4FElzp9PqLTTRZYNXF3BFEnQ7TeYaGhx9Jph4rolKZ10Yewi1BoU2f/aZzSZLG10TM4+7eo75x42cOWlkH++FPaRQfDJrIg+cJ/hZa9Iz+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=NpOy8auJ; arc=none smtp.client-ip=91.218.175.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="NpOy8auJ"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=AT+k59Jf7Yel+lrU/ubCyWe4HYVGDfMZZyk4c3IEoMw=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790719119; v=1; x=1791323919;
 b=NpOy8auJhtuNpMlXvU7hHUHAbOj1s/LggKAmDn9YcqdG4zZJVZQopxhIo8nBlKuuZ7WUtgrG
 MWm0TbjfEc4gUfcUrkri2KHjc6qL5Y+HWyspFGc5zn5slkOyt+uezqJknO7hMEiau8vk3+yAbd0
 9URGy0tyUKrKwkMJzJD0FCJo=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 88077444fd536873;
	Tue, 29 Sep 2026 21:58:38 +0000
X-Mizu-Trace-ID: 88077444fd536873
X-Migadu-Flow: FLOW_OUT
Message-ID: <88a780fc-e2ec-47b6-9347-fd2b21bdd585@linux.dev>
Date: Tue, 29 Sep 2026 14:58:36 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v7 04/22] bpf: Add lookups for exception cleanup
 resumes and landing pads
Content-Language: en-GB
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
References: <20260929001601.3242665-1-yonghong.song@linux.dev>
 <20260929001623.3247375-1-yonghong.song@linux.dev>
 <20260929003302.BA9D71F000FF@smtp.kernel.org>
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20260929003302.BA9D71F000FF@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 9/28/26 5:33 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] bpf: missing cleanup_pad adjustment in BPF_PATCH_MOVE_TARGET
> --
>
> commit ddeb49ab1c3e86d5fea9b3b127432b6e34db617b
> Author: Yonghong Song <yonghong.song@linux.dev>
>
> bpf: Add lookups for exception cleanup resumes and landing pads
>
> This commit introduces helpers to recognize exception cleanup resumes and
> landing pads. It also adds logic to maintain cleanup_pad data in
> insn_aux_data when instructions are patched or removed.
>
>> diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
>> index 37cf130ebb57b..5b7fe4ba610b3 100644
>> --- a/kernel/bpf/fixups.c
>> +++ b/kernel/bpf/fixups.c
>> @@ -268,11 +268,18 @@ static void adjust_insn_aux_data(struct bpf_verifier_env *env,
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
> When mode is BPF_PATCH_MOVE_TARGET and the landing pad is located exactly
> at the patched instruction, does this condition fail to adjust it?
>
> Since cleanup_pad is 1-based, a value of off + 1 means the landing pad is
> exactly at off. Because this strictly checks > off + 1, it skips adjusting
> data[i].cleanup_pad when it equals off + 1.
>
> If BPF_PATCH_MOVE_TARGET is used (for example, with gen_prologue or may_goto
> initialization), the original instruction is moved to the end of the patch
> sequence. This means the landing pad should follow it and move to the end
> as well, but it will be left pointing to the start of the inserted sequence.
>
> Could this result in the unwinder jumping to the newly inserted prologue or
> loop initialization instead of the actual exception landing pad?

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

>
>> +
>>   	/*
>>   	 * Last slot instruction could be a newly generated
>>   	 * BPF_ST/BPF_LDX/BPF_STX, systematically mark it for non-stack access

