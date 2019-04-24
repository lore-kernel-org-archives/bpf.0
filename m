Return-Path: <SRS0=W3SG=S2=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0903C282E3
	for <bpf@archiver.kernel.org>; Wed, 24 Apr 2019 22:39:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B279B208E4
	for <bpf@archiver.kernel.org>; Wed, 24 Apr 2019 22:39:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="hZyCoDW4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726579AbfDXWj6 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 24 Apr 2019 18:39:58 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:34266 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726418AbfDXWj5 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 24 Apr 2019 18:39:57 -0400
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3OMTeGN032625
        for <bpf@vger.kernel.org>; Wed, 24 Apr 2019 15:39:56 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=p8OHjDU4tm9Gb0EjPO+5G++0K4z7lJwZuKj7F/6rxf4=;
 b=hZyCoDW4tAyuWlaaiBMpRHG946lVEy9lQ9fko39KNaf9sU7JUyeEc+wQI3mutn4Hl7k4
 /hGSDQ44TAKOv3NMvuyeFUmbGjGwzTu4EG1khPaHTuFi/IbJsb7DqbnU8niCCWUJjU0O
 Y9+m05mkiU528+M8JaB9zVTjoZSV6MukaKw= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2s2x8e8xnr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 24 Apr 2019 15:39:56 -0700
Received: from mx-out.facebook.com (2620:10d:c081:10::13) by
 mail.thefacebook.com (2620:10d:c081:35::126) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1713.5;
 Wed, 24 Apr 2019 15:39:55 -0700
Received: by devbig005.ftw2.facebook.com (Postfix, from userid 6611)
        id 5D45429421BD; Wed, 24 Apr 2019 15:39:54 -0700 (PDT)
Smtp-Origin-Hostprefix: devbig
From:   Martin KaFai Lau <kafai@fb.com>
Smtp-Origin-Hostname: devbig005.ftw2.facebook.com
To:     <bpf@vger.kernel.org>, <netdev@vger.kernel.org>
CC:     Alexei Starovoitov <ast@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        <kernel-team@fb.com>, Yonghong Song <yhs@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH bpf-next 3/6] bpf: Support BPF_MAP_TYPE_SK_STORAGE in bpf map probing
Date:   Wed, 24 Apr 2019 15:39:54 -0700
Message-ID: <20190424223954.517036-1-kafai@fb.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190424223948.516788-1-kafai@fb.com>
References: <20190424223948.516788-1-kafai@fb.com>
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-24_14:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This patch supports probing for the new BPF_MAP_TYPE_SK_STORAGE.
BPF_MAP_TYPE_SK_STORAGE enforces BTF usage, so the new probe
requires to create and load a BTF also.

Signed-off-by: Martin KaFai Lau <kafai@fb.com>
---
 tools/bpf/bpftool/map.c       |  1 +
 tools/lib/bpf/libbpf_probes.c | 74 ++++++++++++++++++++++++++++++++++-
 2 files changed, 74 insertions(+), 1 deletion(-)

diff --git a/tools/bpf/bpftool/map.c b/tools/bpf/bpftool/map.c
index 10b6c9d3e525..693ab3da37de 100644
--- a/tools/bpf/bpftool/map.c
+++ b/tools/bpf/bpftool/map.c
@@ -46,6 +46,7 @@ const char * const map_type_name[] = {
 	[BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE]	= "percpu_cgroup_storage",
 	[BPF_MAP_TYPE_QUEUE]			= "queue",
 	[BPF_MAP_TYPE_STACK]			= "stack",
+	[BPF_MAP_TYPE_SK_STORAGE]		= "sk_storage",
 };
 
 const size_t map_type_name_size = ARRAY_SIZE(map_type_name);
diff --git a/tools/lib/bpf/libbpf_probes.c b/tools/lib/bpf/libbpf_probes.c
index 0f25541632e3..2e26ddb005e4 100644
--- a/tools/lib/bpf/libbpf_probes.c
+++ b/tools/lib/bpf/libbpf_probes.c
@@ -9,6 +9,7 @@
 #include <net/if.h>
 #include <sys/utsname.h>
 
+#include <linux/btf.h>
 #include <linux/filter.h>
 #include <linux/kernel.h>
 
@@ -130,11 +131,65 @@ bool bpf_probe_prog_type(enum bpf_prog_type prog_type, __u32 ifindex)
 	return errno != EINVAL && errno != EOPNOTSUPP;
 }
 
