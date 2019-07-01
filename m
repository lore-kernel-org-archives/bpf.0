Return-Path: <SRS0=ay3l=U6=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1925C06510
	for <bpf@archiver.kernel.org>; Mon,  1 Jul 2019 23:59:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C761320B7C
	for <bpf@archiver.kernel.org>; Mon,  1 Jul 2019 23:59:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="AzTiY6Qs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727013AbfGAX7U (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 1 Jul 2019 19:59:20 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:29510 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727035AbfGAX7T (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 1 Jul 2019 19:59:19 -0400
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x61Not2G030572
        for <bpf@vger.kernel.org>; Mon, 1 Jul 2019 16:59:18 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=lSTtLvJhW6kst0OSPiEM9T8F2eWvtre+hIT3n3W6RgM=;
 b=AzTiY6QshRYMMijNoZ9rjeMT0/kC8sw7jgys4Mjq0YAgEOxmF5cHoro/2Rsu6VserY+w
 2setRDunH5qAzudqxHdOXWrqWHYoxpnSWdznECkL/ECj9a7FLgQW1UwFJu389tkszkVe
 zJgApkYLpm/aET/vPgVgHdChqqOhbStBRI4= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2tfns49fwa-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 01 Jul 2019 16:59:18 -0700
Received: from mx-out.facebook.com (2620:10d:c081:10::13) by
 mail.thefacebook.com (2620:10d:c081:35::126) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1713.5;
 Mon, 1 Jul 2019 16:59:17 -0700
Received: by dev101.prn2.facebook.com (Postfix, from userid 137359)
        id 049BD86149D; Mon,  1 Jul 2019 16:59:16 -0700 (PDT)
Smtp-Origin-Hostprefix: dev
From:   Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Hostname: dev101.prn2.facebook.com
To:     <andrii.nakryiko@gmail.com>, <bpf@vger.kernel.org>,
        <netdev@vger.kernel.org>, <ast@fb.com>, <daniel@iogearbox.net>,
        <kernel-team@fb.com>, <yhs@fb.com>
CC:     Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Cluster: prn2c23
Subject: [PATCH v5 bpf-next 6/9] libbpf: add raw tracepoint attach API
Date:   Mon, 1 Jul 2019 16:59:00 -0700
Message-ID: <20190701235903.660141-7-andriin@fb.com>
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

Add a wrapper utilizing bpf_link "infrastructure" to allow attaching BPF
programs to raw tracepoints.

Signed-off-by: Andrii Nakryiko <andriin@fb.com>
Acked-by: Song Liu <songliubraving@fb.com>
Reviewed-by: Stanislav Fomichev <sdf@google.com>
---
 tools/lib/bpf/libbpf.c   | 39 +++++++++++++++++++++++++++++++++++++++
 tools/lib/bpf/libbpf.h   |  3 +++
 tools/lib/bpf/libbpf.map |  1 +
 3 files changed, 43 insertions(+)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index d8c1743efc4a..72ee3d8d20a8 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -4269,6 +4269,45 @@ struct bpf_link *bpf_program__attach_tracepoint(struct bpf_program *prog,
 	return link;
 }
 
+static int bpf_link__destroy_fd(struct bpf_link *link)
+{
+	struct bpf_link_fd *l = (void *)link;
+
+	return close(l->fd);
+}
+
+struct bpf_link *bpf_program__attach_raw_tracepoint(struct bpf_program *prog,
+						    const char *tp_name)
+{
+	char errmsg[STRERR_BUFSIZE];
+	struct bpf_link_fd *link;
+	int prog_fd, pfd;
+
+	prog_fd = bpf_program__fd(prog);
+	if (prog_fd < 0) {
+		pr_warning("program '%s': can't attach before loaded\n",
+			   bpf_program__title(prog, false));
+		return ERR_PTR(-EINVAL);
+	}
+
+	link = malloc(sizeof(*link));
+	if (!link)
+		return ERR_PTR(-ENOMEM);
+	link->link.destroy = &bpf_link__destroy_fd;
+
+	pfd = bpf_raw_tracepoint_open(tp_name, prog_fd);
+	if (pfd < 0) {
+		pfd = -errno;
+		free(link);
+		pr_warning("program '%s': failed to attach to raw tracepoint '%s': %s\n",
+			   bpf_program__title(prog, false), tp_name,
+			   libbpf_strerror_r(pfd, errmsg, sizeof(errmsg)));
+		return ERR_PTR(pfd);
+	}
+	link->fd = pfd;
+	return (struct bpf_link *)link;
+}
+
 enum bpf_perf_event_ret
 bpf_perf_event_read_simple(void *mmap_mem, size_t mmap_size, size_t page_size,
 			   void **copy_mem, size_t *copy_size,
diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index 60611f4b4e1d..f55933784f95 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -182,6 +182,9 @@ LIBBPF_API struct bpf_link *
 bpf_program__attach_tracepoint(struct bpf_program *prog,
 			       const char *tp_category,
 			       const char *tp_name);
+LIBBPF_API struct bpf_link *
+bpf_program__attach_raw_tracepoint(struct bpf_program *prog,
+				   const char *tp_name);
 
 struct bpf_insn;
 
diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
index 3c618b75ef65..e6b7d4edbc93 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -171,6 +171,7 @@ LIBBPF_0.0.4 {
 		bpf_object__load_xattr;
 		bpf_program__attach_kprobe;
 		bpf_program__attach_perf_event;
+		bpf_program__attach_raw_tracepoint;
 		bpf_program__attach_tracepoint;
 		bpf_program__attach_uprobe;
 		btf_dump__dump_type;
-- 
2.17.1

