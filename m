Return-Path: <SRS0=zbR4=RA=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85AA5C43381
	for <bpf@archiver.kernel.org>; Mon, 25 Feb 2019 22:29:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48B0620643
	for <bpf@archiver.kernel.org>; Mon, 25 Feb 2019 22:29:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551133744;
	bh=QPQfpfYd3X/eWbOQaD0qZOTtDVVHw3tf7RkRrLPcoCo=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-ID:From;
	b=J/gmHzH8j7oS80qPsxMvb0zfIe+5HGmeIeeQj1MmFqe1eVBJ17KU7Ozm6z/ImmsI5
	 tQ6KWB2Zssci3fwW3FDBesXyHKNkWwJA4rAQ/cyrKT6isoE3qYI+YCJ/YnT3PBTqeV
	 TurdsNLJIVIkMyvJ84PfzXgQDIpPLIl7g3fv3n00=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727559AbfBYW3E convert rfc822-to-8bit (ORCPT
        <rfc822;bpf@archiver.kernel.org>); Mon, 25 Feb 2019 17:29:04 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:36800 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727554AbfBYW3D (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 25 Feb 2019 17:29:03 -0500
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1PMSxLW023877
        for <bpf@vger.kernel.org>; Mon, 25 Feb 2019 14:29:03 -0800
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2qvpwu0hgv-12
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 25 Feb 2019 14:29:02 -0800
Received: from mx-out.facebook.com (2620:10d:c0a1:3::13) by
 mail.thefacebook.com (2620:10d:c021:18::171) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1531.3;
 Mon, 25 Feb 2019 14:28:48 -0800
Received: by devbig007.ftw2.facebook.com (Postfix, from userid 572438)
        id 4A50E76091F; Mon, 25 Feb 2019 14:28:48 -0800 (PST)
Smtp-Origin-Hostprefix: devbig
From:   Alexei Starovoitov <ast@kernel.org>
Smtp-Origin-Hostname: devbig007.ftw2.facebook.com
To:     <davem@davemloft.net>
CC:     <daniel@iogearbox.net>, <edumazet@google.com>,
        <netdev@vger.kernel.org>, <bpf@vger.kernel.org>,
        <kernel-team@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH v3 bpf-next 3/4] tools/bpf: sync bpf.h into tools
Date:   Mon, 25 Feb 2019 14:28:41 -0800
Message-ID: <20190225222842.2031962-4-ast@kernel.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20190225222842.2031962-1-ast@kernel.org>
References: <20190225222842.2031962-1-ast@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-25_12:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

sync bpf.h into tools directory

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 tools/include/uapi/linux/bpf.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index bcdd2474eee7..2e308e90ffea 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -2813,6 +2813,8 @@ struct bpf_prog_info {
 	__u32 jited_line_info_rec_size;
 	__u32 nr_prog_tags;
 	__aligned_u64 prog_tags;
+	__u64 run_time_ns;
+	__u64 run_cnt;
 } __attribute__((aligned(8)));
 
 struct bpf_map_info {
-- 
2.20.0