+static int load_btf(void)
+{
+#define BTF_INFO_ENC(kind, kind_flag, vlen) \
+	((!!(kind_flag) << 31) | ((kind) << 24) | ((vlen) & BTF_MAX_VLEN))
+#define BTF_TYPE_ENC(name, info, size_or_type) \
+	(name), (info), (size_or_type)
+#define BTF_INT_ENC(encoding, bits_offset, nr_bits) \
+	((encoding) << 24 | (bits_offset) << 16 | (nr_bits))
+#define BTF_TYPE_INT_ENC(name, encoding, bits_offset, bits, sz) \
+	BTF_TYPE_ENC(name, BTF_INFO_ENC(BTF_KIND_INT, 0, 0), sz), \
+	BTF_INT_ENC(encoding, bits_offset, bits)
+#define BTF_MEMBER_ENC(name, type, bits_offset) \
+	(name), (type), (bits_offset)
+
+	const char btf_str_sec[] = "\0bpf_spin_lock\0val\0cnt\0l";
+	/* struct bpf_spin_lock {
+	 *   int val;
+	 * };
+	 * struct val {
+	 *   int cnt;
+	 *   struct bpf_spin_lock l;
+	 * };
+	 */
+	__u32 btf_raw_types[] = {
+		/* int */
+		BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4),  /* [1] */
+		/* struct bpf_spin_lock */                      /* [2] */
+		BTF_TYPE_ENC(1, BTF_INFO_ENC(BTF_KIND_STRUCT, 0, 1), 4),
+		BTF_MEMBER_ENC(15, 1, 0), /* int val; */
+		/* struct val */                                /* [3] */
+		BTF_TYPE_ENC(15, BTF_INFO_ENC(BTF_KIND_STRUCT, 0, 2), 8),
+		BTF_MEMBER_ENC(19, 1, 0), /* int cnt; */
+		BTF_MEMBER_ENC(23, 2, 32),/* struct bpf_spin_lock l; */
+	};
+	struct btf_header btf_hdr = {
+		.magic = BTF_MAGIC,
+		.version = BTF_VERSION,
+		.hdr_len = sizeof(struct btf_header),
+		.type_len = sizeof(btf_raw_types),
+		.str_off = sizeof(btf_raw_types),
+		.str_len = sizeof(btf_str_sec),
+	};
+	__u8 raw_btf[sizeof(struct btf_header) + sizeof(btf_raw_types) +
+		     sizeof(btf_str_sec)];
+
+	memcpy(raw_btf, &btf_hdr, sizeof(btf_hdr));
+	memcpy(raw_btf + sizeof(btf_hdr), btf_raw_types, sizeof(btf_raw_types));
+	memcpy(raw_btf + sizeof(btf_hdr) + sizeof(btf_raw_types),
+	       btf_str_sec, sizeof(btf_str_sec));
+
+	return bpf_load_btf(raw_btf, sizeof(raw_btf), 0, 0, 0);
+}
+
 bool bpf_probe_map_type(enum bpf_map_type map_type, __u32 ifindex)
 {
 	int key_size, value_size, max_entries, map_flags;
+	__u32 btf_key_type_id = 0, btf_value_type_id = 0;
 	struct bpf_create_map_attr attr = {};
-	int fd = -1, fd_inner;
+	int fd = -1, btf_fd = -1, fd_inner;
 
 	key_size	= sizeof(__u32);
 	value_size	= sizeof(__u32);
@@ -160,6 +215,16 @@ bool bpf_probe_map_type(enum bpf_map_type map_type, __u32 ifindex)
 	case BPF_MAP_TYPE_STACK:
 		key_size	= 0;
 		break;
+	case BPF_MAP_TYPE_SK_STORAGE:
+		btf_key_type_id = 1;
+		btf_value_type_id = 3;
+		value_size = 8;
+		max_entries = 0;
+		map_flags = BPF_F_NO_PREALLOC;
+		btf_fd = load_btf();
+		if (btf_fd < 0)
+			return false;
+		break;
 	case BPF_MAP_TYPE_UNSPEC:
 	case BPF_MAP_TYPE_HASH:
 	case BPF_MAP_TYPE_ARRAY:
@@ -205,11 +270,18 @@ bool bpf_probe_map_type(enum bpf_map_type map_type, __u32 ifindex)
 		attr.max_entries = max_entries;
 		attr.map_flags = map_flags;
 		attr.map_ifindex = ifindex;
+		if (btf_fd >= 0) {
+			attr.btf_fd = btf_fd;
+			attr.btf_key_type_id = btf_key_type_id;
+			attr.btf_value_type_id = btf_value_type_id;
+		}
 
 		fd = bpf_create_map_xattr(&attr);
 	}
 	if (fd >= 0)
 		close(fd);
+	if (btf_fd >= 0)
+		close(btf_fd);
 
 	return fd >= 0;
 }
-- 
2.17.1

