Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1BF531A07F
	for <bpf@vger.kernel.org>; Sat, 18 Apr 2026 03:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776483278; cv=none; b=BO31+nLcTkbMs0LoMPXxpXpNMAs9y+7iGbfmXkE3FOssans+JK7poALDGKPIR9PX5npqR9D6a4QrbyluYqptiIpvJm6G0OmKFY3hF95A6fEz5OR6xFUQhf0JBlHDKIn3+hG88YcogBlsNSh2fJyj108PxKI5wZ4q3f0/i0TAbmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776483278; c=relaxed/simple;
	bh=PcblRqR4m/tiIE4Kwu/QUXny4ZJZGfWotKFw9TTIckY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=SX8dYjJh0TWQeDOZSC0KUAuwYwu1H50bG38CR+oDmD9ydFqdJjnT/rbmc0HdV+UqEOD9MkuQi1E7wbBw1Teji+Q5EK16/drV7ZcSnVpNmHri9n8CbDnco9mtZnXrAWwX4ej5RT5ShcutghIwzVgqKNOYbwnns6WJbGvVMEVFK38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hzoTClgw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hzoTClgw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03847C19424;
	Sat, 18 Apr 2026 03:34:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776483278;
	bh=PcblRqR4m/tiIE4Kwu/QUXny4ZJZGfWotKFw9TTIckY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=hzoTClgwdrZnGrUgd7yO4m10mJStCqzNY14tZYeWAuHDBT1y6ihw9UbPnVvadmxez
	 cW87wNkLEfiKu79xHXwx8Eng5OUb6Ye+1u2pZ5CVc2sGPZhQgT9QKo94vJ+ru1+THO
	 P43nWf7OoMieaCwsUlsNeQVFzblXMvx8qq0bp39125PFVL2bsi9HNNwRyqtv07buVA
	 HRzQkRxPKyLbY4ek6BttU31p5JmFeiDeimqdcdlRVmSlqFnJ5VykZbcaYZJ1iMWKbD
	 +ERW4uT+lLtePJs4iHVxVE1hfRxuwEq6aFdYSlvXoErXBWh0pZmysvkw9jPxKpnW0W
	 jrB5/IQ3/mP2Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCHv5 bpf-next 21/28] selftests/bpf: Add tracing multi
 skel/pattern/ids attach tests
Reply-To: sashiko@lists.linux.dev
To: "Jiri Olsa" <jolsa@kernel.org>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260417192502.194548-22-jolsa@kernel.org>
References: <20260417192502.194548-22-jolsa@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 18 Apr 2026 03:34:37 +0000
Message-Id: <20260418033438.03847C19424@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Sashiko AI review found 2 potential issue(s):
- [Medium] Double free of `vmlinux_btf` in the error path of `get_ids()`.
- [Medium] Missing error state assignment in `get_ids()` leads to returning=
 a partially or fully zero-initialized array instead of failing.
--

commit 44b619347c03e0f87cfb994ba8b14346b293edcc
Author: Jiri Olsa <jolsa@kernel.org>

selftests/bpf: Add tracing multi skel/pattern/ids attach tests

Adding tests for tracing_multi link attachment via all possible
libbpf apis - skeleton, function pattern and btf ids.

> diff --git a/tools/testing/selftests/bpf/prog_tests/tracing_multi.c b/too=
ls/testing/selftests/bpf/prog_tests/tracing_multi.c
> new file mode 100644
> index 0000000000000..52d3339b430a5
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/tracing_multi.c

[ ... ]

> +static __u32 *get_ids(const char * const funcs[], int funcs_cnt, const c=
har *mod)
> +{
> +	struct btf *btf, *vmlinux_btf =3D NULL;
> +	__u32 nr, type_id, cnt =3D 0;
> +	void *root =3D NULL;
> +	__u32 *ids =3D NULL;
> +	int i, err =3D 0;
> +
> +	btf =3D btf__load_vmlinux_btf();
> +	if (!ASSERT_OK_PTR(btf, "btf__load_vmlinux_btf"))
> +		return NULL;
> +
> +	if (mod) {
> +		vmlinux_btf =3D btf;
> +		btf =3D btf__load_module_btf(mod, vmlinux_btf);
> +		if (!ASSERT_OK_PTR(btf, "btf__load_module_btf")) {
> +			btf__free(vmlinux_btf);
> +			goto out;

Can this result in a double free of vmlinux_btf? If btf__load_module_btf()
fails, we call btf__free(vmlinux_btf) here, and then goto out, where
btf__free(vmlinux_btf) is called again.

> +		}
> +	}
> +
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
> +			goto out;

Does this code return an invalid array if tsearch() fails? When tsearch()
fails, we jump to out, but err is still 0. Because err is 0, the cleanup
block below won't free ids and will instead return the partially or fully
zero-initialized array.

Also, if the BTF type loop that follows this completes without finding all
expected functions (cnt < funcs_cnt), err also remains 0.

Should err be set to a non-zero value before the goto and when
cnt < funcs_cnt?

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

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260417192502.1945=
48-22-jolsa@kernel.org?part=3D1
