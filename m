Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D978049EC78;
	Fri, 25 Sep 2026 14:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790347466; cv=none; b=pvMY8OqGl4Be4+sWtk4HHnaCUvEMFs7z/ch5ZG+Muk/+C1QiXP1ZuqHd1M2EOYnwvAkYtsY9Am/SFYQFNlpNPTcwwGkzsg4IB1xnCjpfKikQZ6YncIpTcFSZGPK5wJz6cxsynbUGLe7X1U4Nvw+enwQh0ODJI2E6B3DU/fB/uEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790347466; c=relaxed/simple;
	bh=wAlG2PZUQ7HMa/vYEBrX6a5yFv7nIWgMApGpO21G8JA=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=nLE5gsK92lzvjyHyatrHY5tOtIHBgv0Ywxzi9yXDOrVc85RwiXGCwVJmZsEdr7V/8xTkLYJ5ik/EHAdCo+jlqkkRP3bu4HekggqWijLjArKF3Bbsz3Abgj0IROs+cvrRGFTzeQx0ab4chk1JSFcsVbyhE5KatX8SyI/9uzIhv/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mYVf0ojW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mYVf0ojW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 889D61F000FF;
	Fri, 25 Sep 2026 14:44:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790347459;
	bh=c2ixQHgTlgBB99aXGpdz0JZkUKgNTS6JeLZqcHbd5j4=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=mYVf0ojW9fzJxUn9o8DEcdsQmNr+JhjF7+UtnyTJBIQdSsEDqQIMAJMXIacwX2+kU
	 dbnQqzkgga3PLMUpgVsh01VnAvRS2y7IZeERTT7ff8U6Dp/dtRajJEjCwh7DBNhHIt
	 amplWJ8PcuG/Ji9vWBCNcPVGOywCDWiertxSLmd6SBzRczNWoKq+NHqvCLs/2hj92Q
	 VJot9HsoU7FBBjpX++JKZZO7QB9FWZko5DfiZupn/eBZAq5RVVsSJjpxMKzWZpL3yX
	 pZQktm8Rw2wF7Ph9UmAm6IYmnFYxxs7jdsPf8nsW+iV+seb/hFEUCLMXX/RTbRj/rR
	 baezkCxO9AzdQ==
Content-Type: multipart/mixed; boundary="===============3453175654668812954=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <9dae67ce8cecd567b3ca1de28f497be5ecfae3b5b3d94520ae52eefa3662b42d@mail.kernel.org>
In-Reply-To: <20260925134828.2012199-3-puranjay@kernel.org>
References: <20260925134828.2012199-3-puranjay@kernel.org>
Subject: Re: [PATCH bpf-next v3 2/3] selftests/bpf: Test fetching AND/OR/XOR atomics in arena
From: bot+bpf-ci@kernel.org
To: puranjay@kernel.org,bpf@vger.kernel.org
Cc: puranjay@kernel.org,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,martin.lau@linux.dev,eddyz87@gmail.com,memxor@gmail.com,song@kernel.org,yonghong.song@linux.dev,tj@kernel.org,void@manifault.com,arighi@nvidia.com,changwoo@igalia.com,sched-ext@lists.linux.dev,linux-kernel@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Fri, 25 Sep 2026 14:44:17 +0000 (UTC)

--===============3453175654668812954==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/progs/arena_atomics.c b/tools/testing/selftests/bpf/progs/arena_atomics.c
> index 73bc2b835f3f..3beca5eab387 100644
> --- a/tools/testing/selftests/bpf/progs/arena_atomics.c
> +++ b/tools/testing/selftests/bpf/progs/arena_atomics.c

[ ... ]

> @@ -91,13 +91,22 @@ int sub(const void *ctx)
>  	return 0;
>  }
>
> -#ifdef __BPF_FEATURE_ATOMIC_MEM_ORDERING
> -_Atomic __u64 __arena_global and64_value = (0x110ull << 32);
> -_Atomic __u32 __arena_global and32_value = 0x110;
> -#else
> +/*
> + * Discarding the result of an atomic RMW is what selects the non-fetching
> + * insn, so keep one of each width per operation to cover that lowering too.
> + * Declared together rather than per operation to keep them in one place.
> + */
> +_Atomic __u64 __arena_global and64_noreturn_value = (0x110ull << 32);
> +_Atomic __u64 __arena_global or64_noreturn_value = (0x110ull << 32);
> +_Atomic __u64 __arena_global xor64_noreturn_value = (0x110ull << 32);
> +_Atomic __u32 __arena_global and32_noreturn_value = 0x110;
> +_Atomic __u32 __arena_global or32_noreturn_value = 0x110;
> +_Atomic __u32 __arena_global xor32_noreturn_value = 0x110;
> +
>  __u64 __arena_global and64_value = (0x110ull << 32);
> +__u64 __arena_global and64_result = 0;
>  __u32 __arena_global and32_value = 0x110;
> -#endif
> +__u32 __arena_global and32_result = 0;

Can this ordering still build on clang-17?

The file's existing clang-17 guard (lines 379-402) says clang-17 crashes
if the .addr_space.1 ELF section has holes, and works around this by
declaring variables as 64-bit. Before __BPF_FEATURE_ADDR_SPACE_CAST is
defined (clang 19+), __arena_global expands to SEC(".addr_space.1"), so
all of these globals go into that section.

Before this commit, the layout had no holes: add/sub (96 bytes), then
and32/and64/or32/or64/xor64/xor32 filled 96-132 continuously, then
cmpxchg32 x3 at 132-144 and cmpxchg64 at 144.

After this commit, the three _Atomic __u64 noreturn values fill 96-120
and the three _Atomic __u32 noreturn values fill 120-132. Then
and64_value needs 8-byte alignment, creating a 4-byte hole at 132-136.
The and/or/xor blocks (u64 value, u64 result, u32 value, u32 result) fill
136-208. cmpxchg32 x3 fill 208-220, then cmpxchg64_value needs 8-byte
alignment, creating a second 4-byte hole at 220-224.

clang-17's BPF backend pads these holes with code nops. BPF writeNopData
only handles multiples of 8, so the build fails with 'fatal error: error
in backend: unable to write nop sequence of 4 bytes'. This is the same
failure the x86_64-llvm-17 CI job hit when load-acquire tests were added
(see lore message Z6a_UILNqVGBqnvY@google.com; fixed only in LLVM
f27c4903c43b, clang 18+).

Could the __u32 globals be reordered to avoid these holes? For example,
moving xor32_noreturn_value from the grouped block to just after
xor32_result, next to the three cmpxchg32 values, would give runs of 2
and 6 u32 values instead of 3 + 3, eliminating both holes. Alternatively,
the existing clang-17 pattern (declaring them as 64-bit) could be used.

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/36144954909
--===============3453175654668812954==--
