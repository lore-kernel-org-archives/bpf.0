Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB784357A5E
	for <bpf@vger.kernel.org>; Wed, 25 Mar 2026 06:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774420999; cv=none; b=K36fjFnfiFI2ftCelyzKPWR2iPIaNK2beZ7jAowN4CjEUjKuksNQhNewRXPQ6+Ldx9Ky7Zq9+6I1RB5ykgLUBMRpm3fCvtG9N3Wkil+/1uOidLkZ28kfuXjrjtyf1Dq3ju1oS0j7vfVKQp5zyNzNae+C0IdPBYNJAzJ8tZyrq0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774420999; c=relaxed/simple;
	bh=kXCnTUPiZ76Pr6br+3xdycz0aylQB46KluiGoXWnetA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pQkM3cr7LZStzv8eh6UacUA/f4IRRXY2rPIc/Qh5tMtFs+91cIpyOQBJbRMnMHtdJ0ticdEmbynBmyqgk4VdcuS024qhNFNTqcoX66tUmsgmOMj4bVSyaxDcRUULRiKR9CcBQUsEvyjdXzr36czYXJPoHN5JcGexA+1gC2U68b8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=pRRTRCVm; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="pRRTRCVm"
Message-ID: <7fc7e5ad-ac42-4c7d-8314-bd252f8887a3@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1774420985;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FTRvwnnL2JK/rHXewDsU4LoXcxKSHbZn+fjrGgdfIqg=;
	b=pRRTRCVmdvkSgW40ajBSFzSKbma4ObaYbqJc8vYKK7IxF0ozOnzrCc5PXFbV9IswvuOkBu
	9wwY03Q5ao7TDEl1Bms2gouUll/ZWago6FrRozkCKNMzOmK5DyXlGyx9aof07OpDNR38dr
	qvvCSeKswBFpECGBkZAsXntlOfKtksc=
Date: Wed, 25 Mar 2026 14:42:48 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCHv4 bpf-next 00/25] bpf: tracing_multi link
Content-Language: en-US
To: Jiri Olsa <jolsa@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>
Cc: Hengqi Chen <hengqi.chen@gmail.com>, bpf@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>,
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <songliubraving@fb.com>,
 Yonghong Song <yhs@fb.com>, Menglong Dong <menglong8.dong@gmail.com>,
 Steven Rostedt <rostedt@kernel.org>
References: <20260324081846.2334094-1-jolsa@kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <20260324081846.2334094-1-jolsa@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

Hi Jiri,

Nice version for tracing_multi link.

I hope I have time to add tracing_multi link support to bpfsnoop, and
test this new tracing feature.

I left comments on patches #13, #24, and #25.

Hope this series lands in bpf-next soon.

Thanks,
Leon

