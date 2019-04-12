Return-Path: <SRS0=9Oao=SO=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46FCAC10F13
	for <bpf@archiver.kernel.org>; Fri, 12 Apr 2019 03:03:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 193112084D
	for <bpf@archiver.kernel.org>; Fri, 12 Apr 2019 03:03:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726728AbfDLDDt (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 11 Apr 2019 23:03:49 -0400
Received: from mx2.suse.de ([195.135.220.15]:60910 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726640AbfDLDDt (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 11 Apr 2019 23:03:49 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 7506BABC3;
        Fri, 12 Apr 2019 03:03:47 +0000 (UTC)
From:   Benjamin Poirier <bpoirier@suse.com>
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org,
        David Ahern <dsahern@gmail.com>
Subject: [PATCH v2 bpf-next 1/2] bpftool: Use print_entry_error() in case of ENOENT when dumping
Date:   Fri, 12 Apr 2019 12:03:21 +0900
Message-Id: <20190412030322.15494-1-bpoirier@suse.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190411082700.26888-1-bpoirier@suse.com>
References: <20190411082700.26888-1-bpoirier@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Commit bf598a8f0f77 ("bpftool: Improve handling of ENOENT on map dumps")
used print_entry_plain() in case of ENOENT because that function provided
the desired formatting. However, that commit actually introduces dead code.
Per-cpu maps are zero-filled. When reading them, it's all or nothing. There
will never be a case where some cpus have an entry and others don't.

The truth is that ENOENT is an error case. So rework print_entry_error() to
provide the desired formatting.

Note that this commit changes the output format in case of errors other
than ENOENT.

example before:
key:
00 00 00 00
value:
No space left on device
[...]

example after:
key: 00 00 00 00
value:
No space left on device
[...]

The ENOENT case is unchanged:
key: 00 00 00 00  value: 14 5b 00 00 00 00 00 00
key: 01 00 00 00  value: <no entry>
[...]

Signed-off-by: Benjamin Poirier <bpoirier@suse.com>
---
 tools/bpf/bpftool/map.c | 34 ++++++++++++++--------------------
 1 file changed, 14 insertions(+), 20 deletions(-)

diff --git a/tools/bpf/bpftool/map.c b/tools/bpf/bpftool/map.c
index e96903078991..71840faaeab5 100644
--- a/tools/bpf/bpftool/map.c
+++ b/tools/bpf/bpftool/map.c
@@ -261,20 +261,19 @@ static void print_entry_json(struct bpf_map_info *info, unsigned char *key,
 }
 
 static void print_entry_error(struct bpf_map_info *info, unsigned char *key,
-			      const char *value)
+			      const char *value, bool single_line)
 {
-	int value_size = strlen(value);
-	bool single_line, break_names;
+	bool break_names;
 
-	break_names = info->key_size > 16 || value_size > 16;
-	single_line = info->key_size + value_size <= 24 && !break_names;
+	break_names = info->key_size > 16;
+	single_line = single_line && !break_names;
 
 	printf("key:%c", break_names ? '\n' : ' ');
 	fprint_hex(stdout, key, info->key_size, " ");
 
 	printf(single_line ? "  " : "\n");
 
-	printf("value:%c%s", break_names ? '\n' : ' ', value);
+	printf("value:%c%s", single_line ? ' ' : '\n', value);
 
 	printf("\n");
 }
@@ -298,11 +297,7 @@ static void print_entry_plain(struct bpf_map_info *info, unsigned char *key,
 
 		if (info->value_size) {
 			printf("value:%c", break_names ? '\n' : ' ');
-			if (value)
-				fprint_hex(stdout, value, info->value_size,
-					   " ");
-			else
-				printf("<no entry>");
+			fprint_hex(stdout, value, info->value_size, " ");
 		}
 
 		printf("\n");
@@ -321,11 +316,8 @@ static void print_entry_plain(struct bpf_map_info *info, unsigned char *key,
 			for (i = 0; i < n; i++) {
 				printf("value (CPU %02d):%c",
 				       i, info->value_size > 16 ? '\n' : ' ');
-				if (value)
-					fprint_hex(stdout, value + i * step,
-						   info->value_size, " ");
-				else
-					printf("<no entry>");
+				fprint_hex(stdout, value + i * step,
+					   info->value_size, " ");
 				printf("\n");
 			}
 		}
@@ -722,11 +714,13 @@ static int dump_map_elem(int fd, void *key, void *value,
 		jsonw_string_field(json_wtr, "error", strerror(lookup_errno));
 		jsonw_end_object(json_wtr);
 	} else {
+		const char *msg = NULL;
+
 		if (errno == ENOENT)
-			print_entry_plain(map_info, key, NULL);
-		else
-			print_entry_error(map_info, key,
-					  strerror(lookup_errno));
+			msg = "<no entry>";
+
+		print_entry_error(map_info, key,
+				  msg ? : strerror(lookup_errno), !!msg);
 	}
 
 	return 0;
-- 
2.21.0

