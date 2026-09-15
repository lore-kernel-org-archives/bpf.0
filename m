Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DA014B66CE
	for <bpf@vger.kernel.org>; Tue, 15 Sep 2026 17:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789493446; cv=none; b=kayE4M15IwnkbzXmAAaTBBL6EeUPpqIo4DXYq1nCL/nopTIKTdOcIoyEfI8H8NrL1RJx+t16WOpm4QTzxbrvkK34rQ980F1HxodRlLjbAq0h45YBspUAmZwQBMkvIaG6ev+JU9RDgaFADHSYuSiNGL2OY6QPBbQcUZN0+vrcsjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789493446; c=relaxed/simple;
	bh=S1cixK/0fY7TKRVEToptEVHaIegtSEg7zKEAc+A20vY=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=EQnU+VbYfwA1FVICx4hjRYn6O3YVg1otJJCFq39ZYi9K30y+ZaCtAMv2l+qWSgAlX/f8IwfSA92QOEGTsXaLOdFlomrRbrQkigC26QeSjNB2gvOs5HA2ZS1O/BHbaEJ01IqdramA4Mrtd8p78mveGcSYJYtIWxbFhYqWObglX0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=me+2xlo6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="me+2xlo6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D7D71F000FF;
	Tue, 15 Sep 2026 17:30:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789493445;
	bh=T6odX49Je+ApI01t+NLPhdQB2MKWOZ2s7lRgR5/htAg=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=me+2xlo60iH+1Il+I+lOxp+3NFbIVjixRFC9vNL4K5UwTcxV0HjjvgQk11IJ34pp/
	 ayvNQU35yZ2xXpk1QNgCuD0sYe5VovXIITPSLJ5amLpe3yNoHBWnn1TUpMKqdNBoXu
	 gu9zIz8bAGHcb1v7TACSxQVtxmdI+t6X+W9lFGHzcxiUBt96X84vjRcptsej1t5XY4
	 gp9EHT/eBfDos9J7aV7btTJprc0VtEwxavVLTdFuU7q+DMlmmrDnGkoiLLhEESZWL2
	 DTe5Y8lmTgBiikmiMLIK559mAJcAFedc2wuCCuXc3q2N0r4fOD9Mrkzn9sUqIXh4X+
	 noGp43TTMiyWA==
Content-Type: multipart/mixed; boundary="===============1665372298902232021=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <48d2443d95eb85c1009861ee565e84225e6e6041746fdcdda72ed214cca60c59@mail.kernel.org>
In-Reply-To: <20260915162252.473044-3-caomingpei@gmail.com>
References: <20260915162252.473044-3-caomingpei@gmail.com>
Subject: Re: [PATCH bpf v3 2/2] selftests/bpf: Test local struct_ops bitfield rejection
From: bot+bpf-ci@kernel.org
To: caomingpei@gmail.com,bpf@vger.kernel.org
Cc: caomingpei@gmail.com,andrii@kernel.org,eddyz87@gmail.com,ameryhung@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Tue, 15 Sep 2026 17:30:44 +0000 (UTC)

--===============1665372298902232021==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/prog_tests/test_struct_ops_module.c b/tools/testing/selftests/bpf/prog_tests/test_struct_ops_module.c
> index 75a0dea511b3f..03f86abafeb7c 100644
> --- a/tools/testing/selftests/bpf/prog_tests/test_struct_ops_module.c
> +++ b/tools/testing/selftests/bpf/prog_tests/test_struct_ops_module.c
> @@ -150,6 +150,36 @@ static void test_struct_ops_not_zeroed(void)
>  	struct_ops_module__destroy(skel);
>  }
>
> +static void test_struct_ops_local_bitfield(void)
> +{
> +	struct struct_ops_module *skel;
> +	char *log = NULL;
> +	int err;
> +
> +	skel = struct_ops_module__open();
> +	if (!ASSERT_OK_PTR(skel, "struct_ops_module_open_local_bitfield"))
> +		return;
> +
> +	bpf_map__set_autocreate(skel->maps.testmod_zeroed, false);
> +	err = bpf_map__set_autocreate(skel->maps.testmod_local_bitfield, true);
> +	if (!ASSERT_OK(err, "enable_local_bitfield_map"))
> +		goto cleanup;

This isn't a bug, but since bpf_map__set_autocreate() can only fail once
the map exists, could the second call drop the err variable and ASSERT_OK
check?  The other callers in this file at lines 75 and 199 call it
unchecked between __open() and __load().

[ ... ]

> @@ -304,6 +334,8 @@ void serial_test_struct_ops_module(void)
>  		test_struct_ops_load();
>  	if (test__start_subtest("struct_ops_not_zeroed"))
>  		test_struct_ops_not_zeroed();
> +	if (test__start_subtest("struct_ops_local_bitfield"))
> +		test_struct_ops_local_bitfield();
>  	if (test__start_subtest("struct_ops_incompatible"))
>  		test_struct_ops_incompatible();
>  	if (test__start_subtest("struct_ops_null_out_cb"))

[ ... ]

> selftests/bpf: Test local struct_ops bitfield rejection
>
> Add a local struct_ops type with a bitfield absent from the corresponding
> kernel BTF type. Verify that libbpf returns -ENOTSUP and emits the local
> bitfield diagnostic.
>
> Keep the existing all-zero scalar test as the compatibility control.

This isn't a bug, but could the last line be clarified?  The existing
zeroed test is not modified in this patch, and the message does not say
what specific behavior the new subtest guards against.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/34996121618
--===============1665372298902232021==--
