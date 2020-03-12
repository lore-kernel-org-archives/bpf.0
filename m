Return-Path: <SRS0=5rgj=45=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C565AC1975A
	for <bpf@archiver.kernel.org>; Thu, 12 Mar 2020 19:56:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98E732071B
	for <bpf@archiver.kernel.org>; Thu, 12 Mar 2020 19:56:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584042988;
	bh=f3upIBDrcFdH0Fn2UOtEScqad9sjVdOnHVf7pqd3c+Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=CSbRuRH3ujhn/TwzmD5hLFPh4sMPqcRB7PyBG7UWrdYcPepRccb871lcRQZOEkg0A
	 bFLVtuGI1p3nPKI8w65AkckJpQMZtf4utZbnJ8onPJTZAp1AmM2BoT/iXqWaa+qIsg
	 QLiCOwjCLsWRgUZ/WeJqCKyqUL5o7Xff0p7P1+Rs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726856AbgCLT42 convert rfc822-to-8bit (ORCPT
        <rfc822;bpf@archiver.kernel.org>); Thu, 12 Mar 2020 15:56:28 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:58348 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726558AbgCLT42 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 12 Mar 2020 15:56:28 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-299-aYOUD-UoOs6cskvHX4Rsyg-1; Thu, 12 Mar 2020 15:56:23 -0400
X-MC-Unique: aYOUD-UoOs6cskvHX4Rsyg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2000219251A3;
        Thu, 12 Mar 2020 19:56:21 +0000 (UTC)
Received: from krava.redhat.com (ovpn-204-40.brq.redhat.com [10.40.204.40])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A51105D9C5;
        Thu, 12 Mar 2020 19:56:15 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     Song Liu <songliubraving@fb.com>,
        kbuild test robot <lkp@intel.com>, netdev@vger.kernel.org,
        bpf@vger.kernel.org, Andrii Nakryiko <andriin@fb.com>,
        Yonghong Song <yhs@fb.com>, Martin KaFai Lau <kafai@fb.com>,
        Jakub Kicinski <kuba@kernel.org>,
        David Miller <davem@redhat.com>,
        =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn.topel@intel.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Song Liu <song@kernel.org>
Subject: [PATCH 01/15] x86/mm: Rename is_kernel_text to __is_kernel_text
Date:   Thu, 12 Mar 2020 20:55:56 +0100
Message-Id: <20200312195610.346362-2-jolsa@kernel.org>
In-Reply-To: <20200312195610.346362-1-jolsa@kernel.org>
References: <20200312195610.346362-1-jolsa@kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: kernel.org
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 8BIT
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The kbuild test robot reported compile issue on x86 in one of
the following patches that adds <linux/kallsyms.h> include into
<linux/bpf.h>, which is picked up by init_32.c object.

The problem is that <linux/kallsyms.h> defines global function
is_kernel_text which colides with the static function of the
same name defined in init_32.c:

  $ make ARCH=i386
  ...
  >> arch/x86/mm/init_32.c:241:19: error: redefinition of 'is_kernel_text'
    static inline int is_kernel_text(unsigned long addr)
                      ^~~~~~~~~~~~~~
   In file included from include/linux/bpf.h:21:0,
                    from include/linux/bpf-cgroup.h:5,
                    from include/linux/cgroup-defs.h:22,
                    from include/linux/cgroup.h:28,
                    from include/linux/hugetlb.h:9,
                    from arch/x86/mm/init_32.c:18:
   include/linux/kallsyms.h:31:19: note: previous definition of 'is_kernel_text' was here
    static inline int is_kernel_text(unsigned long addr)

Renaming the init_32.c is_kernel_text function to __is_kernel_text.

Acked-by: Song Liu <songliubraving@fb.com>
Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 arch/x86/mm/init_32.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/arch/x86/mm/init_32.c b/arch/x86/mm/init_32.c
index 23df4885bbed..eb6ede2c3d43 100644
--- a/arch/x86/mm/init_32.c
+++ b/arch/x86/mm/init_32.c
@@ -238,7 +238,11 @@ page_table_range_init(unsigned long start, unsigned long end, pgd_t *pgd_base)
 	}
 }
 
-static inline int is_kernel_text(unsigned long addr)
+/*
+ * The <linux/kallsyms.h> already defines is_kernel_text,
+ * using '__' prefix not to get in conflict.
+ */
+static inline int __is_kernel_text(unsigned long addr)
 {
 	if (addr >= (unsigned long)_text && addr <= (unsigned long)__init_end)
 		return 1;
@@ -328,8 +332,8 @@ kernel_physical_mapping_init(unsigned long start,
 				addr2 = (pfn + PTRS_PER_PTE-1) * PAGE_SIZE +
 					PAGE_OFFSET + PAGE_SIZE-1;
 
-				if (is_kernel_text(addr) ||
-				    is_kernel_text(addr2))
+				if (__is_kernel_text(addr) ||
+				    __is_kernel_text(addr2))
 					prot = PAGE_KERNEL_LARGE_EXEC;
 
 				pages_2m++;
@@ -354,7 +358,7 @@ kernel_physical_mapping_init(unsigned long start,
 				 */
 				pgprot_t init_prot = __pgprot(PTE_IDENT_ATTR);
 
-				if (is_kernel_text(addr))
+				if (__is_kernel_text(addr))
 					prot = PAGE_KERNEL_EXEC;
 
 				pages_4k++;
@@ -881,7 +885,7 @@ static void mark_nxdata_nx(void)
 	 */
 	unsigned long start = PFN_ALIGN(_etext);
 	/*
-	 * This comes from is_kernel_text upper limit. Also HPAGE where used:
+	 * This comes from __is_kernel_text upper limit. Also HPAGE where used:
 	 */
 	unsigned long size = (((unsigned long)__init_end + HPAGE_SIZE) & HPAGE_MASK) - start;
 
-- 
2.24.1

