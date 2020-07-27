Return-Path: <SRS0=Ijne=BG=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55E6DC433E0
	for <bpf@archiver.kernel.org>; Mon, 27 Jul 2020 17:54:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 394342070B
	for <bpf@archiver.kernel.org>; Mon, 27 Jul 2020 17:54:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727071AbgG0RyS (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 27 Jul 2020 13:54:18 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:50162 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726821AbgG0RyS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 27 Jul 2020 13:54:18 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1k07KF-0002zf-KX; Mon, 27 Jul 2020 17:54:11 +0000
From:   Colin King <colin.king@canonical.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] bpf: fix swapped arguments in calls to check_buffer_access
Date:   Mon, 27 Jul 2020 18:54:11 +0100
Message-Id: <20200727175411.155179-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

There are a couple of arguments of the boolean flag zero_size_allowed
and the char pointer buf_info when calling to function check_buffer_access
that are swapped by mistake. Fix these by swapping them to correct
the argument ordering.

Addresses-Coverity: ("Array compared to 0")
Fixes: afbf21dce668 ("bpf: Support readonly/readwrite buffers in verifier")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 kernel/bpf/verifier.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index cd14e70f2d07..88bb25d08bf8 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -3477,14 +3477,14 @@ static int check_mem_access(struct bpf_verifier_env *env, int insn_idx, u32 regn
 				regno, reg_type_str[reg->type]);
 			return -EACCES;
 		}
-		err = check_buffer_access(env, reg, regno, off, size, "rdonly",
-					  false,
+		err = check_buffer_access(env, reg, regno, off, size, false,
+					  "rdonly",
 					  &env->prog->aux->max_rdonly_access);
 		if (!err && value_regno >= 0)
 			mark_reg_unknown(env, regs, value_regno);
 	} else if (reg->type == PTR_TO_RDWR_BUF) {
-		err = check_buffer_access(env, reg, regno, off, size, "rdwr",
-					  false,
+		err = check_buffer_access(env, reg, regno, off, size, false,
+					  "rdwr",
 					  &env->prog->aux->max_rdwr_access);
 		if (!err && t == BPF_READ && value_regno >= 0)
 			mark_reg_unknown(env, regs, value_regno);
-- 
2.27.0

