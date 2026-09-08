Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2F1B5616A8
	for <bpf@vger.kernel.org>; Tue,  8 Sep 2026 16:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788883406; cv=none; b=BUWVfduKWvSTRn1Kkrag4okmcbSszDH/3/If9WbY+Vse3a1MDWSPSSLGLAbTAuxfqNpCtkV17VY+MIy4jDCSltdA0c4FApZq8bm/co76XUELEfFigUo5872f2u7cTNiiemaQ+++7DRRgzW4LjUaQ4uNGCF29xTk+1zg0WM8Meb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788883406; c=relaxed/simple;
	bh=P65KJuZARP1cNVpAI/ViKAygRh2I0vl+PZnR0mdxhic=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=KxpvF/n6evx7ZIuSPUc8k48qUbfS+PmKxofEc+xWnLVgNlRoE3C7xfzXWPMrdjmDqhxoToHFrL+unlRqp06b+JnH2qFqRU2J4OzHt+Uw1Zp/HID+ir712CQ5ZS0Yp0lWqF36RqvNAmc07StNcaL87g0Pl8ygNNpcUwHVgOwLaAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hP5gtbDA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hP5gtbDA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D2B81F00A3A;
	Tue,  8 Sep 2026 16:03:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788883404;
	bh=ucD0hAk6slzi8mg34aw8Ipf2z7Mn/e+exgiSSJbm+S0=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=hP5gtbDA/CqINEJkz8Z1KgUrEYRYzU4vsYI3caCVoWpiuLkXvfwNr2h2c1VSursyo
	 rP5DpD6rD0aVhCQQ+5Ohv6nadRCHopsBIbaido1sEXhXctP04MOUwI/TM4ozWmcdpz
	 6OuHgY9roXoSs/ORc6xr5B3AAf0UGomNwq/ALA3SGUMcD2zlM07pUwjCcg/56JTY1I
	 AEhpZ00lKb3qFg9O2MwdxFFB9BvWiOWw7pKNfzuakP0VoD11ZdihcKdwFIxv+093XR
	 69hIviAyQg/8mKAZiDyzFmHbLS+QV2XYP+L7LBglJUJZdtIG1Li/oimYftGNcq6Wyg
	 ELd7eXp4TISgg==
Content-Type: multipart/mixed; boundary="===============7360458075074642585=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <3b909016a8dcb99df0125202bbc3a564bb48c60067ea1476a22db43088c695e7@mail.kernel.org>
In-Reply-To: <20260907053847.1115-3-zhaofuyu@vivo.com>
References: <20260907053847.1115-3-zhaofuyu@vivo.com>
Subject: Re: [PATCH bpf-next v7 2/2] selftests/bpf: add tests for selective module BTF loading
From: bot+bpf-ci@kernel.org
To: zhaofuyu@vivo.com,bpf@vger.kernel.org
Cc: eddyz87@gmail.com,andrii.nakryiko@gmail.com,alan.maguire@oracle.com,zhaofuyu@vivo.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Tue,  8 Sep 2026 16:03:24 +0000 (UTC)

--===============7360458075074642585==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/prog_tests/btf_module_allowlist.c b/tools/testing/selftests/bpf/prog_tests/btf_module_allowlist.c
> new file mode 100644
> index 000000000000..fb1b9ffb6c7a
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/btf_module_allowlist.c
> @@ -0,0 +1,155 @@

[ ... ]

> +static void btf_module_allowlist_default(void)
> +{
> +	struct btf_module_allowlist *skel;
> +	int ret;
> +	LIBBPF_OPTS(bpf_object_open_opts, opts);
> +
> +	skel = btf_module_allowlist__open();
> +	if (!ASSERT_OK_PTR(skel, "btf_module_allowlist__open"))
> +		return;
> +
> +	ret = btf_module_allowlist__load(skel);
> +	ASSERT_OK(ret, "btf_module_allowlist__load");
> +
> +	btf_module_allowlist__destroy(skel);
> +	skel = NULL;
> +
> +	skel = btf_module_allowlist__open_opts(&opts);
> +	if (!ASSERT_OK_PTR(skel, "btf_module_allowlist__open_opts"))
> +		return;
> +
> +	ret = btf_module_allowlist__load(skel);
> +	ASSERT_OK(ret, "btf_module_allowlist__load opts");
> +
> +	btf_module_allowlist__destroy(skel);
> +}

Jiri Olsa noted in v7 that the second btf_module_allowlist__open_opts(&opts)
call appears redundant. This test section duplicates the same test logic
already covered in the first part of the function. Could this second test
be removed to simplify the test?

[ ... ]

> +void test_btf_module_allowlist(void)
> +{
> +	struct btf *vmlinux_btf = NULL;
> +	struct btf *module_btf = NULL;
> +
> +	if (!env.has_testmod) {
> +		printf("%s:SKIP: bpf_testmod is not available\n", __func__);
> +		test__skip();
> +		return;
> +	}
> +
> +	vmlinux_btf = btf__load_vmlinux_btf();
> +	if (libbpf_get_error(vmlinux_btf)) {
> +		printf("%s:SKIP: vmlinux_btf is not available\n", __func__);
> +		test__skip();
> +		return;
> +	}
> +
> +	/* Ensure bpf_testmod BTF is available. */
> +	module_btf = btf__load_module_btf("bpf_testmod", vmlinux_btf);
> +	if (libbpf_get_error(module_btf)) {
> +		printf("%s:SKIP: bpf_testmod's BTF is not available\n", __func__);
> +		btf__free(vmlinux_btf);
> +		test__skip();
> +		return;
> +	}

Andrii Nakryiko requested in v6 not to use libbpf_get_error() as it is
legacy and discouraged. He suggested checking for NULL and then looking at
errno instead. The code still uses libbpf_get_error() here and again below
for the module_btf check. Could these be updated to follow the recommended
pattern?

> +
> +	btf__free(module_btf);
> +	btf__free(vmlinux_btf);
> +
> +	if (test__start_subtest("default"))
> +		btf_module_allowlist_default();
> +
> +	if (test__start_subtest("allowlist"))
> +		btf_module_allowlist_allow();
> +
> +	if (test__start_subtest("skip_unlisted"))
> +		btf_module_allowlist_skip();
> +
> +	if (test__start_subtest("emptylist"))
> +		btf_module_allowlist_empty();
> +
> +	if (test__start_subtest("invalid_input"))
> +		btf_module_allowlist_invalid();
> +}

Jiri Olsa also suggested in v7 adding a test that verifies the module's BTF
did not get loaded because of the allowlist setup. He recommended using
something like bpf_program__set_attach_target(prog, 0,
"bpf_testmod:bpf_fentry_test1") which would fail, or some other way that
uses obj->btf_modules. This would improve test coverage by directly verifying
that module BTF filtering works at the BTF loading level, not just at the
program loading level. Would it be worth adding such a test?

> diff --git a/tools/testing/selftests/bpf/progs/btf_module_allowlist.c b/tools/testing/selftests/bpf/progs/btf_module_allowlist.c
> new file mode 100644
> index 000000000000..bb3c38bee77d
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/btf_module_allowlist.c

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/34245661129
--===============7360458075074642585==--
