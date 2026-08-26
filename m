Received: from mta1.migadu.com (out-42.mta1.migadu.com [95.215.58.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40FF43A8FEA
	for <bpf@vger.kernel.org>; Wed, 26 Aug 2026 20:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787777417; cv=none; b=sulLiUnTNPhqybND7M3kw6mBlsjfFhDeuOkIFwPvenPFAAVjv07DozeKURTnkq4Qw2T6zdgU+UQjSUgIogOReYRVwpFZ5Qm8IP0sPaLa1eouWn9bU03f2fpOj5yXs1C33DQiL8erGALwcRIoj25G9t2CF5knsAe7M/Jx7bFvupM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787777417; c=relaxed/simple;
	bh=NuHQ37y7CzWAQweYdjmqnkNoKGELF4DP89ytcjs/cvg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Hk9xHcOacS5bm/Tm+r/aXYB88jZw1FLnK7ZyvX8eFMlynMZmYCl4LjnB0/25FmLdDPkGxWzJ7qO2vkwl6ruWd8E357f0ubN3hrS+oNAEyFUbeIhoPzKbBvJB22dj4VF4rQfPJKcMVsAInRwC7PmP5WpgTeUceokc7YDwONWWpIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=f4fT0Btx; arc=none smtp.client-ip=95.215.58.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="f4fT0Btx"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=NuHQ37y7CzWAQweYdjmqnkNoKGELF4DP89ytcjs/cvg=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787777414; v=1; x=1788382214;
 b=f4fT0BtxeRdJOMYohbVZcB5Z9fnrdjIYUXbo0IBLmwDY9BhJv/3zIBbhSAAER3AFp0bFxg4D
 bilxVsNJ4lMqxatTZY1mdS+rdTbfGqaekgw+DtKxrkbjiHPvYulyjPco1KeOOYO6e6sSy17elq5
 sn+P4XEeyFHkbvW9FKx//HbQ=
X-Envelope-To: bpf@vger.kernel.org
Received: from [IPV6:2620:10d:c085:21c1::1576] (2620:10d:c090:400::5:7641)
	by smtp.migadu.com with ESMTPS id 59d66917ee13c9d0;
	Wed, 26 Aug 2026 20:50:06 +0000
X-Mizu-Trace-ID: 59d66917ee13c9d0
X-Migadu-Flow: FLOW_OUT
Message-ID: <d293e07d-4039-4c25-8dec-6da22906a6df@linux.dev>
Date: Wed, 26 Aug 2026 13:50:03 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v1 13/14] selftests/bpf: Exercise arena arguments
 on every capable JIT
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Eduard Zingerman
 <eddyz87@gmail.com>, Emil Tsalapatis <emil@etsalapatis.com>, kkd@meta.com,
 kernel-team@meta.com
References: <20260821233516.3426127-1-memxor@gmail.com>
 <20260821233516.3426127-14-memxor@gmail.com>
Content-Language: en-US
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <20260821233516.3426127-14-memxor@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2026-08-21 4:35 p.m., Kumar Kartikeya Dwivedi wrote:
> The arena kfunc runtime tests are restricted to x86-64 and arm64, so new
> JIT implementations can compile without exercising rebasing, nullable
> arguments, five-register calls, or the verifier capability gate.
> 
> Run those tests on RISC-V, s390, LoongArch, and PowerPC64 as well. Teach
> test_loader about PowerPC64 so it can select the newly annotated programs.
> 
> Enable the struct_ops arena tests on RISC-V, s390, and LoongArch, whose
> indirect trampolines now implement the separate reverse-conversion path.
> PowerPC64 remains covered only for kfunc arguments because it does not
> advertise the struct_ops capability.

I'd avoid adding these unless you actually ran it.

Have you tried non-x86 / arm64 arches at least in emulation?

> 
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---
>   .../bpf/prog_tests/test_struct_ops_arena.c    | 16 ++++++---
>   .../testing/selftests/bpf/progs/arena_kfunc.c | 36 +++++++++++++++++++
>   tools/testing/selftests/bpf/progs/bpf_misc.h  |  1 +
>   tools/testing/selftests/bpf/test_loader.c     |  5 +++
>   4 files changed, 53 insertions(+), 5 deletions(-)
> 
> [...]
