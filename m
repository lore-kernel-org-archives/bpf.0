Return-Path: <SRS0=5VBK=SF=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 991BDC10F06
	for <bpf@archiver.kernel.org>; Wed,  3 Apr 2019 08:46:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74DC2206B7
	for <bpf@archiver.kernel.org>; Wed,  3 Apr 2019 08:46:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725990AbfDCIqZ (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 3 Apr 2019 04:46:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:31896 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725857AbfDCIqZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 3 Apr 2019 04:46:25 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id AD941308213C;
        Wed,  3 Apr 2019 08:46:24 +0000 (UTC)
Received: from krava (ovpn-204-108.brq.redhat.com [10.40.204.108])
        by smtp.corp.redhat.com (Postfix) with SMTP id 95BAB5D9C4;
        Wed,  3 Apr 2019 08:46:20 +0000 (UTC)
Date:   Wed, 3 Apr 2019 10:46:19 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     andrii.nakryiko@gmail.com
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org, kernel-team@fb.com,
        Andrii Nakryiko <andriin@fb.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@fb.com>, Yonghong Song <yhs@fb.com>,
        Martin KaFai Lau <kafai@fb.com>
Subject: Re: [PATCH bpf-next] kbuild: add ability to generate BTF type info
 for vmlinux
Message-ID: <20190403084619.GA23855@krava>
References: <20190402164950.429597-1-andrii.nakryiko@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190402164950.429597-1-andrii.nakryiko@gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Wed, 03 Apr 2019 08:46:24 +0000 (UTC)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Apr 02, 2019 at 09:49:50AM -0700, andrii.nakryiko@gmail.com wrote:
> From: Andrii Nakryiko <andriin@fb.com>
> 
> This patch adds new config option to trigger generation of BTF type
> information from DWARF debuginfo for vmlinux and kernel modules through
> pahole, which in turn relies on libbpf for btf_dedup() algorithm.
> 
> The intent is to record compact type information of all types used
> inside kernel, including all the structs/unions/typedefs/etc. This
> enables BPF's compile-once-run-everywhere ([0]) approach, in which
> tracing programs that are inspecting kernel's internal data (e.g.,
> struct task_struct) can be compiled on a system running some kernel
> version, but would be possible to run on other kernel versions (and
> configurations) without recompilation, even if the layout of structs
> changed and/or some of the fields were added, removed, or renamed.
> 
> This is only possible if BPF loader can get kernel type info to adjust
> all the offsets correctly. This patch is a first time in this direction,
> making sure that BTF type info is part of Linux kernel image in
> non-loadable ELF section.
> 
> BTF deduplication ([1]) algorithm typically provides 100x savings
> compared to DWARF data, so resulting .BTF section is not big as is
> typically about 2MB in size.

hi,
I'm using the latest pahole from git tree:
  https://github.com/acmel/dwarves.git

and getting pahole crash:

  LD      vmlinux
  BTF     vmlinux
die__process_inline_expansion: DW_TAG_label (0xa) @ <0x3eef8> not handled!
scripts/link-vmlinux.sh: line 96: 31222 Segmentation fault      (core dumped) LLVM_OBJCOPY=${OBJCOPY} ${PAHOLE} -J ${1}
make[1]: *** [/home/jolsa/linux/Makefile:1025: vmlinux] Error 139
make: *** [Makefile:170: sub-make] Error 2

is there some other source/dependency I'm missing?

thanks,
jirka


