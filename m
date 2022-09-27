Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04910C6FA8E
	for <bpf@archiver.kernel.org>; Tue, 27 Sep 2022 11:01:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231858AbiI0LBB (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 27 Sep 2022 07:01:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231724AbiI0LAr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 27 Sep 2022 07:00:47 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 203BE2C111;
        Tue, 27 Sep 2022 04:00:45 -0700 (PDT)
Received: from canpemm500010.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4McGmr0nDCzpV3J;
        Tue, 27 Sep 2022 18:57:48 +0800 (CST)
Received: from localhost.localdomain (10.175.112.70) by
 canpemm500010.china.huawei.com (7.192.105.118) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 27 Sep 2022 19:00:42 +0800
From:   Wang Yufen <wangyufen@huawei.com>
To:     <quentin@isovalent.com>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <andrii@kernel.org>, <martin.lau@linux.dev>, <song@kernel.org>,
        <yhs@fb.com>, <john.fastabend@gmail.com>, <kpsingh@kernel.org>,
        <sdf@google.com>, <haoluo@google.com>, <jolsa@kernel.org>,
        <davem@davemloft.net>, <kuba@kernel.org>, <hawk@kernel.org>,
        <nathan@kernel.org>, <ndesaulniers@google.com>, <trix@redhat.com>
CC:     <bpf@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <netdev@vger.kernel.org>, <llvm@lists.linux.dev>
Subject: [bpf-next v7 3/3] bpftool: Update the bash completion(add autoattach to prog load)
Date:   Tue, 27 Sep 2022 19:21:16 +0800
Message-ID: <1664277676-2228-3-git-send-email-wangyufen@huawei.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1664277676-2228-1-git-send-email-wangyufen@huawei.com>
References: <1664277676-2228-1-git-send-email-wangyufen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.112.70]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 canpemm500010.china.huawei.com (7.192.105.118)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add autoattach optional to prog load|loadall for supporting
one-step load-attach-pin_link.

Signed-off-by: Wang Yufen <wangyufen@huawei.com>
---
 tools/bpf/bpftool/bash-completion/bpftool | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/bpf/bpftool/bash-completion/bpftool b/tools/bpf/bpftool/bash-completion/bpftool
index dc1641e..2957b42 100644
--- a/tools/bpf/bpftool/bash-completion/bpftool
+++ b/tools/bpf/bpftool/bash-completion/bpftool
@@ -505,6 +505,7 @@ _bpftool()
                             _bpftool_once_attr 'type'
                             _bpftool_once_attr 'dev'
                             _bpftool_once_attr 'pinmaps'
+                            _bpftool_once_attr 'autoattach'
                             return 0
                             ;;
                     esac
-- 
1.8.3.1

