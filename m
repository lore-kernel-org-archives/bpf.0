Return-Path: <SRS0=US5c=RX=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0AFAC43381
	for <bpf@archiver.kernel.org>; Wed, 20 Mar 2019 12:27:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A6652184D
	for <bpf@archiver.kernel.org>; Wed, 20 Mar 2019 12:27:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727607AbfCTM17 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 20 Mar 2019 08:27:59 -0400
Received: from mx2.suse.de ([195.135.220.15]:41144 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725996AbfCTM17 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 20 Mar 2019 08:27:59 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id AAC8BAD7B;
        Wed, 20 Mar 2019 12:27:57 +0000 (UTC)
From:   Michal Rostecki <mrostecki@opensuse.org>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        netdev@vger.kernel.org, bpf@vger.kernel.org
Cc:     Michal Rostecki <mrostecki@opensuse.org>
Subject: [PATCH bpf] libbpf: Check if map names are not NULL
Date:   Wed, 20 Mar 2019 13:27:42 +0100
Message-Id: <20190320122742.19311-1-mrostecki@opensuse.org>
X-Mailer: git-send-email 2.16.4
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

BPF maps do not have to be named, so map names can be NULL. Map name
pointers should be checked before doing any operations which cannot be
done on NULL pointers.

This issue was detected by the following errors coming from bpftool
built with AddressSanitizer:

bpf.c:256:2: runtime error: null pointer passed as argument 2, which is declared to never be null
bpf.c:92:2: runtime error: null pointer passed as argument 2, which is declared to never be null
bpf.c:169:2: runtime error: null pointer passed as argument 2, which is declared to never be null

Fixes: 88cda1c9da02 ("bpf: libbpf: Provide basic API support to specify BPF obj name")
Fixes: d7be143b67c2 ("libbpf: Support expected_attach_type at prog load")
Fixes: 8a138aed4a80 ("bpf: btf: Add BTF support to libbpf")
Signed-off-by: Michal Rostecki <mrostecki@opensuse.org>
---
 tools/lib/bpf/bpf.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
index 9cd015574e83..21484ff1cecb 100644
--- a/tools/lib/bpf/bpf.c
+++ b/tools/lib/bpf/bpf.c
@@ -89,8 +89,9 @@ int bpf_create_map_xattr(const struct bpf_create_map_attr *create_attr)
 	attr.value_size = create_attr->value_size;
 	attr.max_entries = create_attr->max_entries;
 	attr.map_flags = create_attr->map_flags;
-	memcpy(attr.map_name, create_attr->name,
-	       min(name_len, BPF_OBJ_NAME_LEN - 1));
+	if (create_attr->name)
+		memcpy(attr.map_name, create_attr->name,
+		       min(name_len, BPF_OBJ_NAME_LEN - 1));
 	attr.numa_node = create_attr->numa_node;
 	attr.btf_fd = create_attr->btf_fd;
 	attr.btf_key_type_id = create_attr->btf_key_type_id;
@@ -166,7 +167,9 @@ int bpf_create_map_in_map_node(enum bpf_map_type map_type, const char *name,
 	attr.inner_map_fd = inner_map_fd;
 	attr.max_entries = max_entries;
 	attr.map_flags = map_flags;
-	memcpy(attr.map_name, name, min(name_len, BPF_OBJ_NAME_LEN - 1));
+	if (name)
+		memcpy(attr.map_name, name,
+		       min(name_len, BPF_OBJ_NAME_LEN - 1));
 
 	if (node >= 0) {
 		attr.map_flags |= BPF_F_NUMA_NODE;
@@ -253,8 +256,9 @@ int bpf_load_program_xattr(const struct bpf_load_program_attr *load_attr,
 	attr.line_info_rec_size = load_attr->line_info_rec_size;
 	attr.line_info_cnt = load_attr->line_info_cnt;
 	attr.line_info = ptr_to_u64(load_attr->line_info);
-	memcpy(attr.prog_name, load_attr->name,
-	       min(name_len, BPF_OBJ_NAME_LEN - 1));
+	if (load_attr->name)
+		memcpy(attr.prog_name, load_attr->name,
+		       min(name_len, BPF_OBJ_NAME_LEN - 1));
 
 	fd = sys_bpf_prog_load(&attr, sizeof(attr));
 	if (fd >= 0)
-- 
2.16.4

