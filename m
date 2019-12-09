Return-Path: <SRS0=w0EI=Z7=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95762C04E30
	for <bpf@archiver.kernel.org>; Mon,  9 Dec 2019 22:40:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57FAE206E0
	for <bpf@archiver.kernel.org>; Mon,  9 Dec 2019 22:40:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="L5dFef6Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726230AbfLIWk3 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 9 Dec 2019 17:40:29 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:44340 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726532AbfLIWk3 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 9 Dec 2019 17:40:29 -0500
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xB9MV7bh021825
        for <bpf@vger.kernel.org>; Mon, 9 Dec 2019 14:40:28 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=facebook;
 bh=5KndjY6T0rVtMxNfxZjvXm0MPE0jySiCpTiD5kH+QaY=;
 b=L5dFef6QCgJZnS3sPA94iznk2PcGQVwSFaDDOu9KxGvSsBmJi8i/6A2CZ2IGZCcgNl9a
 uyA2cai3N9LKBtpMLMxvjcm3ITXB/+e3fR7HiEdhAVNDF7HAPWuQ1zG1uv82j6bd8xHM
 9U3xHMmiCvG7zkI0be/cEOLes9Rth1cThsQ= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2wrvh0fgu0-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 09 Dec 2019 14:40:28 -0800
Received: from intmgw003.06.prn3.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 9 Dec 2019 14:40:26 -0800
Received: by devbig012.ftw2.facebook.com (Postfix, from userid 137359)
        id 5BC7E2EC1D03; Mon,  9 Dec 2019 14:40:23 -0800 (PST)
Smtp-Origin-Hostprefix: devbig
From:   Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Hostname: devbig012.ftw2.facebook.com
To:     <bpf@vger.kernel.org>, <netdev@vger.kernel.org>, <ast@fb.com>,
        <daniel@iogearbox.net>
CC:     <andrii.nakryiko@gmail.com>, <kernel-team@fb.com>,
        Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH bpf] libbpf: Bump libpf current version to v0.0.7
Date:   Mon, 9 Dec 2019 14:40:22 -0800
Message-ID: <20191209224022.3544519-1-andriin@fb.com>
X-Mailer: git-send-email 2.17.1
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-09_05:2019-12-09,2019-12-09 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 impostorscore=0 clxscore=1015 mlxscore=0 mlxlogscore=789 suspectscore=0
 malwarescore=0 lowpriorityscore=0 phishscore=0 adultscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1912090178
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

New development cycles starts, bump to v0.0.7 proactively.

Signed-off-by: Andrii Nakryiko <andriin@fb.com>
---
 tools/lib/bpf/libbpf.map | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
index 8ddc2c40e482..495df575f87f 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -208,3 +208,6 @@ LIBBPF_0.0.6 {
 		btf__find_by_name_kind;
 		libbpf_find_vmlinux_btf_id;
 } LIBBPF_0.0.5;
+
+LIBBPF_0.0.7 {
+} LIBBPF_0.0.6;
-- 
2.17.1

