Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9867BC47088
	for <bpf@archiver.kernel.org>; Fri,  2 Dec 2022 08:19:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232889AbiLBITS (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 2 Dec 2022 03:19:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232771AbiLBISe (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 2 Dec 2022 03:18:34 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EA89FD1C;
        Fri,  2 Dec 2022 00:17:40 -0800 (PST)
Received: from dggpeml500010.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4NNm0s0MDszqSMX;
        Fri,  2 Dec 2022 16:13:33 +0800 (CST)
Received: from huawei.com (10.175.101.6) by dggpeml500010.china.huawei.com
 (7.185.36.155) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Fri, 2 Dec
 2022 16:17:37 +0800
From:   Xin Liu <liuxin350@huawei.com>
To:     <andrii@kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <martin.lau@linux.dev>, <song@kernel.org>, <yhs@fb.com>,
        <john.fastabend@gmail.com>, <kpsingh@kernel.org>, <sdf@google.com>,
        <haoluo@google.com>, <jolsa@kernel.org>
CC:     <bpf@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <yanan@huawei.com>, <wuchangye@huawei.com>,
        <xiesongyang@huawei.com>, <kongweibin2@huawei.com>,
        <liuxin350@huawei.com>, <zhangmingyi5@huawei.com>
Subject: [PATCH bpf-next v2] libbpf:Improved usability of the Makefile in libbpf
Date:   Fri, 2 Dec 2022 16:17:38 +0800
Message-ID: <20221202081738.128513-1-liuxin350@huawei.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.101.6]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml500010.china.huawei.com (7.185.36.155)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Current libbpf Makefile does not contain the help command, which
is inconvenient to use. Similar to the Makefile help command of the
perf, a help command is provided to list the commands supported by
libbpf make and the functions of the commands.

Signed-off-by: Xin Liu <liuxin350@huawei.com>
---

v2: Simplified display. Some unused commands are displayed in the help command. 

v1: https://lore.kernel.org/bpf/20221129074235.116969-1-liuxin350@huawei.com/

 tools/lib/bpf/Makefile | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/tools/lib/bpf/Makefile b/tools/lib/bpf/Makefile
index 4c904ef0b47e..ae523e4cce05 100644
--- a/tools/lib/bpf/Makefile
+++ b/tools/lib/bpf/Makefile
@@ -286,3 +286,22 @@ tags:
 
 # Delete partially updated (corrupted) files on error
 .DELETE_ON_ERROR:
+
+help:
+	@echo 'libbpf default targets:'
+	@echo '  HINT: use "V=1" to enable verbose build'
+	@echo '  all     - build librarys and pkgconfig'
+	@echo ''
+	@echo 'libbpf install targets:'
+	@echo '  HINT: use "prefix"(default "/usr/local") or "DESTDIR"(default "/")'
+	@echo '        to install to a particular path like "make prefix=/usr/local install"'
+	@echo '  install          - build and install all headers, librarys and pkgconfig'
+	@echo '  install_headers  - install only headers to include/bpf'
+	@echo ''
+	@echo 'libbpf make targets:'
+	@echo '  tags    - use ctags to make tag information for source browsing'
+	@echo '  cscope  - use cscope to make interactive browsing database'
+	@echo ''
+	@echo 'libbpf maintainer targets:'
+	@echo '  clean   - remove all generated files'
+	@echo '  check   - check abi and version info'
-- 
2.33.0

