Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBCB3C4361B
	for <bpf@archiver.kernel.org>; Tue,  8 Dec 2020 21:50:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B8CC206FC
	for <bpf@archiver.kernel.org>; Tue,  8 Dec 2020 21:50:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730167AbgLHVtr (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 8 Dec 2020 16:49:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:40890 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726114AbgLHVtr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 8 Dec 2020 16:49:47 -0500
From:   KP Singh <kpsingh@kernel.org>
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH bpf] bpf, doc: Update KP's email in MAINTAINERS
Date:   Tue,  8 Dec 2020 22:49:00 +0100
Message-Id: <20201208214900.80684-1-kpsingh@kernel.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Helps me use a single account to sign off and send patches use
appropriate email redirection without needing to update MAINTAINERS.

Signed-off-by: KP Singh <kpsingh@kernel.org>
---
 MAINTAINERS | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 061e64b2423a..2a6e1d409524 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3239,7 +3239,7 @@ R:	Martin KaFai Lau <kafai@fb.com>
 R:	Song Liu <songliubraving@fb.com>
 R:	Yonghong Song <yhs@fb.com>
 R:	John Fastabend <john.fastabend@gmail.com>
-R:	KP Singh <kpsingh@chromium.org>
+R:	KP Singh <kpsingh@kernel.org>
 L:	netdev@vger.kernel.org
 L:	bpf@vger.kernel.org
 S:	Supported
@@ -3358,7 +3358,7 @@ F:	arch/x86/net/
 X:	arch/x86/net/bpf_jit_comp32.c
 
 BPF LSM (Security Audit and Enforcement using BPF)
-M:	KP Singh <kpsingh@chromium.org>
+M:	KP Singh <kpsingh@kernel.org>
 R:	Florent Revest <revest@chromium.org>
 R:	Brendan Jackman <jackmanb@chromium.org>
 L:	bpf@vger.kernel.org
-- 
2.27.0

