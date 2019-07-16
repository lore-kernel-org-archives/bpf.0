Return-Path: <SRS0=q5+7=VN=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9899C76192
	for <bpf@archiver.kernel.org>; Tue, 16 Jul 2019 03:57:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DA1220693
	for <bpf@archiver.kernel.org>; Tue, 16 Jul 2019 03:57:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="hJGM//5j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731521AbfGPD5L (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 15 Jul 2019 23:57:11 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:34582 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730768AbfGPD5K (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 15 Jul 2019 23:57:10 -0400
Received: from pps.filterd (m0001255.ppops.net [127.0.0.1])
        by mx0b-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6G3ufTF030109
        for <bpf@vger.kernel.org>; Mon, 15 Jul 2019 20:57:09 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=facebook;
 bh=oFGGz2z/t/QcKCLsOtAUIcam8nQf+r/RcT547J6LTYI=;
 b=hJGM//5jUimTy0gDSpCCf25nzJ9G9pFirEyCsZxSdq6neGNw6t2LbziMOXZNFDFWpMyg
 NMXuGlUsIgMyPVwwNT9opFonfYkawcb+ZzOUoadmG1Mki0eYVH6ldg8vvYqKEg7fzaAj
 ZC4vnbgq6j5g111of0AJjWcTy41x0AciVBM= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0b-00082601.pphosted.com with ESMTP id 2trqxmk4hb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 15 Jul 2019 20:57:09 -0700
Received: from mx-out.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 15 Jul 2019 20:57:08 -0700
Received: by dev101.prn2.facebook.com (Postfix, from userid 137359)
        id 59BBA861595; Mon, 15 Jul 2019 20:57:06 -0700 (PDT)
Smtp-Origin-Hostprefix: dev
From:   Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Hostname: dev101.prn2.facebook.com
To:     <ast@fb.com>, <daniel@iogearbox.net>, <bpf@vger.kernel.org>,
        <netdev@vger.kernel.org>
CC:     <andrii.nakryiko@gmail.com>, <kernel-team@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        Magnus Karlsson <magnus.karlsson@intel.com>
Smtp-Origin-Cluster: prn2c23
Subject: [PATCH bpf] libbpf: fix another GCC8 warning for strncpy
Date:   Mon, 15 Jul 2019 20:57:03 -0700
Message-ID: <20190716035704.948081-1-andriin@fb.com>
X-Mailer: git-send-email 2.17.1
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-16_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1907160049
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Similar issue was fixed in cdfc7f888c2a ("libbpf: fix GCC8 warning for
strncpy") already. This one was missed. Fixing now.

Cc: Magnus Karlsson <magnus.karlsson@intel.com>
Signed-off-by: Andrii Nakryiko <andriin@fb.com>
---
 tools/lib/bpf/xsk.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/lib/bpf/xsk.c b/tools/lib/bpf/xsk.c
index b33740221b7e..5007b5d4fd2c 100644
--- a/tools/lib/bpf/xsk.c
+++ b/tools/lib/bpf/xsk.c
@@ -517,7 +517,8 @@ int xsk_socket__create(struct xsk_socket **xsk_ptr, const char *ifname,
 		err = -errno;
 		goto out_socket;
 	}
-	strncpy(xsk->ifname, ifname, IFNAMSIZ);
+	strncpy(xsk->ifname, ifname, IFNAMSIZ - 1);
+	xsk->ifname[IFNAMSIZ - 1] = '\0';
 
 	err = xsk_set_xdp_socket_config(&xsk->config, usr_config);
 	if (err)
-- 
2.17.1

