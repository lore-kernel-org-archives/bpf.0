Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D01D445AF6
	for <bpf@vger.kernel.org>; Tue, 11 Aug 2026 14:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786458458; cv=none; b=D8mzTivoLTZQhkE1ABAgnG/ti4Hfti5xp4dilm9tDZudeQSHUIPHnw0jEBg/0w9Yc7Fv28GdlTkTjQ0V/SAJDzxU16RPBymjB7mH79hqKNRIVz2+UJX4C6jLD++6FKjbaDcU9GA/WyAuRfWiRFgD8Nf/d13euoSnDDNW3wjf4Hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786458458; c=relaxed/simple;
	bh=nVIP073XaL21KA96wDPH6ToCvlyUgZEDN586BZmijpE=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=oeP66FcU2EMPmGJfS/dZ0qb2pJRleNPto9pLopOD3/RQlx6Kk2XUrzUN6OJ2LEU1L09t6WhBKRJKA0p+mqXKov7UUynngt81q5Fd/7mHaCw25pmUgO1JoaSNKBD5SG+CCRsWLYMFz9IcaBTSxEBNcwjr7WZFzoXRX7NIVZXsoss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QPdPJ8Ob; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QPdPJ8Ob"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F2B71F00A3A;
	Tue, 11 Aug 2026 14:27:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786458456;
	bh=VBw5GOkdzYJ/gqiRRZ+oNJlGMjqxoRwVRpoU1gFmOO8=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=QPdPJ8ObwfO6bDzBX4MdPCxt4XPc+PFE20a+VGMPVzQy97HEQiHkqsAPZywJaVXLj
	 WChCfJqOOkyfOWR8rajsft8bMJZQLyPAI+Z9KSlUuIWlkxZiPpR7CEy0hw0PkGpnxf
	 aOXal/ecsges9nNHYcKxXg/17TP6Oz4ZHa0gYbTDJu/oeClfLI2HjTHBjXSyliRYjt
	 KV5DXLRwE2dsKmFM+Lonnee0yYAoOwseFKylofi1nTc0CFqsDH2pOs3RiViZOgH6+e
	 Ho+O6eeZZpdZM2MSeKJniqnfGudn9C8uAVlS4kyjT/AAyyRcrveHb9Pz+vvjevfdQg
	 2QJiLKbbeAymA==
Content-Type: multipart/mixed; boundary="===============3082970254000212603=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <94cf180b432f9d5d15a198285273f2ad57426e16855ff584da1c40519a93c4cd@mail.kernel.org>
In-Reply-To: <20260811131600.506721-6-daniel@iogearbox.net>
References: <20260811131600.506721-6-daniel@iogearbox.net>
Subject: Re: [PATCH bpf-next v3 6/6] selftests/bpf: Add arena fault tests for atomics with fetch
From: bot+bpf-ci@kernel.org
To: daniel@iogearbox.net,memxor@gmail.com
Cc: eddyz87@gmail.com,puranjay@kernel.org,bpf@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Tue, 11 Aug 2026 14:27:36 +0000 (UTC)

--===============3082970254000212603==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/prog_tests/stream.c b/tools/testing/selftests/bpf/prog_tests/stream.c
> --- a/tools/testing/selftests/bpf/prog_tests/stream.c
> +++ b/tools/testing/selftests/bpf/prog_tests/stream.c
> @@ -105,6 +105,10 @@ void test_stream_arena_fault_address(void)
>  		test_address(skel->progs.stream_arena_write_fault, &skel->bss->fault_addr);
>  	if (test__start_subtest("load_acquire_fault"))
>  		test_address(skel->progs.stream_arena_load_acquire_fault, &skel->bss->fault_addr);
> +	if (test__start_subtest("xchg_fault"))
> +		test_address(skel->progs.stream_arena_xchg_fault, &skel->bss->fault_addr);
> +	if (test__start_subtest("cmpxchg_fault"))
> +		test_address(skel->progs.stream_arena_cmpxchg_fault, &skel->bss->fault_addr);
>
>  	stream__destroy(skel);
>  }
> diff --git a/tools/testing/selftests/bpf/progs/stream.c b/tools/testing/selftests/bpf/progs/stream.c
> --- a/tools/testing/selftests/bpf/progs/stream.c
> +++ b/tools/testing/selftests/bpf/progs/stream.c
> @@ -229,6 +229,107 @@ int stream_arena_load_acquire_fault(void *ctx)
>  	return val;
>  }
>
> +SEC("syscall")
> +__arch_x86_64
> +__arch_arm64
> +__success __retval(0)
> +__stderr("ERROR: Arena WRITE access at unmapped address 0x{{.*}}")

The series includes fixes for four JITs (x86, arm64, riscv, s390), but
these new programs only cover two of them. Could __arch_riscv64 and
__arch_s390x variants be added for the other half?

The riscv64 and s390 JIT fixes exist in the same series:

  a49d067b71354 bpf, riscv: Clear fetch destination on faulting arena atomic
  e0de31f547978 bpf, s390:  Clear fetch destination on faulting arena atomic

but the __arch gate provably excludes them from these tests.

The __stderr() half unavoidably gates on x86_64 and arm64, since only
those two JITs call bpf_prog_report_arena_violation(). Both the riscv
and s390 changelogs state this explicitly.

