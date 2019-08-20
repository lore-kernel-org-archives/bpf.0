Return-Path: <SRS0=Y+lb=WQ=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1C7BC3A59D
	for <bpf@archiver.kernel.org>; Tue, 20 Aug 2019 09:32:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8E8922CF9
	for <bpf@archiver.kernel.org>; Tue, 20 Aug 2019 09:32:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="YI8oZp1K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729458AbfHTJcP (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 20 Aug 2019 05:32:15 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:35706 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729469AbfHTJcN (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 20 Aug 2019 05:32:13 -0400
Received: by mail-wm1-f67.google.com with SMTP id l2so2025396wmg.0
        for <bpf@vger.kernel.org>; Tue, 20 Aug 2019 02:32:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=pjQJTm51JkN1A78/vK4czcd3hJPplZhrhZWA1hkQGDk=;
        b=YI8oZp1KNEADrGQzs3cVCzDFZVHS6CubNpFCu/+sao75g8+BYMAoqXZs1V/tdzRbqu
         yHb+hQrb21jKhYVGSxXdm0uQOixo83mDJa4whEXhjif3d+4BCCoMfGn84EJGvuix3vvk
         mWKkc2cebuAFhk4pyZ5uxiG2DENcGvxqNCH5GdkhPL7vH5TRz15NKoZ2uO8nNNKr2Nbw
         ksiZfDVzZOWQRYxogf335RRAh29uehiUMIFhhV6Hivx7bAlORfzN4xpfhLFAUkJMjiL1
         aHd5m2VfzEfmH4jPRTUcBRnRyUx0B/mtkgZILv6laNoanz9pn6xRV42XDZTbe4e5+Z7h
         xKMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=pjQJTm51JkN1A78/vK4czcd3hJPplZhrhZWA1hkQGDk=;
        b=PrjvpNl2xjDSbkNXd44zOa2ZH/zB+UbYDmNaJd1LIBB2Z6mXKKByELRsnewmyCNq0s
         e2Psma6o3NXC/kBLtgeEsdsjFRLxHbosrhlqWRRdvRLk1s6CHP+P5TbBLzlpBsdUbJm3
         WsBXxoExEbnCIjOxFyJ+1XHOjG++mR5sRom0w620d5YNhZ8jq9dUdv6dfZkq7XbN5WLh
         fRWoziz8HFXHdBt0tKfCbVD915We4f/s8FDmBOKjpfTghXOmbPC4+4jPjnk6rC+8G2eg
         Z/POJdsS/EBi/0NFtNRlLekk5i/gg2NmYr6KnC/hVjzaO3nB0l6c6JUJ0Vxp0Gomvw54
         3NUQ==
X-Gm-Message-State: APjAAAXtgl0kmnSQ6A/jUbOhOf37EjXYrdPzGNTMEKBHqBkh3QonVYjH
        gqsUz5FN4xJHanbHJ5i31Gbpfw==
X-Google-Smtp-Source: APXvYqycU89JhrsIz1RtF0WtFBhU5Y749iJCFMyWW3NxS8A0T5cTwwgxNA1BUoyerZWJW8298Y3i6A==
X-Received: by 2002:a1c:f910:: with SMTP id x16mr7663957wmh.173.1566293531083;
        Tue, 20 Aug 2019 02:32:11 -0700 (PDT)
Received: from cbtest32.netronome.com ([217.38.71.146])
        by smtp.gmail.com with ESMTPSA id p9sm16128190wru.61.2019.08.20.02.32.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2019 02:32:10 -0700 (PDT)
From:   Quentin Monnet <quentin.monnet@netronome.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org,
        oss-drivers@netronome.com,
        Quentin Monnet <quentin.monnet@netronome.com>
Subject: [PATCH bpf-next v2 4/5] libbpf: add bpf_btf_get_next_id() to cycle through BTF objects
Date:   Tue, 20 Aug 2019 10:31:53 +0100
Message-Id: <20190820093154.14042-5-quentin.monnet@netronome.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190820093154.14042-1-quentin.monnet@netronome.com>
References: <20190820093154.14042-1-quentin.monnet@netronome.com>
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add an API function taking a BTF object id and providing the id of the
next BTF object in the kernel. This can be used to list all BTF objects
loaded on the system.

v2:
- Rebase on top of Andrii's changes regarding libbpf versioning.

Signed-off-by: Quentin Monnet <quentin.monnet@netronome.com>
Reviewed-by: Jakub Kicinski <jakub.kicinski@netronome.com>
---
 tools/lib/bpf/bpf.c      | 5 +++++
 tools/lib/bpf/bpf.h      | 1 +
 tools/lib/bpf/libbpf.map | 2 ++
 3 files changed, 8 insertions(+)

diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
index 1439e99c9be5..cbb933532981 100644
--- a/tools/lib/bpf/bpf.c
+++ b/tools/lib/bpf/bpf.c
@@ -593,6 +593,11 @@ int bpf_map_get_next_id(__u32 start_id, __u32 *next_id)
 	return bpf_obj_get_next_id(start_id, next_id, BPF_MAP_GET_NEXT_ID);
 }
 
+int bpf_btf_get_next_id(__u32 start_id, __u32 *next_id)
+{
+	return bpf_obj_get_next_id(start_id, next_id, BPF_BTF_GET_NEXT_ID);
+}
+
 int bpf_prog_get_fd_by_id(__u32 id)
 {
 	union bpf_attr attr;
diff --git a/tools/lib/bpf/bpf.h b/tools/lib/bpf/bpf.h
index ff42ca043dc8..0db01334740f 100644
--- a/tools/lib/bpf/bpf.h
+++ b/tools/lib/bpf/bpf.h
@@ -156,6 +156,7 @@ LIBBPF_API int bpf_prog_test_run(int prog_fd, int repeat, void *data,
 				 __u32 *retval, __u32 *duration);
 LIBBPF_API int bpf_prog_get_next_id(__u32 start_id, __u32 *next_id);
 LIBBPF_API int bpf_map_get_next_id(__u32 start_id, __u32 *next_id);
+LIBBPF_API int bpf_btf_get_next_id(__u32 start_id, __u32 *next_id);
 LIBBPF_API int bpf_prog_get_fd_by_id(__u32 id);
 LIBBPF_API int bpf_map_get_fd_by_id(__u32 id);
 LIBBPF_API int bpf_btf_get_fd_by_id(__u32 id);
diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
index 4e72df8e98ba..664ce8e7a60e 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -186,4 +186,6 @@ LIBBPF_0.0.4 {
 } LIBBPF_0.0.3;
 
 LIBBPF_0.0.5 {
+	global:
+		bpf_btf_get_next_id;
 } LIBBPF_0.0.4;
-- 
2.17.1

