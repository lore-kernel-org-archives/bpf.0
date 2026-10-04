Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D75FE4399EA
	for <bpf@vger.kernel.org>; Sun,  4 Oct 2026 14:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791123886; cv=none; b=CbCkxXhyIQResjEc0w0tPwb9djH2r8F+iFB8ImPhoEzDsH9LZZkOtqz7TdWpMJdxG4xzxsgWlki/j9V2iMHbMFI1BObWVAEnHevYlditQi8o4wfSQfCXodVxtN88IY4MlgVdjTZZXSjZrmOQNAliGL68yKEpvgLrqOuZQa+/Ok4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791123886; c=relaxed/simple;
	bh=uXibVaJRNbLc/yAPdbks9Q/qsNzTcE5xPgG3/6pEnDU=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=glruja2j4cw3q2LSNPmMBlX4lvWzIKrSvP2YbCrYNpKQdv3LhqGKq39z32qvo22TqiKKM7cErbQsGkYPBP4352pNSnxVNS0WQZNjjKhTg7b5u7J6VkqwDPRyGofy6nQtIHdpQoDR4P/Wr24V8jKLCWoOFDF4g/fj48+2yY+UIWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F5uLVe9r; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F5uLVe9r"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 470441F000FF;
	Sun,  4 Oct 2026 14:24:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791123884;
	bh=S0p6KScZLTOEbX7SlOKSFV5+v+YnXDf28SjThXKIu+g=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=F5uLVe9rLF/3N5apdLuhjTZGpm0QJfhh7UOOqvCzG/LEn70iz7mJbC81t1g8dfDEh
	 8Bz0h/u17AhIsgleOjVRmRAMdFmcPoNalgN4kd7q/fbb+cdP/NWbDQB4ZhhD+X03Pi
	 Z0zx/hHY6CV21+kOcjwZOfKVRZd7rQJ8wwuLPB8NH7TUHNrSWwur7Jsvls7Wg9Hrvx
	 kEt1wMXi+L8P6xzXLaYjYrSTpnKRnNMNDB8l1ELCLwNoQ/JW27ypQEpT4StQ03za4U
	 yegdKWiO5VPtDEzuLigDmwQLqJmOtihBvjl0uHXJwejL5y3LISkffCDRwNtGwUkvOj
	 OwGe6Jl9Yq6tg==
Content-Type: multipart/mixed; boundary="===============2245452824140866769=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <87c06a6bbfb20e6d4e98afe0c738b760e020b41c6e4d778c0fb3b2f84aa79ce1@mail.kernel.org>
In-Reply-To: <20261004-scev-minimal-rebase-v2-42-f6254e29fdf2@gmail.com>
References: <20261004-scev-minimal-rebase-v2-42-f6254e29fdf2@gmail.com>
Subject: Re: [PATCH bpf-next v2 42/43] selftests/bpf: tests for immediate dominator computation
From: bot+bpf-ci@kernel.org
To: eddyz87@gmail.com,bpf@vger.kernel.org,ast@kernel.org
Cc: andrii@kernel.org,daniel@iogearbox.net,kernel-team@fb.com,yonghong.song@linux.dev,eddyz87@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Sun,  4 Oct 2026 14:24:43 +0000 (UTC)

--===============2245452824140866769==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> selftests/bpf: tests for immediate dominator computation

TL;DR: The ldimm64 selftests in verifier_idoms.c may pass even if the
bpf_is_ldimm64() skip in compute_predecessors() is removed, so comments and
changelog overstate what they check.

> diff --git a/tools/testing/selftests/bpf/progs/verifier_idoms.c b/tools/testing/selftests/bpf/progs/verifier_idoms.c
> new file mode 100644
> index 000000000000..a29d6332baa4
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/verifier_idoms.c
> @@ -0,0 +1,390 @@

[ ... ]

