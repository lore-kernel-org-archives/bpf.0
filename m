Return-Path: <SRS0=QYSm=4V=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 999F1C3F2D1
	for <bpf@archiver.kernel.org>; Wed,  4 Mar 2020 18:07:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D56D21556
	for <bpf@archiver.kernel.org>; Wed,  4 Mar 2020 18:07:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="qH2YBAkE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730068AbgCDSHg (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 4 Mar 2020 13:07:36 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:63590 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728361AbgCDSHf (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 4 Mar 2020 13:07:35 -0500
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 024I6DOe019973
        for <bpf@vger.kernel.org>; Wed, 4 Mar 2020 10:07:35 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=oZ9feTVsk79ERSNDwlBDt37K72Qzyp1AA2ALqmXIEvY=;
 b=qH2YBAkExyPxoJJMZqMmFjQEdXyq/NywTZ75vRHr8mbKmliA2MbBRi3QeuOVbBT06xnA
 wS/GodhrmmGmdcfpWMAjKXik6IHpPwHqp0eaSQBvMouFgpDSwVOzbmAY4fm36rr/z37h
 Cn4wvDYq0vpiDlvh1Fec0CxcSJc2LKnCgPw= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2yj2gj44bf-16
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 04 Mar 2020 10:07:35 -0800
Received: from intmgw004.08.frc2.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Wed, 4 Mar 2020 10:07:27 -0800
Received: by devbig006.ftw2.facebook.com (Postfix, from userid 4523)
        id 1D11F62E3375; Wed,  4 Mar 2020 10:07:23 -0800 (PST)
Smtp-Origin-Hostprefix: devbig
From:   Song Liu <songliubraving@fb.com>
Smtp-Origin-Hostname: devbig006.ftw2.facebook.com
To:     <netdev@vger.kernel.org>, <bpf@vger.kernel.org>
CC:     <quentin@isovalent.com>, <kernel-team@fb.com>, <ast@kernel.org>,
        <daniel@iogearbox.net>, <arnaldo.melo@gmail.com>,
        <jolsa@kernel.org>, Song Liu <songliubraving@fb.com>,
        Paul Chaignon <paul.chaignon@orange.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH v4 bpf-next 4/4] bpftool: fix typo in bash-completion
Date:   Wed, 4 Mar 2020 10:07:10 -0800
Message-ID: <20200304180710.2677695-5-songliubraving@fb.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200304180710.2677695-1-songliubraving@fb.com>
References: <20200304180710.2677695-1-songliubraving@fb.com>
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-03-04_07:2020-03-04,2020-03-04 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 malwarescore=0
 impostorscore=0 suspectscore=0 priorityscore=1501 lowpriorityscore=0
 adultscore=0 bulkscore=0 phishscore=0 spamscore=0 clxscore=1015 mlxscore=0
 mlxlogscore=743 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2003040124
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

_bpftool_get_map_names => _bpftool_get_prog_names for prog-attach|detach.

Fixes: 99f9863a0c45 ("bpftool: Match maps by name")
Cc: Paul Chaignon <paul.chaignon@orange.com>
Signed-off-by: Song Liu <songliubraving@fb.com>
---
 tools/bpf/bpftool/bash-completion/bpftool | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/bpf/bpftool/bash-completion/bpftool b/tools/bpf/bpftool/bash-completion/bpftool
index 49f4ab2f67e3..a9cce9d3745a 100644
--- a/tools/bpf/bpftool/bash-completion/bpftool
+++ b/tools/bpf/bpftool/bash-completion/bpftool
@@ -389,7 +389,7 @@ _bpftool()
                                     _bpftool_get_prog_ids
                                     ;;
                                 name)
-                                    _bpftool_get_map_names
+                                    _bpftool_get_prog_names
                                     ;;
                                 pinned)
                                     _filedir
-- 
2.17.1

