Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794246302;
	b=bvMApKguN7SZ2wEjhEN9zNPtHH5Jp6WnDIr30f67zoFPY0xNKzIsvYI0syGombSThgcH
	 /FxYq5RZK4aa/kkL3+W2ijqmk5j7dM9w/3TXtpcWQPKDfKtwdbjAATzMzhBRZS5hyW8+J
	 rKL/dwYaNrhK2CxVIzzpdvWL5ghurLsOLgbFPGW8Yr3uCIErfMKY13TkX5odqMvSRdqPa
	 4WjsFNT1ROAg5uamQxM0Zb8KcTvyHo2AlEk48K+qkVRtKdxPOtM1iv6RV0URg8bR6Z3z2
	 RRSH60wk80YszoIBnVVi3e3R+oAyepDXN/MaPn357SVU9/t/BReROSSG7TPmPtQn8sA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794246302;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=m0ssjIBr/+gY3LAWR3lvmEG3gxTSZMmrSQ01WdIhf20=;
	b=af3pbu3dbSh8cdN+02/qMnUywcKhiBkVkDWXT8CbK22QFetEoODbhM9VLhIbQVyhIzoS
	 FQBQnpSG0sHaOp3P/yox0YQcQiPulozPFJEfIooVa3vSTDeJ3j5NaOwgQUaMPDnt79dUp
	 dE7HGU0JFvVawSwAq7X1s/KoeYB7VtyU27w6LcHsZFJrdXCFSNFbcALQTadvTE1WHq1Wo
	 2NzF3vEWdvQ3LcaUbqVyqSZL5zQtoTNlHjTdARva30nRqA5RVhs/V9NkNs5JIQWkrKQXM
	 MBFxru83QE1uF4rtMAw+MTyucM/xSUN5aDnvOE87OQQzfs4qT3KtHQV0HMFS9GK2voQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jz9+kRFq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EB25606A334
	for <bpf@vger.kernel.org>; Mon,  9 Nov 2026 17:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jz9+kRFq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1574F1F008A2;
	Mon,  9 Nov 2026 17:45:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794246302;
	bh=m0ssjIBr/+gY3LAWR3lvmEG3gxTSZMmrSQ01WdIhf20=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=jz9+kRFqTWzI4PvG0jFupjQaMcCWYpRlCOXK0GjcqRp3zYMIIijbV22C8XSAPJXAZ
	 Ru1JGbP8QyIE1I3/vAXYhA+PBsqHUh1ObaZePh67xARcJFa2OzvFpxEXG6+slnMe2N
	 85gI4osAz/LVoYFOa7i2SSkSh0MDB06JeiV9H+LtSj5CMsjT8freSWvC89BNs1y2L6
	 4Qe6tqVsyWfKaQBH05HsX59tU1pYWLz1EJaR6BNPWuTA7bkABbKT248feHIvjN5TiR
	 sreL1/RgwCjitqpyF+GK+tt3S30vWwS0dyS7RyBtHsrYjEKT5u3qOaSwWFpUJnSH4F
	 psZIxnKFU3kUQ==
Message-ID: <sashiko-outbox-205331@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 bpf-next 07/18] scripts: Add LLVM plugin
 infrastructure
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anton Protopopov" <a.s.protopopov@gmail.com>, bpf@vger.kernel.org
In-Reply-To: <20261109170550.141443-8-a.s.protopopov@gmail.com>
References: <20261109170550.141443-1-a.s.protopopov@gmail.com>
 <20261109170550.141443-8-a.s.protopopov@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Nov 2026 17:45:01 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [Low] riscv: pi: filter out LLVM_PLUGINS_CFLAGS from KBUILD_CFLAGS
- [Low] vdso: avoid stripping LLVM_PLUGINS_CFLAGS from kernel objects
--

commit 072fb07f8d2d07b80e87b0ea8e05cc60c466504e
Author: Anton Protopopov <a.s.protopopov@gmail.com>

scripts: Add LLVM plugin infrastructure

This commit adds Kbuild and Kconfig infrastructure for building and loading
LLVM IR pass plugins with -fpass-plugin, and excludes LLVM_PLUGINS_CFLAGS
from vDSO, EFI stub, and early boot builds.

> diff --git a/arch/arm64/kernel/pi/Makefile b/arch/arm64/kernel/pi/Makefile
> index a273ab5af805c..5813bb75c9925 100644
> --- a/arch/arm64/kernel/pi/Makefile
> +++ b/arch/arm64/kernel/pi/Makefile
> @@ -10,6 +10,7 @@ KBUILD_CFLAGS	:=3D $(subst $(CC_FLAGS_FTRACE),,$(KBUILD=
_CFLAGS)) -fpie \
>  		   -D__DISABLE_EXPORTS -ffreestanding -D__NO_FORTIFY \
>  		   -fno-asynchronous-unwind-tables -fno-unwind-tables \
>  		   $(CONFIG_CC_OPT_NO_ADDRSIG)
> +KBUILD_CFLAGS	:=3D $(filter-out $(LLVM_PLUGINS_CFLAGS),$(KBUILD_CFLAGS))

[Severity: Low]
Should arch/riscv/kernel/pi/Makefile also filter out $(LLVM_PLUGINS_CFLAGS)
from KBUILD_CFLAGS?

Like arch/arm64/kernel/pi/Makefile, it compiles pre-MMU position-independent
early boot objects with -fpie and -ffreestanding, filters out
CC_FLAGS_FTRACE and CC_FLAGS_LTO, and prefixes symbols with __pi_ via
objcopy.  Leaving LLVM_PLUGINS_CFLAGS enabled there can break symbol
confinement or introduce absolute addresses before the MMU and relocations
are active.

[ ... ]

> diff --git a/lib/vdso/Makefile.include b/lib/vdso/Makefile.include
> index cedbf15f80874..848d58296ba23 100644
> --- a/lib/vdso/Makefile.include
> +++ b/lib/vdso/Makefile.include
> @@ -1,5 +1,8 @@
>  # SPDX-License-Identifier: GPL-2.0
> =20
> +# vDSO code executes outside the kernel.
> +KBUILD_CFLAGS :=3D $(filter-out $(LLVM_PLUGINS_CFLAGS),$(KBUILD_CFLAGS))
> +
>  GENERIC_VDSO_MK_PATH :=3D $(abspath $(lastword $(MAKEFILE_LIST)))
>  GENERIC_VDSO_DIR :=3D $(dir $(GENERIC_VDSO_MK_PATH))

[Severity: Low]
Does stripping $(LLVM_PLUGINS_CFLAGS) from the directory-wide KBUILD_CFLAGS
here also drop LLVM plugins from standard in-kernel objects built in those
directories?

Makefiles that include lib/vdso/Makefile.include also build obj-y kernel
objects linked into vmlinux, such as arch/sparc/vdso/vma.o and the
vdso*-image.o targets in arch/x86/entry/vdso/common/Makefile.include,
arch/sparc/vdso/Makefile, and arch/mips/vdso/Makefile.  Those Makefiles
scope $(GCC_PLUGINS_CFLAGS) removal to $(vobjs) (as this patch does for
arch/x86/um/vdso/Makefile), whereas modifying KBUILD_CFLAGS unconditionally
in lib/vdso/Makefile.include prevents enabled LLVM plugins from running on
the in-kernel objects and drops their <generated/llvm-plugins.h> rebuild
dependency.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261109170550.1414=
43-1-a.s.protopopov@gmail.com?part=3D7
