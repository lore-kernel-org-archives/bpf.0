Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C5091B4138
	for <bpf@vger.kernel.org>; Thu, 20 Aug 2026 06:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787206938; cv=none; b=uRzeuKzz3LD3+kdXCLXeq0v3dC1RTwvkv4zwB8w7BG56U8chleJcCtCkm+vkwWFj4iRCV2YaFcuXR8q5cauA+ZS+saOE34kQwM7pUT9FiDS+eccxFdTBYvh9skzGx4u2tvhoeVlmNDnRdhSPLm9A8zRuf8EqE3vzXU+wY0tRQYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787206938; c=relaxed/simple;
	bh=zej7AhaCx27LT3x0lQqLVhqMQmChzwx+e3W+dqrBbr4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=gqxkWeHcApcsU+rc3V8e4jqcnXs+jclpHwpNOMiVVdZDuLypploTsG1HhFmMZqyZyLPPk7d+PFglAn/4DnxV+5rsOiy4dEB+wED48qCGViQaxPMfn5GLei8Elqmbqk+BORptHclqvI/watck/1EZ725T+9fNMW+E7+sqBCEgQG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=akvBXVCY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="akvBXVCY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA0BC1F00A3A;
	Thu, 20 Aug 2026 06:22:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787206936;
	bh=UYEyd4KgNJtPkvJXiX8HnpRlUGLYZgXt9pKErghR2HE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=akvBXVCYDSOlATisqbHxFBpyuxCQgkJ8ZYhzRU4lsJ05mxkhdW5CpmaIuZDOCAFRn
	 ez6FTgZhxYVZWEH1yrFt8CdUbLc3HCN+DQTiaFk7XtFXI1Q/E1HygtZ6XxbB5hfNIk
	 Bhb3MPDf2w8eUAIlS5bqgrJ8jhQpKEMEJGrDB9n5XzzrMY6lkHYNbIu3FDLgjCzufk
	 QB3jiI+Voa6PiHbFyQh8w5W5eSM17btpT9mK18oJqXvl+e8GMgE5di3jOoNCPpxO9/
	 7p7/JZfI/nttj+nC09eoj2fI2UNqPii447uyzknZCVsr5TrD/YhGWxEbWCIeoQKQxi
	 EevfYltwcmwjA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v4 2/2] selftests/bpf: add memcg async reclaim
 test
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hui Zhu" <hui.zhu@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <53762e3403fe8e8c263cf685cea5d55377ec5204.1787205002.git.zhuhui@kylinos.cn>
References: <cover.1787205002.git.zhuhui@kylinos.cn>
 <53762e3403fe8e8c263cf685cea5d55377ec5204.1787205002.git.zhuhui@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 20 Aug 2026 06:22:16 +0000
Message-Id: <20260820062216.AA0BC1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Insecure temporary file creation pattern leading to a TOCTOU rac=
e condition.
--

--- Patch [2]: [PATCH bpf-next v4 2/2] selftests/bpf: add memcg async recla=
im test ---
commit 690f8d9075834023b364e130547a2026753c92e6
Author: Hui Zhu <zhuhui@kylinos.cn>

selftests/bpf: add memcg async reclaim test

Add memcg_async_reclaim selftest that verifies BPF-driven async
proactive reclaim can mitigate refault-induced slowdown under memory
pressure.

> diff --git a/tools/testing/selftests/bpf/prog_tests/memcg_async_reclaim.c=
 b/tools/testing/selftests/bpf/prog_tests/memcg_async_reclaim.c
> new file mode 100644
> index 0000000000000..ece7bceaab3c4
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/memcg_async_reclaim.c

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

[ ... ]

> +	fd =3D mkstemp(high_data_file);
> +	if (!ASSERT_GE(fd, 0, "mkstemp"))
> +		goto cleanup;
> +	close(fd);

[Severity: Medium]
Is this temporary file creation vulnerable to a time-of-check to time-of-use
race condition?

By immediately closing the file descriptor securely created by mkstemp()
and reopening it by name later in write_file():

write_file() {
	fp =3D fopen(filename, "wb");
}

Could this allow a symlink attack in the window between the close and the
open if the file is replaced?

While selftests run in a controlled environment, this pattern is frequently
flagged as a security anti-pattern by static analysis tools.

Would it be possible to pass the file descriptor directly to the child
process instead of closing it, or use exclusive creation flags when
reopening?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1787205002.gi=
t.zhuhui@kylinos.cn?part=3D2
