Return-Path: <SRS0=P9GS=RC=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B675AC43381
	for <bpf@archiver.kernel.org>; Wed, 27 Feb 2019 23:31:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 819D221850
	for <bpf@archiver.kernel.org>; Wed, 27 Feb 2019 23:31:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="TOWcaj1C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730465AbfB0XbJ (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 27 Feb 2019 18:31:09 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:33557 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729412AbfB0XbI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 27 Feb 2019 18:31:08 -0500
Received: by mail-qk1-f194.google.com with SMTP id x9so11037711qkf.0
        for <bpf@vger.kernel.org>; Wed, 27 Feb 2019 15:31:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Tfvf7ascZOwhjWpAuwm+p9dnMIZ3cUDU0mZgyHPWDxo=;
        b=TOWcaj1CKqS4goPrRNWTZ0hR0N5X1RHca3KLd5H0pxC5AI+bgtZRKCOjtaAK0z30iD
         QNNVb0BM5GYh0O7X3HWcSbZcCRuiWJL0j0rzWN0ACIAC1LG+/cepoYjD68BSI+RJ6p9o
         hsBvwMIFRAjEG6K+bytNU3ZzHCfbPnTM7HgYuswvE2M3pjGbzUF+jH6dT/Nnvc8YYtI9
         tPlqKbQhXFQOiP26lJwyOpTUtGisZrdJF+WuQ1bWsbtY/MhIHu778btEe/T9P/6CDXKA
         XXY0zjFqraYj5erjoqvc1oH0MLuIjP9b1xg9RhSME/kJwj6LyGpqWRobZ/jSwWLWLLIy
         jA7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Tfvf7ascZOwhjWpAuwm+p9dnMIZ3cUDU0mZgyHPWDxo=;
        b=ECg/SUqj5OeJ9B3tht1WXxoBDbf3ioPRNFTiurRKjT/fOI8BqrCwGWzft561HVr87A
         iDCf4H89wjS0MYsKv+AIqLKlfKAQ8tVsSgZm0dx2ne9/xorXpGhOCzqKjkIWI3BrBuUu
         LPjZSTgH88UhjUhtgUdDvOB21ei5AZ9MRhatBRiDtTW9ZQYcm82i+s1m5aCfJhRg66CC
         JP2sdSrTmiU53FTos+vcHaYjbgmflE93aLqVuIhYrgnQWchIBQ8QJUGpPdA9NgIQGRr1
         zDfMghtkW99CW6OcmMKg7Gw035JAPSRS2d8U6HLopdguvhPdcP7iDmtpFNdaQPFPa2wQ
         43lw==
X-Gm-Message-State: APjAAAXWPmULt/B5t7Y/oSw2V4CgwWQiNUpRKAVv2OcBA0DDOVlkSM0z
        sOtMdgW0CgcjP7WOPiW0NzKxKw==
X-Google-Smtp-Source: APXvYqwcTxUAsNsyqV1iBm5RjijXZ2yG2ETJ9KxC5ydSzfxWYzsFK7j/QrMLOFaITDkzFAqZC02Jxw==
X-Received: by 2002:a37:68cc:: with SMTP id d195mr4167928qkc.309.1551310267383;
        Wed, 27 Feb 2019 15:31:07 -0800 (PST)
Received: from jkicinski-Precision-T1700.netronome.com ([66.60.152.14])
        by smtp.gmail.com with ESMTPSA id z28sm11509741qth.85.2019.02.27.15.31.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Feb 2019 15:31:06 -0800 (PST)
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     alexei.starovoitov@gmail.com, daniel@iogearbox.net
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org,
        oss-drivers@netronome.com,
        Jakub Kicinski <jakub.kicinski@netronome.com>
Subject: [PATCH bpf-next 1/5] samples: bpf: force IPv4 in ping
Date:   Wed, 27 Feb 2019 15:30:42 -0800
Message-Id: <20190227233046.11718-2-jakub.kicinski@netronome.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20190227233046.11718-1-jakub.kicinski@netronome.com>
References: <20190227233046.11718-1-jakub.kicinski@netronome.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

