Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0597C2C1788
	for <bpf@vger.kernel.org>; Mon, 29 Jun 2026 02:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782699300; cv=none; b=b+y6IkKsDhs2ZZoIScA1BMJSMGoi3s0OitdC4+34Jj6nulqSXQbnclTrLxkcfX5+8Ohhns+0QNdAXQ5no3YBbJ/U3kVOYqw23Nyc2tkxg98pmCmXDaWIsCPlLRSEyZ9yCi2xEpRnPiY1lm5jyt4aFeV/RtFnRDztce6W84sDB7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782699300; c=relaxed/simple;
	bh=B2fdBKpNv5OvbM0GIPeh4SNTUYsiUx7nFegm/cKV6VY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NHw3n15laIjboJMWWmo7PDY2vMa6MGNZd82IvmbV1ttdKziypQa/DejW2T8WR31X/fw/l2G2+GgmPjv3TKUGqk6R2H3Am2KZ9DUuBnjJAzzEiMTV2VPiq19A4BPDxz4LGLrpE0hqEZsY0el8plxQyKuoVEfcyeKbCp//WDZihAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=gQ5OZukC; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="gQ5OZukC"
Message-ID: <855e44f3-d22c-47e5-8bd1-c5d9f7014a75@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782699287;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SfciW9oe/6KsBQ9g2E0tczItMH1cFAvZbrBquHscbUE=;
	b=gQ5OZukCAeKLNPZ+YxRovUP3vQcQGlgOuVlKm6ikMGUjKgvPxKqErZ2CT1TMhx+BhJoD5n
	oKOniTn/Cm0SUOg1l2ySQYCkrKt8gMaR2Te6O81JgRL4g0N7dlDIY3zul/R531Ieq/U3I2
	JAaLn0QA5QD3MBgowIa0D86/21yIt7Q=
Date: Mon, 29 Jun 2026 10:14:28 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [RFC PATCH bpf-next 00/12] bpf: Introduce static-defined tracing
 probe for BPF
Content-Language: en-US
To: Xu Kuohai <xukuohai@huaweicloud.com>, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>,
 KP Singh <kpsingh@kernel.org>, Anton Protopopov <a.s.protopopov@gmail.com>,
 Amery Hung <ameryhung@gmail.com>, Eyal Birger <eyal.birger@gmail.com>,
 Rong Tao <rongtao@cestc.cn>
References: <cover.1782571533.git.xukuohai@huawei.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <cover.1782571533.git.xukuohai@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

Hi Kuohai,

On 28/6/26 06:51, Xu Kuohai wrote:
> From: Xu Kuohai <xukuohai@huawei.com>
> 
> This series introduces static-defined tracing probes for BPF programs.
> BPF SDT (static-defined tracing) works similarly to USDT. User defines


At first glance, the SDT idea looks cool to me.

However, what's your purpose of introducing SDT?

If to provide points in bpf progs to be traced, like tracepoints in
kernel functions, I think subprog+fentry is an alternative approach.
Comparing with SDT, subprog+fentry requires a function call at run time,
instead of a NOP like SDT.

For example,

#define __sink(expr) asm volatile("" : "+g"(expr))

static __noinline void my_trace(int len, int ret)
{
	__sink(len);
	__sink(ret);
}

SEC("xdp")
int xdp_prog(struct xdp_md *ctx)
{
	int len = ctx->data_end - ctx->data;
	int ret = XDP_DROP;
	...
	my_trace(len, ret);
	...
}

'my_trace' can be traced using fentry to inspect the details of 'xdp_prog'.

Furthermore, if users don't want a function call at run time, e.g. they
don't want to call 'my_trace' at run time in production, they can patch
the callsite of 'my_trace' with NOP before loading 'xdp_prog', and drop
the subprog 'my_trace' in their user space application. This elimination
is approachable, since it is used heavily in bpfsnoop [1]. However, this
elimination is not easy to understand. Want me to show more details
about this elimination?

Link:
[1] https://github.com/bpfsnoop/bpfsnoop

Thanks,
Leon

