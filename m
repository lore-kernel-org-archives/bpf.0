Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DFC4ECAAD3
	for <bpf@archiver.kernel.org>; Sat, 17 Sep 2022 08:49:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229735AbiIQItZ (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Sat, 17 Sep 2022 04:49:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbiIQItX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 17 Sep 2022 04:49:23 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2605B32061;
        Sat, 17 Sep 2022 01:49:21 -0700 (PDT)
Received: from dggpeml500026.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MV4L305VjzpSvX;
        Sat, 17 Sep 2022 16:46:35 +0800 (CST)
Received: from dggpeml500010.china.huawei.com (7.185.36.155) by
 dggpeml500026.china.huawei.com (7.185.36.106) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sat, 17 Sep 2022 16:49:19 +0800
Received: from huawei.com (10.175.101.6) by dggpeml500010.china.huawei.com
 (7.185.36.155) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Sat, 17 Sep
 2022 16:49:18 +0800
From:   Xin Liu <liuxin350@huawei.com>
To:     <ast@kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>,
        <martin.lau@linux.dev>, <song@kernel.org>, <yhs@fb.com>,
        <john.fastabend@gmail.com>, <kpsingh@kernel.org>, <sdf@google.com>,
        <haoluo@google.com>, <jolsa@kernel.org>
CC:     <bpf@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <yanan@huawei.com>, <wuchangye@huawei.com>,
        <xiesongyang@huawei.com>, <zhudi2@huawei.com>,
        <kongweibin2@huawei.com>, <liuxin350@huawei.com>
Subject: [PATCH v2] libbpf: Fix NULL pointer exception in API btf_dump__dump_type_data
Date:   Sat, 17 Sep 2022 16:48:09 +0800
Message-ID: <20220917084809.30770-1-liuxin350@huawei.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.101.6]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpeml500010.china.huawei.com (7.185.36.155)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

We found that function btf_dump__dump_type_data can be called by the
user as an API, but in this function, the `opts` parameter may be used
as a null pointer.This causes `opts->indent_str` to trigger a NULL
pointer exception.

Fixes: 2ce8450ef5a3 ("libbpf: add bpf_object__open_{file, mem} w/ extensible opts")
Signed-off-by: Xin Liu <liuxin350@huawei.com>
Signed-off-by: Weibin Kong <kongweibin2@huawei.com>
---
v1 -> v2: Use OPTS_GET to fix NULL pointer exceptions
v1: https://lore.kernel.org/bpf/20220914123423.24368-1-liuxin350@huawei.com/ 

 tools/lib/bpf/btf_dump.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/lib/bpf/btf_dump.c b/tools/lib/bpf/btf_dump.c
index 627edb5bb6de..4221f73a74d0 100644
--- a/tools/lib/bpf/btf_dump.c
+++ b/tools/lib/bpf/btf_dump.c
@@ -2385,7 +2385,7 @@ int btf_dump__dump_type_data(struct btf_dump *d, __u32 id,
 	d->typed_dump->indent_lvl = OPTS_GET(opts, indent_level, 0);
 
 	/* default indent string is a tab */
-	if (!opts->indent_str)
+	if (!OPTS_GET(opts, indent_str, NULL))
 		d->typed_dump->indent_str[0] = '\t';
 	else
 		libbpf_strlcpy(d->typed_dump->indent_str, opts->indent_str,
-- 
2.33.0

