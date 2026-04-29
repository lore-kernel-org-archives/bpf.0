Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1AD233858B
	for <bpf@vger.kernel.org>; Wed, 29 Apr 2026 19:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777491667; cv=none; b=AnKI8D6DcGlWS65pPva0VyPfol9g0bnJT26kxQO+uKMaFGtDuA3YUwsp8iUE3tMKR8EzDaRuZfdCovHfbo57rTx24RB5depYmYMj69NWUJqoG7/S/gzwMPj488M6QCkU1MF6NlSvj0CgdP2fqjtjtr4X4MepYxNEOx9VytNQc2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777491667; c=relaxed/simple;
	bh=zdog0kvchKHSSn3V4En0FEc0BjxjV4Fj6H+LeR1E1Mw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=HKdQDDXw7LBOGqEdskWot429seW9VIejzyZ0LaNnlzQL30wxMyngg90n0+s6+XczgUHYMvwORleq5T9QE+gQvd7CRwHAnoqixpv5K8Phs5rKO2eyM6mJmPVOR8dxTGp1LvcVQM7dspLTf3JwxHQZLRb+ZnlQENAihfEkqlCiqpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s3dEdd70; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s3dEdd70"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 806B7C19425;
	Wed, 29 Apr 2026 19:41:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777491667;
	bh=zdog0kvchKHSSn3V4En0FEc0BjxjV4Fj6H+LeR1E1Mw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=s3dEdd70nJuaMNJzdyMCGCTVQhKNaq3fpElreCp8ZJkM+p+5WJ4iNC8H0GDnWFaRL
	 UGsoTGLZxDmOXuMA9SLlHgaOA6Ke5MyUYneF7VWEEZQIrktgJvyBXJcB2f25FRi1v7
	 nDtg4wuDzl3bTXrz2zYTtdQ2PMDbfetU+o83BVGn42z/npGutn4RFF0xzsco8dEo+x
	 bjS3ObcvpFuJWPJcKIF7cw7gO8fyairQHfkgaQ83hfs5nSPU78TzZYYEkeXLERrhor
	 HeKmMvSIMsAypebDN54545NilIKQMCno8PwdwDGapQLT9Yt5J6Fe2ZattOKSdjADjj
	 +DEd27iiKgCtg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v9 02/11] selftests/bpf: Fix test_kmods KDIR to
 honor O= and distro kernels
Reply-To: sashiko@lists.linux.dev
To: =?utf-8?b?UmljYXJkbyBCLiBNYXJsacOocmU=?= <rbm@suse.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260429-selftests-bpf_misconfig-v9-2-c311f06b4791@suse.com>
References: <20260429-selftests-bpf_misconfig-v9-2-c311f06b4791@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 29 Apr 2026 19:41:06 +0000
Message-Id: <20260429194107.806B7C19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Automatical fallback to host kernel headers (`/lib/modules/$(uname=
 -r)/build`) for building in-tree BPF test modules will cause confusing bui=
ld failures and defeats the permissive skip logic.
--

commit ffa2987a74e06bf51c1a3ffcf2c85b1504b4d383
Author: Ricardo B. Marli=C3=A8re <rbm@suse.com>

selftests/bpf: Fix test_kmods KDIR to honor O=3D and distro kernels

This commit updates the test_kmods Makefile to honor O=3D and
KBUILD_OUTPUT directories, and falls back to distro kernel headers
when the source tree is unconfigured.

> diff --git a/tools/testing/selftests/bpf/test_kmods/Makefile b/tools/test=
ing/selftests/bpf/test_kmods/Makefile
> index 63c4d3f6a12f..031c7454ce65 100644
> --- a/tools/testing/selftests/bpf/test_kmods/Makefile
> +++ b/tools/testing/selftests/bpf/test_kmods/Makefile
> @@ -1,5 +1,16 @@
[ ... ]
> +KMOD_O :=3D $(or $(O),$(KBUILD_OUTPUT))
> +KMOD_O_VALID :=3D $(if $(KMOD_O),$(if $(wildcard $(KMOD_O)/Module.symver=
s),$(KMOD_O)))
> +KDIR ?=3D $(if $(KMOD_O_VALID),$(SRCTREE_KDIR), \
> +	    $(if $(wildcard $(SRCTREE_KDIR)/Module.symvers),$(SRCTREE_KDIR), \
> +		/lib/modules/$(shell uname -r)/build))

Will falling back to the host kernel headers cause compilation errors when
building in-tree test modules like bpf_testmod?

Since bpf_testmod relies heavily on internal BPF structures, experimental
macros, and kfuncs that change frequently between kernel releases, compiling
it against /lib/modules/$(uname -r)/build on a system where the running
kernel does not exactly match the upstream source tree will likely fail.

Additionally, if the host headers are present, the permissive skip check
further down in the file will pass since the directory exists.

Because the compilation failure is not ignored by the parent bpf/Makefile,
won't this abort the entire BPF selftests build with confusing C compilation
errors instead of silently skipping the unconfigured kernel tree?

Should in-tree test modules avoid falling back to host distro headers to
prevent these version mismatches?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260429-selftests-=
bpf_misconfig-v9-0-c311f06b4791@suse.com?part=3D2
