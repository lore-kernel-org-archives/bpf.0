Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FCC31A9F90
	for <bpf@vger.kernel.org>; Wed, 16 Sep 2026 07:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789545430; cv=none; b=gTSVQKzdRQ0OVxHS19+gIbFomxBYT23n7KPhwj3SBVIH1o/oEEv8HBAfcsbyAQ0GIqcDT1eS7mrCJcToZLmQ1k9zH0FHYQD7qgLBBkpJ9s/qiT73PLif7tl/wSkznxLSlepg0ec3GAk89zxtSMWtz3iJh4XvSV7UmjFOMVUZnSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789545430; c=relaxed/simple;
	bh=NwTzzAhrQmASjnJkmA5NTTWhIOKv3R8D6WhST/HKAnw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=MM2lHsx9M6dstKlCstnc22d5OlcAehtT+nk9CAx+HZpKuSc6/eZt8ukzU7nM5XQN1A805AQqI+LRGvmInMo+ecnCFeXnoU+wNm9HkTgaLKOq3Ur07/h75+ctCXfQbl+G3TzA1tsBlECQUQWrf5VJ8sHohHYSHQtvZbvc6G/8vyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KKdjVweX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KKdjVweX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3573C1F000FF;
	Wed, 16 Sep 2026 07:56:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789545419;
	bh=aD92ucJzU9mEqLql+DvRq0H9v+wcP/iFWQMHmHqZABg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KKdjVweXQLBpJbwg6tmi4QGUzlmfClJ1GcJRwTYIQrMtuqReZBYrVORs6Qle3vDuk
	 KE5Ll8WSstGLFHM2CLcZgQnS2sv1w7W2b6vh1M2FVtF00PDAdu4Ch+D9dPDml34+AL
	 VQry2ChfMGkVAJDqsBRvcKZ9GhEbNvGQhC79svFa8+/8jbwWn3JiXgIDHoZavEEXFn
	 PDtw096rRdJEbTpj/OOnvT07M2r6F184JCsFxildJSAYmYkBV+bM9QeJvxcztKDoWX
	 LTbFxAIZ30AfAIath6vzBNGbsf6EgewJfNUcQME54CLo4HAScc3gNtuhSLlLuTPFTP
	 9xhrP0x7ZP0sQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 bpf-next 10/11] selftests/bpf: Test bpftool dump of
 BTF location info
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alan Maguire" <alan.maguire@oracle.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260916074118.1007116-11-alan.maguire@oracle.com>
References: <20260916074118.1007116-1-alan.maguire@oracle.com>
 <20260916074118.1007116-11-alan.maguire@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 16 Sep 2026 07:56:58 +0000
Message-Id: <20260916075659.3573C1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] bpf: uninitialized stack variable path passed to unlink() on err=
or path
--

commit 7571df89a1b4928d95fd5e997d48f8637c83a473
Author: Alan Maguire <alan.maguire@oracle.com>

selftests/bpf: Test bpftool dump of BTF location info

Add a bpftool raw BTF dump test covering LOC_PARAM, LOC_PROTO, and
LOCSEC types.

> diff --git a/tools/testing/selftests/bpf/prog_tests/bpftool_btf_dump.c b/=
tools/testing/selftests/bpf/prog_tests/bpftool_btf_dump.c
> --- a/tools/testing/selftests/bpf/prog_tests/bpftool_btf_dump.c
> +++ b/tools/testing/selftests/bpf/prog_tests/bpftool_btf_dump.c
> @@ -175,4 +249,14 @@ void test_bpftool_btf_dump(void)
>  	unlink(path);
>  out_btf:
>  	btf__free(btf);
> +
> +	btf =3D mk_loc_btf();
> +	if (!btf)
> +		return;
> +
> +	if (!btf_to_tmpfile(btf, path) && test__start_subtest("loc_dump"))
> +		test_loc_dump(path);
> +
> +	unlink(path);

[Severity: Medium]
Is there a risk of passing uninitialized stack memory to unlink() here?

If btf_to_tmpfile() fails early, for example if btf__raw_data() returns NUL=
L:

tools/testing/selftests/bpf/prog_tests/bpftool_btf_dump.c:btf_to_tmpfile() {
        ...
        raw =3D btf__raw_data(btf, &sz);
        if (!ASSERT_OK_PTR(raw, "raw_data"))
                return -1;
        ...
}

The path buffer remains uninitialized stack memory. The short-circuit
evaluation in test_bpftool_btf_dump() will skip test_loc_dump(), but it
looks like the execution will then proceed directly to this unconditional
unlink(path) call.

> +	btf__free(btf);
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260916074118.1007=
116-1-alan.maguire@oracle.com?part=3D10
