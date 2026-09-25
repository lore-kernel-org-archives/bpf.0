Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AC6035E92F
	for <bpf@vger.kernel.org>; Fri, 25 Sep 2026 22:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790377091; cv=none; b=tqiHcKBWCBnG6Lg1VQlcYhhT7DS1jDyEU9WZmUTGvOzQ6yZa6n2MthAtQ6dNWUaTD+VsgJG04obvvqDT6gkkPVa2xYrctpgnHTIG+irSv1cI82C41Z/CJZTM7gV6mC14Ca6jy942hA2lqx+lOwy1seEvzlmRz4q6iFHWsNm+NcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790377091; c=relaxed/simple;
	bh=mZ7qqlslECHmSa9hxdMyiEWNNe8Xj0FO9uMflelXjmI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=DDcO4PdEjQpl3LWunSpmqaGU6AtmCKQZNAtumH54GzD5p1xiRMDdRPBtS4CAzpM0auN/B7oZMPqN+y+WUAg16Z0Dy2WFkIYc7d1HrhrVWPtHM3qz0AtDBjTEyL9haWtIXonmtTFx1NJDf9lvJilgoMsDmf7r+2SU/UGQzxqB+go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NpaHqrnl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NpaHqrnl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4AE01F000FF;
	Fri, 25 Sep 2026 22:58:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790377089;
	bh=31Vf6DHWIOvAOFUrVSAuc1udzpuU0pOmM0oxRzbz3V8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NpaHqrnlY8hhYNb6YkpAJUSqGDdRdO2lnvYRHGXwUo7iuPehfVS/4d/0/kmcjaHK4
	 0vqWVYSE0m6NHOApt8h7kh3G6OaUD7UUCVSbNr/FNclvcfeNoxSq63e894ScpozAbm
	 EP+jOfydlnIF34E1vW2jhf4GJ7wlGmIBSFRdHNpZgKJ15UV56bu6OapoKI1jZhS8aQ
	 uk5L7Q2PoSqTyk1bp1SyyZxtgH3K0HV9+8AIKjpdghtEtdn9vt3RyWIsuggXSwLHLr
	 qv8a/gGuzexLNVKCCAWbzFXFg5wivEKurl8xowFjlk2yKbhQO8UydtUIs3Zwsr/vpS
	 3DTVEKufZPaZA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: Add linked_externs test for
 externs in allocated sections
Reply-To: sashiko-reviews@lists.linux.dev
To: "Andrii Nakryiko" <andrii@kernel.org>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260925224631.1490488-2-andrii@kernel.org>
References: <20260925224631.1490488-1-andrii@kernel.org>
 <20260925224631.1490488-2-andrii@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 25 Sep 2026 22:58:09 +0000
Message-Id: <20260925225809.B4AE01F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] bpf: TOCTOU and missing error check for mkstemp in test_relink()
- [Medium] bpf: Missing NULL check for bpf_object__btf() in test_relink()
--

commit 2e7da3dcbd552604f0f6c052dc8cda7a3628ffb8
Author: Andrii Nakryiko <andrii@kernel.org>

selftests/bpf: Add linked_externs test for externs in allocated sections

This commit adds two objects that define an arena global each and declare t=
he
other one's as extern, linking them into a single skeleton. It also introdu=
ces
a test to drive the libbpf linker directly to verify the relinking process.

> diff --git a/tools/testing/selftests/bpf/prog_tests/linked_externs.c b/to=
ols/testing/selftests/bpf/prog_tests/linked_externs.c
> new file mode 100644
> index 0000000000000..29358c82dc356
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/linked_externs.c
[ ... ]
> +/* link in1 on its own first, then link the result with in2 */
> +static void test_relink(const char *in1, const char *in2, const char *se=
c_name)
> +{
> +	char out1[] =3D "/tmp/linked_externs.XXXXXX", out2[] =3D "/tmp/linked_e=
xterns.XXXXXX";
> +	const struct btf_var_secinfo *vi;
> +	struct bpf_object *obj =3D NULL;
> +	const struct btf_type *t;
> +	struct btf *btf;
> +	int i, id, n;
> +
> +	close(mkstemp(out1));
> +	close(mkstemp(out2));

[Severity: Medium]
Could this result in a Time-Of-Check to Time-Of-Use (TOCTOU) race condition
and silently ignore failures?

mkstemp() can fail, returning -1 and leaving the template unchanged. Because
the return value is discarded, could concurrent test runs end up using the
identical fallback filename "/tmp/linked_externs.XXXXXX" and corrupt each
other's output?

Additionally, even on success, does immediately closing the temporary file =
and
reopening it by name in a world-writable directory (/tmp) introduce a class=
ic
TOCTOU race condition?

> +
> +	if (!ASSERT_OK(link_objs(out1, in1, NULL), "link_stage1") ||
> +	    !ASSERT_OK(link_objs(out2, out1, in2), "link_stage2"))
> +		goto cleanup;
> +
> +	obj =3D bpf_object__open_file(out2, NULL);
> +	if (!ASSERT_OK_PTR(obj, "obj_open"))
> +		goto cleanup;
> +
> +	btf =3D bpf_object__btf(obj);
> +	id =3D btf__find_by_name_kind(btf, sec_name, BTF_KIND_DATASEC);

[Severity: Medium]
Does this code dereference a potentially NULL pointer?

bpf_object__btf(obj) can return NULL if the loaded BPF object lacks BTF
information. The returned btf pointer is then passed to
btf__find_by_name_kind(), which dereferences it internally (btf->start_id).

Could this lead to a segmentation fault on malformed objects instead of a
graceful test failure (e.g., via ASSERT_OK_PTR())?

> +	if (!ASSERT_GT(id, 0, "find_datasec"))
> +		goto cleanup;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260925224631.1490=
488-1-andrii@kernel.org?part=3D2