But the __retval(0) half does not depend on arena violation reporting.
A variant tagged __arch_riscv64 __arch_s390x with __success __retval(0)
and no __stderr() would exercise exactly the register-clear fix those two
commits make, using the same poison-and-return mechanism. As written, two
of the four fixed JITs ship with no test coverage.

> +__stderr("CPU: {{[0-9]+}} UID: 0 PID: {{[0-9]+}} Comm: {{.*}}")
> +__stderr("Call trace:\n"
> +"{{([a-zA-Z_][a-zA-Z0-9_]*\\+0x[0-9a-fA-F]+/0x[0-9a-fA-F]+\n"
> +"|[ \t]+[^\n]+\n)*}}")
> +int stream_arena_xchg_fault(void *ctx)
> +{
> +	static const struct bpf_insn xchg_insn = {
> +		.code	 = 0xc3,	/* BPF_STX | BPF_ATOMIC | BPF_W */
> +		.dst_reg = 1,		/* BPF_REG_1 */
> +		.src_reg = 2,		/* BPF_REG_2 */
> +		.off	 = 0x7fff,
> +		.imm	 = 0xe1,	/* BPF_XCHG */
> +	};

Does the misaligned .off = 0x7fff cause the test to validate a different
fault path on arm64 than the commit message describes?

user_vm_start is page aligned, so the effective address is
user_vm_start + 0x7fff, which is 3 mod 4. The 4-byte BPF_W access also
straddles the page boundary at 0x8000.

For plain LDR/STR (stream_arena_read_fault, stream_arena_write_fault),
this offset works as intended: arm64 permits unaligned access with
SCTLR_EL1.A=0, so those really do take a translation fault on the unmapped
page.

But atomics require natural alignment. arm64 LSE CAS/SWP raise an EL1
Alignment fault (ESR FSC 0b100001) when the access is misaligned or crosses
a 16-byte granule, and that takes priority over the translation fault.

The test still passes - fixup_exception() in arch/arm64/mm/fault.c runs
before any die_kernel_fault path, so ex_handler_bpf() still clears the
fetch register and still prints "Arena WRITE access at unmapped address".
The fix under test is fault-type independent.

But the arm64 arm of both new subtests validates the alignment-fault path
rather than the unmapped-arena-page path, while x86-64 (where page fault
is delivered ahead of split-lock alignment check) validates the intended
one, so the two architectures end up testing different code paths.

A 4-byte-aligned offset inside the unmapped page (e.g. 0x7ffc) would keep
the fault a translation fault on both architectures. The pre-existing
stream_arena_load_acquire_fault has the same property with its 0x7fff.

[ ... ]

> +	return val;
> +}
> +
> +SEC("syscall")
> +__arch_x86_64
> +__arch_arm64

A subsystem pattern flags this as potentially concerning: On arm64 these
two programs only load on CPUs that implement LSE atomics, and nothing in
the test gates on that.

arch/arm64/net/bpf_jit_comp.c:bpf_jit_supports_insn() rejects arena RMW
atomics without LSE:

  bool bpf_jit_supports_insn(struct bpf_insn *insn, bool in_arena)
  {
  	if (!in_arena)
  		return true;
  	switch (insn->code) {
  	case BPF_STX | BPF_ATOMIC | BPF_W:
  	case BPF_STX | BPF_ATOMIC | BPF_DW:
  		if (!bpf_atomic_is_load_store(insn) &&
  		    !cpus_have_cap(ARM64_HAS_LSE_ATOMICS))
  			return false;
  	}
  	return true;
  }

The verifier consults it for arena destinations in atomic_ptr_type_ok()
and on failure rejects the program with "BPF_ATOMIC stores into R1 arena
is not allowed". BPF_XCHG (0xe1) and BPF_CMPXCHG (0xf1) are not load-store
forms, so bpf_atomic_is_load_store() returns false for both and the LSE
check applies.

This is new for this object. Before the patch the arena programs in
progs/stream.c used plain BPF_LDX/BPF_STX and one BPF_LOAD_ACQ, and
BPF_LOAD_ACQ is exempted by bpf_atomic_is_load_store(). progs/stream.c
therefore had no CPU-feature dependency until now.

On an ARMv8.0 core (Cortex-A53/A57/A72) the consequences reach beyond the
two new subtests, because stream__open_and_load() is an all-or-nothing
whole-object load:

  - test_stream_arena_fault_address(): stream__open_and_load() returns
    NULL, ASSERT_OK_PTR fails and the function returns, so read_fault,
    write_fault and load_acquire_fault are lost too - three subtests
    that pass today.
  - test_stream_syscall(): same whole-object load, and this test is
    otherwise entirely architecture-neutral.
  - test_stream_success() (RUN_TESTS) loads programs individually
    (bpf_program__set_autoload), so there the damage is limited to the
    two new programs reporting load failure.

Would a runtime LSE probe, or moving the two RMW programs into a separate
object so a load failure cannot take down the unrelated subtests, contain
this?

progs/arena_atomics.c already does arena xchg/cmpxchg guarded only by
compile-time checks, prog_tests/arena_atomics.c loads that whole object
with arena_atomics__load(), and DENYLIST.aarch64 is empty - so the
arena_atomics test presumably already fails on non-LSE arm64. This class
of gap is pre-existing in the tree.

> +__success __retval(0)
> +__stderr("ERROR: Arena WRITE access at unmapped address 0x{{.*}}")

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/31496528509
--===============3082970254000212603==--
