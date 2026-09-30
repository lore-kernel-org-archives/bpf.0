Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 008DF3DD849
	for <bpf@vger.kernel.org>; Wed, 30 Sep 2026 19:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790798013; cv=none; b=cE1Ft/MuFwA8I33ZYln22IhCkCUHdtgTJIaXtO3RqJfy2m6LHkyo0CkB6NI2YWvKRAvZaAqEVOytNB4mlS0+gYftt+Hz20YJh9Sb3qR9ufUb96faSYnNQ1LAHtbQZk/pE9kI04W+OcJlQh3z3ocSgRuvRrKbK0m92C/+RjDWUkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790798013; c=relaxed/simple;
	bh=j+bjH8DWR18jKw0wnZ26lUyO+IXQ1CDFuV0GtOSDG2I=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=fGneqSJbWi8ysaHKug31KVVySGYT2JiRN3S/U4yC17AXUZRVXVrtK8YxrFyahFK96VemkDVFm2XmbewqUj0dC7bUoEhiJI5MbgC4ANL20/NUnQG+Nl+8WFIE8/Rfy0qvZ5J9tvc/olDDSEJuRqCaRGBYVdZrEBNH7BVezd6b890=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eKSm8aa3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eKSm8aa3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 692711F000FF;
	Wed, 30 Sep 2026 19:53:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790798011;
	bh=Iayn9PdUUGiJk1zvFvcWo4jUAKQVCSxnQpIbS0+9Q3s=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eKSm8aa3QHSbBnLjBfEgcgM+AsGxNf24FVGnr4yQeRBAEsWOJHj+t602MgJWG19Ch
	 Vj0Iy3mueK0MdgMMHMWjPPScHtMIEt26J7Cb6Emlgxg4g2ivtE3fXpkur4OYr41tmV
	 Y9i3Utzy5dbvITSLjUVAHFvfyfjqs5ZrHkE4us/WLMLgEOg/kggWWH8EE75vRmTB/8
	 LtdHv4HsACcgStJ8W151c0TWoiy+xncR+WspIwsUuYsAr9IUhtVePWQ1zGR/2FlEQV
	 CtsA3zbCvEAzrSjjRXcBM+0O1l2wFWNnrDPpXAgeDgLBj1mWl/tjq/KWVGEU8+EX+U
	 uLN1UzlV/pokg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next 14/14] selftests/bpf: Add test for global data
 of a program in Rust
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260930193127.2181684-15-alexei.starovoitov@gmail.com>
References: <20260930193127.2181684-1-alexei.starovoitov@gmail.com>
 <20260930193127.2181684-15-alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 30 Sep 2026 19:53:30 +0000
Message-Id: <20260930195331.692711F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] selftests/bpf: missing mandatory ASSERT_OK_PTR validation for manua=
l prog lookup
--

commit 37e64ff11fb20edbe8afb99ff6fe32fab0d64ea7
Author: Alexei Starovoitov <ast@kernel.org>

selftests/bpf: Add test for global data of a program in Rust

This commit introduces a new test demonstrating how libbpf handles .data,
.bss, and .rodata for BPF programs written in Rust. It builds the program
using upstream rustc and evaluates it through the test_progs framework.

> diff --git a/tools/testing/selftests/bpf/prog_tests/data_in_arena.c b/too=
ls/testing/selftests/bpf/prog_tests/data_in_arena.c
> index bccfb0110b94b..d8bc489820b1e 100644
> --- a/tools/testing/selftests/bpf/prog_tests/data_in_arena.c
> +++ b/tools/testing/selftests/bpf/prog_tests/data_in_arena.c
[ ... ]
> +static void test_rust(void)
> +{
> +	const char *file =3D "./data_in_arena_rust.bpf.o";
> +	struct bpf_object *obj;
[ ... ]
> +	if (!ASSERT_OK(bpf_object__load(obj), "load"))
> +		goto out;
> +	/* libbpf goes on without BTF when the kernel doesn't take it */
> +	ASSERT_GE(bpf_object__btf_fd(obj), 0, "btf_fd");
> +	ASSERT_EQ(run_prog(bpf_object__find_program_by_name(obj, "list_in_data"=
)),
> +		  100 + 20 + 3, "retval");

[Severity: Low]
Is an ASSERT_OK_PTR() check missing for the program lookup here?

The BPF subsystem testing guidelines mandate that manual lookup APIs like
bpf_object__find_program_by_name() must be validated before use. If the
program named "list_in_data" is missing from the object, the lookup returns
NULL. Passing this unvalidated pointer directly to run_prog() will cause
bpf_program__fd(NULL) to fail the test run.

Validating the pointer first would ensure any failure explicitly indicates
the program was not found, rather than reporting an obscure return value
mismatch.

> +out:
> +	bpf_object__close(obj);
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260930193127.2181=
684-1-alexei.starovoitov@gmail.com?part=3D14
