Return-Path: <SRS0=rV2l=SZ=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10BB4C282E1
	for <bpf@archiver.kernel.org>; Tue, 23 Apr 2019 22:46:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D27B8218D3
	for <bpf@archiver.kernel.org>; Tue, 23 Apr 2019 22:46:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727838AbfDWWqM (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 23 Apr 2019 18:46:12 -0400
Received: from www62.your-server.de ([213.133.104.62]:51126 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726342AbfDWWqL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 23 Apr 2019 18:46:11 -0400
Received: from [178.199.41.31] (helo=localhost)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1hJ4Az-0003mk-Q3; Wed, 24 Apr 2019 00:46:09 +0200
From:   Daniel Borkmann <daniel@iogearbox.net>
To:     ast@kernel.org
Cc:     andrii.nakryiko@gmail.com, bpf@vger.kernel.org,
        netdev@vger.kernel.org, Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH bpf-next 2/2] bpf, libbpf: fix segfault in bpf_object__init_maps' pr_debug statement
Date:   Wed, 24 Apr 2019 00:45:57 +0200
Message-Id: <4d9c7c6fd837567f9002c57206f9a0c2ced416ec.1556059361.git.daniel@iogearbox.net>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <cover.1556059361.git.daniel@iogearbox.net>
References: <cover.1556059361.git.daniel@iogearbox.net>
In-Reply-To: <cover.1556059361.git.daniel@iogearbox.net>
References: <cover.1556059361.git.daniel@iogearbox.net>
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.100.3/25428/Tue Apr 23 10:00:55 2019)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Ran into it while testing; in bpf_object__init_maps() data can be NULL
in the case where no map section is present. Therefore we simply cannot
access data->d_size before NULL test. Move the pr_debug() where it's
safe to access.

Fixes: d859900c4c56 ("bpf, libbpf: support global data/bss/rodata sections")
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 tools/lib/bpf/libbpf.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 85315de..9052061 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -875,14 +875,14 @@ bpf_object__init_maps(struct bpf_object *obj, int flags)
 		nr_maps++;
 	}
 
-	/* Alloc obj->maps and fill nr_maps. */
-	pr_debug("maps in %s: %d maps in %zd bytes\n", obj->path,
-		 nr_maps, data->d_size);
 	if (!nr_maps && !nr_maps_glob)
 		return 0;
 
 	/* Assume equally sized map definitions */
 	if (data) {
+		pr_debug("maps in %s: %d maps in %zd bytes\n", obj->path,
+			 nr_maps, data->d_size);
+
 		map_def_sz = data->d_size / nr_maps;
 		if (!data->d_size || (data->d_size % nr_maps) != 0) {
 			pr_warning("unable to determine map definition size "
-- 
2.9.5

