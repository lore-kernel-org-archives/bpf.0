Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C04E3E929B
	for <bpf@vger.kernel.org>; Thu, 16 Apr 2026 20:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776370808; cv=none; b=H1c8v3jMOBnCsgJYofFaggF2KBOYyFIUtwCSzjNtNAukInnVkf7HaV2MCaLGGBbyJLCswdeiXNt5I9IyKJ72LwQ1z9978np6kWgGuc+YkqgAVSOibPrqV80yZuUK4rCHMrKcYiGtQyQL6mvcw2qVvdg3ZOzeFxUyRa5/HeXBFAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776370808; c=relaxed/simple;
	bh=7W+L9aYTbW3Z4SkhFCsR7TjS6FAVhTJ5Jo3n9ls9GB4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Uv+Szk+aV7uGJUmzpD9hCrsUULqwftgpWHDQEqMAEWo4rX30TCQ40Q1fjhBrcZtmQ8H9gx7PjP8VfRCRJ9dr9TswzMsQEVdqi0/1T/ENA852e9K6sc7ybgvczZmKw2ioQc84vP13YkkAo+ww6YjStM1omCxPtFzBd//kzzBAYgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FJLLrgFK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FJLLrgFK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F8A4C2BCAF;
	Thu, 16 Apr 2026 20:20:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776370807;
	bh=7W+L9aYTbW3Z4SkhFCsR7TjS6FAVhTJ5Jo3n9ls9GB4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=FJLLrgFKnRhQOMNXaz4o+I0Xv3UpVeqAv6WkLr9JAsER1J63IQpRfgiKutr5BY+nA
	 gKYjxW32iuI20c8E34hMRagZEsG8HIBTopIipmVeusHtFuuFVcTHCWhN3Ktt7dl4WE
	 YciWQRjkPDymWbA67tIjWdFEcjBrYDknFnrSX+FUXWooxNGJ9ACaIgjPa02ypgCBnK
	 U1VKZZUMccx/CgghB5wbppDWjMQQbTyuqAaUDoJgCGFMQjI+/cIrpJ9H1iBFc6sTJU
	 dVAVLe2gX5/R8+YPNiEJyHemX6kefuCptmJmwA8MnV5CAUahYZsILOROae0zq2NO8i
	 qAi/z/nOSWjTA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 bpf-next 5/8] selftests/bpf: Test BTF sanitization
 rejection for invalid vlen
Reply-To: sashiko@lists.linux.dev
To: "Alan Maguire" <alan.maguire@oracle.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260416143904.1220662-6-alan.maguire@oracle.com>
References: <20260416143904.1220662-6-alan.maguire@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 16 Apr 2026 20:20:06 +0000
Message-Id: <20260416202007.4F8A4C2BCAF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Sashiko AI review found 2 potential issue(s):
- [High] Incorrect assertion macro `ASSERT_OK` used for boolean return valu=
e `kernel_supports()`, leading to spurious test failures on kernels support=
ing the feature.
- [Medium] Malformed BTF construction: DATASEC byte size is too small for t=
he added variables, resulting in out-of-bounds offsets.
--

commit 547d5170cb3d8f555e19115439d037e23963de75
Author: Alan Maguire <alan.maguire@oracle.com>

selftests/bpf: Test BTF sanitization rejection for invalid vlen

For a kernel that does not support extended vlen, BTF should be
rejected. This commit simulates non-support using the feature cache=20
and ensures that BTF with an extended vlen DATASEC is rejected.

> diff --git a/tools/testing/selftests/bpf/prog_tests/btf_sanitize.c b/tool=
s/testing/selftests/bpf/prog_tests/btf_sanitize.c
> index 652b51efafc27..1349fc7b34e9c 100644
> --- a/tools/testing/selftests/bpf/prog_tests/btf_sanitize.c
> +++ b/tools/testing/selftests/bpf/prog_tests/btf_sanitize.c

[ ... ]

> +static void test_btf_sanitize_extended(void)
> +{
> +	struct btf *btf =3D NULL, *sanitized =3D NULL;
> +	struct kern_feature_cache *cache =3D NULL;
> +	struct kfree_skb *skel =3D NULL;
> +	int i;
> +
> +	skel =3D kfree_skb__open();
> +	if (!ASSERT_OK_PTR(skel, "kfree_skb_skel"))
> +		return;
> +
> +	if (!ASSERT_OK(kernel_supports(skel->obj, FEAT_BTF_VLEN_KIND_EXTENDED),
> +		       "vlen_kind_extended_supported"))
> +		goto out;

Is ASSERT_OK the right macro to use for this check?

Because kernel_supports() returns a boolean, if the test is run on a kernel
that natively supports the feature, it will return true (1). Since ASSERT_OK
expects exactly 0 for success, this evaluates to ASSERT_OK(1) and triggers
a spurious test failure.

Would ASSERT_TRUE be more appropriate here to avoid aborting the test on
modern kernels?

> +
> +	cache =3D calloc(1, sizeof(*cache));

[ ... ]

> +	btf =3D btf__new_empty();
> +	if (!ASSERT_OK_PTR(btf, "empty_btf"))
> +		goto out;
> +	if (!ASSERT_GT(btf__add_int(btf, "int", 4, BTF_INT_SIGNED), 0, "add_int=
") ||
> +	    !ASSERT_GT(btf__add_var(btf, "var1", 0, 1), 0, "add_var") ||
> +	    !ASSERT_GT(btf__add_datasec(btf, "datasec1", 0x10000), 0, "add_data=
sec"))
> +		goto out;
> +
> +	for (i =3D 0; i < 0x10000; i++) {
> +		if (!ASSERT_OK(btf__add_datasec_var_info(btf, 2, i * 4, 4), "add_var_i=
nfo"))
> +			goto out;
> +	}

Does this loop create a structurally malformed BTF object?

The DATASEC byte size is explicitly set to 0x10000 bytes above, but the loop
adds 0x10000 variables of size 4 at offsets up to 65535 * 4 (262140). This
places the variables far outside the declared bounds of the section.

Should the declared DATASEC size be 0x40000 instead to properly accommodate
the added variables and prevent unexpected failures if tighter bounds checks
are introduced?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260416143904.1220=
662-1-alan.maguire@oracle.com?part=3D5
