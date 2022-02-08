Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 918A3C433FE
	for <bpf@archiver.kernel.org>; Tue,  8 Feb 2022 01:47:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241100AbiBHBro (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 7 Feb 2022 20:47:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235830AbiBHBZw (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 7 Feb 2022 20:25:52 -0500
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F3B3C061A73
        for <bpf@vger.kernel.org>; Mon,  7 Feb 2022 17:25:50 -0800 (PST)
Received: from dggpeml500025.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Jt4xp1k1HzdZTT;
        Tue,  8 Feb 2022 09:22:38 +0800 (CST)
Received: from huawei.com (10.175.124.27) by dggpeml500025.china.huawei.com
 (7.185.36.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Tue, 8 Feb
 2022 09:25:45 +0800
From:   Hou Tao <houtao1@huawei.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>
CC:     Ard Biesheuvel <ard.biesheuvel@arm.com>,
        Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Zi Shen Lim <zlim.lnx@gmail.com>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        <bpf@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <houtao1@huawei.com>
Subject: [PATCH bpf-next v3 1/2] bpf, arm64: call build_prologue() first in first JIT pass
Date:   Tue, 8 Feb 2022 09:25:38 +0800
Message-ID: <20220208012539.491753-2-houtao1@huawei.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220208012539.491753-1-houtao1@huawei.com>
References: <20220208012539.491753-1-houtao1@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.124.27]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpeml500025.china.huawei.com (7.185.36.35)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

BPF line info needs ctx->offset to be the instruction offset
in the whole jited image instead of the body itself, so also
call build_prologue() first in first JIT pass.

Fixes: 37ab566c178d ("bpf: arm64: Enable arm64 jit to provide bpf_line_info")
Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 arch/arm64/net/bpf_jit_comp.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
index 2375ed3e4c8a..68b35c83e637 100644
--- a/arch/arm64/net/bpf_jit_comp.c
+++ b/arch/arm64/net/bpf_jit_comp.c
@@ -1190,15 +1190,18 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
 		goto out_off;
 	}
 
-	/* 1. Initial fake pass to compute ctx->idx. */
-
-	/* Fake pass to fill in ctx->offset. */
-	if (build_body(&ctx, extra_pass)) {
+	/*
+	 * 1. Initial fake pass to compute ctx->idx and ctx->offset.
+	 *
+	 * BPF line info needs ctx->offset[i] to be the offset of
+	 * instruction[i] in jited image, so build prologue first.
+	 */
+	if (build_prologue(&ctx, was_classic)) {
 		prog = orig_prog;
 		goto out_off;
 	}
 
-	if (build_prologue(&ctx, was_classic)) {
+	if (build_body(&ctx, extra_pass)) {
 		prog = orig_prog;
 		goto out_off;
 	}
-- 
2.27.0

