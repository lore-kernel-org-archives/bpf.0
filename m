Received: from mta1.migadu.com (out-210.mta1.migadu.com [95.215.58.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC0E83A4274
	for <bpf@vger.kernel.org>; Fri,  2 Oct 2026 18:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790965060; cv=none; b=queLXcRzn2UPh1uVEX/hfrkufWNiMvDckH6SZkyWDysGM1oqLd6HFO24w1yh0nMR7tJuou3bC8GLn0OecjyrLUfQPNL+auC2dhZT0lcYUDv5CiUFX9fKVo1mJR7PLI3TAtQBAnJxuW1KM5ekGYT6N2hyB0X5s1+Li55brDem60A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790965060; c=relaxed/simple;
	bh=Gzc/3ojeVy036/D5ZN1i2B0XlYfgGgl6dvY7i4h1k8o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YZbyosZy6FFWoWkuB/fsgObL84S17yZfZk55cySu4mRDwvqGarOzNsgUNvIso406prxFPsB3ovIHvjkAubG7cnAGe3a+yuAccIhilCYhFtLF2KselPWNSc9eQtYA3zAQ+tIpGS946IWiQJTEgnRUj6CI1QyZfWrSgHbgdsUGrI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=VXNE4Zfl; arc=none smtp.client-ip=95.215.58.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="VXNE4Zfl"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=Gzc/3ojeVy036/D5ZN1i2B0XlYfgGgl6dvY7i4h1k8o=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790965055; v=1; x=1791569855;
 b=VXNE4ZflpE1Ce8qtmHVyBIZk9xmIzGn7pwgWNhsq2D+bwpSwdDpUvWBQ39/8ffvAOZpqvE4M
 Qus/spJszaxjtxoLy+j60Uz7jMe6ajfKVmISm1qZI6xWOs3wt0zepWQHd03Dg05jh+Pge8Jvfxg
 sv/3FXOdaQE2KhLkA7ON3GVA=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 56805890d06bb522;
	Fri, 02 Oct 2026 18:17:35 +0000
X-Mizu-Trace-ID: 56805890d06bb522
X-Migadu-Flow: FLOW_OUT
Message-ID: <3beddaa2-1abd-4b2d-b220-549c3f3c7d89@linux.dev>
Date: Fri, 2 Oct 2026 19:17:30 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v8 04/22] bpf: Add lookups for exception cleanup
 resumes and landing pads
Content-Language: en-GB
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
References: <20261001133006.1335369-1-yonghong.song@linux.dev>
 <20261001133027.1338227-1-yonghong.song@linux.dev>
 <20261001134805.EA74F1F000FF@smtp.kernel.org>
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20261001134805.EA74F1F000FF@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/1/26 6:48 AM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] bpf: failure to adjust cleanup_pad for BPF_PATCH_MOVE_TARGET allows arbitrary read/crash
> --
>
> commit 1a4d7ce9c87bb54c2feec4648d42fa1046ccb8b1
> Author: Yonghong Song <yonghong.song@linux.dev>
>
> bpf: Add lookups for exception cleanup resumes and landing pads
>
> This commit adds lookups to exception.c to recognize calls to bpf_unwind()
> and bpf_unwind_resume(). It also updates bpf_patch_insn_data(),
> verifier_remove_insns(), and bpf_opt_remove_nops() to keep the landing pads
> of call sites properly synchronized.
>
>> diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
>> index 37cf130ebb57b..5b7fe4ba610b3 100644
>> --- a/kernel/bpf/fixups.c
>> +++ b/kernel/bpf/fixups.c
> [ ... ]
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
> [Severity: High]
> Could this fail to adjust the cleanup_pad correctly when the mode is
> BPF_PATCH_MOVE_TARGET in adjust_insn_aux_data()?
>
> The condition checks data[i].cleanup_pad > off + 1, which works well for
> BPF_PATCH_KEEP_TARGET, but it appears to miss BPF_PATCH_MOVE_TARGET where
> the target should follow the original instruction to the end of the patched
> sequence.
>
> When a prologue is inserted at offset 0 (for example, during
> bpf_convert_ctx_accesses), exception landing pads pointing to offset 0 are
> not shifted. If a user sets an exception landing pad at offset 0, unwinding
> would cause execution to jump to the newly inserted prologue instead of the
> original instruction.
>
> Since the prologue for program types like TC expects R1 to contain the CTX
> pointer, and R1 is a caller-saved register containing whatever was placed
> there before calling bpf_unwind(), could dereferencing this
> attacker-controlled R1 during an exception unwind lead to an arbitrary memory
> read or a kernel panic?
>
> Should this check be dependent on the mode, such as:
> data[i].cleanup_pad > (mode == BPF_PATCH_MOVE_TARGET ? off : off + 1)
> to properly account for both modes?
>
This patch should be okay. The following is what I replied in v8 for this patch:

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

So I think this patch should be okay.

