Return-Path: <SRS0=pl6P=36=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B08BC2BA83
	for <bpf@archiver.kernel.org>; Mon, 10 Feb 2020 01:20:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37AC6208C4
	for <bpf@archiver.kernel.org>; Mon, 10 Feb 2020 01:20:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726207AbgBJBUt (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Sun, 9 Feb 2020 20:20:49 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:9711 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725868AbgBJBUt (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 9 Feb 2020 20:20:49 -0500
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 2EB9D8629322D0A65290;
        Mon, 10 Feb 2020 09:20:46 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.439.0; Mon, 10 Feb 2020 09:20:36 +0800
From:   Hongbo Yao <yaohongbo@huawei.com>
To:     <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <yaohongbo@huawei.com>, <chenzhou10@huawei.com>, <kafai@fb.com>,
        <songliubraving@fb.com>, <yhs@fb.com>, <andriin@fb.com>,
        <netdev@vger.kernel.org>, <bpf@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <clang-built-linux@googlegroups.com>
Subject: [PATCH bpf-next] bpf: make btf_check_func_type_match() static
Date:   Mon, 10 Feb 2020 09:14:41 +0800
Message-ID: <20200210011441.147102-1-yaohongbo@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Fix sparse warning:
kernel/bpf/btf.c:4131:5: warning: symbol 'btf_check_func_type_match' was
not declared. Should it be static?

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Hongbo Yao <yaohongbo@huawei.com>
---
 kernel/bpf/btf.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 8c9d8f266bef..f24868a4176a 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -4144,9 +4144,9 @@ int btf_distill_func_proto(struct bpf_verifier_log *log,
  * EFAULT - verifier bug
  * 0 - 99% match. The last 1% is validated by the verifier.
  */
-int btf_check_func_type_match(struct bpf_verifier_log *log,
-			      struct btf *btf1, const struct btf_type *t1,
-			      struct btf *btf2, const struct btf_type *t2)
+static int btf_check_func_type_match(struct bpf_verifier_log *log,
+				     struct btf *btf1, const struct btf_type *t1,
+				     struct btf *btf2, const struct btf_type *t2)
 {
 	const struct btf_param *args1, *args2;
 	const char *fn1, *fn2, *s1, *s2;
-- 
2.20.1

