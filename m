Return-Path: <SRS0=OafG=EP=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97B8FC2D0A3
	for <bpf@archiver.kernel.org>; Mon,  9 Nov 2020 07:01:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B35620789
	for <bpf@archiver.kernel.org>; Mon,  9 Nov 2020 07:01:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729587AbgKIHBH (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 9 Nov 2020 02:01:07 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:7471 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728873AbgKIHBH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 9 Nov 2020 02:01:07 -0500
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4CV22h64k8zhjPL;
        Mon,  9 Nov 2020 15:01:00 +0800 (CST)
Received: from huawei.com (10.175.113.133) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.487.0; Mon, 9 Nov 2020
 15:01:02 +0800
From:   Wang Hai <wanghai38@huawei.com>
To:     <ast@kernel.org>, <daniel@iogearbox.net>, <kafai@fb.com>,
        <songliubraving@fb.com>, <yhs@fb.com>, <andrii@kernel.org>,
        <john.fastabend@gmail.com>, <kpsingh@chromium.org>,
        <toke@redhat.com>, <quentin@isovalent.com>,
        <danieltimlee@gmail.com>
CC:     <bpf@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH bpf] tools: bpftool: Add missing close before bpftool net attach exit
Date:   Mon, 9 Nov 2020 15:04:10 +0800
Message-ID: <20201109070410.65833-1-wanghai38@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.113.133]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

progfd is created by prog_parse_fd(), before 'bpftool net attach' exit,
it should be closed.

Fixes: 04949ccc273e ("tools: bpftool: add net attach command to attach XDP on interface")
Signed-off-by: Wang Hai <wanghai38@huawei.com>
---
 tools/bpf/bpftool/net.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/bpf/bpftool/net.c b/tools/bpf/bpftool/net.c
index 910e7bac6e9e..3e9b40e64fb0 100644
--- a/tools/bpf/bpftool/net.c
+++ b/tools/bpf/bpftool/net.c
@@ -600,12 +600,14 @@ static int do_attach(int argc, char **argv)
 	if (err < 0) {
 		p_err("interface %s attach failed: %s",
 		      attach_type_strings[attach_type], strerror(-err));
+		close(progfd);
 		return err;
 	}
 
 	if (json_output)
 		jsonw_null(json_wtr);
 
+	close(progfd);
 	return 0;
 }
 
-- 
2.17.1

