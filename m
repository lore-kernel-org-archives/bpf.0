Received: from mta1.migadu.com (out-12.mta1.migadu.com [95.215.58.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E47AE3B19D0
	for <bpf@vger.kernel.org>; Wed, 26 Aug 2026 19:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787773960; cv=none; b=Q57qiFcxLhuPUHMr/I0tH4cHxHU3tfCExNdxmJ0dvjxoOeIn9xVpqIyuqGWqqwvEGm6u6Mk/v8gPqIX5HDApdcURqnunUrIEiz2Eyp7mwY2s4WjD7LUHILS2/xvpCVAIA02uwOuQAvVjGGZM6bEwulsImf1M8fo0us/ANwQtzoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787773960; c=relaxed/simple;
	bh=dkyRfi4DMY7VWlxzbj9wR6+C+aBkHHmdKfqab2LonVw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n1MwQ81xnXiIN19vPKrifXiSV1M4vNUcLpMsxNmPvQlguAagj7KB/dRXZtpq1CmFL8dW1FjjSC9474snQG2EQB5QUCS/HQ5Vyfl0lkOLbN3DLlvtfeWbRajRcrkQLEHogkVp2Nqye7rxbRYKMJpYzdw+JOlY0Lsdmd48MCNIRs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=mEd2KQCp; arc=none smtp.client-ip=95.215.58.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="mEd2KQCp"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=dkyRfi4DMY7VWlxzbj9wR6+C+aBkHHmdKfqab2LonVw=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787773952; v=1; x=1788378752;
 b=mEd2KQCpETRSVLRKsj6JLmzoNLZzUSBsCf+dP42BVnoowVHIYZwOSblsTnrTg+3VNj+If4AP
 IQNQ8hT3hhEL7GaYCAPT+4jlynFdkz9rsZ5RgDhhgT200wkSdPO3ZwwXSQlNyZJ+4eEbGsZ9vdh
 7TBNlCwAL4A0fIYMK9kbmc3U=
X-Envelope-To: bpf@vger.kernel.org
Received: from [IPV6:2620:10d:c085:21c1::1576] (2620:10d:c090:400::5:7641)
	by smtp.migadu.com with ESMTPS id 23b5284cc004b0c2;
	Wed, 26 Aug 2026 19:52:22 +0000
X-Mizu-Trace-ID: 23b5284cc004b0c2
X-Migadu-Flow: FLOW_OUT
Message-ID: <86ca92e5-fcbd-42b4-a322-219b0a8e517a@linux.dev>
Date: Wed, 26 Aug 2026 12:52:19 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v1 01/14] bpf: Split arena kfunc and struct_ops
 JIT capabilities
To: Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Emil Tsalapatis <emil@etsalapatis.com>, kkd@meta.com, kernel-team@meta.com
References: <20260821233516.3426127-1-memxor@gmail.com>
 <20260821233516.3426127-2-memxor@gmail.com>
 <f48031ff6aa8c6f2f7e98e4111912050dc9c3fd6.camel@gmail.com>
Content-Language: en-US
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <f48031ff6aa8c6f2f7e98e4111912050dc9c3fd6.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2026-08-24 3:28 p.m., Eduard Zingerman wrote:
> On Sat, 2026-08-22 at 01:34 +0200, Kumar Kartikeya Dwivedi wrote:
>> Arena pointer kfunc calls and struct_ops callbacks need different JIT
>> support. The former rebases BPF arena offsets before a kfunc call, while
>> the latter converts kernel pointers when an indirect trampoline builds a
>> callback context.
>>
>> A single bpf_jit_supports_arena_args() hook forces an architecture to
>> implement both paths at once. That ties bpf_arena_alloc_pages()
>> conversion to struct_ops trampoline support and prevents the paths from
>> being enabled and reviewed independently.
>>
>> Replace it with separate kfunc and struct_ops capability hooks. Make the
>> verifier query the hook for the path it is checking, and have x86-64 and
>> arm64 advertise both capabilities to preserve their current behavior.
>>
>> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
>> ---
> 
> I see no particular reason for this split.

+1

I don't think the split makes sense in general, independent of the
powerpc point.

The arch either supports the arena pointers everywhere, or the support
is incomplete, which IMO means it doesn't support them.

> Don't see any guards in the generic or powerpc related code preventing
> struct_ops programs from loading. Hence, I presume these are supported
> by the arch. Why excluding the arch, given that all changes are
> vibe-coded?

