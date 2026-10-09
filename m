Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F1F33ACA79;
	Fri,  9 Oct 2026 03:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791517385; cv=none; b=HjvrH/O7aBP+d3FsdLGG9B/eXxr1FAWeVjwiTlCc9Pxe8QMTuZoFytKNorBRt+1nuSclZ8oL6lNErdenNWoDnfA7QCU01KqkTFrqthgdM5/ONQz3vNdXjgmN0V0TsF8tTk+joD6UPk2ahHpREb0UbtvW9s8zMlNo2mtwHH+9heU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791517385; c=relaxed/simple;
	bh=qqXrHjSr3SV10hSYX/XfKD3J3xtKcsSQtOI9PFtAhiw=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=np2sUGtGsxhhLbNfPF0fpIoPAbKgsHXWJx4XAuRGNizeFTLQGv8GSqn31dt36EvtNi/HAcHu7KnoA8/fRLjIKw/DLAmH1uToRrvitgl6DUTQRszwlunhS2TYc8WZKKDT3sx+vUsyp4VllPBytwsgts03Mtd2noxwWeXg+7dVLv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d7Q8tDJm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d7Q8tDJm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 813671F00893;
	Fri,  9 Oct 2026 03:42:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791517376;
	bh=5aPCcAVsmpt4qOE8bDTbND9um3Ewz95XmGL8O0GlbpY=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=d7Q8tDJmtw6Wpy3ArP0D0rMayjgR83Kr3mDu3It6xDIDcqnZZYo03plR77fylF7Fh
	 Gi6zsNoCfZx3P0bnQflEbS6vC2zmNbtQkONdSa7XeVxLVPj7YD9/k1k6uOb3XQ5Cao
	 862lG7dKWctZhUa0XlHwExqoSIhIqiHKMXPzhJV7MpNKnLrnxJgxAiL8QzTJ0RnZob
	 +7rqURBt4VIylTqePg95LLUHUtVXd/NQ7KWzL4WlsIvEQW8VJOIsTwHBCP9puuhd5v
	 jSbfwup0Tc8b2wK30opFKjAq3ZIuVAVRz10aOcfBDvH6v51R3WoibUlj0LuqACrl52
	 Z0fR+6I8sMHlQ==
Content-Type: multipart/mixed; boundary="===============0305360540098415603=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <de66b04d75933a3f4a2a86ff4f660d7832b2b9dcc383d8207aecdf2befedbc35@mail.kernel.org>
In-Reply-To: <20261009024925.3169077-3-memxor@gmail.com>
References: <20261009024925.3169077-3-memxor@gmail.com>
Subject: Re: [PATCH bpf-next v1 2/3] bpf, x86: Skip the PROBE_MEM address range check under SMAP
From: bot+bpf-ci@kernel.org
To: memxor@gmail.com,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,emil@etsalapatis.com,ihor.solodrai@linux.dev,dave.hansen@linux.intel.com,luto@kernel.org,peterz@infradead.org,tglx@kernel.org,mingo@redhat.com,bp@alien8.de,puranjay@kernel.org,kkd@meta.com,kernel-team@meta.com,x86@kernel.org,linux-kernel@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Fri,  9 Oct 2026 03:42:54 +0000 (UTC)

--===============0305360540098415603==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf, x86: Skip the PROBE_MEM address range check under SMAP

TL;DR:
- Possible kernel oops: unprivileged (CAP_PERFMON, no CAP_BPF) programs aren't
  in kallsyms, so a NULL PROBE_MEM load under SMAP may not be fixed up
- Commit message wrongly credits arm64/riscv/loongarch; runtime cost
  unmentioned
- Stale comments (LASS, uaddress_limit)

