Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 017D8344DB9
	for <bpf@vger.kernel.org>; Mon, 13 Jul 2026 17:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783962816; cv=none; b=EZv/gtL0vvJNDEkD1S3Qdq0O3NwacxpIh8rJVabuXmPdFU0tknezPg0aZW4P7DCi707tBP+Ebuh6G8pfkG5MZ8M9msuckExRVaO5b3Smr6qffWcC+1lVnr1rvxhoVsgP/MR9wPCFMY7QcD4D2LM9/VJu/c/BIoDDK+KGR5Ybcz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783962816; c=relaxed/simple;
	bh=N7J1xsMVYWOAV16p9ftyRfvJpIpJ8zpIGZR8IfdtWpo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=NDQarmZi2O8Z/c+T7l2CIlRu3Fdo4ga5DrPjCYfXdhRDq7TcAMiSOa8zAKoK1bmSbslud2166tIT4s7/lz5cqrYYLW6A3n4oKLyegEUevHzvJOLfBnvaAVuiMo8Lg7WCa71Bss/nPZz3eSZjSrJtG7uScleUcrr0df02A0XBJE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gloTglxz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gloTglxz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A5A71F000E9;
	Mon, 13 Jul 2026 17:13:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783962814;
	bh=nB32rMgONiGnxlqlbJ53ICnPo8afGDKovkZAuAIaD7w=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gloTglxz5vrBXme+UFi0l7ddVilI0J+ZlG6IZ2WQQHdzSWhnsyeZOyM/kUsReAVtz
	 8xQJq2KnIPyv3ll8z+vTUhdvmhnomKIBq9Iz0nIld7dSqHcqiNwGXYTnWohg37dXPe
	 s1s5ffqM5defSlmeLEG4t7UhbGGHNr8siP6H6PF1WKT4yFIM+8IgVN6Awha/0+iF+B
	 +pHPJasVwnaD8eXuZ/0rGyOaHv0cxzwwmb2StdHxduooeYN5aa31VM/c5OI8OrxUCB
	 YTWuoSC5F8TU9JBrzvD3flj+e4IUGKFr6iQCs4KYmATJUAfxxkdkPGHgaso1L0nT/P
	 wpAyc6ntQeRxQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v9 6/9] selftests/bpf: Add tests to verify
 global percpu data
Reply-To: sashiko-reviews@lists.linux.dev
To: "Leon Hwang" <leon.hwang@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260713154024.30851-7-leon.hwang@linux.dev>
References: <20260713154024.30851-1-leon.hwang@linux.dev>
 <20260713154024.30851-7-leon.hwang@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 13 Jul 2026 17:13:33 +0000
Message-Id: <20260713171334.6A5A71F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The test `test_global_percpu_data_subskel` unconditionally asser=
ts that `var_cnt > 0`, but the compiled BPF object contains no non-percpu g=
lobal variables, meaning `var_cnt` will always be exactly 0 and the test wi=
ll reliably fail.
--

--- Patch [6]: [PATCH bpf-next v9 6/9] selftests/bpf: Add tests to verify g=
lobal percpu data ---
commit 3e1db5f1fcec57a130c30e415035e1b1944b5e17
Author: Leon Hwang <leon.hwang@linux.dev>

selftests/bpf: Add tests to verify global percpu data

This commit introduces tests for BPF global percpu data, verifying APIs like
bpf_map__set_initial_value() and bpf_map__initial_value(). It also adds a
subskeleton test to ensure that the live variables of a subskeleton do not
include those for global percpu data.

> diff --git a/tools/testing/selftests/bpf/prog_tests/global_percpu_subskel=
.c b/tools/testing/selftests/bpf/prog_tests/global_percpu_subskel.c
> new file mode 100644
> index 0000000000000..8aebd533d86b5
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/global_percpu_subskel.c
[ ... ]
> +	if (!ASSERT_OK_PTR(subskel->subskel, "subskel"))
> +		goto out;
> +	if (!ASSERT_OK_PTR(subskel->maps.percpu, "maps.percpu"))
> +		goto out;
> +	ASSERT_EQ(bpf_map__type(subskel->maps.percpu), BPF_MAP_TYPE_PERCPU_ARRA=
Y,
> +		  "percpu_map_type");
> +	ASSERT_GT(subskel->subskel->var_cnt, 0, "var_cnt");

[Severity: Medium]
Will this test unconditionally fail here?

Since all global variables in test_global_percpu_data.c are placed in .perc=
pu
sections:

int unused SEC(".percpu.looooooooong");
int data2 SEC(".percpu.data");
int data SEC(".percpu") =3D -1;

bpftool generates a subskeleton with a variable count of 0, because maps of=
 type
BPF_MAP_TYPE_PERCPU_ARRAY are skipped during subskeleton generation.

Thus, subskel->subskel->var_cnt should be exactly 0, which would cause this
assertion to fail.

> +
> +	for (i =3D 0; i < subskel->subskel->var_cnt; i++) {
> +		const struct bpf_var_skeleton *var;
> +
> +		var =3D (void *) subskel->subskel->vars + i * subskel->subskel->var_sk=
el_sz;
> +		ASSERT_NEQ(var->map, &subskel->maps.percpu, "var");
> +	}
> +

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260713154024.3085=
1-1-leon.hwang@linux.dev?part=3D6
