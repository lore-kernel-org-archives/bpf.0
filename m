Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DB252F1FFC
	for <bpf@vger.kernel.org>; Wed, 27 May 2026 12:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779883316; cv=none; b=DsQB9VEUnltz6NhMkigjuUCSmBYfjayJagvHzw0vBTEnX1cJinfxvqAw8v+v83fEnlKb/eMBIDZ8T/9bArFlKkrgHRVGCuJ6unhaLOc5uhzgl27i2QFYrw5AslagdEz3djU+sBQbK8nY4XYw2FaxaLvbS2RVYAD+w52QGxk6ymU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779883316; c=relaxed/simple;
	bh=xRzbrtYzHMrIHoLUBvn89oxr4D5uJ6tWYljxEr0SKR8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ay6I7zlOTRM9BVHOuSdGwxRqC996iJcq99GkqeuSXs86pfJWjBJ4f24R4xY18nWiLhpvvubE5zNj2GORyFFoy9glz4BcXIYdGpwemmNupEfI8+GyfgwYmn7+ytFTjclmYo4AEJh2GzSalCLsVECB1h5sfejpSOhfCOLoQs/Xkbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VuEDPrfw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VuEDPrfw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9997E1F00A3A;
	Wed, 27 May 2026 12:01:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779883314;
	bh=qFzGy/f3uaw+FTKXLbpD1E3jBuaankdUKRvzr589sYQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VuEDPrfwLniV48FPMyOG8sAnc7xllYhdvA9CFAltPRbcaZ0YH2xqbViOY/pjfUNYG
	 4vWpUBjR6+a2zGCBth/MqzHzP/atM3vXkoIwRd8Yk/jvP5kA+csSPEHGRbjXhCVxMl
	 eDoqOd1Pu1BuSwTC9VPl6TtWwWRWY56Nh13ZU1etpE+7UUmwTYTFjIqVK/fvh9497j
	 S6eXy1Euts3Z4m5N0atv1FIKW/1Z7/6ccW3sLsVe2JnmoqET7GiRxs/PvzAObxUcKY
	 3WN8jo/uCttpK89zZ8yTmpfZEsrT2MiO1nE/F8HLxVYDOBOD4xPY36ysKqcfoZxkL0
	 PZ6U/7qctuFrg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCHv6 bpf-next 21/29] selftests/bpf: Add tracing multi
 skel/pattern/ids attach tests
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jiri Olsa" <jolsa@kernel.org>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260527113951.46265-22-jolsa@kernel.org>
References: <20260527113951.46265-22-jolsa@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 27 May 2026 12:01:53 +0000
Message-Id: <20260527120154.9997E1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Memory leak of the `ids` array and returning an invalid pointer =
on `tsearch` failure.
--

commit 9ced96ba89ac124e685ef4f6b4b49d9124c48bef
Author: Jiri Olsa <jolsa@kernel.org>

selftests/bpf: Add tracing multi skel/pattern/ids attach tests

This commit adds tests for tracing_multi link attachment using various
libbpf APIs, including skeleton, function pattern, and BTF ids.

> diff --git a/tools/testing/selftests/bpf/prog_tests/tracing_multi.c b/too=
ls/testing/selftests/bpf/prog_tests/tracing_multi.c
> new file mode 100644
> index 0000000000000..e290513358d9c
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/tracing_multi.c

[ ... ]

> +static __u32 *get_ids(const char * const funcs[], int funcs_cnt, const c=
har *mod)
> +{

[ ... ]

> +	ids =3D calloc(funcs_cnt, sizeof(ids[0]));
> +	if (!ids)
> +		goto out;
> +
> +	/*
> +	 * We sort function names by name and search them
> +	 * below for each function.
> +	 */
> +	for (i =3D 0; i < funcs_cnt; i++) {
> +		if (!tsearch(&funcs[i], &root, compare)) {
> +			ASSERT_FAIL("tsearch failed");
> +			err =3D -1;
> +			goto out;
> +		}
> +	}

[ ... ]

> +	if (err) {
> +		free(ids);
> +		ids =3D NULL;
> +	}
> +
> +out:
> +	tdestroy(root, tdestroy_free_nop);
> +	btf__free(vmlinux_btf);
> +	btf__free(btf);
> +	return ids;
> +}

[Severity: Medium]
Does this error path leak the ids array and return an invalid pointer?

If tsearch() fails, the code sets err =3D -1 and jumps to the out label.
However, the out label is placed after the if (err) cleanup block that is
supposed to free ids and set it to NULL.=20

Because the cleanup is bypassed, ids is leaked. Furthermore, the caller
will receive a non-NULL pointer, which will incorrectly pass the
ASSERT_OK_PTR check and cause the test to proceed using an array of zeros.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260527113951.4626=
5-22-jolsa@kernel.org?part=3D1
