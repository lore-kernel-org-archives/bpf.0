Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C6EF3BFAE2
	for <bpf@vger.kernel.org>; Tue, 13 Oct 2026 09:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791882870; cv=none; b=f9PpHBwo80uAFWkbwlgB/ec55tmvlFwDbesTaAYLwgHp2BZFcEFFM/XzroVa23jp5ifsIjRwZG0PdaH+fSYUI8QAXbo1h1MfoLWZHt8MctHxkNsaS4oDIkZJldapqCgWBmH3lB7Rs8R2++poiQyEWUyX7xnPjnd2QzEzOb17k2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791882870; c=relaxed/simple;
	bh=GBN4KQvhQYvfJlFkTE9CzR+lL4hxtqGCR3+lfQTl3dQ=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=j0MSNr2hFwUKmoqsyBVRCPy1gy4vFG3oPKe3127VjznSrKnyUzcDaZ1fmshqXK2KX0w7nfkzwfcz84HBBStxnh3mMAq/vfpNQdZFlubHL0IyNMPH5D8XLlw7mA6F/qqNthka0DC0l5TyDPtnoSwzhH5Gao2jelDD8PvZ01DlmsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KNiYW2Hr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KNiYW2Hr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAB1D1F000FF;
	Tue, 13 Oct 2026 09:14:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791882869;
	bh=0PDQgcWLeRYtSV93W8Oqy5Ndrqh8YNo4nffq/NvUQ8w=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=KNiYW2HrhTIRDjhBmfADSUgnAKOh3Yobv+F0yU+zMo5N1HhCzHoE8Zt31Unzf+jUu
	 p1vix34Zju3VI4mGFnBHeaRIyKSekvQDPbsrPMvIIjnier6v4SRzVrOVLjmDQmJNb9
	 PZ6cyR19G63fF+GVWVXwdshBQEsy6JA9moo3FD6iLBbpHOf8ViAQr4RkLq9fro5BgJ
	 iTUJ/mqob0bmAErDPApb2D/OWhX+cxTOF0C8BFYSxZUVrm6P6L3MW0zG3M5XpCf6sr
	 BkmrtNzTgWHyGEKLgo2gspMarVW0yiAT6IwTcSLqSfJLcb59PrIFDDADudDwdxdC6n
	 VwVCWEhLkByug==
Content-Type: multipart/mixed; boundary="===============2707716416231144659=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <19d84db7443c99a6256ac4bda3e1eabefb2a052b231f8aa571dc0628ee2ed2ff@mail.kernel.org>
In-Reply-To: <20261013082012.1107446-8-memxor@gmail.com>
References: <20261013082012.1107446-8-memxor@gmail.com>
Subject: Re: [PATCH bpf-next v2 07/13] selftests/bpf: Test __arena pointer members
From: bot+bpf-ci@kernel.org
To: memxor@gmail.com,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,emil@etsalapatis.com,ihor.solodrai@linux.dev,tj@kernel.org,kkd@meta.com,kernel-team@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Tue, 13 Oct 2026 09:14:27 +0000 (UTC)

--===============2707716416231144659==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> selftests/bpf: Test __arena pointer members

TL;DR: Test issue in test_struct_ops_arena.c: if the bpf_testmod BTF lacks the
"arena" type tag, the new arena member tests are silently dropped,
test__skip() is never called, and the test still reports OK.

> diff --git a/tools/testing/selftests/bpf/prog_tests/test_struct_ops_arena.c b/tools/testing/selftests/bpf/prog_tests/test_struct_ops_arena.c
> --- a/tools/testing/selftests/bpf/prog_tests/test_struct_ops_arena.c
> +++ b/tools/testing/selftests/bpf/prog_tests/test_struct_ops_arena.c

[ ... ]

> +/*
> + * The tags on the members of struct bpf_testmod_arena_member_args reach the
> + * module BTF only from a toolchain with btf_type_tag support.
> + */
> +static bool testmod_has_type_tag(const char *tag)
> +{
> +	struct btf *vmlinux_btf, *module_btf;
> +	bool found = false;
> +
> +	vmlinux_btf = btf__load_vmlinux_btf();
> +	if (!ASSERT_OK_PTR(vmlinux_btf, "vmlinux_btf"))
> +		return false;
> +	module_btf = btf__load_module_btf("bpf_testmod", vmlinux_btf);
> +	if (ASSERT_OK_PTR(module_btf, "module_btf"))
> +		found = btf__find_by_name_kind(module_btf, tag, BTF_KIND_TYPE_TAG) > 0;
> +	if (!found)
> +		printf("%s:SKIP: no %s type tag in the bpf_testmod BTF\n", __func__, tag);
> +	btf__free(module_btf);
> +	btf__free(vmlinux_btf);
> +	return found;
> +}

[ ... ]

> @@ -122,6 +201,18 @@ void serial_test_struct_ops_arena(void)
>  		arena_arg_fail();
>  	if (test__start_subtest("arena_arg_attach"))
>  		arena_arg_attach();
> +	if (testmod_has_type_tag("arena")) {
> +		if (test__start_subtest("arena_member"))
> +			arena_member();
> +		if (test__start_subtest("arena_member_render"))
> +			arena_member_render();
> +		RUN_TESTS(struct_ops_arena_member_fail__union);
> +		RUN_TESTS(struct_ops_arena_member_fail__load_acq);
> +		RUN_TESTS(struct_ops_arena_member_fail__mismatch);
> +		RUN_TESTS(struct_ops_arena_member_fail__mismatch_mem);
> +		RUN_TESTS(struct_ops_arena_member_fail__write);
> +		RUN_TESTS(struct_ops_arena_member_fail__no_arena);
> +	}
>  #else
>  	test__skip();
>  #endif

When the bpf_testmod BTF has no "arena" type tag, testmod_has_type_tag()
prints a SKIP line but never calls test__skip().  Is the skip reported
anywhere?

serial_test_struct_ops_arena() then leaves out the arena_member and
arena_member_render subtests and all six RUN_TESTS() groups, and the parent
test still reports OK.  test_progs only prints a test's captured stdout when
the test fails or runs verbose (dump_test_log() uses print_test = verbose()
|| force_log || test_failed), so in a normal run the message is never shown
and the skip is never counted.

That seems realistic for kernels built with a toolchain that lacks
btf_type_tag support, where this coverage would be silently dropped.
prog_tests/btf_tag.c does the same check
(btf__find_by_name_kind(*module_btf, "user", BTF_KIND_TYPE_TAG) <= 0) and
pairs the printf with test__skip().

Could the arena_member and arena_member_render subtests still be started
unconditionally, calling test__skip() from inside each one when the tag is
missing?  That would keep the arena_arg* results intact while making the
skip visible.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/38370395582
--===============2707716416231144659==--
