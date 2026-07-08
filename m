Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B2382D949F
	for <bpf@vger.kernel.org>; Wed,  8 Jul 2026 08:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783498476; cv=none; b=BjlhM7Z7MMZO5TWgALPWs0c4upGfIyqlJK4MTgqMC8rAGk1oSxAc5oXYEIuVqGl64Jrd42bXgVQ7Xe5F24Q4aJjGj2vhFtxLBNzwCAL1OMJiKStlTq5FUiJjJmYpoES8VuLJJ2Sve+WeMriySzXs7JECfYF/iUGxH4zi/oPIJ68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783498476; c=relaxed/simple;
	bh=rGr7jsGj/fmzmMOBL09z7m+IJSpM/v+IO0JZqXltO54=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=eRoCiEa1meL2yvEHh2PRM+VtmXq+newOuJxZTv+vuyjzGQOCVzR0/UWD4ICKxerpJ36/bI7NsqmhujPcrCqgxB3TiazRdcfXQXqoG1WJ0jWcdqI0ZvCN59gyprBmSFQhYq4+sKOdg2bf8KtcCLz1jnCDEfaWXJgqk3RyT5PNivQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PS9SOJ1l; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PS9SOJ1l"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCAFA1F000E9;
	Wed,  8 Jul 2026 08:14:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783498474;
	bh=5CgbMgvDJ+L94bPUI3jeV97/02WZ0AS2uqPWYmzgy0o=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PS9SOJ1lbnBQsw1c5QWakcXsexO6Y/drKIj05znqJIr7PRJ6djaMxq+ncxefQ5Mu8
	 oSjnCUM4uxuZUZRCJH4GbX2TwUAQOUKyKbMqYrrJY7xhnq6ldzzvCZ8GewY1M5YueT
	 /l6SxVdB3tQIKm6vynltgN+NPrORrRNR5NJ1hAHGH5F/awDKdqAAjl5YiJgGOvWmUn
	 UEF5AEDWj1BSGkTm+z4anpc6jmwg6QzZKCp0642U0ErgGK+NjnX68nCPUDq6lN5KZh
	 lPWlnbv8mz173/9imoTQgDY+BJzIL5/235k+4n9hp534dpim0/mIPzqBX5mrtAUH11
	 UKawlbdlRck9A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v6 6/8] selftests/bpf: Adjust bpf_map layout in
 verifier_map_ptr
Reply-To: sashiko-reviews@lists.linux.dev
To: "Daniel Borkmann" <daniel@iogearbox.net>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260708075343.358712-7-daniel@iogearbox.net>
References: <20260708075343.358712-1-daniel@iogearbox.net>
 <20260708075343.358712-7-daniel@iogearbox.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 08 Jul 2026 08:14:34 +0000
Message-Id: <20260708081434.BCAFA1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Stale test logic in `signed_loader.c` causes selftest suite fail=
ure due to removed in-loader metadata checks.
--

--- Patch [6]: [PATCH bpf-next v6 6/8] selftests/bpf: Adjust bpf_map layout=
 in verifier_map_ptr ---
commit 57fd96aa0d68880807526c20a038bd95f1762aa4
Author: Daniel Borkmann <daniel@iogearbox.net>

selftests/bpf: Adjust bpf_map layout in verifier_map_ptr

This patch adjusts the selftest verifier expectations for bpf_map's memory
layout. It updates tests to reflect the removal of the write-only excl memb=
er,
moving ops to offset 32 and inner_map_meta to offset 40.

> diff --git a/tools/testing/selftests/bpf/progs/verifier_map_ptr.c b/tools=
/testing/selftests/bpf/progs/verifier_map_ptr.c
> index 1661936598703..e0a65835c861b 100644
> --- a/tools/testing/selftests/bpf/progs/verifier_map_ptr.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_map_ptr.c
[ ... ]
> @@ -97,23 +98,23 @@ __naked void read_non_existent_field_rejected(void)
>  }
> =20
>  /*
> - * The u32 excl field spans offsets 32..35 (mend 36). Reading a u32 at o=
ffset
> - * 33 starts inside excl but extends past its end, which the verifier re=
jects
> + * The sha byte array spans offsets 0..31 (mend 32). Reading a u32 at of=
fset

[Severity: Medium]
Since this series removes the excl field and emit_signature_match(), did we
miss updating tools/testing/selftests/bpf/prog_tests/signed_loader.c?

When running test_progs, test_signed_loader() calls metadata_check_shape(),
which fails here because it still expects the loader to read the removed
excl field at offset 32 and relies on emit_signature_match():

check_sig_match_shape() {
	...
	if (!ASSERT_GE(a, 0, "emit_signature_match present"))
		return;
	...
	/* excl check: r2 =3D *(u32 *)(map + 32); if r2 !=3D 1 goto cleanup */
	ASSERT_EQ(in[a + 2].code, (BPF_LDX | BPF_MEM | BPF_W), "excl load width");
	ASSERT_EQ(in[a + 2].off, SHA256_DIGEST_LENGTH, "excl field offset");
	...
}

Tests like metadata_sha_mismatch also seem to rely on the removed in-loader
hash check to reject tampered maps, meaning they might now unexpectedly run
successfully and fail their ASSERT_EQ(r, -EINVAL) verifications. Can this
cause the selftests suite to fail?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260708075343.3587=
12-1-daniel@iogearbox.net?part=3D6
