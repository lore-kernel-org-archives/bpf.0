Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793871713;
	b=PqPFWSQ4danVOTafx6Z8+PenPIPXqfNOm7BGvvgS769Z3DHLqrFrnvmns7xd1AgRNgOP
	 r3v2wkF7Os4zPOAFK/Ugl86EAAUvxJpFK5L8D17rOHw+nDH3CYWiEiUhEaH5OQ4c+5GEu
	 xnPmjrZcaC5ShEPvOKK+QY99m31HvBf74wdMjfXj8SQoW5uFVgI3VRbI58VgKIUMRw3HU
	 ma4vRdzUiv1saSgsZ4a3+WyiiBNPAuMmpxfHSg32ewUiKVdqGOE9BVa8aeTtSA7+rjUae
	 9CDA/1kt3ocat08+GeLLsFGAOr4ZdHo9qYaDrkMR1EDBzk7vTA+R2k56p8RHxkxfKxw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793871713;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=/Y2n9N3wHarGbcQP7ckfFTp1WfkEHxeGHJzkmY+Ja/M=;
	b=L763oNlGjzlVrI1kyUUiOcZ933/Os7BJILOATSPy4By4XceldyNIdoSPSu2nc+DMyrIf
	 MgCoIzachVdvelU3+x5Z5dT6iRrwTS8iO6L9RV6dyiKCd0Ojg0puZC6X1PMDIZBBzPXFD
	 z5HtRxCaeufMJIQTQiTg9/wcS9/p5KACsIonukI0mymGTe45TuvIzyk5xXNBhEV3tSYjM
	 Q9IhOcMyoFf0UMCJkmOBBlzWVMYzI9x8XAqxtQ6nfelIaskdIo8LGiWIiJvRFr+oUfwyd
	 KMbPfBXgg7ZybXyn458Xo+lJAWqfMLBOXB2YnebrVwYzpone8fJaq2pt+Wk7bE0ArNQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=A4qEBuzZ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69DF7606A31B;
	Thu,  5 Nov 2026 09:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=A4qEBuzZ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 180041F000C1;
	Thu,  5 Nov 2026 09:41:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793871713;
	bh=/Y2n9N3wHarGbcQP7ckfFTp1WfkEHxeGHJzkmY+Ja/M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=A4qEBuzZUpdqYcqJxtZJz0HQHypx0ojZ1RZncVDsD1y+3eaE0yA5Q5eA4W13uSSrO
	 DPXD7QigtpmgDV8uJAgJchiPPqGi3rETfIKKAzgEQBhxrPSBfuRbnOTBl5LRWMUKKr
	 ukglWm2g0G7jez2kFZt/QSkRbaSGu7QCobEAI0YjRCiQ31wAAVmDB/zDi0P0BcjGG4
	 W7910/WHeos4BkIp60BlHZkai6LVyOQAN4dotfAiEEnaV/ZpDGxpDNvPFauvGFkeEF
	 K28fMZpvRT8t2t4k+WO0NKpn1a4SZou91Q+LpBfUYEZTJjIQlaoD3w7xv4XNpMFYPB
	 Q481IZgaHJdXw==
Message-ID: <sashiko-outbox-198772@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v4 2/2] selftests/bpf: Test faulting build IDs
 from a sleepable raw tracepoint
Reply-To: sashiko-reviews@lists.linux.dev
To: "Feng Yang" <yangfeng59949@163.com>
Cc: bpf@vger.kernel.org, linux-trace-kernel@vger.kernel.org
In-Reply-To: <20261105093212.826479-2-yangfeng59949@163.com>
References: <20261105093212.826479-1-yangfeng59949@163.com>
 <20261105093212.826479-2-yangfeng59949@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 09:41:52 +0000
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
- [Medium] selftests/bpf: race setting target_tgid before target_syscall
- [Medium] selftests/bpf: unchecked signed-unsigned division in subtest_raw=
_tp()
--

commit 2b4f6f5d972293b188ccb421c050655343b0d0ee
Author: Feng Yang <yangfeng@kylinos.cn>

selftests/bpf: Test faulting build IDs from a sleepable raw tracepoint

This commit extends the build_id selftest with sleepable and non-sleepable
raw tracepoint subtests on sys_enter to verify user stack build ID extracti=
on
when the build ID page is paged out.

