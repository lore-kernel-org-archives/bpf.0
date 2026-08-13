Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C203943F8B5;
	Thu, 13 Aug 2026 08:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786608676; cv=none; b=rtqflSXPgpGon+0jiXCrFC4OCcAxt7i5387eOLE55ncexED/im9HXFZf2UN7QtgCUtMSdde/rakPhY3H8KNa336G2G94oYUr6GCN2RFh4DU13P+/bO5O+GXV0zCdvjKujRejf8iegc/ienERLSpE0dVTSllfPLiFjI/9XgEtdvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786608676; c=relaxed/simple;
	bh=IfWGFcUCfG34v+lFGseM7rxdpJXRz8e7r1rAEIAZCYc=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=Dk/Y73j0gJFTVLdYD5bjj45cJiDTr+oypZXspFmpPWx3aG+A0mLGs1pI26wSVRuWUTVM5sK2ETdzCDopF1C8JEhnn+WpcmXbuCCwHSdYG9ZwfW3+qRngG7TlTCeF7dQhXee/7i0mb06RIJxFSZ/Q/pIH+qjomgqXzTb/I04V3QA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CAzdMU8h; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CAzdMU8h"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D50D31F000E9;
	Thu, 13 Aug 2026 08:11:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786608669;
	bh=BlJ8wKLgGXEVc+BD39fhdz/Owvcy4D8dzQhVar+ovDk=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=CAzdMU8hAb9kTMKXFLI6lnLhflXozR/TVSl9v2uiA9HBFOyGEMrjZ3gr531sp1hl1
	 0Edkk/m2U+VHT4Ra1aWbXcknhOQmoSLbRRgPNTKv9Pbzk7h+3agUwX29yyHa5cX8xq
	 Ba7EAEIj5JeikYPAXC4zof8f3F7dREn21yHQ4LUKKuJMksAFWwV2toI4XWxxIU0woc
	 v9dtkqhqodhqAKKSTTVSl5kUFHI88OvGlvtbQ0A9kyisAl8ce1AQiGoo/k5YRcqM8l
	 PuywZ+df308LCL5sjQfGLo58JCMzKE95jfwwmTdt9wanZgOhm7loCVIjbhH2Kk1MWe
	 oDbNgjZvi3nfQ==
Content-Type: multipart/mixed; boundary="===============6604724293875791578=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <6a9f7ec666d4f36867e91cf21a36d7f8ef6a3872ac694f1eb468aa5278372ce3@mail.kernel.org>
In-Reply-To: <20260813070906.5164-1-yangtiezhu@loongson.cn>
References: <20260813070906.5164-1-yangtiezhu@loongson.cn>
Subject: Re: [PATCH bpf-next v1] selftests/bpf: Enable timed may_goto tests for LoongArch
From: bot+bpf-ci@kernel.org
To: yangtiezhu@loongson.cn,chenhuacai@kernel.org,hengqi.chen@gmail.com,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com
Cc: loongarch@lists.linux.dev,bpf@vger.kernel.org,linux-kernel@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Thu, 13 Aug 2026 08:11:08 +0000 (UTC)

--===============6604724293875791578==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> selftests/bpf: Enable timed may_goto tests for LoongArch
>
> Enable stream_cond_break, may_goto_interaction, and verifier_may_goto_1
> tests for LoongArch, aligning with recent architectural infrastructure
> support (timed may_goto and arch_bpf_stack_walk JIT).

The changelog states the tests are enabled "aligning with recent
architectural infrastructure support (timed may_goto and arch_bpf_stack_walk
JIT)". Does LoongArch have this infrastructure at this commit?

Looking at the tree, bpf_jit_supports_timed_may_goto() is not implemented for
LoongArch (only the __weak false stub in kernel/bpf/core.c:3379 exists).
arch/loongarch/net/Makefile builds only bpf_jit.o -- there is no
bpf_timed_may_goto.S file, unlike arm64, riscv, s390, powerpc, and x86. Also,
arch_bpf_stack_walk() is not implemented for LoongArch (only arch_stack_walk()
exists in arch/loongarch/kernel/stacktrace.c, but not the BPF-specific
variant).

If the enabling JIT work is in a separate series or a different tree, should
the changelog name it and state the dependency? As applied, this patch makes
three previously-skipped subtests fail on LoongArch.

> diff --git a/tools/testing/selftests/bpf/progs/stream.c b/tools/testing/selftests/bpf/progs/stream.c
> index 00a37933e411d..8e8e1339dc743 100644
> --- a/tools/testing/selftests/bpf/progs/stream.c
> +++ b/tools/testing/selftests/bpf/progs/stream.c
> @@ -65,6 +65,7 @@ __arch_x86_64
>  __arch_arm64
>  __arch_s390x
>  __arch_riscv64
> +__arch_loongarch
>  __success __retval(0)
>  __stderr("ERROR: Timeout detected for may_goto instruction")
>  __stderr("CPU: {{[0-9]+}} UID: 0 PID: {{[0-9]+}} Comm: {{.*}}")

The stream_cond_break test asserts that the kernel emits "ERROR: Timeout
detected for may_goto instruction" to stderr. Will this work on LoongArch?

