Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B43B3C4545
	for <bpf@vger.kernel.org>; Wed, 17 Jun 2026 09:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781689539; cv=none; b=R5EBpiw6MGhDcw51Cx0uAhJgrGpljuZSQaWQA3A04tgdj87TeSxZa21N404ahN+/g/pL3+AcH1qkcxwNwhPzxuxAd4CVGmrmqXhmBebgjMkeUQgiRYzcrvXyfplF6/BtvJh7/eRiKzXzPGjCQWON9Qt4EADS6uuW8ByQq/NRS5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781689539; c=relaxed/simple;
	bh=MicREHmOGFaL/o66xLNzbDDWGUe5t+NGwdkozT9+Z/w=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=b77MdbsZwxT9FMmd17TLGKvLJvm8XUbdE9xCQ6ryAW+bJuxN0US2vrwTEud7fIh9Ew1i3OFKqhBZl3MQUngsiJEvD19GTNlezSgTeP8NIMA4EK2yEPsCnZw6EnL3K7F1WPh4WseBKLPs7UwnNP1o+K/wQ6AJKfUaTYV8l7KTDAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EBozsrzq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EBozsrzq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1EEF1F000E9;
	Wed, 17 Jun 2026 09:45:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781689538;
	bh=FXjJsP6xWf03P95+CtLkthSuF8tBDA30OXw30ealebc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EBozsrzqh7EpTrg3LdzRYjY0bnVmOmK/eXK4+CgZZ0t79V60ZcCNWmdY9sodcaJRI
	 F6hBnzT9q2ru6ao2FdSLmYqqJTL7JVo6WHeqiM3es/tcb19J8jLuCKO66niq4z8+UV
	 0YIguJHJ9dwGzSIVgQft7j5fVS2blbTfRKMxcQbH3BxGy+2RMttleNXv2zTBcZlekq
	 /aEELRNMabc6EHWzqYrPvXl+KBKb4FN/nssoSpuYZrgOkalkv6vqepH1z2DcLD5krA
	 +xFoGQDEa0jLZItZlY0cAq3eI085jgrhLPH7pVhBbSgpXS5nVArATatauMT/OZmz54
	 feVvzAbOioLmQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf v3 2/2] selftests/bpf: Cover partial copy of
 non-linear test_run output
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sun Jian" <sun.jian.kdev@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260617093557.63880-3-sun.jian.kdev@gmail.com>
References: <20260617093557.63880-1-sun.jian.kdev@gmail.com>
 <20260617093557.63880-3-sun.jian.kdev@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 17 Jun 2026 09:45:37 +0000
Message-Id: <20260617094537.D1EEF1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Uninitialized stack buffer `out` is read if the BPF test run fai=
ls.
--

commit f204128d45018a80c7b9b142c6d9a253204b22bd
Author: Sun Jian <sun.jian.kdev@gmail.com>

selftests/bpf: Cover partial copy of non-linear test_run output
   =20
This commit adds selftest coverage for partial copies of non-linear test_run
output for TC and XDP programs. It verifies that test_run returns -ENOSPC,
reports the full packet length, and copies the packet prefix into the
provided buffer.

> diff --git a/tools/testing/selftests/bpf/prog_tests/prog_run_opts.c b/too=
ls/testing/selftests/bpf/prog_tests/prog_run_opts.c
> index 01f1d1b6715a6..9cc898e6a9f71 100644
> --- a/tools/testing/selftests/bpf/prog_tests/prog_run_opts.c
> +++ b/tools/testing/selftests/bpf/prog_tests/prog_run_opts.c
[ ... ]
> @@ -20,6 +24,69 @@ static void check_run_cnt(int prog_fd, __u64 run_cnt)
>  	      "incorrect number of repetitions, want %llu have %llu\n", run_cnt=
, info.run_cnt);
>  }
> =20
> +static void init_pkt(__u8 *pkt, size_t len)
> +{
> +	size_t i;
> +
> +	for (i =3D 0; i < len; i++)
> +		pkt[i] =3D i & 0xff;
> +}
> +
> +static void test_skb_nonlinear_data_out_partial(struct test_pkt_access *=
skel)
> +{
> +	LIBBPF_OPTS(bpf_test_run_opts, topts);
> +	__u8 pkt[NONLINEAR_PKT_LEN];
> +	__u8 out[SHORT_OUT_LEN];

[Severity: Medium]
Should out[] be explicitly zero-initialized?

If bpf_prog_test_run_opts() fails with an unexpected error and doesn't write
to the userspace buffer, the ASSERT_EQ macros below won't abort the test.
This means the subsequent ASSERT_OK(memcmp(...)) call will read uninitializ=
ed
stack memory, which can trigger undefined behavior and Memory Sanitizer (MS=
AN)
warnings.

> +	struct __sk_buff skb =3D {};
> +	int prog_fd, err;
> +
[ ... ]
> +	prog_fd =3D bpf_program__fd(skel->progs.tc_pass_prog);
> +	err =3D bpf_prog_test_run_opts(prog_fd, &topts);
> +
> +	ASSERT_EQ(err, -ENOSPC, "skb_nonlinear_partial_err");
> +	ASSERT_EQ(topts.data_size_out, sizeof(pkt), "skb_nonlinear_partial_data=
_size_out");
> +	ASSERT_OK(memcmp(out, pkt, sizeof(out)), "skb_nonlinear_partial_data_ou=
t");
> +}
> +
> +static void test_xdp_nonlinear_data_out_partial(struct test_pkt_access *=
skel)
> +{
> +	LIBBPF_OPTS(bpf_test_run_opts, topts);
> +	__u8 pkt[NONLINEAR_PKT_LEN];
> +	__u8 out[SHORT_OUT_LEN];

[Severity: Medium]
Could we also zero-initialize this buffer for the same reason?

> +	struct xdp_md ctx =3D {};
> +	int prog_fd, err;
> +
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260617093557.6388=
0-1-sun.jian.kdev@gmail.com?part=3D2
