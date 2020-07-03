Return-Path: <SRS0=a4pm=AO=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB049C433E1
	for <bpf@archiver.kernel.org>; Fri,  3 Jul 2020 09:51:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 85A2F20723
	for <bpf@archiver.kernel.org>; Fri,  3 Jul 2020 09:51:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593769906;
	bh=BNG7VRTafDLocUa2dOMXP+8My4ynT8Oespl7Cmq/gqU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=c2eJScYb9/FpjHEYZRoswKO+WTy9xTBBx9Hk80cnlQ3yRpC/jMWgy+nF1BZdX9/AN
	 51xTtDNvlZdDNj9qJmA7ODYfL5QWGqfgcILv7Vp1HlXrev34GfU7kQHYyvt5Z4x5YZ
	 AT+4zLtN22XAkN6SUexVO5D6NN0zD1ZYjbbZGF04=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726082AbgGCJvq convert rfc822-to-8bit (ORCPT
        <rfc822;bpf@archiver.kernel.org>); Fri, 3 Jul 2020 05:51:46 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:46508 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726272AbgGCJvp (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 3 Jul 2020 05:51:45 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-503-uGhh_xc2PSqrPM7vEwUjDQ-1; Fri, 03 Jul 2020 05:51:40 -0400
X-MC-Unique: uGhh_xc2PSqrPM7vEwUjDQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6DDCD107ACCA;
        Fri,  3 Jul 2020 09:51:38 +0000 (UTC)
Received: from krava.redhat.com (unknown [10.40.194.24])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D01A59CA0;
        Fri,  3 Jul 2020 09:51:30 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     Andrii Nakryiko <andriin@fb.com>, netdev@vger.kernel.org,
        bpf@vger.kernel.org, Song Liu <songliubraving@fb.com>,
        Yonghong Song <yhs@fb.com>, Martin KaFai Lau <kafai@fb.com>,
        David Miller <davem@redhat.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Wenbo Zhang <ethercflow@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Brendan Gregg <bgregg@netflix.com>,
        Florent Revest <revest@chromium.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH v5 bpf-next 4/9] bpf: Resolve BTF IDs in vmlinux image
Date:   Fri,  3 Jul 2020 11:51:06 +0200
Message-Id: <20200703095111.3268961-5-jolsa@kernel.org>
In-Reply-To: <20200703095111.3268961-1-jolsa@kernel.org>
References: <20200703095111.3268961-1-jolsa@kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jolsa@kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: kernel.org
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 8BIT
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Using BTF_ID_LIST macro to define lists for several helpers
using BTF arguments.

And running resolve_btfids on vmlinux elf object during linking,
so the .BTF_ids section gets the IDs resolved.

Acked-by: Andrii Nakryiko <andriin@fb.com>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 Makefile                 | 3 ++-
 kernel/trace/bpf_trace.c | 9 +++++++--
 net/core/filter.c        | 9 +++++++--
 scripts/link-vmlinux.sh  | 6 ++++++
 4 files changed, 22 insertions(+), 5 deletions(-)

diff --git a/Makefile b/Makefile
index 8db4fd8097e0..def58d4f9ed7 100644
--- a/Makefile
+++ b/Makefile
@@ -448,6 +448,7 @@ OBJSIZE		= $(CROSS_COMPILE)size
 STRIP		= $(CROSS_COMPILE)strip
 endif
 PAHOLE		= pahole
+RESOLVE_BTFIDS	= $(srctree)/tools/bpf/resolve_btfids/resolve_btfids
 LEX		= flex
 YACC		= bison
 AWK		= awk
@@ -510,7 +511,7 @@ GCC_PLUGINS_CFLAGS :=
 CLANG_FLAGS :=
 
 export ARCH SRCARCH CONFIG_SHELL BASH HOSTCC KBUILD_HOSTCFLAGS CROSS_COMPILE LD CC
