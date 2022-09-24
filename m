Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B647AC6FA83
	for <bpf@archiver.kernel.org>; Sat, 24 Sep 2022 10:13:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233671AbiIXKN3 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Sat, 24 Sep 2022 06:13:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233480AbiIXKN1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 24 Sep 2022 06:13:27 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DBE9A599B;
        Sat, 24 Sep 2022 03:13:25 -0700 (PDT)
Received: from dggpeml500025.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MZPqW0qFdzHthh;
        Sat, 24 Sep 2022 18:08:39 +0800 (CST)
Received: from dggpeml500010.china.huawei.com (7.185.36.155) by
 dggpeml500025.china.huawei.com (7.185.36.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sat, 24 Sep 2022 18:13:23 +0800
Received: from huawei.com (10.175.101.6) by dggpeml500010.china.huawei.com
 (7.185.36.155) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Sat, 24 Sep
 2022 18:13:22 +0800
From:   Xin Liu <liuxin350@huawei.com>
To:     <ast@kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>,
        <martin.lau@linux.dev>, <song@kernel.org>, <yhs@fb.com>,
        <john.fastabend@gmail.com>, <kpsingh@kernel.org>, <sdf@google.com>,
        <haoluo@google.com>, <jolsa@kernel.org>
CC:     <bpf@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <yanan@huawei.com>, <wuchangye@huawei.com>,
        <xiesongyang@huawei.com>, <zhudi2@huawei.com>,
        <kongweibin2@huawei.com>, <liuxin350@huawei.com>
Subject: [PATCH 2/2] bpftool: add fPIE option for bpftool
Date:   Sat, 24 Sep 2022 18:12:09 +0800
Message-ID: <20220924101209.50653-3-liuxin350@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20220924101209.50653-1-liuxin350@huawei.com>
References: <20220924101209.50653-1-liuxin350@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.101.6]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpeml500010.china.huawei.com (7.185.36.155)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Use the fPIE option to compile bpftool to improve bpftool security.

Signed-off-by: Xin Liu <liuxin350@huawei.com>
---
 tools/bpf/bpftool/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/bpf/bpftool/Makefile b/tools/bpf/bpftool/Makefile
index 4a95c017ad4c..d1cd21214388 100644
--- a/tools/bpf/bpftool/Makefile
+++ b/tools/bpf/bpftool/Makefile
@@ -72,6 +72,7 @@ bash_compdir ?= /usr/share/bash-completion/completions
 
 CFLAGS += -O2
 CFLAGS += -W -Wall -Wextra -Wno-unused-parameter -Wno-missing-field-initializers
+CFLAGS += -pie -fPIE
 CFLAGS += $(filter-out -Wswitch-enum -Wnested-externs,$(EXTRA_WARNINGS))
 CFLAGS += -DPACKAGE='"bpftool"' -D__EXPORTED_HEADERS__ \
 	-I$(or $(OUTPUT),.) \
-- 
2.33.0

