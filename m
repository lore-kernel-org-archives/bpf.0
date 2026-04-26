Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2335A3009D4
	for <bpf@vger.kernel.org>; Sun, 26 Apr 2026 21:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777239502; cv=none; b=GlU09Xf7FYiSA2u1sqhs4yThiDMHWc0AnzsW/bI/+/nY9pouZ4+otYrAg8DB/V/KQD5u1hFTpM5C+7NbUgriCvkfl0P5Zr7dIuc+IoUPj/5mYt3Pg6N3djage9yFNAXWpq0vcKafkmOOSmNgdZqsEPNMW5OCWSK6Kz60/XvZlRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777239502; c=relaxed/simple;
	bh=0mq+9aeKezv0obNe1iY9IgFmWfrXsCMqnbQHR0A5qgA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jJzMFkjK3YVLip7M5z1kkTSBy5ZGyhlfffRSNiJzGnzHxHCY4UBkAIbLHJ47DTIt7yMXMUWfUhi/dmaNKnl8EgkyKnaH7KxR+nufwcWizrVmUxifgQaYM42iwbtVA1iy37CO0gj4JK9Q1hK2TH4f0NQTgxhF61VTrrAt5L0Sxy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bYeR3gv0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bYeR3gv0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA8F3C2BCAF;
	Sun, 26 Apr 2026 21:38:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777239501;
	bh=0mq+9aeKezv0obNe1iY9IgFmWfrXsCMqnbQHR0A5qgA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=bYeR3gv0ykNKHJPIj3QLTJim2szUAJbeRS9aYQBpJuHFN5UUX0f7X632ZLZ5mvQid
	 BaNuFsZXTm+9/gV18j1QqXs3wossP3tDKRbpS4MDZOswRftgjNYJH8lavxRh/irFGr
	 qAjKzbtyjbwSWQNzsix4yar3OZcz8F8sZthAp9jMeSHb5OcWC8kC1XZJH3ibRW7D1Q
	 /j0weYqWrJ2wpVSD5FiTIwfDwr0jpUsr2haXJU2PmRI3QVO1DqP8anGkk1UzzvNzxq
	 veOdtzvJwJTkTN7ue8NJAT0LgN2tlQrUl93wuVh3WVP6OENXzcVAm6P/Wx8WC5KU3i
	 soK6cfeOZvQ9g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v9 8/8] selftests/bpf: Reuse stderr parsing for
 libarena ASAN tests
Reply-To: sashiko@lists.linux.dev
To: "Emil Tsalapatis" <emil@etsalapatis.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260426190338.4615-9-emil@etsalapatis.com>
References: <20260426190338.4615-9-emil@etsalapatis.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 26 Apr 2026 21:38:21 +0000
Message-Id: <20260426213821.AA8F3C2BCAF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Sashiko AI review found 2 potential issue(s):
- [Low] Unnecessary export of `free_msgs` to the global namespace.
- [Low] Use of a magic number for the BPF stream ID.
--

commit 49cffc0bea9678ea2577c634e093c46121bf87fd
Author: Emil Tsalapatis <emil@etsalapatis.com>

selftests/bpf: Reuse stderr parsing for libarena ASAN tests

This commit adds code to directly test the output of libarena ASAN tests.
It reuses testing infrastructure originally for BPF streams to verify that
ASAN emits call stacks when memory errors occur.

> diff --git a/tools/testing/selftests/bpf/test_loader.c b/tools/testing/se=
lftests/bpf/test_loader.c
> index c4c34cae6102..ee637809a1d4 100644
> --- a/tools/testing/selftests/bpf/test_loader.c
> +++ b/tools/testing/selftests/bpf/test_loader.c
> @@ -93,7 +93,7 @@ void test_loader_fini(struct test_loader *tester)
>  	free(tester->log_buf);
>  }
> =20
> -static void free_msgs(struct expected_msgs *msgs)
> +void free_msgs(struct expected_msgs *msgs)

Are there any callers outside of test_loader.c that need this function?

It appears the newly added verify_test_stderr() encapsulates the cleanup
internally by calling free_test_spec(), leaving free_msgs() without any
external callers. Could this function remain static to avoid unnecessary
namespace pollution?

[ ... ]

> @@ -789,6 +789,43 @@ static void emit_stderr(const char *stderr, bool for=
ce)
>  	fprintf(stdout, "STDERR:\n=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D\n%s=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D\n", stderr);
>  }
> =20
> +static void verify_stderr(int prog_fd, struct expected_msgs *msgs)
> +{
> +	LIBBPF_OPTS(bpf_prog_stream_read_opts, ropts);
> +	char *buf;
> +	int ret;
> +
> +	if (!msgs->cnt)
> +		return;
> +
> +	buf =3D malloc(TEST_LOADER_LOG_BUF_SZ);
> +	if (!ASSERT_OK_PTR(buf, "malloc"))
> +		return;
> +
> +	ret =3D bpf_prog_stream_read(prog_fd, 2, buf, TEST_LOADER_LOG_BUF_SZ - =
1,
> +				    &ropts);

Would it be better to use the BPF_STREAM_STDERR macro here instead of
hardcoding the value 2?

Using the macro defined in include/uapi/linux/bpf.h might improve
readability and stay consistent with other stream testing code.

[ ... ]

> diff --git a/tools/testing/selftests/bpf/test_progs.h b/tools/testing/sel=
ftests/bpf/test_progs.h
> index 1a44467f4310..37955a8ad385 100644
> --- a/tools/testing/selftests/bpf/test_progs.h
> +++ b/tools/testing/selftests/bpf/test_progs.h
> @@ -563,5 +563,7 @@ struct expected_msgs {
> =20
>  void validate_msgs(const char *log_buf, struct expected_msgs *msgs,
>  		   void (*emit_fn)(const char *buf, bool force));
> +void free_msgs(struct expected_msgs *msgs);

If free_msgs() can remain static, should this declaration be removed?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260426190338.4615=
-1-emil@etsalapatis.com?part=3D8
