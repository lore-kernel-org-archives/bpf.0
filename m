Return-Path: <SRS0=PZ9s=5K=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2754C54FD0
	for <bpf@archiver.kernel.org>; Wed, 25 Mar 2020 16:20:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92BA5206F8
	for <bpf@archiver.kernel.org>; Wed, 25 Mar 2020 16:20:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TcyoCrt0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727849AbgCYQUa (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 25 Mar 2020 12:20:30 -0400
Received: from mail-pj1-f74.google.com ([209.85.216.74]:59032 "EHLO
        mail-pj1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727386AbgCYQUa (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 25 Mar 2020 12:20:30 -0400
Received: by mail-pj1-f74.google.com with SMTP id r42so2033833pjb.8
        for <bpf@vger.kernel.org>; Wed, 25 Mar 2020 09:20:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=L8WrV0ubLBVhUrQVvhvKwmhLQ6aP75RVQ6YI9PPorEw=;
        b=TcyoCrt0NVSJ8wdxpz8KW7p7AAF0Q7WEYHGhlNMWivo23oDK+9VguwbUpNHFkQDNY2
         gT1AQOFGvhgeOZu4mX3hOTAZnkQnad8of68/4f0UJTwtH9JTUYE5t1EddEwe9KtIKsbo
         rtQi8c+jttwAyhwOhBrvhLjHIwGp8BmH9ARNs6o6qiSIQevLcuMLpUA6DOrpy006i6Il
         kVWUVYkc8Uce+VMwYlZMCIVXr+uKnY1yCJds12v/ApBCyVJFngNm5sxrb8IKiBGnAG/v
         FZV1PX3ClAvav827YGihM0Cs/Df3HBiNWuK6lOfrZkNO3GCwtfzX44wgA45fK5N/vpU7
         Y/Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=L8WrV0ubLBVhUrQVvhvKwmhLQ6aP75RVQ6YI9PPorEw=;
        b=JM5WgNWDMIbeAam6a814vRVZyJI3BljyKkmo0TFo5SZdq82n9UXeGRewamNl4Nd9XJ
         kD3rQOQnQqFITJ7gDj9VyxsCLz4GyLECfQT55Xxps1ZijH63i5UrYuvnjjkatDmxG4W1
         onyddPgtmaOmmXmt4FiSCu1ZO3HntZoYYzYkyODYcpe9EHbSycW9VdrsB8tMsMgMFH8T
         lZZ/z12o4xJpIa6Nz245xcyNxbVJ3pdmCydTj4brLVErNsaiCC+eziua3TtRYugFp57p
         Xs/sAOI51r34cThAAt0QqDkdxR6odF1lZleAf3TckgtpktiZtM4aJ0ijJDS+i/9FUbD1
         iQiA==
X-Gm-Message-State: ANhLgQ1UBaLOZNHYiPzM2KdotHHDfRxmQXhiqkUEG0iRMEZ3AtvR3TTy
        OA8QlGJuPVLB2eBrPyFoYUM5F2o=
X-Google-Smtp-Source: ADFU+vtBt0rthx9Nk78rdX+dTUNDpmrQNNes7xYaBh+/UchHpyPIc2Z0lpbEjTO6OkwR3oz7PDjEwUg=
X-Received: by 2002:a17:90a:feb:: with SMTP id 98mr4661349pjz.72.1585153228811;
 Wed, 25 Mar 2020 09:20:28 -0700 (PDT)
Date:   Wed, 25 Mar 2020 09:20:26 -0700
Message-Id: <20200325162026.254799-1-sdf@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.25.1.696.g5e7596f4ac-goog
Subject: [PATCH bpf-next v2] libbpf: don't allocate 16M for log buffer by default
From:   Stanislav Fomichev <sdf@google.com>
To:     netdev@vger.kernel.org, bpf@vger.kernel.org
Cc:     davem@davemloft.net, ast@kernel.org, daniel@iogearbox.net,
        Stanislav Fomichev <sdf@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

For each prog/btf load we allocate and free 16 megs of verifier buffer.
On production systems it doesn't really make sense because the
programs/btf have gone through extensive testing and (mostly) guaranteed
to successfully load.

Let's assume successful case by default and skip buffer allocation
on the first try. If there is an error, start with BPF_LOG_BUF_SIZE
and double it on each ENOSPC iteration.

v2:
* Don't allocate the buffer at all on the first try (Andrii Nakryiko)

Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 tools/lib/bpf/btf.c    | 20 +++++++++++++++-----
 tools/lib/bpf/libbpf.c | 22 ++++++++++++++--------
 2 files changed, 29 insertions(+), 13 deletions(-)

diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
index 3d1c25fc97ae..bfef3d606b54 100644
--- a/tools/lib/bpf/btf.c
+++ b/tools/lib/bpf/btf.c
@@ -657,22 +657,32 @@ int btf__finalize_data(struct bpf_object *obj, struct btf *btf)
 
 int btf__load(struct btf *btf)
 {
-	__u32 log_buf_size = BPF_LOG_BUF_SIZE;
+	__u32 log_buf_size = 0;
 	char *log_buf = NULL;
 	int err = 0;
 
 	if (btf->fd >= 0)
 		return -EEXIST;
 
-	log_buf = malloc(log_buf_size);
-	if (!log_buf)
-		return -ENOMEM;
+retry_load:
+	if (log_buf_size) {
+		log_buf = malloc(log_buf_size);
+		if (!log_buf)
+			return -ENOMEM;
 
-	*log_buf = 0;
+		*log_buf = 0;
+	}
 
 	btf->fd = bpf_load_btf(btf->data, btf->data_size,
 			       log_buf, log_buf_size, false);
 	if (btf->fd < 0) {
+		if (!log_buf || errno == ENOSPC) {
+			log_buf_size = max((__u32)BPF_LOG_BUF_SIZE,
+					   log_buf_size << 1);
+			free(log_buf);
+			goto retry_load;
+		}
+
 		err = -errno;
 		pr_warn("Error loading BTF: %s(%d)\n", strerror(errno), errno);
 		if (*log_buf)
diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 085e41f9b68e..b2fd43a03708 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -4855,8 +4855,8 @@ load_program(struct bpf_program *prog, struct bpf_insn *insns, int insns_cnt,
 {
 	struct bpf_load_program_attr load_attr;
 	char *cp, errmsg[STRERR_BUFSIZE];
-	int log_buf_size = BPF_LOG_BUF_SIZE;
-	char *log_buf;
+	size_t log_buf_size = 0;
+	char *log_buf = NULL;
 	int btf_fd, ret;
 
 	if (!insns || !insns_cnt)
@@ -4896,22 +4896,28 @@ load_program(struct bpf_program *prog, struct bpf_insn *insns, int insns_cnt,
 	load_attr.prog_flags = prog->prog_flags;
 
 retry_load:
-	log_buf = malloc(log_buf_size);
-	if (!log_buf)
-		pr_warn("Alloc log buffer for bpf loader error, continue without log\n");
+	if (log_buf_size) {
+		log_buf = malloc(log_buf_size);
+		if (!log_buf)
+			pr_warn("Alloc log buffer for bpf loader error, continue without log\n");
+
+		*log_buf = 0;
+	}
 
 	ret = bpf_load_program_xattr(&load_attr, log_buf, log_buf_size);
 
 	if (ret >= 0) {
-		if (load_attr.log_level)
+		if (log_buf && load_attr.log_level)
 			pr_debug("verifier log:\n%s", log_buf);
 		*pfd = ret;
 		ret = 0;
 		goto out;
 	}
 
-	if (errno == ENOSPC) {
-		log_buf_size <<= 1;
+	if (!log_buf || errno == ENOSPC) {
+		log_buf_size = max((size_t)BPF_LOG_BUF_SIZE,
+				   log_buf_size << 1);
+
 		free(log_buf);
 		goto retry_load;
 	}
-- 
2.25.1.696.g5e7596f4ac-goog

