Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2C824D7D37;
	Fri,  9 Oct 2026 12:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791549238; cv=none; b=ofEMXPooWUdaxxy3pJqiKMWeBe/FoEVPnYlXObe4K09CPlxSb1vv2XyHUq4Dd1dePdjArx/o9Ff772FvG8aD9FijPRy3PybEUo1cScnrXTy46LdWf6jlrmwqF3MeDdFV+9geNF0Cay5BgIWK1IoquV4Z52zzANlin629LnCuy/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791549238; c=relaxed/simple;
	bh=W4COJCSqVm3t3PuXOJ2Wby+X+kuGaXzXHl6bHXJTd2I=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=k2hkhsV8CKNCihGPF2aciMOemDLr2RV+Z4l1u5LMmCjeWzzOaG+1bgerltgC9JEj89v2I9yUK0WzzS7eEBen7CTw135G9KMTTCoSRUuOkr9oZ5xgx4ss1LN6pKtvgvCNh28JxzV91oEvo152EBOQofEqMgHRtvrJdslznFNoiug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OrAoFN/T; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OrAoFN/T"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A1C21F000FF;
	Fri,  9 Oct 2026 12:33:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791549234;
	bh=LOdUM7r3dR6O0OPTg3vzG72dTNl5T+oRoNk1NwDGyeA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OrAoFN/T9lZcwopurnEV953Gmo6TFhirx1OTQP253oKMnM2aiM/Ie8/mlX2TYGg1J
	 p2EWX5ndTdlI46eWDJG3GBiCd0vWHkI06kWqtV4DxYL3Gp3JjyJ0yxgxJGZBA37BwW
	 ylvJ4TeY2HzHekVVpGppza4cMZaehwCoO3xOqS+r8biU2mv8Kf0ZffdwErlwjdyUiy
	 iDRVpxmBuGDcp2z5gFEhcDvOwK2HXUnQa2e2/nD6QLeusetGrzOo9ZTBc1fJC2tKSu
	 bUBiZno9yWlKLX3vfiAFoVjHfagGcotCPSomiURX+2IDYeH+ALT+k4XbJHgQnU/oKl
	 pbM3snHr67jpg==
Message-ID: <sashiko-outbox-165544@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 bpf-next 7/7] selftests/bpf: Add a test verifying
 inline information
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alan Maguire" <alan.maguire@oracle.com>
Cc: bpf@vger.kernel.org, linux-modules@vger.kernel.org, "Petr Pavlu" <petr.pavlu@suse.com>
In-Reply-To: <20261009112324.1442319-8-alan.maguire@oracle.com>
References: <20261009112324.1442319-1-alan.maguire@oracle.com>
 <20261009112324.1442319-8-alan.maguire@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 09 Oct 2026 12:33:54 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] selftests/bpf: module_get_base_addr() desyncs on trailing /proc/=
modules tokens
- [Medium] bpf: btf_inline test incorrectly allows memory-spilled parameter
--

commit 4adb006744e35941ca2b357431675f3202d1100f
Author: Alan Maguire <alan.maguire@oracle.com>
Subject: selftests/bpf: Add a test verifying inline information

This commit adds a selftest to verify inline information for bpf_testmod.
It checks that an always-inlined function has a single location parameter
encoded in a register, and that the LOCSEC descriptor offset is within the
expected range.

> diff --git a/tools/testing/selftests/bpf/prog_tests/btf_inline.c b/tools/=
testing/selftests/bpf/prog_tests/btf_inline.c
> new file mode 100644
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/btf_inline.c
[ ... ]
> +	lp =3D btf_loc_param(t);
> +	if (!ASSERT_TRUE(lp->flags & BTF_LOC_PARAM_REG, "param_has_reg"))
> +		goto out;

[Severity: Medium]
Because the variable in testmod_inline_len() below is forced into memory, i=
ts
BTF location is encoded as a register-relative memory offset, which sets bo=
th
BTF_LOC_PARAM_REG and BTF_LOC_PARAM_OFFSET.

Does this bitwise AND accidentally pass for memory offsets since they have a
base register? If so, this check might be masking the fact that the paramet=
er
was actually spilled to the stack instead of being purely encoded in a
register as the commit message describes.

[ ... ]
> diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c b/tools=
/testing/selftests/bpf/test_kmods/bpf_testmod.c
> index 93847ca6293b4..b4f0af2aeca45 100644
> --- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
> +++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
[ ... ]
> @@ -735,6 +735,13 @@ bpf_testmod_test_read(struct file *file, struct kobj=
ect *kobj,
>  EXPORT_SYMBOL(bpf_testmod_test_read);
>  ALLOW_ERROR_INJECTION(bpf_testmod_test_read, ERRNO);
> =20
> +static __always_inline size_t testmod_inline_len(size_t len)
> +{
> +	/* Keep an instruction in the inline site without changing len. */
> +	asm volatile("" : "+m"(len));

[Severity: Medium]
Does the "+m" constraint here force the len variable into memory rather
than a register? The commit message explicitly states the intent is to veri=
fy
a parameter "encoded in a register", but this constraint forces a stack spi=
ll
instead.

> +	return len;
> +}
[ ... ]
> diff --git a/tools/testing/selftests/bpf/trace_helpers.c b/tools/testing/=
selftests/bpf/trace_helpers.c
> index 679008b310d9a..f3a1d627699da 100644
> --- a/tools/testing/selftests/bpf/trace_helpers.c
> +++ b/tools/testing/selftests/bpf/trace_helpers.c
[ ... ]
> +unsigned long long module_get_base_addr(const char *module)
> +{
> +	unsigned long long addr, base_addr =3D 0;
> +	char name[500];
> +	FILE *f;
> +
> +	f =3D fopen("/proc/modules", "r");
> +	if (!f)
> +		return 0;
> +
> +	while (fscanf(f, "%499s %*s %*s %*s %*s 0x%llx", name, &addr) =3D=3D 2)=
 {

[Severity: Medium]
Will this loop terminate prematurely if it encounters trailing data on a li=
ne
in /proc/modules?

If a module (like an out-of-tree or unsigned module) has an optional traili=
ng
taint string such as "(O)", this fscanf format lacks a line consumer (like
%*[^\n]\n) to read to the end of the line.

On the next iteration, the %499s token will mistakenly consume the leftover
taint string instead of the next module's name, shifting all subsequent fie=
lds
by one token. When the 0x%llx field then attempts to parse the state string
(e.g., "Live"), it will fail to match the "0x" prefix and return 1, causing
the loop to exit early and return 0 instead of the correct base address.

> +		if (strcmp(module, name) =3D=3D 0) {
> +			base_addr =3D addr;
> +			break;
> +		}
> +	}
> +	fclose(f);
> +	return base_addr;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261009112324.1442=
319-1-alan.maguire@oracle.com?part=3D7