>     bpf, x86: Skip the PROBE_MEM address range check under SMAP
>
>     The x86 JIT guards every PROBE_MEM load with a range check that keeps user
>     addresses, the guard page above TASK_SIZE_MAX and the vsyscall page away
>     from the load, because a kernel-mode fault on those addresses would oops
>     under SMAP instead of reaching the load's exception table entry. The check
>     is nine instructions and 39 bytes (32 when the offset is zero) in front of
>     a load of a few bytes. For "r7 = *(u64 *)(r0 + 2200)" on a 5-level paging
>     kernel, with VSYSCALL_ADDR and TASK_SIZE_MAX + PAGE_SIZE - VSYSCALL_ADDR as
>     the two constants:
>
>       movq    $-10485760, %r10
>       movq    %rax, %r11
>       addq    $2200, %r11
>       subq    %r10, %r11
>       movabsq $72057594048413696, %r10
>       cmpq    %r10, %r11
>       ja      load
>       xorl    %edi, %edi
>       jmp     done
>     load:
>       movq    2200(%rax), %rdi
>     done:
>
>     The previous patch made do_user_addr_fault() resolve the exception table
>     entries of BPF programs for faults on user addresses when SMAP is enabled.
>     On such kernels, emit the bare load with its exception table entry, as the
>     arm64, riscv, s390 and loongarch JITs already do. All BPF programs run with
>     SMAP active once the CPU feature is enabled, and the feature cannot change
>     after boot, so checking it at JIT time is sufficient. Kernels without SMAP,
>     including those booted with nosmap, keep the range check.
>
>     Measured with veristat over every object of the BPF selftests and over 466
>     production objects from Meta's fleet, on an x86-64 guest with SMAP, with
>     and without this series on top of bpf-next:
>
>                             programs  with PROBE_MEM  reduction per program
>                                                       mean  median    max
>       BPF selftests             3324              91  35.0%  37.5%  74.4%
>       Meta production programs  1710             228   7.0%   1.8%  69.2%
>
>     No program grows. The socket and task iterators of the selftests lose about
>     half of their code, dump_tcp6 goes from 4386 to 2124 bytes, and the
>     smallest production programs lose 60% to 69%. Loads through trusted
>     pointers and the probe_read helpers do not use PROBE_MEM, which is why most
>     programs are unaffected.
>
>     Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>

The commit message says the JIT emits the bare load "as the arm64, riscv,
s390 and loongarch JITs already do".  Is that accurate for arm64, riscv and
loongarch?

Those three select ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE and use the weak
bpf_arch_uaddress_limit(), which returns TASK_SIZE.  For them
bpf_do_misc_fixups() rewrites every PROBE_MEM and PROBE_MEMSX load into a
guarded sequence before the JIT sees it:

    *patch++ = BPF_MOV64_REG(BPF_REG_AX, insn->src_reg);
    if (insn->off)
            *patch++ = BPF_ALU64_IMM(BPF_ADD, BPF_REG_AX, insn->off);
    *patch++ = BPF_ALU64_IMM(BPF_RSH, BPF_REG_AX, 32);
    *patch++ = BPF_JMP_IMM(BPF_JLE, BPF_REG_AX, uaddress_limit >> 32, 2);
    *patch++ = *insn;
    *patch++ = BPF_JMP_IMM(BPF_JA, 0, 0, 1);
    *patch++ = BPF_MOV64_IMM(insn->dst_reg, 0);

So those JITs never emit a bare PROBE_MEM load for a user address.  Only
s390, which has separate address spaces, relies on the fault path in the way
the changelog describes.

With this patch, x86 with X86_FEATURE_SMAP set takes a full page fault,
is_bpf_text_address() and the exception table search for a load of NULL plus
an offset, where it used to execute a compare and a branch.  The veristat
numbers only measure code size.

Could the changelog correct the arm64/riscv/loongarch statement and say
something about the runtime cost of loads that now fault where they used to
branch?

> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> index 083fcd6cf15b..793e7cd5a5c4 100644
> --- a/arch/x86/net/bpf_jit_comp.c
> +++ b/arch/x86/net/bpf_jit_comp.c

[ ... ]

