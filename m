Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E36303783C1
	for <bpf@vger.kernel.org>; Wed,  3 Jun 2026 17:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780508999; cv=none; b=iILXnp/NLCytF7EmfmumANePFGcnjlSQT7PSPmvPsohS146+TDn4kSev1mKAQWpuSpEah971EKEt/N33PVwN8QYEiFXkWLSKq4J/0ldZJm3QZMgprorXam2dXoUCg2i3ccpUgG1zqIw7Wwf9PnBuVOPWbnv5XHKTcXmnf9PoWa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780508999; c=relaxed/simple;
	bh=5zOwfEwDnaM4EL13r+AKL25SZeUeJKZeqkq/Qwtt8ho=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=WQfRcjRVw+mGMaHkTkkvzdfjpf0ErOCGNGP4lBf1z3Ujk6hhKHcakmejpiariaP+4YpA3QLhGz5aeXzQSqsW7KFEP195wZWP7d5PtVpMXAiybxvl1KpgBWNBHFaGgOAnV2XJ5eWESqTkyTzl74C6YDKZCnwzKzoymimrLe31+Y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AkleZfjp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AkleZfjp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 729DC1F00893;
	Wed,  3 Jun 2026 17:49:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780508997;
	bh=tWM3p+05VYUNPuWnHQY7V2Rg+lehOcL6Lpn/w2yeug8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=AkleZfjpOHEsCO4AqFYx4Mw+v9irQQPwepZ8tB9hnDlLGDDta85VGc9xreVQd5jnV
	 eNTur9mgoD7aN5iRHyC0Jsoj/Yw8GWZZcbLt3gdQBfWr+CByKfw5s+y2Fwi5Kltgdd
	 KK8Gxcmb2dm73a/VJVTq11LFsHbX+0m2f6v1UQqIskPYmULT+6Qg/9tFFCBcrTSn3I
	 WNo57F5u8PzV6HD1/TOcPs1fMkJbXEJHKy4+T2ec5gKp5D/jjVmyAtMpXZNPavI1XN
	 HBRPbCMkNuVytR295QcNCZ3x6c0k/zdelYSSz2w/nI7YrTP6qd4xw7AK1yM23s3S70
	 EXxy7fMzWJYCw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] bpftool: Make the LLVM disassembler an optional runtime
 dependency
Reply-To: sashiko-reviews@lists.linux.dev
To: "Korenberg Mark via B4 Relay" <devnull+socketpair.gmail.com@kernel.org>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260603-bpftool-plugin-v1-1-68c0ac91f5a3@gmail.com>
References: <20260603-bpftool-plugin-v1-1-68c0ac91f5a3@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 03 Jun 2026 17:49:57 +0000
Message-Id: <20260603174957.729DC1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] The 'dump jited' functionality is completely broken for statically=
 linked builds of bpftool.
- [High] Linking static LLVM archives into a shared object plugin will caus=
e relocation errors and build failures on many distributions.
- [Medium] Hardcoding the absolute installation path for the LLVM plugin pr=
events running bpftool locally from the build tree.
- [Low] Multi-line comment does not follow the required BPF subsystem style.
--

commit c9ad3aff3b32fd9fdba7deb04f2d26819aac8786
Author: Korenberg Mark <socketpair@gmail.com>

bpftool: Make the LLVM disassembler an optional runtime dependency

This commit splits the libLLVM JIT disassembler into a separate shared
plugin. It dynamically loads the plugin via dlopen() to remove the hard
runtime dependency on the large libLLVM library from the main bpftool binar=
y.

> diff --git a/tools/bpf/bpftool/Makefile b/tools/bpf/bpftool/Makefile
> index 0febf60e1b646..9887ac6fbae3e 100644
> --- a/tools/bpf/bpftool/Makefile
> +++ b/tools/bpf/bpftool/Makefile
[ ... ]
> @@ -165,19 +168,36 @@ endif
>  endif
> =20
>  ifeq ($(HAS_LLVM),1)
> +  # The libLLVM-based JIT disassembler is built as a separate plugin,
> +  # bpftool-llvm.so, which is the only object that links against libLLVM.
> +  # bpftool loads it lazily with dlopen() (see jit_disasm.c), so the bpf=
tool
> +  # binary itself keeps no dependency on the large libLLVM shared object.
>    CFLAGS  +=3D -DHAVE_LLVM_SUPPORT
> +  CFLAGS  +=3D -DLLVM_PLUGIN_DIR=3D'"$(libdir)/bpftool"'

