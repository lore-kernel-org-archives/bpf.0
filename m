Return-Path: <SRS0=9Oao=SO=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9EE5C282CE
	for <bpf@archiver.kernel.org>; Fri, 12 Apr 2019 22:00:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5D042084D
	for <bpf@archiver.kernel.org>; Fri, 12 Apr 2019 22:00:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="As6J63d8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727331AbfDLWAi (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 12 Apr 2019 18:00:38 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33388 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727245AbfDLWAP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 12 Apr 2019 18:00:15 -0400
Received: by mail-wr1-f68.google.com with SMTP id q1so13777136wrp.0
        for <bpf@vger.kernel.org>; Fri, 12 Apr 2019 15:00:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=33/0vLDNV+/fkdAJJtAOFzRJSQIBJATreCk8IP7/Y7g=;
        b=As6J63d8ugwdyObljS0PPYV0EnjNNkhhD8QpjYbzD50y0RivvBVWKZCwnty/QzQn8Q
         k3MXdLXXH4ZHC4tx0Frbl94xQoTEZeNeohp/9z5A3kPkrq28qYGDZc3asPClCkbTRF49
         LekKAOgwYvMGOJq7GUG4HiONbvFlzpYIEZz9kvSXb/TCX6qZL6I/pQ7M4P5TGdo14Vxo
         c4aB7/mSzJZ1wZZgpSvPq/c1wdFjqGC6UlokE5l3ZNmG/0Bx/4PQWlQ+4YlBaVBZbK7Z
         wSqfTRTVc47woqYO/FgDM1FfwB0TnVFhYrpfziBBnOTMesWQzwvzE62ezbMLKwXHatu7
         XLjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=33/0vLDNV+/fkdAJJtAOFzRJSQIBJATreCk8IP7/Y7g=;
        b=knB91DliqFyLMPxupxWNVo1Zo6mjxBYvmDcXjmPpzYaqlZ+o20njGYbxPYSGsT7euf
         7RCynXthNwWAP8wW8U6XH6pjY1m2qQaYGF2i6gtLEuENSrBUKdGuMw+/yAqUWpjGL+QV
         JdYZM2YG6cCbcIwmG1HSrS8hH2Dsfcvy0WEvYCk4EYUEKF38W9vR60o1ZPo2+BSBDPT6
         heDpWSg/7/LwVxMuTueP7+oRWcxhA1xmDlrujp8smlM9YJrPj4WNDZr9kEU+fxteBBI6
         aKttohU6SA1y6Hu9NrDGBj+sRqjbHc1/ROQkxJ5HAxSB+NbnnkO7pKb9qZRN6mKGhiTe
         fDVA==
X-Gm-Message-State: APjAAAVJB1H0zteq6scQsO967gKheQevysJjYrNzwvDeUWFuOACizX9D
        ij/efJ6h5i+P+ENfqT2KQr58RA==
X-Google-Smtp-Source: APXvYqzd1Efb/GBemCc+bWtHozRU0zvlJT+Mw0RxvPX+qFpZu8DXXsFZaQUd4R5UiYukyqidtygPfg==
X-Received: by 2002:a5d:4750:: with SMTP id o16mr34176244wrs.206.1555106414206;
        Fri, 12 Apr 2019 15:00:14 -0700 (PDT)
Received: from cbtest28.netronome.com ([217.38.71.146])
        by smtp.gmail.com with ESMTPSA id f1sm8490764wml.28.2019.04.12.15.00.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 12 Apr 2019 15:00:13 -0700 (PDT)
From:   Jiong Wang <jiong.wang@netronome.com>
To:     alexei.starovoitov@gmail.com, daniel@iogearbox.net
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org,
        oss-drivers@netronome.com, Jiong Wang <jiong.wang@netronome.com>
Subject: [PATCH v3 bpf-next 11/19] libbpf: add "prog_flags" to bpf_program/bpf_prog_load_attr/bpf_load_program_attr
Date:   Fri, 12 Apr 2019 22:59:44 +0100
Message-Id: <1555106392-20117-12-git-send-email-jiong.wang@netronome.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1555106392-20117-1-git-send-email-jiong.wang@netronome.com>
References: <1555106392-20117-1-git-send-email-jiong.wang@netronome.com>
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

libbpf doesn't allow passing "prog_flags" during bpf program load in a
couple of load related APIs, "bpf_load_program_xattr", "load_program" and
"bpf_prog_load_xattr".

It makes sense to allow passing "prog_flags" which is useful for
customizing program loading.

Signed-off-by: Jiong Wang <jiong.wang@netronome.com>
---
 tools/lib/bpf/bpf.c    | 1 +
 tools/lib/bpf/bpf.h    | 1 +
 tools/lib/bpf/libbpf.c | 3 +++
 tools/lib/bpf/libbpf.h | 1 +
 4 files changed, 6 insertions(+)

diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
index 955191c..f79ec49 100644
--- a/tools/lib/bpf/bpf.c
+++ b/tools/lib/bpf/bpf.c
@@ -254,6 +254,7 @@ int bpf_load_program_xattr(const struct bpf_load_program_attr *load_attr,
 	if (load_attr->name)
 		memcpy(attr.prog_name, load_attr->name,
 		       min(strlen(load_attr->name), BPF_OBJ_NAME_LEN - 1));
+	attr.prog_flags = load_attr->prog_flags;
 
 	fd = sys_bpf_prog_load(&attr, sizeof(attr));
 	if (fd >= 0)
diff --git a/tools/lib/bpf/bpf.h b/tools/lib/bpf/bpf.h
index bc30783..a983442 100644
--- a/tools/lib/bpf/bpf.h
+++ b/tools/lib/bpf/bpf.h
@@ -86,6 +86,7 @@ struct bpf_load_program_attr {
 	const void *line_info;
 	__u32 line_info_cnt;
 	__u32 log_level;
+	__u32 prog_flags;
 };
 
 /* Flags to direct loading requirements */
diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index e5b77ad..e0affd0 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -182,6 +182,7 @@ struct bpf_program {
 	void *line_info;
 	__u32 line_info_rec_size;
 	__u32 line_info_cnt;
+	__u32 prog_flags;
 };
 
 enum libbpf_map_type {
@@ -1876,6 +1877,7 @@ load_program(struct bpf_program *prog, struct bpf_insn *insns, int insns_cnt,
 	load_attr.line_info_rec_size = prog->line_info_rec_size;
 	load_attr.line_info_cnt = prog->line_info_cnt;
 	load_attr.log_level = prog->log_level;
+	load_attr.prog_flags = prog->prog_flags;
 	if (!load_attr.insns || !load_attr.insns_cnt)
 		return -EINVAL;
 
@@ -3320,6 +3322,7 @@ int bpf_prog_load_xattr(const struct bpf_prog_load_attr *attr,
 						      expected_attach_type);
 
 		prog->log_level = attr->log_level;
+		prog->prog_flags = attr->prog_flags;
 		if (!first_prog)
 			first_prog = prog;
 	}
diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index c5ff005..5abc237 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -320,6 +320,7 @@ struct bpf_prog_load_attr {
 	enum bpf_attach_type expected_attach_type;
 	int ifindex;
 	int log_level;
+	int prog_flags;
 };
 
 LIBBPF_API int bpf_prog_load_xattr(const struct bpf_prog_load_attr *attr,
-- 
2.7.4

