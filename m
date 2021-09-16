Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02CBFC4332F
	for <bpf@archiver.kernel.org>; Thu, 16 Sep 2021 13:41:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DC3566120F
	for <bpf@archiver.kernel.org>; Thu, 16 Sep 2021 13:41:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240305AbhIPNmf (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 16 Sep 2021 09:42:35 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:15430 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240283AbhIPNme (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 16 Sep 2021 09:42:34 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4H9J6726cMzR5hv;
        Thu, 16 Sep 2021 21:37:03 +0800 (CST)
Received: from dggpeml500025.china.huawei.com (7.185.36.35) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Thu, 16 Sep 2021 21:41:10 +0800
Received: from huawei.com (10.175.124.27) by dggpeml500025.china.huawei.com
 (7.185.36.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Thu, 16 Sep
 2021 21:41:10 +0800
From:   Hou Tao <houtao1@huawei.com>
To:     Alexei Starovoitov <ast@kernel.org>
CC:     Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, <bpf@vger.kernel.org>,
        <netdev@vger.kernel.org>, <houtao1@huawei.com>
Subject: [PATCH 2/3] libbpf: support detecting and attaching of writable tracepoint program
Date:   Thu, 16 Sep 2021 21:55:10 +0800
Message-ID: <20210916135511.3787194-3-houtao1@huawei.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210916135511.3787194-1-houtao1@huawei.com>
References: <20210916135511.3787194-1-houtao1@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.124.27]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpeml500025.china.huawei.com (7.185.36.35)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Program on writable tracepoint is BPF_PROG_TYPE_RAW_TRACEPOINT_WRITABLE,
but its attachment is the same as BPF_PROG_TYPE_RAW_TRACEPOINT.

Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 tools/lib/bpf/libbpf.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 88d8825fc6f6..e6a1d552040c 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -7942,6 +7942,10 @@ static const struct bpf_sec_def section_defs[] = {
 		.attach_fn = attach_raw_tp),
 	SEC_DEF("raw_tp/", RAW_TRACEPOINT,
 		.attach_fn = attach_raw_tp),
+	SEC_DEF("raw_tracepoint_writable/", RAW_TRACEPOINT_WRITABLE,
+		.attach_fn = attach_raw_tp),
+	SEC_DEF("raw_tp_writable/", RAW_TRACEPOINT_WRITABLE,
+		.attach_fn = attach_raw_tp),
 	SEC_DEF("tp_btf/", TRACING,
 		.expected_attach_type = BPF_TRACE_RAW_TP,
 		.is_attach_btf = true,
-- 
2.29.2

