Return-Path: <SRS0=P0Qj=TY=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 950FAC282E1
	for <bpf@archiver.kernel.org>; Fri, 24 May 2019 18:59:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 656AE2184E
	for <bpf@archiver.kernel.org>; Fri, 24 May 2019 18:59:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="eobJM7PN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391664AbfEXS7R (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 24 May 2019 14:59:17 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:39732 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2391618AbfEXS7R (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 24 May 2019 14:59:17 -0400
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4OIo1HI019281
        for <bpf@vger.kernel.org>; Fri, 24 May 2019 11:59:16 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=i9KJsPXfMKWMU4yGosGCauJyd8EPlc91lPI8FQHp2j0=;
 b=eobJM7PNr9ddq8QAa5DecNlo1VFj1lNr/M8ngyqRT4b9UVy1/ay3KS8LJpXP9uaG5ACn
 7HIGmAD+M9Urs2Nv27PvfSJ4uxpTH08m/clRxergWJncG3Px8O/t/s9WZLB+pfHTOHmj
 wYB5a5yFxb15NiC37AoZ61aWgJxiwCMi/sw= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2spjbq0yq6-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 24 May 2019 11:59:15 -0700
Received: from mx-out.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Fri, 24 May 2019 11:59:14 -0700
Received: by dev101.prn2.facebook.com (Postfix, from userid 137359)
        id 22E3B8613DC; Fri, 24 May 2019 11:59:12 -0700 (PDT)
Smtp-Origin-Hostprefix: dev
From:   Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Hostname: dev101.prn2.facebook.com
To:     <andrii.nakryiko@gmail.com>, <ast@fb.com>, <daniel@iogearbox.net>,
        <netdev@vger.kernel.org>, <bpf@vger.kernel.org>,
        <kernel-team@fb.com>
CC:     Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Cluster: prn2c23
Subject: [PATCH v3 bpf-next 01/12] libbpf: ensure libbpf.h is included along libbpf_internal.h
Date:   Fri, 24 May 2019 11:58:56 -0700
Message-ID: <20190524185908.3562231-2-andriin@fb.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190524185908.3562231-1-andriin@fb.com>
References: <20190524185908.3562231-1-andriin@fb.com>
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-24_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=782 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905240122
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

libbpf_internal.h expects a bunch of stuff defined in libbpf.h to be
defined. This patch makes sure that libbpf.h is always included.

Signed-off-by: Andrii Nakryiko <andriin@fb.com>
---
 tools/lib/bpf/libbpf_internal.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/lib/bpf/libbpf_internal.h b/tools/lib/bpf/libbpf_internal.h
index f3025b4d90e1..850f7bdec5cb 100644
--- a/tools/lib/bpf/libbpf_internal.h
+++ b/tools/lib/bpf/libbpf_internal.h
@@ -9,6 +9,8 @@
 #ifndef __LIBBPF_LIBBPF_INTERNAL_H
 #define __LIBBPF_LIBBPF_INTERNAL_H
 
+#include "libbpf.h"
+
 #define BTF_INFO_ENC(kind, kind_flag, vlen) \
 	((!!(kind_flag) << 31) | ((kind) << 24) | ((vlen) & BTF_MAX_VLEN))
 #define BTF_TYPE_ENC(name, info, size_or_type) (name), (info), (size_or_type)
-- 
2.17.1

