Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF390381E86;
	Tue,  1 Sep 2026 17:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788285334; cv=none; b=Snx3QpmhCMm93u9AwchxJPTlt1TzA0jEYnCl1OUSiI/k5z9nrffLQHUwal6LX3MTBgFwZ4D8146vFKk1+TN69qH945kRaoN7MhvpP2b6zhFV5apQgwt3KiVdvsWNWm3jzvjphI1KqWM2h9NYFisqgZpUFOYXzFn5izDI1Pnb8fE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788285334; c=relaxed/simple;
	bh=YASXxzuwk3jc+RybNf3xt04Vg4coME2BmXX1HYU1q6Q=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=WEZ7iz35S0KkJUtCNZo6nHdzCgO81EAtfM2l0mrzE9ttp8tSpOyb1a28Gg5uFz0DOM0aPGbOPF6Lb5VsObDFce2x6kdSlaKbAZpmN+zR8+w/fhYMiJEfbTWkmwk7OrXp4e1ZWWxXktiW9DcmtMVcL6thKkvbZDPOqfCjDTQZULQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d0dYf45o; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d0dYf45o"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15D541F00A3A;
	Tue,  1 Sep 2026 17:55:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788285332;
	bh=2bniolO/aINAsdJH6ksIVa7PNFaLmVjDb7J4V9QZpXc=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=d0dYf45oTHTgjyrPX7CotDknK6yg0X+J3G8RIoIqQaTRqGHQmq8qO6o/FEbovwqt3
	 FCCVF/OnFlzYkdnNeCHkft0ybFmxiwPNfBFNNXOP1yeaUR3KKo/pVD6cEKVuykUKcX
	 pyiD40RfJ1iutAQRyaBqs9KQyECMU9+ume6+m0LQxQeRE+k2ziiU7ERhJLLpPygrmY
	 6ww4CcNOaDmUCBq8VXNI7C6tydA7odZWAodRKJhEin8tamr2qhOEX9yaDnStmcdhIs
	 Lvgv6c4gMG6viyNAJ/xEaM0syWi2YK4vcLhd4WjRHtPobJfJI1T5+MqpasVuDn6sHD
	 93bK4sIMYC88A==
Content-Type: multipart/mixed; boundary="===============7559018127272805319=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <658365121007638105983f9612ad2372e23f2df39580d90d72239813cf8fa104@mail.kernel.org>
In-Reply-To: <20260901165757.801449-8-alan.maguire@oracle.com>
References: <20260901165757.801449-8-alan.maguire@oracle.com>
Subject: Re: [PATCH v2 bpf-next 07/18] selftests/bpf: BTF distill tests to ensure LOC[_PARAM|_PROTO] add to split BTF
From: bot+bpf-ci@kernel.org
To: alan.maguire@oracle.com,ast@kernel.org,andrii@kernel.org
Cc: daniel@iogearbox.net,eddyz87@gmail.com,jolsa@kernel.org,ihor.solodrai@linux.dev,yonghong.song@linux.dev,song@kernel.org,qmo@kernel.org,martin.lau@linux.dev,memxor@gmail.com,emil@etsalapatis.com,mcgrof@kernel.org,petr.pavlu@suse.com,tj@kernel.org,kees@kernel.org,bpf@vger.kernel.org,nathan@kernel.org,nsc@kernel.org,arnd@arndb.de,puranjay@kernel.org,yatsenko@meta.com,atenart@kernel.org,ojeda@kernel.org,linux-modules@vger.kernel.org,alan.maguire@oracle.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Tue,  1 Sep 2026 17:55:31 +0000 (UTC)

