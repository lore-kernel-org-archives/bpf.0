Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57F6A35C6AC
	for <bpf@vger.kernel.org>; Tue, 13 Oct 2026 12:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791895086; cv=none; b=QbLU6xPSmwRzJP5UIxp5CkomKxb3qb6gapjEdUELCGOaHIVGKQW4PT5+0p0biIy+/RPG2Wbt4GbCKg1nOJEUBjSZ+byLQ2VuIQzOpZQl4WpvHWUo9YUPcCdwa++XdfQ/coNmjkJQjDmHPTofAkI27If/kNZ36RB8dAES8bH01FI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791895086; c=relaxed/simple;
	bh=hcV5TUIX7rvYCTLeA6qSsn11nHf48ZiR1QFLjrwtytc=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=pmv2mjr/38zAFnCjxKB6YaiR9cbo5dobBDJKeHeKsig00+wHt+KK/dAmlKWgvfDA+y5dmITsCXS5yr16Swou2rajugPDZ6ZRJkH1W0JoiBrLaiebUuzvPiK2A1luNKXe0n857kyhcq8Xg/8RectG/i5cR2xx1AzWtEvUT6A4PsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NDfH2tj7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NDfH2tj7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2AE21F00893;
	Tue, 13 Oct 2026 12:38:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791895085;
	bh=buxrw7iSizELL5/oKxZ58Ocy8uQeRip7WrNNf5qVY/Y=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NDfH2tj7MLPJuPV9VhfhdrPRDOlER3GwOIQ9MeRnLKjXLzrIa2hNuKINVbF+hHk6b
	 EvRtf20GVWX9Cbg5AHWXAa4a4OgsVrAu10iHlu85KIlZfvg3XXqJLG+Bhm5HKGM4aj
	 Kve7alGINkBr74lEqf/JQJphdbgURJDW5hSf/VoUr+OHFrMbEwwhFp15nnCSxFrjMg
	 kO1zADCNomeO8RsIfIjvIKZ71Z6Fl4BF6/kZNPneenI9YrTIWFnFcZddnjv6/vw/nD
	 WXPV+mMGoXMjx9NoYXSzXeNKBKYDm0WabBWThAeMDi+0d9gvAA0fKrrG5Ss2n17dFp
	 nj08Tet+F/tig==
Message-ID: <sashiko-outbox-169725@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 6/6] selftests/bpf: add tests for the page_owner
 bpf_iter target
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zhen Ni" <zhen.ni@easystack.cn>
Cc: bpf@vger.kernel.org
In-Reply-To: <20261013122125.843451-7-zhen.ni@easystack.cn>
References: <20261013122125.843451-1-zhen.ni@easystack.cn>
 <20261013122125.843451-7-zhen.ni@easystack.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Oct 2026 12:38:04 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] bpf/selftests: hardcoded errno values break architecture portabi=
lity
--

commit d63d4254b64f243f696e8d9b4ca8b07f371d8139
Author: Zhen Ni <zhen.ni@easystack.cn>

selftests/bpf: add tests for the page_owner bpf_iter target

This commit adds a sleepable BPF program and a userspace runner to test
the seq_file and open-coded page_owner iterators. It verifies iterator
parity, output matching, and kfunc contracts including memcg classification.

> diff --git a/tools/testing/selftests/bpf/progs/bpf_iter_page_owner.c b/to=
ols/testing/selftests/bpf/progs/bpf_iter_page_owner.c
> new file mode 100644
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/bpf_iter_page_owner.c
[ ... ]
> +char memcg_pathbuf[4096];
> +char memcg_first_path[4096];
> +char memcg_first_name[80];
> +
> +#define MEMCG_ENODATA 61
> +#define MEMCG_EOPNOTSUPP 95
> +
> +#define MEMCG_F_ONLINE	(1 << 0)
> +#define MEMCG_F_OBJCG	(1 << 1)

[Severity: Medium]
Will these hardcoded errno values cause a regression in the selftests on
certain architectures?

The bpf_page_owner_get_memcg_info() kfunc returns standard kernel error
codes like -ENODATA and -EOPNOTSUPP. However, these error codes vary by
architecture. For example, ENODATA is 111 on SPARC and 86 on Alpha, while
EOPNOTSUPP is 122 on MIPS.

When the test runs on these architectures, the kfunc will return the
architecture-specific error code. This will fail the hardcoded comparison
in check_memcg(), incorrectly incrementing memcg_bad and causing the
selftest to fail.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261013122125.8434=
51-1-zhen.ni@easystack.cn?part=3D6
