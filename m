Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DC75C4167D
	for <bpf@archiver.kernel.org>; Tue, 22 Feb 2022 07:41:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229664AbiBVHmC (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 22 Feb 2022 02:42:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229889AbiBVHl4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 22 Feb 2022 02:41:56 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43156D5F4A
        for <bpf@vger.kernel.org>; Mon, 21 Feb 2022 23:34:46 -0800 (PST)
Received: from kwepemi500013.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4K2rWK5lMqzdZW0;
        Tue, 22 Feb 2022 15:33:33 +0800 (CST)
Received: from huawei.com (10.67.174.197) by kwepemi500013.china.huawei.com
 (7.221.188.120) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Tue, 22 Feb
 2022 15:34:44 +0800
From:   Xu Kuohai <xukuohai@huawei.com>
To:     <bpf@vger.kernel.org>
CC:     Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Yonghong Song <yhs@fb.com>, Shuah Khan <shuah@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>
Subject: [PATCH bpf-next 0/2] libbpf: Fix btf dump error for BTF_KIND_FWD
Date:   Tue, 22 Feb 2022 02:45:22 -0500
Message-ID: <20220222074524.1027060-1-xukuohai@huawei.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.174.197]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemi500013.china.huawei.com (7.221.188.120)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Xu Kuohai (2):
  libbpf: Skip BTF_KIND_FWD when counting duplicated type names
  selftests/bpf: Update btf_dump for conflict FWD and STRUCT name

 tools/lib/bpf/btf_dump.c                         | 16 +++++++++-------
 .../testing/selftests/bpf/prog_tests/btf_dump.c  | 11 +++++++++--
 2 files changed, 18 insertions(+), 9 deletions(-)

-- 
2.30.2

