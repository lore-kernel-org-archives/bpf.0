Received: from mta0.migadu.com (out-169.mta0.migadu.com [91.218.175.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5DDB33E360
	for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 23:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790204987; cv=none; b=tXn6a/HOpTNFuFiy7zgDK5BfBiaMwkwr0fKSQT3uAPP770UdMgzyoBmXKxWolUBHvSUf8YcI7c7pmRwjQFha8T7FZTypvjC3uw5kCfHpCcbJ3bj/Qyepr2JO7yFVQGXu8mGrvhGc4dTfkpanNck+SahAR8TA7byttpkmwiuSaRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790204987; c=relaxed/simple;
	bh=fBC/IomwUHGzw8zkIhAiiLI02Qcn8WkmJ66IbrIqL9Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eibEsnmEUTgnm5Dp3MvMKUgmeC23sIVA6wynCEMBKzrGRU5+S67AODvVVU9XbRlSRdIS3uKB9TveLD+feiQDEDcxoGX5tYSJSeROoHzUdhZvRDY/0mHb1wnAPLRGSdAofdj0CyMfH3kUqAIQph6yxdqeWNpXl2cOr5be9UWT188=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=lsl+BPRg; arc=none smtp.client-ip=91.218.175.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="lsl+BPRg"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=fBC/IomwUHGzw8zkIhAiiLI02Qcn8WkmJ66IbrIqL9Q=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790204983; v=1; x=1790809783;
 b=lsl+BPRgZZLo/EoSJZZQzV2DrfPTfERL9jd2Kc22eNVVMt6kYc9LdrDd2EKEqU9SOcAxqYhJ
 WVNmpY2jp4vaQN5WyKvIPtIqmsPSi+EXlpVf3RSv/7wVE6Ym+iz/seGPUs9vHg3OyAqIe/jMIzq
 n3lY9BbkdPqsnqCwZSN6Qfj4=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 879518b3f3eaa58e;
	Wed, 23 Sep 2026 23:09:43 +0000
X-Mizu-Trace-ID: 879518b3f3eaa58e
X-Migadu-Flow: FLOW_OUT
Message-ID: <f6e4c8ae-813d-4696-b534-14c9a87bcbb9@linux.dev>
Date: Wed, 23 Sep 2026 16:09:39 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v5 07/21] bpf: Explore the landing pads no call
 site reaches
Content-Language: en-GB
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Eduard Zingerman <eddyz87@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com
References: <20260923045846.2414643-1-yonghong.song@linux.dev>
 <20260923045922.2417689-1-yonghong.song@linux.dev>
 <df24934c5ecbd70bc35b528b8e58ae668ce02051.camel@gmail.com>
 <DLN0K7231LF2.1UNIBGA546C90@gmail.com>
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <DLN0K7231LF2.1UNIBGA546C90@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 9/23/26 2:28 PM, Alexei Starovoitov wrote:
> On Wed Sep 23, 2026 at 4:26 PM UTC, Eduard Zingerman wrote:
>> On Tue, 2026-09-22 at 21:59 -0700, Yonghong Song wrote:
>>> A cleanup record need not cover a call an exception can unwind out of: a
>>> frontend is free to emit a region around a helper or an ordinary kfunc,
>>> both nounwind here. Nothing marks a call site then, and that record's
>>> landing pad is reached by nothing at all -- leaving bpf_check_cfg() to
>>> refuse the program over code its own frontend had no way not to emit:
>>>
>>>     0: call bpf_preempt_disable
>>>     1: call bpf_preempt_enable      record = { begin = 1, end = 2, pad = 4 }
>>>     2: r0 = 0
>>>     3: exit
>>>     4: r1 = pads_ran ll             landing pad
>>>     6: r2 = *(u64 *)(r1 + 0)
>>>     7: r2 |= RAN_NOUNWIND_REC
>>>     8: *(u64 *)(r1 + 0) = r2
>>>     9: call bpf_unwind_resume
>>>    10: exit
>>>
>>> The range [1,2) holds one call, and it is a kfunc, so an exception cannot
>>> come out of it. mark_call_sites() marks nothing, nothing pushes an edge to
>>> 4, and 4 through 10 are reachable from nothing: "unreachable insn 4". The
>>> pad is dead, which is correct -- no exception can ever arrive at it -- but
>>> the program is fine and has to load.
>>>
>>> Walk every pad the table names that the edges did not reach, the way the
>>> walk is already re-seeded at an exception callback. From there the pad is
>>> code like any other: do_check() never enters it, because no call site
>>> dispatches to it, so the dead code sweep removes it along with everything
>>> else that was not reached.
>>>
>>> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
>>> ---
>> Yonghong, in v4 you said that rustc does not generate dead landing pads.
>> Why do we need this patch?
> It's not dead. commit log is incorrect.
>
> I bet C code that caused such asm didn't mark bpf_preempt_enable as nothrow,
> so compiler correctly emitted exception table.
> Now commit log argues that this helper doesn't throw in reality.
> Well, too late, the mistake was made earlier.
>
> I don't like the unwind approach taken by later patches in the series.
>
> imo the following is cleaner:
> - do not repurpose bpf_throw() for this new thing.
>    Introduce new kfunc that will do the unwind, let's name it bpf_unwind() ?
> - replace all 'call bpf_unwind_resume' with NOP by the verifier (or may with bpf_exit. tbd)
>    Technically rustc or llvm can do that too, but it's cleaner to do in the verifier.
> - In bpf_unwind() walk all exception tables and replace return addresses
>    in corresponding frames to landing_pad_ip-s.
> - just return from bpf_unwind().
>    restoring callee saved registers will happen automatically by corresponding
>    frames and there is no need to search exception tables at each step.
>    That's what typical eh unwinder does, but it's doing it due to C++ logic
>    that is more complex that Rust. For Rust unwinds we don't need all that.
>    The above algorithm will do.
>
> Also please add an example where [ip_start, ip_end] range is more than just a call
> insn. I mentioned it couple times as the reason why 'invoke' aka 16-byte insn
> approach doesn't work.
> I'm pretty sure I saw such IP ranges generated by rustc.
>
Thanks for explaining what should be implemented in a simpler way. I will try
to implement this as above steps.


