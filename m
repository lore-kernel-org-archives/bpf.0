Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FD16C46467
	for <bpf@archiver.kernel.org>; Tue, 29 Nov 2022 13:45:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229773AbiK2NpX (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 29 Nov 2022 08:45:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229650AbiK2NpW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 29 Nov 2022 08:45:22 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23525B861;
        Tue, 29 Nov 2022 05:45:20 -0800 (PST)
Received: from dggpeml500021.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4NM3VH39XlzmWJB;
        Tue, 29 Nov 2022 21:44:39 +0800 (CST)
Received: from dggpeml100012.china.huawei.com (7.185.36.121) by
 dggpeml500021.china.huawei.com (7.185.36.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 29 Nov 2022 21:45:18 +0800
Received: from localhost.localdomain (10.67.175.61) by
 dggpeml100012.china.huawei.com (7.185.36.121) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 29 Nov 2022 21:45:18 +0800
From:   Zheng Yejian <zhengyejian1@huawei.com>
To:     <ast@kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>,
        <martin.lau@linux.dev>, <song@kernel.org>, <yhs@fb.com>,
        <john.fastabend@gmail.com>, <kpsingh@kernel.org>, <sdf@google.com>,
        <haoluo@google.com>, <jolsa@kernel.org>, <corbet@lwn.net>,
        <bpf@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <zhengyejian1@huawei.com>
Subject: [PATCH bpf] bpf, docs: Correct the example of BPF_XOR
Date:   Tue, 29 Nov 2022 21:45:58 +0800
Message-ID: <20221129134558.2757043-1-zhengyejian1@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.175.61]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpeml100012.china.huawei.com (7.185.36.121)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Refer to description of BPF_XOR, dst_reg should be used but not src_reg
in the examples.

Signed-off-by: Zheng Yejian <zhengyejian1@huawei.com>
---
 Documentation/bpf/instruction-set.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/bpf/instruction-set.rst b/Documentation/bpf/instruction-set.rst
index 5d798437dad4..e672d5ec6cc7 100644
--- a/Documentation/bpf/instruction-set.rst
+++ b/Documentation/bpf/instruction-set.rst
@@ -122,11 +122,11 @@ BPF_END   0xd0   byte swap operations (see `Byte swap instructions`_ below)
 
 ``BPF_XOR | BPF_K | BPF_ALU`` means::
 
-  src_reg = (u32) src_reg ^ (u32) imm32
+  dst_reg = (u32) dst_reg ^ (u32) imm32
 
 ``BPF_XOR | BPF_K | BPF_ALU64`` means::
 
-  src_reg = src_reg ^ imm32
+  dst_reg = dst_reg ^ imm32
 
 
 Byte swap instructions
-- 
2.25.1

