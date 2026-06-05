Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5332A2C1595
	for <bpf@vger.kernel.org>; Fri,  5 Jun 2026 12:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780661233; cv=none; b=pbxft+Vw7DwVQWpBQatZWhEYEIXsbuuMagF7Tj/o6oU6xaBVpIoc8Ews8pGGF8OhV8mGQF0ZjvtM+QEr/WOnHILgogkplETFfEch56wfmZWETPqi6J1kKObatd1xg4rZPQyKzozT+NZUdMSZWa3l3vgvaKvi7Qqju/Vo8J2qpcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780661233; c=relaxed/simple;
	bh=iVtxugPhBocU+jt07F40eRDZd4xT1aIVsc7lzle3D+0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=m4mPN7IAUTlA/Xi4kFtssDHVsVTrLmhBtAX3l3b9NoXRLxwvXk5SsiH6TI4/mLL6gPxVZYI6YGFTyvwV6vaARsNrRbBD9JlyN7fItVqgQKNPQxoas+RzbVzkjQQE1EFPtqPrr3zty2ggSTAGMleTQLR0aJ8+BmD/g0WzmnejeYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NtkGUwh2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NtkGUwh2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D51941F00893;
	Fri,  5 Jun 2026 12:07:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780661232;
	bh=eNI2YtHuLNYpW4luPfkjX9boV5eYZv4fulTj6NTgRUY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NtkGUwh2prTVqhpbQls+wf+ERN9d8vJHx6siEx3E6EODT3EXNg7s4YmN+CM5hZDgi
	 FUApDEBOB9q1QwVpTw97/nwf579ULqR11pE1G0aLyQ+7YP+0XY4Vp1rMgWFk7iA/TU
	 aFcfm5TAWS73OZ95bwLDQVJvuC1LPhZsJBTPJdE2rkzsyikhwRs84UEA36lupXXFQA
	 ORpngGtbrqIQcj6GkakJ2N2Bq9dYOIEUtjDt2Q/cVRWgn3RYuwpmQx85wB6E8Gu8Wt
	 SQs8FrfHpUS0XBesWSlPLfcfkM/sgC1FGi8BvpRzkHXWodAid3hpSrsuL9+eJ+4du8
	 Cbt0JBWiLjTmQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 bpf-next] selftests/bpf: add arena split and fork
 tests
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ruslan Valiyev" <linuxoid@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260605115713.3224051-1-linuxoid@gmail.com>
References: <20260605115713.3224051-1-linuxoid@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 05 Jun 2026 12:07:11 +0000
Message-Id: <20260605120711.D51941F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Multi-line comment does not follow the required BPF subsystem comme=
nt style.
--

commit f3309fb333fa0cbe670a595203f862bdefb2a073
Author: Ruslan Valiyev <linuxoid@gmail.com>

selftests/bpf: add arena split and fork tests

This commit adds two tests for an arena map's mmap()ed region. The
arena_split test checks that a partial munmap() that would split the
mapping fails with EINVAL, while arena_fork verifies that a forked child=20
does not inherit the mapping.

> diff --git a/tools/testing/selftests/bpf/prog_tests/arena_fork.c b/tools/=
testing/selftests/bpf/prog_tests/arena_fork.c
> new file mode 100644
> index 0000000000000..bb134e9adb607
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/arena_fork.c

[ ... ]

> +	pid =3D fork();
> +	if (pid =3D=3D 0) {
> +		unsigned char vec;
> +		int rc;
> +
> +		/* If the mapping was not inherited the range is unmapped in
> +		 * the child, so mincore() fails with ENOMEM. A success means
> +		 * the child wrongly inherited the mapping.
> +		 */

[Severity: Low]
This isn't a bug, but does this multi-line comment in test_arena_fork()
follow the preferred BPF subsystem comment style?

The BPF guidelines require the opening /* to be on its own line for
multi-line comments, like this:

/*
 * If the mapping was not inherited the range is unmapped in
 * the child...
 */

> +		rc =3D mincore(area, ps, &vec);
> +		if (rc =3D=3D 0)
> +			_exit(1);
> +		_exit(errno =3D=3D ENOMEM ? 0 : 2);
> +	}

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260605115713.3224=
051-1-linuxoid@gmail.com?part=3D1
