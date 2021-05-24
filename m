Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2765C04FF3
	for <bpf@archiver.kernel.org>; Mon, 24 May 2021 07:13:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E97D611EE
	for <bpf@archiver.kernel.org>; Mon, 24 May 2021 07:13:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232128AbhEXHPX (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 24 May 2021 03:15:23 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:5744 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232120AbhEXHPW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 24 May 2021 03:15:22 -0400
Received: from dggems702-chm.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4FpSyx42Pgzmkh5;
        Mon, 24 May 2021 15:10:17 +0800 (CST)
Received: from dggema772-chm.china.huawei.com (10.1.198.214) by
 dggems702-chm.china.huawei.com (10.3.19.179) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Mon, 24 May 2021 15:13:52 +0800
Received: from huawei.com (10.175.101.6) by dggema772-chm.china.huawei.com
 (10.1.198.214) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Mon, 24
 May 2021 15:13:51 +0800
From:   Liu Jian <liujian56@huawei.com>
To:     <ast@kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>,
        <kafai@fb.com>, <songliubraving@fb.com>, <yhs@fb.com>,
        <john.fastabend@gmail.com>, <kpsingh@kernel.org>,
        <quentin@isovalent.com>, <liujian56@huawei.com>, <sdf@google.com>,
        <netdev@vger.kernel.org>, <bpf@vger.kernel.org>
Subject: [PATCH] bpftool: Add sock_release help info for cgroup attach command
Date:   Mon, 24 May 2021 15:15:48 +0800
Message-ID: <20210524071548.115138-1-liujian56@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.101.6]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggema772-chm.china.huawei.com (10.1.198.214)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Fixes: db94cc0b4805 ("bpftool: Add support for BPF_CGROUP_INET_SOCK_RELEASE")
Signed-off-by: Liu Jian <liujian56@huawei.com>
---
 tools/bpf/bpftool/cgroup.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/bpf/bpftool/cgroup.c b/tools/bpf/bpftool/cgroup.c
index d901cc1b904a..6e53b1d393f4 100644
--- a/tools/bpf/bpftool/cgroup.c
+++ b/tools/bpf/bpftool/cgroup.c
@@ -28,7 +28,8 @@
 	"                        connect6 | getpeername4 | getpeername6 |\n"   \
 	"                        getsockname4 | getsockname6 | sendmsg4 |\n"   \
 	"                        sendmsg6 | recvmsg4 | recvmsg6 |\n"           \
-	"                        sysctl | getsockopt | setsockopt }"
+	"                        sysctl | getsockopt | setsockopt |\n"	       \
+	"                        sock_release }"
 
 static unsigned int query_flags;
 
-- 
2.17.1

