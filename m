Return-Path: <SRS0=9Oao=SO=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D862BC282CE
	for <bpf@archiver.kernel.org>; Fri, 12 Apr 2019 13:29:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A84942186A
	for <bpf@archiver.kernel.org>; Fri, 12 Apr 2019 13:29:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="t6/nkDN9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726958AbfDLN37 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 12 Apr 2019 09:29:59 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:54157 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726973AbfDLN36 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 12 Apr 2019 09:29:58 -0400
Received: by mail-wm1-f66.google.com with SMTP id q16so11254131wmj.3
        for <bpf@vger.kernel.org>; Fri, 12 Apr 2019 06:29:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=JT+XJcUgsRhwQ7fFVvxtks0i0ze/Hbl2a7DoaC1Za8Q=;
        b=t6/nkDN9Cpd/oCXuur7CVS5UXJrz1ynaADv65WRrBhOL8RwxF5CQax/mM9mCtYeyAj
         FCQZZoIpZ3wV8/EXBiEVpaRwRH94OrHE98HcTYWmNoHdycSfcFm04/jredls16YTlPBM
         ykmXOKN0mM8sDdnwvbfayu27LGRpMhVoFW4BMAZtjYvDih85KMbH5n6cMM6QobaV1ZKZ
         pLOUp3oozBM6KhzW8RDxgLEKvgudXkfGliIS8JCav1vhbupKI98311pYpMQA+f57k/Uw
         YLSHPDaYUMzsXA+rv4L/D13+40tDcE/Kk5XMSaXfuEO3K0JhE4hbCwU3KTrZKH7G1OuU
         Krkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=JT+XJcUgsRhwQ7fFVvxtks0i0ze/Hbl2a7DoaC1Za8Q=;
        b=Qll2EWR/MOAqBBP7QD2DPf4fI6F8qT+CW+/xk7ZJBdHv242smjidwkE7JP68sb1cUU
         C2+rs2+d2t6SbRjoPBmyEhB+7EDkQd5qbVII1X0HfdWbhOBz1SsRzRbo+fNTFlUWtEPz
         VF5CBrTcEjWZhOOzSNj+HuzX8WnY1c2FeIxWIwIv5w3ZtY7nViVraToTtfGeGaCWlvqS
         O3C4oeWlitCWwoshxIueJeRAcA/druUaZ5zgGnCD+BhEwrr4/Ul6g3Io+kIbwRQsecDe
         g2IEV1LtR/qOzHAUz8USrlOy1sJt9vD+P2Aa9sP9pVr/EDE4BeeWOEGqdMb3pfhaJKD/
         nAWg==
X-Gm-Message-State: APjAAAXtEG4+vTOGiCEaX1UKmYKaABzmj9cYB1fvQKkkduX+Qpk2BQf/
        BE/+qlDtBhwmZZrdH/wu8Pgb/g==
X-Google-Smtp-Source: APXvYqx2C18w4oWPctwL/F1IXEV/uC9jw0lw13qYLzzJItnox1RIPzoG6phrAEg89b7fplC47UNpCg==
X-Received: by 2002:a1c:81c9:: with SMTP id c192mr10954374wmd.124.1555075796665;
        Fri, 12 Apr 2019 06:29:56 -0700 (PDT)
Received: from cbtest32.netronome.com ([217.38.71.146])
        by smtp.gmail.com with ESMTPSA id v184sm15752915wma.6.2019.04.12.06.29.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Apr 2019 06:29:53 -0700 (PDT)
From:   Quentin Monnet <quentin.monnet@netronome.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org,
        oss-drivers@netronome.com,
        Quentin Monnet <quentin.monnet@netronome.com>
Subject: [PATCH bpf-next 3/5] tools: bpftool: fix man page documentation for "pinmaps" keyword
Date:   Fri, 12 Apr 2019 14:29:36 +0100
Message-Id: <20190412132938.9044-4-quentin.monnet@netronome.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190412132938.9044-1-quentin.monnet@netronome.com>
References: <20190412132938.9044-1-quentin.monnet@netronome.com>
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The "pinmaps" keyword is present in the man page, in the verbose
description of the "bpftool prog load" command. However, it is missing
from the summary of available commands at the beginning of the file. Add
it there as well.

Signed-off-by: Quentin Monnet <quentin.monnet@netronome.com>
Reviewed-by: Jakub Kicinski <jakub.kicinski@netronome.com>
---
 tools/bpf/bpftool/Documentation/bpftool-prog.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/bpf/bpftool/Documentation/bpftool-prog.rst b/tools/bpf/bpftool/Documentation/bpftool-prog.rst
index 9386bd6e0396..49c33939239f 100644
--- a/tools/bpf/bpftool/Documentation/bpftool-prog.rst
+++ b/tools/bpf/bpftool/Documentation/bpftool-prog.rst
@@ -25,7 +25,7 @@ PROG COMMANDS
 |	**bpftool** **prog dump xlated** *PROG* [{**file** *FILE* | **opcodes** | **visual** | **linum**}]
 |	**bpftool** **prog dump jited**  *PROG* [{**file** *FILE* | **opcodes** | **linum**}]
 |	**bpftool** **prog pin** *PROG* *FILE*
-|	**bpftool** **prog { load | loadall }** *OBJ* *PATH* [**type** *TYPE*] [**map** {**idx** *IDX* | **name** *NAME*} *MAP*] [**dev** *NAME*]
+|	**bpftool** **prog { load | loadall }** *OBJ* *PATH* [**type** *TYPE*] [**map** {**idx** *IDX* | **name** *NAME*} *MAP*] [**dev** *NAME*] [**pinmaps** *MAP_DIR*]
 |	**bpftool** **prog attach** *PROG* *ATTACH_TYPE* [*MAP*]
 |	**bpftool** **prog detach** *PROG* *ATTACH_TYPE* [*MAP*]
 |	**bpftool** **prog tracelog**
-- 
2.17.1

