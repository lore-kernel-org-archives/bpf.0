Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794669383;
	b=ZnybrMj4yQ7QTsE7Q/Wp/aPN+bl7/80n9s5d81XIkU0hpUpTkO1E82+O/zVlW+Otf3IG
	 NPFYx4QjAEbMUq+6lJLCT4c9jJ6843cm2OQqvDLGcqQmjG52RasQCvIZZqyCTs1xGl5mb
	 rTKcBaYIBbox7whqfLZmK2iukovpRUQqO4AncvyBbhaPjK22aTgS0y3GxoPzEJmGG5Raa
	 9UHm1HjG4hK6xQYuS5u9T0rW7WgE+Y82CxNy2rizqiQWdxJPavWH7oD/VynMqCDzB2jrC
	 gw4hOATZg4SXxfFf6RgRuS4kkiUYQNv1jsD6EW2B4DO/JmzNg0zlAYLkfDt+9M/uQ6A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794669383;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=VjWmBtYyazk941niW0WfO0QeQek4sh6E9BJ4GXuizuI=;
	b=nfNsAXr7n61hPok2MEaYv7TMyAYITZjEEh6up2zK5Xxi+WK4zm1MTaXKG6VLP3cq8Tx3
	 bu6NSGl9XuDCzOD2yVeWETs3Eob/GjjoRoLrMZKfXdl9fVq34W+bxOfcztiJs7t7qvZhh
	 AiAb/ox540yp+62H6cUIXG0f5whNoEQLCzYqA8d0M6H1q6q7lYirtRRNdVoSM2FuhZIaY
	 4v4737rcvKMmVPBOsS67JFjTJopWCaOVvemAd1m0I2XLlOLXEJFlfQ0I4a4tJcHrfpJsW
	 Fjq+Anx4Bvx77SaY8FERfdBCDX3EdwON8hgXMuyDM1eD2RC++XB8B7SIouNO6pq5AVA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=glfmM9yL;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2E8D606A329;
	Sat, 14 Nov 2026 15:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=glfmM9yL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42FE31F000C4;
	Sat, 14 Nov 2026 15:16:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794669383;
	bh=VjWmBtYyazk941niW0WfO0QeQek4sh6E9BJ4GXuizuI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=glfmM9yL62bdxgZ6ErZZgMlH8eyxWgtl25BsiTH1o1L26DmOmVnQNhZ514vZc5BLE
	 ruKaMyJil552m49eG1mzkjQxW5lPaxXXwcgn10lqtidCRBssjZ41mYGfvmxKNtBLUx
	 jPylivwiNUvCHxhwlWpRmR1msbWh+7m5H8KMlqZDA0Oq4PIDpd51PIHHo+/FqwOvsU
	 Rt7Hs3NMcYrPjsJfhBmbUd+TPD5uYjFC8itF/76DS7x03MgmdIioOZDLu+WREEI7a/
	 P+8yMZXRqq4CDxPw2LfVtSyGM3T/DHsKdDQUugO+jTcnmnXiCKQU7oPzNkGfZYgjHJ
	 YBJOkItFu4fNw==
Message-ID: <sashiko-outbox-214682@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v2 8/9] selftests/bpf: Verify iter link_create
 logs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Leon Hwang" <leon.hwang@linux.dev>, bpf@vger.kernel.org
Cc: linux-trace-kernel@vger.kernel.org
In-Reply-To: <20261114150610.84507-9-leon.hwang@linux.dev>
References: <20261114150610.84507-1-leon.hwang@linux.dev>
 <20261114150610.84507-9-leon.hwang@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 14 Nov 2026 15:16:22 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] selftests/bpf: swapped iter_info and iter_info_len subtest names
--

commit 05954811719a2e7df15c96088c216104e09ba282
Author: Leon Hwang <leon.hwang@linux.dev>

selftests/bpf: Verify iter link_create logs

This commit adds selftests verifying the error codes, log messages, and
reported log sizes for invalid bpf_link_create() iterator arguments and
programs.

