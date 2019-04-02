Return-Path: <SRS0=V8Hm=SE=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F164C4360F
	for <bpf@archiver.kernel.org>; Tue,  2 Apr 2019 04:28:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E297520882
	for <bpf@archiver.kernel.org>; Tue,  2 Apr 2019 04:28:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554179295;
	bh=/prIG6bzyoBtV0u4kLTeJOy4zIEDl8dOIK0D7a9E7Ro=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-ID:From;
	b=jxoLMsCoTphXila1z1TMUAe7w1bPZr6bJDd8GBNq4+xAaaqXY+OoaSPXbBk7WM30i
	 XUmcNB2oZ1IEbhvZnGbKaEEmsFTDBP/dIL1X0uyXcTxRLtIe0zQqqfJRheEW2fgT/s
	 xn2bFEkVK9t3KcPn2nAAfCMlEa626ic5OYlof6go=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728983AbfDBE2L convert rfc822-to-8bit (ORCPT
        <rfc822;bpf@archiver.kernel.org>); Tue, 2 Apr 2019 00:28:11 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:53570 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728940AbfDBE2K (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 2 Apr 2019 00:28:10 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x324KDPh008264
        for <bpf@vger.kernel.org>; Mon, 1 Apr 2019 21:28:09 -0700
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2rkqg3hvgn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 01 Apr 2019 21:28:09 -0700
Received: from mx-out.facebook.com (2620:10d:c0a1:3::13) by
 mail.thefacebook.com (2620:10d:c021:18::175) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1713.5;
 Mon, 1 Apr 2019 21:28:08 -0700
Received: by devbig007.ftw2.facebook.com (Postfix, from userid 572438)
        id E24FA760E11; Mon,  1 Apr 2019 21:28:05 -0700 (PDT)
Smtp-Origin-Hostprefix: devbig
From:   Alexei Starovoitov <ast@kernel.org>
Smtp-Origin-Hostname: devbig007.ftw2.facebook.com
To:     <davem@davemloft.net>
CC:     <daniel@iogearbox.net>, <jakub.kicinski@netronome.com>,
        <jannh@google.com>, <netdev@vger.kernel.org>,
        <bpf@vger.kernel.org>, <kernel-team@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH v2 bpf-next 08/10] libbpf: teach libbpf about log_level bit 2
Date:   Mon, 1 Apr 2019 21:27:47 -0700
Message-ID: <20190402042749.3670015-9-ast@kernel.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20190402042749.3670015-1-ast@kernel.org>
References: <20190402042749.3670015-1-ast@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-02_02:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Allow bpf_prog_load_xattr() to specify log_level for program loading.

Teach libbpf to accept log_level with bit 2 set.

Increase default BPF_LOG_BUF_SIZE from 256k to 16M.
There is no downside to increase it to a maximum allowed by old kernels.
Existing 256k limit caused ENOSPC errors and users were not able to see
verifier error which is printed at the end of the verifier log.

If ENOSPC is hit, double the verifier log and try again to capture
the verifier error.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 tools/lib/bpf/bpf.c    |  2 +-
 tools/lib/bpf/bpf.h    |  2 +-
 tools/lib/bpf/libbpf.c | 16 ++++++++++++++--
 tools/lib/bpf/libbpf.h |  1 +
 4 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
index 9cd015574e83..a1db869a6fda 100644
--- a/tools/lib/bpf/bpf.c
+++ b/tools/lib/bpf/bpf.c
@@ -223,7 +223,7 @@ int bpf_load_program_xattr(const struct bpf_load_program_attr *load_attr,
 		return -EINVAL;
 
 	log_level = load_attr->log_level;
-	if (log_level > 2 || (log_level && !log_buf))
+	if (log_level > (4 | 2 | 1) || (log_level && !log_buf))
 		return -EINVAL;
 
 	name_len = load_attr->name ? strlen(load_attr->name) : 0;
diff --git a/tools/lib/bpf/bpf.h b/tools/lib/bpf/bpf.h
index 6ffdd79bea89..e2c0df7b831f 100644
--- a/tools/lib/bpf/bpf.h
+++ b/tools/lib/bpf/bpf.h
@@ -92,7 +92,7 @@ struct bpf_load_program_attr {
 #define MAPS_RELAX_COMPAT	0x01
 
 /* Recommend log buffer size */
-#define BPF_LOG_BUF_SIZE (256 * 1024)
+#define BPF_LOG_BUF_SIZE (16 * 1024 * 1024) /* verifier maximum in kernels <= 5.1 */
 LIBBPF_API int
 bpf_load_program_xattr(const struct bpf_load_program_attr *load_attr,
 		       char *log_buf, size_t log_buf_sz);
diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 11c25d9ea431..e1e4d35cf08e 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -152,6 +152,7 @@ struct bpf_program {
 		};
 	} *reloc_desc;
 	int nr_reloc;
+	int log_level;
 
 	struct {
 		int nr;
@@ -1494,6 +1495,7 @@ load_program(struct bpf_program *prog, struct bpf_insn *insns, int insns_cnt,
 {
 	struct bpf_load_program_attr load_attr;
 	char *cp, errmsg[STRERR_BUFSIZE];
+	int log_buf_size = BPF_LOG_BUF_SIZE;
 	char *log_buf;
 	int ret;
 
@@ -1514,21 +1516,30 @@ load_program(struct bpf_program *prog, struct bpf_insn *insns, int insns_cnt,
 	load_attr.line_info = prog->line_info;
 	load_attr.line_info_rec_size = prog->line_info_rec_size;
 	load_attr.line_info_cnt = prog->line_info_cnt;
+	load_attr.log_level = prog->log_level;
 	if (!load_attr.insns || !load_attr.insns_cnt)
 		return -EINVAL;
 
-	log_buf = malloc(BPF_LOG_BUF_SIZE);
+retry_load:
+	log_buf = malloc(log_buf_size);
 	if (!log_buf)
 		pr_warning("Alloc log buffer for bpf loader error, continue without log\n");
 
-	ret = bpf_load_program_xattr(&load_attr, log_buf, BPF_LOG_BUF_SIZE);
+	ret = bpf_load_program_xattr(&load_attr, log_buf, log_buf_size);
 
 	if (ret >= 0) {
+		if (load_attr.log_level)
+			pr_debug("verifier log:\n%s", log_buf);
 		*pfd = ret;
 		ret = 0;
 		goto out;
 	}
 
+	if (errno == ENOSPC) {
+		log_buf_size <<= 1;
+		free(log_buf);
+		goto retry_load;
+	}
 	ret = -LIBBPF_ERRNO__LOAD;
 	cp = libbpf_strerror_r(errno, errmsg, sizeof(errmsg));
 	pr_warning("load bpf program failed: %s\n", cp);
@@ -2938,6 +2949,7 @@ int bpf_prog_load_xattr(const struct bpf_prog_load_attr *attr,
 		bpf_program__set_expected_attach_type(prog,
 						      expected_attach_type);
 
+		prog->log_level = attr->log_level;
 		if (!first_prog)
 			first_prog = prog;
 	}
diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index c70785cc8ef5..531323391d07 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -314,6 +314,7 @@ struct bpf_prog_load_attr {
 	enum bpf_prog_type prog_type;
 	enum bpf_attach_type expected_attach_type;
 	int ifindex;
+	int log_level;
 };
 
 LIBBPF_API int bpf_prog_load_xattr(const struct bpf_prog_load_attr *attr,
-- 
2.20.0