-export CPP AR NM STRIP OBJCOPY OBJDUMP OBJSIZE READELF PAHOLE LEX YACC AWK INSTALLKERNEL
+export CPP AR NM STRIP OBJCOPY OBJDUMP OBJSIZE READELF PAHOLE RESOLVE_BTFIDS LEX YACC AWK INSTALLKERNEL
 export PERL PYTHON PYTHON3 CHECK CHECKFLAGS MAKE UTS_MACHINE HOSTCXX
 export KGZIP KBZIP2 KLZOP LZMA LZ4 XZ
 export KBUILD_HOSTCXXFLAGS KBUILD_HOSTLDFLAGS KBUILD_HOSTLDLIBS LDFLAGS_MODULE
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 1d874d8e4384..e26fbb1dad9c 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -13,6 +13,7 @@
 #include <linux/kprobes.h>
 #include <linux/syscalls.h>
 #include <linux/error-injection.h>
+#include <linux/btf_ids.h>
 
 #include <asm/tlb.h>
 
@@ -710,7 +711,9 @@ BPF_CALL_5(bpf_seq_printf, struct seq_file *, m, char *, fmt, u32, fmt_size,
 	return err;
 }
 
-static int bpf_seq_printf_btf_ids[5];
+BTF_ID_LIST(bpf_seq_printf_btf_ids)
+BTF_ID(struct, seq_file)
+
 static const struct bpf_func_proto bpf_seq_printf_proto = {
 	.func		= bpf_seq_printf,
 	.gpl_only	= true,
@@ -728,7 +731,9 @@ BPF_CALL_3(bpf_seq_write, struct seq_file *, m, const void *, data, u32, len)
 	return seq_write(m, data, len) ? -EOVERFLOW : 0;
 }
 
-static int bpf_seq_write_btf_ids[5];
+BTF_ID_LIST(bpf_seq_write_btf_ids)
+BTF_ID(struct, seq_file)
+
 static const struct bpf_func_proto bpf_seq_write_proto = {
 	.func		= bpf_seq_write,
 	.gpl_only	= true,
diff --git a/net/core/filter.c b/net/core/filter.c
index c5e696e6c315..a859ad681988 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -75,6 +75,7 @@
 #include <net/ipv6_stubs.h>
 #include <net/bpf_sk_storage.h>
 #include <net/transp_v6.h>
+#include <linux/btf_ids.h>
 
 /**
  *	sk_filter_trim_cap - run a packet through a socket filter
@@ -3779,7 +3780,9 @@ static const struct bpf_func_proto bpf_skb_event_output_proto = {
 	.arg5_type	= ARG_CONST_SIZE_OR_ZERO,
 };
 
-static int bpf_skb_output_btf_ids[5];
+BTF_ID_LIST(bpf_skb_output_btf_ids)
+BTF_ID(struct, sk_buff)
+
 const struct bpf_func_proto bpf_skb_output_proto = {
 	.func		= bpf_skb_event_output,
 	.gpl_only	= true,
@@ -4173,7 +4176,9 @@ static const struct bpf_func_proto bpf_xdp_event_output_proto = {
 	.arg5_type	= ARG_CONST_SIZE_OR_ZERO,
 };
 
-static int bpf_xdp_output_btf_ids[5];
+BTF_ID_LIST(bpf_xdp_output_btf_ids)
+BTF_ID(struct, xdp_buff)
+
 const struct bpf_func_proto bpf_xdp_output_proto = {
 	.func		= bpf_xdp_event_output,
 	.gpl_only	= true,
diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
index 92dd745906f4..e26f02dbedee 100755
--- a/scripts/link-vmlinux.sh
+++ b/scripts/link-vmlinux.sh
@@ -336,6 +336,12 @@ fi
 
 vmlinux_link vmlinux "${kallsymso}" ${btf_vmlinux_bin_o}
 
+# fill in BTF IDs
+if [ -n "${CONFIG_DEBUG_INFO_BTF}" ]; then
+info BTFIDS vmlinux
+${RESOLVE_BTFIDS} vmlinux
+fi
+
 if [ -n "${CONFIG_BUILDTIME_TABLE_SORT}" ]; then
 	info SORTTAB vmlinux
 	if ! sorttable vmlinux; then
-- 
2.25.4

