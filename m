Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B57D946F48B
	for <bpf@vger.kernel.org>; Tue, 21 Jul 2026 19:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784663537; cv=none; b=aAu5sj5Yagedo1oPTRIGc37vilbIUclKUOnTNzJsoaZc4YigoQXao7tgw8M8W421+nRLSbZkD9EJPKmLpJBJ5XQQLjtO6Yz/ECMZrn0XxyGeuc86DOu/WzlWIITBQVgDaJAypQdwNsxZPsaCIy0c6Nhxj3S5fb6lPgZw5BE1I2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784663537; c=relaxed/simple;
	bh=uJlifbMY2TDmHwjFa5rsBBnnQtSyLuzQRMpQ5dPbsFI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Q/SmTVxD/WRvlVS0vMR8M+RyW2Sni3+n/nsrSrM8o0MnHmWCfNpRf/xIgn5p3zRwNo3y5CoghN88L5pT5B4Wp8nVdoqBFm9VaHXIj/54mHRpHAUqw6NKo+dcAZnAb0d/U7/J7T0eaRneFfLU9DHLBChyd3X1+rVFUC3suvhTElo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fz432JhW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fz432JhW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 712FC1F00A3A;
	Tue, 21 Jul 2026 19:52:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784663536;
	bh=F7O+1ednDdWhIr44uyOnhNkgO7DsXSDG5HEJaE8X1Zk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Fz432JhWQ7jb1b2XrOFQMcq1FS7yl3/LownzlifxDk3Iq+bu8+qtqrRXsGK6LEYcP
	 klRFMvK6/XgUmaH8N5vtxoPN1+bDud28watIyguNsv/tenmMy3MnUrRTOn2Ctn7H0g
	 QYld5cpCUN4LY07pt1tGxfBpJpbSLRRTxmUiGs53FheGW0iRspi3Dg7qe7geiYF5vC
	 UM8AZPgkfWv+ISLFiSzYWVgaDdMXK6R2mWUsBhxZWkc2yMHT/l3xBfpkqFRLnTuFPD
	 02mIqJ3QLo8WA28/5i+SpGDlb5tQxbrLlld/88+z4CFnwQHM79m294BIvyGPo3S/sS
	 M8SDaiNM7R9TA==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH bpf-next v2 2/3] selftests/bpf: move shared build
 definitions into Makefile.buildvars
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mykola Lysenko" <nickolay.lysenko@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260721194111.334795-3-nickolay.lysenko@gmail.com>
References: <20260721194111.334795-1-nickolay.lysenko@gmail.com>
 <20260721194111.334795-3-nickolay.lysenko@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 21 Jul 2026 19:52:16 +0000
Message-Id: <20260721195216.712FC1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The variables TEST_KMODS and BPF_GCC are duplicated in both Make=
file and Makefile.buildvars, creating a brittle maintenance hazard.
--

--- Patch [2]: [RFC PATCH bpf-next v2 2/3] selftests/bpf: move shared build=
 definitions into Makefile.buildvars ---
commit 609eb873658507425701a592c055f112cedbb6b8
Author: Mykola Lysenko <nickolay.lysenko@gmail.com>

selftests/bpf: move shared build definitions into Makefile.buildvars

This commit moves toolchain, path, flag, and probe definitions from the main
Makefile into a new Makefile.buildvars file. This allows these definitions
to be included by multiple makefiles for running test instances in sub-make=
s.

> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftes=
ts/bpf/Makefile
> index 09e5be201afb5..2ddcb812dc85c 100644
> --- a/tools/testing/selftests/bpf/Makefile
> +++ b/tools/testing/selftests/bpf/Makefile
[ ... ]
> +# These probes gate the flavor list, which must be final before lib.mk is
> +# included; keep values consistent with Makefile.buildvars.
> +ifeq ($(origin BPF_GCC),undefined)
> +BPF_GCC :=3D $(shell command -v bpf-gcc;)
>  endif
[ ... ]
> -TEST_KMODS :=3D bpf_testmod.ko bpf_test_no_cfi.ko bpf_test_modorder_x.ko=
 \
> +TEST_KMODS ?=3D bpf_testmod.ko bpf_test_no_cfi.ko bpf_test_modorder_x.ko=
 \
>  	bpf_test_modorder_y.ko bpf_test_rqspinlock.ko
[ ... ]
> diff --git a/tools/testing/selftests/bpf/Makefile.buildvars b/tools/testi=
ng/selftests/bpf/Makefile.buildvars
> new file mode 100644
> index 0000000000000..2a7efe6d1c795
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/Makefile.buildvars
[ ... ]
> +# Immediate (with an override-preserving guard): a plain ?=3D stays
> +# recursively expanded and would re-run 'command -v' on every expansion.
> +ifeq ($(origin BPF_GCC),undefined)
> +BPF_GCC		:=3D $(shell command -v bpf-gcc;)
> +endif
[ ... ]
> +# Kernel test modules; TEST_KMODS=3D on the command line disables them.
> +TEST_KMODS ?=3D bpf_testmod.ko bpf_test_no_cfi.ko bpf_test_modorder_x.ko=
 \
> +	bpf_test_modorder_y.ko bpf_test_rqspinlock.ko

[Severity: Medium]
Does keeping duplicate definitions of TEST_KMODS and BPF_GCC in both Makefi=
le
and Makefile.buildvars create a maintenance hazard?

Since Makefile defines TEST_KMODS with "?=3D" before including
Makefile.buildvars, if a developer adds a new test module to
Makefile.buildvars but forgets to update Makefile, the new module won't
be built because the Makefile definition takes precedence and ignores the
update.

Could these definitions be consolidated into a single location to prevent
silent build failures from desynchronized lists?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260721194111.3347=
95-1-nickolay.lysenko@gmail.com?part=3D2
