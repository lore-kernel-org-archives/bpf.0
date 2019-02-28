Return-Path: <SRS0=vk/n=RD=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EAE0C00319
	for <bpf@archiver.kernel.org>; Thu, 28 Feb 2019 03:04:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F275C218A5
	for <bpf@archiver.kernel.org>; Thu, 28 Feb 2019 03:04:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="fw7qeXft"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730530AbfB1DEa (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 27 Feb 2019 22:04:30 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:37187 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730131AbfB1DE3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 27 Feb 2019 22:04:29 -0500
Received: by mail-qt1-f195.google.com with SMTP id a48so21934884qtb.4
        for <bpf@vger.kernel.org>; Wed, 27 Feb 2019 19:04:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=W+nOJGMAEXMb/1TZUsm8T9lvdIvprh6xTiI6uw5BLzI=;
        b=fw7qeXftpFq8WsDQyTJvp91dNGIURsHh8etGwRG22xrSLxGgV2Elz7NVFiQTPZFyOM
         mdho5qN+eJMlL1VXkdC/2ckC98VsN/ZJJUYKwLVYuJ8LIGC6sBeHKo/yxowaWkjYiav+
         i0Ptp1PhR/YpuDME55y8IgIabrzB3EX/HL/WqNU9Yp7fOAYnDRdonlKGtO6+Q95euNkF
         GZqJfW9K1icGidcpzN7YGyRHctfVitsV8IR/yEhemy0rkUD3P4K8ZFDtpsPI/LiCkfsM
         8Rgpnb38oLB32YJEzYIx2iL20kydLaBCPdMjOZMDNgLMHTze7t+wVRX0MCPldgjfC9MY
         9KLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=W+nOJGMAEXMb/1TZUsm8T9lvdIvprh6xTiI6uw5BLzI=;
        b=FjhALcUdBeBCJ9nRUtqxyZbQjRwKsEeMv7l7C7KFZ1VXca/ZellouBx4m9K/TyfPQs
         i2dGCVzulwkG+OhsbDX2z6zdRlf0gMXQZAukvtOtkg2XRShyBHbGBBA1o6pXTo+r6hma
         DBJoIpjfYkL9j1/YDQDkCu7NV4iWCTaaf8ZvtipNGKuyGqVfGrisrErDjdtkYv7vRgQW
         y52Xr2hJ/cP30gJzr4adoxzvCTuE78ESUD0evUQE2ZZqkzJFVg3UVMXoqNBXrtuqNgDq
         fGD3eywvP18ODJTUmrU0B2EKZ4caduJ1BTX8jqA1egDusadkqKhWvGjeuUpLzq5Ubks+
         XNdw==
X-Gm-Message-State: APjAAAVjW2LIKgTLdpgL6HcF8Y+qLfM9Jb2dhL/2E7cTSnzVnuvf6pKf
        jqBZ9pELd2+Ng5boP1toY7B2Mg==
X-Google-Smtp-Source: APXvYqx/0YQWe0r8hYoHB3sRobPVy9Hsl7lftBgIkThj62HtGX9bJxV8Ud7Yuxri6oSSc/vIAwB8ug==
X-Received: by 2002:a0c:96c1:: with SMTP id b1mr4747487qvd.45.1551323068195;
        Wed, 27 Feb 2019 19:04:28 -0800 (PST)
Received: from jkicinski-Precision-T1700.netronome.com ([66.60.152.14])
        by smtp.gmail.com with ESMTPSA id r44sm11242066qtb.53.2019.02.27.19.04.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Feb 2019 19:04:27 -0800 (PST)
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     alexei.starovoitov@gmail.com, daniel@iogearbox.net
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org,
        oss-drivers@netronome.com,
        Jakub Kicinski <jakub.kicinski@netronome.com>
Subject: [PATCH bpf-next v2 1/5] samples: bpf: force IPv4 in ping
Date:   Wed, 27 Feb 2019 19:04:10 -0800
Message-Id: <20190228030414.18973-2-jakub.kicinski@netronome.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20190228030414.18973-1-jakub.kicinski@netronome.com>
References: <20190228030414.18973-1-jakub.kicinski@netronome.com>
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
Acked-by: Andrii Nakryiko <andriin@fb.com>
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

