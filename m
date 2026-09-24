Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84D64477E4B
	for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 11:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790251002; cv=none; b=kuXdKnNtteIBr+a2RdKqaahA4nMhR/885lQuf+G8WgWSyl2+6p1vCeoKXNn58nOeGiGX43rEM0kpCOPSfG48YctHSZ+pCYDYNlf4cOA1Imj9Fi23htRJqnN+UIJiUghCrYc93UKdWoaenyM01VFRyBDYWFHLgaBBGL5L/hlpwvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790251002; c=relaxed/simple;
	bh=k9mG0tutrs7TNEirf/8Is3c4R5JOw830Hk9CYMc8ltc=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=FmMUeEaiSzkkgT8ru+UeUlRuNiJ3Sj4CuyAMnUjfiF24yfIfO4EsKBSt9IeoyO4ji+YgECZTIpixUszehn+U8Dm0XzAnMM1e+JJWfWjj/yPG5VN+c63pd1ipQcmjwATjbe0cIDQiBjrVOKmbGo2dkapsnz/b5NMbw03uCdr7LOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TBmpSORD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TBmpSORD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABB6A1F000FF;
	Thu, 24 Sep 2026 11:56:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790251001;
	bh=a1R/yxFPpbUs5jfu/37tdcGGw78L6e870GfYawJ1QPI=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=TBmpSORDCl1dXJ8Hn1cvxeULqJlvHpUokTouRjLhkHAYzclzrPnlhMjgFQ8rgzy25
	 QcVy2/z6MgDVyx3Hki+K74L9GiMitxTMs1rKxjMP2EN+hb+HbCQtFYCBnX6LpVb9y0
	 LdhRUiqHq9tr4X8R3zahGp/fFPDKW9r9oFUK4cFLsVvJUTainynz8M5ls0VsR8uHAJ
	 BViGN0UXyWGiCrIMkbK2cqDVZYBgwDDHygOdhenwi9TUj1fFEDXrfFx9fHilgsBf2Q
	 2Hh3J08ZSp2TrmvBKptWQXSywFQmQX4H778XEFiuVcM2lF3zg3z//uNOYGU7oyz1I/
	 iVqG7S/W4GsoQ==
Content-Type: multipart/mixed; boundary="===============8606195399061351096=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <b130801e8d8019e11df92d4e821281ca6c1b4e955556ce8076a17325c39b09b4@mail.kernel.org>
In-Reply-To: <20260924111428.75957-7-alan.maguire@oracle.com>
References: <20260924111428.75957-7-alan.maguire@oracle.com>
Subject: Re: [PATCH v4 bpf-next 06/11] selftests/bpf: BTF distill tests to ensure LOC[_PARAM|_PROTO] add to split BTF
From: bot+bpf-ci@kernel.org
To: alan.maguire@oracle.com,ast@kernel.org,andrii@kernel.org,eddyz87@gmail.com,qmo@kernel.org
Cc: jolsa@kernel.org,daniel@iogearbox.net,ihor.solodrai@linux.dev,yonghong.song@linux.dev,song@kernel.org,martin.lau@linux.dev,memxor@gmail.com,emil@etsalapatis.com,bpf@vger.kernel.org,nsc@kernel.org,puranjay@kernel.org,yatsenko@meta.com,alan.maguire@oracle.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Thu, 24 Sep 2026 11:56:38 +0000 (UTC)

--===============8606195399061351096==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/prog_tests/btf_distill.c b/tools/testing/selftests/bpf/prog_tests/btf_distill.c
> index fb67ae195a73..f0900b47fd48 100644
> --- a/tools/testing/selftests/bpf/prog_tests/btf_distill.c
> +++ b/tools/testing/selftests/bpf/prog_tests/btf_distill.c

[ ... ]

> +/* LOC_PARAM, LOC_PROTO should be added to split BTF. */
> +static void test_distilled_loc(void)
> +{
> +	struct btf *btf1 = NULL, *btf2 = NULL, *btf3 = NULL;
> +	struct btf *btf4 = NULL, *btf5 = NULL;
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
> +	btf__add_loc_proto(btf1);			/* [5] loc proto */
> +	btf__add_loc_proto_param(btf1, 4);		/*  param value */
> +	btf__add_int(btf1, "unsigned int", 4, 0);	/* [6] unsigned int */

[ ... ]

> +	btf2 = btf__new_empty_split(btf1);
> +	if (!ASSERT_OK_PTR(btf2, "empty_split_btf"))
> +		goto cleanup;
> +
> +	btf__add_locsec(btf2, "inline.text");		/* [6] locsec */
                                                            ^^^

Should this comment be [7] instead of [6]? The btf1 base already contains
types [1]..[6], so the first type added to split BTF btf2 gets ID 7. The
VALIDATE_RAW_BTF block below confirms this with "[7] LOCSEC 'inline.text'".

> +	btf__add_locsec_loc(btf2, 3, 5, 256);		/* "foo" offset 256 */
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
> +		"[6] INT 'unsigned int' size=4 bits_offset=0 nr_bits=32 encoding=(none)",
> +		"[7] LOCSEC 'inline.text' vlen=1\n"
> +		"\tfunc_type_id=3 loc_proto_type_id=5 offset=256");

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/35993586374
--===============8606195399061351096==--
