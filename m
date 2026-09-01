Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2982148EBF6;
	Tue,  1 Sep 2026 17:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788285345; cv=none; b=VxKOD/iUeuZ0ScOSy+L4z9pUYeGfI9jdoDjOju7ZNyf5FzovOwDh5zu6X/Kw1a8eBEw/8yfSwGrRcXOx58HUnNjK98FawPayvhQDzJFH2TctyinJPW4gBbfotJ8u1RKPUhbpHOrQEiI2oYb1aCl77rZF3eOnLoYo6CKUGrrnJ+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788285345; c=relaxed/simple;
	bh=vqWQtFJqfX2qOyt45Ut+vk+sNeFAmxTYniQldE1sLXM=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=R8Nkj2dIL71u1NPq27mE3/D9ZCLNT4Inp9/WPtSQtEE6tyayDMdlr3vreHZTIjJl0vTCpuYGsb5tur9sr78lsooABZbUKV+EtqSv4VN1eZR37aqqMU8N/Wgl5hJ+sfBjyjeymSWku9VvaR2/KOUTdskuFcaGMKOjHgzJPLuYrvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jil2ZM55; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jil2ZM55"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64B3D1F000E9;
	Tue,  1 Sep 2026 17:55:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788285343;
	bh=QYabS1h7Iv/peRTFVV1hkAMf06F9tNbwGx8datua2LM=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=Jil2ZM55O9gE8gmZl+L/Iesoe3mSzTQBXyKV4wZM+EQCIIXM4dS4klm4wYUOopZyL
	 Zp4F4s8cD0QplJfOP0nrfom33I2T1bFzJumVPwNzudtg8JPQAeo2Ed6jeTynvCBCKx
	 FGcZxnpfcHi6q1hRuxNcBBIWhj5oPO9ePG0nZ4f4EhPSL73zr+OOb5RqoU48JMv2EP
	 OYQ0xXmJkBgOzMx4fZ8VBe7B90ehjnBUP5Dv1vVt459/GOTv7/fx881bRJ8QsDgrcS
	 woDzTguknZMw2mooePlPYHm4De3xkkL65V986dDDYtB9tUw/tgY8GvbTJGNLy1pjf/
	 VU8g+SY/rD9qQ==
Content-Type: multipart/mixed; boundary="===============7112936476057156357=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <c5344d940af49de41a500e96318bb7375ea493c0e491493c316eeba4c64859f8@mail.kernel.org>
In-Reply-To: <20260901165757.801449-9-alan.maguire@oracle.com>
References: <20260901165757.801449-9-alan.maguire@oracle.com>
Subject: Re: [PATCH v2 bpf-next 08/18] selftests/bpf: Validate that btf__permute transfer works
From: bot+bpf-ci@kernel.org
To: alan.maguire@oracle.com,ast@kernel.org,andrii@kernel.org
Cc: daniel@iogearbox.net,eddyz87@gmail.com,jolsa@kernel.org,ihor.solodrai@linux.dev,yonghong.song@linux.dev,song@kernel.org,qmo@kernel.org,martin.lau@linux.dev,memxor@gmail.com,emil@etsalapatis.com,mcgrof@kernel.org,petr.pavlu@suse.com,tj@kernel.org,kees@kernel.org,bpf@vger.kernel.org,nathan@kernel.org,nsc@kernel.org,arnd@arndb.de,puranjay@kernel.org,yatsenko@meta.com,atenart@kernel.org,ojeda@kernel.org,linux-modules@vger.kernel.org,alan.maguire@oracle.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Tue,  1 Sep 2026 17:55:42 +0000 (UTC)

--===============7112936476057156357==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> selftests/bpf: Validate that btf__permute transfer works
>
> Add coverage for btf__permute() transfer mode, including type-ID
> remapping and LOCSEC record ordering in the resulting split BTF.
>
> Verify string handling for both cases: a string used only by transferred
> types is removed from the base BTF and deduplicated locally in the split
> BTF, while a string also referenced by a retained base type remains a
> base-string reference.
>
> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>

This isn't a bug, but would it be worth a sentence in the changelog for
the new permute_layout subtest too, so the layout-section coverage is
visible without reading the diff?

The commit message describes the transfer mode coverage in detail, but the
patch also adds test_permute_layout() which builds a BTF with .add_layout
= true, permutes it with a transfer, and re-parses btf__raw_data() to
verify the layout/string section offsets stayed consistent.

> diff --git a/tools/testing/selftests/bpf/prog_tests/btf_permute.c b/tools/testing/selftests/bpf/prog_tests/btf_permute.c
> index 04ade5ad77ac..ef75fd71df96 100644
> --- a/tools/testing/selftests/bpf/prog_tests/btf_permute.c
> +++ b/tools/testing/selftests/bpf/prog_tests/btf_permute.c

[ ... ]

> +/* Permuting BTF with a layout section must keep section offsets in sync. */
> +static void test_permute_layout(void)
> +{
> +	LIBBPF_OPTS(btf_new_opts, opts, .add_layout = true);
> +	LIBBPF_OPTS(btf_permute_opts, permute_opts);
> +	struct btf *btf, *parsed, *transfer_btf = NULL;
> +	const void *raw;
> +	__u32 raw_sz;
> +	__u32 permute_ids[] = { 0, 1, BTF_PERMUTE_ID_TRANSFER | 2 };
> +	int err;
> +
> +	btf = btf__new_empty_opts(&opts);
> +	if (!ASSERT_OK_PTR(btf, "empty_layout_btf"))
> +		return;
> +
> +	btf__add_int(btf, "int", 4, BTF_INT_SIGNED);
> +	btf__add_ptr(btf, 1);
> +	permute_opts.transfer_btf = &transfer_btf;
> +	err = btf__permute(btf, permute_ids, ARRAY_SIZE(permute_ids), &permute_opts);
> +	if (!ASSERT_OK(err, "btf__permute_layout"))
> +		goto cleanup;
> +
> +	raw = btf__raw_data(btf, &raw_sz);
> +	parsed = btf__new(raw, raw_sz);
> +	if (!ASSERT_OK_PTR(parsed, "parse_permuted_layout"))
> +		goto cleanup;
> +	btf__free(parsed);
> +cleanup:
> +	btf__free(transfer_btf);
> +	btf__free(btf);
> +}
> +
>  void test_btf_permute(void)
>  {
>  	if (test__start_subtest("permute_base"))
>  		test_permute_base();
>  	if (test__start_subtest("permute_split"))
>  		test_permute_split();
> +	if (test__start_subtest("permute_transfer"))
> +		test_permute_transfer();
> +	if (test__start_subtest("permute_layout"))
> +		test_permute_layout();
>  }


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/33537080133
--===============7112936476057156357==--
