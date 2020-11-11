Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56B09C5517A
	for <bpf@archiver.kernel.org>; Wed, 11 Nov 2020 13:52:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A2832074B
	for <bpf@archiver.kernel.org>; Wed, 11 Nov 2020 13:52:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726595AbgKKNvh (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 11 Nov 2020 08:51:37 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:7883 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726985AbgKKNvd (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 11 Nov 2020 08:51:33 -0500
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4CWR3536z3z75dk;
        Wed, 11 Nov 2020 21:51:13 +0800 (CST)
Received: from huawei.com (10.175.113.133) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.487.0; Wed, 11 Nov 2020
 21:51:21 +0800
From:   Wang Hai <wanghai38@huawei.com>
To:     <john.fastabend@gmail.com>, <quentin@isovalent.com>,
        <mrostecki@opensuse.org>
CC:     <ast@kernel.org>, <daniel@iogearbox.net>, <kafai@fb.com>,
        <songliubraving@fb.com>, <yhs@fb.com>, <andrii@kernel.org>,
        <kpsingh@chromium.org>, <toke@redhat.com>,
        <danieltimlee@gmail.com>, <bpf@vger.kernel.org>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 bpf] tools: bpftool: Add missing close before bpftool net attach exit
Date:   Wed, 11 Nov 2020 21:54:25 +0800
Message-ID: <20201111135425.56533-1-wanghai38@huawei.com>
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
v2->v3: add 'err = 0' before successful return
v1->v2: use cleanup tag instead of repeated closes
 tools/bpf/bpftool/net.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/tools/bpf/bpftool/net.c b/tools/bpf/bpftool/net.c
index 910e7bac6e9e..f927392271cc 100644
--- a/tools/bpf/bpftool/net.c
+++ b/tools/bpf/bpftool/net.c
@@ -578,8 +578,8 @@ static int do_attach(int argc, char **argv)
 
 	ifindex = net_parse_dev(&argc, &argv);
 	if (ifindex < 1) {
-		close(progfd);
-		return -EINVAL;
+		err = -EINVAL;
+		goto cleanup;
 	}
 
 	if (argc) {
@@ -587,8 +587,8 @@ static int do_attach(int argc, char **argv)
 			overwrite = true;
 		} else {
 			p_err("expected 'overwrite', got: '%s'?", *argv);
-			close(progfd);
-			return -EINVAL;
+			err = -EINVAL;
+			goto cleanup;
 		}
 	}
 
@@ -597,16 +597,20 @@ static int do_attach(int argc, char **argv)
 		err = do_attach_detach_xdp(progfd, attach_type, ifindex,
 					   overwrite);
 
-	if (err < 0) {
+	if (err) {
 		p_err("interface %s attach failed: %s",
 		      attach_type_strings[attach_type], strerror(-err));
-		return err;
+		goto cleanup;
 	}
 
 	if (json_output)
 		jsonw_null(json_wtr);
 
-	return 0;
+	err = 0;
+
+cleanup:
+	close(progfd);
+	return err;
 }
 
 static int do_detach(int argc, char **argv)
-- 
2.17.1

