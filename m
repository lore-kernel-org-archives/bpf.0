Return-Path: <SRS0=sRBR=SN=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8D38C10F13
	for <bpf@archiver.kernel.org>; Thu, 11 Apr 2019 08:04:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C074B206BA
	for <bpf@archiver.kernel.org>; Thu, 11 Apr 2019 08:04:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726106AbfDKIE1 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 11 Apr 2019 04:04:27 -0400
Received: from mx2.suse.de ([195.135.220.15]:54898 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725793AbfDKIE1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 11 Apr 2019 04:04:27 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id BA297AC61;
        Thu, 11 Apr 2019 08:04:25 +0000 (UTC)
From:   Benjamin Poirier <bpoirier@suse.com>
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org,
        David Ahern <dsahern@gmail.com>
Subject: [PATCH bpf] bpftool: Fix errno variable usage
Date:   Thu, 11 Apr 2019 17:03:32 +0900
Message-Id: <20190411080332.24574-1-bpoirier@suse.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The test meant to use the saved value of errno. Given the current code, it
makes no practical difference however.

Fixes: bf598a8f0f77 ("bpftool: Improve handling of ENOENT on map dumps")
Signed-off-by: Benjamin Poirier <bpoirier@suse.com>
---
 tools/bpf/bpftool/map.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/bpf/bpftool/map.c b/tools/bpf/bpftool/map.c
index e0c650d91784..05b029b934a6 100644
--- a/tools/bpf/bpftool/map.c
+++ b/tools/bpf/bpftool/map.c
@@ -720,7 +720,7 @@ static int dump_map_elem(int fd, void *key, void *value,
 		jsonw_string_field(json_wtr, "error", strerror(lookup_errno));
 		jsonw_end_object(json_wtr);
 	} else {
-		if (errno == ENOENT)
+		if (lookup_errno == ENOENT)
 			print_entry_plain(map_info, key, NULL);
 		else
 			print_entry_error(map_info, key,
-- 
2.21.0

