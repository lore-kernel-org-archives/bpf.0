Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E67B83FD941
	for <bpf@vger.kernel.org>; Tue,  9 Jun 2026 11:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781005688; cv=none; b=mQkjddAPuVkWna79Wlie0/LACPhsIHtyzhmet5Y+VTEB2oXRtqklZnnC3HsmL5nsxLlvFspPF+1gvVz0VSTRi8eWmo4Ef2LcBSwbXOdhyPphcXae3fr2YveYCsjH6OnnqIGUh/xqfdrriAFRh1SzN8NZE+P0anGruD9vNfRrBzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781005688; c=relaxed/simple;
	bh=/NQRGWMhiVJIotyZnBpyMemhDU3w9FW4ZuHxCrJwV2k=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=H3mStC7pYb7F18SegTwlzJ6RD7P032Rn5fvoKDO1nXOY14FyDDRpUx17O1QYHQJeHJGunOvTGX5w4leohfQaBHjWc52QKJUAtOvdGBkxwjIB7zIngcQ6VjXuwG5vNpCXhEjYpvzbzUTtjbaiWQ93UidwxWGucWFKDN70dOM8LAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k5C5hgOJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k5C5hgOJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C81A1F00893;
	Tue,  9 Jun 2026 11:48:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781005687;
	bh=24Yubcs+SuVnO+t0w2uHaKZ4f0NPjwrhwLfApA+NgO8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=k5C5hgOJYj+zyqvOFXCNb2+08+Oany+HsrA5q0UHqZ9YOCX7pNHnCEGjvlYC93blO
	 MWH8kglkXWBRia9XGa2QzaXLDL9ZTFj1Er6YDLveWEXCkgOrr+9YR+01IeeD840scl
	 jXJxbRe94VnTbPSW+rGUz6XfP5+eVjnr08f1GemgPZg3fsFuw9Gy7ioMUM92vgOGP7
	 o9FQ0N3JejNxMUIRVwbuGCLdOQSusqCFJ4PQuXZbyw3RAR8p8v13GmYF50GjlMpz0p
	 siJCCCA4laSCDx0aUynv8Xb83lcFshNrMjXkG3+A8uTeo3p+T0oKhwXa9vdw/WAipq
	 ieDI8riuPG4wQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf] selftests/bpf: Add BTF repeated field count
 overflow test
Reply-To: sashiko-reviews@lists.linux.dev
To: "Paul Moses" <p@1g4.org>
Cc: bpf@vger.kernel.org
In-Reply-To: <SzebdWqm2zREZBf8Tc5Kc-JDWbh9nBztnk4PUu5kRSD1OOdr_ESVTt__2Hd3-lClr47jIjJCXfOH0RHsMpjjpEUh_R2v30nh3T1IXNT6Pbo=@1g4.org>
References: <SzebdWqm2zREZBf8Tc5Kc-JDWbh9nBztnk4PUu5kRSD1OOdr_ESVTt__2Hd3-lClr47jIjJCXfOH0RHsMpjjpEUh_R2v30nh3T1IXNT6Pbo=@1g4.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 09 Jun 2026 11:48:06 +0000
Message-Id: <20260609114807.0C81A1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] The patch adds a selftest that intentionally triggers a 32-bit=
 integer multiplication overflow in `btf_repeat_fields()`, but fails to inc=
lude the corresponding kernel fix. Running this test will cause a massive k=
ernel stack buffer overflow and crash the system.
--

commit c85a43a465188ee0a856395b17e0e43e08bfa15b
Author: Paul Moses <p@1g4.org>

selftests/bpf: Add BTF repeated field count overflow test

Add a raw BTF test that exercises repeated special-field expansion with a
large array count to trigger an overflow in btf_repeat_fields.

> diff --git a/tools/testing/selftests/bpf/prog_tests/btf.c b/tools/testing=
/selftests/bpf/prog_tests/btf.c
> --- a/tools/testing/selftests/bpf/prog_tests/btf.c
> +++ b/tools/testing/selftests/bpf/prog_tests/btf.c

[ ... ]

> @@ -4258,6 +4258,43 @@ static struct btf_raw_test raw_tests[] =3D {
>  	.max_entries =3D 1,
>  },
> =20
> +{
> +	.descr =3D "struct test repeated fields count overflow",
> +	.raw_types =3D {
> +		BTF_TYPE_INT_ENC(NAME_TBD, BTF_INT_SIGNED, 0, 32, 4),	/* [1] */
> +		BTF_STRUCT_ENC(NAME_TBD, 0, 0),				/* [2] */

[ ... ]

> +		BTF_MEMBER_ENC(NAME_TBD, 5, 0),
> +		BTF_MEMBER_ENC(NAME_TBD, 5, 0),
> +		BTF_TYPE_ARRAY_ENC(6, 1, 0x1999999aU),			/* [7] */

[Severity: Critical]
This isn't a bug introduced by this patch, but does adding this test without
its corresponding kernel fix deterministically crash systems running selfte=
sts?

This test intentionally triggers a 32-bit integer multiplication overflow in
kernel/bpf/btf.c:btf_repeat_fields(). The bounds check performs 32-bit
unsigned arithmetic:

kernel/bpf/btf.c:btf_repeat_fields() {
    ...
    if (field_cnt * (repeat_cnt + 1) > info_cnt)
        return -E2BIG;
    ...
}

The test crafts a BTF array of size 0x1999999a containing an internal struct
with 10 special fields. When evaluated, 10 * 0x1999999a equals 4294967300,
which wraps around to 4 in 32-bit math.

Since 4 is less than BTF_FIELDS_MAX (11), the bounds check incorrectly pass=
es.
The loop then writes massively past the end of the stack-allocated info_arr
buffer:

kernel/bpf/btf.c:btf_repeat_fields() {
    ...
    for (i =3D 0; i < repeat_cnt; i++) {
        memcpy(&info[cur], &info[0], field_cnt * sizeof(info[0]));
    ...
}

Should the fix in btf_repeat_fields() be included alongside or before this
test is merged to prevent kernel panics during selftests?

> +		BTF_STRUCT_ENC(NAME_TBD, 2, 8 + 8 * 0x1999999aU),	/* [8] */
> +		BTF_MEMBER_ENC(NAME_TBD, 4, 0),
> +		BTF_MEMBER_ENC(NAME_TBD, 7, 64),
> +		BTF_END_RAW,
> +	},

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/SzebdWqm2zREZBf8Tc5=
Kc-JDWbh9nBztnk4PUu5kRSD1OOdr_ESVTt__2Hd3-lClr47jIjJCXfOH0RHsMpjjpEUh_R2v30=
nh3T1IXNT6Pbo=3D@1g4.org?part=3D1
