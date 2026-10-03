Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6904372B2F
	for <bpf@vger.kernel.org>; Sat,  3 Oct 2026 01:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790991187; cv=none; b=FCcH+UyZucwa60FtY5fiVFFl42tjUhzrQSuA+zqUrpusH+tdYI/46+yovtQDYlfE/g+61zEDUVKWNCH8vMcWpTHoM5zHVWvJhmfYRX2whRGxu7jg1yPiXxAmem67SrhS8feUWL7SvslWEfmEDeNGAU33fH2gAcOR1LeP5zu6Sdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790991187; c=relaxed/simple;
	bh=GH8vS/4DRQM3YfVULlKjZliXQQHPQFlv4DUbkxg9c5M=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=uENaq03SooepFBb6VSNXbH1jSiGy0ouzqKUxXNYD17dw6Gxto/qHFNu8sJgBj0EV/wj6lQjqlvC9q7PGaoYmkPqTyBzdaOU9MYovfWW8+mzt/6GLlYKddFOIXL8PzSnjVqm5ctitJuDwHvIJ1SzA0//evCxxcLmrkXhr7GS5gNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LSRHBxg+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LSRHBxg+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 493601F0089A;
	Sat,  3 Oct 2026 01:33:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790991186;
	bh=KhpCb2VdorSRXLv4PgZh9sUScDdEPYGuRYeiCQz0c/I=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LSRHBxg+rLBXrWw9IvFYeU1KG/PQC8+7k3ex0+JSAdeEdqidrBl7oBUZF6LNrpcXE
	 2nssN3Lv8qAT0wXEQ2gPvZ4yxd1Mckjwyr3nunweOorj5kjgyMBQySXzDNqGXiaOhh
	 Mmz4a1RXQIye/UN0n4wowCX7iZWtVzV09OxcGzJC1Brm9596QE+RVOF2wOsYiTplAz
	 lMF5nGmFFC2Ha/f73wM9E5xfKBJmMuiGy6dsPU/8TfGQMKVnsBXsWlccjOGMSBp92Q
	 Ix40G6lKqI0SMYjUVqIREt/wkvmyHuaniqkQgRXK+o+yVuhC0FXiPvQe/Zahp+wmQe
	 gfPKCoTR5S9Lg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v2 15/15] selftests/bpf: Add test for global
 data of a program in Rust
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20261002124714.180012-16-alexei.starovoitov@gmail.com>
References: <20261002124714.180012-1-alexei.starovoitov@gmail.com>
 <20261002124714.180012-16-alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 03 Oct 2026 01:33:05 +0000
Message-Id: <20261003013306.493601F0089A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] bpf: missing ASSERT_OK_PTR for bpf_object__find_program_by_name
--

commit 3ad0a944f5e1d8b874c6e4579bc0bb7941f6ed67
Author: Alexei Starovoitov <ast@kernel.org>

selftests/bpf: Add test for global data of a program in Rust

This commit adds a test to verify how libbpf handles global data (.data,
.bss, .rodata) of a Rust BPF program within an arena. It introduces a
new Rust program and dynamically loads the resulting object file using
manual libbpf APIs in data_in_arena.c.

> diff --git a/tools/testing/selftests/bpf/prog_tests/data_in_arena.c b/too=
ls/testing/selftests/bpf/prog_tests/data_in_arena.c
> index 86dc6798bbdef..cb1023507c017 100644
> --- a/tools/testing/selftests/bpf/prog_tests/data_in_arena.c
> +++ b/tools/testing/selftests/bpf/prog_tests/data_in_arena.c

[ ... ]

> +/* The object is there if rustc and clang can build it, see Makefile.bui=
ldvars */
> +static void test_rust(void)
> +{
> +	const char *file =3D "./data_in_arena_rust.bpf.o";
> +	struct bpf_object *obj;
> +
> +	if (access(file, R_OK)) {
> +		test__skip();
> +		return;
> +	}
> +	obj =3D bpf_object__open_file(file, NULL);
> +	if (!ASSERT_OK_PTR(obj, "open"))
> +		return;
> +	if (!ASSERT_OK(bpf_object__load(obj), "load"))
> +		goto out;
> +	/* libbpf goes on without BTF when the kernel doesn't take it */
> +	ASSERT_GE(bpf_object__btf_fd(obj), 0, "btf_fd");
> +	ASSERT_EQ(run_prog(bpf_object__find_program_by_name(obj, "list_in_data"=
)),
> +		  100 + 20 + 3, "retval");

[Severity: Medium]
Could this result in a crash if the program is not found in the object file?

bpf_object__find_program_by_name() returns NULL if the specified program is
not found. Passing this result directly into run_prog() without prior
validation via ASSERT_OK_PTR violates the BPF selftest guidelines for
manual lookup APIs, and might cause the test to crash instead of failing
cleanly.

> +out:
> +	bpf_object__close(obj);
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261002124714.1800=
12-1-alexei.starovoitov@gmail.com?part=3D15
