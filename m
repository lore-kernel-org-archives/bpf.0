Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9397F35C1BC;
	Sat, 17 Oct 2026 15:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792249386; cv=none; b=ekqdTwh40x0Z/GhrGoR6J+1NiBgVe+DIsv0omXuECSSVfAYvDF+6QbO3U7SrOQZuCOkLWLRqsFYIWVqhA1migSjwmPNj3zK9RDaRyZ1upHFBHTiCvskZcaDPEiqON/LBiwUaigPwGwnr1kqQBOQrtIdDTuoBnPJ7jUCQiiY91u4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792249386; c=relaxed/simple;
	bh=o0jdAayoX0qlxTlKLj/KWkChND2PeYq/Orw9Z9KauQE=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=PlRuc8+UlOUc5lUR19Y7bY7EXmSNAjvO/X3YF8QNce3rVHMpWCu2TBAhXkPucf/MqrFX524BhnkphfiuMCvX5WgfLRt7lq07HkqjCaDrKsm9ujVDX3+rzB5fcRky3Hdaf3inamv/8MZuk+aZ77TnjFkNS14uhaRhiSbcKwK9buM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ePvslCRc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ePvslCRc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0FBE1F000C4;
	Sat, 17 Oct 2026 15:02:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792249381;
	bh=npyDh5o9SCNa2ofQnCG6GSCcXQwetOEjM8/DM/CmWz0=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=ePvslCRc4PbnpDF0hbuw5HmkA80tFR8LL2L/hmabcXQqqvCyP1/EXWl7tN87SI6Bc
	 Xgu5LNLHZwOX7t+MUwlzMSj/ooC5nqaxll5/ZJjKPT2dyugD8WCaV5O29iNOJFGAmK
	 VuEzPRugA0TPymd7CUYzNbArsJrPQNL+E6A+ZfrHLeecH3Ut2aSYIspHdCqCYg9h3k
	 ZYvc7CmhF9jh0nhdH0Z9j09fxSNmbNYDYxKUUofS7Tz9zCt8LTok3YsXUzr3oISJKV
	 wH3dXhV7f6+nFnoHyy+EkLSI5JzUCRAmevQWX9nbm1Z2HExS5G0KxJJzwINvuZMfGw
	 s0I2n8x18yLcQ==
Content-Type: multipart/mixed; boundary="===============5666084559664282283=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <343fe8b9f06af37dde193869b694dbf908b0a0f6592a1e4cc5f5a0ac295b1b88@mail.kernel.org>
In-Reply-To: <20261017142649.51047-7-leon.hwang@linux.dev>
References: <20261017142649.51047-7-leon.hwang@linux.dev>
Subject: Re: [PATCH bpf-next 6/6] selftests/bpf: Add tests to verify link_create logs
From: bot+bpf-ci@kernel.org
To: leon.hwang@linux.dev,bpf@vger.kernel.org
Cc: andrew+netdev@lunn.ch,davem@davemloft.net,edumazet@kernel.org,kuba@kernel.org,pabeni@redhat.com,horms@kernel.org,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,ihor.solodrai@linux.dev,hawk@kernel.org,john.fastabend@gmail.com,sdf@fomichev.me,rostedt@goodmis.org,mhiramat@kernel.org,mathieu.desnoyers@efficios.com,shuah@kernel.org,kuniyu@google.com,liuhangbin@gmail.com,mkarsten@uwaterloo.ca,masashi.honma@gmail.com,linux-kernel@vger.kernel.org,netdev@vger.kernel.org,linux-trace-kernel@vger.kernel.org,linux-kselftest@vger.kernel.org,leon.hwang@linux.dev,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Sat, 17 Oct 2026 15:02:57 +0000 (UTC)

--===============5666084559664282283==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> selftests/bpf: Add tests to verify link_create logs

TL;DR: Nits only, in the new link_create log selftests in xdp_link.c: the four
subtests repeat the same setup and assertions and could share a helper, and
one has a redundant true_size = 0.

> diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_link.c b/tools/testing/selftests/bpf/prog_tests/xdp_link.c
> --- a/tools/testing/selftests/bpf/prog_tests/xdp_link.c
> +++ b/tools/testing/selftests/bpf/prog_tests/xdp_link.c

[ ... ]

> @@ -150,3 +150,135 @@ void serial_test_xdp_link(void)
>  	test_xdp_link__destroy(skel1);
>  	test_xdp_link__destroy(skel2);
>  }
> +
> +static void test_link_create_invalid_prog_fd(void)
> +{
> +	const char *msg = "Invalid prog_fd.\n";
> +	char log_buf[128] = {};
> +	int fd;
> +	LIBBPF_OPTS(bpf_log_opts, log_opts,
> +		    .buf = log_buf,
> +		    .size = sizeof(log_buf),
> +		    .level = 1,
> +	);
> +
> +	fd = bpf_link_create_log(-1, IFINDEX_LO, BPF_XDP, NULL, &log_opts);
> +	if (!ASSERT_LT(fd, 0, "bpf_link_create_log")) {
> +		close(fd);
> +		return;
> +	}
> +
> +	ASSERT_EQ(fd, -EBADF, "fd");
> +	ASSERT_STREQ(log_buf, msg, "log_buf");
> +	ASSERT_EQ(log_opts.true_size, strlen(msg) + 1, "log_size");
> +}

This isn't a bug, but the four new test_link_create_*() functions repeat the
same log_buf and LIBBPF_OPTS(bpf_log_opts, ...) setup, and the same trailing
ASSERT_EQ(fd, ...) / ASSERT_STREQ(log_buf, msg) /
ASSERT_EQ(log_opts.true_size, strlen(msg) + 1) sequence.  They differ only in
prog fd, target, attach type, expected errno and message.

This looks close to test_map_create() in map_init.c.  Could the four
link_create log tests share a small helper that takes the prog fd, target,
attach type, opts, expected errno and message?

> +
> +static void test_link_create_invalid_attach_type(void)
> +{
> +	const char *msg = "Invalid attach_type.\n";
> +	struct test_xdp_link *skel;
> +	char log_buf[128] = {};
> +	int fd;
> +	LIBBPF_OPTS(bpf_log_opts, log_opts,
> +		    .buf = log_buf,
> +		    .size = sizeof(log_buf),
> +		    .level = 1,
> +	);
> +
> +	skel = test_xdp_link__open_and_load();
> +	if (!ASSERT_OK_PTR(skel, "test_xdp_link__open_and_load"))
> +		return;
> +
> +	log_opts.true_size = 0;

This isn't a bug, but is the log_opts.true_size = 0; line needed here?
LIBBPF_OPTS() already zero-initializes log_opts, true_size is only written by
libbpf after the syscall, and the other three tests omit this line.

> +	fd = bpf_link_create_log(bpf_program__fd(skel->progs.xdp_handler), IFINDEX_LO,
> +				 BPF_CGROUP_INET_INGRESS, NULL, &log_opts);

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/39042048581
--===============5666084559664282283==--
