Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D629843B495
	for <bpf@vger.kernel.org>; Tue, 18 Aug 2026 08:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787042810; cv=none; b=fu3/jmRBt3mMH+9ZOWWupnVXfD17g/J4siyP0J7FKG7plGVQ+l9LEYg8Ye6Miea+Z7SIN5ssTu2gVTBYD9LyMBGca/gRGX8w1q4NZC1A60rUvCzpDs2cNYeQIsdNaLfiXXcU9aM64ZiWOM0z+gz1y6M4kwPaO93txP8H7ZnSVYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787042810; c=relaxed/simple;
	bh=sYQj9QK5xki55yj6qqkghkEqFeQHEFwyX5DUwhFtw0g=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jWmK4AM9rvw+tac9wNzIDpYoksm7Sjz8Y4wzp6auyDaaHVENcmL+Q06R20toNTEvrmrJCXRMrCiMobtZYPXSFxWUcfmS2GNgtj1YaxCLsoH2/ej7pEVWI8Uw1DpufQDwjNenM2EkCxvpC/ZSPxUHJDqK7osi2EOcdvdeL+IePXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sist/O4M; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sist/O4M"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61C581F000E9;
	Tue, 18 Aug 2026 08:46:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787042808;
	bh=AX03XvGJ0IYyzjgvCvLXtXt0MXd96HengN+9LSpygc4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Sist/O4MbKflDyu9I32LlHsIe12j0+lNRV9wYmw2lBgtKrSFX/iDO+WKu2J3+EEE2
	 y0x/iuj+5hfIs3zcfuSpIFB2qvJ6RaP1hEx6YnIfGk+ZxVrTDgR8n2HKy0Jm2tKKo+
	 yTzjMtlbQquqm1lIDI6IZm4DRm32EUTYOyN9EMM/KLdRMcht2+Y/HwEpzNHPEy9Dir
	 qAoSVhaJ04B6JgXBjNJlpfR7dHC7AF2/ehbU5887pqKBvqcJ5wFpDTzhnTxmpq3aJ3
	 eEJZ0k8gPjN1feivR4iItJ3Q3ufaxzyikAjYl4DuYXqyeT2igpnQMp1BOxYeNJPrq/
	 XjapLJix7PiWg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v2 2/2] selftests/bpf: add memcg async reclaim
 test
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hui Zhu" <hui.zhu@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <fbbeaf46501c66372d792c712349eac0205beea7.1787040082.git.zhuhui@kylinos.cn>
References: <cover.1787040082.git.zhuhui@kylinos.cn>
 <fbbeaf46501c66372d792c712349eac0205beea7.1787040082.git.zhuhui@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 18 Aug 2026 08:46:47 +0000
Message-Id: <20260818084648.61C581F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] Test fails consistently on systems where `/tmp` is a `tmpfs` bec=
ause file operations will create unevictable shmem pages, leading to an OOM=
 kill.
- [Medium] Race condition in the cleanup path can send SIGKILL to unrelated=
 processes due to sending signals to reaped PIDs.
--

--- Patch [2]: [PATCH bpf-next v2 2/2] selftests/bpf: add memcg async recla=
im test ---
commit bbf998f1580c0a48a6f9d3478a89f37c3c38e8c9
Author: Hui Zhu <zhuhui@kylinos.cn>

selftests/bpf: add memcg async reclaim test

Add memcg_async_reclaim selftest that verifies BPF-driven async
proactive reclaim can mitigate refault-induced slowdown under memory
pressure.

> diff --git a/tools/testing/selftests/bpf/prog_tests/memcg_async_reclaim.c=
 b/tools/testing/selftests/bpf/prog_tests/memcg_async_reclaim.c
> new file mode 100644
> index 0000000000000..6fab88203e7d3
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/memcg_async_reclaim.c

[ ... ]

> +static int setup_high_low_cgroups(u64 *high_cgroup_id, u64 *low_cgroup_i=
d)
> +{

[ ... ]

> +	ret =3D write_cgroup_file(CG_DIR, "memory.swap.max", "0");
> +	if (!ASSERT_OK(ret, "write_cgroup_file memory.swap.max"))
> +		goto cleanup;

[ ... ]

> +static int
> +run_high_low_workload(double *high_elapsed, double *low_elapsed, int rea=
d_times)
> +{
> +	char high_data_file[] =3D "/tmp/memcg_async_high_data_XXXXXX";
> +	char low_data_file[] =3D "/tmp/memcg_async_low_data_XXXXXX";

[Severity: Medium]
Will this test consistently fail with an OOM kill on systems where /tmp is
mounted as tmpfs?

Since the test explicitly disables swap via "memory.swap.max" =3D "0", any
tmpfs pages created by these workloads become completely unevictable. This
will cause the cgroup to hit its memory limit and OOM instead of triggering
reclaim.

Additionally, tmpfs pages are treated as anonymous memory rather than file
pages, so they will not generate the WORKINGSET_REFAULT_FILE events that the
BPF program relies on in get_cgroup_event().

Could these temporary files be created in a directory backed by a standard
filesystem, or could the test skip if /tmp is a tmpfs?

[ ... ]

> +	if (!ASSERT_GT(waitpid(low_pid, &status, 0), 0, "low waitpid"))
> +		goto cleanup;
> +	if (!ASSERT_TRUE(WIFEXITED(status), "low exited"))
> +		goto cleanup;
> +	if (!ASSERT_EQ(WEXITSTATUS(status), 0, "low exit status"))
> +		goto cleanup;
> +
> +	if (!ASSERT_GT(waitpid(high_pid, &status, 0), 0, "high waitpid"))
> +		goto cleanup;
> +	if (!ASSERT_TRUE(WIFEXITED(status), "high exited"))
> +		goto cleanup;
> +	if (!ASSERT_EQ(WEXITSTATUS(status), 0, "high exit status"))
> +		goto cleanup;
> +
> +	if (get_time(high_time_file, high_elapsed))
> +		goto cleanup;
> +	if (get_time(low_time_file, low_elapsed))
> +		goto cleanup;
> +
> +	ret =3D 0;
> +
> +cleanup:
> +	/* On failure, make sure no child process is left behind */
> +	if (ret) {
> +		if (high_pid > 0) {
> +			kill(high_pid, SIGKILL);
> +			(void)waitpid(high_pid, NULL, 0);
> +		}
> +		if (low_pid > 0) {
> +			kill(low_pid, SIGKILL);
> +			(void)waitpid(low_pid, NULL, 0);
> +		}
> +	}

[Severity: Medium]
Can this cleanup path race with PID reuse and send SIGKILL to unrelated
processes?

If the initial waitpid(low_pid, &status, 0) succeeds but a subsequent check
like ASSERT_EQ(WEXITSTATUS(status), 0, ...) fails, the code will jump to
cleanup. Because low_pid is still greater than 0, kill(low_pid, SIGKILL)
will be called.

Since waitpid() has already reaped the child process, the operating system
might have reused the PID for a new process by the time kill() is executed.
Because selftests often run as root, this would blindly terminate whatever
process happened to receive that PID.

Should the pid variables be set to -1 immediately after a successful
waitpid() to prevent them from being signaled during cleanup?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1787040082.gi=
t.zhuhui@kylinos.cn?part=3D2
