Return-Path: <SRS0=Mj0V=T2=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3DF1C46470
	for <bpf@archiver.kernel.org>; Sun, 26 May 2019 00:01:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DE91214AE
	for <bpf@archiver.kernel.org>; Sun, 26 May 2019 00:01:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="jsqkwBY3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727504AbfEZABL (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Sat, 25 May 2019 20:01:11 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:45930 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727513AbfEZABK (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sat, 25 May 2019 20:01:10 -0400
Received: from pps.filterd (m0044008.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4PNwWZD005573
        for <bpf@vger.kernel.org>; Sat, 25 May 2019 17:01:10 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=facebook;
 bh=Eg2NjMtiqq9RcYgkn0SY1hCMAZBKyqpahjTEGeY82Nc=;
 b=jsqkwBY3u9apofekqL1Op0HzXpjz6PBBWPzCikZtGnnMaAj5DfoAuZr0xmy4SLrhH/cB
 8a67erReFMY8RoBFiQT69MIOyIoZDxyfNStfubRsfyhbwtebvTSpeqrx6QQ0IQ7YpP2M
 QlUJn7bKU/jgEYC9wQsCtNb+Ps7ke3MRkfQ= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2sq10q1ncu-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Sat, 25 May 2019 17:01:09 -0700
Received: from mx-out.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Sat, 25 May 2019 17:01:08 -0700
Received: by dev101.prn2.facebook.com (Postfix, from userid 137359)
        id EE57E86171C; Sat, 25 May 2019 17:01:01 -0700 (PDT)
Smtp-Origin-Hostprefix: dev
From:   Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Hostname: dev101.prn2.facebook.com
To:     <andrii.nakryiko@gmail.com>, <netdev@vger.kernel.org>,
        <bpf@vger.kernel.org>, <ast@fb.com>, <daniel@iogearbox.net>,
        <quentin.monnet@netronome.com>, <kernel-team@fb.com>
CC:     Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Cluster: prn2c23
Subject: [PATCH bpf-next] bpftool: auto-complete BTF IDs for btf dump
Date:   Sat, 25 May 2019 17:01:01 -0700
Message-ID: <20190526000101.112077-1-andriin@fb.com>
X-Mailer: git-send-email 2.17.1
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-25_17:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=472 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905250169
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
 tools/bpf/bpftool/bash-completion/bpftool | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/tools/bpf/bpftool/bash-completion/bpftool b/tools/bpf/bpftool/bash-completion/bpftool
index 75c01eafd3a1..fbbad0ed8e82 100644
--- a/tools/bpf/bpftool/bash-completion/bpftool
+++ b/tools/bpf/bpftool/bash-completion/bpftool
@@ -71,6 +71,12 @@ _bpftool_get_prog_tags()
         command sed -n 's/.*"tag": "\(.*\)",$/\1/p' )" -- "$cur" ) )
 }
 
+_bpftool_get_btf_ids()
+{
+    COMPREPLY+=( $( compgen -W "$( bpftool -jp prog 2>&1 | \
+        command sed -n 's/.*"btf_id": \(.*\),\?$/\1/p' )" -- "$cur" ) )
+}
+
 _bpftool_get_obj_map_names()
 {
     local obj
@@ -635,6 +641,9 @@ _bpftool()
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

