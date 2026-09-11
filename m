Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B085757EA;
	Fri, 11 Sep 2026 03:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789097857; cv=none; b=rKcUE9ECYlDVaEs+UYc29v77y1XEXCtPhiaeIdvTI1rjTQ+GFOnFkTJaVqfE/kyP2YWKvoO721y1loL6dWzEbXBtlnotP7DRx0gaaPZJnCeLTV9xni+pqn8EM0sqeO7yOvJFeGpryq04BU1v0idD31zymx8TGEUI0PxXsrAH1uQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789097857; c=relaxed/simple;
	bh=p0u8qKkj93CYxdnho7G5XW/+KK9xoVl7o1K95gsq2IQ=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=g1c0qRt2mnMC0zfd1ETBTmqiSzMWofYMMtwH9Bg7B2JDD6xMOEkPyMycRL3ZJRd04V4hB1RppVH38dz+kJJGcLpZfc+d6xbvXOhMQgKtyG3pBzIMvzqpgGmDWiKwO64dDlZje7A8eRVmXh5XLWAGw+PVKoSAxyyfTjusGTo57Rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aabIGn3s; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aabIGn3s"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D9DA1F00893;
	Fri, 11 Sep 2026 03:37:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789097855;
	bh=zUGypeBcGLiaFjJaHQWcw9fb92LvMNy8T3HOZfFpc2o=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=aabIGn3sTNJgdcXcH0u/LlRa6YVrCpEnbJTS6I2sRFrIVsQVYyiBImfZoy8Rikj30
	 oWogdgHb5oFhD+k/JU90n4DtyASVNHQM1K5eZpSt6stwwFsQ/apolKvzaKta+WCSZW
	 //F8h27sJuq255xJ/9c+SzzO6zkRYvFI0/YdYwDMIbIqjom2H/bRDnuHBAeZdk3qkj
	 gIirIzHZAo6y0DwnpbekKXzuHbuH0OCGrZxJeM+MjjFxvGXL2eI47HPXzFPDZ7jd6S
	 shjVdK9VE2lhx9VHuhxyI9OVZWHtUHGrvCjj8Jioabj/SisgXzTkPLboavmEZb/9OK
	 wMdgaxRRJOnuQ==
Content-Type: multipart/mixed; boundary="===============8717046814699199885=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <43836e91c05ebc17a327d26c28c018d8e09ed2dcaca6fd02b562e37a17a55dd4@mail.kernel.org>
In-Reply-To: <20260911025100.190706-3-diannaaav@gmail.com>
References: <20260911025100.190706-3-diannaaav@gmail.com>
Subject: Re: [PATCH bpf-next v4 2/2] selftests/bpf: Cover recursive bpftool map dumps
From: bot+bpf-ci@kernel.org
To: diannaaav@gmail.com,qmo@kernel.org,bpf@vger.kernel.org
Cc: andrii@kernel.org,eddyz87@gmail.com,ihor.solodrai@linux.dev,linux-kselftest@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Fri, 11 Sep 2026 03:37:35 +0000 (UTC)

--===============8717046814699199885==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/prog_tests/bpftool_map_dump.c b/tools/testing/selftests/bpf/prog_tests/bpftool_map_dump.c
> new file mode 100644
> index 000000000000..db547a68d0a2
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/bpftool_map_dump.c

[ ... ]

> +	/*
> +	 * Compare the complete JSON document: a flat array with the root first,
> +	 * one copy of the shared inner map, and unchanged entry representations.
> +	 */
> +	if (entries)
> +		snprintf(expected, sizeof(expected),
> +			 "[{\"id\":%u,\"type\":\"%s\",\"name\":\"dump_outer\","
> +			 "\"flags\":0,\"elements\":%s},{\"id\":%u,\"type\":\"hash\","
> +			 "\"name\":\"dump_inner\",\"flags\":0,\"elements\":%s}]",
> +			 root_id, type_name, outer, inner_id, inner);

This isn't a bug, but the map-object JSON template appears six times
across test_outer(), test_multiple_roots() and test_unreadable() - would
a small helper that formats one {"id":..,"elements":..} object keep them
from drifting apart?

[ ... ]

> +static void test_many_inner_maps(bool json)
> +{
> +	LIBBPF_OPTS(bpf_map_create_opts, opts);
> +	const struct rlimit limit = { .rlim_cur = 32, .rlim_max = 32 };
> +	char command[MAX_BPFTOOL_CMD_LEN], token[64];
> +	__u32 ids[64], root_id, key;
> +	int inner_fd = -1, outer_fd = -1, status;
> +	int inherited_fds[32], nr_inherited = 0, i;
> +	char *output = NULL;
> +	pid_t pid;

[ ... ]

> +	pid = fork();
> +	if (!ASSERT_GE(pid, 0, "fork"))
> +		goto out;
> +	if (!pid) {
> +		struct dirent *entry;
> +		DIR *dir;
> +
> +		/* Reserve a slot for the directory even if the parent is full. */
> +		close(inherited_fds[nr_inherited - 1]);
> +		dir = opendir("/proc/self/fd");
> +		if (!dir)
> +			_exit(6);
> +		/* The parent keeps the outer map and its inner maps alive. */
> +		for (;;) {
> +			char *end;
> +			long fd;
> +
> +			errno = 0;
> +			entry = readdir(dir);
> +			if (!entry) {
> +				if (errno)
> +					_exit(6);
> +				break;
> +			}
> +			fd = strtol(entry->d_name, &end, 10);
> +			if (*end || fd < 3 || fd == dirfd(dir))
> +				continue;
> +			close(fd);
> +		}
> +		if (closedir(dir))
> +			_exit(6);
> +		if (setrlimit(RLIMIT_NOFILE, &limit))
> +			_exit(1);
> +		snprintf(command, sizeof(command), "%s -r map dump id %u",
> +			 json ? "-j" : "", root_id);
> +		if (get_bpftool_command_output(command, output, 65535))
> +			_exit(2);
> +		if (count_token(output, json ? "\"id\":" : "Found ") != ARRAY_SIZE(ids) + 1 ||
> +		    count_token(output, json ? "\"inner_map_id\":" : "inner_map_id:") !=
> +		    ARRAY_SIZE(ids))
> +			_exit(3);
> +		for (key = 0; key < ARRAY_SIZE(ids); key++) {
> +			if (json)
> +				snprintf(token, sizeof(token), "\"id\":%u,", ids[key]);
> +			else
> +				snprintf(token, sizeof(token), "\n%u: hash  name dump_inner  ",
> +					 ids[key]);
> +			if (count_token(output, token) != 1)
> +				_exit(4);
> +		}
> +		if (json && (output[0] != '[' ||
> +			     strcmp(output + strlen(output) - 2, "]\n")))
> +			_exit(5);
> +		_exit(0);
> +	}

This isn't a bug, but would small named constants (or a one-line comment
table) for these exit codes make a CI failure easier to triage than the
bare numbers?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/34557170753
--===============8717046814699199885==--
