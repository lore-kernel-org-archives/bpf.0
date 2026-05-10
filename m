Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9248364055
	for <bpf@vger.kernel.org>; Sun, 10 May 2026 16:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778431291; cv=none; b=MPBJDk8Wm6YdFTOEJSHUn/6nxikQ6wCqTb6HVgHyrzl5P++jtEhHDmtEkCZoOlPxS7JmpRwTLLWU0+ulZdGHsFwL7iewhKOsI1NqGCH32uOeVInJpeMGCiJN1WCEbAnMPk1O0wQ/wcWjohZhVzsKh8oyUDwVGaJu41UX4Ekyu4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778431291; c=relaxed/simple;
	bh=kINXlYj0ZqFhDqV5Kh8bif5NJW8WYWpdXrgfmFjbOhA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QXZQ/OZ2f0//WCmRBJjfb5oqyT2udWT6T6tFIInBzORxkIYghSsSRff4MQShkUcrqFkv86h/odxDnHGqK26hBrxaOrLgfYoplg4m9J/N7vL4GOzbpx1II/nFtwRsgPvvV72wctMCO07dY+ADd2KwAt4zbXNJy0t/ieEBoFZdwb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=VElKCbdx; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="VElKCbdx"
Message-ID: <b59b83fa-a762-4a97-91d6-3b28094fa65f@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1778431277;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=brqs3vlEAOl86BNBrmMrWEk4dDnUwWS00c323bfHDXU=;
	b=VElKCbdx9z5kUVE+NYAFBFdJeOWFfEdp/kRCiWQRA4Lq9nYosbQ3rmw89Fxd9HuExb+lpm
	kA1nzaEU/Dcpm8Syh8QrX03ymWUVPGUOFZQfBTvSzUXxMxorkbExwLn5bxcEJAH23LQCwA
	q2gkvRijxXeL7KPbWCggWoK0SNQPkGc=
Date: Sun, 10 May 2026 09:41:12 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2 07/23] bpf: Add precision marking and
 backtracking for stack argument slots
Content-Language: en-GB
To: sashiko@lists.linux.dev
Cc: bpf@vger.kernel.org
References: <20260507213018.1128602-1-yonghong.song@linux.dev>
 <20260509040551.C9E2AC2BCB2@smtp.kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20260509040551.C9E2AC2BCB2@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 5/9/26 6:05 AM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] Incorrect tracking and propagation of stack argument precision at subprogram boundaries in `backtrack_insn()`.
> --
>
> commit 82222fc9756a9a239fae1b810efc4aa155d2973f
> Author: Yonghong Song <yonghong.song@linux.dev>
>
>      bpf: Add precision marking and backtracking for stack argument slots
>
> This commit extends the precision marking and backtracking infrastructure to
> support stack argument slots (r11-based accesses). It ensures precision
> demands for scalar values passed through stack arguments are properly
> tracked.
>
>> diff --git a/kernel/bpf/backtrack.c b/kernel/bpf/backtrack.c
>> index 93738a076c888..17f254a02831f 100644
>> --- a/kernel/bpf/backtrack.c
>> +++ b/kernel/bpf/backtrack.c
> [ ... ]
>> @@ -336,6 +351,19 @@ static int backtrack_insn(struct bpf_verifier_env *env, int idx, int subseq_idx,
>>   			return 0;
>>   		bt_clear_reg(bt, load_reg);
>>   
>> +		if (hist && hist->flags & INSN_F_STACK_ARG_ACCESS) {
>> +			spi = hist->spi;
>> +			/*
>> +			 * Stack arg read: callee reads from r11+off, but
>> +			 * the data lives in the caller's stack_arg_regs.
>> +			 * Set the mask in the caller frame so precision
>> +			 * is marked in the caller's slot at the callee
>> +			 * entry checkpoint.
>> +			 */
>> +			bt_set_frame_stack_arg_slot(bt, bt->frame - 1, spi);
>> +			return 0;
>> +		}
>> +
> When backtracking a callee's read of an incoming stack argument via BPF_LDX,
> the logic correctly sets the mask in the caller frame (bt->frame - 1).
>
> [ ... ]
>> @@ -426,6 +465,18 @@ static int backtrack_insn(struct bpf_verifier_env *env, int idx, int subseq_idx,
>>   						bpf_bt_set_frame_reg(bt, bt->frame - 1, i);
>>   					}
>>   				}
>> +				/*
>> +				 * propagate callee's incoming stack arg precision
>> +				 * to caller's outgoing stack arg slots
>> +				 */
>> +				if (bt_stack_arg_mask(bt)) {
>> +					for (i = 0; i < MAX_BPF_FUNC_ARGS - MAX_BPF_FUNC_REG_ARGS; i++) {
>> +						if (!bt_is_frame_stack_arg_slot_set(bt, bt->frame, i))
>> +							continue;
>> +						bt_clear_frame_stack_arg_slot(bt, bt->frame, i);
>> +						bt_set_frame_stack_arg_slot(bt, bt->frame - 1, i);
>> +					}
>> +				}
> Does this propagation logic operate on the correct mask?
>
> Since the callee's BPF_LDX instructions already marked the incoming stack
> arguments directly in the caller's frame (bt->frame - 1),
> bt_stack_arg_mask(bt) for the current frame (bt->frame) shouldn't contain
> any incoming stack arguments here.

You are right here. bt_is_frame_stack_arg_slot_set(bt, bt->frame, i) should be 0 so
the above whole loop is not necessary.

>
> If bt_stack_arg_mask(bt) is non-zero at this point, wouldn't that indicate
> leftover uninitialized outgoing stack arguments from the callee that were
> never matched by a BPF_STX?
>
> Instead of propagating these leftovers to the caller frame, should this
> condition be treated as a verifier_bug(), similar to how leftover stack
> slots are handled just above this code?

Yes, verifier_bug() makes sense to capture potential issues. This will
be similar to potential bugs with register spills.

>

