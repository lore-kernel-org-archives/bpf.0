Received: from mta1.migadu.com (out-2.mta1.migadu.com [95.215.58.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CC833403E8
	for <bpf@vger.kernel.org>; Tue, 22 Sep 2026 05:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790054748; cv=none; b=sYOgLXL7col4s1Vd7SrVkkNXEUozGCV4xGRzRyojtCaYOMcL0oH9bmORnmmjIwcnkPpkoA43PUinR2P/YRHy/UO7WBLcOzift0p8SEektKUCtgIbYy3agTLixjGXBUfvZkBdw126a6T74hG4N4+97bgmtgnLJekfvyHOUyBWDVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790054748; c=relaxed/simple;
	bh=oM0Z9qnK1z/kGJqxnex+d3x6p3Fh/VaA5BaQgsUYQmc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SeePCPUoGoFhypEOINoKyFzpVLbUjj/yQpBw7w5wQfzbYpSgi5/s9EXZQXHPbkeDB6mH1XEp8xtV0Aulz8k2HNN4WGboi4uzlPea3xuxF6jAkv9xgi3g6B0a9Yw5/QbN7h24VSVTnmD7urmr6ydlJcNTTQlTEF/xpvblGbpjNpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=BLU6wYC2; arc=none smtp.client-ip=95.215.58.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="BLU6wYC2"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=oM0Z9qnK1z/kGJqxnex+d3x6p3Fh/VaA5BaQgsUYQmc=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790054741; v=1; x=1790659541;
 b=BLU6wYC2MXuN6qRlulEgYV6B0h2j2PNJmHPkuSwxjfcvnTolKx7OcAVOscvE8J9ar/pD5ySV
 7O38Ekryou/8uQMgIctALMGKpB5USIfNtMNOi+Zko2f6f8W/7KkezKZwjpcXgc5gSmf4sspsfbY
 BwHya1CYcsot9DtIcl3DdHbE=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id dcbe5487e574394c;
	Tue, 22 Sep 2026 05:25:41 +0000
X-Mizu-Trace-ID: dcbe5487e574394c
X-Migadu-Flow: FLOW_OUT
Message-ID: <fb67e32a-6215-4695-8003-7cfcfba2ac50@linux.dev>
Date: Mon, 21 Sep 2026 22:25:38 -0700
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
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Eduard Zingerman
 <eddyz87@gmail.com>, kernel-team@fb.com
References: <20260921210033.1715000-1-yonghong.song@linux.dev>
 <20260921210114.1720196-1-yonghong.song@linux.dev>
 <DLLJT7NBMC67.1MIBGY9CC99CA@gmail.com>
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <DLLJT7NBMC67.1MIBGY9CC99CA@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 9/21/26 9:08 PM, Alexei Starovoitov wrote:
> On Mon Sep 21, 2026 at 9:01 PM UTC, Yonghong Song wrote:
>> --- /dev/null
>> +++ b/include/linux/bpf_cleanup_abi.h
>> @@ -0,0 +1,16 @@
>> +/* SPDX-License-Identifier: GPL-2.0-only */
>> +/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
>> +#ifndef _LINUX_BPF_CLEANUP_ABI_H
>> +#define _LINUX_BPF_CLEANUP_ABI_H
>> +
>> +/*
>> + * Value arch_bpf_run_cleanup_pad() leaves in r0 on the way into a landing pad.
>> + * It has to be a constant the verifier knows: LLVM names r0 as both the
>> + * exception pointer and the exception selector register, so every pad reads it
>> + * before anything else and is free to store what it read. It gets a header of
>> + * its own because the two sides that have to agree on it are the verifier and
>> + * the arch dispatchers, which are assembly.
>> + */
>> +#define BPF_PAD_ENTRY_R0	1
>> +
>> +#endif /* _LINUX_BPF_CLEANUP_ABI_H */
> I'm not going to read the AI reasons in commit log that it came up with
> to justify new .h.
> I bet it doesn't need new .h. If it does, please spell it out with human voice.
> And, in general, pls tell AI to be terse. and remember it forever.
>
> I told my clanker to be like me. Terse and to the point.

Okay, I added this file to be shared in x86/net/bpf_cleanup_pad.S,
arm64/net/bpf_cleanup_pad.S and verifier.c.  Yes, we can remove it
with single line comment in their respective files.


