Return-Path: <SRS0=PZ8U=UG=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_MED,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81D28C2BCA1
	for <bpf@archiver.kernel.org>; Fri,  7 Jun 2019 16:29:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57B322064A
	for <bpf@archiver.kernel.org>; Fri,  7 Jun 2019 16:29:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rxwkKtND"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730408AbfFGQ32 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 7 Jun 2019 12:29:28 -0400
Received: from mail-ot1-f73.google.com ([209.85.210.73]:43956 "EHLO
        mail-ot1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730603AbfFGQ31 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 7 Jun 2019 12:29:27 -0400
Received: by mail-ot1-f73.google.com with SMTP id w110so1166149otb.10
        for <bpf@vger.kernel.org>; Fri, 07 Jun 2019 09:29:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=0ex+jf4WI3a57ZiYgCgNt5mNaX06ZcrQdQFoME4eIzo=;
        b=rxwkKtNDkgEAyUoqkt2JY9y/nj3jvL9a3j16dr8OSfnDx6V90Uuo+z5g/pJmSxtCPX
         Q/+/w5B/xqp4UI56hlkRampJW91QLFCjQq5idSdtvtt3Pkt89lLuNGXCbtqKW4ImsH9l
         HsqTpLDdJ8Y/hb5US7s2wNnQnmZIn5OLKIxNhj9hV/S8hqgvnXmB9RhHFlAncUaVC/sp
         qf5NF+0XMhISa+tSgSCYjmyttWrlht4prmEXj5zJNL4I1LaKlyKc7262kKSkFE+hbW3D
         gf2QYN9iPbqnAAaC7nzsE1WSy79pa/Q6vPyVrUcWuKzywkFHNohypZlKxYYc56mb85G2
         T21A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=0ex+jf4WI3a57ZiYgCgNt5mNaX06ZcrQdQFoME4eIzo=;
        b=A1tGnVd3kUL1gfO0jsQ2Zt6Om01Ce357RbbmW9lYsQUaiN+NeDBjx2ETWNhdn4tyxR
         fo3cSHF+QF9xnJzZ0X1+nkGfOjZN10g/IwIRXwb4Nh0GEFIGqiW7EUbUwH+1xJZFhQ11
         5W87M8X+RlVgBr2ng1NWOUgBNx50S9FjPJEsjWFxJOAQDYp5ycUA5ELbCkOTgewIiDYC
         xje1NbMMfuiVTldzEL9rk3/DQMGDBsBJbaC1L1Af5v6CYg0RnrdHUJzYsAZIDpNUvUs+
         lGyj8bd/1ShsR5vOR8n4kXchy0UUJ4YcY1/AF9Gt9S9fZpIBXt7t0fNf42L3LE0bRt2o
         7Uqg==
X-Gm-Message-State: APjAAAVCiZHsIas/hk69l2g8jTsT9Y051ocZHKzT2d+SNtfuJauam18A
        8JZ+8+dgOwlaJ/wehApaKc33nAI=
X-Google-Smtp-Source: APXvYqy/qGHzUWHwIUzto6F/jzzUtZbPiSX6UuWVhkhrgWgtPGyhzJR5/thyDZdLCLzfiyUGiRq/Fkc=
X-Received: by 2002:aca:d40f:: with SMTP id l15mr4192865oig.61.1559924966546;
 Fri, 07 Jun 2019 09:29:26 -0700 (PDT)
Date:   Fri,  7 Jun 2019 09:29:14 -0700
In-Reply-To: <20190607162920.24546-1-sdf@google.com>
Message-Id: <20190607162920.24546-3-sdf@google.com>
Mime-Version: 1.0
References: <20190607162920.24546-1-sdf@google.com>
X-Mailer: git-send-email 2.22.0.rc1.311.g5d7573a151-goog
Subject: [PATCH bpf-next v3 2/8] bpf: sync bpf.h to tools/
From:   Stanislav Fomichev <sdf@google.com>
To:     netdev@vger.kernel.org, bpf@vger.kernel.org
Cc:     davem@davemloft.net, ast@kernel.org, daniel@iogearbox.net,
        Stanislav Fomichev <sdf@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Export new prog type and hook points to the libbpf.

Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 tools/include/uapi/linux/bpf.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 7c6aef253173..174136aa6906 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -170,6 +170,7 @@ enum bpf_prog_type {
 	BPF_PROG_TYPE_FLOW_DISSECTOR,
 	BPF_PROG_TYPE_CGROUP_SYSCTL,
 	BPF_PROG_TYPE_RAW_TRACEPOINT_WRITABLE,
+	BPF_PROG_TYPE_CGROUP_SOCKOPT,
 };
 
 enum bpf_attach_type {
@@ -192,6 +193,8 @@ enum bpf_attach_type {
 	BPF_LIRC_MODE2,
 	BPF_FLOW_DISSECTOR,
 	BPF_CGROUP_SYSCTL,
+	BPF_CGROUP_GETSOCKOPT,
+	BPF_CGROUP_SETSOCKOPT,
 	__MAX_BPF_ATTACH_TYPE
 };
 
@@ -3533,4 +3536,15 @@ struct bpf_sysctl {
 				 */
 };
 
+struct bpf_sockopt {
+	__bpf_md_ptr(struct bpf_sock *, sk);
+	__bpf_md_ptr(void *, optval);
+	__bpf_md_ptr(void *, optval_end);
+
+	__s32	level;
+	__s32	optname;
+
+	__u32	optlen;
+};
+
 #endif /* _UAPI__LINUX_BPF_H__ */
-- 
2.22.0.rc1.311.g5d7573a151-goog

