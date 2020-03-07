Return-Path: <SRS0=NlDT=4Y=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B33DC10F25
	for <bpf@archiver.kernel.org>; Sat,  7 Mar 2020 00:17:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61351206E2
	for <bpf@archiver.kernel.org>; Sat,  7 Mar 2020 00:17:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="Qg4DHWhm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726769AbgCGARd (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 6 Mar 2020 19:17:33 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:34654 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726704AbgCGARd (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 6 Mar 2020 19:17:33 -0500
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0270GvR4001756
        for <bpf@vger.kernel.org>; Fri, 6 Mar 2020 16:17:32 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=gdFmlJTRxcq7QMjYODJoYXA513BFSRyf4af8ShgSyRA=;
 b=Qg4DHWhm3zvx23UDj3o8eGTwTHorJGdrlwpe3StBG0+fMNJ8SfJqS7AEV40b6HctDCwq
 OQQXK0UavcBuPekG8QBNhijPCdI4o9o8Pc2EPgfgwpu/W0JmUpQGDh8EPhjUT81VFebn
 bYw9QVIAd3YxrVMDXo6pePlEAvrZNdhSbBg= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 2yk7x8ekht-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 06 Mar 2020 16:17:32 -0800
Received: from intmgw003.03.ash8.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c085:21d::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1847.3; Fri, 6 Mar 2020 16:17:32 -0800
Received: by devbig006.ftw2.facebook.com (Postfix, from userid 4523)
        id 1EDF562E2880; Fri,  6 Mar 2020 16:17:27 -0800 (PST)
Smtp-Origin-Hostprefix: devbig
From:   Song Liu <songliubraving@fb.com>
Smtp-Origin-Hostname: devbig006.ftw2.facebook.com
To:     <netdev@vger.kernel.org>, <bpf@vger.kernel.org>
CC:     <quentin@isovalent.com>, <kernel-team@fb.com>, <ast@kernel.org>,
        <daniel@iogearbox.net>, <arnaldo.melo@gmail.com>,
        <jolsa@kernel.org>, Song Liu <songliubraving@fb.com>,
        Paul Chaignon <paul.chaignon@orange.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH v5 bpf-next 4/4] bpftool: fix typo in bash-completion
Date:   Fri, 6 Mar 2020 16:17:13 -0800
Message-ID: <20200307001713.3559880-5-songliubraving@fb.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200307001713.3559880-1-songliubraving@fb.com>
References: <20200307001713.3559880-1-songliubraving@fb.com>
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-03-06_09:2020-03-06,2020-03-06 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 clxscore=1015
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 malwarescore=0
 spamscore=0 phishscore=0 bulkscore=0 suspectscore=0 mlxlogscore=681
 mlxscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2003070000
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

_bpftool_get_map_names => _bpftool_get_prog_names for prog-attach|detach.

Fixes: 99f9863a0c45 ("bpftool: Match maps by name")
Cc: Paul Chaignon <paul.chaignon@orange.com>
Reviewed-by: Quentin Monnet <quentin@isovalent.com>
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

