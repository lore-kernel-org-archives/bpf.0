Received: from mta0.migadu.com (out-240.mta0.migadu.com [91.218.175.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62CC435DA6E
	for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 03:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790133490; cv=none; b=MsAPtynUfth2jMI2YJUOCJHDJBuAMp9EHkl+0ul4dsyOST6KGUg8ed5F6RRlJwaqjfUw86luo4gjiFvma+MqCi8RBp0ROgR8KTMFgxZR7NJm2RFMcphkgS/Ojx9XTIuiBPZtzuayGPxHY7p915MNEdwWURneAtwgNwc0JJPgD/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790133490; c=relaxed/simple;
	bh=w8Oz99m4SBx9p+7LAELvse3ZepLfHGA4iPCL+YYH4jM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WBl+AcLVUns1iUkKUzbK7IJYgSJ2POFLDsS80hT9oeXgPRrSJHcUmPTCsm1dj5Cn2hOWRKDf+wii/v+6pwXfxfrtblMNcvEF2pdB81EhTJgV+yOpZ7S5hzODdB0WigH7JUzqwImygPls37uBqdfT4DlElV6FW3q3nTLl8rcqbpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=euU/RFSN; arc=none smtp.client-ip=91.218.175.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="euU/RFSN"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=w8Oz99m4SBx9p+7LAELvse3ZepLfHGA4iPCL+YYH4jM=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790133486; v=1; x=1790738286;
 b=euU/RFSNxMQ8vNIV042nPRuC81gZFTWlCrqMrFPEZsUUHKmytR1uR/1W6+gvhU3d+3HWwu5e
 BOTp3uGzbW9dTXTZreAOoBtoIohB8cSQQVstjzBkBL91jJwUAPNek/rf0qX02f9KBBSUhWwXcxs
 Fdx+GZBF7WtzONOXmyuhX6Qs=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id a99958fb9618cd0e;
	Wed, 23 Sep 2026 03:18:06 +0000
X-Mizu-Trace-ID: a99958fb9618cd0e
X-Migadu-Flow: FLOW_OUT
Message-ID: <3e725d87-5531-419f-b148-89261040904d@linux.dev>
Date: Tue, 22 Sep 2026 20:18:02 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v4 08/20] bpf: Walk the exception unwind in the
 verifier
Content-Language: en-GB
To: Eduard Zingerman <eddyz87@gmail.com>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com
References: <20260921210033.1715000-1-yonghong.song@linux.dev>
 <20260921210114.1720196-1-yonghong.song@linux.dev>
 <DLLJT7NBMC67.1MIBGY9CC99CA@gmail.com>
 <fb67e32a-6215-4695-8003-7cfcfba2ac50@linux.dev>
 <e896db69276278e0053adaff941ae8c78eac1e78.camel@gmail.com>
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <e896db69276278e0053adaff941ae8c78eac1e78.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 9/22/26 2:53 PM, Eduard Zingerman wrote:
> On Mon, 2026-09-21 at 22:25 -0700, Yonghong Song wrote:
>> On 9/21/26 9:08 PM, Alexei Starovoitov wrote:
>>> On Mon Sep 21, 2026 at 9:01 PM UTC, Yonghong Song wrote:
>>>> --- /dev/null
>>>> +++ b/include/linux/bpf_cleanup_abi.h
>>>> @@ -0,0 +1,16 @@
>>>> +/* SPDX-License-Identifier: GPL-2.0-only */
>>>> +/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
>>>> +#ifndef _LINUX_BPF_CLEANUP_ABI_H
>>>> +#define _LINUX_BPF_CLEANUP_ABI_H
>>>> +
>>>> +/*
>>>> + * Value arch_bpf_run_cleanup_pad() leaves in r0 on the way into a landing pad.
>>>> + * It has to be a constant the verifier knows: LLVM names r0 as both the
>>>> + * exception pointer and the exception selector register, so every pad reads it
>>>> + * before anything else and is free to store what it read. It gets a header of
>>>> + * its own because the two sides that have to agree on it are the verifier and
>>>> + * the arch dispatchers, which are assembly.
>>>> + */
>>>> +#define BPF_PAD_ENTRY_R0	1
>>>> +
>>>> +#endif /* _LINUX_BPF_CLEANUP_ABI_H */
>>> I'm not going to read the AI reasons in commit log that it came up with
>>> to justify new .h.
>>> I bet it doesn't need new .h. If it does, please spell it out with human voice.
>>> And, in general, pls tell AI to be terse. and remember it forever.
>>>
>>> I told my clanker to be like me. Terse and to the point.
>> Okay, I added this file to be shared in x86/net/bpf_cleanup_pad.S,
>> arm64/net/bpf_cleanup_pad.S and verifier.c.  Yes, we can remove it
>> with single line comment in their respective files.
>>
> As far as I understand BPF_PAD_ENTRY_R0 is not needed at all.
> As the value is unused the jits can zero out R0 upon landing
> pad entry from throw or resume, verifier can initialize R0 as
> an unknown scalar: mark_reg_unknown(env, frame->regs, BPF_REG_0).

Agree. R0 is not really needed so make it mark_reg_unknown is
the right approach.


