Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 401444A5EBE
	for <bpf@vger.kernel.org>; Mon,  7 Sep 2026 13:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788789487; cv=none; b=d6XT3NwLCeHB7L3c8NtTJNpsyk5LFqVtbWnVYKxXw3uaG5/7DubG1bNc6yK/v/NuE1dH7LhlgDLNPqaZzJNIqQt/Msj/A1DNKnqCi+gN4vWa5uL7tW2otjGgixTkZFPRowjzcDbtj6igAJhOdTogmWZdXAUEg88nbapCJH5+YcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788789487; c=relaxed/simple;
	bh=oKJHc/fJmYTAJ0/pcd9XPCYAZU/kziGZ2J9bjmKIf4M=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=FbYbGliqkWnvg5V00hzgLTFfTxOhQuKcwLWEKdy8DJyZ71vg4PLf2HGDp0/dVjEGAGVgvjziifNQXlI12DFkmNu85UVKVeDyqwqsXvxeDJRwjwOIK91+pP3xIM1DBhetf628lI5FOGn5vir6AwZFq93FHMYMLH9RF1j55SsBwWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LOzB4gVM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LOzB4gVM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02FE41F00A3A;
	Mon,  7 Sep 2026 13:58:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788789486;
	bh=Uuii1DdmDi5cDCBt3dLOrnX8EkEtYTiNasfg6OUMu3I=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LOzB4gVMI2ZtDhffjhA0craDCpPAu8ibsXJXUwtQeFQlrxxM9Jhx06ZMs/gz2WfXY
	 erT02b4N1rZ2SBIZ/YrLeNiL44xbrHQQ2E8jhTcd3RRRRrAxf6K4MF9vxyMupckLrC
	 LUwf8ZuAJkOSvX1Wm/QFN4/gHEq8Bsk91OCpFiCnF6USblq/VjM+RkQAHck6kphg/f
	 8hli4UOVgZYJ5B9Qaz0i7GlumxGhZd/uBNEZlzyp4NA836ncuehu5T8yzLU4I4J8mF
	 zXvn/DxFIl/inXuaWpQgp0jfsBci2SlwU812gvsJE39fyY61Lwp3X3zbgd2l5FUHge
	 pMMwxJDTOYUVQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next 2/4] selftests/bpf: Add tests for
 bpf_call_rcu()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Puranjay Mohan" <puranjay@kernel.org>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260907134552.1772405-3-puranjay@kernel.org>
References: <20260907134552.1772405-1-puranjay@kernel.org>
 <20260907134552.1772405-3-puranjay@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 07 Sep 2026 13:58:05 +0000
Message-Id: <20260907135806.02FE41F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Incomplete test validation in `test_call_rcu_teardown`.
--

commit 7d7060669166bdbb9948b95d35813ccc322df204
Author: Puranjay Mohan <puranjay@kernel.org>

selftests/bpf: Add tests for bpf_call_rcu()

This commit adds tests for bpf_call_rcu() to cover the callback running
after a grace period, checking -EBUSY on second arm, head reuse, and
teardown. It also includes negative tests for invalid map types and
verifier rejections.

> diff --git a/tools/testing/selftests/bpf/prog_tests/call_rcu.c b/tools/te=
sting/selftests/bpf/prog_tests/call_rcu.c
> new file mode 100644
> index 0000000000000..ccbfa9965d511
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/call_rcu.c

[ ... ]

> +/* Tear down the map and the program while a callback is still queued. */
> +static void test_call_rcu_teardown(void)
> +{
> +	LIBBPF_OPTS(bpf_test_run_opts, opts);
> +	struct call_rcu *skel;
> +
> +	skel =3D call_rcu__open_and_load();
> +	if (!ASSERT_OK_PTR(skel, "skel_open_and_load"))
> +		return;
> +
> +	/* The callback re-arms after the last user reference is gone; that mus=
t be refused. */
> +	skel->bss->chain =3D 1;
> +	ASSERT_OK(bpf_prog_test_run_opts(bpf_program__fd(skel->progs.arm), &opt=
s), "test_run");
> +	call_rcu__destroy(skel);
> +}

[Severity: Medium]
Does this test actually verify that the re-arming was refused?

It looks like we set chain to 1, run the program, and then immediately
destroy the skeleton without waiting for the callback to run or asserting
the value of chain_err.

If a kernel regression allowed the re-arm to succeed, would this test just
silently pass without catching the failure?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260907134552.1772=
405-1-puranjay@kernel.org?part=3D2
