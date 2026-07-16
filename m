Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C0A02DC79B
	for <bpf@vger.kernel.org>; Thu, 16 Jul 2026 03:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784170883; cv=none; b=Yj2ecxzBg/BaNzZWs3YccKYXSMgCvPo8GkeFeBhT4LjUouN0uXj85Ngj5jMiDHy4JQzoLm5XDadHUgcm826AqXq7VLPtjWqkyY0FXbpZ6n5V77qHv6fb+6NN+jJsCRUnFfuvvBMS3OyuqVuc2Ev/HWeogE08kuKRdf9fWF5Pvug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784170883; c=relaxed/simple;
	bh=ITKskE2U3BgVUR40TzaJFoFH9YE1y1svF3RvQjA2aS0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=JS4DRqaILRk3sjxwaeL7I7pkbRDB757Q4ZzTgpP1xZV/zkb8YdmGFY04ulzOyB/xcwnnnCV4zvf490Pn52aPhGSivMO2KK0mKbhMkecGZeK+5d2urGREAyTqTk89z53ULI9kgCR4w5fX4PTf4+l7vH7hc30Mi3SjLB967oCQ+0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bp5ykc7M; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bp5ykc7M"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C613E1F000E9;
	Thu, 16 Jul 2026 03:01:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784170876;
	bh=EaUiKE0mdP2inJURdzCULLQ5kG7w3016SmT/lxWLWww=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Bp5ykc7MLs+VYOa5PSW2fLQeBGL+eVu0FNv1QOAc46LHuvWW/rb+53Kg5PTQa2uz+
	 wfOgrRgXCq7aJ77uRq60CF9anSdunI2wOukUBZtihzGsV4FdjQE56me3BUg21E8NFr
	 n6CPHV50nTVcq7LLmDd2Ol7r56c6Efs2oxTfUDGerYoZnmohfczsLSAcQ37ACGdCEv
	 FbAFs6g7I4k3WOA51oPVMZT9pjKlRapcfLZK5Ju0tJUmfNq1Z0TUToZWLlT7lkU/8l
	 nhNjGbmZBFt/yfLjLHTksEv04Xf98TzzOylqXjHT1w2kVJC2EVPxUrTdTVNRK/0NY1
	 ZFnnGFdz6OFAw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] kbuild: rpm-pkg: Preserve .BTF section in kernel
 modules during debuginfo stripping
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yafang Shao" <laoar.shao@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260716025342.42628-1-laoar.shao@gmail.com>
References: <20260716025342.42628-1-laoar.shao@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 16 Jul 2026 03:01:16 +0000
Message-Id: <20260716030116.C613E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The check for `find-debuginfo.sh` capabilities in `mkspec` hardc=
odes host properties into `kernel.spec`, breaking SRPM portability across d=
istributions and failing silently when the tool is not in `$PATH`.
--

--- Patch [1]: [PATCH v2] kbuild: rpm-pkg: Preserve .BTF section in kernel =
modules during debuginfo stripping ---
commit 99202060a54c32638e01a2bfdc4d23b190f3f77c
Author: Yafang Shao <laoar.shao@gmail.com>

kbuild: rpm-pkg: Preserve .BTF section in kernel modules during debuginfo s=
tripping

This commit updates the RPM packaging scripts to pass --keep-section .BTF
to find-debuginfo.sh. This ensures that BTF information is preserved when
debuginfo is stripped from kernel modules.

> diff --git a/scripts/package/mkspec b/scripts/package/mkspec
> index c604f8c174e2c..00acef348ba84 100755
> --- a/scripts/package/mkspec
> +++ b/scripts/package/mkspec
[ ... ]
> @@ -65,6 +65,11 @@ fi
>  echo "%define with_debuginfo_manual $with_debuginfo_manual"
>  echo "%define with_debuginfo_rpm $with_debuginfo_rpm"
> =20
> +# Detect if find-debuginfo.sh supports --keep-section (RHEL 9+)
> +if find-debuginfo.sh --help 2>&1 | grep -q keep-section; then
> +	echo "%global with_keep_section 1"
> +fi

[Severity: Medium]
Is it safe to assume find-debuginfo.sh is in the standard user $PATH?

On many systems, this script resides in /usr/lib/rpm/, which isn't typically
in the $PATH. This could cause the check to silently fail and strip the .BTF
section during a local make rpm-pkg build.

Also, since mkspec runs during SRPM generation (make srcrpm-pkg), doesn't
this statically bake the generation host's capabilities into the resulting
kernel.spec file?

If the SRPM is rebuilt on an older distribution, rpmbuild might fail because
the older script rejects the --keep-section argument. If generated on an
older host and built on a newer one, BTF info would be silently stripped.
Could we dynamically query the target host's capabilities using something
like %(__find_debuginfo) inside the spec file itself?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260716025342.4262=
8-1-laoar.shao@gmail.com?part=3D1
