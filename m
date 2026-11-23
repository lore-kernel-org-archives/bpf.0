Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=113.46.200.219
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795420036;
	b=hduAFfuBPWvztsiabPQtDEpcMNkGtnyYDOKf7UOh0O5jo/LiF40w9YPMmZ/GH/e9RgfB
	 TAL9/E4c0adYn/kraOBaZRXqRvpFwq4fVTSkuXfITL+HpweXe5N9DwgEUbw5QFh4XZ4B8
	 caXfhtXV07rUy6JkEI2jrXZY1kOs0UUieHw9hckkMHLDVtbMh2/ZzV0KNJhT/LCynXjpE
	 qcuBCKhEIMTi+H2Nypd2If6FLyltIL3B+yGWshua3nrUhUwrGsNRz8heIm8JWUa6KCHL6
	 4lTiF2VpRjvM+rxbQcmeVIIBM27V9n1GQWeCqqAGQWugBrM9iekFsWaGCWTyU7PM66Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795420036;
	h=DMARC-Filter:dkim-signature:Received:Received:Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:CC:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Originating-IP:X-ClientProxiedBy;
	bh=Dr1iKVrv9/eBqSO8/xSdTONwVVAExyf79+TG9olwstM=;
	b=jW+6GHPOE/i7MzIkzHsFAEct3GZLjMj2Ux5SNYPrv+IIeumTfqcXOIeJGLsew0bLMxpX
	 PhWThlHOyHhoANsbK0jtYJS6JxCmOmfiIiggM2yNm6PIUMB0xd0H1gOGV41DHxEbU6D/k
	 pBvGg67PiLjMEi5I9a0ih739h6Vl9aRa7G4Atr7m5q4V2xT2D8L3G5Kcv7MQWX3+UcCTK
	 0sSKIrF/027ZO63vIVx+7gAbrTpBN+g36tdXS+YN30HsRxF5eUZMGHIeCi1J91HOIXeE3
	 YX+1pmaX7BRVBjM4OWySPRc5rRcoq6xNr9Rrfu2FWUAk+L1xzTFexIXt6ZfuIbDXuGg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=huawei.com;
	spf=pass smtp.mailfrom=huawei.com;
	dkim=pass header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=OdeLPQi7;
	arc=none smtp.remote-ip=113.46.200.219
