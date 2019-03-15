Return-Path: <SRS0=GcXc=RS=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F10D7C43381
	for <bpf@archiver.kernel.org>; Fri, 15 Mar 2019 20:18:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4AC321871
	for <bpf@archiver.kernel.org>; Fri, 15 Mar 2019 20:18:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="kU+RuEuF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726418AbfCOUSU (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 15 Mar 2019 16:18:20 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:43044 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726303AbfCOUSU (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 15 Mar 2019 16:18:20 -0400
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2FKDNc3009041
        for <bpf@vger.kernel.org>; Fri, 15 Mar 2019 13:18:19 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=facebook;
 bh=21YqPYT47yexymhnU/BlqIlUHfIdJT2ZtMU/gu26HIU=;
 b=kU+RuEuFv5sOzmTSXK84++saPhu71yRPBczzBH/05jylKVHIrYSLYqJjTnO82+e2Nj7c
 vrJVmBpkpPyKlr/4eLWDI51PDVCNJdAbjGkc1tyDdDhNOyJrYhQ92nUickbqOwEB71Xi
 DIOL4Ui325X8o+UflF1N/3ujO1MOxRgsyaw= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2r8jp283vs-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 15 Mar 2019 13:18:18 -0700
Received: from mx-out.facebook.com (2620:10d:c081:10::13) by
 mail.thefacebook.com (2620:10d:c081:35::129) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1713.5;
 Fri, 15 Mar 2019 13:18:17 -0700
Received: by dev101.prn2.facebook.com (Postfix, from userid 137359)
        id 80B6B861315; Fri, 15 Mar 2019 13:18:16 -0700 (PDT)
Smtp-Origin-Hostprefix: dev
From:   Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Hostname: dev101.prn2.facebook.com
To:     <andrii.nakryiko@gmail.com>, <bpf@vger.kernel.org>
CC:     Andrii Nakryiko <andriin@fb.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@fb.com>, Yonghong Song <yhs@fb.com>,
        Martin KaFai Lau <kafai@fb.com>
Smtp-Origin-Cluster: prn2c23
Subject: [PATCH bpf-next] kbuild: add ability to generate BTF type info for vmlinux
Date:   Fri, 15 Mar 2019 13:17:49 -0700
Message-ID: <20190315201749.556085-1-andriin@fb.com>
X-Mailer: git-send-email 2.17.1
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-15_13:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This patch adds new config option to trigger generation of BTF type
information from DWARF debuginfo for vmlinux and kernel modules through
pahole, which in turn relies on libbpf for btf_dedup() algorithm.

The intent is to record compact type information of all types used
inside kernel, including all the structs/unions/typedefs/etc. This
enables BPF's compile-once-run-everywhere ([0]) approach, in which
tracing programs that are inspecting kernel's internal data (e.g.,
struct task_struct) can be compiled on a system running some kernel
version, but would be possible to run on other kernel versions (and
configurations) without recompilation, even if the layout of structs
changed and/or some of the fields were added, removed, or renamed.

This is only possible if BPF loader can get kernel type info to adjust
all the offsets correctly. This patch is a first time in this direction,
making sure that BTF type info is part of Linux kernel image in
non-loadable ELF section.

BTF deduplication ([1]) algorithm typically provides 100x savings
compared to DWARF data, so resulting .BTF section is not big as is
typically about 2MB in size.

[0] http://vger.kernel.org/lpc-bpf2018.html#session-2
[1] https://facebookmicrosites.github.io/bpf/blog/2018/11/14/btf-enhancement.html

Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Alexei Starovoitov <ast@fb.com>
Cc: Yonghong Song <yhs@fb.com>
Cc: Martin KaFai Lau <kafai@fb.com>
Signed-off-by: Andrii Nakryiko <andriin@fb.com>
---
 Makefile                |  3 ++-
 lib/Kconfig.debug       |  8 ++++++++
 scripts/link-vmlinux.sh | 20 +++++++++++++++++++-
 3 files changed, 29 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index d5713e7b1e50..a55308147a09 100644
