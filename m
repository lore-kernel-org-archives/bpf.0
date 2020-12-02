Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E34EC6369E
	for <bpf@archiver.kernel.org>; Wed,  2 Dec 2020 23:14:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 069C7221EB
	for <bpf@archiver.kernel.org>; Wed,  2 Dec 2020 23:14:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387720AbgLBXOV (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 2 Dec 2020 18:14:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387686AbgLBXOV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 2 Dec 2020 18:14:21 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C64FC061A04
        for <bpf@vger.kernel.org>; Wed,  2 Dec 2020 15:13:35 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id k7so381137ybm.13
        for <bpf@vger.kernel.org>; Wed, 02 Dec 2020 15:13:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=ZFxjFlPOGRZwOnY0RO0nkySg3CsVohaI0ePFi9oHcrY=;
        b=szsqI7ZLY+xJ2u/4byOrY+YuFCqH/PIjA8qOolHBjTgjEKAkupUiyZ8j4v2OZ57gUj
         R7LJplZbv2B7JHFxpiwDx0v0VdhW4rH/iSq39aMrDaRDHpXy0DTPj44jJdKVANd6yukd
         /OGtLa41bdcBWFyg/xPnuo1j7w4Vyyr73QHcArGvSsAZ8v8nzVkdxYJbpx5lznzT8vN+
         TmgxT2gDwPjN+jGudK8e9TWM3jDVFegBoRjMLGP+4J2HlGRw7WVxjvakdRYBCI9Cd+8A
         EBjq8FSvk8ydGmd4qovuTb/PnKLaNHLQk5sJyeR9lqNpewApwUSq5CTS23WwLkUIz0y+
         UpHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=ZFxjFlPOGRZwOnY0RO0nkySg3CsVohaI0ePFi9oHcrY=;
        b=cGJqN/5KP5O/6zPta+5CZa+ozlg9+gZ/za7iOg/W8xe2kVkiBzytiO7DRp/Og/e8Nn
         EAsRcbNVuIDTAC192hbUehlyHEoNg3aYnoL+g6opuQ7lH2TTbtbeoWGd/nyy5vTqMESo
         AH71RbhMyg3Sap8CvwH/QiBsq/4BY5v5IQJ+HoQh5a73lv0SVNCkw57U8jQm3849qG3j
         hh1ygH4Vj3jwpdLHNl9XgAxCQeZpxvjmMNYl5AuGG8iwupRRGiN+GMLQgWia17X8d6nH
         IIcil5caY1YRWll3EobD8Cj3wF1OhOLdA8/FVmoquR6uE/+mDfPdDuR2a7ckeyz5JKa2
         8/lA==
X-Gm-Message-State: AOAM531EgEAfmyPyDFHQ3+2MhI9bPOGgqupuqHdxHYmHAWi77XelIC3K
        orC4qf+/onkzu5Pwgo9kCNsqhqc=
X-Google-Smtp-Source: ABdhPJwexRD95gDCy4awzIG4X7TlQfJTt9TcopPQLJvcCZF3h9HVFS3ezLar8PpCNCfEGO+xsJNaM44=
Sender: "sdf via sendgmr" <sdf@sdf2.svl.corp.google.com>
X-Received: from sdf2.svl.corp.google.com ([2620:15c:2c4:1:7220:84ff:fe09:7732])
 (user=sdf job=sendgmr) by 2002:a25:c503:: with SMTP id v3mr655637ybe.15.1606950814299;
 Wed, 02 Dec 2020 15:13:34 -0800 (PST)
Date:   Wed,  2 Dec 2020 15:13:32 -0800
Message-Id: <20201202231332.3923644-1-sdf@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.29.2.576.ga3fc446d84-goog
Subject: [PATCH bpf-next] libbpf: cap retries in sys_bpf_prog_load
From:   Stanislav Fomichev <sdf@google.com>
To:     netdev@vger.kernel.org, bpf@vger.kernel.org
Cc:     davem@davemloft.net, ast@kernel.org, daniel@iogearbox.net,
        Stanislav Fomichev <sdf@google.com>,
        Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

I've seen a situation, where a process that's under pprof constantly
generates SIGPROF which prevents program loading indefinitely.
The right thing to do probably is to disable signals in the upper
layers while loading, but it still would be nice to get some error from
libbpf instead of an endless loop.

Let's add some small retry limit to the program loading:
try loading the program 5 (arbitrary) times and give up.

v2:
* 10 -> 5 retires (Andrii Nakryiko)

Signed-off-by: Stanislav Fomichev <sdf@google.com>
Acked-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/bpf.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
index d27e34133973..4025266d0fb0 100644
--- a/tools/lib/bpf/bpf.c
+++ b/tools/lib/bpf/bpf.c
@@ -67,11 +67,12 @@ static inline int sys_bpf(enum bpf_cmd cmd, union bpf_attr *attr,
 
 static inline int sys_bpf_prog_load(union bpf_attr *attr, unsigned int size)
 {
+	int retries = 5;
 	int fd;
 
 	do {
 		fd = sys_bpf(BPF_PROG_LOAD, attr, size);
-	} while (fd < 0 && errno == EAGAIN);
+	} while (fd < 0 && errno == EAGAIN && retries-- > 0);
 
 	return fd;
 }
-- 
2.29.2.576.ga3fc446d84-goog

