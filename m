Return-Path: <SRS0=9soK=TZ=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0785DC282CE
	for <bpf@archiver.kernel.org>; Sat, 25 May 2019 05:38:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7F5F2133D
	for <bpf@archiver.kernel.org>; Sat, 25 May 2019 05:38:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="NVVm6h5g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726206AbfEYFiR (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Sat, 25 May 2019 01:38:17 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:40298 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726091AbfEYFiR (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sat, 25 May 2019 01:38:17 -0400
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4P5Z8JQ014777
        for <bpf@vger.kernel.org>; Fri, 24 May 2019 22:38:16 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=facebook;
 bh=6H5JKgxkjq5QbRBdsVmRIPKzSYAfrFHKk4vUQrO+X0o=;
 b=NVVm6h5gbXznHsE+8kmqDND+WRqnplD3dY+OkC2Q0/VPCtCzecBIS7UmG0PxmlUhMpBH
 mj42uBW2mHgXo9xOBp/3DwoVq8iQ4xTj1Kg3Q3m6Y8LOKvnZuEnNWX+Vjlw6lpmrpwy9
 X+q5nZEKGZ01P2Fvnr6BenqwxZ7k5CateIQ= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2spjbq2f3k-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 24 May 2019 22:38:16 -0700
Received: from mx-out.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Fri, 24 May 2019 22:38:14 -0700
Received: by dev101.prn2.facebook.com (Postfix, from userid 137359)
        id C3C1A86171B; Fri, 24 May 2019 22:38:12 -0700 (PDT)
Smtp-Origin-Hostprefix: dev
From:   Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Hostname: dev101.prn2.facebook.com
To:     <andrii.nakryiko@gmail.com>, <kernel-team@fb.com>,
        <netdev@vger.kernel.org>, <bpf@vger.kernel.org>, <ast@fb.com>,
        <daniel@iogearbox.net>, <quentin.monnet@netronome.com>
CC:     Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Cluster: prn2c23
Subject: [PATCH bpf-next] bpftool: auto-complete BTF IDs for btf dump
Date:   Fri, 24 May 2019 22:38:09 -0700
Message-ID: <20190525053809.1207929-1-andriin@fb.com>
X-Mailer: git-send-email 2.17.1
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-25_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=511 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905250038
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Auto-complete BTF IDs for `btf dump id` sub-command. List of possible BTF
IDs is scavenged from loaded BPF programs that have associated BTFs, as
there is currently no API in libbpf to fetch list of all BTFs in the
system.

Suggested-by: Quentin Monnet <quentin.monnet@netronome.com>
Signed-off-by: Andrii Nakryiko <andriin@fb.com>
---
 tools/bpf/bpftool/bash-completion/bpftool | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/tools/bpf/bpftool/bash-completion/bpftool b/tools/bpf/bpftool/bash-completion/bpftool
index 75c01eafd3a1..9fbc33e93689 100644
--- a/tools/bpf/bpftool/bash-completion/bpftool
+++ b/tools/bpf/bpftool/bash-completion/bpftool
@@ -71,6 +71,13 @@ _bpftool_get_prog_tags()
         command sed -n 's/.*"tag": "\(.*\)",$/\1/p' )" -- "$cur" ) )
 }
 
+_bpftool_get_btf_ids()
+{
+    COMPREPLY+=( $( compgen -W "$( bpftool -jp prog 2>&1 | \
+        command sed -n 's/.*"btf_id": \(.*\),\?$/\1/p' | \
+        command sort -nu )" -- "$cur" ) )
+}
+
 _bpftool_get_obj_map_names()
 {
     local obj
@@ -635,6 +642,9 @@ _bpftool()
                                 map)
                                     _bpftool_get_map_ids
                                     ;;
+                                dump)
+                                    _bpftool_get_btf_ids
+                                    ;;
                             esac
                             return 0
                             ;;
-- 
2.17.1

