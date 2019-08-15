Return-Path: <SRS0=AlFI=WL=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7B0AC3A59B
	for <bpf@archiver.kernel.org>; Thu, 15 Aug 2019 15:00:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D4E4208C2
	for <bpf@archiver.kernel.org>; Thu, 15 Aug 2019 15:00:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="KLl3BXkV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733300AbfHOPAg (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 15 Aug 2019 11:00:36 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46604 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733284AbfHOPAf (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 15 Aug 2019 11:00:35 -0400
Received: by mail-wr1-f65.google.com with SMTP id z1so2451540wru.13
        for <bpf@vger.kernel.org>; Thu, 15 Aug 2019 08:00:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=AMLCV3YzxdATq/4eGHOKLDLXG9C3cKBdYE1r3RyBJ+0=;
        b=KLl3BXkVBJpfnKeUU3H6k867vHag42Ex9+v9AEx81+dRf4yk4pCDSMXI+bLv93GQ81
         YtCbU1BWam10D8THgpjZXR/LgYcx1GTIWT1c/N3668Iw6UXjrIDmpyEG1gEtlX+1yOAK
         L4fHF2IcmUvRqEJ5P1Q+fyDcBe76wvE44/+62dqAsC2QP+nAHAK7wqKwGh6R1G3B9KLz
         zg9m9do2LUWKjsGRXIBl1Xchoz8CqW9XOcw7tdO6JI1FrNEq6c7zuGtArtmsYVm3fGxS
         XicoR/oDCXCSbYusITcT+8dk7Qcl872DXn7X/YyYS8CrT3obFSl0uvDvDXnV5BWipkx+
         SqGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=AMLCV3YzxdATq/4eGHOKLDLXG9C3cKBdYE1r3RyBJ+0=;
        b=VOkHO5UIW14itxIdj88EF8TBihj6enhE/y7CByzZQh+oVzSRQE6/ehdJ+mVbkE+N2N
         BUHxe5ZRIfP7eUGZ7SIdSYbC13CQbNYvY9uSqt8yDQDFgRYo7ziqciftTbPgpS2JoqQO
         U7IuPazMXi9Wdf+m/oO5wmxdnI4t4rGZz+Cgqg+COmizsSCAky5xbo0O8/mGS8xnBrKj
         Al2u/oSXZpJvUH8eOYP4OnHkBA8Qcg42EVEDkZbrMbqzv7h6rWMTwH2B2syOI7w0cO6/
         yg8XG6tdzueERKiiJQo6Av/k7iJ7kl4yZ28lQ1+JHEaEcH573OIveS2QI7/8wWYS8S6R
         3Hig==
X-Gm-Message-State: APjAAAW2vBp6e4ILWh6HwGQ5GCY3/McK49Es/YVkconjAu4vB1XBhzWL
        rs4YOP9A6RtNG5zZ3KPBvzb8Xg==
X-Google-Smtp-Source: APXvYqzSPMZMQ36wQTI/IEQUqZqLLwIv9BaYuThd3wcWPBg+IUtwvRQObrrPHz97lsiTdetQriR2Lw==
X-Received: by 2002:a5d:4a45:: with SMTP id v5mr5727220wrs.108.1565881233814;
        Thu, 15 Aug 2019 08:00:33 -0700 (PDT)
Received: from cbtest32.netronome.com ([217.38.71.146])
        by smtp.gmail.com with ESMTPSA id a23sm2794857wma.24.2019.08.15.08.00.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2019 08:00:33 -0700 (PDT)
From:   Quentin Monnet <quentin.monnet@netronome.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org,
        oss-drivers@netronome.com,
        Quentin Monnet <quentin.monnet@netronome.com>
Subject: [PATCH bpf-next 3/5] libbpf: refactor bpf_*_get_next_id() functions
Date:   Thu, 15 Aug 2019 16:00:17 +0100
Message-Id: <20190815150019.8523-4-quentin.monnet@netronome.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190815150019.8523-1-quentin.monnet@netronome.com>
References: <20190815150019.8523-1-quentin.monnet@netronome.com>
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

In preparation for the introduction of a similar function for retrieving
the id of the next BTF object, consolidate the code from
bpf_prog_get_next_id() and bpf_map_get_next_id() in libbpf.

Signed-off-by: Quentin Monnet <quentin.monnet@netronome.com>
Reviewed-by: Jakub Kicinski <jakub.kicinski@netronome.com>
---
 tools/lib/bpf/bpf.c | 21 ++++++++-------------
 1 file changed, 8 insertions(+), 13 deletions(-)

diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
index c7d7993c44bb..1439e99c9be5 100644
--- a/tools/lib/bpf/bpf.c
+++ b/tools/lib/bpf/bpf.c
@@ -568,7 +568,7 @@ int bpf_prog_test_run_xattr(struct bpf_prog_test_run_attr *test_attr)
 	return ret;
 }
 
-int bpf_prog_get_next_id(__u32 start_id, __u32 *next_id)
+static int bpf_obj_get_next_id(__u32 start_id, __u32 *next_id, int cmd)
 {
 	union bpf_attr attr;
 	int err;
@@ -576,26 +576,21 @@ int bpf_prog_get_next_id(__u32 start_id, __u32 *next_id)
 	memset(&attr, 0, sizeof(attr));
 	attr.start_id = start_id;
 
-	err = sys_bpf(BPF_PROG_GET_NEXT_ID, &attr, sizeof(attr));
+	err = sys_bpf(cmd, &attr, sizeof(attr));
 	if (!err)
 		*next_id = attr.next_id;
 
 	return err;
 }
 
-int bpf_map_get_next_id(__u32 start_id, __u32 *next_id)
+int bpf_prog_get_next_id(__u32 start_id, __u32 *next_id)
 {
-	union bpf_attr attr;
-	int err;
-
-	memset(&attr, 0, sizeof(attr));
-	attr.start_id = start_id;
-
-	err = sys_bpf(BPF_MAP_GET_NEXT_ID, &attr, sizeof(attr));
-	if (!err)
-		*next_id = attr.next_id;
+	return bpf_obj_get_next_id(start_id, next_id, BPF_PROG_GET_NEXT_ID);
+}
 
-	return err;
+int bpf_map_get_next_id(__u32 start_id, __u32 *next_id)
+{
+	return bpf_obj_get_next_id(start_id, next_id, BPF_MAP_GET_NEXT_ID);
 }
 
 int bpf_prog_get_fd_by_id(__u32 id)
-- 
2.17.1

