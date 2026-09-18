Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA64951DDEA
	for <bpf@vger.kernel.org>; Fri, 18 Sep 2026 19:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789761549; cv=none; b=H6v96I+65CAcvIC4TvP11jV2bk3Sxw8W9vRP2Vbxel1Wo9iD/OurCn/Phnsejk75q0pFZ0FEq6jbuxD/wcD//pWdMgHU0UsSOg1DKgA4HZD+nfWrC0jAlPfOL4p58aPvcLkfOiUr1OSv7q32OUf7VsGAW6xjRtxPeyVogCHJEyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789761549; c=relaxed/simple;
	bh=Hh8kBKTJavRfG7N4/6Jk5gLFI7aM6VtW/cLN5AJI24c=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GMg1WnzJ6sHUVkZbZsCKdYDLI4KKRqB/5Gk1mAkEtLvYNFOnmvxZ63IFXtVgIwW+TrETea+YzOXTKHvnt1Oead/M6MGdMhthXTfNIDSufOZ1U79E3YcLdVtWL1YQciWzJYviTt+UgbYQJ6ly9eONa0+dA3o9yVO44yRtyEyhC34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VkG1vbJ8; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VkG1vbJ8"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-396ccc09d65so1155352a91.3
        for <bpf@vger.kernel.org>; Fri, 18 Sep 2026 12:59:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789761547; x=1790366347; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=ureKglK7E8z9UopMgU7sx+29AzDdNEEhiEwvgmYlJN4=;
        b=VkG1vbJ8y0x3SYJ7msPrhQxpUtRgOSM9RiMFSj4Fz1pASHZg/iU3GmEY4ajV9d5WGn
         If6mSh7FNdvIs/Foycw+E3JubZ2EF037/4IJuPZTkV+ZFk8APJnvOu3UplbiqhsqElgn
         aWTlc96dVPXBlsg2G55Dx570MfxL13l7c4c6FEIe5wLmMshNYYU9U/M81hUKY1yC7Y07
         THVL7TA8+aa/hxiHb/A4K8HBmwmqXg0zh+uNUtsVwtQlxKxeqFPw/fKPfQrNXJ3X9Ox0
         Sf0Fia7EhE5mBY12k5d7snICa4qktHlmXhH1S0rfKOXwtmNzIF76W2Q61/oZudAsOgkP
         SQ/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789761547; x=1790366347;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ureKglK7E8z9UopMgU7sx+29AzDdNEEhiEwvgmYlJN4=;
        b=BmlR46UoTo3LMzr+lMum70Fq2DVcdW9wd5FA0+Z0PcUr5Ix0ZQjUWsjkYWuOVUya5u
         jvDvI4MrlV7Otid2FAlm4wbcYIwHHwIItfNA3C2MZthEfYgsVZcH9QvaF6ARQa7Jgwun
         n/U+aAlGE02XGSx05EFo+obBnj5YZjOMNAiwXpUZP5tYiZciuYqtvuJwq81Ie2+1NgBd
         R/uCe5Q/+KdmmtPBL5e29Vg28TX6slWVzsu/2RHINQM601kXrmpkZ87Z/P16JifKecE9
         7OUF5XKd6yfjpG0/ba1V+ybgmyKLbeJ/1nC5LpPnAFGnR89g0r0Lu2gLFdndLaB1Ph8R
         8H8g==
X-Forwarded-Encrypted: i=1; AKwUvBzB0BXinmNtovT00R4/cbHt8uGnG+MmWY3G/rWcZOvDOfQAoasb3YGIA/GRclCteS3If2Y=@vger.kernel.org
X-Gm-Message-State: AFuF++lGlwHHHZpGuGLCSFQQsJowVSb9Ezox1cwf6ihS0EoHntT7L03H
	gcdfmp9WZ448Xo0hDH3DAz6mHELBYt4OkRgMG9ZY8KTZayX0EvS90U0C
X-Gm-Gg: AYBFou1Jy9b/4l0u6HNw275bIHr51pi5bcB/eHnqO2qV5elCBYKDXaheef7ovs/jmBs
	/JkPWq1nACv2OEZ9mGq9nyFe5gY7QAqjbP+TO8Y8vYqmFqtReEZfPjkOTE1LjNw3JADVx0tdkNk
	RUEo2dbjEIfjwtogOTkWDCpL+U1Mu+LAS0h9JO53xUbMLiePO2LXsc1yxbwDrm6qfaAW8QBoszC
	3b36mATXjQx3JHgJm1N1Ahrpv3u2WSOwxs6yToefFeiyL/yVr/94AauMQ2eXWqNaCj0ovT2+M6A
	hU+KAq8Xn8byZ6lYroJnNVAHmiE59Fc09tuVrxM0wWU77K7XtcQpypvStQ5ykcpsdlyG/yf866q
	uIH/Q1cVUKOd4BO1b6EjVmSs7kwKYvW5l/VVUXYYZzWeLncWWjlym3zn5Ilee6z6QdskSirfxAi
	3vVnXmJlby8wZGSE6HRxAsC7KVY+wBvC6gjx3OH7J6hC2x83bGmITCdT1EmUm+r8O/87Wf87szy
	j7I8dWRg0jRJ4xcUtvWps1fGjy+8fTCTKaaWDE62LzhIhdJRvSVX/K0Zw==
