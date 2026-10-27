Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793119571;
	b=smGabREceV1GNLbYULVcJQGBNj1pqhlGb+lHhuzKcvsHKOo0JAHcZQyOK/PrS2qYQsVP
	 ewE1/1gz6ixXMeUpk77T+Ttfs7+Uxmp5cqkpg9l9/0X1QfPyEF5b5VH1huASx+WJP7BQL
	 RFSebvOYfU1wnjsiZkjocv2126mKbMECzzoZElI7FPUGNdUKnZupOx0Zcrn4+7BbSvB3D
	 O4AlwHXW+ZKs6VMH/qG8Ofnof4nOCGSDr+/IPI9axpTBah8oqUQTGDFIfOsLqf/6+hdky
	 Hdt5LF/MzfP1ibvAMnWr/fb/tU7KQ/4c0wt57LMt3wdHkfSShaaVMcmARTz4YwdHcEg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793119571;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=ZR4iXfjLE18n9IsMPYVOZjcHl2kf9Eo16yEz3fPq5v4=;
	b=GEJOhYk96ev9MmTmbW4pQSSmM9X94Gi9rbsR/uqpb7j0PlRFfjJewQqOoK+bKOGIsdlf
	 lGmZEUd+RuUaeQGvmnnin0+1fv51U9Okd8uXBhSuE/N8spP0LlXnX94R0nrx4yilV2ahv
	 dT6ff9zOTeoICU/upyNhigQ46S5wWgApso9PUFjLHsITDqF+2sEJUeYMnTNSimTN/FKTa
	 Umf9o05HkZgQ7qEP0qtB7F+ovlWTutN8rIsXJjxzauE1Pnl8RyYWRrzl2amvxw0N+fNVA
	 MOztxVNogdRbdl1Xq4NgN3glJNy46V7cMpomgY5Pq8rrNa3F/HpMHt4bsZkrD1WsGQA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Jb2ldxJ7;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3465260A2609
	for <bpf@vger.kernel.org>; Tue, 27 Oct 2026 16:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Jb2ldxJ7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDAAC1F01825;
	Tue, 27 Oct 2026 16:46:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793119570;
	bh=ZR4iXfjLE18n9IsMPYVOZjcHl2kf9Eo16yEz3fPq5v4=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=Jb2ldxJ76cWStQtV5jaWyXtkPL1EPAAoWQmJPvib0a7WtRA8Efj+YDKTlUTeg9Zve
	 b4p9YFFiQui1340eiSxcTlrkGROsNB6cWEs/5mW8/eDGd53vYk598g8LrMTnTyH5BP
	 zp1m9Cny3wszIwUPbRlbd6GGCtE3TWTQbFErt5OCvs2SN57FdJjEQ/mrgwdT9I3fRB
	 /QktGTgZP3x9ewqw6ZKvyZdmF0icSoTJ6o54dguk5NpDCdTxE0tZpHBMYJI7R9Z2WZ
	 WMxZkY0TQqoNzAy/mxKlKhcMQ2gvFJQO+kr3fahBMo0u2CEEuUQL5hMtiz1gWjAQFX
	 PpmOgbMFOeRKQ==
Message-ID: <sashiko-outbox-186949@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next 5/7] selftests/bpf: Test local IRQ kfunc
 inlining
Reply-To: sashiko-reviews@lists.linux.dev
To: "Emil Tsalapatis" <emil@etsalapatis.com>, bpf@vger.kernel.org
In-Reply-To: <20261027162820.10887-6-emil@etsalapatis.com>
References: <20261027162820.10887-1-emil@etsalapatis.com>
 <20261027162820.10887-6-emil@etsalapatis.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 27 Oct 2026 16:46:10 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] selftests/bpf: parallel race on bpf_jit_harden in test_irq_jit()
- [Medium] selftests/bpf: missing is_jit_enabled() skip check in test_irq_j=
it()
--