> diff --git a/tools/testing/selftests/bpf/prog_tests/iter_link.c b/tools/t=
esting/selftests/bpf/prog_tests/iter_link.c
> new file mode 100644
> index 0000000000000..623a84ba612d5
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/iter_link.c

[ ... ]

> +static void test_log_invalid_iter_info(void)
> +{
> +	unsigned char info[sizeof(union bpf_iter_link_info) + 1] =3D {};
> +	const char *msg =3D "Invalid iter_info_len.\n";
> +	struct bpf_iter_bpf_map *skel;
> +	struct bpf_link *link;
> +	char log_buf[128] =3D {};
> +	LIBBPF_OPTS(bpf_log_opts, log_opts,
> +		    .buf =3D log_buf,
> +		    .size =3D sizeof(log_buf),
> +		    .level =3D 1,
> +	);
> +	LIBBPF_OPTS(bpf_iter_attach_opts, opts,
> +		    .link_info =3D (union bpf_iter_link_info *)info,
> +		    .link_info_len =3D sizeof(info),
> +		    .log_opts =3D &log_opts,
> +	);
> +
> +	skel =3D bpf_iter_bpf_map__open_and_load();
> +	if (!ASSERT_OK_PTR(skel, "bpf_iter_bpf_map__open_and_load"))
> +		return;
> +
> +	info[sizeof(info) - 1] =3D 1;
> +	link =3D bpf_program__attach_iter(skel->progs.dump_bpf_map, &opts);
> +	if (!ASSERT_ERR_PTR(link, "bpf_program__attach_iter")) {
> +		bpf_link__destroy(link);
> +		goto out;
> +	}
> +
> +	ASSERT_EQ(libbpf_get_error(link), -E2BIG, "err");
> +	ASSERT_STREQ(log_buf, msg, "log_buf");
> +	ASSERT_EQ(log_opts.true_size, strlen(msg) + 1, "log_size");
> +
> +out:
> +	bpf_iter_bpf_map__destroy(skel);
> +}
> +
> +static void test_log_invalid_iter_info_len(void)
> +{
> +	const char *msg =3D "Invalid iter_info.\n";
> +	LIBBPF_OPTS(bpf_link_create_opts, opts,
> +		    .iter.info =3D (union bpf_iter_link_info *)1,
> +		    .iter.len =3D sizeof(union bpf_iter_link_info),
> +	);
> +
> +	test_iter_link_create_log(0, &opts, 0, -EFAULT, msg);
> +}
> +
> +static void test_log_invalid_prog(void)
> +{
> +	const char *msg =3D "The iter target does not support the bpf prog.\n";
> +	LIBBPF_OPTS(bpf_link_create_opts, opts);
> +
> +	test_iter_link_create_log(0, &opts, BPF_F_SLEEPABLE, -EINVAL, msg);
> +}
> +
> +void test_iter_link_log(void)
> +{
> +	if (test__start_subtest("invalid_target_fd"))
> +		test_log_invalid_target_fd();
> +	if (test__start_subtest("invalid_flags"))
> +		test_log_invalid_flags();
> +	if (test__start_subtest("iter_info_only"))
> +		test_log_iter_info_only();
> +	if (test__start_subtest("iter_info_len_only"))
> +		test_log_iter_info_len_only();
> +	if (test__start_subtest("invalid_iter_info"))
> +		test_log_invalid_iter_info();
> +	if (test__start_subtest("invalid_iter_info_len"))
> +		test_log_invalid_iter_info_len();

[Severity: Low]
Are the function and subtest names for test_log_invalid_iter_info() and
test_log_invalid_iter_info_len() swapped?

test_log_invalid_iter_info() passes an oversized link_info_len with a
non-zero trailing byte and checks for -E2BIG ("Invalid iter_info_len."),
whereas test_log_invalid_iter_info_len() passes a bad iter.info pointer
and checks for -EFAULT ("Invalid iter_info.").  If either subtest fails,
the reported subtest name will point to the opposite check.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261114150610.8450=
7-1-leon.hwang@linux.dev?part=3D8