X-Received: by 2002:a17:90b:3f84:b0:39e:4c7e:f042 with SMTP id 98e67ed59e1d1-39e54f91d4amr7393686a91.31.1789761547050;
        Fri, 18 Sep 2026 12:59:07 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:e136:8952:772a:93a4? ([2620:10d:c090:500::4:e681])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-144d55e71a4sm682092c88.13.2026.09.18.12.59.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 12:59:06 -0700 (PDT)
Message-ID: <fc7dd9b68e50a07af40f6ac571fb7adb6ba512d3.camel@gmail.com>
Subject: Re: [PATCH v3 bpf-next 06/11] selftests/bpf: BTF distill tests to
 ensure LOC[_PARAM|_PROTO] add to split BTF
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alan Maguire <alan.maguire@oracle.com>, ast@kernel.org,
 andrii@kernel.org, 	jolsa@kernel.org
Cc: daniel@iogearbox.net, ihor.solodrai@linux.dev, yonghong.song@linux.dev, 
	song@kernel.org, qmo@kernel.org, martin.lau@linux.dev, memxor@gmail.com, 
	emil@etsalapatis.com, bpf@vger.kernel.org, nsc@kernel.org,
 puranjay@kernel.org, 	yatsenko@meta.com
Date: Fri, 18 Sep 2026 12:59:04 -0700
In-Reply-To: <20260916074118.1007116-7-alan.maguire@oracle.com>
References: <20260916074118.1007116-1-alan.maguire@oracle.com>
	 <20260916074118.1007116-7-alan.maguire@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2026-09-16 at 08:41 +0100, Alan Maguire wrote:
