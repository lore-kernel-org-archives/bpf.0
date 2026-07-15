Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5141023395E
	for <bpf@vger.kernel.org>; Wed, 15 Jul 2026 00:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784076272; cv=none; b=f6b70fraRKi+ivm7nYCoE/xpIYINKmIEWv1jhIFKdrwdxrfx+HpYjJgu81pb1k83tr01j7kduXLPc94tBzhuAvLrCj/q52m8uHsYlihL/ySrPhv0CWsYkq6baOoIcdK/vT4Q+7NcFE0s+BRPI6JPCIlxH8B6DnUw/9avrwJRV0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784076272; c=relaxed/simple;
	bh=hpnsyR/sA6tIfXfCtFg3ws54ItobXvYiytYkLbASTNQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aSq8zR6QhYkapzWdz8gf0teBayPUm7pALpChbQ8VtiCw9xE+AeiO8YjZ+YBa5NeQiQMDWwlvx4ilkYfrmCc9Slx/A8mFjXEKojEvLhELqYXJeyXazBtS4Wr1S7F5SEvqHaMqxBj6B9P8hIJ2SIcckUaxIduByZ2gecXiFvVg6yA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=PHt5ABjO; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="PHt5ABjO"
Message-ID: <d69e94e4-71e3-4bda-befb-9e76938e3359@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784076253;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uFdAyfIbyM3WhEUZwBwm08iMzmRJxX8iN9Ey9j8Kh9U=;
	b=PHt5ABjOFG8lpxcdjNUGydJbJEv4uw2Qralsdx208csok5oYn78BL4YBmjsDPI6vWsRSuE
	qTehHMoyug/FJAsT+flOEDQzjzcp12vGK0SZkS9NHUHVS+YsnTQrgXB2d2/xRGkxfA1zUF
	SCO9bkMpA5DmvxBowyXLlL6iLzLLH3Y=
Date: Tue, 14 Jul 2026 17:43:51 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v5 00/10] bpf: add support for KASAN checks in
 JITed programs
To: =?UTF-8?Q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?=
 <alexis.lothore@bootlin.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>,
 Thomas Gleixner <tglx@kernel.org>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>, Shuah Khan <shuah@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Andrey Konovalov <andreyknvl@gmail.com>
Cc: ebpf@linuxfoundation.org,
 Bastien Curutchet <bastien.curutchet@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20260709-kasan-v5-0-1c64af8e4e1e@bootlin.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <20260709-kasan-v5-0-1c64af8e4e1e@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 7/9/26 3:01 AM, Alexis LothorÃ© (eBPF Foundation) wrote:
> Hello,
> this is v5 of the series aiming to bring basic support for KASAN checks
> to BPF JITed programs.
> 
> [...]

Hi Alexis,

I started reviewing this revision today, but didn't get through
everything.  Sending a few comments in a bit, will continue tomorrow.

Thank you for working on it.

> 
> ---
> Alexis Lothoré (eBPF Foundation) (10):
>       bpf: propagate original instruction offset when patching program
>       bpf: mark instructions accessing program stack
>       bpf: add BPF_JIT_KASAN for KASAN instrumentation of JITed programs
>       bpf, x86: add helper to emit kasan checks in x86 JITed programs
>       bpf, x86: refactor BPF_ST management in do_jit
>       bpf, x86: emit KASAN checks into x86 JITed programs
>       bpf, x86: enable KASAN for JITed programs on x86
>       selftests/bpf: add helpers for KASAN in JIT testing
>       selftests/bpf: move bpf_jit_harden helper into testing_helpers
>       selftests/bpf: add tests to validate KASAN on JIT programs
> 
>  arch/x86/Kconfig                                   |   1 +
>  arch/x86/net/bpf_jit_comp.c                        | 271 ++++++++++---
>  include/linux/bpf_verifier.h                       |   2 +
>  include/linux/filter.h                             |  10 +-
>  kernel/bpf/Kconfig                                 |  17 +
>  kernel/bpf/core.c                                  |   2 +-
>  kernel/bpf/fixups.c                                | 132 +++++--
>  kernel/bpf/verifier.c                              |   9 +
>  .../selftests/bpf/prog_tests/bpf_insn_array.c      |  44 +--
>  tools/testing/selftests/bpf/prog_tests/kasan.c     | 430 +++++++++++++++++++++
>  tools/testing/selftests/bpf/progs/kasan.c          | 394 +++++++++++++++++++
>  tools/testing/selftests/bpf/progs/kasan_harden.c   |  41 ++
>  .../testing/selftests/bpf/test_kmods/bpf_testmod.c |  22 ++
>  tools/testing/selftests/bpf/testing_helpers.c      |  32 ++
>  tools/testing/selftests/bpf/testing_helpers.h      |   1 +
>  tools/testing/selftests/bpf/unpriv_helpers.c       |  10 +
>  tools/testing/selftests/bpf/unpriv_helpers.h       |   2 +
>  17 files changed, 1288 insertions(+), 132 deletions(-)
> ---
> base-commit: 950d646b505ae37ee75f4c2b11d41e7190036c42
> change-id: 20260126-kasan-fcd68f64cd7b
> 
> Best regards,
> --  
> Alexis Lothoré (eBPF Foundation) <alexis.lothore@bootlin.com>
> 

