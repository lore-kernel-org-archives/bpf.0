Return-Path: <SRS0=sRBR=SN=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B8FEC10F13
	for <bpf@archiver.kernel.org>; Thu, 11 Apr 2019 08:27:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 515A22083E
	for <bpf@archiver.kernel.org>; Thu, 11 Apr 2019 08:27:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726137AbfDKI1K (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 11 Apr 2019 04:27:10 -0400
Received: from mx2.suse.de ([195.135.220.15]:58992 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725793AbfDKI1K (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 11 Apr 2019 04:27:10 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 887CEAC69;
        Thu, 11 Apr 2019 08:27:09 +0000 (UTC)
From:   Benjamin Poirier <bpoirier@suse.com>
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org
Subject: [PATCH bpf-next] bpftool: Exit early when it's not possible to dump a REUSEPORT_SOCKARRAY map
Date:   Thu, 11 Apr 2019 17:27:00 +0900
Message-Id: <20190411082700.26888-1-bpoirier@suse.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

avoids outputting a series of
	value:
	No space left on device

The value itself is not wrong but bpf_fd_reuseport_array_lookup_elem() can
only return it if the map was created with value_size = 8. There's nothing
bpftool can do about it. Instead of repeating this error for every key in
the map, print the error once, print an explanatory message and exit.

Signed-off-by: Benjamin Poirier <bpoirier@suse.com>
---

Note that this will lead to a merge conflict if the patch "bpftool: Fix
errno variable usage" is merged in the bpf branch:

<<<<<<< HEAD
                if (lookup_errno == ENOENT)
=======
                if (errno == ENOENT) {
>>>>>>> bpf-next

The resolution should be trivial:
                if (lookup_errno == ENOENT) {

 tools/bpf/bpftool/map.c | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/tools/bpf/bpftool/map.c b/tools/bpf/bpftool/map.c
index e96903078991..bb648e42923c 100644
--- a/tools/bpf/bpftool/map.c
+++ b/tools/bpf/bpftool/map.c
@@ -684,7 +684,6 @@ static int dump_map_elem(int fd, void *key, void *value,
 			 struct bpf_map_info *map_info, struct btf *btf,
 			 json_writer_t *btf_wtr)
 {
-	int num_elems = 0;
 	int lookup_errno;
 
 	if (!bpf_map_lookup_elem(fd, key, value)) {
@@ -702,9 +701,8 @@ static int dump_map_elem(int fd, void *key, void *value,
 			} else {
 				print_entry_plain(map_info, key, value);
 			}
-			num_elems++;
 		}
-		return num_elems;
+		return 1;
 	}
 
 	/* lookup error handling */
@@ -722,11 +720,13 @@ static int dump_map_elem(int fd, void *key, void *value,
 		jsonw_string_field(json_wtr, "error", strerror(lookup_errno));
 		jsonw_end_object(json_wtr);
 	} else {
-		if (errno == ENOENT)
+		if (errno == ENOENT) {
 			print_entry_plain(map_info, key, NULL);
-		else
+		} else {
 			print_entry_error(map_info, key,
 					  strerror(lookup_errno));
+			return -lookup_errno;
+		}
 	}
 
 	return 0;
@@ -787,7 +787,16 @@ static int do_dump(int argc, char **argv)
 				err = 0;
 			break;
 		}
-		num_elems += dump_map_elem(fd, key, value, &info, btf, btf_wtr);
+		err = dump_map_elem(fd, key, value, &info, btf, btf_wtr);
+		/* bpf_fd_reuseport_array_lookup_elem() can only return a
+		 * value if the map's value_size == 8
+		 */
+		if (info.type == BPF_MAP_TYPE_REUSEPORT_SOCKARRAY &&
+		    info.value_size != 8 && err == -ENOSPC) {
+			p_err("cannot dump REUSEPORT_SOCKARRAY map with value_size != 8");
+			goto exit_free;
+		}
+		num_elems += err;
 		prev_key = key;
 	}
 
-- 
2.21.0

