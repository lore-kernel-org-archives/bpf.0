Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9B10352C34
	for <bpf@vger.kernel.org>; Thu, 16 Apr 2026 12:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776344002; cv=none; b=PCAgHfGdK4Y5p9aAMkavBIgljqe6Bdt+YaKEfjCrg5EBC5AdpQoUv96S1oODJkxqJnlBc82POy/iC0hgRuxS9tbSS5v5TbMxcewLomUMPXJLBE5cFiu9/Gs3ZFkLahy6L+YPlZ/CD3xzmX3a60Ilk3OrB5+7mHA+AUoHM74CAME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776344002; c=relaxed/simple;
	bh=pMGl1NyQIOKOPoS3meUph0ZjEoSeWKYbxnd36apMuvA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=W5DdTqC9CEMER9HDAPlzadtcnRszaEK77jvDwhIVk9nOpneSFuM6QKK7XBQwMFOY3bI6C0WknxN6+kOysrq6FuWh3iFY6LdTNZVkCoX74KBN7i8glNw+C8rW6ltjSscO0SON9zs1EsANPybiMLuU3oKXuvfibdBGC7/v36lCH8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f0wZ5urz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f0wZ5urz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AF09C2BCAF;
	Thu, 16 Apr 2026 12:53:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776344001;
	bh=pMGl1NyQIOKOPoS3meUph0ZjEoSeWKYbxnd36apMuvA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=f0wZ5urzEWrJDZ+AFUwzP250XcFFYKIkkCz7VWEh6D/N5AYi+NF6Qi88rCi0hGfkg
	 5wS+dMAXVx94R/rhybn5jdmytDrvjP7EvLVwycIpoJeeogTUPsZ4Rw/aoe1qiPBNGl
	 hnRAFRzE+8X1kq+LYZ8jh7KryRg1Qgcw5Zi6a6c689RKIbKiW/rZfkgZoPGCc/nyMy
	 S9K/R6Pux1jhrigUY8B+afx36oVRJR1Cd8i2Vc1Yy9SSiH1Ppvnt0P4b6X0Sv0mEuu
	 HqGnyQUxjUqhBNJMNA+Tqi9wFyH5VRtoNBt8Mb4hhJWtGeE+zr3cBUQ5qx6hDoFe4s
	 PtBNBmx0FkupA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v6 02/11] selftests/bpf: Fix test_kmods KDIR to
 honor O= and distro kernels
Reply-To: sashiko@lists.linux.dev
To: =?utf-8?b?UmljYXJkbyBCLiBNYXJsacOocmU=?= <rbm@suse.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260416-selftests-bpf_misconfig-v6-2-7efeab504af1@suse.com>
References: <20260416-selftests-bpf_misconfig-v6-2-7efeab504af1@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 16 Apr 2026 12:53:20 +0000
Message-Id: <20260416125321.7AF09C2BCAF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Sashiko AI review found 2 potential issue(s):
- [Medium] Relative paths passed via `O=3D` are incorrectly evaluated from =
the kernel source root instead of the invocation directory.
- [Medium] The `make clean` target unconditionally fails and aborts the bui=
ld if the kernel source tree is unconfigured and distro headers are missing.
--

commit 533e8d39cc98f56f3dff4f8c5bff0dcd49fc6ef1
Author: Ricardo B. Marli=C3=A8re <rbm@suse.com>

selftests/bpf: Fix test_kmods KDIR to honor O=3D and distro kernels

This commit modifies test_kmods/Makefile to honor O=3D and KBUILD_OUTPUT, a=
nd
adds a fallback to /lib/modules/$(uname -r)/build for distro kernels. It al=
so
makes missing KDIR silently skipped when building in permissive mode.

> diff --git a/tools/testing/selftests/bpf/test_kmods/Makefile b/tools/test=
ing/selftests/bpf/test_kmods/Makefile
> index 63c4d3f6a12f6..10f202bd0d8c2 100644
> --- a/tools/testing/selftests/bpf/test_kmods/Makefile
> +++ b/tools/testing/selftests/bpf/test_kmods/Makefile
> @@ -1,5 +1,7 @@
>  TEST_KMOD_DIR :=3D $(realpath $(dir $(abspath $(lastword $(MAKEFILE_LIST=
)))))
> -KDIR ?=3D $(abspath $(TEST_KMOD_DIR)/../../../../..)
> +SRCTREE_KDIR :=3D $(abspath $(TEST_KMOD_DIR)/../../../../..)
> +KMOD_O :=3D $(or $(O),$(KBUILD_OUTPUT))

Will this break out-of-tree builds if a user passes a relative path?

If a user builds selftests with a relative O=3D path (e.g. make O=3Dout), K=
MOD_O
captures this relative string and passes it unaltered to the kernel build
system via make -C $(KDIR) O=3D$(KMOD_O).

Because make -C changes the working directory to $(KDIR) before evaluating
O=3D, the relative path will be evaluated relative to the kernel root rather
than the directory where make was originally invoked.

[ ... ]
> @@ -14,8 +16,24 @@ $(foreach m,$(MODULES),$(eval obj-m +=3D $(m:.ko=3D.o)=
))
> =20
>  CFLAGS_bpf_testmod.o =3D -I$(src)
> =20
> +# When BPF_STRICT_BUILD !=3D 0, a missing KDIR is fatal (the default).
> +# When permissive, skip silently.
> +PERMISSIVE :=3D $(filter 0,$(BPF_STRICT_BUILD))
> +
>  all:
> -	$(Q)$(MAKE) -C $(KDIR) M=3D$(TEST_KMOD_DIR) modules
> +ifeq ($(PERMISSIVE),)
> +	$(Q)$(MAKE) -C $(KDIR) $(if $(KMOD_O),O=3D$(KMOD_O),KBUILD_OUTPUT=3D) \
> +		M=3D$(TEST_KMOD_DIR) modules

[ ... ]

>  clean:
> -	$(Q)$(MAKE) -C $(KDIR) M=3D$(TEST_KMOD_DIR) clean
> +ifeq ($(PERMISSIVE),)
> +	$(Q)$(MAKE) -C $(KDIR) $(if $(KMOD_O),O=3D$(KMOD_O),KBUILD_OUTPUT=3D) \
> +		M=3D$(TEST_KMOD_DIR) clean

Does this unconditionally abort make clean if the kernel source tree is
unconfigured and distro headers are missing?

If the system lacks installed kernel headers, /lib/modules/$(uname -r)/build
will not exist. In the default strict mode, GNU Make's -C flag will
immediately throw a fatal 'No such file or directory' error and abort the
make clean process.

> +else ifneq ("$(wildcard $(KDIR))", "")
> +	$(Q)$(MAKE) -C $(KDIR) $(if $(KMOD_O),O=3D$(KMOD_O),KBUILD_OUTPUT=3D) \
> +		M=3D$(TEST_KMOD_DIR) clean
> +endif

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260416-selftests-=
bpf_misconfig-v6-0-7efeab504af1@suse.com?part=3D2
