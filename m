Return-Path: <SRS0=+eov=SG=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32B5CC4360F
	for <bpf@archiver.kernel.org>; Thu,  4 Apr 2019 21:37:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED3FE21738
	for <bpf@archiver.kernel.org>; Thu,  4 Apr 2019 21:37:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554413838;
	bh=9bctyeXbJP2/lYe3JcODjTC9KkNjOW++RD11UjU/0C0=;
	h=From:To:CC:Subject:Date:List-ID:From;
	b=Z/PttLzbCB1/Sf4qaXWZhKqEJ5DaV2NCLRxyDVc6QGFbGK7/Fn2zxiAYGDFHxMv3o
	 ZC8YSuA1nau0TLvkAtkKVIijzMwNe3tucb7JTbSTPRNLbXuXQ2NKlu90Ur+M6uy4j+
	 AV8HOYSh5hW9jNrnCu1WVJFGDv7P75GF6qzTej+0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729428AbfDDVhR convert rfc822-to-8bit (ORCPT
        <rfc822;bpf@archiver.kernel.org>); Thu, 4 Apr 2019 17:37:17 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:42644 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727398AbfDDVhR (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 4 Apr 2019 17:37:17 -0400
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x34LZ2TX009713
        for <bpf@vger.kernel.org>; Thu, 4 Apr 2019 14:37:16 -0700
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2rnpmpgsqf-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 04 Apr 2019 14:37:16 -0700
Received: from mx-out.facebook.com (2620:10d:c081:10::13) by
 mail.thefacebook.com (2620:10d:c081:35::130) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1713.5;
 Thu, 4 Apr 2019 14:37:14 -0700
Received: by devbig007.ftw2.facebook.com (Postfix, from userid 572438)
        id 745DF760872; Thu,  4 Apr 2019 14:37:14 -0700 (PDT)
Smtp-Origin-Hostprefix: devbig
From:   Alexei Starovoitov <ast@kernel.org>
Smtp-Origin-Hostname: devbig007.ftw2.facebook.com
To:     <davem@davemloft.net>
CC:     <daniel@iogearbox.net>, <netdev@vger.kernel.org>,
        <bpf@vger.kernel.org>, <kernel-team@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH bpf-next] samples/bpf: fix build with new clang
Date:   Thu, 4 Apr 2019 14:37:14 -0700
Message-ID: <20190404213714.2800997-1-ast@kernel.org>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-04_12:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

clang started to error on invalid asm clobber usage in x86 headers
and many bpf program samples failed to build with the message:

  CLANG-bpf  /data/users/ast/bpf-next/samples/bpf/xdp_redirect_kern.o
In file included from /data/users/ast/bpf-next/samples/bpf/xdp_redirect_kern.c:14:
In file included from ../include/linux/in.h:23:
In file included from ../include/uapi/linux/in.h:24:
In file included from ../include/linux/socket.h:8:
In file included from ../include/linux/uio.h:14:
In file included from ../include/crypto/hash.h:16:
In file included from ../include/linux/crypto.h:26:
In file included from ../include/linux/uaccess.h:5:
In file included from ../include/linux/sched.h:15:
In file included from ../include/linux/sem.h:5:
In file included from ../include/uapi/linux/sem.h:5:
In file included from ../include/linux/ipc.h:9:
In file included from ../include/linux/refcount.h:72:
../arch/x86/include/asm/refcount.h:72:36: error: asm-specifier for input or output variable conflicts with asm clobber list
                                         r->refs.counter, e, "er", i, "cx");
                                                                      ^
../arch/x86/include/asm/refcount.h:86:27: error: asm-specifier for input or output variable conflicts with asm clobber list
                                         r->refs.counter, e, "cx");
                                                             ^
2 errors generated.

Override volatile() to workaround the problem.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 samples/bpf/asm_goto_workaround.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/samples/bpf/asm_goto_workaround.h b/samples/bpf/asm_goto_workaround.h
index 5cd7c1d1a5d5..7409722727ca 100644
--- a/samples/bpf/asm_goto_workaround.h
+++ b/samples/bpf/asm_goto_workaround.h
@@ -13,4 +13,5 @@
 #define asm_volatile_goto(x...) asm volatile("invalid use of asm_volatile_goto")
 #endif
 
+#define volatile(x...) volatile("")
 #endif
-- 
2.20.0