> probes in the BPF source code. The probes are built into NOP instructions
> in the ELF. At runtime, when an observer is attached, the NOP instruction
> is patched to a CALL instruction to the observer prog trampoline.
> 
> Unlike USDT, BPF SDT requires explicit macros to generate the function
> prototype BTF for each probe. This allows the verifier to validate the
> probe sites against the declared types, and observer programs can be
> attached similarly to normal tracing programs using the function prototype
> information.
> 
> A probe with two arguments in the target program can be declared and defined
> like:
> 
>     BPF_SDT_DECLARE2(my_trace, int, int);
> 
>     SEC("xdp")
>     int xdp_prog(struct xdp_md *ctx)
>     {
>         int len = ctx->data_end - ctx->data;
>         int ret = XDP_DROP;
>         ...
>         BPF_SDT_PROBE2(my_trace, len, ret);
>         ...
>     }
> 
> An observer would be like:
> 
>     SEC("bpf_sdt")
>     int BPF_PROG(observer_prog, int len, int ret)
>     {
>         bpf_printk("len=%d ret=%d\n", len, ret);
>         return 0;
>     }
> 
> The target program and probe site for the observer program should be set
> at load time via bpf_program__set_attach_target() manually, since program
> names are not unique and program IDs are allocated at runtime - there is
> no static way to identify the target program.
> 
> For BPF_SDT_DECLARE2(my_trace, int, int) and BPF_SDT_PROBE2(my_trace, len, ret)
> macros, the compiler produces:
> 
>   [code section, e.g. xdp]
>       goto +0                  // NOP, patched to CALL at attach time
> 
>   [.bpf_sdt_notes section]
>       ___sdt_jt_my_trace:      // symbol marking this entry's boundary
>       .quad  0b                // 8 bytes: offset of the NOP in the code
>                                // section (resolved by the linker via
>                                // R_BPF_64_ABS64 relocation)
>       r1 = %[arg1_reg]         // 8 bytes per argument: BPF move insn
>                                // whose src_reg field encodes the BPF
>                                // register holding each probe argument
>       r2 = %[arg2_reg]
> 
>       ....
> 
>   [.BTF section]
>       FUNC_PROTO (int, int) -> void   // from BPF_SDT_DECLARE2 stub
>       DECL_TAG "bpf_sdt:my_trace:2"   // keyed by name + nargs
> 
> The .BTF and .bpf_sdt_notes sections are parsed by libbpf and ultimately
> converted to an insn_array map per bpf program. Each map slot records the
> instruction offset, jited address, FUNC_PROTO BTF ID, and argument register
> for each probe site.
> 
> When an observer prog is loaded, the probe is resolved against the target
> program's SDT map using the target fd and probe name passed by the user.
> 
> For attach, the existing bpf trampoline is reused with per-argument register
> mappings declared by the SDT macro.
> 
> Xu Kuohai (12):
>   libbpf: Prepare bpf SDT probe section for the linker
>   libbpf: Introduce bpf SDT probe macros
>   libbpf: Add bpf_sdt_notes section parser
>   bpf: Create insn_array map for bpf SDT probe
>   bpf: Collect SDT probe BTF IDs from BTF decl tags
>   bpf: Add type check for SDT probe site
>   bpf: Record probe name in SDT map
>   libbpf: Add libbpf support to load SDT observer program
>   bpf: Add kernel support to load SDT observer program
>   bpf: Support attach and detach for SDT observer program
>   bpf, x86: Add JIT support SDT for probe
>   selftests/bpf: Add tests for bpf SDT probe
> 
>  arch/x86/net/bpf_jit_comp.c                   |  38 +-
>  include/linux/bpf.h                           |  26 +-
>  include/linux/bpf_types.h                     |   1 +
>  include/linux/bpf_verifier.h                  |   3 +
>  include/linux/filter.h                        |   1 +
>  include/uapi/linux/bpf.h                      |  21 +-
>  kernel/bpf/bpf_insn_array.c                   |  64 ++-
>  kernel/bpf/cfg.c                              |   3 +
>  kernel/bpf/core.c                             |   5 +
>  kernel/bpf/fixups.c                           |   4 +
>  kernel/bpf/liveness.c                         |  24 +-
>  kernel/bpf/syscall.c                          | 163 +++++-
>  kernel/bpf/trampoline.c                       |   4 +
>  kernel/bpf/verifier.c                         | 174 +++++-
>  tools/include/uapi/linux/bpf.h                |  21 +-
>  tools/lib/bpf/Makefile                        |   2 +-
>  tools/lib/bpf/bpf.c                           |  10 +-
>  tools/lib/bpf/bpf.h                           |   9 +-
>  tools/lib/bpf/bpf_sdt.h                       | 346 ++++++++++++
>  tools/lib/bpf/libbpf.c                        | 513 +++++++++++++++++-
>  tools/lib/bpf/libbpf_internal.h               |   1 +
>  tools/lib/bpf/linker.c                        |   9 +
>  .../selftests/bpf/prog_tests/test_bpf_sdt.c   | 151 ++++++
>  .../selftests/bpf/progs/bpf_sdt_observer.c    |  30 +
>  .../selftests/bpf/progs/bpf_sdt_target.c      |  34 ++
>  25 files changed, 1622 insertions(+), 35 deletions(-)
>  create mode 100644 tools/lib/bpf/bpf_sdt.h
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/test_bpf_sdt.c
>  create mode 100644 tools/testing/selftests/bpf/progs/bpf_sdt_observer.c
>  create mode 100644 tools/testing/selftests/bpf/progs/bpf_sdt_target.c
> 