Received: from canpmsgout04.his.huawei.com (canpmsgout04.his.huawei.com [113.46.200.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5B08606A31A;
	Mon, 23 Nov 2026 07:47:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A5B08606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=OdeLPQi7
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=Dr1iKVrv9/eBqSO8/xSdTONwVVAExyf79+TG9olwstM=;
	b=OdeLPQi7av4eFetgOW7gmJ2uA8HEKWdiGvd9Q4UyaU+RgjE8O6Bn7GlEaKy3v/fPucetd+0hJ
	xx1KNV9uQthppb7212n3GNLBh4tWNY4LyDh84y6zB5CESKbopZMJRW7VTvtuEZ6HAl3YJ5k9FTk
	zF113MK7P+qTA3m3BS6qRUY=
Received: from mail.maildlp.com (unknown [172.19.162.144])
	by canpmsgout04.his.huawei.com (SkyGuard) with ESMTPS id 4jXyh04vw2z1prKb;
	Mon, 23 Nov 2026 15:46:56 +0800 (CST)
Received: from dggpemr200003.china.huawei.com (unknown [7.185.36.25])
	by mail.maildlp.com (Postfix) with ESMTPS id 817C34056D;
	Mon, 23 Nov 2026 15:47:12 +0800 (CST)
Received: from whupemq100006.china.huawei.com (7.152.184.206) by
 dggpemr200003.china.huawei.com (7.185.36.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 23 Nov 2026 15:47:12 +0800
Received: from [10.67.110.154] (10.67.110.154) by
 whupemq100006.china.huawei.com (7.152.184.206) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Mon, 23 Nov 2026 15:47:10 +0800
Message-ID: <6f594d21-f5c5-4224-b4ff-04ba3183a414@huawei.com>
Date: Mon, 23 Nov 2026 15:46:56 +0800
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 bpf-next 0/3] riscv: bpf: Add BPF private stack support
To: <ast@kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>
CC: Chen Pei <cp0613@linux.alibaba.com>, <memxor@gmail.com>,
	<bjorn@kernel.org>, <puranjay@kernel.org>, <alexei.starovoitov@gmail.com>,
	<eddyz87@gmail.com>, <martin.lau@linux.dev>, <song@kernel.org>,
	<yonghong.song@linux.dev>, <jolsa@kernel.org>, <emil@etsalapatis.com>,
	<ihor.solodrai@linux.dev>, <pjw@kernel.org>, <palmer@dabbelt.com>,
	<aou@eecs.berkeley.edu>, <alex@ghiti.fr>, <luke.r.nels@gmail.com>,
	<xi.wang@gmail.com>, <shuah@kernel.org>, <rgbi3307@gmail.com>,
	<guoren@kernel.org>, <bpf@vger.kernel.org>,
	<linux-riscv@lists.infradead.org>, <linux-kselftest@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <20261106181558.1564-1-cp0613@linux.alibaba.com>
Content-Language: en-US
From: Pu Lehui <pulehui@huawei.com>
In-Reply-To: <20261106181558.1564-1-cp0613@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 whupemq100006.china.huawei.com (7.152.184.206)

Hi Alexei, Daniel, Andrii,

Gentle ping on this series -- it looks good to me and bpf selftests pass 
on RV64. Some upcoming patches will conflict with these changes, so it 
would be helpful to get this applied first.

Thanks,
Lehui

On 2026/11/7 2:15, Chen Pei wrote:
> This series adds private-stack support to the RV64 BPF JIT.
> 
> The verifier rejects a struct_ops program that requests a private stack
> with -EACCES when the JIT does not report
> bpf_jit_supports_private_stack(), and sched_ext requests one for its
> dispatch callback, so no sched_ext scheduler can load on riscv64 today.
> 
> Allocation, the guard value and the lifetime handling follow arm64,
> x86-64 and powerpc64; the 16 byte two-copy guard layout follows arm64
> and powerpc64, since x86-64 uses an 8 byte guard with a single copy.
> What is specific to riscv64 is where the pointers end up:
> 
>   - Every BPF stack access goes through BPF_REG_FP (S5), so pointing S5
>     at the top of the per-CPU area and leaving SP on the kernel stack is
>     all the JIT has to do. S5 is callee-saved and each subprog derives
>     its own, so bpf2bpf calls need no extra save and restore.
>   - The outgoing stack argument area stays in the kernel frame: callers
>     write it relative to SP while callees read it relative to RV_REG_FP.
>     Unlike x86-64, no register here is shared with the private-stack
>     frame pointer, so no verifier-side exclusion is needed and stack
>     arguments keep working together with a private stack. arm64 already
>     does the same, and patch 3 tests that combination.
>   - The per-CPU lookup is emitted after the tail call entry point. A
>     program using a private stack can still be entered as a tail call
>     target, at RV_TAILCALL_OFFSET, so it has to set up its own S5 there;
>     and since that offset is a constant added to the target's bpf_func,
>     everything in front of it must be the same size in every program.
> 
> The base address is materialized with absolute moves, as on arm64,
> x86-64 and powerpc64, which reach the per-CPU offset through gs:, TPIDR
> or r13; riscv64 has no such register, so the address of __per_cpu_offset
> is loaded too. Patch 1 has the detail, including why emit_imm() is a
> choice there and why the prologue length stays fixed across passes.
> 
> RV32 does not declare support and keeps the existing behaviour; the
> prologue signature is unchanged, so bpf_jit_comp32.c needs no edit.
> 
> Changes since v2:
>   - Patch 1: PRIV_STACK_GUARD_VAL moved to bpf_jit.h.
>   - Patch 3: The test redone as two asm programs in
>     progs/verifier_stack_arg.c.
> 
> Changes since v1:
>   - Patch 1 commit message: guard layout credited to arm64 and powerpc64,
>     value alone to x86-64; __per_cpu_offset described as a choice.
>   - Patch 3: test_private_stack_runtime() renamed to
>     serial_test_private_stack_runtime(), and the stack argument skip
>     prints a reason.
> 
> Testing
> =======
> QEMU virt rv64, an 8 vCPU SMP kernel and a 1 vCPU UP kernel, both built
> on the base commit below, source tree clean at the head of this series,
> selftests built from these patches. There are no private-stack related
> failures, and the private-stack suites logged no BUG, WARNING, unknown
> opcode or guard corruption. On UP, kfunc_call/subprog,
> kfunc_call/subprog_lskel and scx_simple are not run: all three fail on
> the unpatched base as well.
> 
>   - verifier_private_stack, struct_ops_private_stack.
>   - tailcalls, stack_arg, subprogs, fentry_fexit, kfunc_call,
>     percpu_alloc, async_stack_depth, arena_atomics, arena_ldsx.
>   - verifier_stack_arg, stack_arg_precision.
>   - may_goto_priv_stack, may_goto_far, verifier_may_goto_1,
>     verifier_may_goto_2.
>   - scx_simple.
>   - sched_ext runner sweep on SMP: 40 cases, 39 pass. enable_cmask fails
>     because its ops.enable() takes a struct scx_cmask __arena pointer and
>     riscv64 does not implement bpf_jit_supports_arena_args().
>   - patch 3's test again on x86-64 and arm64, so all three
>     architectures it is gated on have run it.
> 
> Chen Pei (3):
>    riscv: bpf: Add BPF private stack support
>    selftests/bpf: Enable private stack tests for riscv64
>    selftests/bpf: Test a private stack together with stack arguments
> 
>   arch/riscv/net/bpf_jit.h                      |  2 +
>   arch/riscv/net/bpf_jit_comp64.c               | 42 +++++++++-
>   arch/riscv/net/bpf_jit_core.c                 | 82 +++++++++++++++++--
>   .../bpf/prog_tests/struct_ops_private_stack.c |  3 +-
>   .../bpf/progs/verifier_private_stack.c        | 41 +++++++++-
>   .../selftests/bpf/progs/verifier_stack_arg.c  | 49 +++++++++++
>   6 files changed, 205 insertions(+), 14 deletions(-)
> 
> 
> base-commit: a3c8813409f13779fec225468aba7d4067a66468
