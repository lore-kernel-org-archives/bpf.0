Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A7EE390CB4
	for <bpf@vger.kernel.org>; Wed, 15 Apr 2026 21:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776287909; cv=none; b=WA4P4ijbfT3mFTtYP8R3CtAXJcyepsamVNISXCYir1Vh9UUf2eooRE3D0XduGe2vmfIFEStSRm1qzGDdAt3kIwL6I0/C9inoBImq00NAc+CDMoigZbuTYlwSVyZ3Q5HXgUZXXy8m9PX0KL8v3EeHni/CWmJRSwzjgnaorm2bQ6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776287909; c=relaxed/simple;
	bh=QmRFVpg6ut/wEgp+itg9S5io9UBrviUQMakUJ9yf9fk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=mi3dWLWhHqOBbcRxhCNSu+EsLqdrB7VZhLfPghQTFcabej4FOx0J6ochk+4Rla8btNKeNKBsmSxjnPXseYyjKO+KxIuDwovYVzqYZLlOcrlAmnClaBSgSy5BBeYNYfPFeLcmdXGBGoVdYj0s6AW2EMpczx7sLqeWfc3xpTum6vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qt+I8NmT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qt+I8NmT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFAFFC19424;
	Wed, 15 Apr 2026 21:18:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776287908;
	bh=QmRFVpg6ut/wEgp+itg9S5io9UBrviUQMakUJ9yf9fk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=Qt+I8NmTMt9uWqi4i8C3QNs4CFvZ+edF2Gf9zD9+0+potWC5ZT7SWatCe6k3ovAlk
	 7nUpRSR2ImCGOH3qKChtHMQn3bLiZ4DWlOTC43wC6Nxq7oPitZEyRiKaS/RuFsns9K
	 LU4+D4LjDol6dLj+lhhaF9rSbK6EnL5HJBWt+W4oHSGkYF2965TzAVY8/bE0vd2IwV
	 Y0squ1XZ/kusCVSuiNrLs4bx537d8rC0HIS+IYjSAgWqVTNUmwUMIW7nHp7fy35u9g
	 b1rvZCKyCvqfNO7sKoxWHt+s78XWOwqWmU1YOe5WEcdJVmid70tTtvHtCDIvn5JzQF
	 +euclmgW2ow6g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v5 02/11] selftests/bpf: Fix test_kmods KDIR to
 honor O= and distro kernels
Reply-To: sashiko@lists.linux.dev
To: =?utf-8?b?UmljYXJkbyBCLiBNYXJsacOocmU=?= <rbm@suse.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260415-selftests-bpf_misconfig-v5-2-03d0a52a898a@suse.com>
References: <20260415-selftests-bpf_misconfig-v5-2-03d0a52a898a@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 15 Apr 2026 21:18:28 +0000
Message-Id: <20260415211828.BFAFFC19424@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Sashiko AI review found 2 potential issue(s):
- [High] Skipping module compilation in permissive mode fatally breaks `rsy=
nc` during out-of-tree builds.
- [Medium] Silently omitting the kernel modules converts a build skip into =
unconditional runtime test suite failures.
--

commit 7696fe9d292ef9e4b288adf6be9f441665f1447a
Author: Ricardo B. Marli=C3=A8re <rbm@suse.com>

selftests/bpf: Fix test_kmods KDIR to honor O=3D and distro kernels

This commit updates test_kmods/Makefile to respect out-of-tree builds using
O=3D and KBUILD_OUTPUT. It also introduces a permissive mode that silently
skips building modules if the kernel directory is missing.

> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftes=
ts/bpf/Makefile
> --- a/tools/testing/selftests/bpf/Makefile
> +++ b/tools/testing/selftests/bpf/Makefile
> @@ -296,7 +296,7 @@ $(addprefix test_kmods/,$(subst .ko,%ko,$(TEST_KMODS)=
)): $(VMLINUX_BTF) $(RESOLV
> =20
>  $(TEST_KMOD_TARGETS): $(addprefix test_kmods/,$(TEST_KMODS))
>  	$(call msg,MOD,,$@)
> -	$(Q)cp test_kmods/$(@F) $@
> +	$(Q)$(if $(PERMISSIVE),if [ -f test_kmods/$(@F) ]; then )cp test_kmods/=
$(@F) $@$(if $(PERMISSIVE),; fi)

Does skipping the cp command leave the target file missing from
TEST_KMOD_TARGETS, which is subsequently included in TRUNNER_EXTRA_FILES?

During an out-of-tree build where O=3D is set, the rule
$(TRUNNER_BINARY)-extras runs rsync -aq $$^ $(TRUNNER_OUTPUT)/. Since $$^
evaluates to the prerequisites, it passes the missing .ko file path directly
to rsync.

Because the file was never created, does this cause rsync to fail fatally
with a No such file or directory error and abort the build?

Note that while the later patch selftests/bpf: Tolerate missing files
during install adds --ignore-missing-args to fix make install, it does not
modify the $(TRUNNER_BINARY)-extras target, leaving out-of-tree make all
broken.

> diff --git a/tools/testing/selftests/bpf/test_kmods/Makefile b/tools/test=
ing/selftests/bpf/test_kmods/Makefile
> --- a/tools/testing/selftests/bpf/test_kmods/Makefile
> +++ b/tools/testing/selftests/bpf/test_kmods/Makefile
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
> +else ifneq ("$(wildcard $(KDIR))", "")
> +	$(Q)$(MAKE) -C $(KDIR) $(if $(KMOD_O),O=3D$(KMOD_O),KBUILD_OUTPUT=3D) \
> +		M=3D$(TEST_KMOD_DIR) modules
> +endif

If permissive mode silently skips module compilation, does this convert a
build skip into unconditional runtime test suite failures?

While test_progs.c attempts to gracefully skip tests by checking
env.has_testmod, other runners and tests fail unconditionally.

For example, test_verifier.c explicitly calls load_bpf_testmod() and
immediately returns EXIT_FAILURE if it fails, aborting the entire
verification test suite.

Similarly, tests like bpf_mod_race.c contain strict assertions
(ASSERT_OK(load_bpf_testmod(false), ...)) in their recovery paths that fail
when the module is missing.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260415-selftests-=
bpf_misconfig-v5-0-03d0a52a898a@suse.com?part=3D2
