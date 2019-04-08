Return-Path: <SRS0=xPz+=SK=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57739C282DE
	for <bpf@archiver.kernel.org>; Mon,  8 Apr 2019 13:54:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 338A6214C6
	for <bpf@archiver.kernel.org>; Mon,  8 Apr 2019 13:54:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726993AbfDHNyd (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 8 Apr 2019 09:54:33 -0400
Received: from www62.your-server.de ([213.133.104.62]:46130 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726876AbfDHNyF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 8 Apr 2019 09:54:05 -0400
Received: from [178.197.248.24] (helo=localhost)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1hDUih-0003fW-7z; Mon, 08 Apr 2019 15:53:55 +0200
From:   Daniel Borkmann <daniel@iogearbox.net>
To:     bpf@vger.kernel.org
Cc:     netdev@vger.kernel.org, ast@kernel.org, joe@wand.net.nz,
        yhs@fb.com, andrii.nakryiko@gmail.com, kafai@fb.com,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH bpf-next v5 02/16] bpf: do not retain flags that are not tied to map lifetime
Date:   Mon,  8 Apr 2019 15:53:34 +0200
Message-Id: <f875133bf543513049dba8e4687274a4a5ee7d0a.1554731339.git.daniel@iogearbox.net>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <cover.1554731339.git.daniel@iogearbox.net>
References: <cover.1554731339.git.daniel@iogearbox.net>
In-Reply-To: <cover.1554731339.git.daniel@iogearbox.net>
References: <cover.1554731339.git.daniel@iogearbox.net>
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.100.3/25413/Mon Apr  8 09:56:28 2019)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Both BPF_F_WRONLY / BPF_F_RDONLY flags are tied to the map file
descriptor, but not to the map object itself! Meaning, at map
creation time BPF_F_RDONLY can be set to make the map read-only
from syscall side, but this holds only for the returned fd, so
any other fd either retrieved via bpf file system or via map id
for the very same underlying map object can have read-write access
instead.

Given that, keeping the two flags around in the map_flags attribute
and exposing them to user space upon map dump is misleading and
may lead to false conclusions. Since these two flags are not
tied to the map object lets also not store them as map property.

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Acked-by: Martin KaFai Lau <kafai@fb.com>
---
 kernel/bpf/syscall.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 828518b..56b4b0e 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -166,13 +166,25 @@ void bpf_map_area_free(void *area)
 	kvfree(area);
 }
 
+static u32 bpf_map_flags_retain_permanent(u32 flags)
+{
+	/* Some map creation flags are not tied to the map object but
+	 * rather to the map fd instead, so they have no meaning upon
+	 * map object inspection since multiple file descriptors with
+	 * different (access) properties can exist here. Thus, given
+	 * this has zero meaning for the map itself, lets clear these
+	 * from here.
+	 */
+	return flags & ~(BPF_F_RDONLY | BPF_F_WRONLY);
+}
+
 void bpf_map_init_from_attr(struct bpf_map *map, union bpf_attr *attr)
 {
 	map->map_type = attr->map_type;
 	map->key_size = attr->key_size;
 	map->value_size = attr->value_size;
 	map->max_entries = attr->max_entries;
-	map->map_flags = attr->map_flags;
+	map->map_flags = bpf_map_flags_retain_permanent(attr->map_flags);
 	map->numa_node = bpf_map_attr_numa_node(attr);
 }
 
-- 
2.9.5

