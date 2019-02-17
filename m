Return-Path: <SRS0=ogH5=QY=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92362C4360F
	for <bpf@archiver.kernel.org>; Sun, 17 Feb 2019 08:20:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 610E421A4A
	for <bpf@archiver.kernel.org>; Sun, 17 Feb 2019 08:20:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="IAin/2Fv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725804AbfBQIU3 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Sun, 17 Feb 2019 03:20:29 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:41418 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725810AbfBQIU3 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sun, 17 Feb 2019 03:20:29 -0500
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1H8CQA2005533
        for <bpf@vger.kernel.org>; Sun, 17 Feb 2019 00:20:28 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=tsdIFV+exp/qxHjjlpiUt03DYzZGbpwG8ZiS11PM3bo=;
 b=IAin/2FvpY2nZpnhxHbOzyCQccO0fZhzY9prKcZgrTe6srAo/3q/Vm76wZLFONqdcJgP
 iTWY1bfG9Gj0Liwd1AYVO3RGl3v0N2M9zvDKNEMBL+NKTnqvXmNWNezK9/Am9+QRp/MI
 zTuXIXXTZENZv1ec7DLoJCEdGKsQwGa57Cg= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2qpyrr8df2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Sun, 17 Feb 2019 00:20:27 -0800
Received: from mx-out.facebook.com (2620:10d:c0a1:3::13) by
 mail.thefacebook.com (2620:10d:c021:18::176) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1531.3;
 Sun, 17 Feb 2019 00:20:26 -0800
Received: by devvm7221.prn2.facebook.com (Postfix, from userid 137359)
        id 4808FB10C288; Sun, 17 Feb 2019 00:20:25 -0800 (PST)
Smtp-Origin-Hostprefix: devvm
From:   Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Hostname: devvm7221.prn2.facebook.com
To:     <acme@kernel.org>, <ast@fb.com>, <dwarves@vger.kernel.org>,
        <bpf@vger.kernel.org>, <kernel-team@fb.com>,
        <andrii.nakryiko@gmail.com>
CC:     Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Cluster: prn2c23
Subject: [PATCH pahole 2/2] btf_encoder: run BTF deduplication before writing out to ELF
Date:   Sun, 17 Feb 2019 00:20:18 -0800
Message-ID: <20190217082018.1008069-3-andriin@fb.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190217082018.1008069-1-andriin@fb.com>
References: <20190217082018.1008069-1-andriin@fb.com>
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-17_04:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

After btf_encoder completes DWARF to BTF 1-to-1 conversion, utilize
libbpf to construct struct btf and run btf__dedup() algorithm on it.
This significantly reduces number of BTF types and strings section size
without losing any information.

Signed-off-by: Andrii Nakryiko <andriin@fb.com>
---
 libbtf.c | 44 ++++++++++++++++++++++++++++++++++----------
 1 file changed, 34 insertions(+), 10 deletions(-)

diff --git a/libbtf.c b/libbtf.c
index 7b862cf..9c87c12 100644
--- a/libbtf.c
+++ b/libbtf.c
@@ -17,6 +17,9 @@
 
 #include "libbtf.h"
 #include "lib/bpf/include/uapi/linux/btf.h"
+#include "lib/bpf/include/linux/err.h"
+#include "lib/bpf/src/btf.h"
+#include "lib/bpf/src/libbpf.h"
 #include "dutil.h"
 #include "gobuffer.h"
 #include "dwarves.h"
@@ -566,19 +569,21 @@ int32_t btf_elf__add_func_proto(struct btf_elf *btfe, struct ftype *ftype, uint3
 	return type_id;
 }
 
-static int btf_elf__write(struct btf_elf *btfe)
+static int btf_elf__write(const char *filename, struct btf *btf)
 {
 	GElf_Shdr shdr_mem, *shdr;
 	GElf_Ehdr ehdr_mem, *ehdr;
 	Elf_Data *btf_elf = NULL;
 	Elf_Scn *scn = NULL;
 	Elf *elf = NULL;
+	const void *btf_data;
+	uint32_t btf_size;
 	int fd, err = -1;
 	size_t strndx;
 
-	fd = open(btfe->filename, O_RDWR);
+	fd = open(filename, O_RDWR);
 	if (fd < 0) {
-		fprintf(stderr, "Cannot open %s\n", btfe->filename);
+		fprintf(stderr, "Cannot open %s\n", filename);
 		return -1;
 	}
 
@@ -617,10 +622,12 @@ static int btf_elf__write(struct btf_elf *btfe)
 		}
 	}
 
+	btf_data = btf__get_raw_data(btf, &btf_size);
+
 	if (btf_elf) {
 		/* Exisiting .BTF section found */
-		btf_elf->d_buf = btfe->data;
-		btf_elf->d_size = btfe->size;
+		btf_elf->d_buf = (void *)btf_data;
+		btf_elf->d_size = btf_size;
 		elf_flagdata(btf_elf, ELF_C_SET, ELF_F_DIRTY);
 
 		if (elf_update(elf, ELF_C_NULL) >= 0 &&
@@ -636,7 +643,7 @@ static int btf_elf__write(struct btf_elf *btfe)
 			llvm_objcopy = "llvm-objcopy";
 
 		/* Use objcopy to add a .BTF section */
-		snprintf(tmp_fn, sizeof(tmp_fn), "%s.btfe", btfe->filename);
+		snprintf(tmp_fn, sizeof(tmp_fn), "%s.btf", filename);
 		close(fd);
 		fd = creat(tmp_fn, S_IRUSR | S_IWUSR);
 		if (fd == -1) {
@@ -646,10 +653,9 @@ static int btf_elf__write(struct btf_elf *btfe)
 		}
 
 		snprintf(cmd, sizeof(cmd), "%s --add-section .BTF=%s %s",
-			 llvm_objcopy, tmp_fn, btfe->filename);
+			 llvm_objcopy, tmp_fn, filename);
 
-		if (write(fd, btfe->data, btfe->size) == btfe->size &&
-		    !system(cmd))
+		if (write(fd, btf_data, btf_size) == btf_size && !system(cmd))
 			err = 0;
 
 		unlink(tmp_fn);
@@ -663,9 +669,15 @@ out:
 	return err;
 }
 
+static int libbpf_log(enum libbpf_print_level level, const char *format, va_list args)
+{
+	return vfprintf(stderr, format, args);
+}
+
 int btf_elf__encode(struct btf_elf *btfe, uint8_t flags)
 {
 	struct btf_header *hdr;
+	struct btf *btf;
 
 	/* Empty file, nothing to do, so... done! */
 	if (gobuffer__size(&btfe->types) == 0)
@@ -695,5 +707,17 @@ int btf_elf__encode(struct btf_elf *btfe, uint8_t flags)
 
 	*(char *)(btf_elf__nohdr_data(btfe) + hdr->str_off) = '\0';
 
-	return btf_elf__write(btfe);
+	libbpf_set_print(libbpf_log);
+
+	btf = btf__new(btfe->data, btfe->size);
+	if (IS_ERR(btf)) {
+		fprintf(stderr, "%s: btf__new failed!\n", __func__);
+		return -1;
+	}
+	if (btf__dedup(btf, NULL, NULL)) {
+		fprintf(stderr, "%s: btf__dedup failed!", __func__);
+		return -1;
+	}
+
+	return btf_elf__write(btfe->filename, btf);
 }
-- 
2.17.1

