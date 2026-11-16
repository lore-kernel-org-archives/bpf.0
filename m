Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794811148;
	b=3dKMqpWW5+J3YvaaLu/iC6WkKK4TqI7pBs9OIhnNy2VRBaxzQKzF06DSVZ8Qyn52ottR
	 jeslkjNoud5QLSdB/2Z3dJMHK9vSmNr98KzeEKCD5St2Ya9WquTaV1gO5l+J85X1d43/z
	 t4/0OfyNVAhYB6XCdrd+pyUbbG/q3exLPxLeojmGJyOitNxzTzvB79Z/WoU0DU263ecSf
	 foOmIyNOXC0PBUMBX5S0JlIgBKFPcDfp0O1EUnDd29rBO8QL3dkmr1+tEWT2EoBffSbEJ
	 Y/QjbOjMADYPIrG73nYMbhV/qYC6TSZol38bOiWO3MEpGlobJa+yesoIOFKJZo/hQVg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794811148;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=izTjP90P/WmdT6wCkSd64S7zbST4eXE5HuNteoEWmR4=;
	b=BNXaLYSyupp9AZZ5wE6T21zshnrTMcs2K5QIpOtUNuL82Y96NOPSi2FyGXpQeLKHShdQ
	 ssG7g7Oqhm65FMdyQ8XXtbUTESzLPNYOexkZO7kTKKvDYvNJJAZ3yRAMTeTehcrb6TkM8
	 fW9UtKDgeajUvVPjXOPMm3De38IWslfwT3sIf5swpjIHjwBGoBzHSEgmegdfeSsuHBN/d
	 j/vcsXcYfGSDxk7t/r8qEWXhrisorV2e/RZHYO1uaTTsrNUUdBrwR90GZoAAX1d++Cm6O
	 7h9WTHf8YyD1X50CdC1srhFv1s+raWC6zb/kZgrVwQaxGHkMqTUQ6ZIlSzdVJfwtBOQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HuJnvzry;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F797606A336
	for <bpf@vger.kernel.org>; Mon, 16 Nov 2026 06:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HuJnvzry
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6BF81F000C5;
	Mon, 16 Nov 2026 06:39:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794811147;
	bh=izTjP90P/WmdT6wCkSd64S7zbST4eXE5HuNteoEWmR4=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=HuJnvzrylscBXtK186ij3k30a2xWrCpmBSAgiHPLdJfxxmG9ef7fmRoPKenfyBOdv
	 2OHgwyDD2sB5J31U6KX+ZVJYPc2o+5t0jGeGKP3+H9aiEvpUwGcUfvuUnpZkt0WopO
	 zNoapc8QeGQ1qPwT2bM3t752JYHXc/Jw6wNNIblqSLLBkJx++fKxVwKMfssBs04r8a
	 d7z6bmny8xGcI5G3Nw+zEI7RRSgRQFlO7lKEQXu9sG6PK92+w+uJuCZbsoK8hTopUM
	 t7JNFBZ+Fj8lcqwtDPfHqY/X6Kv5tlpWRdlJLQ32HKYxODJaX5it9/oRghOWVie1Qf
	 aFCtPWn24Ef9w==
Message-ID: <sashiko-outbox-216288@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next 21/21] selftests/bpf: Test limits of the load
 with raw programs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org
In-Reply-To: <20261116055638.4171529-22-alexei.starovoitov@gmail.com>
References: <20261116055638.4171529-1-alexei.starovoitov@gmail.com>
 <20261116055638.4171529-22-alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 06:39:07 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [Medium] selftests/bpf: unguarded JIT-only xlated imm check in
  test_subprogs()
- [Low] selftests/bpf: pipe write fd leak on error path in
  test_freezer()
--

commit 3c3d567efb107d402bf1f0ddb12c0e6adeace271
Author: Alexei Starovoitov <ast@kernel.org>

selftests/bpf: Test limits of the load with raw programs

This commit adds a no_limits selftest suite covering BPF program and BTF
loading edge cases such as signals, cgroup freezer, memory cgroup limits,
syscall program contexts, large numbers of subprogs, kfuncs, and light
skeletons.

