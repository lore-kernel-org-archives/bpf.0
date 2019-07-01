Return-Path: <SRS0=ay3l=U6=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93E44C06510
	for <bpf@archiver.kernel.org>; Mon,  1 Jul 2019 23:59:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F79320B7C
	for <bpf@archiver.kernel.org>; Mon,  1 Jul 2019 23:59:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="nxvxYYv+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727010AbfGAX7P (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 1 Jul 2019 19:59:15 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:22412 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726811AbfGAX7M (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 1 Jul 2019 19:59:12 -0400
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.27/8.16.0.27) with SMTP id x61NsKEU022239
        for <bpf@vger.kernel.org>; Mon, 1 Jul 2019 16:59:11 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=pMX+miHg/FXXzAODDCj/BGEfoCw+qyLP7+NouH9NI9g=;
 b=nxvxYYv+sP/8h9KWk0nNpEJVv9W0cBBM0tJJ+M0zhZyB4gvmfalJFx/rHCc4O2pQpaOs
 VZ6CARB8737skyBFcZqssUHXIUSCCP/0KK5hgC3PxsOdvhfzPFh0oRw3rj5tGoUVENQY
 9eZ0qi6s++INbmUvOkc5J0euSJH9cj6iSCI= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0089730.ppops.net with ESMTP id 2tfg1s2qcr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 01 Jul 2019 16:59:11 -0700
Received: from mx-out.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 1 Jul 2019 16:59:10 -0700
Received: by dev101.prn2.facebook.com (Postfix, from userid 137359)
        id C563086149D; Mon,  1 Jul 2019 16:59:08 -0700 (PDT)
Smtp-Origin-Hostprefix: dev
From:   Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Hostname: dev101.prn2.facebook.com
To:     <andrii.nakryiko@gmail.com>, <bpf@vger.kernel.org>,
        <netdev@vger.kernel.org>, <ast@fb.com>, <daniel@iogearbox.net>,
        <kernel-team@fb.com>, <yhs@fb.com>
CC:     Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Cluster: prn2c23
Subject: [PATCH v5 bpf-next 2/9] libbpf: introduce concept of bpf_link
Date:   Mon, 1 Jul 2019 16:58:56 -0700
Message-ID: <20190701235903.660141-3-andriin@fb.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190701235903.660141-1-andriin@fb.com>
References: <20190701235903.660141-1-andriin@fb.com>
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-01_14:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1907010278
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

bpf_link is an abstraction of an association of a BPF program and one of
many possible BPF attachment points (hooks). This allows to have uniform
interface for detaching BPF programs regardless of the nature of link
and how it was created. Details of creation and setting up of a specific
bpf_link is handled by corresponding attachment methods
(bpf_program__attach_xxx) added in subsequent commits. Once successfully
created, bpf_link has to be eventually destroyed with
bpf_link__destroy(), at which point BPF program is disassociated from
a hook and all the relevant resources are freed.

Signed-off-by: Andrii Nakryiko <andriin@fb.com>
Acked-by: Song Liu <songliubraving@fb.com>
Reviewed-by: Stanislav Fomichev <sdf@google.com>
---
 tools/lib/bpf/libbpf.c   | 17 +++++++++++++++++
 tools/lib/bpf/libbpf.h   |  4 ++++
 tools/lib/bpf/libbpf.map |  3 ++-
 3 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 6e6ebef11ba3..455795e6f8af 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -3941,6 +3941,23 @@ int bpf_prog_load_xattr(const struct bpf_prog_load_attr *attr,
 	return 0;
 }
 
+struct bpf_link {
+	int (*destroy)(struct bpf_link *link);
+};
+
+int bpf_link__destroy(struct bpf_link *link)
+{
+	int err;
+
+	if (!link)
+		return 0;
+
+	err = link->destroy(link);
+	free(link);
+
+	return err;
+}
+
 enum bpf_perf_event_ret
 bpf_perf_event_read_simple(void *mmap_mem, size_t mmap_size, size_t page_size,
 			   void **copy_mem, size_t *copy_size,
diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index d639f47e3110..5082a5ebb0c2 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -165,6 +165,10 @@ LIBBPF_API int bpf_program__pin(struct bpf_program *prog, const char *path);
 LIBBPF_API int bpf_program__unpin(struct bpf_program *prog, const char *path);
 LIBBPF_API void bpf_program__unload(struct bpf_program *prog);
 
+struct bpf_link;
+
+LIBBPF_API int bpf_link__destroy(struct bpf_link *link);
+
 struct bpf_insn;
 
 /*
diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
index 2c6d835620d2..3cde850fc8da 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -167,10 +167,11 @@ LIBBPF_0.0.3 {
 
 LIBBPF_0.0.4 {
 	global:
+		bpf_link__destroy;
+		bpf_object__load_xattr;
 		btf_dump__dump_type;
 		btf_dump__free;
 		btf_dump__new;
 		btf__parse_elf;
-		bpf_object__load_xattr;
 		libbpf_num_possible_cpus;
 } LIBBPF_0.0.3;
-- 
2.17.1

