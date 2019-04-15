Return-Path: <SRS0=RZwz=SR=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B472EC282DA
	for <bpf@archiver.kernel.org>; Mon, 15 Apr 2019 17:27:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8622F20656
	for <bpf@archiver.kernel.org>; Mon, 15 Apr 2019 17:27:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="hgVYZkU1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727980AbfDOR0r (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 15 Apr 2019 13:26:47 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:36099 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727963AbfDOR0p (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 15 Apr 2019 13:26:45 -0400
Received: by mail-wr1-f67.google.com with SMTP id y13so23045831wrd.3
        for <bpf@vger.kernel.org>; Mon, 15 Apr 2019 10:26:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=MpCitH7OitwdS3gEZKicgK34bxZPlB54bkEREbm5EmI=;
        b=hgVYZkU1VQccgkXXo3AG63bkgg41x9wm9w2OorzWerLWjDFmbl+bi5iquy4xDNYeaU
         RZG3MfTQkVQgekOIy/Np3sqfnZnm5TkvvWNuuLz61VV9l653Ooqvrm6l1c6Kv7MQ6cJm
         gjADICaOsjJqyRDDaQd+0POrVTVDoimtaHRYGaFsT+SokNL8DrS0DuvXh+55C5J7FjOs
         6NdH6HX9eJeqLJ8RrZbWU2dJ+bstZ0qVW0wv9UMkhahSFzphORdqS5+vB8Gq+E9tWLkk
         J+pZ2Q13oxKKXciu/YdLQDANDBBiYqRc/7j2Fyj0k7A2Aj+mDIYHgrW7fUW3bQuORa7w
         n6qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=MpCitH7OitwdS3gEZKicgK34bxZPlB54bkEREbm5EmI=;
        b=pg/hmZvR78HZGxoy6t8HZ8c/zihKzi7w7KTqzZm1UsLUNcSfcaeFApz8Na2vMd6T5b
         z1recYafljUViqK6+aU3Kl7o/jJxaBaK4R5GoSYQchxIkR4XCk/0SR50ZcNf59fZyTrj
         oQ/6fr2uka02eMXwhCOdSTqVCu4X9cKi/qrZAJdXxMeWRe5iFrJ0k0kK3eOP91WsT6v8
         RmgWBbOh6ZsLbqNgYx1RqAdgtBfqFaZ+ALIoPPq7inqKuQU8Nx9IyK2pYBhRlqeAgWkh
         wll7rMH8xgTGJ6YRqknzdeNLzjWO/NCgnH4Mbii2Sjd/d1u6u1XviiqncPgdy4HbnwWT
         aqYw==
X-Gm-Message-State: APjAAAUgm211iOXQYS+axg0sh4FIuN5cfvJTyP6MgEfh71IYgD/0KkZI
        fSNpM2WI9347b1qyyAWmKaXstQ==
X-Google-Smtp-Source: APXvYqzSj0NqAivAVT89Q7Lh1tNCDtSzP5a4oPosEbgN7u38qYgEaAFA46urjcfT8gdtovRlC7pJCw==
X-Received: by 2002:adf:f102:: with SMTP id r2mr32977826wro.136.1555349204047;
        Mon, 15 Apr 2019 10:26:44 -0700 (PDT)
Received: from cbtest28.netronome.com ([217.38.71.146])
        by smtp.gmail.com with ESMTPSA id v190sm27094232wme.18.2019.04.15.10.26.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 15 Apr 2019 10:26:43 -0700 (PDT)
From:   Jiong Wang <jiong.wang@netronome.com>
To:     alexei.starovoitov@gmail.com, daniel@iogearbox.net
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org,
        oss-drivers@netronome.com, Jiong Wang <jiong.wang@netronome.com>
Subject: [PATCH v4 bpf-next 07/15] libbpf: add "prog_flags" to bpf_program/bpf_prog_load_attr/bpf_load_program_attr
Date:   Mon, 15 Apr 2019 18:26:17 +0100
Message-Id: <1555349185-12508-8-git-send-email-jiong.wang@netronome.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1555349185-12508-1-git-send-email-jiong.wang@netronome.com>
References: <1555349185-12508-1-git-send-email-jiong.wang@netronome.com>
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

libbpf doesn't allow passing "prog_flags" during bpf program load in a
couple of load related APIs, "bpf_load_program_xattr", "load_program" and
"bpf_prog_load_xattr".

It makes sense to allow passing "prog_flags" which is useful for
customizing program loading.

Reviewed-by: Jakub Kicinski <jakub.kicinski@netronome.com>
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

