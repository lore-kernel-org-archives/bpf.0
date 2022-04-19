Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD3FEC433EF
	for <bpf@archiver.kernel.org>; Tue, 19 Apr 2022 14:24:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353252AbiDSO0l (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 19 Apr 2022 10:26:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245037AbiDSO0d (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 19 Apr 2022 10:26:33 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 966422A279;
        Tue, 19 Apr 2022 07:23:47 -0700 (PDT)
Received: from dggpemm500020.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4KjQvt5DVQzFqS8;
        Tue, 19 Apr 2022 22:21:14 +0800 (CST)
Received: from dggpemm500019.china.huawei.com (7.185.36.180) by
 dggpemm500020.china.huawei.com (7.185.36.49) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 19 Apr 2022 22:23:44 +0800
Received: from k04.huawei.com (10.67.174.115) by
 dggpemm500019.china.huawei.com (7.185.36.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 19 Apr 2022 22:23:44 +0800
From:   Pu Lehui <pulehui@huawei.com>
To:     <bpf@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <netdev@vger.kernel.org>, <linux-riscv@lists.infradead.org>
CC:     <andrii@kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <kafai@fb.com>, <songliubraving@fb.com>, <yhs@fb.com>,
        <john.fastabend@gmail.com>, <kpsingh@kernel.org>,
        <paul.walmsley@sifive.com>, <palmer@dabbelt.com>,
        <aou@eecs.berkeley.edu>, <pulehui@huawei.com>
Subject: [PATCH v2 bpf-next 0/2] Support riscv libbpf USDT arg parsing logic
Date:   Tue, 19 Apr 2022 22:52:36 +0800
Message-ID: <20220419145238.482134-1-pulehui@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.174.115]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500019.china.huawei.com (7.185.36.180)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

patch 1 fix a minor issue where usdt_cookie is cast to 32 bits.
patch 2 add support riscv libbpf USDT argument parsing logic,
both RV32 and RV64 tests have been passed as like follow:

# ./test_progs -t usdt
#169 usdt:OK
Summary: 1/4 PASSED, 0 SKIPPED, 0 FAILED

Pu Lehui (2):
  libbpf: Fix usdt_cookie being cast to 32 bits
  libbpf: Support riscv USDT argument parsing logic

 tools/lib/bpf/libbpf.c          |   2 +-
 tools/lib/bpf/libbpf_internal.h |   2 +-
 tools/lib/bpf/usdt.c            | 115 ++++++++++++++++++++++++++++++--
 3 files changed, 113 insertions(+), 6 deletions(-)

-- 
2.25.1

