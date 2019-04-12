Return-Path: <SRS0=9Oao=SO=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DE15C282CE
	for <bpf@archiver.kernel.org>; Fri, 12 Apr 2019 13:30:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC13B2171F
	for <bpf@archiver.kernel.org>; Fri, 12 Apr 2019 13:30:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="jaSmciI1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726993AbfDLNaB (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 12 Apr 2019 09:30:01 -0400
Received: from mail-wm1-f42.google.com ([209.85.128.42]:35383 "EHLO
        mail-wm1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726988AbfDLNaA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 12 Apr 2019 09:30:00 -0400
Received: by mail-wm1-f42.google.com with SMTP id y197so11059683wmd.0
        for <bpf@vger.kernel.org>; Fri, 12 Apr 2019 06:29:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=wC/Jt2pDXCxtfVNqONNt66tS/LprRc4R6xXfrfTc3Hk=;
        b=jaSmciI1pOAFQBfGKhT1N7ZmVFU4+4OJ1kqVyw7fgAWz1nc3GsJYIudKhvK1ehek5T
         kY7Hk3w0DGuBcfKGdcVgxU6kfrh4xxM3VdthZz4e+PmdZcU4sDuTR74iyj8KOzSMViyV
         PPP+OhPfUPtpsjBJgTtCaYUDRIvMvaVynVJ+VIeqKApZsF8IXApLcu7FeZOPuk3AtfWS
         ZZPEkayg3EtQl1RHeFnWZyoVNJh6c/7Ia8WdAfkgD8rStplu+7rci8fgE9wmf/x08viY
         kZNeRTgWBLE/kMEviom2w/mvcK6NmQXawi8iIaTlA0c6NhI2egFdRSx6PFTzPuSOWXr0
         1tWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=wC/Jt2pDXCxtfVNqONNt66tS/LprRc4R6xXfrfTc3Hk=;
        b=V/6e/SfVHsSr44Er7KRXAo9rZ1XLxWiwvzepJV7bDkiOlsspPEE+k4kwKpFmTGf6cS
         rJca3Jxuo1WWm9QGkqJydTd6Eek1HgOqQFL6/LZK4bFbUAqkc+1ve+ybK6W4SgNfs365
         9OJVN1npbkgmTgSJlNiboFhc0JMCQ8hBbuOR/4J0WBt5AwXDDUS4nNVHdQ5X+q6IXhRm
         8yx7r1b8gdgoVTIhFvTMUFnRLwS9O86hLhJ/TZqlW/+8wyKdXgoh9iKTdjuEYzPjvKbv
         Fdf1kvxOsxjmVymfMIfKHBJFbOgdZsNv4xYthqkrWBnlDUIv0NQd1EWJpOfwweISvPah
         xgOg==
X-Gm-Message-State: APjAAAU8J1hqh7d4n9sn9BhBct4Fjf/5G0IthdpahfHtINeOKtMvzyvG
        WifmowrDC2UjFjZadrAH/84yrQ==
X-Google-Smtp-Source: APXvYqyUEK9lrH3JqfPPjXBg4Ul/bXsexZXo5nCuaWDgL/tjeh6W603/TUGVdW9x+59Y+m9yEEHFnA==
X-Received: by 2002:a05:600c:220b:: with SMTP id z11mr10903197wml.73.1555075797790;
        Fri, 12 Apr 2019 06:29:57 -0700 (PDT)
Received: from cbtest32.netronome.com ([217.38.71.146])
        by smtp.gmail.com with ESMTPSA id v184sm15752915wma.6.2019.04.12.06.29.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Apr 2019 06:29:56 -0700 (PDT)
From:   Quentin Monnet <quentin.monnet@netronome.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org,
        oss-drivers@netronome.com,
        Quentin Monnet <quentin.monnet@netronome.com>
Subject: [PATCH bpf-next 4/5] tools: bpftool: fix short option name for printing version in man pages
Date:   Fri, 12 Apr 2019 14:29:37 +0100
Message-Id: <20190412132938.9044-5-quentin.monnet@netronome.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190412132938.9044-1-quentin.monnet@netronome.com>
References: <20190412132938.9044-1-quentin.monnet@netronome.com>
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Manual pages would tell that option "-v" (lower case) would print the
version number for bpftool. This is wrong: the short name of the option
is "-V" (upper case). Fix the documentation accordingly.

Signed-off-by: Quentin Monnet <quentin.monnet@netronome.com>
Reviewed-by: Jakub Kicinski <jakub.kicinski@netronome.com>
---
 tools/bpf/bpftool/Documentation/bpftool-cgroup.rst  | 2 +-
 tools/bpf/bpftool/Documentation/bpftool-feature.rst | 2 +-
 tools/bpf/bpftool/Documentation/bpftool-map.rst     | 2 +-
 tools/bpf/bpftool/Documentation/bpftool-net.rst     | 2 +-
 tools/bpf/bpftool/Documentation/bpftool-perf.rst    | 2 +-
 tools/bpf/bpftool/Documentation/bpftool-prog.rst    | 2 +-
 tools/bpf/bpftool/Documentation/bpftool.rst         | 2 +-
 7 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/tools/bpf/bpftool/Documentation/bpftool-cgroup.rst b/tools/bpf/bpftool/Documentation/bpftool-cgroup.rst
index 9bb9ace54ba8..5e3b7d9d7599 100644
--- a/tools/bpf/bpftool/Documentation/bpftool-cgroup.rst
+++ b/tools/bpf/bpftool/Documentation/bpftool-cgroup.rst
@@ -99,7 +99,7 @@ OPTIONS
 	-h, --help
 		  Print short generic help message (similar to **bpftool help**).
 
-	-v, --version
+	-V, --version
 		  Print version number (similar to **bpftool version**).
 
 	-j, --json
diff --git a/tools/bpf/bpftool/Documentation/bpftool-feature.rst b/tools/bpf/bpftool/Documentation/bpftool-feature.rst
index 82de03dd8f52..10177343b7ce 100644
--- a/tools/bpf/bpftool/Documentation/bpftool-feature.rst
+++ b/tools/bpf/bpftool/Documentation/bpftool-feature.rst
@@ -63,7 +63,7 @@ OPTIONS
 	-h, --help
 		  Print short generic help message (similar to **bpftool help**).
 
-	-v, --version
+	-V, --version
 		  Print version number (similar to **bpftool version**).
 
 	-j, --json
diff --git a/tools/bpf/bpftool/Documentation/bpftool-map.rst b/tools/bpf/bpftool/Documentation/bpftool-map.rst
index 5c984ffc9f01..55ecf80ca03e 100644
--- a/tools/bpf/bpftool/Documentation/bpftool-map.rst
+++ b/tools/bpf/bpftool/Documentation/bpftool-map.rst
@@ -135,7 +135,7 @@ OPTIONS
 	-h, --help
 		  Print short generic help message (similar to **bpftool help**).
 
-	-v, --version
+	-V, --version
 		  Print version number (similar to **bpftool version**).
 
 	-j, --json
diff --git a/tools/bpf/bpftool/Documentation/bpftool-net.rst b/tools/bpf/bpftool/Documentation/bpftool-net.rst
index 779dab3650ee..6b692b428373 100644
--- a/tools/bpf/bpftool/Documentation/bpftool-net.rst
+++ b/tools/bpf/bpftool/Documentation/bpftool-net.rst
@@ -55,7 +55,7 @@ OPTIONS
 	-h, --help
 		  Print short generic help message (similar to **bpftool help**).
 
-	-v, --version
+	-V, --version
 		  Print version number (similar to **bpftool version**).
 
 	-j, --json
diff --git a/tools/bpf/bpftool/Documentation/bpftool-perf.rst b/tools/bpf/bpftool/Documentation/bpftool-perf.rst
index bca5590a80d0..86154740fabb 100644
--- a/tools/bpf/bpftool/Documentation/bpftool-perf.rst
+++ b/tools/bpf/bpftool/Documentation/bpftool-perf.rst
@@ -43,7 +43,7 @@ OPTIONS
 	-h, --help
 		  Print short generic help message (similar to **bpftool help**).
 
-	-v, --version
+	-V, --version
 		  Print version number (similar to **bpftool version**).
 
 	-j, --json
diff --git a/tools/bpf/bpftool/Documentation/bpftool-prog.rst b/tools/bpf/bpftool/Documentation/bpftool-prog.rst
index 49c33939239f..f2beb79a77e7 100644
--- a/tools/bpf/bpftool/Documentation/bpftool-prog.rst
+++ b/tools/bpf/bpftool/Documentation/bpftool-prog.rst
@@ -144,7 +144,7 @@ OPTIONS
 	-h, --help
 		  Print short generic help message (similar to **bpftool help**).
 
-	-v, --version
+	-V, --version
 		  Print version number (similar to **bpftool version**).
 
 	-j, --json
diff --git a/tools/bpf/bpftool/Documentation/bpftool.rst b/tools/bpf/bpftool/Documentation/bpftool.rst
index 4f2188845dd8..deb2ca911ddf 100644
--- a/tools/bpf/bpftool/Documentation/bpftool.rst
+++ b/tools/bpf/bpftool/Documentation/bpftool.rst
@@ -49,7 +49,7 @@ OPTIONS
 	-h, --help
 		  Print short help message (similar to **bpftool help**).
 
-	-v, --version
+	-V, --version
 		  Print version number (similar to **bpftool version**).
 
 	-j, --json
-- 
2.17.1

