Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99B8133FE0F
	for <bpf@vger.kernel.org>; Tue, 21 Jul 2026 14:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784643982; cv=none; b=U1maE3OQ1txv9Iu367h3DmR3qADK1zPWQKDCVkVrRjaULp/pBKsZ2UUdtMAy0E3uhLAAc+82Dx8HB9e45VvD/UIG6iznEj3NOTr/D3bNyC08mCIcWZxNzpwz8h9cggASyDtCuWQyTg64FoTuQTdUQINeiFcff/BsAZLlIFvCTp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784643982; c=relaxed/simple;
	bh=ymdFqo9lG2eAYRa4z+/MX1v6abeDb5E1HpRITEhFbRI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=iT3hGj5Mba1jr3TD7xAjmR/lDcZcrVQ1P5BzvL8DpRZ3vFZE4MvAaw6yUy242JA9u77AUZgI8gR4tLoV8pHGSIum5LpdsGI2KFeE7m81iKgIRAt3qBnu52sXFijEqUkPTjsSBD7ebrXX0LaJIdcz4u5RfHBKHKb9Ybo4qKrV0j4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H5AXUW68; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H5AXUW68"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EE4B1F000E9;
	Tue, 21 Jul 2026 14:26:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784643981;
	bh=ymdFqo9lG2eAYRa4z+/MX1v6abeDb5E1HpRITEhFbRI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=H5AXUW68d2MEJaH0hT2YxX2vFWguF+VdgRYlgKgfVP1cXuAlpNC4wpR56z43SHLSq
	 rmSoyaGEE29cBMBj5AERJe0aJ9rf9c+IRLLZ7mZh8SOChU5QCbyUKuE+D51Vmn0578
	 HcipGLVvK5AD6cjwKPQTveI6xB+algzGnS/lVF5jPEycteWv4VZKR25jhFrr4mJv6H
	 g+vFtNJpjeo3boXZehZKqp9YUgPY5yuXvPHGu1eG0htlV18LNyQzLV/TVQm9DG0+Aj
	 EmBQWoCawa9MsZ9YHI8iyr0/OPTBSw/Rp59CSXMSBZlFwfD0FdsfAuFW1bwSyqTe0M
	 tC7M7Kz6iAmRQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 14/21] binfmt_misc: document the transparent identity
 contract
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christian Brauner" <brauner@kernel.org>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260721-work-bpf-binfmt_misc-ptinterp-v2-14-e57866e4ae0f@kernel.org>
References: <20260721-work-bpf-binfmt_misc-ptinterp-v2-0-e57866e4ae0f@kernel.org>
 <20260721-work-bpf-binfmt_misc-ptinterp-v2-14-e57866e4ae0f@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 21 Jul 2026 14:26:20 +0000
Message-Id: <20260721142621.5EE4B1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Documentation incorrectly claims PR_SET_MM_MAP requires privileg=
es to retarget auxv and memory markers.
--

--- Patch [14]: [PATCH v2 14/21] binfmt_misc: document the transparent iden=
tity contract ---
commit ca9e0f57f6063d4c7be0eda47389dcf9a21a1409
Author: Christian Brauner <brauner@kernel.org>

binfmt_misc: document the transparent identity contract

This commit documents the transparent interpreter contract for binfmt_misc,
describing how arguments are preserved, how the binary is passed via
AT_EXECFD, and the roles of the interpreter and program during loading.

> diff --git a/Documentation/admin-guide/binfmt-misc.rst b/Documentation/ad=
min-guide/binfmt-misc.rst
> index 81b78e315fad8..ea1c1c0676c88 100644
> --- a/Documentation/admin-guide/binfmt-misc.rst
> +++ b/Documentation/admin-guide/binfmt-misc.rst

[ ... ]

> @@ -223,6 +223,36 @@ binfmt_misc instances themselves are looked up. The =
entry keeps the handler
> +code/data statistics markers via one ``PR_SET_MM_MAP`` which completes
> +what attaching debuggers observe. The prctl is privileged - it takes
> +``CONFIG_CHECKPOINT_RESTORE`` plus ``CAP_CHECKPOINT_RESTORE`` or
> +``CAP_SYS_ADMIN`` in the caller's user namespace - so a loader running
> +without these leaves the aux vector and the markers as the kernel set
> +them. What remains visibly different from a direct

[Severity: Medium]
Is this documentation accurate regarding the privilege requirements for
PR_SET_MM_MAP?

Looking at prctl_set_mm_map(), the checkpoint_restore_ns_capable() check is
explicitly skipped if the provided prctl_map.exe_fd is -1.=20

Because a transparent interpreter already has /proc/pid/exe correctly label=
ed
by the kernel, the loader shouldn't need to change the exe_fd.

Doesn't this mean a loader can successfully retarget the auxv and memory=20
markers completely unprivileged by simply passing exe_fd =3D -1?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260721-work-bpf-b=
infmt_misc-ptinterp-v2-0-e57866e4ae0f@kernel.org?part=3D14