> 
> [0] http://vger.kernel.org/lpc-bpf2018.html#session-2
> [1] https://facebookmicrosites.github.io/bpf/blog/2018/11/14/btf-enhancement.html
> 
> Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
> Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
> Cc: Daniel Borkmann <daniel@iogearbox.net>
> Cc: Alexei Starovoitov <ast@fb.com>
> Cc: Yonghong Song <yhs@fb.com>
> Cc: Martin KaFai Lau <kafai@fb.com>
> Signed-off-by: Andrii Nakryiko <andriin@fb.com>
> ---
>  Makefile                |  3 ++-
>  lib/Kconfig.debug       |  8 ++++++++
>  scripts/link-vmlinux.sh | 20 +++++++++++++++++++-
>  3 files changed, 29 insertions(+), 2 deletions(-)
> 
> diff --git a/Makefile b/Makefile
> index d5713e7b1e50..a55308147a09 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -387,6 +387,7 @@ NM		= $(CROSS_COMPILE)nm
>  STRIP		= $(CROSS_COMPILE)strip
>  OBJCOPY		= $(CROSS_COMPILE)objcopy
>  OBJDUMP		= $(CROSS_COMPILE)objdump
> +PAHOLE		= pahole
>  LEX		= flex
>  YACC		= bison
>  AWK		= awk
> @@ -442,7 +443,7 @@ KBUILD_LDFLAGS :=
>  GCC_PLUGINS_CFLAGS :=
>  
>  export ARCH SRCARCH CONFIG_SHELL HOSTCC KBUILD_HOSTCFLAGS CROSS_COMPILE AS LD CC
> -export CPP AR NM STRIP OBJCOPY OBJDUMP KBUILD_HOSTLDFLAGS KBUILD_HOSTLDLIBS
> +export CPP AR NM STRIP OBJCOPY OBJDUMP PAHOLE KBUILD_HOSTLDFLAGS KBUILD_HOSTLDLIBS
>  export MAKE LEX YACC AWK GENKSYMS INSTALLKERNEL PERL PYTHON PYTHON2 PYTHON3 UTS_MACHINE
>  export HOSTCXX KBUILD_HOSTCXXFLAGS LDFLAGS_MODULE CHECK CHECKFLAGS
>  
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index d4df5b24d75e..cce78dcd19a2 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -200,6 +200,14 @@ config DEBUG_INFO_DWARF4
>  	  But it significantly improves the success of resolving
>  	  variables in gdb on optimized code.
>  
> +config DEBUG_INFO_BTF
> +	bool "Generate BTF typeinfo"
> +	depends on DEBUG_INFO
> +	help
> +	  Generate deduplicated BTF type information from DWARF debug info.
> +	  Turning this on expects presence of pahole tool, which will convert
> +	  DWARF type info into equivalent deduplicated BTF type info.
> +
>  config GDB_SCRIPTS
>  	bool "Provide GDB scripts for kernel debugging"
>  	depends on DEBUG_INFO
> diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
> index c8cf45362bd6..73bb7dfdc2c9 100755
> --- a/scripts/link-vmlinux.sh
> +++ b/scripts/link-vmlinux.sh
> @@ -40,7 +40,7 @@ set -e
>  info()
>  {
>  	if [ "${quiet}" != "silent_" ]; then
> -		printf "  %-7s %s\n" ${1} ${2}
> +		printf "  %-7s %s\n" "${1}" "${2}"
>  	fi
>  }
>  
> @@ -114,6 +114,20 @@ vmlinux_link()
>  	fi
>  }
>  
> +# generate .BTF typeinfo from DWARF debuginfo
> +gen_btf()
> +{
> +	local pahole_ver;
> +
> +	pahole_ver=$(${PAHOLE} --version | sed -E 's/v([0-9]+)\.([0-9]+)/\1\2/')
> +	if [ "${pahole_ver}" -lt "113" ]; then
> +		info "BTF" "${1}: pahole version $(${PAHOLE} --version) is too old, need at least v1.13"
> +		exit 0
> +	fi
> +
> +	info "BTF" ${1}
> +	LLVM_OBJCOPY=${OBJCOPY} ${PAHOLE} -J ${1}
> +}
>  
>  # Create ${2} .o file with all symbols from the ${1} object file
>  kallsyms()
> @@ -281,6 +295,10 @@ fi
>  info LD vmlinux
>  vmlinux_link "${kallsymso}" vmlinux
>  
> +if [ -n "${CONFIG_DEBUG_INFO_BTF}" ]; then
> +	gen_btf vmlinux
> +fi
> +
>  if [ -n "${CONFIG_BUILDTIME_EXTABLE_SORT}" ]; then
>  	info SORTEX vmlinux
>  	sortextable vmlinux
> -- 
> 2.17.1
> 
