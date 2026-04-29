Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B16C304BDF
	for <bpf@vger.kernel.org>; Wed, 29 Apr 2026 03:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777434820; cv=none; b=B70kS4Tr7v57NZ8lpJUReo0PcdfQT2TWiK2NFGJokktoG99VHvFRFVqxmdaYYjEb1DzJGIRHn96uk1PqLTOtXoezHAV95eU7lhaBtNG3gSZMqgIkDVIQFIiaCFiWI0YTXRiqzkEsrUFickpINWOKSXbOWN9QlnT3f9+Nq6Dg0cU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777434820; c=relaxed/simple;
	bh=LpJlezQ0HFX4Tz3+uj4+LBOJwSZLIypcYclVjDpGQ20=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=BTQi1JUvqHBbhpOW4uSW8DyYlDExPygsJhacytyVRWRZGvl/UDzMtIR0OrZQPUbdBH85Dt2Xqk3ZRuHhHSe0WZE8OGoca2iNFCFBU8iiZhrbaA6K5PAEeU4F1Infr42TbXwP684G88p2Y/cYZMkLNb0wmn7qCmnv8JQ7qeAubWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DPgKztH+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DPgKztH+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D682FC19425;
	Wed, 29 Apr 2026 03:53:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777434820;
	bh=LpJlezQ0HFX4Tz3+uj4+LBOJwSZLIypcYclVjDpGQ20=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=DPgKztH+1oGQFzvMOBNpkklh+/DhkhJGGzvbqEpImDObFEzfQnZBS4LL0IK/cCfKf
	 ZGUUGd49YG9OOGgFnQQlhMhfn1nSr1G3uNLYgFMconxFIXogPAJo6lJpsv84peaM74
	 2ALE/3ZPc4aXhrx9x3syHriaLQ/xKCgojr0Dgx1E6bgrEEYE7nT8FqbMcJCLGUcqR5
	 doLQhztH4WhRN9opWs3am3ZrISo2QmMaahTveBPGiIXbViL8BNzoXhdPQcYs3eUkMU
	 6DQ/AF92qp8Ppt3xSN5PXfr05J8JLwdpMo6hxHc6yNg8fcYjXtVAgA8vTcbfTpc6/h
	 LfEuDHHlV0m0w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v8 02/11] selftests/bpf: Fix test_kmods KDIR to
 honor O= and distro kernels
Reply-To: sashiko@lists.linux.dev
To: =?utf-8?b?UmljYXJkbyBCLiBNYXJsacOocmU=?= <rbm@suse.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260428-selftests-bpf_misconfig-v8-2-bf02cf97dbcb@suse.com>
References: <20260428-selftests-bpf_misconfig-v8-2-bf02cf97dbcb@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 29 Apr 2026 03:53:39 +0000
Message-Id: <20260429035339.D682FC19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Incorrect Kbuild variable precedence when both O=3D and KBUILD_O=
UTPUT=3D are set with different values.
--

commit 9fabc0968b75e1e4a5267d98394811c6db31a86e
Author: Ricardo B. Marli=C3=A8re <rbm@suse.com>

selftests/bpf: Fix test_kmods KDIR to honor O=3D and distro kernels

test_kmods/Makefile always pointed KDIR at the kernel source tree root,
ignoring O=3D and KBUILD_OUTPUT. On distro kernels where the source tree has
not been built, there was no fallback and the build would fail
unconditionally.

> diff --git a/tools/testing/selftests/bpf/test_kmods/Makefile b/tools/test=
ing/selftests/bpf/test_kmods/Makefile
> index 63c4d3f6a12f..dcba595b4b99 100644
> --- a/tools/testing/selftests/bpf/test_kmods/Makefile
> +++ b/tools/testing/selftests/bpf/test_kmods/Makefile

[ ... ]

> @@ -14,8 +25,21 @@ $(foreach m,$(MODULES),$(eval obj-m +=3D $(m:.ko=3D.o)=
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
> +	$(Q)$(MAKE) -C $(KDIR) $(if $(KMOD_O_VALID),O=3D$(KMOD_O_VALID),KBUILD_=
OUTPUT=3D) \

Will this cause an issue with Kbuild variable precedence if both O=3D and
KBUILD_OUTPUT=3D are set to different directories?

When a user provides both O=3D on the command line and KBUILD_OUTPUT=3D in =
the
environment, standard Kbuild prioritizes O=3D.

However, the parent bpf/Makefile passes KBUILD_OUTPUT explicitly on the
command line to this sub-make, upgrading it to a command-line variable
stored in MAKEFLAGS. This sub-make correctly evaluates
$(or $(O),$(KBUILD_OUTPUT)) to validate the O=3D directory, and calls the
kernel Makefile passing O=3D$(KMOD_O_VALID).

But because KBUILD_OUTPUT is also a command-line variable in MAKEFLAGS,
the kernel's top-level Makefile assignment "KBUILD_OUTPUT :=3D $(O)" is
ignored by GNU Make. Consequently, the kernel build uses the directory
specified by KBUILD_OUTPUT rather than the validated O=3D directory. This
leads to a build failure if KBUILD_OUTPUT lacks the prepared build
infrastructure.

Could we explicitly override KBUILD_OUTPUT when KMOD_O_VALID is true?
Something like:

    $(if $(KMOD_O_VALID),O=3D$(KMOD_O_VALID) \
        KBUILD_OUTPUT=3D$(KMOD_O_VALID),KBUILD_OUTPUT=3D)

> +		M=3D$(TEST_KMOD_DIR) modules
> +else ifneq ("$(wildcard $(KDIR))", "")
> +	$(Q)$(MAKE) -C $(KDIR) $(if $(KMOD_O_VALID),O=3D$(KMOD_O_VALID),KBUILD_=
OUTPUT=3D) \

Would the same explicit override for KBUILD_OUTPUT be needed here as well?

> +		M=3D$(TEST_KMOD_DIR) modules
> +endif
> =20
>  clean:
> -	$(Q)$(MAKE) -C $(KDIR) M=3D$(TEST_KMOD_DIR) clean
> +ifneq ("$(wildcard $(KDIR))", "")
> +	$(Q)$(MAKE) -C $(KDIR) $(if $(KMOD_O_VALID),O=3D$(KMOD_O_VALID),KBUILD_=
OUTPUT=3D) \

And also for the clean target?

> +		M=3D$(TEST_KMOD_DIR) clean
> +endif

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260428-selftests-=
bpf_misconfig-v8-0-bf02cf97dbcb@suse.com?part=3D2
