Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EBA26513C1
	for <bpf@vger.kernel.org>; Mon, 19 Oct 2026 14:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792418911; cv=none; b=jW3MnY0JTU7W/tQnanFJDb3KlwwhsLk8L9jID62D5gb0bBxWPGX6JzPT1KtyW/1hqyjtjIZrECPIT7HZBcl6XWaX3DtClcpMOUnXZ1RR1PBbEA2sG3VcNPaq3DENNbCPlUwyr16+yxJpEVPWxlg5R80CnhzU6uNzMj8uX8IwG2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792418911; c=relaxed/simple;
	bh=B2YOyuf3hjPRBN5AWXa9DYpcJu5CdUD1+Uc82f3qwYw=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=Rqd/xyKE7QyQeHoW1fz+nY3Yo78g48O+fDNXnfAs9zAGCRaGYGVRn/ncDu60JoD9b4H/vMq6anQV6Rl20RZhqEGKv9QNcU2JjPZ42Ll1qrY4xkGrHU4k1MJu4fvoocl/uodaVn7D8qbHcPY3GY5Dddo1No9FufVC3Ge5taKFWRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q4beaooB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q4beaooB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6E841F000C4;
	Mon, 19 Oct 2026 14:08:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792418909;
	bh=4fC59GdttMBEnFJwgI4XkPGQphY2ChShdJD58VKWO8c=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Q4beaooBPJShnkkjiX2OtU3cv9gIwXNazJznd2+AoZCfoVf8TEuLOQZu8yl9pp/eS
	 rHgLC7kGuy3VZeInQXDP4FhEA57WUKj4fzGr/CMkv53/bNcEaIeTF9YZflXWQR02ww
	 kdvSDpXbf2wv3cEcNndSzeUhiJvL8aqXMzdeiHv3OidsKT9FOVYz15dkfBZ+borAyc
	 HRyKQxD4IEaPDHU6QXed9nBf+18e7DIEFK4bPMth0D5rLI0l+VvujPajCJ2N4bBN2J
	 hewm1YydijwXM9vA+QYsJ/KAw2sSsxN7MFcub5d+7AAQyvP8lVPgvSH4BQUW0+GOtp
	 uRuTBTvV078wg==
Message-ID: <sashiko-outbox-177301@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v6 4/5] selftests/net: Add a shared BPF
 skeleton rule
Reply-To: sashiko-reviews@lists.linux.dev
To: "Bochao Cao" <bochaolucky@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20261018-xdp-v5-send-20261008-v6-4-7336e1282ca3@gmail.com>
References: <20261018-xdp-v5-send-20261008-v6-0-7336e1282ca3@gmail.com>
 <20261018-xdp-v5-send-20261008-v6-4-7336e1282ca3@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 19 Oct 2026 14:08:29 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] selftests/net: bpf.mk ignores LLVM when setting HOSTCC and HOSTL=
D for bpftool
--

commit 710ef769e16adaffb164124378ccc9076be7c9c1
Author: Bochao Cao <bochaolucky@gmail.com>

selftests/net: Add a shared BPF skeleton rule

This commit adds a shared rule to tools/testing/selftests/net/bpf.mk for
generating BPF skeletons, builds a host bootstrap bpftool when BPFTOOL is
not supplied, and adjusts header includes and submake variables.

> diff --git a/tools/testing/selftests/net/bpf.mk b/tools/testing/selftests=
/net/bpf.mk
> index a4f6755dd8941..016e32960280a 100644
> --- a/tools/testing/selftests/net/bpf.mk
> +++ b/tools/testing/selftests/net/bpf.mk

[ ... ]

