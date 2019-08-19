Return-Path: <SRS0=Vw9o=WP=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EF2BC3A5A0
	for <bpf@archiver.kernel.org>; Mon, 19 Aug 2019 21:54:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E140214DA
	for <bpf@archiver.kernel.org>; Mon, 19 Aug 2019 21:54:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lekensteyn.nl header.i=@lekensteyn.nl header.b="RpJXXkmz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728360AbfHSVy4 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 19 Aug 2019 17:54:56 -0400
Received: from lekensteyn.nl ([178.21.112.251]:39727 "EHLO lekensteyn.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728283AbfHSVy4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 19 Aug 2019 17:54:56 -0400
X-Greylist: delayed 2008 seconds by postgrey-1.27 at vger.kernel.org; Mon, 19 Aug 2019 17:54:56 EDT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lekensteyn.nl; s=s2048-2015-q1;
        h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From; bh=CPhDF5jnURDhjAxSFhJHWKq3/SRRecFjjjdMVgviX/E=;
        b=RpJXXkmzoFgbBUx1sJBeRcHJKuT3/TD6/lyleO5gyECCe5Im1ZGtsgioV7qOQNSOQ9H8LaNRFUpvCyaAI5XWirTUJRmHqgykZG0bncQM6g7OTi/uywPq9eskKMNeNw2mPUIAoTt4rCvsVXnFA93SsSHF+dxJ7WCwl+X1l4x9AsHZ6oG4Cz2Z/EOMcDuM/Qqhr1xj1NpDtweWRh72S1y/+xwr0rVYWjv2c0Xsvz6Cz9/r7lJLQJsV49/MBi6PgbuUG2CoPgZYUSlS6489CWe4iTLWndmoljJoVEuXwsYfOBgWx5iYEkg8EfRsJ6nKzsObRqRWVGPVBLWexQZMJd489g==;
Received: by lekensteyn.nl with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.84_2)
        (envelope-from <peter@lekensteyn.nl>)
        id 1hzp5h-0005T6-0w; Mon, 19 Aug 2019 23:21:25 +0200
From:   Peter Wu <peter@lekensteyn.nl>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org
Subject: [PATCH 2/2] bpf: clarify description for CONFIG_BPF_EVENTS
Date:   Mon, 19 Aug 2019 22:21:22 +0100
Message-Id: <20190819212122.10286-3-peter@lekensteyn.nl>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190819212122.10286-1-peter@lekensteyn.nl>
References: <20190819212122.10286-1-peter@lekensteyn.nl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

PERF_EVENT_IOC_SET_BPF supports uprobes since v4.3, and tracepoints
since v4.7 via commit 04a22fae4cbc ("tracing, perf: Implement BPF
programs attached to uprobes"), and commit 98b5c2c65c29 ("perf, bpf:
allow bpf programs attach to tracepoints") respectively.

Signed-off-by: Peter Wu <peter@lekensteyn.nl>
---
 kernel/trace/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
index 98da8998c25c..b09d7b1ffffd 100644
--- a/kernel/trace/Kconfig
+++ b/kernel/trace/Kconfig
@@ -520,7 +520,8 @@ config BPF_EVENTS
 	bool
 	default y
 	help
-	  This allows the user to attach BPF programs to kprobe events.
+	  This allows the user to attach BPF programs to kprobe, uprobe, and
+	  tracepoint events.
 
 config DYNAMIC_EVENTS
 	def_bool n
-- 
2.22.0