ping localhost may default of IPv6 on modern systems, but
samples are trying to only parse IPv4.  Force IPv4.

samples/bpf/tracex1_user.c doesn't interpret the packet so
we don't care which IP version will be used there.

Signed-off-by: Jakub Kicinski <jakub.kicinski@netronome.com>
Reviewed-by: Quentin Monnet <quentin.monnet@netronome.com>
---
 samples/bpf/sock_example.c | 2 +-
 samples/bpf/sockex1_user.c | 2 +-
 samples/bpf/sockex2_user.c | 2 +-
 samples/bpf/sockex3_user.c | 2 +-
 samples/bpf/tracex2_user.c | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/samples/bpf/sock_example.c b/samples/bpf/sock_example.c
index 60ec467c78ab..00aae1d33fca 100644
--- a/samples/bpf/sock_example.c
+++ b/samples/bpf/sock_example.c
@@ -99,7 +99,7 @@ int main(void)
 {
 	FILE *f;
 
-	f = popen("ping -c5 localhost", "r");
+	f = popen("ping -4 -c5 localhost", "r");
 	(void)f;
 
 	return test_sock();
diff --git a/samples/bpf/sockex1_user.c b/samples/bpf/sockex1_user.c
index 93ec01c56104..be8ba5686924 100644
--- a/samples/bpf/sockex1_user.c
+++ b/samples/bpf/sockex1_user.c
@@ -26,7 +26,7 @@ int main(int ac, char **argv)
 	assert(setsockopt(sock, SOL_SOCKET, SO_ATTACH_BPF, prog_fd,
 			  sizeof(prog_fd[0])) == 0);
 
-	f = popen("ping -c5 localhost", "r");
+	f = popen("ping -4 -c5 localhost", "r");
 	(void) f;
 
 	for (i = 0; i < 5; i++) {
diff --git a/samples/bpf/sockex2_user.c b/samples/bpf/sockex2_user.c
index 1d5c6e9a6d27..125ee6efc913 100644
--- a/samples/bpf/sockex2_user.c
+++ b/samples/bpf/sockex2_user.c
@@ -34,7 +34,7 @@ int main(int ac, char **argv)
 	assert(setsockopt(sock, SOL_SOCKET, SO_ATTACH_BPF, prog_fd,
 			  sizeof(prog_fd[0])) == 0);
 
-	f = popen("ping -c5 localhost", "r");
+	f = popen("ping -4 -c5 localhost", "r");
 	(void) f;
 
 	for (i = 0; i < 5; i++) {
diff --git a/samples/bpf/sockex3_user.c b/samples/bpf/sockex3_user.c
index 9d02e0404719..bbb1cd0666a9 100644
--- a/samples/bpf/sockex3_user.c
+++ b/samples/bpf/sockex3_user.c
@@ -58,7 +58,7 @@ int main(int argc, char **argv)
 			  sizeof(__u32)) == 0);
 
 	if (argc > 1)
-		f = popen("ping -c5 localhost", "r");
+		f = popen("ping -4 -c5 localhost", "r");
 	else
 		f = popen("netperf -l 4 localhost", "r");
 	(void) f;
diff --git a/samples/bpf/tracex2_user.c b/samples/bpf/tracex2_user.c
index 1a81e6a5c2ea..c9544a4ce61a 100644
--- a/samples/bpf/tracex2_user.c
+++ b/samples/bpf/tracex2_user.c
@@ -131,7 +131,7 @@ int main(int ac, char **argv)
 	signal(SIGTERM, int_exit);
 
 	/* start 'ping' in the background to have some kfree_skb events */
-	f = popen("ping -c5 localhost", "r");
+	f = popen("ping -4 -c5 localhost", "r");
 	(void) f;
 
 	/* start 'dd' in the background to have plenty of 'write' syscalls */
-- 
2.19.2

