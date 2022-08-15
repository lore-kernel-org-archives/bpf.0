Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD402C25B06
	for <bpf@archiver.kernel.org>; Mon, 15 Aug 2022 02:30:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232530AbiHOCah (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Sun, 14 Aug 2022 22:30:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230009AbiHOCag (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 14 Aug 2022 22:30:36 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC5035FB8
        for <bpf@vger.kernel.org>; Sun, 14 Aug 2022 19:30:34 -0700 (PDT)
Received: from canpemm500010.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4M5dVt4dmbzmV7n;
        Mon, 15 Aug 2022 10:28:22 +0800 (CST)
Received: from huawei.com (10.175.101.6) by canpemm500010.china.huawei.com
 (7.192.105.118) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 15 Aug
 2022 10:30:30 +0800
From:   Liu Jian <liujian56@huawei.com>
To:     <john.fastabend@gmail.com>, <jakub@cloudflare.com>,
        <edumazet@google.com>, <davem@davemloft.net>,
        <yoshfuji@linux-ipv6.org>, <dsahern@kernel.org>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <andrii@kernel.org>, <mykolal@fb.com>,
        <ast@kernel.org>, <daniel@iogearbox.net>, <martin.lau@linux.dev>,
        <song@kernel.org>, <yhs@fb.com>, <kpsingh@kernel.org>,
        <sdf@google.com>, <haoluo@google.com>, <jolsa@kernel.org>,
        <shuah@kernel.org>, <bpf@vger.kernel.org>
CC:     <liujian56@huawei.com>
Subject: [PATCH bpf-next 0/2] >   Keep reference on socket file while wait send memory
Date:   Mon, 15 Aug 2022 10:33:41 +0800
Message-ID: <20220815023343.295094-1-liujian56@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.101.6]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 canpemm500010.china.huawei.com (7.192.105.118)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Keep reference on socket file while wait send memory

Liu Jian (2):
  sk_msg: Keep reference on socket file while wait_memory
  selftests/bpf: Add wait send memory test for sockmap redirect

 net/ipv4/tcp_bpf.c                         |  8 +++++
 tools/testing/selftests/bpf/test_sockmap.c | 42 ++++++++++++++++++++++
 2 files changed, 50 insertions(+)

-- 
2.17.1

