Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD545C433DB
	for <bpf@archiver.kernel.org>; Fri,  5 Feb 2021 12:43:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A79E64FD0
	for <bpf@archiver.kernel.org>; Fri,  5 Feb 2021 12:43:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231423AbhBEMnq convert rfc822-to-8bit (ORCPT
        <rfc822;bpf@archiver.kernel.org>); Fri, 5 Feb 2021 07:43:46 -0500
Received: from us-smtp-delivery-44.mimecast.com ([205.139.111.44]:22234 "EHLO
        us-smtp-delivery-44.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232159AbhBEMlg (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 5 Feb 2021 07:41:36 -0500
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-508-xlXrX5MiMzCrA_GoPnE9BQ-1; Fri, 05 Feb 2021 07:40:39 -0500
X-MC-Unique: xlXrX5MiMzCrA_GoPnE9BQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C39BC100CCC3;
        Fri,  5 Feb 2021 12:40:36 +0000 (UTC)
Received: from krava.cust.in.nbox.cz (unknown [10.40.195.59])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E87E660936;
        Fri,  5 Feb 2021 12:40:33 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andriin@fb.com>
Cc:     Song Liu <songliubraving@fb.com>, netdev@vger.kernel.org,
        bpf@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>,
        Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kbuild@vger.kernel.org
Subject: [PATCH bpf-next 4/4] kbuild: Add resolve_btfids clean to root clean target
Date:   Fri,  5 Feb 2021 13:40:20 +0100
Message-Id: <20210205124020.683286-5-jolsa@kernel.org>
In-Reply-To: <20210205124020.683286-1-jolsa@kernel.org>
References: <20210205124020.683286-1-jolsa@kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jolsa@kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: kernel.org
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=WINDOWS-1252
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The resolve_btfids tool is used during the kernel build,
so we should clean it on kernel's make clean.

Invoking the the resolve_btfids clean as part of root
'make clean'.

Acked-by: Song Liu <songliubraving@fb.com>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 Makefile | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index b0e4767735dc..159d9592b587 100644
--- a/Makefile
+++ b/Makefile
@@ -1086,6 +1086,11 @@ ifdef CONFIG_STACK_VALIDATION
   endif
 endif
 
+PHONY += resolve_btfids_clean
+
+resolve_btfids_clean:
+	$(Q)$(MAKE) -sC $(srctree)/tools/bpf/resolve_btfids O=$(abspath $(objtree))/tools/bpf/resolve_btfids clean
+
 ifdef CONFIG_BPF
 ifdef CONFIG_DEBUG_INFO_BTF
   ifeq ($(has_libelf),1)
@@ -1495,7 +1500,7 @@ vmlinuxclean:
 	$(Q)$(CONFIG_SHELL) $(srctree)/scripts/link-vmlinux.sh clean
 	$(Q)$(if $(ARCH_POSTLINK), $(MAKE) -f $(ARCH_POSTLINK) clean)
 
-clean: archclean vmlinuxclean
+clean: archclean vmlinuxclean resolve_btfids_clean
 
 # mrproper - Delete all generated files, including .config
 #
-- 
2.26.2

