Return-Path: <SRS0=9Oao=SO=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13312C10F13
	for <bpf@archiver.kernel.org>; Fri, 12 Apr 2019 03:04:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF0262084D
	for <bpf@archiver.kernel.org>; Fri, 12 Apr 2019 03:03:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726828AbfDLDD7 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 11 Apr 2019 23:03:59 -0400
Received: from mx2.suse.de ([195.135.220.15]:60984 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726720AbfDLDD7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 11 Apr 2019 23:03:59 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 36402AC6E;
        Fri, 12 Apr 2019 03:03:58 +0000 (UTC)
From:   Benjamin Poirier <bpoirier@suse.com>
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org
Subject: [PATCH v2 bpf-next 2/2] bpftool: Improve handling of ENOSPC on reuseport_array map dumps
Date:   Fri, 12 Apr 2019 12:03:22 +0900
Message-Id: <20190412030322.15494-2-bpoirier@suse.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190412030322.15494-1-bpoirier@suse.com>
References: <20190411082700.26888-1-bpoirier@suse.com>
 <20190412030322.15494-1-bpoirier@suse.com>
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
the map, print an explanatory warning and a specialized error.

example before:
key: 00 00 00 00
value:
No space left on device
key: 01 00 00 00
value:
No space left on device
key: 02 00 00 00
value:
No space left on device
Found 0 elements

example after:
Warning: cannot read values from reuseport_sockarray map with value_size != 8
key: 00 00 00 00  value: <cannot read>
key: 01 00 00 00  value: <cannot read>
key: 02 00 00 00  value: <cannot read>
Found 0 elements

Signed-off-by: Benjamin Poirier <bpoirier@suse.com>
---
 tools/bpf/bpftool/map.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/tools/bpf/bpftool/map.c b/tools/bpf/bpftool/map.c
index 71840faaeab5..e6d72f777767 100644
--- a/tools/bpf/bpftool/map.c
+++ b/tools/bpf/bpftool/map.c
@@ -716,8 +716,12 @@ static int dump_map_elem(int fd, void *key, void *value,
 	} else {
 		const char *msg = NULL;
 
-		if (errno == ENOENT)
+		if (lookup_errno == ENOENT) {
 			msg = "<no entry>";
+		} else if (lookup_errno == ENOSPC && map_info->type ==
+			 BPF_MAP_TYPE_REUSEPORT_SOCKARRAY) {
+			msg = "<cannot read>";
+		}
 
 		print_entry_error(map_info, key,
 				  msg ? : strerror(lookup_errno), !!msg);
@@ -774,6 +778,11 @@ static int do_dump(int argc, char **argv)
 			}
 		}
 
+	if (info.type == BPF_MAP_TYPE_REUSEPORT_SOCKARRAY &&
+	    info.value_size != 8) {
+		p_info("Warning: cannot read values from %s map with value_size != 8",
+		       map_type_name[info.type]);
+	}
 	while (true) {
 		err = bpf_map_get_next_key(fd, prev_key, key);
 		if (err) {
-- 
2.21.0

