Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE8FC41F5CC
	for <bpf@vger.kernel.org>; Thu, 27 Aug 2026 10:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787827594; cv=none; b=ic6ncs0SBm1YzxhmKgFduZ2Y7Haf3EX1t1JVG4zA1aPa8UK2wGGpCq0CyBLV8iU5R0/P2lpiJYqkRRdPZhwLyUu3gUcDIHy0v9PYTvJIeYqlXc6sx/QPeslJ2BBwUd6MICZtP/biLD8ofQE1yuwWS0C0FrsOcet0nePWKWxNPvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787827594; c=relaxed/simple;
	bh=5U/P7pc3PDgAsfW8ILVURd0BGmPxRRVwMqvU8l3riHk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=EFlMTtALpf2pzOny70wwYKkp6U8RvmHEa18TMAsYHBxudkhTkEv7/ORHQn0mnR0xw2mJNy+dpSHqKHyIHEgRDecKJTr2p3tH+gfxxP2K26hAzZglBZDh6inCjSxDTsXAXm5MWHfw8uQ7X4vgB7hulzLX+JIWmBg0J13Q4Ak+j34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aMD9HCuk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aMD9HCuk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2695A1F000E9;
	Thu, 27 Aug 2026 10:46:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787827592;
	bh=3XQ5DR29OPv2M6KqhSGYbxG5PqEUO7bmzDqQZY9Fd1U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=aMD9HCukhAl1HmF3jJ9fHXCmypcL536f4gCiEcm0jYfJ+oOIrVlTc5HvzvIlU98lw
	 sGw33A7EnSEFPDZzfCJwJzpEgCRFIk7vLNlIE6O2bzMjxb6FGACMdkpPLFvS3tUlpZ
	 pvkTGiS08M3d1iOqvi7VCZl3EyUoYJ/My9AylhcRB68LkPUVSkrUS5Mqw1JGpRtd9X
	 9cEL7Lf3fAJFmHmmxJuNM5FPATQEdhsUtLBSZCY9iAzA2LNE5AX7STtAH49B8KFScx
	 pSRL7/gdEAqhPkf/GGo+t4ioJmoAiol3Iz56jFo060mTr2PKDx/wfgDki1IzmYM2Ms
	 QKas8eZWub/vQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v5 2/2] selftests/bpf: Add memcg async reclaim
 test
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hui Zhu" <hui.zhu@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <eec9160b702fd6d65631a34f0945230e0845d12b.1787826402.git.zhuhui@kylinos.cn>
References: <cover.1787826402.git.zhuhui@kylinos.cn>
 <eec9160b702fd6d65631a34f0945230e0845d12b.1787826402.git.zhuhui@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 27 Aug 2026 10:46:31 +0000
Message-Id: <20260827104632.2695A1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [Medium] Insecure temporary file creation (Time-of-Check to Time-of-Use s=
ymlink attack)

Pre-existing issues:
- [High] Missing negative bounds check for enum in BPF memory controller kf=
uncs
--

commit d790568f8e67742a221eaf1bb57e732d1d035f32
Author: Hui Zhu <zhuhui@kylinos.cn>
selftests/bpf: Add memcg async reclaim test

This commit adds the memcg_async_reclaim selftest to verify that
BPF-driven async proactive reclaim mitigates refault-induced slowdown
under memory pressure.

[Severity: High]
This is a pre-existing issue, but there is a missing negative bounds check
for enum arguments in the BPF memory controller kfuncs.

In mm/bpf_memcontrol.c:bpf_mem_cgroup_memory_events():

    if (unlikely(event >=3D MEMCG_NR_MEMORY_EVENTS))
        return (unsigned long)-1;

And similarly in mm/memcontrol.c:memcg_vm_event_item_valid():

    if (idx >=3D NR_VM_EVENT_ITEMS)
        return false;

Because enum types in C are signed integers, these signed comparisons allow
negative values to bypass the bounds check. A BPF program calling these
kfuncs with a negative integer value can bypass the check, leading directly
to an out-of-bounds kernel memory read. Since the BPF verifier permits this
(the enum parameter is not constrained by __const), could this allow
information disclosure for users with CAP_BPF?

> diff --git a/tools/testing/selftests/bpf/prog_tests/memcg_async_reclaim.c=
 b/tools/testing/selftests/bpf/prog_tests/memcg_async_reclaim.c
> new file mode 100644
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/memcg_async_reclaim.c
[ ... ]
> +static int write_file(const char *filename)
> +{
> +	int ret =3D -1;
> +	size_t written =3D 0;
> +	char *buffer;
> +	FILE *fp;
> +
> +	fp =3D fopen(filename, "wb");
> +	if (!fp)
> +		goto out;
[ ... ]
> +static int
> +run_high_low_workload(double *high_elapsed, double *low_elapsed, int rea=
d_times)
> +{
> +	char high_data_file[PATH_MAX];
> +	char low_data_file[PATH_MAX];
> +	char high_time_file[PATH_MAX];
> +	char low_time_file[PATH_MAX];
> +	const char *dir =3D workload_files_dir();
> +	pid_t high_pid =3D -1, low_pid =3D -1;
> +	pid_t wait_ret;
> +	int fd, status;
> +	int ret =3D -1;
> +
> +	snprintf(high_data_file, sizeof(high_data_file),
> +		 "%s/memcg_async_high_data_XXXXXX", dir);
> +	snprintf(low_data_file, sizeof(low_data_file),
> +		 "%s/memcg_async_low_data_XXXXXX", dir);
> +	snprintf(high_time_file, sizeof(high_time_file),
> +		 "%s/memcg_async_high_time_XXXXXX", dir);
> +	snprintf(low_time_file, sizeof(low_time_file),
> +		 "%s/memcg_async_low_time_XXXXXX", dir);
> +
> +	fd =3D mkstemp(high_data_file);
> +	if (!ASSERT_GE(fd, 0, "mkstemp"))
> +		goto cleanup;
> +	close(fd);

[Severity: Medium]
Is there a potential Time-of-Check to Time-of-Use (TOCTOU) symlink
vulnerability here?=20

The test uses mkstemp() to securely create temporary files, but immediately
closes the file descriptor. Later, the child process opens the file by name
in write_file() using fopen(filename, "wb").

If the test is run in a shared temporary directory (like /tmp), could a loc=
al
attacker replace the temporary file with a symlink to another file on the
system during the window between close() and fopen()? Since the test process
typically runs as root, this would follow the symlink and overwrite the
target file.

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1787826402.gi=
t.zhuhui@kylinos.cn?part=3D2
