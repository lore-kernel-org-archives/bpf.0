Return-Path: <SRS0=V8Hm=SE=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74350C4360F
	for <bpf@archiver.kernel.org>; Tue,  2 Apr 2019 17:08:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43CF8205F4
	for <bpf@archiver.kernel.org>; Tue,  2 Apr 2019 17:08:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TXD3yUoC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731268AbfDBRIq (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 2 Apr 2019 13:08:46 -0400
Received: from mail-pg1-f201.google.com ([209.85.215.201]:34851 "EHLO
        mail-pg1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726558AbfDBRIp (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 2 Apr 2019 13:08:45 -0400
Received: by mail-pg1-f201.google.com with SMTP id e12so10349839pgh.2
        for <bpf@vger.kernel.org>; Tue, 02 Apr 2019 10:08:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=ST7qE5kPE/qWQqGOd7QqqCfQQ2smSUwp3RhaJ5Tj5YI=;
        b=TXD3yUoCQBA+wswDnHlvYrvWIuQ6F45igJI0IVqtzAn2DGAqpRFxnVUHZYzjBaTC3G
         OePGusPfPp9wArfFli2ZT13S5MxX8Rsj2Um8xy2Hz7qPy//O6jyy4WbBnrE9w9aA4n3V
         VcbnQW3FHjjsWvzMIvrnLI0ZLDd6PG8V4I3ltvMZgPRAAAjr7LZk8hPcazuxt93iJlWn
         +FG70GVx8Sp4YalJyudXyx9RLMZ8+PopRBlVi0/xXHnbnnlFai+cXOJE9sz2aFghVQ+n
         p16yFNZ9ufRQi/6n1KPA9FeUnSXruIwDiL64h07ZpEFDB1xKZvXracjUq/AMvXa2PqiA
         emMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ST7qE5kPE/qWQqGOd7QqqCfQQ2smSUwp3RhaJ5Tj5YI=;
        b=KRDzL7w7Hp0IDcG99k3s1inDku99GNAN1xo6mDcnvX7q6DI8IzXc6jKt9l/wZ2NRN7
         GdUTJE0QmGcDyztRjDqledFKXzTEhsy/5m13jPTtyRa05jXSMFVzCFX67Th+iJb0g3UN
         cjx2YTOxgoOJLUokFpjOe/vta6u+fbR8eJ6JBWICpv+0Hi5pCZuvzJVCypx+N+yPZLOh
         E4wkOFdNCskQXI63cCQdVWRRJYtv+A5CDt8v8x4oCxM/V5AF+try2PWIW7jhDkYLWmgx
         WKl4EAWQdkpPz+YGuDebGyimdSFNvad9KFT1g0DbbjtV+pN9wItZhuH1nX93lIACcWMn
         uglg==
X-Gm-Message-State: APjAAAU5jMeUUSxGMvaIy1eFLDvYmavvfo7yWWCWZozsGJyZSq5z6qiX
        2uPTqyHm/D8PCpWeHD8h726YH1I=
X-Google-Smtp-Source: APXvYqxIwPZgIEX5NjXKBU20SsUKfwFccyixDybgeyWfYQptxxWx3xkbRm1achT7lMPCJwr/rc0pu+0=
X-Received: by 2002:a17:902:324:: with SMTP id 33mr2054206pld.26.1554224924915;
 Tue, 02 Apr 2019 10:08:44 -0700 (PDT)
Date:   Tue,  2 Apr 2019 10:08:34 -0700
In-Reply-To: <20190402170835.30732-1-sdf@google.com>
Message-Id: <20190402170835.30732-4-sdf@google.com>
Mime-Version: 1.0
References: <20190402170835.30732-1-sdf@google.com>
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
Subject: [PATCH bpf-next 3/4] selftests: bpf: fix -Wformat-invalid-specifier
 for bpf_obj_id.c
From:   Stanislav Fomichev <sdf@google.com>
To:     netdev@vger.kernel.org, bpf@vger.kernel.org
Cc:     davem@davemloft.net, ast@kernel.org, daniel@iogearbox.net,
        Stanislav Fomichev <sdf@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Use standard C99 %zu for sizeof, not GCC's custom %Zu:
bpf_obj_id.c:76:48: warning: invalid conversion specifier 'Z'

Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 tools/testing/selftests/bpf/prog_tests/bpf_obj_id.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_obj_id.c b/tools/testing/selftests/bpf/prog_tests/bpf_obj_id.c
index a64f7a02139c..cb827383db4d 100644
--- a/tools/testing/selftests/bpf/prog_tests/bpf_obj_id.c
+++ b/tools/testing/selftests/bpf/prog_tests/bpf_obj_id.c
@@ -73,7 +73,7 @@ void test_bpf_obj_id(void)
 			  info_len != sizeof(struct bpf_map_info) ||
 			  strcmp((char *)map_infos[i].name, expected_map_name),
 			  "get-map-info(fd)",
-			  "err %d errno %d type %d(%d) info_len %u(%Zu) key_size %u value_size %u max_entries %u map_flags %X name %s(%s)\n",
+			  "err %d errno %d type %d(%d) info_len %u(%zu) key_size %u value_size %u max_entries %u map_flags %X name %s(%s)\n",
 			  err, errno,
 			  map_infos[i].type, BPF_MAP_TYPE_ARRAY,
 			  info_len, sizeof(struct bpf_map_info),
@@ -117,7 +117,7 @@ void test_bpf_obj_id(void)
 			  *(int *)(long)prog_infos[i].map_ids != map_infos[i].id ||
 			  strcmp((char *)prog_infos[i].name, expected_prog_name),
 			  "get-prog-info(fd)",
-			  "err %d errno %d i %d type %d(%d) info_len %u(%Zu) jit_enabled %d jited_prog_len %u xlated_prog_len %u jited_prog %d xlated_prog %d load_time %lu(%lu) uid %u(%u) nr_map_ids %u(%u) map_id %u(%u) name %s(%s)\n",
+			  "err %d errno %d i %d type %d(%d) info_len %u(%zu) jit_enabled %d jited_prog_len %u xlated_prog_len %u jited_prog %d xlated_prog %d load_time %lu(%lu) uid %u(%u) nr_map_ids %u(%u) map_id %u(%u) name %s(%s)\n",
 			  err, errno, i,
 			  prog_infos[i].type, BPF_PROG_TYPE_SOCKET_FILTER,
 			  info_len, sizeof(struct bpf_prog_info),
@@ -185,7 +185,7 @@ void test_bpf_obj_id(void)
 		      memcmp(&prog_info, &prog_infos[i], info_len) ||
 		      *(int *)(long)prog_info.map_ids != saved_map_id,
 		      "get-prog-info(next_id->fd)",
-		      "err %d errno %d info_len %u(%Zu) memcmp %d map_id %u(%u)\n",
+		      "err %d errno %d info_len %u(%zu) memcmp %d map_id %u(%u)\n",
 		      err, errno, info_len, sizeof(struct bpf_prog_info),
 		      memcmp(&prog_info, &prog_infos[i], info_len),
 		      *(int *)(long)prog_info.map_ids, saved_map_id);
@@ -231,7 +231,7 @@ void test_bpf_obj_id(void)
 		      memcmp(&map_info, &map_infos[i], info_len) ||
 		      array_value != array_magic_value,
 		      "check get-map-info(next_id->fd)",
-		      "err %d errno %d info_len %u(%Zu) memcmp %d array_value %llu(%llu)\n",
+		      "err %d errno %d info_len %u(%zu) memcmp %d array_value %llu(%llu)\n",
 		      err, errno, info_len, sizeof(struct bpf_map_info),
 		      memcmp(&map_info, &map_infos[i], info_len),
 		      array_value, array_magic_value);
-- 
2.21.0.392.gf8f6787159e-goog

