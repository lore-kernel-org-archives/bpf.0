Return-Path: <SRS0=J20p=SM=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E68D5C10F11
	for <bpf@archiver.kernel.org>; Wed, 10 Apr 2019 19:51:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B851820830
	for <bpf@archiver.kernel.org>; Wed, 10 Apr 2019 19:51:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="NFBDMKjT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726106AbfDJTvT (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 10 Apr 2019 15:51:19 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:40350 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726732AbfDJTux (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 10 Apr 2019 15:50:53 -0400
Received: by mail-wm1-f68.google.com with SMTP id z24so3917539wmi.5
        for <bpf@vger.kernel.org>; Wed, 10 Apr 2019 12:50:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=IovskK9UbwdYQWplzamPYQOHiU5bdz12oNCeyO+ZAtU=;
        b=NFBDMKjTmrBU7RXCjrdZC9VqzwdbLmTIssSxwtNKOMjmLgWDleSVeKTaLOr2F79b2T
         k6dd7dRhwqhlbkFSU3qfd36rVNRXzHueXOyVWaqCTw23dwRjktkNGirMt8YUVTOjht5v
         yjG4U0I/qUZ1UzBvjOQ4Ia7plVVmxYG0CSj4D8qnwWutDrw/SBLCdIjRMMhN5WJBJKYF
         h2HSsaYFU4MBQDZELm9APItUt8OvJHnsWjTeYW1KYPOIh6Drii+xGWOjXFB0WU8SBSu9
         AMvzm1oMMWCAqe9pFQhAQDu8RZdHajcA5WiTOon7sWQU0pFoIGrQG+B70mrqc/Y6MIfL
         prpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=IovskK9UbwdYQWplzamPYQOHiU5bdz12oNCeyO+ZAtU=;
        b=hEN+HQPX2+1VD7s1Q+M9URavDH8c6yRyiPmsyU/+JQEi0N/4RGL/AVygPMlqmnmb7q
         EOXU3HWIX7vlDaKDni32e3aonGGEZPSaOOyvrSuw+eVRf4khPBPaLRu0HrRZOLtFwidC
         7zcYeViyMowUOz9f4aRKFUQvDn2V1Gq/6wPvDzacVRCfTk95Lv3H0EXJLIGAxEmhX1/u
         yhfaMW4X0vQOI1MZJHfOzR/uk4MEO/tlAol3upk/b1CGA4I7B5BwDJV/t2Hen0Okftb+
         fG9hR11VTrrLV20u41VvTVO6475Hr4Z1kofMAU5l1i7akPkrong2MsO4fbmn4D8T5POL
         WvHA==
X-Gm-Message-State: APjAAAWHBdtGmdAiu+0E+0SCJpAb6mWqY8epIKWSRa3eJCa8kFG2OWSy
        5Ue5UUoc9F7/K39CkBTVLtObQsG+0ng=
X-Google-Smtp-Source: APXvYqyQuF15w1jbY2lUQIAGrXCZRlZ60ryAc6TeR0cgoHZWJWaqu5W+55/l+NCaSRg65w5ITi8oBg==
X-Received: by 2002:a1c:9ad6:: with SMTP id c205mr4142916wme.46.1554925852002;
        Wed, 10 Apr 2019 12:50:52 -0700 (PDT)
Received: from cbtest28.netronome.com ([217.38.71.146])
        by smtp.gmail.com with ESMTPSA id 4sm2288540wmg.12.2019.04.10.12.50.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 10 Apr 2019 12:50:51 -0700 (PDT)
From:   Jiong Wang <jiong.wang@netronome.com>
To:     alexei.starovoitov@gmail.com, daniel@iogearbox.net
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org,
        oss-drivers@netronome.com, Jiong Wang <jiong.wang@netronome.com>
Subject: [PATCH/RFC v2 bpf-next 11/19] libbpf: new global variable "libbpf_test_mode"
Date:   Wed, 10 Apr 2019 20:50:25 +0100
Message-Id: <1554925833-7333-12-git-send-email-jiong.wang@netronome.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1554925833-7333-1-git-send-email-jiong.wang@netronome.com>
References: <1554925833-7333-1-git-send-email-jiong.wang@netronome.com>
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Enable BPF_F_TEST_RND_HI32 for all existing bpf selftests or other
independent tests could involve quite a few changes to make sure all bpf
prog load places has BPF_F_TEST_RND_HI32 set.

Given most of the tests are using libbpf, this patch introduces a new
global variable "libbpf_test_mode" into libbpf, once which is set, all bpf
prog load issued through libbpf will have BPF_F_TEST_RND_HI32 set
automatically, this could minimize changes required from testsuite.

The other way might be introducing new load function like
"bpf_prog_test_load", which will set BPF_F_TEST_RND_HI32. But there are
several prog load APIs, and we need minor changes on some parameters.

The global variable approach seems to be a proper first step for easy
testsuite porting.

Signed-off-by: Jiong Wang <jiong.wang@netronome.com>
---
 tools/lib/bpf/bpf.c      | 4 ++++
 tools/lib/bpf/libbpf.c   | 2 ++
 tools/lib/bpf/libbpf.h   | 2 ++
 tools/lib/bpf/libbpf.map | 1 +
 4 files changed, 9 insertions(+)

diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
index dababce..0795a85 100644
--- a/tools/lib/bpf/bpf.c
+++ b/tools/lib/bpf/bpf.c
@@ -254,6 +254,8 @@ int bpf_load_program_xattr(const struct bpf_load_program_attr *load_attr,
 	if (load_attr->name)
 		memcpy(attr.prog_name, load_attr->name,
 		       min(strlen(load_attr->name), BPF_OBJ_NAME_LEN - 1));
+	if (libbpf_test_mode)
+		attr.prog_flags |= BPF_F_TEST_RND_HI32;
 
 	fd = sys_bpf_prog_load(&attr, sizeof(attr));
 	if (fd >= 0)
@@ -350,6 +352,8 @@ int bpf_verify_program(enum bpf_prog_type type, const struct bpf_insn *insns,
 	log_buf[0] = 0;
 	attr.kern_version = kern_version;
 	attr.prog_flags = prog_flags;
+	if (libbpf_test_mode)
+		attr.prog_flags |= BPF_F_TEST_RND_HI32;
 
 	return sys_bpf_prog_load(&attr, sizeof(attr));
 }
diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index e2a457e..606643f 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -45,6 +45,8 @@
 #include "str_error.h"
 #include "libbpf_util.h"
 
+bool libbpf_test_mode;
+
 #ifndef EM_BPF
 #define EM_BPF 247
 #endif
diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index c5ff005..b40de66 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -447,6 +447,8 @@ bpf_program__bpil_addr_to_offs(struct bpf_prog_info_linear *info_linear);
 LIBBPF_API void
 bpf_program__bpil_offs_to_addr(struct bpf_prog_info_linear *info_linear);
 
+LIBBPF_API extern bool libbpf_test_mode;
+
 #ifdef __cplusplus
 } /* extern "C" */
 #endif
diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
index 6730017..5854e0b 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -156,6 +156,7 @@ LIBBPF_0.0.2 {
 		bpf_program__get_prog_info_linear;
 		bpf_program__bpil_addr_to_offs;
 		bpf_program__bpil_offs_to_addr;
+		libbpf_test_mode;
 } LIBBPF_0.0.1;
 
 LIBBPF_0.0.3 {
-- 
2.7.4