commit c1826dafea259f7db660c28b5f90f57c88d53332
Author: Emil Tsalapatis <emil@etsalapatis.com>

selftests/bpf: Test local IRQ kfunc inlining

This commit adds BPF selftests for local IRQ save and restore kfunc inlinin=
g,
checking that userspace cannot submit the kernel-private opcodes directly a=
nd
verifying the translated and JITed instructions with bpf_jit_harden enabled.

> diff --git a/tools/testing/selftests/bpf/prog_tests/irq_jit.c b/tools/tes=
ting/selftests/bpf/prog_tests/irq_jit.c
> new file mode 100644
> index 0000000000000..3d5dc3c77edbc
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/irq_jit.c

[ ... ]

> +void test_irq_jit(void)
> +{
> +	struct irq_jit *skel;
> +	const char *harden =3D "/proc/sys/net/core/bpf_jit_harden";
> +	char old_harden[32];
> +	int err;

[Severity: Medium]
Should test_irq_jit() be declared as serial_test_irq_jit() instead?

Because /proc/sys/net/core/bpf_jit_harden modifies the global bpf_jit_harden
sysctl rather than per-netns state, running test_irq_jit() in parallel mode
(test_progs -j) enables constant blinding and disables BPF kallsyms globally
while other worker processes are running.

Concurrent tests that assert on unblinded xlated instruction offsets (such =
as
check_one_to_one_mapping(), check_simple(), and check_deletions() in
tools/testing/selftests/bpf/prog_tests/bpf_insn_array.c) or look up JITed B=
PF
symbols in /proc/kallsyms (such as test_stacktrace_ips) can fail spuriously
while bpf_jit_harden is set to 2.

In addition, test_irq_jit() races with other parallel tests that read and
write bpf_jit_harden (such as toggle_jit_harden() in
tools/testing/selftests/bpf/prog_tests/subprogs.c and check_blindness() in
tools/testing/selftests/bpf/prog_tests/bpf_insn_array.c). A concurrent writ=
er
can clear bpf_jit_harden before irq_jit__open_and_load() runs, or cause
old_harden to sample and restore "2", leaving hardening permanently enabled
for subsequent tests like serial_test_btf_rust().

Other tests that set /proc/sys/net/core/bpf_jit_harden to "2" via
sysctl_set_or_fail(), such as serial_test_arena_scalar_blinded(),
serial_test_jit_insns_blinded(), and serial_test_kasan(), use the
serial_test_ prefix to avoid this race.

> +
> +	if (sysctl_set_or_fail(harden, old_harden, "2"))
> +		return;
> +	skel =3D irq_jit__open_and_load();
> +	if (!ASSERT_OK_PTR(skel, "irq_jit_open_and_load"))
> +		goto restore_harden;

[Severity: Medium]
What happens in test_irq_jit() when the kernel is built without
CONFIG_BPF_JIT or when the BPF JIT is disabled at runtime
(/proc/sys/net/core/bpf_jit_enable =3D=3D 0)?

When CONFIG_BPF_JIT is not enabled, /proc/sys/net/core/bpf_jit_harden does
not exist and sysctl_set_or_fail() fails the test with ENOENT. When the JIT
is compiled in but disabled at runtime, add_kfunc_call() in
kernel/bpf/verifier.c rejects the kfunc calls with -ENOTSUPP:

    if (!env->prog->jit_requested) {
        verbose(env, "JIT is required for calling kernel function\n");
        return -ENOTSUPP;
    }

causing irq_jit__open_and_load() to fail the test instead of skipping.

Could test_irq_jit() check is_jit_enabled() and call test__skip() before
touching bpf_jit_harden, similar to serial_test_arena_scalar_blinded() in
tools/testing/selftests/bpf/prog_tests/arena_scalar_blinded.c:

    if (!is_jit_enabled()) {
        test__skip();
        return;
    }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261027162820.1088=
7-1-emil@etsalapatis.com?part=3D5
