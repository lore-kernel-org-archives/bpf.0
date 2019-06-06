Return-Path: <SRS0=vsg3=UF=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE3BAC04AB5
	for <bpf@archiver.kernel.org>; Thu,  6 Jun 2019 23:49:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC924206DF
	for <bpf@archiver.kernel.org>; Thu,  6 Jun 2019 23:49:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727855AbfFFXtS (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 6 Jun 2019 19:49:18 -0400
Received: from www62.your-server.de ([213.133.104.62]:47038 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726682AbfFFXtR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 6 Jun 2019 19:49:17 -0400
Received: from [178.197.249.21] (helo=localhost)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1hZ28B-0005Qp-Na; Fri, 07 Jun 2019 01:49:15 +0200
From:   Daniel Borkmann <daniel@iogearbox.net>
To:     alexei.starovoitov@gmail.com
Cc:     kafai@fb.com, rdna@fb.com, m@lambda.lt, bpf@vger.kernel.org,
        netdev@vger.kernel.org, Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH bpf v3 2/6] bpf: sync tooling uapi header
Date:   Fri,  7 Jun 2019 01:48:58 +0200
Message-Id: <20190606234902.4300-3-daniel@iogearbox.net>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20190606234902.4300-1-daniel@iogearbox.net>
References: <20190606234902.4300-1-daniel@iogearbox.net>
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.100.3/25472/Thu Jun  6 10:09:59 2019)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Sync BPF uapi header in order to pull in BPF_CGROUP_UDP{4,6}_RECVMSG
attach types. This is done and preferred as an extra patch in order
to ease sync of libbpf.

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Acked-by: Andrey Ignatov <rdna@fb.com>
Acked-by: Martin KaFai Lau <kafai@fb.com>
---
 tools/include/uapi/linux/bpf.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 63e0cf66f01a..e4114a7e4451 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -192,6 +192,8 @@ enum bpf_attach_type {
 	BPF_LIRC_MODE2,
 	BPF_FLOW_DISSECTOR,
 	BPF_CGROUP_SYSCTL,
+	BPF_CGROUP_UDP4_RECVMSG,
+	BPF_CGROUP_UDP6_RECVMSG,
 	__MAX_BPF_ATTACH_TYPE
 };
 
-- 
2.17.1