--===============7559018127272805319==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/prog_tests/btf_distill.c b/tools/testing/selftests/bpf/prog_tests/btf_distill.c
> index fb67ae195a73..f433b29ffce9 100644
> --- a/tools/testing/selftests/bpf/prog_tests/btf_distill.c
> +++ b/tools/testing/selftests/bpf/prog_tests/btf_distill.c
> @@ -671,6 +671,80 @@ static void test_distilled_base_embedded_err(void)
>  	btf__free(btf1);
>  }
>
> +/* LOC_PARAM, LOC_PROTO should be added to split BTF. */
> +static void test_distilled_loc(void)
> +{
> +	struct btf *btf1 = NULL, *btf2 = NULL, *btf3 = NULL, *btf4 = NULL;
> +
> +	btf1 = btf__new_empty();
> +	if (!ASSERT_OK_PTR(btf1, "empty_main_btf"))
> +		return;
> +
> +	btf__add_int(btf1, "int", 4, BTF_INT_SIGNED);	/* [1] int */
> +	btf__add_func_proto(btf1, 1);                   /* [2] int (*)(int); */
> +	btf__add_func_param(btf1, "p1", 1);
> +	btf__add_func(btf1, "foo", BTF_FUNC_STATIC, 2);	/* [3] int foo(int); */
> +	btf__add_loc_param(btf1, 4, BTF_LOC_PARAM_SIGNED | BTF_LOC_PARAM_CONST);
> +	btf__add_loc_param_value(btf1, -1);		/* [4] loc value */
> +
> +	VALIDATE_RAW_BTF(
> +		btf1,
> +		"[1] INT 'int' size=4 bits_offset=0 nr_bits=32 encoding=SIGNED",
> +		"[2] FUNC_PROTO '(anon)' ret_type_id=1 vlen=1\n"
> +		"\t'p1' type_id=1",
> +		"[3] FUNC 'foo' type_id=2 linkage=static",
> +		"[4] LOC_PARAM '(anon)' size=4 flags=0x3 vlen=1\n"
> +		"\tvalue=-1");
> +
> +	btf2 = btf__new_empty_split(btf1);
> +	if (!ASSERT_OK_PTR(btf2, "empty_split_btf"))
> +		goto cleanup;
> +
> +	btf__add_loc_proto(btf2);			/* [5] loc proto */
> +	btf__add_loc_proto_param(btf2, 4);		/*  param value */
> +
> +	btf__add_locsec(btf2, ".locs");			/* [6] locsec */
> +	btf__add_locsec_loc(btf2, 3, 5, 256);		/* "foo" offset 256 */

Does this test actually cover the LOC_PROTO relocation case? Looking at
btf__distill_base() in tools/lib/bpf/btf.c, the LOC_PROTO here is created
in the split BTF (btf2, id [5]), not in the base BTF.

When btf_add_distilled_type_ids() runs, the only reference to that
LOC_PROTO is the LOCSEC's loc_proto=5. Since split_start_id equals
btf__type_cnt(btf1) which is 5, the condition:

  if (*id >= dist->split_start_id)
      continue;

means id_map is only populated for ids 1 (INT), 2 (FUNC_PROTO), 3 (FUNC)
and 4 (LOC_PARAM). The BTF_KIND_LOC_PROTO case in btf_add_distilled_types()
is never reached.

The LOC_PROTO that appears in the expected btf4 dump is just the split
type copied verbatim by the unconditional "First add all split types" loop,
so it would be produced even if the LOC_PROTO handling in
btf_add_distilled_types() were missing.

The realistic case this series addresses is a module LOCSEC in split BTF
referring to a LOC_PROTO that dedup mapped into the vmlinux base BTF.
Wouldn't putting the LOC_PROTO (and its LOC_PARAM) in btf1 and only the
LOCSEC in btf2 test that scenario?

> +	VALIDATE_RAW_BTF(
> +		btf2,
> +		"[1] INT 'int' size=4 bits_offset=0 nr_bits=32 encoding=SIGNED",
> +		"[2] FUNC_PROTO '(anon)' ret_type_id=1 vlen=1\n"
> +		"\t'p1' type_id=1",
> +		"[3] FUNC 'foo' type_id=2 linkage=static",
> +		"[4] LOC_PARAM '(anon)' size=4 flags=0x3 vlen=1\n"
> +		"\tvalue=-1",
> +		"[5] LOC_PROTO '(anon)' vlen=1\n"
> +		"\ttype_id=4",
> +		"[6] LOCSEC '.locs' vlen=1\n"
> +		"\tfunc_type_id=3 loc_proto_type_id=5 offset=256");
> +
> +	if (!ASSERT_EQ(0, btf__distill_base(btf2, &btf3, &btf4),
> +		       "distilled_base") ||
> +	    !ASSERT_OK_PTR(btf3, "distilled_base") ||
> +	    !ASSERT_OK_PTR(btf4, "distilled_split") ||
> +	    !ASSERT_EQ(2, btf__type_cnt(btf3), "distilled_base_type_cnt"))
> +		goto cleanup;
> +
> +	VALIDATE_RAW_BTF(
> +		btf4,
> +		"[1] INT 'int' size=4 bits_offset=0 nr_bits=32 encoding=SIGNED",
> +		/* remainder is split BTF */
> +		"[2] LOC_PROTO '(anon)' vlen=1\n"
> +		"\ttype_id=6",
> +		"[3] LOCSEC '.locs' vlen=1\n"
> +		"\tfunc_type_id=5 loc_proto_type_id=2 offset=256",
> +		"[4] FUNC_PROTO '(anon)' ret_type_id=1 vlen=1\n"
> +		"\t'p1' type_id=1",
> +		"[5] FUNC 'foo' type_id=4 linkage=static",
> +		"[6] LOC_PARAM '(anon)' size=4 flags=0x3 vlen=1\n"
> +		"\tvalue=-1");

Also, six of the eight sibling tests in this file finish with a
btf__relocate() step plus a re-validation. Should this test similarly
round-trip the id fixups through relocation?

> +cleanup:
> +	btf__free(btf4);
> +	btf__free(btf3);
> +	btf__free(btf2);
> +	btf__free(btf1);
> +}
> +
>  void test_btf_distill(void)
>  {
>  	if (test__start_subtest("distilled_base"))
> @@ -689,4 +763,6 @@ void test_btf_distill(void)
>  		test_distilled_base_vmlinux();
>  	if (test__start_subtest("distilled_endianness"))
>  		test_distilled_endianness();
> +	if (test__start_subtest("distilled_loc"))
> +		test_distilled_loc();
>  }


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/33537080133
--===============7559018127272805319==--
