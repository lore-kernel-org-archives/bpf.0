Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74CB71DB54C
	for <bpf@vger.kernel.org>; Thu, 14 May 2026 04:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778732585; cv=none; b=d8qGYCDxxJ0gHqfj5f/H5SS+vbJgX46bl3+cWxad9QpuE/Fv1zemED4mrLYOvArOjaBwhqXo5asbq1etIAX4jO85JHCWeYSlmE/swnXIykpZUJag4nIqlOdwqrzGQhvMG3wCblHEcE0+h5YQLGcXWK5rpNRNkWMvpPudS/LB/R4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778732585; c=relaxed/simple;
	bh=i0c34wutd56w1OL6wbvY7w+qP021ydJ+cfefLVkdb+c=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=iZB+wkCRwR2uGDuHXa2uCpQIR6mxPYTiOqaNeNpKKcEGXesAXE6KrmTDvVgREAdE8CXi3wM1qVKoDTGyCzYs2Nv9N02StsdcWjtIgU2a1tx/smnYjTwr47x4tBFyRZn+BKcbkGJ/r2ZZehyjjUXJo6l+ZVAwVCmb8tnyLaNlJaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WbbXSogk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WbbXSogk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF3ECC2BCB7;
	Thu, 14 May 2026 04:23:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778732585;
	bh=i0c34wutd56w1OL6wbvY7w+qP021ydJ+cfefLVkdb+c=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=WbbXSogk10zSb/7b6W4Tn9wWNHB0pA13yeK4QoIf5LJsWH0Fp+i/kjLastWOww3ya
	 KQOUCkC71ThzemolgSBpk/Wxyq+NbfA6PxouU4d0N+oNTe1iPaCIxA8kr8ZX4ri947
	 3NllW6PqSJa40dOPsUiFd2t85d1Do894epDmJwHUbnUORwmoEIcqvmBIcR2qYQL3jz
	 EQywnR0FFrc5PoD/cBYN+CAtGNwLpPK5+/4j2q04RAU0lqKr3QA0ti0ib3/FmBnVXw
	 qSWJUhP4uDayuzy7ESxOjblcQ2qDp6Yamh5A2O2FcDDMQMS6sZ8uwVkBgd7xFHXsNv
	 tz5H588ln/fDw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next] selftests/bpf: Override EXTRA_LDFLAGS for
 static builds
Reply-To: sashiko-reviews@lists.linux.dev
To: "Paul Chaignon" <paul.chaignon@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <714556da329c812988010ffe53173d9152570a78.1778669303.git.paul.chaignon@gmail.com>
References: <714556da329c812988010ffe53173d9152570a78.1778669303.git.paul.chaignon@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 14 May 2026 04:23:04 +0000
Message-Id: <20260514042304.EF3ECC2BCB7@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The suggested workaround `EXTRA_LDFLAGS=3D-static` in README.rst=
 breaks the bpftool build or silently disables LLVM support.
--

commit dcbd0d5d7a0eb4a9300ad0890d83b7e4cdfd3aeb
Author: Paul Chaignon <paul.chaignon@gmail.com>

selftests/bpf: Override EXTRA_LDFLAGS for static builds

This commit updates the README.rst for BPF selftests to include
EXTRA_LDFLAGS=3D-static when recommending how to statically link,
in order to fix shared library loading errors with libLLVM.so
when running vmtest.sh.

> diff --git a/tools/testing/selftests/bpf/README.rst b/tools/testing/selft=
ests/bpf/README.rst
> index 776fbe3cb8f9b..37164322a1023 100644
> --- a/tools/testing/selftests/bpf/README.rst
> +++ b/tools/testing/selftests/bpf/README.rst
> @@ -77,7 +77,7 @@ In case of linker errors when running selftests, try us=
ing static linking:
> =20
>  .. code-block:: console
> =20
> -  $ LDLIBS=3D-static PKG_CONFIG=3D'pkg-config --static' vmtest.sh
> +  $ LDLIBS=3D-static EXTRA_LDFLAGS=3D-static PKG_CONFIG=3D'pkg-config --=
static' vmtest.sh

Can adding EXTRA_LDFLAGS=3D-static break the bpftool build or silently disa=
ble
LLVM support?

In the bpftool Makefile, LLVM's --system-libs and -lstdc++ are only appended
to LIBS if llvm-config --shared-mode outputs 'static'. However, the
feature-llvm test in tools/build/feature/Makefile unconditionally includes
--system-libs and uses g++, which automatically includes -lstdc++.

If a system has static LLVM libraries but llvm-config --shared-mode is set
to 'shared' (common on many distros), the feature-llvm test statically links
successfully, but bpftool's Makefile will attempt to build with LLVM support
using gcc -static while omitting --system-libs and -lstdc++. This can cause
the build to fail with undefined references.

Additionally, if static LLVM libraries are entirely absent, the feature test
fails, causing bpftool to silently build without LLVM support.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/714556da329c8129880=
10ffe53173d9152570a78.1778669303.git.paul.chaignon@gmail.com?part=3D1
