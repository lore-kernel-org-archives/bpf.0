Return-Path: <SRS0=Kw1S=Q6=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D4D7C10F0B
	for <bpf@archiver.kernel.org>; Sat, 23 Feb 2019 17:44:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48A27206B6
	for <bpf@archiver.kernel.org>; Sat, 23 Feb 2019 17:44:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550943873;
	bh=gOlspIQIq5EWsGZI246XFpY+oDN9hLB47V0e+3UpWSI=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-ID:From;
	b=CP4bAgKLHFN15IX9n8+J6WR85GepRZ84LQcNLFYViyiQ7RzBYCUP1L+OYYJ0VTnS3
	 t965P4EkDjzsH2FQht1fM31YypELq6hmJ0Jiu2IOh6JuFRPOYbGGLNTe1NUnN72rgJ
	 S1GbSp5NnhhS6mV7s6alMykBWr18PoPM5Vw1Siwo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726183AbfBWRoa convert rfc822-to-8bit (ORCPT
        <rfc822;bpf@archiver.kernel.org>); Sat, 23 Feb 2019 12:44:30 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:59386 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726203AbfBWRoa (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sat, 23 Feb 2019 12:44:30 -0500
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.27/8.16.0.27) with SMTP id x1NHbZLJ006521
        for <bpf@vger.kernel.org>; Sat, 23 Feb 2019 09:44:29 -0800
Received: from maileast.thefacebook.com ([199.201.65.23])
        by m0001303.ppops.net with ESMTP id 2quapxr0j9-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Sat, 23 Feb 2019 09:44:29 -0800
Received: from mx-out.facebook.com (2620:10d:c0a1:3::13) by
 mail.thefacebook.com (2620:10d:c021:18::173) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1531.3;
 Sat, 23 Feb 2019 09:44:28 -0800
Received: by devbig007.ftw2.facebook.com (Postfix, from userid 572438)
        id 06A85760812; Sat, 23 Feb 2019 09:44:26 -0800 (PST)
Smtp-Origin-Hostprefix: devbig
From:   Alexei Starovoitov <ast@kernel.org>
Smtp-Origin-Hostname: devbig007.ftw2.facebook.com
To:     <davem@davemloft.net>
CC:     <daniel@iogearbox.net>, <edumazet@google.com>,
        <netdev@vger.kernel.org>, <bpf@vger.kernel.org>,
        <kernel-team@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH v2 bpf-next 2/4] bpf: expose program stats via bpf_prog_info
Date:   Sat, 23 Feb 2019 09:44:20 -0800
Message-ID: <20190223174422.663270-3-ast@kernel.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20190223174422.663270-1-ast@kernel.org>
References: <20190223174422.663270-1-ast@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-23_11:,,
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
index 9a8c990c5df4..3405e0a4cf77 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -2152,6 +2152,7 @@ static int bpf_prog_get_info_by_fd(struct bpf_prog *prog,
 	struct bpf_prog_info __user *uinfo = u64_to_user_ptr(attr->info.info);
 	struct bpf_prog_info info = {};
 	u32 info_len = attr->info.info_len;
+	struct bpf_prog_stats stats;
 	char __user *uinsns;
 	u32 ulen;
 	int err;
@@ -2191,6 +2192,10 @@ static int bpf_prog_get_info_by_fd(struct bpf_prog *prog,
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

