Return-Path: <SRS0=2zuU=UY=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66389C48BD5
	for <bpf@archiver.kernel.org>; Tue, 25 Jun 2019 18:23:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E67B2086D
	for <bpf@archiver.kernel.org>; Tue, 25 Jun 2019 18:23:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="BceKwcdl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732927AbfFYSXS (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 25 Jun 2019 14:23:18 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:17362 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732924AbfFYSXR (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 25 Jun 2019 14:23:17 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5PI4wwl003283
        for <bpf@vger.kernel.org>; Tue, 25 Jun 2019 11:23:16 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=EbdI+tv3K3Ij6MyI3EN+D0t6s2Zu+exv/Pbe6ynvnic=;
 b=BceKwcdlORCMvjmuj+qKbyw8g9FRt/FCsgnGMWs1Q3fEuyPhtEu2ZWbfNP28lDNxvgoo
 v1u31tWIeNCxzZLDKnMchG0s6O3Ws0Y800sFFRVu7Irsx2BuV+rOaJ/1fsfoLaoDFKCB
 sBWK/V4PKyHqTmCJytWvwSPqhFAWGBGk560= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2tb3cmcmd5-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 25 Jun 2019 11:23:16 -0700
Received: from mx-out.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::d) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 25 Jun 2019 11:23:14 -0700
Received: by devbig006.ftw2.facebook.com (Postfix, from userid 4523)
        id A441F62E1DB8; Tue, 25 Jun 2019 11:23:13 -0700 (PDT)
Smtp-Origin-Hostprefix: devbig
From:   Song Liu <songliubraving@fb.com>
Smtp-Origin-Hostname: devbig006.ftw2.facebook.com
To:     <netdev@vger.kernel.org>, <bpf@vger.kernel.org>
CC:     <ast@kernel.org>, <daniel@iogearbox.net>, <kernel-team@fb.com>,
        Song Liu <songliubraving@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH bpf-next 3/4] libbpf: add libbpf_[get|put]_bpf_permission()
Date:   Tue, 25 Jun 2019 11:23:02 -0700
Message-ID: <20190625182303.874270-4-songliubraving@fb.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190625182303.874270-1-songliubraving@fb.com>
References: <20190625182303.874270-1-songliubraving@fb.com>
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-25_12:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906250137
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This patch adds two more API to libbpf: libbpf_get_bpf_permission() and
libbpf_put_bpf_permission().

For root, these two APIs are no-op.

Signed-off-by: Song Liu <songliubraving@fb.com>
---
 tools/lib/bpf/libbpf.c   | 54 ++++++++++++++++++++++++++++++++++++++++
 tools/lib/bpf/libbpf.h   |  7 ++++++
 tools/lib/bpf/libbpf.map |  2 ++
 3 files changed, 63 insertions(+)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 68f45a96769f..cf2d68268bde 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -35,6 +35,7 @@
 #include <sys/stat.h>
 #include <sys/types.h>
 #include <sys/vfs.h>
+#include <sys/ioctl.h>
 #include <tools/libc_compat.h>
 #include <libelf.h>
 #include <gelf.h>
@@ -4286,3 +4287,56 @@ int libbpf_num_possible_cpus(void)
 	}
 	return cpus;
 }
+
+LIBBPF_API bool libbpf_get_bpf_permission(void)
+{
+	char *cp, errmsg[STRERR_BUFSIZE];
+	int fd, ret;
+
+	if (geteuid() == 0)
+		return true;
+
+	fd = open(LIBBPF_DEV_BPF, O_RDONLY);
+	if (fd < 0) {
+		cp = libbpf_strerror_r(errno, errmsg, sizeof(errmsg));
+		pr_warning("failed to open %s: %s\n", LIBBPF_DEV_BPF, cp);
+		return false;
+	}
+
+	ret = ioctl(fd, BPF_DEV_IOCTL_GET_PERM);
+
+	if (ret) {
+		cp = libbpf_strerror_r(errno, errmsg, sizeof(errmsg));
+		pr_warning("failed to get BPF permission: %s\n", cp);
+		close(fd);
+		return false;
+	}
+	close(fd);
+	pr_debug("got BPF permission for non-privileged user\n");
+	return true;
+}
+
+LIBBPF_API void libbpf_put_bpf_permission(void)
+{
+	char *cp, errmsg[STRERR_BUFSIZE];
+	int fd, ret;
+
+	if (geteuid() == 0)
+		return;
+
+	fd = open(LIBBPF_DEV_BPF, O_RDONLY);
+	if (fd < 0) {
+		cp = libbpf_strerror_r(errno, errmsg, sizeof(errmsg));
+		pr_warning("failed to open %s: %s\n", LIBBPF_DEV_BPF, cp);
+		return;
+	}
+
+	ret = ioctl(fd, BPF_DEV_IOCTL_PUT_PERM);
+	if (ret) {
+		cp = libbpf_strerror_r(errno, errmsg, sizeof(errmsg));
+		pr_warning("failed to release BPF permission: %s\n", cp);
+		close(fd);
+	}
+	close(fd);
+	pr_debug("released BPF permission for non-privileged user\n");
+}
diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index d639f47e3110..22052c55a96c 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -470,6 +470,13 @@ bpf_program__bpil_offs_to_addr(struct bpf_prog_info_linear *info_linear);
  */
 LIBBPF_API int libbpf_num_possible_cpus(void);
 
+#define LIBBPF_DEV_BPF "/dev/bpf"
+
+/* (For non-root user) get permission to access bpf() syscall */
+LIBBPF_API bool libbpf_get_bpf_permission(void);
+/* (For non-root user) put permission to access bpf() syscall */
+LIBBPF_API void libbpf_put_bpf_permission(void);
+
 #ifdef __cplusplus
 } /* extern "C" */
 #endif
diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
index 2c6d835620d2..93a2c4175fdd 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -173,4 +173,6 @@ LIBBPF_0.0.4 {
 		btf__parse_elf;
 		bpf_object__load_xattr;
 		libbpf_num_possible_cpus;
+		libbpf_get_bpf_permission;
+		libbpf_put_bpf_permission;
 } LIBBPF_0.0.3;
-- 
2.17.1

