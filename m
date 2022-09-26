Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7031C07E9D
	for <bpf@archiver.kernel.org>; Mon, 26 Sep 2022 04:51:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233157AbiIZEvu (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 26 Sep 2022 00:51:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233173AbiIZEvt (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 26 Sep 2022 00:51:49 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E1AD2655A
        for <bpf@vger.kernel.org>; Sun, 25 Sep 2022 21:51:49 -0700 (PDT)
Received: from canpemm500010.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MbVcJ57YCzWh3G;
        Mon, 26 Sep 2022 12:47:44 +0800 (CST)
Received: from localhost.localdomain (10.175.112.70) by
 canpemm500010.china.huawei.com (7.192.105.118) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 26 Sep 2022 12:51:46 +0800
From:   Wang Yufen <wangyufen@huawei.com>
To:     <ast@kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>,
        <martin.lau@linux.dev>, <song@kernel.org>, <yhs@fb.com>,
        <john.fastabend@gmail.com>, <kpsingh@kernel.org>, <sdf@google.com>,
        <haoluo@google.com>, <jolsa@kernel.org>, <mykolal@fb.com>,
        <shuah@kernel.org>, <delyank@fb.com>, <zhudi2@huawei.com>,
        <jakub@cloudflare.com>, <kuba@kernel.org>, <kuifeng@fb.com>,
        <deso@posteo.net>, <zhuyifei@google.com>, <hengqi.chen@gmail.com>
CC:     <bpf@vger.kernel.org>
Subject: [bpf-next 07/11] bpf/selftests: convert tcp_estats test to ASSERT_* macros
Date:   Mon, 26 Sep 2022 13:12:07 +0800
Message-ID: <1664169131-32405-8-git-send-email-wangyufen@huawei.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1664169131-32405-1-git-send-email-wangyufen@huawei.com>
References: <1664169131-32405-1-git-send-email-wangyufen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.112.70]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 canpemm500010.china.huawei.com (7.192.105.118)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Convert the selftest to use the preferred ASSERT_* macros instead of the
deprecated CHECK().

Signed-off-by: Wang Yufen <wangyufen@huawei.com>
---
 tools/testing/selftests/bpf/prog_tests/tcp_estats.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/tcp_estats.c b/tools/testing/selftests/bpf/prog_tests/tcp_estats.c
index 032dbfb..e070bca 100644
--- a/tools/testing/selftests/bpf/prog_tests/tcp_estats.c
+++ b/tools/testing/selftests/bpf/prog_tests/tcp_estats.c
@@ -6,11 +6,9 @@ void test_tcp_estats(void)
 	const char *file = "./test_tcp_estats.bpf.o";
 	int err, prog_fd;
 	struct bpf_object *obj;
-	__u32 duration = 0;
 
 	err = bpf_prog_test_load(file, BPF_PROG_TYPE_TRACEPOINT, &obj, &prog_fd);
-	CHECK(err, "", "err %d errno %d\n", err, errno);
-	if (err)
+	if (!ASSERT_OK(err, ""))
 		return;
 
 	bpf_object__close(obj);
-- 
1.8.3.1

