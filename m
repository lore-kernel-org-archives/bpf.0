Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 273F120C00A
	for <bpf@vger.kernel.org>; Mon,  6 Apr 2026 04:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775449787; cv=none; b=A2oKUT2F7ITiWrM/uzx33s9N6hv+fHAQejVy+KV0/5IvG6BseVW8twhYZUlVqmpi204Oy3t43nMS1CCTq0z0K9mTJrGbMwhTxj8x5CpwgG44Ak3+BderrnhbBimyOe1u3a1T7zyOqPwniUiy3vstTGcN98yFh//OBRJkbHMGdDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775449787; c=relaxed/simple;
	bh=t53oiJ/SAcRLUuDrJXCue585hBKcgHbRZnZfmbtyCq4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=txpSRR2kidR/TJrhdiMi3dhRv0tdbUg+F013sX3kDjTF/4rbqgEEbjZCWCTt16tE9DZZTLwG3kyZPwNPgrh/6Y/bQmAY3N5lLeFnizXN3Qg3On7LhAir9HysUg0ICXDJu5gpTM/o18SVCFG1iVu4byUmhNiqxfxnrvAUrEeNMu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=GyKsxkud; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="GyKsxkud"
Message-ID: <074ee11d-3f63-4e6c-b66d-c60a834cbb25@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1775449784;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=R4pFWtj1u6KNXIThWQyl5gWfe/OM4uRcQNVDht5LHkY=;
	b=GyKsxkuduMBF7985A1TApcSHNMViiiEBTc77sZ+7KjoyJerys3FTZ28KbYcxLwngY1wNcc
	2r0X6MxhkdeyLaCP+69eSKqJItaIgGFf3XG0BgWpCjSH/6t3r5QaKr55jH1WOLV5JnNNiT
	VuYZh54FKXpAz3pp+c22ITvxVDzyFVU=
Date: Sun, 5 Apr 2026 21:29:38 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 03/10] bpf: Support stack arguments for bpf
 functions
Content-Language: en-GB
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 "Jose E . Marchesi" <jose.marchesi@oracle.com>,
 Kernel Team <kernel-team@fb.com>, Martin KaFai Lau <martin.lau@kernel.org>
References: <20260402012727.3916819-1-yonghong.song@linux.dev>
 <20260402012742.3917613-1-yonghong.song@linux.dev>
 <CAADnVQ+y1jZZTyNcXghD0UQ+JzD0pEu=icSP7=+QY4b=9dzv7A@mail.gmail.com>
 <924fde92-d28f-471d-9f0a-0c176958139c@linux.dev>
 <CAADnVQJdTffT5sdqZVdWX9W-jG2vPjiPAA0OT3iMPPsY9-KFmA@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <CAADnVQJdTffT5sdqZVdWX9W-jG2vPjiPAA0OT3iMPPsY9-KFmA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 4/5/26 2:07 PM, Alexei Starovoitov wrote:
> On Thu, Apr 2, 2026 at 9:11 PM Yonghong Song <yonghong.song@linux.dev> wrote:
>>
>>
>> On 4/2/26 4:38 PM, Alexei Starovoitov wrote:
>>> On Wed, Apr 1, 2026 at 6:27 PM Yonghong Song <yonghong.song@linux.dev> wrote:
>>>> Currently BPF functions (subprogs) are limited to 5 register arguments.
>>>> With [1], the compiler can emit code that passes additional arguments
>>>> via a dedicated stack area through bpf register
>>>> BPF_REG_STACK_ARG_BASE (r12), introduced in the previous patch.
>>>>
>>>> The following is an example to show how stack arguments are saved
>>>> and transferred between caller and callee:
>>>>
>>>>     int foo(int a1, int a2, int a3, int a4, int a5, int a6, int a7) {
>>>>       ...
>>>>       bar(a1, a2, a3, a4, a5, a6, a7, a8);
>>>>       ...
>>>>     }
>>>>
>>>> The following is a illustration of stack allocation:
>>>>
>>>>      Caller (foo)                           Callee (bar)
>>>>      ============                           ============
>>>>      r12-relative stack arg area:           r12-relative stack arg area:
>>>>
>>>>      r12-8:  [incoming arg 6]          +--> r12-8:  [incoming arg 6] (from caller's outgoing r12-24)
>>>>      r12-16: [incoming arg 7]          |+-> r12-16: [incoming arg 7] (from caller's outgoing r12-32)
>>>>                                        ||+> r12-24: [incoming arg 8] (from caller's outgoing r12-40)
>>>>      ---- incoming/outgoing boundary   |||  ---- incoming/outgoing boundary
>>>>      r12-24: [outgoing arg 6 to callee]+||   ...
>>>>      r12-32: [outgoing arg 7 to callee]-+|
>>>>      r12-40: [outgoing arg 8 to callee]--+
>>> I haven't looked at the patch itself only at this diagram.
>>> How does it suppose to map to x86 calling convention?
>>> The shift is unusual.
>>> x86 is using fp-N for outgoing and fp+N for incoming.
>>> Why can't we use the same?
>>>
>> This is not for jit. The above transfer is for verification purpose.
>> For example, for callee, a load 'rX = *(u64 *)(r12 - 8)' can easily
>> get the value rX in callee since the value is copied from caller to callee.
> There shouldn't be any extra copy.
> For 7th and higher argument:
> the caller does 'stx [r12 - N]' and the callee does 'ldx [r12 + M]'
> and JIT emits them as-is only adjusting N and M constants.

Indeed, for 7th and higher arguments, ldx and stx and directly get
or store values in expected calling-convention places.

>
> For 6th argument JIT emits these two stx/ldx as moves to/from x86's r9.

For stx case, we should move the bottom stack value (6th argument)
to r9 and pop the bottom stack slot (8 bytes).

For ldx case, this is a bpf callee to access a bpf caller. In such
cases, r9 is not involved.