> @@ -46,8 +46,37 @@ $(BPFOBJ): $(wildcard $(BPFDIR)/*.[ch] $(BPFDIR)/Makef=
ile)		       \
>  	   $(APIDIR)/linux/bpf.h					       \
>  	   | $(BUILD_DIR)/libbpf
>  	$(call msg,MAKE,,$@)
> -	$(Q)$(MAKE) $(submake_extras) -C $(BPFDIR) OUTPUT=3D$(BUILD_DIR)/libbpf=
/ \
> +	$(Q)$(MAKE) $(submake_extras) -C $(BPFDIR) srctree=3D$(abspath $(top_sr=
cdir)) \
> +		    OUTPUT=3D$(BUILD_DIR)/libbpf/ \
>  		    EXTRA_CFLAGS=3D'-g -O0'				       \
>  		    DESTDIR=3D$(SCRATCH_DIR) prefix=3D all install_headers
> =20
>  EXTRA_CLEAN +=3D $(SCRATCH_DIR)
> +
> +# Build a host bpftool only when a test needs a generated skeleton.
> +HOSTCC ?=3D gcc
> +HOSTLD ?=3D ld
> +BPFTOOL_BUILD :=3D $(BUILD_DIR)/bpftool
> +ifeq ($(origin BPFTOOL),undefined)
> +BPFTOOL :=3D $(BPFTOOL_BUILD)/bootstrap/bpftool
> +BPFTOOL_DEP :=3D $(BPFTOOL)
> +else
> +BPFTOOL_DEP :=3D $(shell command -v $(BPFTOOL))
> +endif
> +
> +$(BPFTOOL_BUILD)/bootstrap/bpftool: \
> +	$(wildcard $(top_srcdir)/tools/bpf/bpftool/*.[ch]) \
> +	$(top_srcdir)/tools/bpf/bpftool/Makefile \
> +	$(wildcard $(BPFDIR)/*.[ch] $(BPFDIR)/Makefile)
> +	$(call msg,MAKE,,$@)
> +	$(Q)mkdir -p $(BPFTOOL_BUILD)
> +	$(Q)$(MAKE) $(submake_extras) -C $(top_srcdir)/tools/bpf/bpftool \
> +		OUTPUT=3D$(BPFTOOL_BUILD)/ srctree=3D$(abspath $(top_srcdir)) \
> +		ARCH=3D CROSS_COMPILE=3D CC=3D"$(HOSTCC)" LD=3D"$(HOSTLD)" bootstrap

[Severity: Medium]
When building with LLVM=3D1, will defaulting HOSTCC to gcc and HOSTLD to ld
and passing them as CC and LD to the bpftool submake cause a toolchain
mismatch or fail on LLVM-only hosts?

Makefiles that include tools/testing/selftests/net/bpf.mk include
tools/testing/selftests/lib.mk first, which handles LLVM=3D by setting
LLVM_PREFIX, LLVM_SUFFIX, CLANG, and CC, but does not define HOSTCC or
HOSTLD. Because tools/testing/selftests/net/bpf.mk defaults HOSTCC ?=3D gcc
and HOSTLD ?=3D ld without checking LLVM, the $(BPFTOOL_BUILD)/bootstrap/bp=
ftool
recipe passes CC=3D"gcc" and LD=3D"ld" on the submake command line without
passing HOSTCC or HOSTLD.

Inside tools/bpf/bpftool/Makefile, tools/scripts/Makefile.include processes
LLVM=3D from MAKEFLAGS:

  $(call allow-override,CC,$(LLVM_PREFIX)clang$(LLVM_SUFFIX))
  $(call allow-override,CLANG,$(LLVM_PREFIX)clang$(LLVM_SUFFIX))
  $(call allow-override,HOSTCC,$(LLVM_PREFIX)clang$(LLVM_SUFFIX))
  $(call allow-override,AR,$(LLVM_PREFIX)llvm-ar$(LLVM_SUFFIX))
  $(call allow-override,HOSTAR,$(LLVM_PREFIX)llvm-ar$(LLVM_SUFFIX))
  $(call allow-override,LD,$(LLVM_PREFIX)ld.lld$(LLVM_SUFFIX))
  $(call allow-override,HOSTLD,$(LLVM_PREFIX)ld.lld$(LLVM_SUFFIX))

Because CC and LD have command-line origin, allow-override leaves them as
gcc and ld, while HOSTCC and HOSTLD resolve to clang and ld.lld. As a
result, tools/bpf/bpftool/Makefile compiles bootstrap/bpftool with
HOSTCC=3Dclang, while CC_NO_CLANG in tools/scripts/Makefile.include and
feature-libelf-zstd in tools/build/Makefile.feature probe CC=3Dgcc (enabling
GCC-only warning flags in EXTRA_WARNINGS and HOST_CFLAGS, or failing when
gcc is not installed).

Should HOSTCC and HOSTLD account for LLVM (or be passed through to the
submake as HOSTCC and HOSTLD after honoring LLVM)?

[ ... ]

>
>--=20
>2.51.0

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261018-xdp-v5-sen=
d-20261008-v6-0-7336e1282ca3@gmail.com?part=3D4
