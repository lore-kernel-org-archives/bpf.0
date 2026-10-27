Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793119009;
	b=KrSq95gZHk9nqBtcc6yIorAiHxDw6VxXGzt7GxJyr2kOENcXnaVzBzrFW2EK3wyk43dq
	 L/ehD+Ss737eqeTQmzY6fvWn36Xn0DkXvOz+gL7+YjxoOJqj4lFso3DDiuIHC1ohq4H50
	 +2lePP6ihYrVfwqelHRPQskfQsRhPigCnY8f9hkYyvPbp2miBJ/O63ryhC15C9GXnH8xO
	 2IBeJ5gXVUvBo87PRkZDfnJMvAIQR237AsAskzJH9mmXJblyMJ5WB4lFV2xEbucjCxbhP
	 22kXaQ60NY2w7PPqLNbzEdjz60YRmq+vsJnlF7OlM3pRf5hp6j81FFrXSMyOElAOvNA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793119009;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=43gKR2cy0rbAWmUana7eTuyU0m3tnOhZamuaAsPd3Xo=;
	b=SsHrsq51musWnRMqEuYebawNMn9xBgFFTK4eLTDZlTB0rYP8MNBFukI71dwQPXbOk4Ld
	 HP3gA5HCD8WWcXMln1mhf2mgjPKkaFq4e9VQz+qnc104tCqtbMwNi7vUmIxn0ow+g73VY
	 Xg2UpZciV7DVOqFKDiC9p23+zx6VEs31pOZHvWIWlzbvpqfa6N6BUS0rdAWH7BI9Bp2o+
	 HLmq2/FOlDSLKO31+tSlnF1xpiLzrkgeOKk+1MjB7d6+3+OrNTkDOj8lkyGYA5Mmg6m5x
	 FiZukuwK2I1pfYjQ7FnvukkaQe1olCXFj+rZc1/1cCgEMGssLRoGJg4FN64boEg6gvw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hXRIK8Kh;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92DCD606A31A
	for <bpf@vger.kernel.org>; Tue, 27 Oct 2026 16:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hXRIK8Kh
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C4701F01825;
	Tue, 27 Oct 2026 16:36:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793119009;
	bh=43gKR2cy0rbAWmUana7eTuyU0m3tnOhZamuaAsPd3Xo=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=hXRIK8KhLZnQNQyspuR9CPwltsH2/sV4rIvauKb7bPjKL/SQUxQhz++Dwa4RUhMS/
	 p+6F34ehIina6rS93d4+TYJQbHPFDMapRnM7mFbuzjWZVDIwxSI7wJWtBwOfAeGfqq
	 89ucrO3lBS6XWtJFH0Wz/RQ1R+BfJDsxB3lfpImuy7EIMTYV6CVWc8h4Fsqn0qZrVq
	 a4k5j762HHEU9wcLef4oFwQRctnGkluQFkI4J38RCfvjBjh3cWTDhDrEWVX+Cbm2be
	 BtvyLuAaaBry+9Gv4KlqW6iYR5ITKUGs75eVSMAmfftzq1vtHDuNKe1Kmz2olx0x5E
	 25v3TZRsGCFKQ==
Message-ID: <sashiko-outbox-186933@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next 1/4] libarena: remove in-code licenses
Reply-To: sashiko-reviews@lists.linux.dev
To: "Emil Tsalapatis" <emil@etsalapatis.com>, bpf@vger.kernel.org
In-Reply-To: <20261027162916.10996-2-emil@etsalapatis.com>
References: <20261027162916.10996-1-emil@etsalapatis.com>
 <20261027162916.10996-2-emil@etsalapatis.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 27 Oct 2026 16:36:48 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] selftests/bpf: missing license section in libarena_bench.bpf.o
--

commit 1bfbb56cf90063a6a767e7e64926692dd815ff9b
Author: Emil Tsalapatis <emil@etsalapatis.com>

libarena: remove in-code licenses

This commit removes the SEC("license") definitions from the libarena BPF
source files (asan.bpf.c, buddy.bpf.c, and common.bpf.c) so that consumers
of libarena provide their own license section.

> diff --git a/tools/testing/selftests/bpf/libarena/src/asan.bpf.c b/tools/=
testing/selftests/bpf/libarena/src/asan.bpf.c
> index de656b69d13af..8a0f061106064 100644
> --- a/tools/testing/selftests/bpf/libarena/src/asan.bpf.c
> +++ b/tools/testing/selftests/bpf/libarena/src/asan.bpf.c
> @@ -532,5 +532,3 @@ __weak __noasan int asan_init(struct asan_init_args *=
args)
>  #pragma clang attribute pop
> =20
>  #endif /* BPF_ARENA_ASAN */
> -
> -__weak char _license[] SEC("license") =3D "GPL";
> diff --git a/tools/testing/selftests/bpf/libarena/src/buddy.bpf.c b/tools=
/testing/selftests/bpf/libarena/src/buddy.bpf.c
> index 2490ab1396de0..552ce87875e3b 100644
> --- a/tools/testing/selftests/bpf/libarena/src/buddy.bpf.c
> +++ b/tools/testing/selftests/bpf/libarena/src/buddy.bpf.c
> @@ -899,5 +899,3 @@ __weak int buddy_free(struct buddy __arena *buddy, vo=
id __arena *addr)
> =20
>  	return ret;
>  }
> -
> -__weak char _license[] SEC("license") =3D "GPL";
> diff --git a/tools/testing/selftests/bpf/libarena/src/common.bpf.c b/tool=
s/testing/selftests/bpf/libarena/src/common.bpf.c
> index d1af60b818389..d859bd538c52d 100644
> --- a/tools/testing/selftests/bpf/libarena/src/common.bpf.c
> +++ b/tools/testing/selftests/bpf/libarena/src/common.bpf.c
> @@ -85,5 +85,3 @@ __weak void arena_free(void __arena *ptr)
>  {
>  	buddy_free(&buddy, ptr);
>  }
> -
> -char _license[] SEC("license") =3D "GPL";

[Severity: Medium]
Does removing _license from common.bpf.c, buddy.bpf.c, and asan.bpf.c leave
libarena_bench.bpf.o without a license section and break the libarena
benchmarks at load time?

In tools/testing/selftests/bpf/libarena/Makefile, libarena_bench.bpf.o is
linked solely from LIBARENA_CORE_SOURCES and LIBARENA_BENCH_SOURCES:

    LIBARENA_BENCH_OBJECTS =3D $(notdir $(LIBARENA_CORE_SOURCES:.bpf.c=3D.b=
pf.o) \
                                      $(LIBARENA_BENCH_SOURCES:.bpf.c=3D.bp=
f.o))

Unlike the selftests in selftests/test_buddy.bpf.c and
selftests/test_asan_buddy.bpf.c, the benchmark source in
tools/testing/selftests/bpf/libarena/benchs/bench_malloc.bpf.c does not
define a SEC("license") section.

When running the libarena-malloc or libarena-calloc benchmarks in
tools/testing/selftests/bpf/benchs/bench_libarena.c:

    malloc_setup() / calloc_setup()
      -> setup_common()
           -> libarena_bench__open_and_load()

libarena_bench.bpf.o now loads with an empty license string, so the BPF
verifier rejects the programs with -EINVAL when checking GPL compatibility
for their kfunc calls, kernel BTF accesses, and bpf_trace_printk usage.

Should tools/testing/selftests/bpf/libarena/benchs/bench_malloc.bpf.c define
a SEC("license") section now that the core library sources no longer provide
one?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261027162916.1099=
6-1-emil@etsalapatis.com?part=3D1
