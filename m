Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794863843;
	b=SDLnDXFZ4b0rXNRBa9gRNBoNtklyi0P5KfAyrknVBQy5RGiOL8DLA/jVlRSHXOWU3r47
	 siggHcMJk5ARI/N8p1pi0sS/woAzJcYBspBBETM4eUJ/jcDmaRiLlwhXrjJGiGjK8cBwA
	 RXSa3edhDL0mgOXEsUHRE5dgN8QMvLyhSwvAovBKDhkuay5xG3sWYgfBUBC49q9n4qlC7
	 FywLQ9mOfUxZQa2nYfYqbFqTNZ3piysQp6LM91iA7bqv9HZZIAvUgHGfBEgQf+Lj4N9ee
	 /0TvqgRNSF8BRKAf3LUoOxYBfn1caY+4iYMYHuxhk7JGN4ElL4qvoxrnJ/c24wVSVUA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794863843;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=sTPbJ07GNt0+1u01Y5G4Xr3hVWCoVAYYEn2wljg+BRs=;
	b=pRUiVd2qI9Nd8ROfM2NyD/4/qqrqz+4k+etPfTbI+H0iG6OM+EA0Yh5kzmsSTEQUg1y/
	 SQh+tgaOfR+ajnfr1A7SPxaHnZy/W116fCntgWirAN8CZ5MIcvjkfDs7Yyy7fPdKjUrCV
	 zLtoO4bKVcFgkatK0iGKIA2rerB0SyBECa3nWSpHN9XAoGfdLNkM3kxN1JLhxVOGnjQjo
	 E6WMYqok14YrTXOFXXC/761uE8Ly2esek6bLEhvwXSO3JCl78yx82zuJ53Nfdsa2V2IWp
	 SVmtB9s12zk/KREe/F2ZqxbbX3z8Z7mDT4UIsVX25O3fmFzIv2r3Y1RzEjmuyeqheBQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bbdSzC1O;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 978A2606A88C
	for <bpf@vger.kernel.org>; Mon, 16 Nov 2026 21:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bbdSzC1O
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2ED0B1F000C7;
	Mon, 16 Nov 2026 21:17:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794863843;
	bh=sTPbJ07GNt0+1u01Y5G4Xr3hVWCoVAYYEn2wljg+BRs=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=bbdSzC1O7dLOov3QwwKLhMnVBKCYv3rBcI5XvLw9QexMDJ54jfwjtupiTopLtnQAU
	 lMpGrxi7asiaGUeknQWr68PsKGCyiMeTDEa7WYqbAwlbAhwQJlHaYwQArGZYI/E5+3
	 oIJMye+BJwcPqB+1ZO7Mqlmy5rgp9rjyOHjbrLguzpV18Gx4WArGQdqhAKo9Ex0Mnv
	 6ibbAvRLTEOIj+tzGdYZmNlg+KNahyt3oJ7BnPWw5T4oByysnNNd/q9mGoJml6+YNI
	 q34sml6hNVBgd9IlCr8huEduHxwLYKnI2bMwyjO5crI475Efe3nN86P00H5ENvRH6m
	 QwMJTf7R44IAQ==
Message-ID: <sashiko-outbox-217697@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v2 21/21] selftests/bpf: Test limits of the
 load with raw programs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org
In-Reply-To: <20261116152626.4032587-22-alexei.starovoitov@gmail.com>
References: <20261116152626.4032587-1-alexei.starovoitov@gmail.com>
 <20261116152626.4032587-22-alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 21:17:22 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 3 potential
issues to consider:
- [Medium] selftests/bpf: unguarded JIT-only xlated imm check in
  test_subprogs()
- [Low] selftests/bpf: pipe write fd leak on error path in
  test_freezer()
- [Low] selftests/bpf: unchecked fork() in no_limits reads uninitialized
  status
--

commit 3c35bcd7e95d13e7559756b6f54585ddac4df9c1
Author: Alexei Starovoitov <ast@kernel.org>

selftests/bpf: Test limits of the load with raw programs

This commit adds BPF selftests covering program loading under signals,
the cgroup freezer, and memory cgroup limits, as well as tests for
syscall program context, large subprogram counts, xlated dumps, kfuncs,
BTF type chains, and a light skeleton with many maps and programs.

> diff --git a/tools/testing/selftests/bpf/prog_tests/no_limits.c b/tools/t=
esting/selftests/bpf/prog_tests/no_limits.c
> new file mode 100644
> index 0000000000000..b949d1db23e6d
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/no_limits.c
> @@ -0,0 +1,465 @@

[ ... ]

> +static int exit_code(pid_t pid)
> +{
> +	int status;
> +
> +	if (!ASSERT_EQ(waitpid(pid, &status, 0), pid, "wait") ||
> +	    !ASSERT_TRUE(WIFEXITED(status), "exited"))
> +		return -1;
> +	return WEXITSTATUS(status);
> +}

[Severity: Low]
Can exit_code() read an uninitialized status if fork() fails in
test_freezer() or load_in_memcg()?  When pid is -1, waitpid(-1, &status,
0) fails with ECHILD and returns -1 without writing status, which passes
ASSERT_EQ(-1, -1) and then evaluates WIFEXITED(status) and
WEXITSTATUS(status) on uninitialized stack memory.

> +
> +/* The freezer does not wait for the end of the load. The load starts ag=
ain after it. */
> +static void test_freezer(int flag)
> +{
> +	struct bpf_insn *insns =3D straight_code(200000);
> +	struct bpf_common_attr common =3D {};
> +	union bpf_attr attr =3D {
> +		.prog_type =3D BPF_PROG_TYPE_SCHED_CLS,
> +		.insns =3D ptr_to_u64(insns),
> +		.insn_cnt =3D 200000,
> +		.license =3D ptr_to_u64("GPL"),
> +	};
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
> +		_exit(syscall(__NR_bpf, BPF_PROG_LOAD | flag, &attr, sizeof(attr), &co=
mmon,
> +			      sizeof(common)) !=3D fd ? 3 : 0);
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
Does the out path leak pipes[1] if create_and_get_cgroup() fails after
pipe(pipes) succeeds?  Also, if an earlier check jumps to out before
pipe(pipes) succeeds, close(pipes[0]) calls close(-1).

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
Will this assertion fail when BPF JIT is disabled?

When a program is interpreted rather than JIT-compiled,
bpf_fixup_call_args() rewrites pseudo-calls to BPF_JMP | BPF_CALL_ARGS,
and prepare_dump_pseudo_call() dumps bpf_call_args_imm(insn->off) into
insn->imm instead of the target subprogram index:

kernel/bpf/syscall.c:prepare_dump_pseudo_call() {
	...
	if (insn->code =3D=3D (BPF_JMP | BPF_CALL_ARGS))
		insn->imm =3D bpf_call_args_imm(insn->off);
	else
		insn->imm =3D bpf_prog_find_func(prog, idx + call_off + 1);
	...
}

Should test_subprogs() check info.jited_prog_len (or env.jit_enabled)
before asserting that insns[funcs - 1].imm equals funcs?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116152626.4032=
587-1-alexei.starovoitov@gmail.com?part=3D21
