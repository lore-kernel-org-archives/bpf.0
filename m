Return-Path: <SRS0=hNvk=EN=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C751C4741F
	for <bpf@archiver.kernel.org>; Sat,  7 Nov 2020 08:11:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 72F4420872
	for <bpf@archiver.kernel.org>; Sat,  7 Nov 2020 08:11:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727861AbgKGIK7 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Sat, 7 Nov 2020 03:10:59 -0500
Received: from m176115.mail.qiye.163.com ([59.111.176.115]:36550 "EHLO
        m176115.mail.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727738AbgKGIK7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 7 Nov 2020 03:10:59 -0500
Received: from vivo-HP-ProDesk-680-G4-PCI-MT.vivo.xyz (unknown [58.251.74.231])
        by m176115.mail.qiye.163.com (Hmail) with ESMTPA id 064C5665C31;
        Sat,  7 Nov 2020 16:10:55 +0800 (CST)
From:   Wang Qing <wangqing@vivo.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>, netdev@vger.kernel.org,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Wang Qing <wangqing@vivo.com>
Subject: [PATCH] bpf: remove duplicate include
Date:   Sat,  7 Nov 2020 16:10:50 +0800
Message-Id: <1604736650-11197-1-git-send-email-wangqing@vivo.com>
X-Mailer: git-send-email 2.7.4
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZHktKSR0fGR5OQx1OVkpNS09MSE1NTk1NTEtVEwETFhoSFyQUDg9ZV1kWGg8SFR0UWU
        FZT0tIVUpKS0hKQ1VLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MQw6Pgw6TD8qIxwdNSkfVhcM
        Tx0KFEtVSlVKTUtPTEhNTU5MSktPVTMWGhIXVQwaFRwKEhUcOw0SDRRVGBQWRVlXWRILWUFZTkNV
        SU5KVUxPVUlISllXWQgBWUFKTElCNwY+
X-HM-Tid: 0a75a1c224b79373kuws064c5665c31
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Remove duplicate header which is included twice.

Signed-off-by: Wang Qing <wangqing@vivo.com>
---
 kernel/bpf/btf.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index ed7d02e..6324de8
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -22,7 +22,6 @@
 #include <linux/skmsg.h>
 #include <linux/perf_event.h>
 #include <linux/bsearch.h>
-#include <linux/btf_ids.h>
 #include <net/sock.h>
 
 /* BTF (BPF Type Format) is the meta data format which describes
-- 
2.7.4

