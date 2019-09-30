Return-Path: <SRS0=vQPo=XZ=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A21EC32792
	for <bpf@archiver.kernel.org>; Mon, 30 Sep 2019 22:16:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E893020815
	for <bpf@archiver.kernel.org>; Mon, 30 Sep 2019 22:16:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="p96YeHgR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730176AbfI3WQO (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 30 Sep 2019 18:16:14 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:28676 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726590AbfI3WQO (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 30 Sep 2019 18:16:14 -0400
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.42/8.16.0.42) with SMTP id x8UMC01o009531
        for <bpf@vger.kernel.org>; Mon, 30 Sep 2019 15:16:09 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=facebook;
 bh=ksBZK73P+9iV095l6KAewxzw5v+Nv0i/kuDTbkxM0Y4=;
 b=p96YeHgRGRhbad+nhSl/FZD7SAJBdw2E6tQXvTDQ0mYI0doojMv6/g1emxwY2rt+pSYj
 Md5g9s/YiJjMRTts1XecmKnOzYZi/QRc5EyNnksaHAHTyrzNYFz0eYbw0G5e8/XL1j4R
 g2rqdTENGxPs8gFu8xhudOKI2KJy41eRArc= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by m0089730.ppops.net with ESMTP id 2vbq6g8vgw-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 30 Sep 2019 15:16:09 -0700
Received: from mx-out.facebook.com (2620:10d:c081:10::13) by
 mail.thefacebook.com (2620:10d:c081:35::129) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1713.5;
 Mon, 30 Sep 2019 15:16:07 -0700
Received: by dev101.prn2.facebook.com (Postfix, from userid 137359)
        id 20BC2861880; Mon, 30 Sep 2019 15:16:07 -0700 (PDT)
Smtp-Origin-Hostprefix: dev
From:   Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Hostname: dev101.prn2.facebook.com
To:     <bpf@vger.kernel.org>, <netdev@vger.kernel.org>, <ast@fb.com>,
        <daniel@iogearbox.net>
CC:     <andrii.nakryiko@gmail.com>, <kernel-team@fb.com>,
        Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Cluster: prn2c23
Subject: [PATCH bpf-next] libbpf: dump current version to v0.0.6
Date:   Mon, 30 Sep 2019 15:16:04 -0700
Message-ID: <20190930221604.491942-1-andriin@fb.com>
X-Mailer: git-send-email 2.17.1
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-09-30_12:2019-09-30,2019-09-30 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 bulkscore=0 spamscore=0
 clxscore=1015 suspectscore=8 phishscore=0 adultscore=0 lowpriorityscore=0
 malwarescore=0 impostorscore=0 mlxscore=0 mlxlogscore=546
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1909300183
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

New release cycle started, let's bump to v0.0.6 proactively.

Signed-off-by: Andrii Nakryiko <andriin@fb.com>
---
 tools/lib/bpf/libbpf.map | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
index d04c7cb623ed..8d10ca03d78d 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -190,3 +190,6 @@ LIBBPF_0.0.5 {
 	global:
 		bpf_btf_get_next_id;
 } LIBBPF_0.0.4;
+
+LIBBPF_0.0.6 {
+} LIBBPF_0.0.5;
-- 
2.17.1