[Severity: Medium]
By unconditionally baking the absolute installation path into the binary, d=
oes
this break running bpftool locally from the build tree?

Standard developer workflows or selftests that execute a locally built bpft=
ool
from a scratch directory won't have the plugin installed in the system libr=
ary
directory. Since dlopen() is called with this absolute path exclusively, it
will fail to load the plugin locally.

[ ... ]
> +  ifeq ($(shell $(LLVM_CONFIG) --shared-mode),static)
> -    LIBS +=3D $(shell $(LLVM_CONFIG) --system-libs $(LLVM_CONFIG_LIB_COM=
PONENTS))
> -    LIBS +=3D -lstdc++
> +    LLVM_LINK_STATIC :=3D 1
> +  endif
> +  ifeq ($(LLVM_LINK_STATIC),1)
> +    LLVM_PLUGIN_LIBS :=3D $(shell $(LLVM_CONFIG) --link-static --libs $(=
LLVM_CONFIG_LIB_COMPONENTS))
> +    LLVM_PLUGIN_LIBS +=3D $(shell $(LLVM_CONFIG) --link-static --system-=
libs $(LLVM_CONFIG_LIB_COMPONENTS))
> +    LLVM_PLUGIN_LIBS +=3D -lstdc++
> +  else
> +    LLVM_PLUGIN_LIBS :=3D $(shell $(LLVM_CONFIG) --libs $(LLVM_CONFIG_LI=
B_COMPONENTS))
>    endif
[ ... ]
> @@ -276,6 +296,20 @@ $(BPFTOOL_BOOTSTRAP): $(BOOTSTRAP_OBJS) $(LIBBPF_BOO=
TSTRAP)
>  $(OUTPUT)bpftool: $(OBJS) $(LIBBPF)
>  	$(QUIET_LINK)$(CC) $(CFLAGS) $(LDFLAGS) $(OBJS) $(LIBS) -o $@
> =20
> +ifeq ($(HAS_LLVM),1)
> +all: $(OUTPUT)bpftool-llvm.so
> +
> +$(OUTPUT)llvm_disasm.o: llvm_disasm.c
> +	$(QUIET_CC)$(CC) $(CFLAGS) $(LLVM_PLUGIN_CFLAGS) -fPIC -c -MMD $< -o $@
> +
> +# The plugin is a shared object by definition, so drop a global -static =
(e.g.
> +# from EXTRA_LDFLAGS for a static bpftool) which would conflict with -sh=
ared.
> +# Embedding libLLVM statically is controlled separately (see LLVM_LINK_S=
TATIC).
> +$(OUTPUT)bpftool-llvm.so: $(OUTPUT)llvm_disasm.o
> +	$(QUIET_LINK)$(CC) $(CFLAGS) $(filter-out -static,$(LDFLAGS)) \
> +		$(LLVM_PLUGIN_LDFLAGS) -shared -o $@ $< $(LLVM_PLUGIN_LIBS)

[Severity: High]
Will linking static LLVM archives into a shared object plugin cause relocat=
ion
errors and build failures on distributions like Debian and Ubuntu?

Since static libraries are typically not compiled with position independent
code, attempting to link them with the shared flag here often produces link=
er
relocation errors.

[Severity: High]
Does this completely break the disassemble functionality for statically lin=
ked
builds of bpftool?

Statically linking bpftool produces a static binary, but this rule forces t=
he
LLVM disassembler to be built exclusively as a shared object. Since static
binaries generally lack full dynamic loader capabilities for loading shared
objects via dlopen(), standalone static builds of bpftool will no longer be
able to disassemble JITed code.

> diff --git a/tools/bpf/bpftool/llvm_disasm.c b/tools/bpf/bpftool/llvm_dis=
asm.c
> new file mode 100644
> index 0000000000000..b832161911ebb
> --- /dev/null
> +++ b/tools/bpf/bpftool/llvm_disasm.c
[ ... ]
> +#include <llvm-c/TargetMachine.h>
> +
> +#include "llvm_disasm.h"
> +
> +/* This callback to set the ref_type is necessary to have the LLVM disas=
sembler
> + * print PC-relative addresses instead of byte offsets for branch instru=
ction
> + * targets.
> + */
> +static const char *
> +symbol_lookup_callback(void *disasm_info, uint64_t ref_value,

[Severity: Low]
This isn't a bug, but the multi-line comment does not follow the required B=
PF
subsystem style. The opening block comment indicator should be on its own
line.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260603-bpftool-pl=
ugin-v1-1-68c0ac91f5a3@gmail.com?part=3D1
