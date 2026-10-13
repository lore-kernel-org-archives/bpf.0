Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94FE825B095
	for <bpf@vger.kernel.org>; Tue, 13 Oct 2026 00:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791852714; cv=none; b=CHV9fItR6Za+tUf7SlCZt2s9h+AymD+JyPGrLUajwaVErGvTFT5HT02Lt+uLiOX6+gWHcqFDC/303QF/n63eVRlj1/1DBJ6PU5wDQVOUzj5ZDFd5Eu4Q97/u3SvPjE3rRupy2IrlmT8tZ4QeI8lVv4s/c9uFfqXQ0wmg1geh78o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791852714; c=relaxed/simple;
	bh=b8Pa/ZMTIHrw+WDBX4kskpAsFdr2qpKNqE9PTEGI5hw=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=uTBROZH43/zhuuz+6nccAezLUuITACsE6adjEILDpfqw0yESA3d4+zyzvR8k6Bz2ov94CytYZcPbjDKSSSnLadC3yQ7g0YhabvRr29aQMcxs8M79PYvhOloH2MKLQQE8CdypgXqLBqujqIn6Kf/8Km94ehRM0Y3nJ04jBucwU1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FcYB8HHf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FcYB8HHf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05BF31F0089B;
	Tue, 13 Oct 2026 00:51:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791852713;
	bh=9+k/hqGh3FuuCsals1s88HETkLB0okxMGb3ioEnzz5M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FcYB8HHfZG36IDVsFvVaBRsduI6/Nvccho/PV9UUUokxK4y9h5AFgPyZs46DRy2Ij
	 MqBqz1R/EjCXfiyHYMZBVSIGgsN70TjXnODGlNImyr3q6LRU/wEuzNbA8yMpRbpfiw
	 I5gPu+OhUpTETxE+MCmvvoHKXoC/9IBSv4XeS37ZOZj5Vrvkxzr7bohNZfqg+Zh0bV
	 EuleTWwBZ4eiet+sEdwpsz82W+zLh5OyTO5vWCLGvp9Y5re68d+bsrJHv55Y2E9icx
	 SUhWcktTgyl00nUtAlNTLyz6BwgUUlBgMUHzeZJZXc7xQbXlZ7Vr1zhraa1uxOYbEB
	 tRly2mJRigDrg==
Message-ID: <sashiko-outbox-168817@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v2 09/11] selftests/bpf: Test trampolines on
 more BPF functions with stack args
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yonghong Song" <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20261013003515.1860439-1-yonghong.song@linux.dev>
References: <20261013003429.1853052-1-yonghong.song@linux.dev>
 <20261013003515.1860439-1-yonghong.song@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Oct 2026 00:51:52 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] bpf: check_unreliable_func_args incorrectly counts slots, allowing=
 corrupting trampoline
--

commit c87f5bcaff5cc54c864fa434bbfefe8d6bff2bbc
Author: Yonghong Song <yonghong.song@linux.dev>

selftests/bpf: Test trampolines on more BPF functions with stack args

Add two functions to the BPF target program of the int128_tgt_prog test.
callee_split() takes a struct holding an __int128 after five u64s, so
on x86-64 it is passed split between r9 and the stack.

> diff --git a/tools/testing/selftests/bpf/prog_tests/tracing_struct.c b/to=
ols/testing/selftests/bpf/prog_tests/tracing_struct.c
> index ad46eabe784f8..e68fd5627ec1c 100644
> --- a/tools/testing/selftests/bpf/prog_tests/tracing_struct.c
> +++ b/tools/testing/selftests/bpf/prog_tests/tracing_struct.c
[ ... ]
> +/*
> + * A static function whose BTF is unreliable gets a trampoline that only=
 knows
> + * of the register arguments, so one taking stack arguments must be refu=
sed.
> + */
> +static void test_tgt_prog_unreliable(void)
> +{
[ ... ]
> +	err =3D bpf_program__set_attach_target(tracer->progs.unreliable_entry, =
fd,
> +					     "callee_unreliable");
> +	if (!ASSERT_OK(err, "set_attach_target"))
> +		goto out;
> +
> +	err =3D tracing_struct_int128_tracer__load(tracer);
> +	ASSERT_ERR(err, "tracer__load");
> +	ASSERT_HAS_SUBSTR(log_buf, "unreliable BTF and stack arguments", "log");

[Severity: High]
While this test accurately checks callee_unreliable() which takes 6 scalar
arguments, is there a potential issue in the verifier's
check_unreliable_func_args() when dealing with struct arguments that occupy
multiple slots?

In kernel/bpf/verifier.c:check_unreliable_func_args(), if
btf_distill_func_proto() fails (e.g. because an argument is a struct larger
than 16 bytes), the fallback path counts the number of arguments instead
of 8-byte slots:

	if (btf_distill_func_proto(NULL, btf, func_proto, tname, &m)) {
		/* at least a slot for each argument */
		nslots =3D btf_type_vlen(func_proto);
	}

For a BPF subprogram taking a 32-byte struct by value and 4 other arguments
(5 arguments total), the actual slot count is 1 + 1 + 1 + 1 + 4 =3D 8 slots
(meaning 3 slots are on the stack). But the fallback calculates nslots =3D =
5.

Since 5 <=3D MAX_BPF_FUNC_REG_ARGS (5), check_unreliable_func_args()
incorrectly returns 0, permitting attachment.

The generated trampoline will not save or restore the stack arguments.

Does this cause the target BPF subprogram to read uninitialized stack
memory from the trampoline frame as its arguments, leading to data corrupti=
on
and undefined behavior?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261013003429.1853=
052-1-yonghong.song@linux.dev?part=3D9
