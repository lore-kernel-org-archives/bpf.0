Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F5BD366806
	for <bpf@vger.kernel.org>; Mon, 31 Aug 2026 14:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788187604; cv=none; b=K0Aj02PDs5Zn98GFBfuy53++qoQ17g1RKc57mfalXHsDSgJetYeRHt3tvmbz2fUAdGSVONMTXmhkMYeUDO8R/4InoJzvMldzfamlA6uD0shErmT2uzIxxgMFD6rokRC3llH20Nat/ZF77hX4qomO0ry6lt+g0l6kTo0jdGuQXkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788187604; c=relaxed/simple;
	bh=wNi/dIlQwOEAucApX8GKIugbeFOqWmH1AeP7WoTF88g=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=XcmSsFJOvqcO/uG5LuB7LUl48IKpMkg8TgDqa6uPB0PvYVTahjt3X2Pieu2uuXD/VJpE51iYT9K76xXcIOghDnYjFDJWHi/AZU0bvXR1EiDdKV1JynvvehLpbuvQxGtdaa5ksV/cuYEiPJOjH6KZ9HDW2KL5DpK/3m24X2Sbalg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ipUBRX9a; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ipUBRX9a"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B88BE1F00A3D;
	Mon, 31 Aug 2026 14:46:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788187603;
	bh=3FpCZPVj42rYqYi+92hGbLsY9X9CptSzQsWGbDhdB5s=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=ipUBRX9aLlqIPSOY2iX6ywaLzeC7z9z/rpDzklIMWQQ6LY9QXbf5C9pfaoyZ/Vr8l
	 VA8aEtf1Sr6sZr1KnKMxJxBE5F+u8K6/lr7qb+umOyWExfvAis3n/4TFooxf+lCmkd
	 39TR2b7+8BECNo8m7NOoeSKycwLmAkJdWSQjI+s5rWYgPoR7KlVTG23yxr6YxBlyY1
	 GHLxHoEireHEnT84VpWS4wB8spa2C1kj7A+sToLY+cX+nN8ffg0yu+ny6CTYlHllwq
	 dqkGRdLCRH6bw3y1232xxq4TkiQ+3p2c6iKxUvKI+eMTi2qqozrQIHwm7S3+sofhVC
	 I10c99ZzM0VFg==
Content-Type: multipart/mixed; boundary="===============8929067925282194568=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <d7e644a42a6bdc2ce95e361ad66ab18e00e688e7e1fa4f8a51b37b38cc108204@mail.kernel.org>
In-Reply-To: <20260831133809.1161-3-zhaofuyu@vivo.com>
References: <20260831133809.1161-3-zhaofuyu@vivo.com>
Subject: Re: [PATCH bpf-next v6 2/2] selftests/bpf: add tests for selective module BTF loading
From: bot+bpf-ci@kernel.org
To: zhaofuyu@vivo.com,bpf@vger.kernel.org
Cc: eddyz87@gmail.com,andrii.nakryiko@gmail.com,alan.maguire@oracle.com,zhaofuyu@vivo.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Mon, 31 Aug 2026 14:46:42 +0000 (UTC)

--===============8929067925282194568==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/prog_tests/btf_module_names.c b/tools/testing/selftests/bpf/prog_tests/btf_module_names.c
> new file mode 100644
> index 0000000000000..68f4a8d735608
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/btf_module_names.c
> @@ -0,0 +1,162 @@

[ ... ]

