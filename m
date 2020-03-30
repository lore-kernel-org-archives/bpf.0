Return-Path: <SRS0=wk2/=5P=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D159DC2D0F2
	for <bpf@archiver.kernel.org>; Mon, 30 Mar 2020 20:39:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B465320757
	for <bpf@archiver.kernel.org>; Mon, 30 Mar 2020 20:39:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728165AbgC3UjF (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 30 Mar 2020 16:39:05 -0400
Received: from www62.your-server.de ([213.133.104.62]:38820 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728048AbgC3UjF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 30 Mar 2020 16:39:05 -0400
Received: from 98.186.195.178.dynamic.wline.res.cust.swisscom.ch ([178.195.186.98] helo=localhost)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1jJ1BW-0007C1-6z; Mon, 30 Mar 2020 22:39:02 +0200
From:   Daniel Borkmann <daniel@iogearbox.net>
To:     alexei.starovoitov@gmail.com
Cc:     bpf@vger.kernel.org, john.fastabend@gmail.com,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>
Subject: [PATCH bpf-next] bpf, doc: Add John as official reviewer to BPF subsystem
Date:   Mon, 30 Mar 2020 22:38:54 +0200
Message-Id: <0e9a74933b3f21f4c5b5a3bc7f8e900b39805639.1585556231.git.daniel@iogearbox.net>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.102.2/25767/Mon Mar 30 15:08:30 2020)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

We've added John Fastabend to our weekly BPF patch review rotation over
last months now where he provided excellent and timely feedback on BPF
patches. Therefore, add him to the BPF core reviewer team to the MAINTAINERS
file to reflect that.

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Acked-by: Alexei Starovoitov <ast@kernel.org>
Acked-by: John Fastabend <john.fastabend@gmail.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 3197fe9256b2..983e449c0b5b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3147,6 +3147,7 @@ R:	Martin KaFai Lau <kafai@fb.com>
 R:	Song Liu <songliubraving@fb.com>
 R:	Yonghong Song <yhs@fb.com>
 R:	Andrii Nakryiko <andriin@fb.com>
+R:	John Fastabend <john.fastabend@gmail.com>
 R:	KP Singh <kpsingh@chromium.org>
 L:	netdev@vger.kernel.org
 L:	bpf@vger.kernel.org
-- 
2.21.0

