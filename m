Return-Path: <SRS0=sv//=Q5=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF8DDC43381
	for <bpf@archiver.kernel.org>; Fri, 22 Feb 2019 23:37:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3A3C2070D
	for <bpf@archiver.kernel.org>; Fri, 22 Feb 2019 23:37:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550878620;
	bh=/dpEDM9nCbyHUJQja6DbCkc8Lse+t6/VaD87d1S1Wk8=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-ID:From;
	b=jo1hFPN2luJi7zJ57CKKapMjGk7FdP3W0KxXM94YCa6+QKdowv64biXSv1OzxQ0Tf
	 O5Ss3DVDi54o9Ud0cyc7me2LZOdmi0ANFvaqo19Oc0gjBISCLvDfzt1nxZeBScCssK
	 W0E9dGgPXbbSsmcmf/gYPsg0zT4VfEjU5D8xvVX0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727086AbfBVXhA convert rfc822-to-8bit (ORCPT
        <rfc822;bpf@archiver.kernel.org>); Fri, 22 Feb 2019 18:37:00 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:37774 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725821AbfBVXhA (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 22 Feb 2019 18:37:00 -0500
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1MNYtXU000437
        for <bpf@vger.kernel.org>; Fri, 22 Feb 2019 15:36:59 -0800
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2qtqqprmjn-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 22 Feb 2019 15:36:59 -0800
Received: from mx-out.facebook.com (2620:10d:c0a1:3::13) by
 mail.thefacebook.com (2620:10d:c021:18::171) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1531.3;
 Fri, 22 Feb 2019 15:36:49 -0800
Received: by devbig007.ftw2.facebook.com (Postfix, from userid 572438)
        id 11B3A760956; Fri, 22 Feb 2019 15:36:49 -0800 (PST)
Smtp-Origin-Hostprefix: devbig
From:   Alexei Starovoitov <ast@kernel.org>
Smtp-Origin-Hostname: devbig007.ftw2.facebook.com
To:     <davem@davemloft.net>
CC:     <daniel@iogearbox.net>, <netdev@vger.kernel.org>,
        <bpf@vger.kernel.org>, <kernel-team@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH bpf-next 2/4] bpf: expose program stats via bpf_prog_info
Date:   Fri, 22 Feb 2019 15:36:42 -0800
Message-ID: <20190222233644.1487087-3-ast@kernel.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20190222233644.1487087-1-ast@kernel.org>
References: <20190222233644.1487087-1-ast@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-22_15:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Return bpf program runtime and runcnt via bpf_prog_info

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 include/uapi/linux/bpf.h | 2 ++
 kernel/bpf/syscall.c     | 5 +++++
 2 files changed, 7 insertions(+)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index bcdd2474eee7..d2cb85d85b39 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -2813,6 +2813,8 @@ struct bpf_prog_info {
 	__u32 jited_line_info_rec_size;
 	__u32 nr_prog_tags;
 	__aligned_u64 prog_tags;
+	__u64 runtime;
+	__u64 runcnt;
 } __attribute__((aligned(8)));
 
 struct bpf_map_info {
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 079e7fa14f39..6c55aeb2e1b7 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -2142,6 +2142,7 @@ static int bpf_prog_get_info_by_fd(struct bpf_prog *prog,
 	struct bpf_prog_info __user *uinfo = u64_to_user_ptr(attr->info.info);
 	struct bpf_prog_info info = {};
 	u32 info_len = attr->info.info_len;
+	struct bpf_prog_stats stats;
 	char __user *uinsns;
 	u32 ulen;
 	int err;
@@ -2181,6 +2182,10 @@ static int bpf_prog_get_info_by_fd(struct bpf_prog *prog,
 	if (err)
 		return err;
 
+	bpf_prog_get_stats(prog, &stats);
+	info.runtime = stats.nsecs;
+	info.runcnt = stats.cnt;
+
 	if (!capable(CAP_SYS_ADMIN)) {
 		info.jited_prog_len = 0;
 		info.xlated_prog_len = 0;
-- 
2.20.0

