Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A9943403EC
	for <bpf@vger.kernel.org>; Sat, 15 Aug 2026 08:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786782422; cv=none; b=R0T0ctfEC6NsUnc/LO4Q7UE+erHTRfZlvXTp2OwpHPCDE7G799ByMzwC92LG+5lP58uHGfDrGjJV0wP6LfKvp+3Kww0LwQABV+83jHJk6nfE4B+PpFQpSGPci3dcnrCKzO4Sf8mjmvAEU6r+YSMZ334VQB8sgnvELXUudSia6r4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786782422; c=relaxed/simple;
	bh=sn1aKCDnqECQ6WCNbpgyWoOR71dWIh2vns4H85lPryE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=lki/Y2YaQiVefXWmOtF2YfEI4BQTiZwZF75ET2o722UVT+/SVrI8/Uq2rWPkPdKfTxYBYl0CRcnNEXz55D7NF5kOXupQXUkuQx0x4EA3De2NYklhZkD6kK0iR90j6j0i5JDe5rvaGciS6SS3bMB4272SdGBQmzz8sNMvRHuqUdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KFJ5ykWC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KFJ5ykWC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E74B61F000E9;
	Sat, 15 Aug 2026 08:27:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786782421;
	bh=LGhn7eld3mSDDjsBwTxVGMop8XgNiTWnJCUmB/uQoz4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KFJ5ykWCda+54ho6i/YuI74TSTHe7bU0moIXGF1iEfvKiaPhOwl05+xSWXBUYKMv7
	 0HWXij0fC1WJW1XOdRgxnTdLcAEQ8bklNMiLCo25zocFtua8/tV+H5diGJE6rE6l/n
	 jsLtDKtkMJ6GlsS/fdgZnCpuUoGo9nzGzDbgeLZwt9gThVfKV+Oo6Ze+XPFDEXQpDm
	 3BNpzj6OhKUl72WcEM01f98Bt29lgH85NFaFlS0WEE0ioDsWKpf6XCQck3P+r/G9wl
	 C7rRcqIAcFkvenSE5QrZ35cfh3kKzmMPQc26PUgubEuPmF/BwvDBXYzv99AJ9/TZs8
	 gxqk2s/cScYAw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v3 5/5] selftests/bpf: cover stream capacity
 and partial read edge cases
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jianlin Shi" <shijianlin11@foxmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <tencent_E2FD478B453F740591952AA7A502D4FCA609@qq.com>
References: <tencent_C919BB32458A4DAD645A68F441345B971E05@qq.com>
 <20260815081920.609936-1-shijianlin11@foxmail.com>
 <tencent_E2FD478B453F740591952AA7A502D4FCA609@qq.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 15 Aug 2026 08:27:00 +0000
Message-Id: <20260815082700.E74B61F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The `test_stream_oversize` test fails to verify its stated goal =
because it uses a completely different BPF program to verify the capacity r=
ollback.
--

--- Patch [5]: [PATCH bpf-next v3 5/5] selftests/bpf: cover stream capacity=
 and partial read edge cases ---
commit 168aa19f7a74d7d1bc5cd6a9913bc5c68df1058d
Author: Jianlin Shi <shijianlin11@foxmail.com>

selftests/bpf: cover stream capacity and partial read edge cases

This commit adds test coverage for stream capacity rollback after oversized
writes and partial reads when buffers straddle unmapped pages.

> diff --git a/tools/testing/selftests/bpf/prog_tests/stream.c b/tools/test=
ing/selftests/bpf/prog_tests/stream.c
> index e4e9374309e26..fefe6431dc7c9 100644
> --- a/tools/testing/selftests/bpf/prog_tests/stream.c
> +++ b/tools/testing/selftests/bpf/prog_tests/stream.c
[ ... ]
> @@ -58,6 +58,76 @@ void test_stream_syscall(void)
>  	stream__destroy(skel);
>  }
> =20
> +void test_stream_oversize(void)
> +{
> +	LIBBPF_OPTS(bpf_test_run_opts, opts);
> +	struct stream *skel;
> +	int ret, prog_fd;
> +	char buf[8] =3D {};
> +
> +	skel =3D stream__open_and_load();
> +	if (!ASSERT_OK_PTR(skel, "stream__open_and_load"))
> +		return;
> +
> +	prog_fd =3D bpf_program__fd(skel->progs.stream_oversize);
> +	ret =3D bpf_prog_test_run_opts(prog_fd, &opts);
> +	ASSERT_OK(ret, "oversize run");
> +	ASSERT_EQ(opts.retval, -E2BIG, "oversize retval");
> +
> +	/* Oversized push must not permanently consume capacity. */
> +	prog_fd =3D bpf_program__fd(skel->progs.stream_syscall);

[Severity: Medium]
Does this code verify the capacity rollback correctly?

Because BPF streams are maintained on a per-program basis, switching to
the stream_syscall program means it tests a completely different, pristine
stream that was never affected by the oversized push.

Should the test verify a subsequent successful push using the same program
that performed the oversized push?

> +	ret =3D bpf_prog_test_run_opts(prog_fd, &opts);
> +	ASSERT_OK(ret, "syscall run");
> +	ASSERT_OK(opts.retval, "syscall retval");
> +
> +	ret =3D bpf_prog_stream_read(prog_fd, BPF_STREAM_STDOUT, buf, sizeof(bu=
f), NULL);
> +	ASSERT_EQ(ret, 3, "bytes after oversize");
> +	ASSERT_OK(memcmp(buf, "foo", 3), "payload after oversize");
> +
> +	stream__destroy(skel);
> +}
[ ... ]
> diff --git a/tools/testing/selftests/bpf/progs/stream.c b/tools/testing/s=
elftests/bpf/progs/stream.c
> index 00a37933e411d..6aa9a67483500 100644
> --- a/tools/testing/selftests/bpf/progs/stream.c
> +++ b/tools/testing/selftests/bpf/progs/stream.c
[ ... ]
> @@ -118,6 +123,13 @@ int stream_syscall(void *ctx)
>  	return 0;
>  }
> =20
> +SEC("syscall")
> +__success __retval(-E2BIG)
> +int stream_oversize(void *ctx)
> +{
> +	return bpf_stream_printk(BPF_STDOUT, _BIG_STR);
> +}

[Severity: Medium]
Since this program returns immediately after the oversized push, it leaves
no way to verify the capacity rollback on the same stream from userspace.

Could this program be updated to perform a subsequent successful push to the
same stream, to correctly validate that the capacity was not permanently
consumed?

> +
>  SEC("syscall")
>  __arch_x86_64
>  __arch_arm64

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260815081920.6099=
36-1-shijianlin11@foxmail.com?part=3D5