--- a/Makefile
+++ b/Makefile
@@ -387,6 +387,7 @@ NM		= $(CROSS_COMPILE)nm
 STRIP		= $(CROSS_COMPILE)strip
 OBJCOPY		= $(CROSS_COMPILE)objcopy
 OBJDUMP		= $(CROSS_COMPILE)objdump
+PAHOLE		= pahole
 LEX		= flex
 YACC		= bison
 AWK		= awk
@@ -442,7 +443,7 @@ KBUILD_LDFLAGS :=
 GCC_PLUGINS_CFLAGS :=
 
 export ARCH SRCARCH CONFIG_SHELL HOSTCC KBUILD_HOSTCFLAGS CROSS_COMPILE AS LD CC
-export CPP AR NM STRIP OBJCOPY OBJDUMP KBUILD_HOSTLDFLAGS KBUILD_HOSTLDLIBS
+export CPP AR NM STRIP OBJCOPY OBJDUMP PAHOLE KBUILD_HOSTLDFLAGS KBUILD_HOSTLDLIBS
 export MAKE LEX YACC AWK GENKSYMS INSTALLKERNEL PERL PYTHON PYTHON2 PYTHON3 UTS_MACHINE
 export HOSTCXX KBUILD_HOSTCXXFLAGS LDFLAGS_MODULE CHECK CHECKFLAGS
 
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index d4df5b24d75e..cce78dcd19a2 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -200,6 +200,14 @@ config DEBUG_INFO_DWARF4
 	  But it significantly improves the success of resolving
 	  variables in gdb on optimized code.
 
+config DEBUG_INFO_BTF
+	bool "Generate BTF typeinfo"
+	depends on DEBUG_INFO
+	help
+	  Generate deduplicated BTF type information from DWARF debug info.
+	  Turning this on expects presence of pahole tool, which will convert
+	  DWARF type info into equivalent deduplicated BTF type info.
+
 config GDB_SCRIPTS
 	bool "Provide GDB scripts for kernel debugging"
 	depends on DEBUG_INFO
diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
index c8cf45362bd6..73bb7dfdc2c9 100755
--- a/scripts/link-vmlinux.sh
+++ b/scripts/link-vmlinux.sh
@@ -40,7 +40,7 @@ set -e
 info()
 {
 	if [ "${quiet}" != "silent_" ]; then
-		printf "  %-7s %s\n" ${1} ${2}
+		printf "  %-7s %s\n" "${1}" "${2}"
 	fi
 }
 
@@ -114,6 +114,20 @@ vmlinux_link()
 	fi
 }
 
+# generate .BTF typeinfo from DWARF debuginfo
+gen_btf()
+{
+	local pahole_ver;
+
+	pahole_ver=$(${PAHOLE} --version | sed -E 's/v([0-9]+)\.([0-9]+)/\1\2/')
+	if [ "${pahole_ver}" -lt "113" ]; then
+		info "BTF" "${1}: pahole version $(${PAHOLE} --version) is too old, need at least v1.13"
+		exit 0
+	fi
+
+	info "BTF" ${1}
+	LLVM_OBJCOPY=${OBJCOPY} ${PAHOLE} -J ${1}
+}
 
 # Create ${2} .o file with all symbols from the ${1} object file
 kallsyms()
@@ -281,6 +295,10 @@ fi
 info LD vmlinux
 vmlinux_link "${kallsymso}" vmlinux
 
+if [ -n "${CONFIG_DEBUG_INFO_BTF}" ]; then
+	gen_btf vmlinux
+fi
+
 if [ -n "${CONFIG_BUILDTIME_EXTABLE_SORT}" ]; then
 	info SORTEX vmlinux
 	sortextable vmlinux
-- 
2.17.1

