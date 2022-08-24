Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDC09C00140
	for <bpf@archiver.kernel.org>; Wed, 24 Aug 2022 14:06:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239007AbiHXOGC (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 24 Aug 2022 10:06:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239234AbiHXOFn (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 24 Aug 2022 10:05:43 -0400
Received: from out30-54.freemail.mail.aliyun.com (out30-54.freemail.mail.aliyun.com [115.124.30.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A0DA7E02D;
        Wed, 24 Aug 2022 07:05:36 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R531e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=chentao.kernel@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0VN7g--P_1661349909;
Received: from VM20210331-5.tbsite.net(mailfrom:chentao.kernel@linux.alibaba.com fp:SMTPD_---0VN7g--P_1661349909)
          by smtp.aliyun-inc.com;
          Wed, 24 Aug 2022 22:05:31 +0800
From:   "chentao.ct" <chentao.kernel@linux.alibaba.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>
Cc:     KP Singh <kpsingh@kernel.org>, netdev@vger.kernel.org,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        "chentao.ct" <chentao.kernel@linux.alibaba.com>
Subject: [PATCH] libbpf: Support raw btf placed in the default path
Date:   Wed, 24 Aug 2022 22:05:07 +0800
Message-Id: <1661349907-57222-1-git-send-email-chentao.kernel@linux.alibaba.com>
X-Mailer: git-send-email 2.2.1
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Now only elf btf can be placed in the default path, raw btf should
also can be there.

Signed-off-by: chentao.ct <chentao.kernel@linux.alibaba.com>
---
 tools/lib/bpf/btf.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
index bb1e06e..b22b5b3 100644
--- a/tools/lib/bpf/btf.c
+++ b/tools/lib/bpf/btf.c
@@ -4661,7 +4661,7 @@ struct btf *btf__load_vmlinux_btf(void)
 	} locations[] = {
 		/* try canonical vmlinux BTF through sysfs first */
 		{ "/sys/kernel/btf/vmlinux", true /* raw BTF */ },
-		/* fall back to trying to find vmlinux ELF on disk otherwise */
+		/* fall back to trying to find vmlinux RAW/ELF on disk otherwise */
 		{ "/boot/vmlinux-%1$s" },
 		{ "/lib/modules/%1$s/vmlinux-%1$s" },
 		{ "/lib/modules/%1$s/build/vmlinux" },
@@ -4686,7 +4686,7 @@ struct btf *btf__load_vmlinux_btf(void)
 		if (locations[i].raw_btf)
 			btf = btf__parse_raw(path);
 		else
-			btf = btf__parse_elf(path, NULL);
+			btf = btf__parse(path, NULL);
 		err = libbpf_get_error(btf);
 		pr_debug("loading kernel BTF '%s': %d\n", path, err);
 		if (err)
-- 
2.2.1