> +
> +/*
> + * Straight-line code, with an ldimm64 in the middle. Instruction index 2 is
> + * the second half of the ldimm64 at index 1 and is not a CFG node; the idom of
> + * index 3 must be 1, not 2. Exercises the bpf_is_ldimm64() skip in both passes
> + * of compute_predecessors().
> + */
> +SEC("socket")
> +__success
> +__log_level(2)
> +__msg("Program dump")
> +__msg("{{.*}} -1   0: {{.*}} (b7) r0 = 0")
> +__msg("{{.*}}  0   1: {{.*}} (18) r1 = 0x1122334455667788")
> +__msg("{{.*}}  1   3: {{.*}} (07) r0 += 1")
> +__msg("{{.*}}  3   4: {{.*}} (0f) r0 += r1")
> +__msg("{{.*}}  4   5: {{.*}} (95) exit")
> +__naked void straight_line_ldimm64(void)
> +{
> +	asm volatile ("					\
> +	r0 = 0;						\
> +	r1 = 0x1122334455667788 ll;			\
> +	r0 += 1;					\
> +	r0 += r1;					\
> +	exit;						\
> +"	::: __clobber_all);
> +}

Can this test actually fail if the bpf_is_ldimm64() skip is missing from
compute_predecessors()?

The comment above and the commit message ("exercises the bpf_is_ldimm64()
skip in compute_predecessors()") present "the idom of index 3 must be 1,
not 2" as the failure being guarded against.

Without the skip, compute_predecessors() would call
bpf_insn_successors(env, 2) on the second half of the ldimm64 and record
insn 2 as an extra predecessor of insn 3.

But insn 2 is never in env->cfg.insn_postorder, because
bpf_compute_postorder() only reaches it through bpf_insn_successors(), which
advances by insn_sz == 2 for an ldimm64.  So idoms[2] keeps the -1 that
bpf_compute_idoms() set, and compute_subprog_idoms() drops that predecessor:

    if (idoms[pred] == -1)
        continue;

idom(3) still comes out as 1, so the __msg() lines above pass either way.
The only other effect is aux[].bb_end, which log_program() does not print.

A value of 2 would only appear if the ldimm64 second half were treated as a
CFG node in bpf_insn_successors() or bpf_compute_postorder(), not if the
compute_predecessors() skip were missing.

[ ... ]

> +#if defined(__TARGET_ARCH_x86) || defined(__TARGET_ARCH_arm64) || defined(__TARGET_ARCH_powerpc)
> +/*
> + * Indirect jump (gotox) with a two-entry jump table. The gotox (insn 4) has two
> + * successors (insn 5 and insn 7), so both targets have the gotox as their only
> + * predecessor and idom. Also re-exercises the ldimm64 skip: insn 2's idom is 0,
> + * the ldimm64 at index 0 (index 1 is its second half).
> + */
> +SEC("socket")
> +__success
> +__log_level(2)
> +__msg("Program dump")
> +__msg("{{.*}} -1   0: {{.*}} (18) r0 = {{0x[0-9a-f]+}}")
> +__msg("{{.*}}  0   2: {{.*}} (07) r0 += 8")
> +__msg("{{.*}}  2   3: {{.*}} (79) r0 = *(u64 *)(r0 +0)")
> +__msg("{{.*}}  3   4: {{.*}} (0d) gotox r0")
> +__msg("{{.*}}  4   5: {{.*}} (b7) r0 = 0")
> +__msg("{{.*}}  5   6: {{.*}} (95) exit")
> +__msg("{{.*}}  4   7: {{.*}} (b7) r0 = 1")
> +__msg("{{.*}}  7   8: {{.*}} (95) exit")
> +__naked void gotox_jump_table(void)

The gotox_jump_table comment ("Also re-exercises the ldimm64 skip: insn 2's
idom is 0") has the same limitation.

Should the comments and the changelog describe what is actually checked, or
should the test assert something that depends on the skip?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/37207249098
--===============2245452824140866769==--