On 24/3/26 16:18, Jiri Olsa wrote:
> hi,
> adding tracing_multi link support that allows fast attachment
> of tracing program to many functions.
> 
> RFC: https://lore.kernel.org/bpf/20260203093819.2105105-1-jolsa@kernel.org/
> v1: https://lore.kernel.org/bpf/20260220100649.628307-1-jolsa@kernel.org/
> v2: https://lore.kernel.org/bpf/20260304222141.497203-1-jolsa@kernel.org/
> v3: https://lore.kernel.org/bpf/20260316075138.465430-1-jolsa@kernel.org/
> 
> v4 changes:
> - unlink rollback fix (added ftrace_hash_count) [bot]
> - use const for some bpf_link_create_opts tracing_multi members [bot]
> - adding missing comment for lockdep keys [bot]
> - selftest error path fixes (leaks) and other assorted test fixes [Leon Hwang]
> - several compile fixes wrt CONFIG_BPF_SYSCALL and CONFIG_BPF_JIT [kernel test robot]
> - make ftrace_hash_clear global, because it's needed in rollback
> 
> v3 changes:
> - fix module parsing [Leon Hwang]
> - use function traceable check from libbpf [Leon Hwang]
> - use ptr_to_u64 and fix/updated few comments [ci]
> - display cookies as decimal numbers [ci]
> - added link_create.flags check [ci]
> - fix error path in bpf_trampoline_multi_detach [ci]
> - make fentry/fexit.multi not extendable [ci]
> - add missing OPTS_VALID to bpf_program__attach_tracing_multi [ci]
> 
> v2 changes:
> - allocate data.unreg in bpf_trampoline_multi_attach for rollback path [ci]
>   and fixed link count setup in rollback path [ci]
> - several small assorted fixes [ci]
> - added loongarch and powerpc changes for struct bpf_tramp_node change
> - added support to attach functions from modules
> - added tests for sleepable programs
> - added rollback tests
> 
> v1 changes:
> - added ftrace_hash_count as wrapper for hash_count [Steven]
> - added trampoline mutex pool [Andrii]
> - reworked 'struct bpf_tramp_node' separatoin [Andrii]
>   - the 'struct bpf_tramp_node' now holds pointer to bpf_link,
>     which is similar to what we do for uprobe_multi;
>     I understand it's not a fundamental change compared to previous
>     version which used bpf_prog pointer instead, but I don't see better
>     way of doing this.. I'm happy to discuss this further if there's
>     better idea
> - reworked 'struct bpf_fsession_link' based on bpf_tramp_node
> - made btf__find_by_glob_kind function internal helper [Andrii]
> - many small assorted fixes [Andrii,CI]
> - added session support [Leon Hwang]
> - added cookies support
> - added more tests
> 
> 
> Note I plan to send linkinfo support separately, the patchset is big enough.
> 
> thanks,
> jirka
> 
> 
> Cc: Hengqi Chen <hengqi.chen@gmail.com>
> ---
> Jiri Olsa (25):
>       ftrace: Add ftrace_hash_count function
>       ftrace: Make ftrace_hash_clear global
>       bpf: Use mutex lock pool for bpf trampolines
>       bpf: Add struct bpf_trampoline_ops object
>       bpf: Add struct bpf_tramp_node object
>       bpf: Factor fsession link to use struct bpf_tramp_node
>       bpf: Add multi tracing attach types
>       bpf: Move sleepable verification code to btf_id_allow_sleepable
>       bpf: Add bpf_trampoline_multi_attach/detach functions
>       bpf: Add support for tracing multi link
>       bpf: Add support for tracing_multi link cookies
>       bpf: Add support for tracing_multi link session
>       bpf: Add support for tracing_multi link fdinfo
>       libbpf: Add bpf_object_cleanup_btf function
>       libbpf: Add bpf_link_create support for tracing_multi link
>       libbpf: Add btf_type_is_traceable_func function
>       libbpf: Add support to create tracing multi link
>       selftests/bpf: Add tracing multi skel/pattern/ids attach tests
>       selftests/bpf: Add tracing multi skel/pattern/ids module attach tests
>       selftests/bpf: Add tracing multi intersect tests
>       selftests/bpf: Add tracing multi cookies test
>       selftests/bpf: Add tracing multi session test
>       selftests/bpf: Add tracing multi attach fails test
>       selftests/bpf: Add tracing multi attach benchmark test
>       selftests/bpf: Add tracing multi attach rollback tests
> 
>  arch/arm64/net/bpf_jit_comp.c                                      |  58 +++---
>  arch/loongarch/net/bpf_jit.c                                       |  44 ++---
>  arch/powerpc/net/bpf_jit_comp.c                                    |  46 ++---
>  arch/riscv/net/bpf_jit_comp64.c                                    |  52 ++---
>  arch/s390/net/bpf_jit_comp.c                                       |  44 ++---
>  arch/x86/net/bpf_jit_comp.c                                        |  54 ++---
>  include/linux/bpf.h                                                | 102 +++++++---
>  include/linux/bpf_types.h                                          |   1 +
>  include/linux/bpf_verifier.h                                       |   3 +
>  include/linux/btf_ids.h                                            |   1 +
>  include/linux/ftrace.h                                             |   2 +
>  include/linux/trace_events.h                                       |   6 +
>  include/uapi/linux/bpf.h                                           |   9 +
>  kernel/bpf/bpf_struct_ops.c                                        |  27 +--
>  kernel/bpf/btf.c                                                   |   4 +
>  kernel/bpf/syscall.c                                               |  88 ++++++---
>  kernel/bpf/trampoline.c                                            | 536 ++++++++++++++++++++++++++++++++++++++++---------
>  kernel/bpf/verifier.c                                              | 124 +++++++++---
>  kernel/trace/bpf_trace.c                                           | 149 +++++++++++++-
>  kernel/trace/ftrace.c                                              |   9 +-
>  net/bpf/bpf_dummy_struct_ops.c                                     |  14 +-
>  net/bpf/test_run.c                                                 |   3 +
>  tools/include/uapi/linux/bpf.h                                     |  10 +
>  tools/lib/bpf/bpf.c                                                |   9 +
>  tools/lib/bpf/bpf.h                                                |   5 +
>  tools/lib/bpf/libbpf.c                                             | 337 ++++++++++++++++++++++++++++++-
>  tools/lib/bpf/libbpf.h                                             |  15 ++
>  tools/lib/bpf/libbpf.map                                           |   1 +
>  tools/lib/bpf/libbpf_internal.h                                    |   1 +
>  tools/testing/selftests/bpf/Makefile                               |   9 +-
>  tools/testing/selftests/bpf/prog_tests/tracing_multi.c             | 912 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  tools/testing/selftests/bpf/progs/tracing_multi_attach.c           |  39 ++++
>  tools/testing/selftests/bpf/progs/tracing_multi_attach_module.c    |  25 +++
>  tools/testing/selftests/bpf/progs/tracing_multi_bench.c            |  12 ++
>  tools/testing/selftests/bpf/progs/tracing_multi_check.c            | 212 ++++++++++++++++++++
>  tools/testing/selftests/bpf/progs/tracing_multi_fail.c             |  18 ++
>  tools/testing/selftests/bpf/progs/tracing_multi_intersect_attach.c |  41 ++++
>  tools/testing/selftests/bpf/progs/tracing_multi_rollback.c         |  43 ++++
>  tools/testing/selftests/bpf/progs/tracing_multi_session_attach.c   |  43 ++++
>  tools/testing/selftests/bpf/trace_helpers.c                        |   6 +-
>  tools/testing/selftests/bpf/trace_helpers.h                        |   1 +
>  41 files changed, 2749 insertions(+), 366 deletions(-)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/tracing_multi.c
>  create mode 100644 tools/testing/selftests/bpf/progs/tracing_multi_attach.c
>  create mode 100644 tools/testing/selftests/bpf/progs/tracing_multi_attach_module.c
>  create mode 100644 tools/testing/selftests/bpf/progs/tracing_multi_bench.c
>  create mode 100644 tools/testing/selftests/bpf/progs/tracing_multi_check.c
>  create mode 100644 tools/testing/selftests/bpf/progs/tracing_multi_fail.c
>  create mode 100644 tools/testing/selftests/bpf/progs/tracing_multi_intersect_attach.c
>  create mode 100644 tools/testing/selftests/bpf/progs/tracing_multi_rollback.c
>  create mode 100644 tools/testing/selftests/bpf/progs/tracing_multi_session_attach.c
> 