> +/*
> + * Verify that an unrequested module BTF is skipped. The BPF program
> + * requires the BTF of bpf_testmod, but bpf_testmod is not specified in
> + * btf_module_names, so its BTF is skipped and the BPF program fails to load.
> + */
> +static void btf_module_names_skip(void)
> +{
> +	struct btf_module_names *skel = NULL;
> +	int ret;
> +	const char *mod_names[] = { "module_nonexist" };
> +
> +	LIBBPF_OPTS(bpf_object_open_opts, opts,
> +		.btf_module_names = mod_names,
> +		.nr_btf_module_names = 1,
> +	);
> +
> +	skel = btf_module_names__open_opts(&opts);
> +	if (!ASSERT_OK_PTR(skel, "btf_module_names__open_opts"))
> +		goto out;
> +
> +	ret = btf_module_names__load(skel);
> +	ASSERT_EQ(ret, -ESRCH, "btf_module_names__load");
> +
> +out:
> +	btf_module_names__destroy(skel);
> +}
> +
> +/*
> + * Verify that an empty filter skips loading all module BTFs. The BPF
> + * program requires bpf_testmod BTF, so it fails to load.
> + */
> +static void btf_module_names_empty(void)
> +{
> +	struct btf_module_names *skel = NULL;
> +	int ret;
> +	const char *mod_names[] = { NULL };
> +
> +	LIBBPF_OPTS(bpf_object_open_opts, opts,
> +		/* Non-NULL pointer with zero entries represents an empty list. */
> +		.btf_module_names = mod_names,
> +		.nr_btf_module_names = 0,
> +	);
> +
> +	skel = btf_module_names__open_opts(&opts);
> +	if (!ASSERT_OK_PTR(skel, "btf_module_names__open_opts empty"))
> +		goto out;
> +
> +	ret = btf_module_names__load(skel);
> +	ASSERT_EQ(ret, -ESRCH, "btf_module_names__load empty");
> +
> +out:
> +	btf_module_names__destroy(skel);
> +}

This isn't a bug, but btf_module_names_skip() and btf_module_names_empty()
look like the same body with two initializer values changed. Would a small
helper taking (names, nr, expected_ret) read better and keep the subtests
to a line apiece?

[ ... ]

> +void test_btf_module_names(void)
> +{
> +	struct btf *vmlinux_btf = NULL;
> +	struct btf *module_btf = NULL;
> +
> +	if (!env.has_testmod) {
> +		test__skip();
> +		return;
> +	}
> +
> +	vmlinux_btf = btf__load_vmlinux_btf();
> +	if (libbpf_get_error(vmlinux_btf)) {
> +		test__skip();
> +		return;
> +	}
> +
> +	/* Ensure bpf_testmod BTF is available. */
> +	module_btf = btf__load_module_btf("bpf_testmod", vmlinux_btf);
> +	if (libbpf_get_error(module_btf)) {
> +		btf__free(vmlinux_btf);
> +		test__skip();
> +		return;
> +	}

A subsystem pattern flags this as potentially concerning: test_btf_module_names()
has three distinct prerequisite failures and all three collapse into a bare
test__skip() with no reason emitted.

The resulting log line is identical in all three cases, so a reader of a CI
result cannot tell which prerequisite was missing, and cannot distinguish
"module BTF support is not built in" from "bpf_testmod failed to load".

test__skip() takes no arguments in the BPF test framework, so the idiom for
conveying a skip reason is an adjacent printf("%s:SKIP:...", __func__) or a
trailing comment. The `if (!env.has_testmod) { test__skip(); return; }` form
is universally idiomatic in prog_tests/ and would not normally be raised.

The escalation is really about the two BTF-availability skips:

	vmlinux_btf = btf__load_vmlinux_btf();
	if (libbpf_get_error(vmlinux_btf)) {
		test__skip();
		return;
	}

	module_btf = btf__load_module_btf("bpf_testmod", vmlinux_btf);
	if (libbpf_get_error(module_btf)) {
		btf__free(vmlinux_btf);
		test__skip();
		return;
	}

Neighbouring tests like prog_tests/btf_tag.c annotate these conditions:

	printf("%s:SKIP: btf_type_tag attribute not in vmlinux btf", __func__);
	printf("%s:SKIP: btf_type_tag attribute not in %s", __func__, module_name);

This matters more here than in a typical test because two of the four
subtests assert a *failure* code (-ESRCH), so silently skipping on a machine
without module BTF is the same observable outcome as the feature working.

Would adding skip reason strings for the BTF-availability checks help
distinguish which prerequisite was missing?

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/33399468751
--===============8929067925282194568==--
