Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CF432652B2;
	Wed, 19 Aug 2026 07:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787123806; cv=none; b=mWSctlrW3J/SaKg+W/U7dg3EENWlfL9IhxktGNTCSPvt+LTAhH6n0JnIrpcQueO3ikCICvOGFaEEupxnnmQuernwq5Yru4Wc3Kicn3jC2/sGdrgCBfKQNIVRw/GR7Fsw9neCFcyhXjts3Y4guyxs7YMNn27cwte2ROJ9723wwyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787123806; c=relaxed/simple;
	bh=yEf8lgA2R0/KZuvFkeaqMmu/m8TvYAPwcJ09+R6AVqk=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=H2w2EjKQyuVsdciu3cOppZR3srjChcNlAg3PO58fij1CxingHx0b9eVCxpgy7Qv3iknmqqhXwYTce4ht1xzmZ+US73bOlFLLKztdAoG5VHm8B2XlJyoiTaue8MGXSIQiPyFG/xRrk9tukxBqtOFqk83GUQ0Lus8qL++WH7t481Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OUajSmkx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OUajSmkx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AA801F000E9;
	Wed, 19 Aug 2026 07:16:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787123805;
	bh=RR+5oC+JwEK6fu7HwCFjTcfa8i7lkxeot1UpnC7rJoo=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=OUajSmkxxgSJUvX0P3OusAk2BNV325fQGca5SN3s6/V96Ce7eVvnOpfFSlVJvY7gP
	 OLcbdjuecaEpIX33FG0TYzfccpcbsV0SvqQc5MWsmJp0uPnerx0TagmFMK9ymEnYiA
	 P09sk8Yo8t/5tpF28Wlzg7TG4P/q6i/GAweT6P4vZ6CsPHMmtO/cNaaSinWR6j8ssD
	 HTsJ/JlwyRikT9jGp7qo871NF8cVqf7euQ+s4rzjU1XLmlV4G/guYGXoemlvLEcPAm
	 VeyDGQ1E3bMml5Vs6ILfRTTw7ikvwENUI5AvsezA1RfyjNQxaJ2MpGt5DZGwpSXP0s
	 IKr9uYWiZdpfA==
Content-Type: multipart/mixed; boundary="===============9008457374577010211=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <1a9245ed6391fb99efab25910fda1e140d54305c58a2ffbaebb785010c0a9f26@mail.kernel.org>
In-Reply-To: <052d445fe9d7741729447f1b90277dcdc6541b4f.1787120833.git.zhuhui@kylinos.cn>
References: <052d445fe9d7741729447f1b90277dcdc6541b4f.1787120833.git.zhuhui@kylinos.cn>
Subject: Re: [PATCH bpf-next v3 2/2] selftests/bpf: add memcg async reclaim test
From: bot+bpf-ci@kernel.org
To: hui.zhu@linux.dev,roman.gushchin@linux.dev,inwardvessel@gmail.com,shakeel.butt@linux.dev,akpm@linux-foundation.org,andrii@kernel.org,eddyz87@gmail.com,ihor.solodrai@linux.dev,ast@kernel.org,daniel@iogearbox.net,memxor@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,shuah@kernel.org,baohua@kernel.org,geliang@kernel.org,linux-kernel@vger.kernel.org,bpf@vger.kernel.org,linux-mm@kvack.org,linux-kselftest@vger.kernel.org
Cc: zhuhui@kylinos.cn,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Wed, 19 Aug 2026 07:16:44 +0000 (UTC)

--===============9008457374577010211==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/prog_tests/memcg_async_reclaim.c b/tools/testing/selftests/bpf/prog_tests/memcg_async_reclaim.c
> new file mode 100644
> index 000000000000..e990d1fdc79f
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/memcg_async_reclaim.c

[ ... ]

> +static int
> +run_high_low_workload(double *high_elapsed, double *low_elapsed, int read_times)
> +{
> +	char high_data_file[PATH_MAX];
> +	char low_data_file[PATH_MAX];
> +	char high_time_file[PATH_MAX];
> +	char low_time_file[PATH_MAX];
> +	const char *dir = workload_files_dir();
> +	pid_t high_pid = -1, low_pid = -1;
> +	int fd, status;
> +	int ret = -1;

[ ... ]

> +	low_pid = fork();
> +	if (!ASSERT_GE(low_pid, 0, "fork low"))
> +		goto cleanup;
> +	if (low_pid == 0)
> +		exit(real_test_child_work(CG_LOW_DIR, low_data_file,
> +					  low_time_file, read_times));
> +
> +	high_pid = fork();
> +	if (!ASSERT_GE(high_pid, 0, "fork high"))
> +		goto cleanup;
> +	if (high_pid == 0)
> +		exit(real_test_child_work(CG_HIGH_DIR, high_data_file,
> +					  high_time_file, read_times));

Should these forked children use _exit() rather than exit()?

exit() runs atexit handlers and flushes every stdio stream the child
inherited from test_progs, including whatever the parent had buffered but
not yet written at the moment of the fork. Where the buffer is a real file
descriptor this duplicates the parent's pending output once per child.

The hijack body in test_progs.c is inside #ifdef __GLIBC__, so on a
non-glibc build stdout is never hijacked at all. Also, stdio_hijack_init()
is skipped when running with verbose output:

  if (verbose() && env.worker_id == -1)
          return;   /* output to stdout by default */

So `./test_progs -v > log` (fully buffered pipe/file, no -j) and any
musl-based build get duplicated log fragments plus the child's own printf.

Other forking tests in this directory already use _exit():
prog_tests/bpf_iter.c, prog_tests/exhandler.c, prog_tests/cpumask.c,
prog_tests/task_kfunc.c, prog_tests/deny_namespace.c, and
prog_tests/uprobe_syscall.c.

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/32224943030
--===============9008457374577010211==--
