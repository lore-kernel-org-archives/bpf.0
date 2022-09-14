Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D009ECAAD8
	for <bpf@archiver.kernel.org>; Wed, 14 Sep 2022 12:35:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229603AbiINMfu (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 14 Sep 2022 08:35:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbiINMfh (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 14 Sep 2022 08:35:37 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83BC965669;
        Wed, 14 Sep 2022 05:35:34 -0700 (PDT)
Received: from dggpeml500020.china.huawei.com (unknown [172.30.72.57])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4MSKT32Zxjz14QRj;
        Wed, 14 Sep 2022 20:31:35 +0800 (CST)
Received: from dggpeml500010.china.huawei.com (7.185.36.155) by
 dggpeml500020.china.huawei.com (7.185.36.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 14 Sep 2022 20:35:33 +0800
Received: from huawei.com (10.175.101.6) by dggpeml500010.china.huawei.com
 (7.185.36.155) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Wed, 14 Sep
 2022 20:35:32 +0800
From:   Xin Liu <liuxin350@huawei.com>
To:     <ast@kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>,
        <martin.lau@linux.dev>, <song@kernel.org>, <yhs@fb.com>,
        <john.fastabend@gmail.com>, <kpsingh@kernel.org>, <sdf@google.com>,
        <haoluo@google.com>, <jolsa@kernel.org>
CC:     <bpf@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <yanan@huawei.com>, <wuchangye@huawei.com>,
        <xiesongyang@huawei.com>, <zhudi2@huawei.com>,
        <kongweibin2@huawei.com>, <liuxin350@huawei.com>
Subject: [PATCH] libbpf: adjust OPTS_VALID logic, so that it can be used correctly
Date:   Wed, 14 Sep 2022 20:34:23 +0800
Message-ID: <20220914123423.24368-1-liuxin350@huawei.com>
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

We found that function btf_dump__dump_type_data can be called by the user
as an api, but in this function, the `opts` parameter may be used as a
null pointer, because OPTS_VALID can't properly prevent opts used as null
pointers during verification. Therefore, we fix this problem through this
modification.

This modification has no impact on other places where OPTS_VALID has been
used.

Fixes: 2ce8450ef5a3 ("libbpf: add bpf_object__open_{file, mem} w/ extensible opts")
Signed-off-by: Xin Liu <liuxin350@huawei.com>
---
 tools/lib/bpf/libbpf_internal.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/lib/bpf/libbpf_internal.h b/tools/lib/bpf/libbpf_internal.h
index 377642ff51fc..29d3267ba56a 100644
--- a/tools/lib/bpf/libbpf_internal.h
+++ b/tools/lib/bpf/libbpf_internal.h
@@ -294,7 +294,7 @@ static inline bool libbpf_validate_opts(const char *opts,
 }
 
 #define OPTS_VALID(opts, type)						      \
-	(!(opts) || libbpf_validate_opts((const char *)opts,		      \
+	((opts) && libbpf_validate_opts((const char *)opts,		      \
 					 offsetofend(struct type,	      \
 						     type##__last_field),     \
 					 (opts)->sz, #type))
-- 
2.33.0

