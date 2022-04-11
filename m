Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D516CC433EF
	for <bpf@archiver.kernel.org>; Mon, 11 Apr 2022 13:00:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231367AbiDKNDB (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 11 Apr 2022 09:03:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237127AbiDKNDA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 11 Apr 2022 09:03:00 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFFF818E04;
        Mon, 11 Apr 2022 06:00:45 -0700 (PDT)
Received: from canpemm500010.china.huawei.com (unknown [172.30.72.57])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4KcTV15B77z1HBVc;
        Mon, 11 Apr 2022 21:00:09 +0800 (CST)
Received: from huawei.com (10.175.101.6) by canpemm500010.china.huawei.com
 (7.192.105.118) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 11 Apr
 2022 21:00:42 +0800
From:   Liu Jian <liujian56@huawei.com>
To:     <ast@kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>,
        <kafai@fb.com>, <songliubraving@fb.com>, <yhs@fb.com>,
        <john.fastabend@gmail.com>, <kpsingh@kernel.org>,
        <davem@davemloft.net>, <kuba@kernel.org>, <sdf@google.com>,
        <netdev@vger.kernel.org>, <bpf@vger.kernel.org>
CC:     <liujian56@huawei.com>
Subject: [PATCH bpf 0/2] Enlarge offset check value in bpf_skb_load_bytes
Date:   Mon, 11 Apr 2022 21:02:53 +0800
Message-ID: <20220411130255.385520-1-liujian56@huawei.com>
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

The data length of skb frags + frag_list may be greater than 0xffff,
and skb_header_pointer can not handle negative offset and negative len.
So here INT_MAX is used to check the validity of offset and len.

And add the test case for the change.

Liu Jian (2):
  net: Enlarge offset check value from 0xffff to INT_MAX in
    bpf_skb_load_bytes
  selftests: bpf: add test for skb_load_bytes

 net/core/filter.c                             |  4 +-
 .../selftests/bpf/prog_tests/skb_load_bytes.c | 65 +++++++++++++++++++
 .../selftests/bpf/progs/skb_load_bytes.c      | 37 +++++++++++
 3 files changed, 104 insertions(+), 2 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/skb_load_bytes.c
 create mode 100644 tools/testing/selftests/bpf/progs/skb_load_bytes.c

-- 
2.17.1