> @@ -2709,6 +2710,15 @@ static int do_jit(struct bpf_verifier_env *env, struct bpf_prog *bpf_prog, int *
>  		case BPF_LDX | BPF_PROBE_MEMSX | BPF_B:
>  		case BPF_LDX | BPF_PROBE_MEMSX | BPF_H:
>  		case BPF_LDX | BPF_PROBE_MEMSX | BPF_W:
> +			probe_mem = BPF_MODE(insn->code) == BPF_PROBE_MEM ||
> +				    BPF_MODE(insn->code) == BPF_PROBE_MEMSX;
> +			/*
> +			 * With SMAP enabled, a load from a user address faults and
> +			 * do_user_addr_fault() resolves the exception table entry of the
> +			 * program, as for an unmapped kernel address, so the address range
> +			 * check is only needed without SMAP.
> +			 */

this isn't a bug, but is this comment accurate when X86_FEATURE_LASS is
enabled?  With LASS, a supervisor load from the user half of the address
space raises a general protection fault rather than a page fault, and that is
handled on a different path:

    exc_general_protection() -> gp_try_fixup_and_notify() -> fixup_exception()

The outcome is the same, but the comment names do_user_addr_fault() as the
place where the entry is resolved.

> +			bounds_check = probe_mem && !cpu_feature_enabled(X86_FEATURE_SMAP);
>  			insn_off = insn->off;

Can this oops for a program that is not in kallsyms?  With bounds_check
false, a PROBE_MEM load of a user address such as NULL plus a field offset
depends only on the new branch in do_user_addr_fault():

    if (is_bpf_text_address(regs->ip) &&
        fixup_exception(regs, X86_TRAP_PF, error_code, address))
            return;
    ...
    page_fault_oops(regs, error_code, address);

Both is_bpf_text_address() and search_bpf_extables() only find programs that
are registered in bpf_tree, and bpf_prog_kallsyms_add() skips programs whose
loader lacks CAP_BPF:

    void bpf_prog_kallsyms_add(struct bpf_prog *fp)
    {
            if (!bpf_prog_kallsyms_candidate(fp) ||
                !bpf_token_capable(fp->aux->token, CAP_BPF))
                    return;

Such programs can still contain PROBE_MEM loads.  With
kernel.unprivileged_bpf_disabled=0, bpf_prog_load() accepts
BPF_PROG_TYPE_SOCKET_FILTER and BPF_PROG_TYPE_CGROUP_SKB without CAP_BPF.
With CAP_PERFMON, env->allow_ptr_leaks is true and bpf_sk_base_func_proto()
exposes bpf_skc_to_tcp_sock() and the other skc_to_* helpers.

skb->sk is readable as PTR_TO_SOCK_COMMON_OR_NULL, and sk_filter_trim_cap()
sets skb->sk while the filter runs.  The helper returns a plain
PTR_TO_BTF_ID, and walking a pointer field from it, for example
tp->inet_conn.icsk_ulp_ops->..., or sk_socket on an orphaned socket, gets
rewritten to BPF_PROBE_MEM by bpf_convert_ctx_accesses().  The x86 JIT then
emits an extable entry for it.

Before this patch, a NULL plus offset load in such a program was caught by
the JIT range check and dst was set to 0.  After it, on a CPU with
X86_FEATURE_SMAP the sequence would be:

    handle_page_fault() -> do_user_addr_fault() -> is_bpf_text_address()
    returns false -> page_fault_oops()

That would be an oops in softirq context (sk_filter on the receive path)
triggered by a user with CAP_PERFMON but without CAP_BPF.

arm64, riscv and loongarch are not exposed to this, because
bpf_do_misc_fixups() inserts the generic user address guard for them.

Should the range check be kept when the program will not be in kallsyms
(!bpf_token_capable(prog->aux->token, CAP_BPF)), or should every JITed
program with exception entries be registered in bpf_tree?

[ ... ]

Separately, the comment above bpf_arch_uaddress_limit() in this file:

arch/x86/net/bpf_jit_comp.c:
    /* x86-64 JIT emits its own code to filter user addresses so return 0 here */
    u64 bpf_arch_uaddress_limit(void)
    {
            return 0;
    }

is the stated reason x86 opts out of the generic verifier user address guard
in bpf_do_misc_fixups().  Is it still correct?  After this patch do_jit()
emits no filter at all when cpu_feature_enabled(X86_FEATURE_SMAP), and user
addresses are rejected only by the hardware check plus the fault handler
fixup.  Should the comment be updated, or should bpf_arch_uaddress_limit() be
made consistent with the new JIT behavior?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/37877475188
--===============0305360540098415603==--