> diff --git a/tools/testing/selftests/bpf/prog_tests/no_limits.c b/tools/t=
esting/selftests/bpf/prog_tests/no_limits.c
> new file mode 100644
> index 0000000000000..2c9e5855f306a
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/no_limits.c
[ ... ]
> +/* The freezer does not wait for the end of the load. The load starts ag=
ain after it. */
> +static void test_freezer(void)
> +{
> +	LIBBPF_OPTS(bpf_prog_load_opts, opts, .attempts =3D 1);
> +	struct bpf_insn *insns =3D straight_code(200000);
> +	int cg =3D -1, pipes[2] =3D { -1, -1 }, fd;
> +	char buf[64] =3D "";
> +	pid_t pid;
> +
> +	if (!insns || !ASSERT_OK(setup_cgroup_environment(), "setup") ||
> +	    !ASSERT_OK(pipe(pipes), "pipe"))
> +		goto out;
> +	cg =3D create_and_get_cgroup("/no_limits");
> +	if (!ASSERT_OK_FD(cg, "cgroup"))
> +		goto out;
> +	pid =3D fork();
> +	if (!pid) {
> +		/* the fd that the prog gets */
> +		if (join_parent_cgroup("/no_limits"))
> +			_exit(1);
> +		fd =3D dup(pipes[0]);
> +		close(fd);
> +		if (write(pipes[1], &fd, sizeof(fd)) !=3D sizeof(fd))
> +			_exit(2);
> +		_exit(bpf_prog_load(BPF_PROG_TYPE_SCHED_CLS, NULL, "GPL", insns, 20000=
0,
> +				    &opts) !=3D fd ? 3 : 0);
> +	}
> +	close(pipes[1]);
> +	if (ASSERT_EQ(read(pipes[0], &fd, sizeof(fd)), sizeof(fd), "read")) {
> +		usleep(10000);
> +		ASSERT_OK(write_cgroup_file("/no_limits", "cgroup.freeze", "1"), "free=
ze");
> +		while (!strstr(buf, "frozen 1") &&
> +		       !read_cgroup_file("/no_limits", "cgroup.events", buf, sizeof(bu=
f)))
> +			usleep(1000);
> +		snprintf(buf, sizeof(buf), "/proc/%d/fd/%d", pid, fd);
> +		ASSERT_ERR(faccessat(AT_FDCWD, buf, F_OK, AT_SYMLINK_NOFOLLOW), "no pr=
og yet");
> +		ASSERT_OK(write_cgroup_file("/no_limits", "cgroup.freeze", "0"), "thaw=
");
> +	}
> +	ASSERT_OK(exit_code(pid), "load");
> +out:
> +	close(pipes[0]);
> +	if (cg >=3D 0)
> +		close(cg);
> +	cleanup_cgroup_environment();
> +	free(insns);
> +}

[Severity: Low]
Does the out path leak pipes[1] if create_and_get_cgroup() fails?  That
error jump happens after pipe(pipes) succeeds and before close(pipes[1]),
leaving pipes[1] open in the test_progs runner across later tests, and
earlier failures also call close(-1) on pipes[0].

[ ... ]

> +/* The number of a subprog does not fit into s16 */
> +static void test_subprogs(void)
> +{
> +	const int funcs =3D 33000, cnt =3D 4 * funcs + 1;
> +	struct bpf_insn *insns =3D many_funcs(funcs);
> +	struct bpf_prog_info info =3D {};
> +	__u32 len =3D sizeof(info);
> +	int fd;
> +
> +	if (!insns)
> +		return;
> +	fd =3D load(insns, cnt);
> +	if (!ASSERT_OK_FD(fd, "load"))
> +		goto out;
> +	ASSERT_EQ(run(fd), funcs - 1, "retval");
> +	info.xlated_prog_len =3D cnt * sizeof(*insns);
> +	info.xlated_prog_insns =3D ptr_to_u64(insns);
> +	if (ASSERT_OK(bpf_prog_get_info_by_fd(fd, &info, &len), "dump"))
> +		ASSERT_EQ(insns[funcs - 1].imm, funcs, "subprog");

[Severity: Medium]
Will this assertion fail when BPF JIT is disabled or unavailable?

When a program is not JIT-compiled, bpf_fixup_call_args() rewrites
pseudo-calls to BPF_JMP | BPF_CALL_ARGS for the interpreter, so
prepare_dump_pseudo_call() dumps bpf_call_args_imm(insn->off) instead of
the subprogram index:

kernel/bpf/syscall.c:prepare_dump_pseudo_call() {
    ...
	if (insn->code =3D=3D (BPF_JMP | BPF_CALL_ARGS))
		insn->imm =3D bpf_call_args_imm(insn->off);
	else
		insn->imm =3D bpf_prog_find_func(prog, idx + call_off + 1);
    ...
}

Guarding this check on env.jit_enabled (or info.jited_prog_len) would
avoid false test failures on interpreter runs.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116055638.4171=
529-1-alexei.starovoitov@gmail.com?part=3D21
