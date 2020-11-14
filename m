Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E082C63697
	for <bpf@archiver.kernel.org>; Sat, 14 Nov 2020 13:53:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C1382225E
	for <bpf@archiver.kernel.org>; Sat, 14 Nov 2020 13:53:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726495AbgKNNxe (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Sat, 14 Nov 2020 08:53:34 -0500
Received: from mx.der-flo.net ([193.160.39.236]:51642 "EHLO mx.der-flo.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726964AbgKNNxd (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 14 Nov 2020 08:53:33 -0500
Received: by mx.der-flo.net (Postfix, from userid 110)
        id 6C5C4431B7; Sat, 14 Nov 2020 14:53:09 +0100 (CET)
Received: from localhost (unknown [IPv6:2a02:1203:ecb0:3930:1751:4157:4d75:a5e2])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx.der-flo.net (Postfix) with ESMTPSA id F4045427E1;
        Sat, 14 Nov 2020 14:52:11 +0100 (CET)
From:   Florian Lehner <dev@der-flo.net>
To:     bpf@vger.kernel.org
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        john.fastabend@gmail.com, peterz@infradead.org, mingo@redhat.com,
        acme@kernel.org, Florian Lehner <dev@der-flo.net>
Subject: [PATCH bpf,perf]] bpf,perf: return EOPNOTSUPP for attaching bpf handler on PERF_COUNT_SW_DUMMY
Date:   Sat, 14 Nov 2020 14:51:26 +0100
Message-Id: <20201114135126.29462-1-dev@der-flo.net>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

At the moment it is not possible to attach a bpf handler to a perf event
of type PERF_TYPE_SOFTWARE with a configuration of PERF_COUNT_SW_DUMMY.

Signed-off-by: Florian Lehner <dev@der-flo.net>
---
 kernel/events/core.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index da467e1dd49a..4e8846b7ceda 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -9668,6 +9668,10 @@ static int perf_event_set_bpf_handler(struct perf_event *event, u32 prog_fd)
 	if (event->prog)
 		return -EEXIST;
 
+	if (event->attr.type == PERF_TYPE_SOFTWARE &&
+	    event->attr.config == PERF_COUNT_SW_DUMMY)
+		return -EOPNOTSUPP;
+
 	prog = bpf_prog_get_type(prog_fd, BPF_PROG_TYPE_PERF_EVENT);
 	if (IS_ERR(prog))
 		return PTR_ERR(prog);
-- 
2.28.0