> diff --git a/tools/testing/selftests/bpf/prog_tests/build_id.c b/tools/te=
sting/selftests/bpf/prog_tests/build_id.c
> index aec9c8d6bc96b..98e3d09981793 100644
> --- a/tools/testing/selftests/bpf/prog_tests/build_id.c
> +++ b/tools/testing/selftests/bpf/prog_tests/build_id.c
[ ... ]
> +static int run_uprobe_multi_syscall(struct test_build_id *skel)
> +{
> +	char c =3D 'x';
> +	int pfd[2], status, err;
> +	pid_t pid;
> +
> +	if (pipe(pfd))
> +		return -errno;
> +
> +	pid =3D fork();
> +	if (pid < 0) {
> +		err =3D -errno;
> +		close(pfd[0]);
> +		close(pfd[1]);
> +		return err;
> +	}
> +	if (pid =3D=3D 0) {
> +		close(pfd[1]);
> +		if (read(pfd[0], &c, 1) !=3D 1)
> +			_exit(127);
> +		close(pfd[0]);
> +		execl("./uprobe_multi", "uprobe_multi", "paged-out-syscall", NULL);
> +		_exit(127);
> +	}
> +
> +	close(pfd[0]);
> +	skel->bss->target_tgid =3D pid;
> +	skel->bss->target_syscall =3D SYS_getpid;

[Severity: Medium]
Can setting target_tgid before target_syscall in run_uprobe_multi_syscall()
race with the child's read(pfd[0], &c, 1) on architectures where SYS_read i=
s 0
(such as x86_64)?

In subtest_raw_tp(), skel->bss is zero-initialized (so target_syscall is 0)
and rawtp_sleepable or rawtp_nofault is already attached before calling
run_uprobe_multi_syscall():

subtest_raw_tp()
  bpf_program__attach()
  run_uprobe_multi_syscall()
    fork()

If the child enters sys_enter for read(pfd[0], &c, 1) after the parent stor=
es
skel->bss->target_tgid =3D pid but before skel->bss->target_syscall =3D SYS=
_getpid
becomes visible, rawtp_nofault or rawtp_sleepable in
tools/testing/selftests/bpf/progs/test_build_id.c sees:

	if ((u32)(bpf_get_current_pid_tgid() >> 32) !=3D (u32)target_tgid ||
	    id !=3D target_syscall)
		return 0;

	/* Record only the first hit, a later getpid() must not overwrite it. */
	if (res_rawtp_sleepable)
		return 0;

Because id =3D=3D 0 matches target_syscall =3D=3D 0, the program records th=
e stack of
the forked test_progs process before execl() and ignores the subsequent
SYS_getpid in uprobe_multi, causing the uprobe_multi build ID assertion to
fail. Should target_syscall be initialized before attaching or before setti=
ng
target_tgid?

> +	if (write(pfd[1], &c, 1) !=3D 1) {
[ ... ]
> +static void subtest_raw_tp(bool sleepable)
> +{
[ ... ]
> +	if (sleepable) {
> +		res =3D skel->bss->res_rawtp_sleepable;
> +		stack =3D skel->bss->stack_rawtp_sleepable;
> +	} else {
> +		res =3D skel->bss->res_rawtp_nofault;
> +		stack =3D skel->bss->stack_rawtp_nofault;
> +	}
> +	frame_cnt =3D res / sizeof(struct bpf_stack_build_id);
> +	if (env.verbosity >=3D VERBOSE_NORMAL)
> +		print_stack(stack, frame_cnt);
> +
> +	ASSERT_GT(frame_cnt, 0, "frames");

[Severity: Medium]
If bpf_get_stack() returns a negative errno in res_rawtp_sleepable or
res_rawtp_nofault, does dividing the signed int res by the unsigned size_t
sizeof(struct bpf_stack_build_id) convert res to a large unsigned value bef=
ore
checking if it succeeded?

On 32-bit architectures, where int and size_t are both 32-bit, a negative r=
es
such as -EFAULT (-14) becomes 0xfffffff2U / 32 =3D 134217727 in frame_cnt, =
which
passes ASSERT_GT(frame_cnt, 0, "frames") and overflows the 128-element
stack_rawtp_sleepable or stack_rawtp_nofault array in print_stack(),
stack_has_build_id(), and stack_has_ip(). Even on 64-bit targets, a failed
ASSERT_GT(frame_cnt, 0, "frames") falls through to the subsequent stack che=
cks
instead of jumping to cleanup.

Should subtest_raw_tp() check res before computing frame_cnt, matching
subtest_sleepable() in the same file:

	if (!ASSERT_GT(skel->bss->res_sleepable, 0, "res"))
		goto cleanup;

	stack =3D skel->bss->stack_sleepable;
	frame_cnt =3D skel->bss->res_sleepable / sizeof(struct bpf_stack_build_id);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105093212.8264=
79-1-yangfeng59949@163.com?part=3D2
