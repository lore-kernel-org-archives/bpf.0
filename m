Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09730C433F5
	for <bpf@archiver.kernel.org>; Thu,  9 Sep 2021 13:22:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE84C60F6C
	for <bpf@archiver.kernel.org>; Thu,  9 Sep 2021 13:22:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357040AbhIINXN (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 9 Sep 2021 09:23:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:35412 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1358526AbhIINLR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 9 Sep 2021 09:11:17 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B2CF7632D6;
        Thu,  9 Sep 2021 12:01:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631188889;
        bh=qi4ocb7Zue/9G442AE8pKmC9HONwGwETAYk2cWmoNsg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EzKse0LU5aVRz+IYKcGcPNRBNEP4KW/I2/oePJ72np1L51x/NyJkOTV4ijvNgol+C
         ek0UElwClANSTf0xz6AeLGSyNytLstGQyAw6fVdYpi3paqt6DubWyTf9FyuUbMJtqi
         OymR2ZOshREeRrY0RzInbZ5MuKIuUeo0DkiPq25Vg/MCh8uAtwsPvHrVXif6Vp1CA6
         NG1RCT+q2GLhIgoV+Mk+pIu7lH+leD278tK2/kARJQVDcZpwAPvs19GLOVeGNqtVGW
         GJJ0q3+CwxmssbGjyJSmHpITQfM1aKP8oBY1XJTC2E8GXtIcZtsvKiHrExPr8Cv+3B
         guRwTy2QOcU2A==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Johan Almbladh <johan.almbladh@anyfinetworks.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Subject: [PATCH AUTOSEL 4.4 10/35] bpf/tests: Fix copy-and-paste error in double word test
Date:   Thu,  9 Sep 2021 08:00:51 -0400
Message-Id: <20210909120116.150912-10-sashal@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210909120116.150912-1-sashal@kernel.org>
References: <20210909120116.150912-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Johan Almbladh <johan.almbladh@anyfinetworks.com>

[ Upstream commit ae7f47041d928b1a2f28717d095b4153c63cbf6a ]

This test now operates on DW as stated instead of W, which was
already covered by another test.

Signed-off-by: Johan Almbladh <johan.almbladh@anyfinetworks.com>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
Link: https://lore.kernel.org/bpf/20210721104058.3755254-1-johan.almbladh@anyfinetworks.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 lib/test_bpf.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/test_bpf.c b/lib/test_bpf.c
index b1495f586f29..7db8d06006d8 100644
--- a/lib/test_bpf.c
+++ b/lib/test_bpf.c
@@ -3983,8 +3983,8 @@ static struct bpf_test tests[] = {
 		.u.insns_int = {
 			BPF_LD_IMM64(R0, 0),
 			BPF_LD_IMM64(R1, 0xffffffffffffffffLL),
-			BPF_STX_MEM(BPF_W, R10, R1, -40),
-			BPF_LDX_MEM(BPF_W, R0, R10, -40),
+			BPF_STX_MEM(BPF_DW, R10, R1, -40),
+			BPF_LDX_MEM(BPF_DW, R0, R10, -40),
 			BPF_EXIT_INSN(),
 		},
 		INTERNAL,
-- 
2.30.2

