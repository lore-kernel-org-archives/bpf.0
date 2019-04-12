Return-Path: <SRS0=9Oao=SO=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DFC7C10F0E
	for <bpf@archiver.kernel.org>; Fri, 12 Apr 2019 13:30:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 562452171F
	for <bpf@archiver.kernel.org>; Fri, 12 Apr 2019 13:30:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="lH2Vgyqy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726974AbfDLNaA (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 12 Apr 2019 09:30:00 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:54777 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726993AbfDLNaA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 12 Apr 2019 09:30:00 -0400
Received: by mail-wm1-f66.google.com with SMTP id c1so11246001wml.4
        for <bpf@vger.kernel.org>; Fri, 12 Apr 2019 06:29:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=yhP7kk/CF+gXSVMHKC1sBhq34lbvLwZBvZoPCzNa3MQ=;
        b=lH2VgyqylzX+63rmhcF6fSVluPIMs1Np3un7eWHbm8JebpWUMfponqe+hYgNc2BA76
         rGmwmS57wBfl+6Dwagfd/ovrsP631uJLEZV/xqBA9Kg5hgRKb6RMNzO2k0fxjJi2P290
         E68gnSOlmZy5lG96fLugCod2MZjDY4cTEugk64QQMb0mllN1ZeDKYSpB0GQ2kX97hrAC
         OkoV1bqbSPnIxwUDZrJCoSM69Z2/NmrfnPoG/BM+vDWgCG3XR52ASBgIim8axy5F7mr6
         +ul5j95q5t56xLB0E4o5UepBy4NXlpygNEzzcVtS6HsU6FlOtuc47THoiEeJT7xaNSUN
         YNcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=yhP7kk/CF+gXSVMHKC1sBhq34lbvLwZBvZoPCzNa3MQ=;
        b=I9AkquzV70rVrTE34668WejzYixCKTYkVWZw5sF8tlhUSdCnJf1FPJe94uaGjVmRKU
         ggWb8b6Z5Jf24vCdSsM3PcCY1uIAj+dLc2zMYPk5tEzlxIkBdn6khAbiWkH9W7AKUQlV
         4aCzts4zS1jq1VdavmRGNp3uP6PC4aqcBfnPrm0S+cgKhkwXkWfc6KI0wDlEuY2/9AJj
         AqB8y8vXfWb0nBAzjPm0reR0Kyc5/MF/DFcdcJ4fc+oR31ub5FaW7ZeGnCLoXKFwHXAf
         Q3/qfyjH/J7o88FBBF3+fAtpLS+FhzYi3UlrKIUyBQFVtLR2qaAuWqDgP6HOMWacedjX
         jPPg==
X-Gm-Message-State: APjAAAWdGojd0cweoDRhTfT777EkTy4ueIwvVBzH6lCH00eJERGuUKy3
        hQHbEVvhFyzej+BqK27teg07pg==
X-Google-Smtp-Source: APXvYqxxmkjT9YYAFKrGGSvf4TrTcH6fuT6kJeJn97602bUPkozSvqZH4tIQLh7s8xGSlBevyf9jwA==
X-Received: by 2002:a1c:3982:: with SMTP id g124mr10974961wma.25.1555075798548;
        Fri, 12 Apr 2019 06:29:58 -0700 (PDT)
Received: from cbtest32.netronome.com ([217.38.71.146])
        by smtp.gmail.com with ESMTPSA id v184sm15752915wma.6.2019.04.12.06.29.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Apr 2019 06:29:57 -0700 (PDT)
From:   Quentin Monnet <quentin.monnet@netronome.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org,
        oss-drivers@netronome.com,
        Quentin Monnet <quentin.monnet@netronome.com>
Subject: [PATCH bpf-next 5/5] tools: bpftool: add a note on program statistics in man page
Date:   Fri, 12 Apr 2019 14:29:38 +0100
Message-Id: <20190412132938.9044-6-quentin.monnet@netronome.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190412132938.9044-1-quentin.monnet@netronome.com>
References: <20190412132938.9044-1-quentin.monnet@netronome.com>
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Linux kernel now supports statistics for BPF programs, and bpftool is
able to dump them. However, these statistics are not enabled by default,
and administrators may not know how to access them.

Add a paragraph in bpftool documentation, under the description of the
"bpftool prog show" command, to explain that such statistics are
available and that their collection is controlled via a dedicated sysctl
knob.

Signed-off-by: Quentin Monnet <quentin.monnet@netronome.com>
Reviewed-by: Jakub Kicinski <jakub.kicinski@netronome.com>
---
 tools/bpf/bpftool/Documentation/bpftool-prog.rst | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/bpf/bpftool/Documentation/bpftool-prog.rst b/tools/bpf/bpftool/Documentation/bpftool-prog.rst
index f2beb79a77e7..bb9bb00c0c2c 100644
--- a/tools/bpf/bpftool/Documentation/bpftool-prog.rst
+++ b/tools/bpf/bpftool/Documentation/bpftool-prog.rst
@@ -56,6 +56,14 @@ DESCRIPTION
 		  Output will start with program ID followed by program type and
 		  zero or more named attributes (depending on kernel version).
 
+		  Since Linux 5.1 the kernel can collect statistics on BPF
+		  programs (such as the total time spent running the program,
+		  and the number of times it was run). If available, bpftool
+		  shows such statistics. However, the kernel does not collect
+		  them by defaults, as it slightly impacts performance on each
+		  program run. Activation or deactivation of the feature is
+		  performed via the **kernel.bpf_stats_enabled** sysctl knob.
+
 	**bpftool prog dump xlated** *PROG* [{ **file** *FILE* | **opcodes** | **visual** | **linum** }]
 		  Dump eBPF instructions of the program from the kernel. By
 		  default, eBPF will be disassembled and printed to standard
-- 
2.17.1