The timeout message is only produced from bpf_prog_report_may_goto_violation()
in kernel/bpf/core.c:3389, which is only reached from
bpf_check_timed_may_goto(), which is only called from the verifier-emitted
sequence in kernel/bpf/fixups.c:1772 -- and that sequence is only emitted when
bpf_jit_supports_timed_may_goto() returns true.

LoongArch does not implement bpf_jit_supports_timed_may_goto():

arch/loongarch/net/bpf_jit.c defines bpf_jit_supports_{kfunc_call,
far_kfunc_call,arena,fsession,subprog_tailcalls} and
bpf_jit_inlines_helper_call(), but no bpf_jit_supports_timed_may_goto(), so
the __weak stub in kernel/bpf/core.c:3379 returning false applies.

arch/loongarch/net/Makefile also builds only bpf_jit.o -- there is no
bpf_timed_may_goto.S, unlike arm64/riscv/s390/powerpc/x86.

On LoongArch the while (can_loop) loop is expanded through the non-timed path
at fixups.c:1815, the loop simply terminates after BPF_MAX_LOOPS iterations,
nothing is written to stderr, and the three __stderr() expectations fail.

Additionally, even with timed may_goto support, bpf_prog_report_may_goto_violation()
returns early when bpf_prog_find_from_stack() returns NULL, and that function
only walks the stack via arch_bpf_stack_walk() in kernel/bpf/core.c:3587.
LoongArch has no arch_bpf_stack_walk() implementation (only arch_stack_walk()
in arch/loongarch/kernel/stacktrace.c), so the __weak no-op at
kernel/bpf/core.c:3375 applies and ctx.prog stays NULL.

> diff --git a/tools/testing/selftests/bpf/progs/verifier_bpf_fastcall.c b/tools/testing/selftests/bpf/progs/verifier_bpf_fastcall.c
> index 4cfaa6b4ab405..328cf630210a2 100644
> --- a/tools/testing/selftests/bpf/progs/verifier_bpf_fastcall.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_bpf_fastcall.c
> @@ -665,6 +665,7 @@ __naked void may_goto_interaction_x86_64(void)
>  SEC("raw_tp")
>  __arch_arm64
>  __arch_riscv64
> +__arch_loongarch
>  __log_level(4)
>  __msg("subprog 0 (may_goto_interaction) main {{.*}} stack 24")
>  /* may_goto counter at -24 */

Will this stack 24 assertion work on LoongArch?

The arch grouping is correct: this non-x86 variant expects
3: call bpf_get_smp_processor_id to survive, and
bpf_verifier_inlines_helper_call() only inlines BPF_FUNC_get_smp_processor_id
under CONFIG_X86_64 in kernel/bpf/verifier.c:16685, so LoongArch behaves like
arm64/riscv64 here.

But the rest of the assertion is specific to timed may_goto:

  - stack 24 and the two prologue stores 0: *(u64 *)(r10 -24) = and
    1: *(u64 *)(r10 -16) = come from the two-slot init at
    kernel/bpf/fixups.c:2400-2403, which is guarded by
    bpf_jit_supports_timed_may_goto().

  - The 7-insn expansion 4: r12 = *(u64 *)(r10 -24) ... 8: r12 = -24 /
    9: call unknown / 10: *(u64 *)(r10 -24) = r12 is the timed expansion at
    kernel/bpf/fixups.c:1790-1805.

On LoongArch the non-timed branch at fixups.c:1815 runs instead: a single
8-byte slot (stack 16, one prologue store of BPF_MAX_LOOPS) and a 4-insn
expansion with no call. Every __msg/__xlated line above therefore mismatches.

> diff --git a/tools/testing/selftests/bpf/progs/verifier_may_goto_1.c b/tools/testing/selftests/bpf/progs/verifier_may_goto_1.c
> index 0e211f030d0d7..db7e30da234f1 100644
> --- a/tools/testing/selftests/bpf/progs/verifier_may_goto_1.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_may_goto_1.c

[ ... ]

> @@ -83,6 +86,7 @@ __arch_x86_64
>  __arch_s390x
>  __arch_arm64
>  __arch_riscv64
> +__arch_loongarch
>  __xlated("0: *(u64 *)(r10 -16) = 65535")
>  __xlated("1: *(u64 *)(r10 -8) = 0")
>  __xlated("2: r12 = *(u64 *)(r10 -16)")

Will the may_goto_batch_2 test assertions work on LoongArch?

This "may_goto batch with offsets 2/0" case asserts the exact timed may_goto
rewrite: two prologue slots initialised to BPF_MAX_TIMED_LOOPS (65535) and 0
in kernel/bpf/fixups.c:2400-2403, then the 7-insn expansion ending in
6: r12 = -16 / 7: call unknown / 8: *(u64 *)(r10 -16) = r12 in
kernel/bpf/fixups.c:1790-1805.

All of it is gated on bpf_jit_supports_timed_may_goto(), which LoongArch does
not implement (only the __weak false stub in kernel/bpf/core.c:3379 exists;
arch/loongarch/net/ has no bpf_timed_may_goto.S and bpf_jit.c defines no such
callback).

On LoongArch the verifier takes the non-timed branch at
kernel/bpf/fixups.c:1815 and emits *(u64 *)(r10 -8) = 8388608 followed by a
4-insn expansion with no call, so this subtest fails.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/31678043819
--===============6604724293875791578==--
