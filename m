Return-Path: <SRS0=AlFI=WL=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 904F7C3A589
	for <bpf@archiver.kernel.org>; Thu, 15 Aug 2019 14:32:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65C9C206C1
	for <bpf@archiver.kernel.org>; Thu, 15 Aug 2019 14:32:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="TupD/Gh2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731220AbfHOOcg (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 15 Aug 2019 10:32:36 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:56012 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732944AbfHOOcg (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 15 Aug 2019 10:32:36 -0400
Received: by mail-wm1-f65.google.com with SMTP id f72so1453718wmf.5
        for <bpf@vger.kernel.org>; Thu, 15 Aug 2019 07:32:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=JPzzk5lRmjCdOAS6zNQJ1VhVCQa5IynB25ENpGskCeY=;
        b=TupD/Gh2d8qyh3RllnYSH0OpkdcfRETSxHt3xZHCA12yunZqr9yvxmWuGKZ9/rhCPq
         JCLcpZR/MuQYpfYkzTKFxT+/jFwTcxyXOs3nIMAsfleRIp7BlNHHLMbv4ZSkcLjmMtl2
         uZbnrJ9QnGcY+BLcdoytpamUQ//0CfHxjSV2ROqGHeCcC7nRN8loHTACUdt6qDlgcYHf
         kCXCOKRNpFXKjkZnsXlPJzhZA89e78anKQXUZXnzzz3d8zWLvr+MR/146/8SD9/YWOVs
         aUGHugQgDvqZY4KHw36yGVVB+iheS1oysDfp+BH1bvc7UrDlo/fAVilRT9UTQtbLJ39q
         n58g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=JPzzk5lRmjCdOAS6zNQJ1VhVCQa5IynB25ENpGskCeY=;
        b=QIN1FuO1RbGtZvFs8NBuKw9raJjGtJ1JXw6QnMtaK8GubhGUivyYM+9zAv6XMTzqub
         +WO/vQJzkuBq1/EU3wY9yBs9w/Gi9gWrt937QqZZetGwi9oOOCJjkUqh3MpE6GflEC71
         xIpKYiabAlub3FU17sgH9eur2Gn5dE6DTf8qIlYqVbgoOplN0JEkvUJJZt+qhDQ0LOFj
         1Mjba78WAAK1PzjddR2YEs2LGT4BnqipAWohPefx6YheevmgMTsULdW5uMqQiFea0pki
         a6zr8qmKfQXeIXYWZvtidfnPvTvjfAH00KvAATxSdR+9fWM2WhXFr7BJYF2J8T8DKmtv
         NbPQ==
X-Gm-Message-State: APjAAAVcIyIgyNpVPD5EW4cCyitf7HwcSgH/2a7bTxZvxk21TTAYryso
        HIH66MlBnEcRABLROWHsR0Sck8ba2SA=
X-Google-Smtp-Source: APXvYqwI9FQz5QfncZdStumoW6LrAu7+/jwRFiHcqXzZLnZOeEWkUGaCqJBs73aFI71k6s+VlZpyUA==
X-Received: by 2002:a05:600c:551:: with SMTP id k17mr3102790wmc.53.1565879554404;
        Thu, 15 Aug 2019 07:32:34 -0700 (PDT)
Received: from cbtest32.netronome.com ([217.38.71.146])
        by smtp.gmail.com with ESMTPSA id a19sm8857463wra.2.2019.08.15.07.32.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2019 07:32:33 -0700 (PDT)
From:   Quentin Monnet <quentin.monnet@netronome.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org,
        oss-drivers@netronome.com,
        Quentin Monnet <quentin.monnet@netronome.com>
Subject: [PATCH bpf 4/6] tools: bpftool: fix format string for p_err() in query_flow_dissector()
Date:   Thu, 15 Aug 2019 15:32:18 +0100
Message-Id: <20190815143220.4199-5-quentin.monnet@netronome.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190815143220.4199-1-quentin.monnet@netronome.com>
References: <20190815143220.4199-1-quentin.monnet@netronome.com>
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The format string passed to one call to the p_err() function in
query_flow_dissector() does not match the value that should be printed,
resulting in some garbage integer being printed instead of
strerror(errno) if /proc/self/ns/net cannot be open. Let's fix the
format string.

Fixes: 7f0c57fec80f ("bpftool: show flow_dissector attachment status")
Signed-off-by: Quentin Monnet <quentin.monnet@netronome.com>
Reviewed-by: Jakub Kicinski <jakub.kicinski@netronome.com>
---
 tools/bpf/bpftool/net.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/bpf/bpftool/net.c b/tools/bpf/bpftool/net.c
index 67e99c56bc88..e3b770082a39 100644
--- a/tools/bpf/bpftool/net.c
+++ b/tools/bpf/bpftool/net.c
@@ -197,7 +197,7 @@ static int query_flow_dissector(struct bpf_attach_info *attach_info)
 
 	fd = open("/proc/self/ns/net", O_RDONLY);
 	if (fd < 0) {
-		p_err("can't open /proc/self/ns/net: %d",
+		p_err("can't open /proc/self/ns/net: %s",
 		      strerror(errno));
 		return -1;
 	}
-- 
2.17.1

