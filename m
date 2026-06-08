Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EC0F3F8ED6
	for <bpf@vger.kernel.org>; Mon,  8 Jun 2026 15:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780932149; cv=none; b=E7LRCdwrfxUokvQ2gzdXBaX21CadNALdIqZUTc0AiQoAw0TsocnWDT5WLIWIjCIABLOguaq4abU8S6Y8gNu0tdMtnORIW03dO9r2TAnMCz4ljLy0pCG3SPlUwq3w4yt9kcTycgegFEyKj7MK/nqM6xLZsVFJCQZ7qM3ybQgSWu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780932149; c=relaxed/simple;
	bh=zBxWNviSMZIC+obdkpta5aNFbLZIAHeE9RKj1FwB5jQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=AmBmNhCUrDYzMXmQlGIeF/VgZmjEiQJcd6MMdFrHWIkLrjiek5tbd+3/A11efVaV14LXyLUQ8VobTkhtbzJuEViqhmL4hCxEz6u66/0pk4nKZ+TF4F8bxPohXbE/TviYgL5LhSTjv24scqwyiTOJ7iinWZgxkFbdK+FQUN80gHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MgLzPu/D; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MgLzPu/D"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E39071F00893;
	Mon,  8 Jun 2026 15:22:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780932148;
	bh=njRVmNhcXNoaglLQrRWb0+CB2LnesgpHsEPN8z7axVA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MgLzPu/DGq/0QeObh/pA23zh9fSXix0Or5WZgbxS+25S6C50TqwXuX0yLqWQJ4E8H
	 6RAHRQiXq3tijXlWh1EAQuafHKmDYc3p0xvh5kacFaSBjxY/uVJmJH0Bop3QtmZxKo
	 zn6YPNsppPoIIIWLbgaIHDlJmepKBY1/PntCf7EGUtgrdcni20rIs6L9YZrJvRkUP2
	 xJBrf6dAnUV8nPZIijMeGxEVLst5gIXmavK6tfmJdcypE/kC7r48FU+zc3V0sg3uaT
	 HdZNjK5gyvsrMaMXU2wI+wHD96xG9UHOJ4gF8b8ml+4O+vOJwlI348+SEyvNOrKupy
	 3Xo7hFzxaBU3A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v5 7/9] selftests/bpf: Add tests to verify
 verifier log for global percpu data
Reply-To: sashiko-reviews@lists.linux.dev
To: "Leon Hwang" <leon.hwang@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260608145113.65857-8-leon.hwang@linux.dev>
References: <20260608145113.65857-8-leon.hwang@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 08 Jun 2026 15:22:27 +0000
Message-Id: <20260608152227.E39071F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] `RUN_TESTS` macro is incorrectly wrapped inside `test__start_sub=
test()`, which breaks the subtest hierarchy.
--

commit 1dcc43260f6040ba128a20fe56dd3f75bb90a451
Author: Leon Hwang <leon.hwang@linux.dev>

selftests/bpf: Add tests to verify verifier log for global percpu data

This patch adds two tests to verify the verifier log output when a
percpu_array map is incorrectly used as a const string.

> diff --git a/tools/testing/selftests/bpf/prog_tests/global_data_init.c b/=
tools/testing/selftests/bpf/prog_tests/global_data_init.c
> --- a/tools/testing/selftests/bpf/prog_tests/global_data_init.c
> +++ b/tools/testing/selftests/bpf/prog_tests/global_data_init.c
[ ... ]
> @@ -244,6 +244,11 @@ static void test_global_percpu_data_lskel(void)
>  	free(online);
>  }
> =20
> +static void test_global_percpu_data_verifier_log(void)
> +{
> +	RUN_TESTS(test_global_percpu_data);
> +}
> +
>  void test_global_percpu_data(void)
>  {
[ ... ]
> @@ -255,4 +260,6 @@ void test_global_percpu_data(void)
>  		test_global_percpu_data_init();
>  	if (test__start_subtest("lskel"))
>  		test_global_percpu_data_lskel();
> +	if (test__start_subtest("verifier_log"))
> +		test_global_percpu_data_verifier_log();

[Severity: Medium]
Does this accidentally break the subtest hierarchy?

The BPF selftests framework does not support nested subtests, and
test__start_subtest_with_desc() explicitly calls test__end_subtest() if a
subtest is already active.

Because RUN_TESTS() internally creates a new subtest for each program in the
skeleton, invoking test_global_percpu_data_verifier_log() while the
"verifier_log" subtest is active will immediately terminate the "verifier_l=
og"
subtest.

This causes the parent subtest to falsely report as passing with zero
assertions, and the skeleton tests will run as flat peer subtests rather th=
an
being logically grouped.

Could RUN_TESTS() be used directly here without wrapping it in
test__start_subtest()?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260608145113.6585=
7-1-leon.hwang@linux.dev?part=3D7
