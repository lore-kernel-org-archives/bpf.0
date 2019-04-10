Return-Path: <SRS0=J20p=SM=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5F08C10F0E
	for <bpf@archiver.kernel.org>; Wed, 10 Apr 2019 00:37:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C9FB20874
	for <bpf@archiver.kernel.org>; Wed, 10 Apr 2019 00:37:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="Lhsjt7GG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726766AbfDJAhs (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 9 Apr 2019 20:37:48 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:59930 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726755AbfDJAhp (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 9 Apr 2019 20:37:45 -0400
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.27/8.16.0.27) with SMTP id x3A0aXMC016897
        for <bpf@vger.kernel.org>; Tue, 9 Apr 2019 17:37:43 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=facebook;
 bh=cFA4Taqa81ZVBpnFhFjB+BIuM9J0UBMJ8BdLml4mTa0=;
 b=Lhsjt7GGt0bhnS0HPIUh1fjCG+jNo4EQBVYMh0aulJruTUeIFXTbYi8FFIP+p8p2IwZm
 L4raopzr9RVGp/7Q0gjA5Qw3OH6zI+qBP+xq09Fg71DTRqSjvKAZTFk5zcqiasZnRr8z
 NXoFFdmUST+ZeAdj2mZTPWFXN5aEOoBZLxw= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by m0001303.ppops.net with ESMTP id 2rs3fr0j48-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 09 Apr 2019 17:37:43 -0700
Received: from mx-out.facebook.com (2620:10d:c081:10::13) by
 mail.thefacebook.com (2620:10d:c081:35::125) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1713.5;
 Tue, 9 Apr 2019 17:37:42 -0700
Received: by devbig003.ftw2.facebook.com (Postfix, from userid 128203)
        id AF1003702B28; Tue,  9 Apr 2019 17:37:41 -0700 (PDT)
Smtp-Origin-Hostprefix: devbig
From:   Yonghong Song <yhs@fb.com>
Smtp-Origin-Hostname: devbig003.ftw2.facebook.com
To:     <bpf@vger.kernel.org>, <netdev@vger.kernel.org>
CC:     Alexei Starovoitov <ast@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>,
        Yonghong Song <yhs@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH bpf-next] [tools/bpf] fix a few ubsan warning
Date:   Tue, 9 Apr 2019 17:37:41 -0700
Message-ID: <20190410003741.1855113-1-yhs@fb.com>
X-Mailer: git-send-email 2.17.1
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-09_14:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The issue is reported at https://github.com/libbpf/libbpf/issues/28.

Basically, per C standard, for
  void *memcpy(void *dest, const void *src, size_t n)
if "dest" or "src" is NULL, regardless of whether "n" is 0 or not,
the result of memcpy is undefined. clang ubsan reported three such
instances in bpf.c with the following pattern:
  memcpy(dest, 0, 0).

Although in practice, no known compiler will cause issues when
copy size is 0. Let us still fix the issue to silence ubsan
warnings.

Signed-off-by: Yonghong Song <yhs@fb.com>
---
 tools/lib/bpf/bpf.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
index a1db869a6fda..78f2400dd2d1 100644
--- a/tools/lib/bpf/bpf.c
+++ b/tools/lib/bpf/bpf.c
@@ -79,7 +79,6 @@ static inline int sys_bpf_prog_load(union bpf_attr *attr, unsigned int size)
 
 int bpf_create_map_xattr(const struct bpf_create_map_attr *create_attr)
 {
-	__u32 name_len = create_attr->name ? strlen(create_attr->name) : 0;
 	union bpf_attr attr;
 
 	memset(&attr, '\0', sizeof(attr));
@@ -89,8 +88,9 @@ int bpf_create_map_xattr(const struct bpf_create_map_attr *create_attr)
 	attr.value_size = create_attr->value_size;
 	attr.max_entries = create_attr->max_entries;
 	attr.map_flags = create_attr->map_flags;
-	memcpy(attr.map_name, create_attr->name,
-	       min(name_len, BPF_OBJ_NAME_LEN - 1));
+	if (create_attr->name)
+		memcpy(attr.map_name, create_attr->name,
+		       min(strlen(create_attr->name), BPF_OBJ_NAME_LEN - 1));
 	attr.numa_node = create_attr->numa_node;
 	attr.btf_fd = create_attr->btf_fd;
 	attr.btf_key_type_id = create_attr->btf_key_type_id;
@@ -155,7 +155,6 @@ int bpf_create_map_in_map_node(enum bpf_map_type map_type, const char *name,
 			       int key_size, int inner_map_fd, int max_entries,
 			       __u32 map_flags, int node)
 {
-	__u32 name_len = name ? strlen(name) : 0;
 	union bpf_attr attr;
 
 	memset(&attr, '\0', sizeof(attr));
@@ -166,7 +165,9 @@ int bpf_create_map_in_map_node(enum bpf_map_type map_type, const char *name,
 	attr.inner_map_fd = inner_map_fd;
 	attr.max_entries = max_entries;
 	attr.map_flags = map_flags;
-	memcpy(attr.map_name, name, min(name_len, BPF_OBJ_NAME_LEN - 1));
+	if (name)
+		memcpy(attr.map_name, name,
+		       min(strlen(name), BPF_OBJ_NAME_LEN - 1));
 
 	if (node >= 0) {
 		attr.map_flags |= BPF_F_NUMA_NODE;
@@ -216,7 +217,6 @@ int bpf_load_program_xattr(const struct bpf_load_program_attr *load_attr,
 	void *finfo = NULL, *linfo = NULL;
 	union bpf_attr attr;
 	__u32 log_level;
-	__u32 name_len;
 	int fd;
 
 	if (!load_attr || !log_buf != !log_buf_sz)
@@ -226,8 +226,6 @@ int bpf_load_program_xattr(const struct bpf_load_program_attr *load_attr,
 	if (log_level > (4 | 2 | 1) || (log_level && !log_buf))
 		return -EINVAL;
 
-	name_len = load_attr->name ? strlen(load_attr->name) : 0;
-
 	memset(&attr, 0, sizeof(attr));
 	attr.prog_type = load_attr->prog_type;
 	attr.expected_attach_type = load_attr->expected_attach_type;
@@ -253,8 +251,9 @@ int bpf_load_program_xattr(const struct bpf_load_program_attr *load_attr,
 	attr.line_info_rec_size = load_attr->line_info_rec_size;
 	attr.line_info_cnt = load_attr->line_info_cnt;
 	attr.line_info = ptr_to_u64(load_attr->line_info);
-	memcpy(attr.prog_name, load_attr->name,
-	       min(name_len, BPF_OBJ_NAME_LEN - 1));
+	if (load_attr->name)
+		memcpy(attr.prog_name, load_attr->name,
+		       min(strlen(load_attr->name), BPF_OBJ_NAME_LEN - 1));
 
 	fd = sys_bpf_prog_load(&attr, sizeof(attr));
 	if (fd >= 0)
-- 
2.17.1

