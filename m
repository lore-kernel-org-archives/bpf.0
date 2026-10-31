Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793484732;
	b=slIZUtrsHnP4nQjiulteOizH1SN+p5CpMk6FjwkTBoUIx3+LvMG+COEJF34FydffpI29
	 nSVZILpONHZeGKBulFxi4m1u106Spw7+z5eOd7nw9rUI2EO4+jftOFLMR6+BqTRdsDN1j
	 BNk1URqJ6v84PPFUrWq1/3boZ/P4GX4eYHen4Ke0VFhejpennLnUv3B/o3ybSjlKLl5jN
	 46BnmtEmGVy2/MyQo/CNUUQRrggNz5gceBY/RmiSMjRM5mJ5Riat35mZjkfDlo/6oY40g
	 93izXLKOUdNIa7Xt1fBr4qYesf8+CE8yUw8/bY1UkZiHMOIIZIAGm9xGusepJQX+QIQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793484732;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=XbTPq0ZFsVWIyJhgX0EIpWwa9bTZtZ8mmz2EL4dClsQ=;
	b=d88uqbsV0pAlJmckDI6xc8XAjVHZ3JB6oDzbJRlICpUkDpmZLBy7WX85oUGtl7J9W5SX
	 cNIlbwtWYJI3bH7SV0wTXdeerEI2yT6A0EXUs3imRcq4B56TVes2NHl8qQSFacPgGqKX7
	 bbc9cM8AjTPQD1N1+fT6y5sScQ72b4MJXMmTaytK5u+ClRG0LXZc08oP9dQpNxMpuyltd
	 fTxhpGo3xp+8xA6zg/rl9WlbkGjmUYbUYVC6jN6xC+i3WpRMWuM0v4Yj2bq1eZ5Rycu+a
	 SAAd+9/5TZpVpZdJIe6PxdLY7NGswN8VaC7LnqlTHwtYAgTkjvmRIvmsOjzV1eDRRig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oF4zKGYX;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5EB6606A31A
	for <bpf@vger.kernel.org>; Sat, 31 Oct 2026 22:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oF4zKGYX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80ABC1F000C1;
	Sat, 31 Oct 2026 22:12:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793484731;
	bh=XbTPq0ZFsVWIyJhgX0EIpWwa9bTZtZ8mmz2EL4dClsQ=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=oF4zKGYXmmZZBlI1OWxd9Ajnf7Xaq1/PzRt7lbIlfjekKFnFZuhu3UWhUe7VqaiZk
	 VdRU5pEXAix1J38BkmUib2xI461DWllGiLoK3ZDy9KuyjZy76hlADEPK9oL+JYSNK6
	 11pcsaQ0/k8RKLI8ZV6d8/S09igM4nzvpKfbDXdAAU+BI8+KGEYEhOC2fJO3S2UIzh
	 75shz2liimdx09pPDTnk7XiMF0uHmqlmqXYicbfcA9JPHIW4v/zXOGofoQiDMoiVOx
	 udj8vrsmE8pA9GSYePjiXnevifvbdkPU5N6m0oeZgkmQXMFBeATCZRGE0OTAiWjl4o
	 UnuF9FPVp0ojw==
Message-ID: <sashiko-outbox-192196@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf v2 9/9] selftests/bpf: Test one may_goto time slice
 per prog invocation
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org
In-Reply-To: <20261031215543.682284-10-alexei.starovoitov@gmail.com>
References: <20261031215543.682284-1-alexei.starovoitov@gmail.com>
 <20261031215543.682284-10-alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 31 Oct 2026 22:12:11 +0000
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
- [Low] selftests/bpf: missing __skip() annotation on dummy_test() in timed=
_may_goto.c
--

commit 0a2b0627ab964341b75c457825392248b5fb88a8
Author: Alexei Starovoitov <ast@kernel.org>

selftests/bpf: Test one may_goto time slice per prog invocation

This commit adds BPF selftests verifying that a single may_goto time slice
is shared across an entire program invocation, including subprogs and
synchronous callbacks, and extends may_goto_far with subprog test cases.

> diff --git a/tools/testing/selftests/bpf/progs/timed_may_goto.c b/tools/t=
esting/selftests/bpf/progs/timed_may_goto.c
> new file mode 100644
> index 0000000000000..c1c48af808a99
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/timed_may_goto.c
> @@ -0,0 +1,898 @@

[ ... ]

> +#if (defined(__TARGET_ARCH_x86) || defined(__TARGET_ARCH_arm64)) && __cl=
ang_major__ >=3D 18

[ ... ]

> +#else
> +
> +SEC("socket")
> +__description("timed may_goto: not supported dummy test")
> +__success
> +int dummy_test(void)
> +{
> +	return 0;
> +}
> +
> +#endif

[Severity: Low]
Should dummy_test() in tools/testing/selftests/bpf/progs/timed_may_goto.c
also include a __skip(...) annotation?

When timed_may_goto.c is built on architectures other than x86_64 and arm64
or with GCC or Clang older than 18, serial_test_timed_may_goto() in
tools/testing/selftests/bpf/prog_tests/timed_may_goto.c runs
RUN_TESTS(timed_may_goto) and returns early. Without __skip(...) on
dummy_test(), test_loader executes the placeholder program and reports OK
instead of SKIP, unlike the other placeholder dummy_test() definitions
updated in commit 8928f5ffdb65 ("selftests/bpf: Report placeholder tests as
SKIP, not OK").

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261031215543.6822=
84-1-alexei.starovoitov@gmail.com?part=3D9
