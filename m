Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDC94375ACF
	for <bpf@vger.kernel.org>; Wed,  8 Jul 2026 21:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783545049; cv=none; b=nW22zAF+RLE8dFlQrEdjQVIHZT4RwZxKemeN7eBnPFXYHYPlmz1fogEd4H+SYMWMXdmUUdckSCTLFtMkGu0X3IyczzSmuPhECOLC6a8pPnpo2BM6B6PlaSFEqBxZGuMWCYFD+B/W6jZt8F0Jb+xOAxFgu+Y5IxfZIWHJ74dP5Ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783545049; c=relaxed/simple;
	bh=QM6RsTMmhOWAgRWGMU3L5L0nKnclOG4M4iSOH6aP1So=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=Tr7vvc+JPJd78vF5tl7FD0T+QReBvtZ88rljnD/1iRLn5zo7WQzn79Skr7pWsUjoT90qNIz6VQBkZmpeM8mtgrDoE1xXyJDdSjmGOYen82H2XJF9yQc3qtQYLFjCT6ORr/rlfe9ssaCf5Gz9wiUaLTxi23kACmxvrGoxKV1RAjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ocaqaz1n; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ocaqaz1n"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1D3F1F000E9;
	Wed,  8 Jul 2026 21:10:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783545047;
	bh=NCBVupJfE3WLb6UTOcPoGM8XAhlEzuZHvUSigEMMHFE=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=Ocaqaz1n/08ulPqBhhxYRGwaHtv8pG94fU0ef4vm0m4fRukcduHy8RyB6xv/OCzcI
	 hp+TnW3llpoZkFJF41HDfYXuXExnt8Ij6lAsx/Bze3DyFdcEqZnt0sxIEHk2n+7/yq
	 t6jGcWyEJC4H++LLVS8mH/2q4GP0IU6TSbcYGwOXAN6siNQ+qCzZBMGTc62xjRX3PU
	 T+lH2hrJWiq+Uz5IQy0C9D6JuUNsQDdL5SzW45PMzSIpaZJmxJcC3tEbOEqjq7IHX6
	 v4UCGZrriCnuM3EUQRjBCgeiAQjYnKCCRD7hBQU62SkCq9cbHAlKiLhtW+QCtItRAb
	 GdrmovNFD5U4Q==
Content-Type: multipart/mixed; boundary="===============1037113179140476373=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <b4271ab7b2a5eb033b22efc367ad93796a92d63f65b7f1acafc80f9ef24d55ca@mail.kernel.org>
In-Reply-To: <20260708201025.2160583-1-yonghong.song@linux.dev>
References: <20260708201025.2160583-1-yonghong.song@linux.dev>
Subject: Re: [PATCH bpf-next 09/12] selftests/bpf: Add C tests for 16-byte returns in R0:R2
From: bot+bpf-ci@kernel.org
To: yonghong.song@linux.dev,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,kernel-team@fb.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Wed,  8 Jul 2026 21:10:46 +0000 (UTC)

--===============1037113179140476373==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/prog_tests/aggregate_ret.c b/tools/testing/selftests/bpf/prog_tests/aggregate_ret.c
> new file mode 100644
> index 0000000000000..d4ecc19684cef
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/aggregate_ret.c
> @@ -0,0 +1,96 @@

[ ... ]

> +/*
> + * Run one program and check its result. The program returns 0 on success, or
> + * 1..4 identifying which half of which aggregate (R0:R2) return value came back
> + * wrong. A return of -1 means the program was built with an LLVM that lacks
> + * R0:R2 16-byte return support, in which case the subtest is skipped.
> + */

[ ... ]

> +	/* C variant (__int128): relies on LLVM 23 R0:R2 codegen, skipped otherwise. */
> +	if (test__start_subtest("int128_c"))
> +		run_prog(skel_c->progs.aggregate_ret_test, true);
> +
> +	aggregate_ret_int128_c__destroy(skel_c);
> +
> +	skel_struct_c = aggregate_ret_struct_c__open_and_load();
> +	if (!ASSERT_OK_PTR(skel_struct_c, "skel_struct_c_open_load"))
> +		return;
> +
> +	/*
> +	 * C variant returning a 16-byte struct by value: exercises the struct
> +	 * branch of bpf_ret_reg_pair(). Also LLVM 23 only.
> +	 */
> +	if (test__start_subtest("struct_c"))
> +		run_prog(skel_struct_c->progs.aggregate_ret_struct_c_test, true);
> +
> +	/*
> +	 * Same 16-byte struct return, but from a global (non-static) callee:
> +	 * exercises the compiler lowering a global struct-returning function to
> +	 * R0:R2 and the verifier's global return path end to end. Also LLVM 23
> +	 * only.
> +	 */
> +	if (test__start_subtest("global_struct_c"))
> +		run_prog(skel_struct_c->progs.aggregate_ret_global_struct_c_test, true);
> +
> +	/*
> +	 * Same 16-byte struct, but returned by value from a kfunc: exercises
> +	 * the struct branch of check_kfunc_call() and the JIT RDX->R2 move.
> +	 * Also LLVM 23 only.
> +	 */
> +	if (test__start_subtest("kfunc_struct_c"))
> +		run_prog(skel_struct_c->progs.aggregate_ret_kfunc_struct_c_test, true);

this isn't a bug, but the "Also LLVM 23 only." note is repeated on each
of these per-subtest comments, and the run_prog() comment above already
states that programs built without R0:R2 support return -1 and get
skipped.  Could that note be stated once rather than on every block?

Related, do the per-subtest comments need to name the specific internals
(bpf_ret_reg_pair(), check_kfunc_call(), "the JIT RDX->R2 move"), or
would a shorter note serve here?

> diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h b/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h
> index c36bb911defa7..34d0a352e70dd 100644
> --- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h
> +++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h
> @@ -55,6 +55,15 @@ struct prog_test_big_arg {
>  	__u64 b;
>  };
>
> +/*
> + * A 16-byte struct returned by value from a kfunc, returned in the R0:R2
> + * register pair.
> + */
> +struct bpf_kfunc_ret_ll {	/* 16 bytes: R0:R2 */

this isn't a bug, but the block comment already says the struct is 16
bytes and returned in the R0:R2 register pair, and the trailing
/* 16 bytes: R0:R2 */ on the next line repeats that.  Could one of the
two be dropped?

> +	__u64 a;
> +	__u64 b;
> +};


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/28973410219
--===============1037113179140476373==--
