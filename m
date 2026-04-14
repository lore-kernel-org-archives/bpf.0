Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 496072E2850
	for <bpf@vger.kernel.org>; Tue, 14 Apr 2026 22:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776204531; cv=none; b=lUMl0ghNbFY7ZtsLm/YOzqd8pdULLmgUrIBlHGEzOQUYHeZ6h/MLZnD9sBbIchfh/SMYap+5J4jkDzia3R6EKfcV/d+ryNQoC//iNLCAyqwQ3pJw6cMsY+KH9UEkFWBNRIyvjCPlaPxONbtA2X7JPuAdDv1TMU/Ro9OQM+QkVhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776204531; c=relaxed/simple;
	bh=I1ED/dG1SqjPqTy+wJSpxO2qgMCYpgWcddxck7hVEXg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ks1KyJmofwggegvEMw94aooEZuU/a4cxDZjyoxccItvE09E4t6W8mLcvGwyr6Lz6QDNxwbhmkgMm6zA+1RSo3/H3H0J+FcOB9H1RuQ2nGirp+BUI+eMRJnXMAajX0VgJlGZd+htKekAbn+mpvEIG55QfC6ATjcfm1Fy3tgPcZi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hurlUWpD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hurlUWpD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6421C19425;
	Tue, 14 Apr 2026 22:08:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776204531;
	bh=I1ED/dG1SqjPqTy+wJSpxO2qgMCYpgWcddxck7hVEXg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=hurlUWpD5kLlM1OPz2kPpc63q9ANlMor4s05aUqZ5Nj67VtFcQKBQVlsu8OUDtF1x
	 tYb9HJOEtDPlD6X/FIK6Vp0ziidzEik2waDwiT6GDNOHHtHPi7as1rW9qkJvGG+kDz
	 70FwTHrfk3rO+prhhceHflHZy790CFpnRB4du9uR1yWfSFM2Qx6IhJtgscSK4Q+hHD
	 ggUZjXl2qjCPQiVs5ICnwsH17XUog15sbloO/OwqrdJLT4Lev4ZZKQP+TrWL2S0Se6
	 SQIf4/6VpuP7esZ0EgccEYUzPex8ZTpgn4LFJCDKpurHRzIJdq+1bpkQ5D534YsHbB
	 JmzK2PZll+1Gw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v4 8/8] selftests/bpf: Add a test to verify
 bpf_iter for global percpu data
Reply-To: sashiko@lists.linux.dev
To: "Leon Hwang" <leon.hwang@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260414132421.63409-9-leon.hwang@linux.dev>
References: <20260414132421.63409-9-leon.hwang@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 14 Apr 2026 22:08:50 +0000
Message-Id: <20260414220850.D6421C19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Sashiko AI review found 3 potential issue(s):
- [Medium] The `dump_percpu_data` program is autoloaded by default, breakin=
g existing subtests on older kernels.
- [Medium] Checking `err =3D=3D -EOPNOTSUPP` after skeleton load incorrectl=
y handles unsupported kernels.
- [Medium] Casting the global datasec to an anonymous C struct relies on fr=
agile compiler layout assumptions.
--

commit 1e00e3e2b318918e67a2c7d2e251132e1b985484
Author: Leon Hwang <leon.hwang@linux.dev>

selftests/bpf: Add a test to verify bpf_iter for global percpu data

Add a test to verify that it is OK to iter the percpu_array map used for
global percpu data.

> diff --git a/tools/testing/selftests/bpf/prog_tests/global_data_init.c b/=
tools/testing/selftests/bpf/prog_tests/global_data_init.c
> index 0b0384b6515ed..9ff09ff1981c4 100644
> --- a/tools/testing/selftests/bpf/prog_tests/global_data_init.c
> +++ b/tools/testing/selftests/bpf/prog_tests/global_data_init.c

[ ... ]

> @@ -269,6 +269,57 @@ static void test_global_percpu_data_verifier_failure=
(void)
> +static void test_global_percpu_data_iter(void)
> +{

[ ... ]

> +	err =3D test_global_percpu_data__load(skel);
> +	if (err =3D=3D -EOPNOTSUPP) {
> +		test__skip();
> +		goto out;
> +	}

Will this correctly skip on older kernels? When the kernel verifier
rejects an unsupported program type or feature during bpf_prog_load(),
it typically returns -EINVAL (or -EACCES), not -EOPNOTSUPP.

Libbpf passes this error code back to the caller, so this condition
might evaluate to false, causing the test to fail on the subsequent
ASSERT_OK(err) check instead of gracefully skipping.

[ ... ]

> diff --git a/tools/testing/selftests/bpf/progs/test_global_percpu_data.c =
b/tools/testing/selftests/bpf/progs/test_global_percpu_data.c
> index 947721c21f30c..0ddb820509ebf 100644
> --- a/tools/testing/selftests/bpf/progs/test_global_percpu_data.c
> +++ b/tools/testing/selftests/bpf/progs/test_global_percpu_data.c

[ ... ]

> +SEC("iter/bpf_map_elem")
> +__auxiliary
> +int dump_percpu_data(struct bpf_iter__bpf_map_elem *ctx)

Will this break existing subtests on older kernels? The bpf program
dump_percpu_data is defined with SEC("iter/bpf_map_elem") without the
? prefix, meaning libbpf will attempt to autoload it whenever
test_global_percpu_data__load() is called.

Since the existing init and lskel subtests also load the full skeleton,
they might inadvertently attempt to load this new iterator program.
Should this use SEC("?iter/bpf_map_elem") to prevent autoloading by
default, and only be explicitly autoloaded in the iter subtest?

> +{
> +	struct {
> +		int data;
> +		char run;
> +		struct {
> +			char set;
> +			int i;
> +			int nums[7];
> +		} struct_data;
> +		int nums[7];
> +	} *pptr =3D ctx->value;

Is it safe to cast the global datasec to an anonymous C struct like
this?

In the BPF source, these are declared as independent global variables.
The layout of these variables in the .percpu ELF section is determined
entirely by the compiler. While the current compiler version might emit
the uninitialized nums array after the initialized variables (matching
the struct layout), this relies on undocumented compiler behavior.

If the compiler alters the layout, or if variables are added or
initialized differently in the future, the field offsets will mismatch.
This could cause the step calculation to diverge from the map's actual
value_size, leading to out-of-bounds reads.

Would it be safer to group these variables into a single explicit struct
in the BPF code to guarantee their memory layout?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260414132421.6340=
9-1-leon.hwang@linux.dev?part=3D8
