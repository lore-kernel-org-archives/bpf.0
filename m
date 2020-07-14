Return-Path: <SRS0=I/LR=AZ=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9301EC433E3
	for <bpf@archiver.kernel.org>; Tue, 14 Jul 2020 10:25:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 62F7D22202
	for <bpf@archiver.kernel.org>; Tue, 14 Jul 2020 10:25:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594722346;
	bh=llJ9r1tWKBqzqDph+eWqVw0w/a3UCaURzLkpZ4XmDd4=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=pnCMs/bkP7TJdCbbn21WIiOrPT7ewtFMdubC5vjKx8Pdm+H879R+TDeuJFmDtSLSS
	 0Wlby6MYuE6lQGwdoOUvksnPW5pzFtgABOqVBIhvLu/hUNI9BOWq5U9eJcwU4d8tC0
	 1LmXmLvsryIxZr2gfXpKDGRr3enwqzhFYibjpe/k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726398AbgGNKZq convert rfc822-to-8bit (ORCPT
        <rfc822;bpf@archiver.kernel.org>); Tue, 14 Jul 2020 06:25:46 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:46303 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725884AbgGNKZp (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 14 Jul 2020 06:25:45 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-397-OOUqcfWgNmmolp5dXM_Dkg-1; Tue, 14 Jul 2020 06:25:41 -0400
X-MC-Unique: OOUqcfWgNmmolp5dXM_Dkg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B2F0E1800D42;
        Tue, 14 Jul 2020 10:25:39 +0000 (UTC)
Received: from krava.redhat.com (unknown [10.40.193.14])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1EC9872AD2;
        Tue, 14 Jul 2020 10:25:35 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andriin@fb.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        netdev@vger.kernel.org, bpf@vger.kernel.org
Subject: [PATCH 1/2] bpf: Fix build for disabled CONFIG_DEBUG_INFO_BTF option
Date:   Tue, 14 Jul 2020 12:25:33 +0200
Message-Id: <20200714102534.299280-1-jolsa@kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: kernel.org
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 8BIT
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Stephen reported following linker warnings on powerpc build:

  ld: warning: orphan section `.BTF_ids' from `kernel/trace/bpf_trace.o' being placed in section `.BTF_ids'
  ld: warning: orphan section `.BTF_ids' from `kernel/bpf/btf.o' being placed in section `.BTF_ids'
  ld: warning: orphan section `.BTF_ids' from `kernel/bpf/stackmap.o' being placed in section `.BTF_ids'
  ld: warning: orphan section `.BTF_ids' from `net/core/filter.o' being placed in section `.BTF_ids'
  ld: warning: orphan section `.BTF_ids' from `kernel/trace/bpf_trace.o' being placed in section `.BTF_ids'

It's because we generated .BTF_ids section even when
CONFIG_DEBUG_INFO_BTF is not enabled. Fixing this by
generating empty btf_id arrays for this case.

Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 include/linux/btf_ids.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/include/linux/btf_ids.h b/include/linux/btf_ids.h
index fe019774f8a7..b3c73db9587c 100644
--- a/include/linux/btf_ids.h
+++ b/include/linux/btf_ids.h
@@ -3,6 +3,8 @@
 #ifndef _LINUX_BTF_IDS_H
 #define _LINUX_BTF_IDS_H
 
+#ifdef CONFIG_DEBUG_INFO_BTF
+
 #include <linux/compiler.h> /* for __PASTE */
 
 /*
@@ -83,5 +85,12 @@ asm(							\
 ".zero 4                                       \n"	\
 ".popsection;                                  \n");
 
+#else
+
+#define BTF_ID_LIST(name) static u32 name[5];
+#define BTF_ID(prefix, name)
+#define BTF_ID_UNUSED
+
+#endif /* CONFIG_DEBUG_INFO_BTF */
 
 #endif
-- 
2.25.4

