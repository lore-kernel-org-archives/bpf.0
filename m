Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1147333A9F3
	for <bpf@vger.kernel.org>; Mon,  6 Apr 2026 16:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775492370; cv=none; b=HFEh8HxwpK3YmRU9msysC3Vb1JXgApMlxsDJU0/H9NBqgRDbyS+WniCpfNnD5FWgMeI71xP4ZmpbZzkPv8eY4xR3uZgBunYRL67lWt4PK+SxdDMt9yMEtArIWKneOr/hDMnHOQn+5cnkO2sTmwBhhyqMTvENLXp8jITM/zo4NXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775492370; c=relaxed/simple;
	bh=wc9oV6masXiA4oxN0jkWOc3wjx1oDypdP+R68g9Aoxw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pQ+vt/uDNGy1l7ESyenbq0eDdfxXfyEWcXxXK6bJ8HFr7s2A7EVHPD12K6gVPnWCE0DiPIrcePcPys4oaIix7gQDrF6Y6PKQOqG77zRAOxsAX8DhXQM+JF0ayt6uZ2ZF9oBjFYJV02P9PZpo6YSoMWQ4akkdXNvv/RcUzevhxP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=uGi8kMN4; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="uGi8kMN4"
Message-ID: <2036096d-296f-4834-9181-ae895d330d22@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1775492367;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aenu1aOmEir+JGNncYMScXXLx5852bqSEVIx7C4qoWY=;
	b=uGi8kMN4ia+9Tj2OqmPsNnppec+mNQ6zORCUtyZi2FWhGoJuCnVomfU8V3xuLvYKfuq2Pe
	c2QfeMZG9NYl/9VcBj5SZ3TOcmGSqGA14gEogTmOv27fraUw0MiemR0lRQlBCD5Aeq+WRU
	Uov628H0kXapM0mxtQgGRj9N6uNLuD8=
Date: Mon, 6 Apr 2026 09:19:18 -0700
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
 <074ee11d-3f63-4e6c-b66d-c60a834cbb25@linux.dev>
 <CAADnVQ+9OdBFnUAXND-MW7epFnqwj9f2w-w0xPD7T73sTMj9Zw@mail.gmail.com>
 <5f37fcf2-05f7-47d3-b412-1515ee19fbea@linux.dev>
 <CAADnVQJ6y33kKOPTWvHu-ZNLFa8JOUih5qfv+e-71+W=orBNhw@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <CAADnVQJ6y33kKOPTWvHu-ZNLFa8JOUih5qfv+e-71+W=orBNhw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 4/6/26 8:17 AM, Alexei Starovoitov wrote:
> On Sun, Apr 5, 2026 at 11:03 PM Yonghong Song <yonghong.song@linux.dev> wrote:
>>
>>
>> On 4/5/26 9:51 PM, Alexei Starovoitov wrote:
>>> On Sun, Apr 5, 2026 at 9:29 PM Yonghong Song <yonghong.song@linux.dev> wrote:
>>>>> For 6th argument JIT emits these two stx/ldx as moves to/from x86's r9.
>>>> For stx case, we should move the bottom stack value (6th argument)
>>>> to r9 and pop the bottom stack slot (8 bytes).
>>> That doesn't sound right.
>>> Passing 6th argument should not involve stack manipulation at all.
>>> No push and no pop.
>> The following stack layout can avoid the above push/pop issue:
>>
>>      incoming stack arg N -> 1
>>      return adderss
>>      saved rbp
>>      BPF program stack
>>      tail call cnt <== if tail call reachable
> let's disallow mixing 6+ args and tailcalls.

Okay.

>
>>      callee-saved regs
>>      r9 <== if priv_frame_ptr is not null
> I guess we can also disable private stack and 6+ args.
> Looks like it's a bit in the way.
> The compilers will emit
> stx [r12 - N], src_reg // store of outgoing 6th arg
> call
>
> For priv stack JIT will emit push_r9 while JITing call insn.
> But it should push_r9 before stx converts to 'mov %r9 <- %src_reg'.

I guess this is not enough. we can push_r9 in prologue. But for
priv stack, r9 is still used in the normal bpf load/store codes.
This will interfere with jitting 'mov %r9 <- %src_reg'.

As you mentioned later, disable priv_stack would work.

> Maybe we can reload r9 after the call instead of push/pop.
>
>>      outgoing stack arg 1
>>      outgoing stack arg M -> 2
>>
>> After the above pushing (outgoing stack arg M -> 2),
>> if bpf-to-bpf, push the outgoing stack arg 1.
>> If kfunc, move outgoing stack arg 1 to r9.
> Ideally JIT treats subprog calls and kfunc calls the same way.
> Why should they be different ?
> In the callee, in both cases, the first insn in the prologue
> can be 'mov [rbp + ] <- %r9',
>
> so that later 'ldx [r12 + ' can be JITed as-is. Here priv stack
> is not in the way.
> Without priv stack we can avoid this first 'mov [rbp + ] <- %r9'
> in the prologue and instead JIT 'ldx [r12 + ' as 'mov %dst_reg <- %r9'
> since nothing will be overwriting %r9.
>
> It feels to me that it's easier to disallow priv stack for now.

So if we disallow priv_stack, we can do
    stx[r12 - first_arg_off] = val/reg => mov %r9, val/reg
other arg_off will be pushed to stack in reverse orders.

So for kfunc, 'mov %r9, val' already there, so we should be okay.
For bpf-to-bpf, do 'push %r9'.

Is this correct?


