Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF40B3FC5D0
	for <bpf@vger.kernel.org>; Fri, 26 Jun 2026 16:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782490333; cv=none; b=WuZUxNj8UpUR4GBnhgZI4EYIC689ZlkRzQIPqSAwB1Y1XiUNmhINm/Rqo+59rJpYjhjzLCIA78A2Ej+bWEOeN3UGMR21RBHNMp1udPaZq1AS0D/UbOc4OJFys9zmKVj2UFMr9k2ktEaOGwID6FlWCFgTGNykGAnMYhh5zUPbQmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782490333; c=relaxed/simple;
	bh=Y4PMxRV/lSffT3HteTkkcI7dwsGpAYaiiTFTge2HJcU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bTvIyx98c263ynw/KY+zEqV803igxYk+kFeyPJqp1yj9wFb6XJRavIQ7S7l8w4MCiqL1Oo3rteweHvAi9mDeflCfUEMz9HdPZ4J0dZZxiGj/O2CVyRueNIZ5VSbLYDww7lZYYEGoGWWboRiMasq4nN3Iqg5TuG4zwH0hWNMc1cQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=NJaZx8IT; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="NJaZx8IT"
Message-ID: <79ca7f6b-5cd5-4c23-8ea9-7867d44046c5@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782490317;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VnzhTF71ierMPfAYewjD1O5YXJU+qgQcRlmaI9+cY1c=;
	b=NJaZx8IT0tfR3yCLcKFKnwlQ+EMMRQTPNZk//KfGyevK34pjAkit2jcpxe+lhiNknqDHT7
	HqL+/bfB7oYkFzh+ke4082Iz+rLgf+sxV/QVu8LRBHnQ4fYWJDY3PDjqB1DFPjIxuVqNkM
	xaJ/A3ywa4N4jnrhX9UkzRTRglYQ5TE=
Date: Sat, 27 Jun 2026 00:11:45 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [RFC PATCH bpf 0/6] bpf: Disallow interpreter fallback for
 interpreter-unsupported insns
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>,
 Emil Tsalapatis <emil@etsalapatis.com>,
 Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>,
 Puranjay Mohan <puranjay@kernel.org>,
 Anton Protopopov <a.s.protopopov@gmail.com>, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <20260626154330.33619-1-leon.hwang@linux.dev>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <20260626154330.33619-1-leon.hwang@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2026/6/26 23:43, Leon Hwang wrote:
> Sashiko reported two potential issues about interpreter fallback [1]
> [2].
> 
> After verifying them by patch #7, I think they are real issues. With

Sorry, it should be the patch #6.

> LLM assistance, the interpreter does not support the internal
> BPF_PROBE_ATOMIC insn and the gotox insn (used for indirect jumps),
> either.
> 
> 1) the user BPF_ADDR_SPACE_CAST insn
>    the interpreter just ignores it.
> 
> 2) the arena ST/STX/LDX insn
>    the interpreter could hit the BUG_ON() in ___bpf_prog_run().
> 
> 3) the BPF_MOV64_PERCPU_REG insn
>    the interpreter could hit page fault, due to loading memory from
>    invalid __percpu pointer.
> 
> 4) the internal BPF_PROBE_ATOMIC insn
>    the interpreter could hit the BUG_ON() in ___bpf_prog_run().
> 
> 5) the gotox insn used for indirect jumps
>    the interpreter could hit the BUG_ON() in ___bpf_prog_run(), too.
> 
> Reject these insns on interpreter fallback path in
> __bpf_prog_select_runtime().
> 
> This series is built on
> "bpf: Fix unaligned interpreter panic on JIT fallback path" [3]. The
> patch #7 is also able to verify the issue of un-JITed helper.
^ patch #6
> 
> However, The patch #7 aims to verify the issues. I think it is not
             ^ patch #6

> proper to be applied to upstream, because it adds a stub
> 'bpf_jit_test_fail_task' to bpf_prog_jit_compile() for the tests.
> 
> I'd like to drop the patch #7 in the next revision.
                      ^ patch #6

Thanks,
Leon

> 
> Link:
> [1] https://lore.kernel.org/bpf/20260608151347.2C77D1F00893@smtp.kernel.org/
> [2] https://lore.kernel.org/bpf/20260622150759.EC9071F000E9@smtp.kernel.org/
> [3] https://lore.kernel.org/bpf/20260615025316.24429-1-yangtiezhu@loongson.cn/
> 
> Leon Hwang (6):
>   bpf: Disallow interpreter fallback for user BPF_ADDR_SPACE_CAST insn
>   bpf: Disallow interpreter fallback for arena insn
>   bpf: Disallow interpreter fallback for BPF_MOV64_PERCPU_REG insn
>   bpf: Disallow interpreter fallback for internal BPF_PROBE_ATOMIC insn
>   bpf: Disallow interpreter fallback for gotox insn
>   lib/test_bpf: Add interpreter-fallback tests
> 
>  include/linux/bpf.h                      |   1 +
>  include/linux/filter.h                   |   4 +
>  kernel/bpf/core.c                        |  69 +-
>  lib/test_bpf.c                           | 800 ++++++++++++++++++++++-
>  tools/lib/bpf/skel_internal.h            |   2 +
>  tools/testing/selftests/bpf/test_kmod.sh |  39 +-
>  6 files changed, 903 insertions(+), 12 deletions(-)
> 
> --
> 2.54.0