> When creating distilled BTF, BTF_KIND_FUNC, _LOC_PARAM and _LOC_PROTO
> should be added to split BTF.  This means potentially some duplication
> of location information, but only for out-of-tree modules that use
> distilled base/split BTF.
>=20
> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> ---
>  .../selftests/bpf/prog_tests/btf_distill.c    | 101 ++++++++++++++++++
>  1 file changed, 101 insertions(+)
>=20
> diff --git a/tools/testing/selftests/bpf/prog_tests/btf_distill.c b/tools=
/testing/selftests/bpf/prog_tests/btf_distill.c
> index fb67ae195a73..141a4cb1f405 100644
> --- a/tools/testing/selftests/bpf/prog_tests/btf_distill.c
> +++ b/tools/testing/selftests/bpf/prog_tests/btf_distill.c
> @@ -671,6 +671,105 @@ static void test_distilled_base_embedded_err(void)
>  	btf__free(btf1);
>  }
> =20
> +/* LOC_PARAM, LOC_PROTO should be added to split BTF. */
> +static void test_distilled_loc(void)
> +{
> +	struct btf *btf1 =3D NULL, *btf2 =3D NULL, *btf3 =3D NULL;
> +	struct btf *btf4 =3D NULL, *btf5 =3D NULL;
> +
> +	btf1 =3D btf__new_empty();
> +	if (!ASSERT_OK_PTR(btf1, "empty_main_btf"))
> +		return;
> +
> +	btf__add_int(btf1, "int", 4, BTF_INT_SIGNED);	/* [1] int */
> +	btf__add_func_proto(btf1, 1);                   /* [2] int (*)(int); */
> +	btf__add_func_param(btf1, "p1", 1);
> +	btf__add_func(btf1, "foo", BTF_FUNC_STATIC, 2);	/* [3] int foo(int); */
> +	btf__add_loc_param(btf1, 4, BTF_LOC_PARAM_SIGNED | BTF_LOC_PARAM_CONST)=
;
> +	btf__add_loc_param_value(btf1, -1);		/* [4] loc value */
> +	btf__add_loc_proto(btf1);			/* [5] loc proto */
> +	btf__add_loc_proto_param(btf1, 4);		/*  param value */
> +
> +	VALIDATE_RAW_BTF(
> +		btf1,
> +		"[1] INT 'int' size=3D4 bits_offset=3D0 nr_bits=3D32 encoding=3DSIGNED=
",
> +		"[2] FUNC_PROTO '(anon)' ret_type_id=3D1 vlen=3D1\n"
> +		"\t'p1' type_id=3D1",
> +		"[3] FUNC 'foo' type_id=3D2 linkage=3Dstatic",
> +		"[4] LOC_PARAM '(anon)' size=3D4 flags=3D0x3 vlen=3D1\n"
> +		"\tvalue=3D-1",
> +		"[5] LOC_PROTO '(anon)' vlen=3D1\n"
> +		"\ttype_id=3D4");

Maybe also add an unrelated type to the base, such that effects of the
distill are visible?

> +	btf2 =3D btf__new_empty_split(btf1);
> +	if (!ASSERT_OK_PTR(btf2, "empty_split_btf"))
> +		goto cleanup;
> +
> +	btf__add_locsec(btf2, "inline.text");		/* [6] locsec */
> +	btf__add_locsec_loc(btf2, 3, 5, 256);		/* "foo" offset 256 */
> +	VALIDATE_RAW_BTF(
> +		btf2,
> +		"[1] INT 'int' size=3D4 bits_offset=3D0 nr_bits=3D32 encoding=3DSIGNED=
",
> +		"[2] FUNC_PROTO '(anon)' ret_type_id=3D1 vlen=3D1\n"
> +		"\t'p1' type_id=3D1",
> +		"[3] FUNC 'foo' type_id=3D2 linkage=3Dstatic",
> +		"[4] LOC_PARAM '(anon)' size=3D4 flags=3D0x3 vlen=3D1\n"
> +		"\tvalue=3D-1",
> +		"[5] LOC_PROTO '(anon)' vlen=3D1\n"
> +		"\ttype_id=3D4",
> +		"[6] LOCSEC 'inline.text' vlen=3D1\n"
> +		"\tfunc_type_id=3D3 loc_proto_type_id=3D5 offset=3D256");
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
> +		"[1] INT 'int' size=3D4 bits_offset=3D0 nr_bits=3D32 encoding=3DSIGNED=
",
> +		/* remainder is split BTF */
> +		"[2] LOCSEC 'inline.text' vlen=3D1\n"
> +		"\tfunc_type_id=3D4 loc_proto_type_id=3D6 offset=3D256",
> +		"[3] FUNC_PROTO '(anon)' ret_type_id=3D1 vlen=3D1\n"
> +		"\t'p1' type_id=3D1",
> +		"[4] FUNC 'foo' type_id=3D3 linkage=3Dstatic",
> +		"[5] LOC_PARAM '(anon)' size=3D4 flags=3D0x3 vlen=3D1\n"
> +		"\tvalue=3D-1",
> +		"[6] LOC_PROTO '(anon)' vlen=3D1\n"
> +		"\ttype_id=3D5");
> +
> +	btf5 =3D btf__new_empty();
> +	if (!ASSERT_OK_PTR(btf5, "empty_reloc_btf"))
> +		goto cleanup;

I'd add another btf__add_<something> here to shift the ides and make
sure that relocate actually did something.

> +	btf__add_int(btf5, "int", 4, BTF_INT_SIGNED);	/* [1] int */
> +
> +	if (!ASSERT_EQ(btf__relocate(btf4, btf5), 0, "relocate_split"))
> +		goto cleanup;
> +	VALIDATE_RAW_BTF(
> +		btf4,
> +		"[1] INT 'int' size=3D4 bits_offset=3D0 nr_bits=3D32 encoding=3DSIGNED=
",
> +		/* remainder is split BTF */
> +		"[2] LOCSEC 'inline.text' vlen=3D1\n"
> +		"\tfunc_type_id=3D4 loc_proto_type_id=3D6 offset=3D256",
> +		"[3] FUNC_PROTO '(anon)' ret_type_id=3D1 vlen=3D1\n"
> +		"\t'p1' type_id=3D1",
> +		"[4] FUNC 'foo' type_id=3D3 linkage=3Dstatic",
> +		"[5] LOC_PARAM '(anon)' size=3D4 flags=3D0x3 vlen=3D1\n"
> +		"\tvalue=3D-1",
> +		"[6] LOC_PROTO '(anon)' vlen=3D1\n"
> +		"\ttype_id=3D5");
> +
> +cleanup:
> +	btf__free(btf5);
> +	btf__free(btf4);
> +	btf__free(btf3);
> +	btf__free(btf2);
> +	btf__free(btf1);
> +}
> +
>  void test_btf_distill(void)
>  {
>  	if (test__start_subtest("distilled_base"))
> @@ -689,4 +788,6 @@ void test_btf_distill(void)
>  		test_distilled_base_vmlinux();
>  	if (test__start_subtest("distilled_endianness"))
>  		test_distilled_endianness();
> +	if (test__start_subtest("distilled_loc"))
> +		test_distilled_loc();
>  }
