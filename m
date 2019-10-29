Return-Path: <SRS0=j4GQ=YW=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAEB2CA9EAE
	for <bpf@archiver.kernel.org>; Tue, 29 Oct 2019 14:51:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8657120717
	for <bpf@archiver.kernel.org>; Tue, 29 Oct 2019 14:51:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389468AbfJ2OvR (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 29 Oct 2019 10:51:17 -0400
Received: from www62.your-server.de ([213.133.104.62]:48302 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727255AbfJ2OvR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 29 Oct 2019 10:51:17 -0400
Received: from 38.249.197.178.dynamic.dsl-lte-bonding.lssmb00p-msn.res.cust.swisscom.ch ([178.197.249.38] helo=localhost)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1iPSpz-0006UZ-5u; Tue, 29 Oct 2019 15:51:11 +0100
From:   Daniel Borkmann <daniel@iogearbox.net>
To:     bpf@vger.kernel.org
Cc:     netdev@vger.kernel.org, Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andriin@fb.com>,
        Alexei Starovoitov <ast@kernel.org>
Subject: [PATCH bpf] bpf, doc: add Andrii as official reviewer to BPF subsystem
Date:   Tue, 29 Oct 2019 15:51:03 +0100
Message-Id: <af565dbef3b0b35040f26bfd16ed59cc0bae8066.1572360528.git.daniel@iogearbox.net>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.101.4/25617/Tue Oct 29 09:56:46 2019)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Andrii Nakryiko has been part of our weekly BPF patch review rotation
for quite some time now and provided excellent and timely feedback on
BPF patches, therefore give credit where credit is due and add him
officially to the BPF core reviewer team to the MAINTAINERS file.

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Acked-by: Andrii Nakryiko <andriin@fb.com>
Acked-by: Alexei Starovoitov <ast@kernel.org>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index e51a68bf8ca8..808bac0e3847 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3051,6 +3051,7 @@ M:	Daniel Borkmann <daniel@iogearbox.net>
 R:	Martin KaFai Lau <kafai@fb.com>
 R:	Song Liu <songliubraving@fb.com>
 R:	Yonghong Song <yhs@fb.com>
+R:	Andrii Nakryiko <andriin@fb.com>
 L:	netdev@vger.kernel.org
 L:	bpf@vger.kernel.org
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git
-- 
2.21.0

