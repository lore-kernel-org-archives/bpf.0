Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 463A318DB01
	for <bpf@vger.kernel.org>; Fri,  3 Apr 2026 04:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775189466; cv=none; b=TKu/KrBCR/WO4HuglZhiJtnRD9dAsfywX0aZM79fp+aNV8Yrpr+eUh76LLqJX0z4OY9KQGmv6ruR8QTItcRhdPr4GfCW5hPwyfJSA9xRkZQxGowZrgAPT7JCAr72bMbEcQQOA83F6FfXzyZWwxxEUR/c9SxHLvML87DVMNs3aqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775189466; c=relaxed/simple;
	bh=Mk6s2wF7lUqegZreNQ7/UT+x35FBYMS71iu1LaeJhSE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XXWXcbeVMtKg5KHyqIrotMIpzdeKaGbB0ucGv1007B8R9eB+wxhRsJFx4KBpUTdJ9GHLwD/ucBBilmbLnkiSfYHhRYwqeQmornWAbBPpFh9+x3EWKuo4rQ9TP3sxj5PeWqr9fiDFu5WvV0R0y1P0A2FVah2LGn43YQf9XZqMhhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ioAqT0YE; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ioAqT0YE"
Message-ID: <924fde92-d28f-471d-9f0a-0c176958139c@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1775189463;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bSL/2hzS7suMJfIiRcM0tcUTWR/4Z+98hMWfRtiJdPc=;
	b=ioAqT0YE7C4qopyenGJtQerOiiZExmx7OVu21THgLuRoUTt+cJwEmhi0wjDhrHvt5uzNb6
	n6v1K0pP0Vp5IgHJx+PmM8LXNgJqRbjlnkRFCtOsMZj1lqiwuyARLk83HHOYzei+57bQ6N
	6WSwoEHy5IyNwlIsHyOaCUXHdUGY/4U=
Date: Thu, 2 Apr 2026 21:10:57 -0700
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
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <CAADnVQ+y1jZZTyNcXghD0UQ+JzD0pEu=icSP7=+QY4b=9dzv7A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 4/2/26 4:38 PM, Alexei Starovoitov wrote:
> On Wed, Apr 1, 2026 at 6:27 PM Yonghong Song <yonghong.song@linux.dev> wrote:
>> Currently BPF functions (subprogs) are limited to 5 register arguments.
>> With [1], the compiler can emit code that passes additional arguments
>> via a dedicated stack area through bpf register
>> BPF_REG_STACK_ARG_BASE (r12), introduced in the previous patch.
>>
>> The following is an example to show how stack arguments are saved
>> and transferred between caller and callee:
>>
>>    int foo(int a1, int a2, int a3, int a4, int a5, int a6, int a7) {
>>      ...
>>      bar(a1, a2, a3, a4, a5, a6, a7, a8);
>>      ...
>>    }
>>
>> The following is a illustration of stack allocation:
>>
>>     Caller (foo)                           Callee (bar)
>>     ============                           ============
>>     r12-relative stack arg area:           r12-relative stack arg area:
>>
>>     r12-8:  [incoming arg 6]          +--> r12-8:  [incoming arg 6] (from caller's outgoing r12-24)
>>     r12-16: [incoming arg 7]          |+-> r12-16: [incoming arg 7] (from caller's outgoing r12-32)
>>                                       ||+> r12-24: [incoming arg 8] (from caller's outgoing r12-40)
>>     ---- incoming/outgoing boundary   |||  ---- incoming/outgoing boundary
>>     r12-24: [outgoing arg 6 to callee]+||   ...
>>     r12-32: [outgoing arg 7 to callee]-+|
>>     r12-40: [outgoing arg 8 to callee]--+
> I haven't looked at the patch itself only at this diagram.
> How does it suppose to map to x86 calling convention?
> The shift is unusual.
> x86 is using fp-N for outgoing and fp+N for incoming.
> Why can't we use the same?
>
This is not for jit. The above transfer is for verification purpose.
For example, for callee, a load 'rX = *(u64 *)(r12 - 8)' can easily
get the value rX in callee since the value is copied from caller to callee.

