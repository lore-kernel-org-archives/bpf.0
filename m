Return-Path: <SRS0=aERf=S3=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35950C4321B
	for <bpf@archiver.kernel.org>; Thu, 25 Apr 2019 22:30:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51C4420717
	for <bpf@archiver.kernel.org>; Thu, 25 Apr 2019 22:30:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="ZLk75E3A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729008AbfDYWaW (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 25 Apr 2019 18:30:22 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:58526 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726126AbfDYWaV (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 25 Apr 2019 18:30:21 -0400
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3PMSnMg020852
        for <bpf@vger.kernel.org>; Thu, 25 Apr 2019 15:30:20 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : subject :
 date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=nMyYTDbx5Aq0JenjU5Gn/+WocOKnb4O6DRmWLQLFez0=;
 b=ZLk75E3A9WS5gyWSWATN48MyhErf36KyYI/SrqboDvozABtlWcbk6lQ1+YIrLtqmquAH
 FD+sx8nNwRf2/bQNnl/H3i1kfRllizPRrp7vrO9ddp19ave3mTVrDld1nbsX56z/oqCx
 XfojGGF/fPrr7vVGtRyyhySgWMGDDEXoPTo= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2s3jt40pt5-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 25 Apr 2019 15:30:20 -0700
Received: from mx-out.facebook.com (2620:10d:c081:10::13) by
 mail.thefacebook.com (2620:10d:c081:35::126) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1713.5;
 Thu, 25 Apr 2019 15:30:18 -0700
Received: by dev101.prn2.facebook.com (Postfix, from userid 137359)
        id 0C6868615AE; Thu, 25 Apr 2019 15:30:18 -0700 (PDT)
Smtp-Origin-Hostprefix: dev
From:   Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Hostname: dev101.prn2.facebook.com
To:     <andrii.nakryiko@gmail.com>, <netdev@vger.kernel.org>,
        <bpf@vger.kernel.org>
Smtp-Origin-Cluster: prn2c23
Subject: [PATCH v4 bpf-next 3/4] bpftool: add bash completions for btf command
Date:   Thu, 25 Apr 2019 15:30:10 -0700
Message-ID: <20190425223011.284686-4-andriin@fb.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190425223011.284686-1-andriin@fb.com>
References: <20190425223011.284686-1-andriin@fb.com>
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-25_18:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add full support for btf command in bash-completion script.

Cc: Quentin Monnet <quentin.monnet@netronome.com>
Cc: Yonghong Song <yhs@fb.com>
Cc: Alexei Starovoitov <ast@fb.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Reviewed-by: Quentin Monnet <quentin.monnet@netronome.com>
Signed-off-by: Andrii Nakryiko <andriin@fb.com>
---
 tools/bpf/bpftool/bash-completion/bpftool | 46 +++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/tools/bpf/bpftool/bash-completion/bpftool b/tools/bpf/bpftool/bash-completion/bpftool
index 9f3ffe1e26ab..bca91d04ed35 100644
--- a/tools/bpf/bpftool/bash-completion/bpftool
+++ b/tools/bpf/bpftool/bash-completion/bpftool
@@ -217,6 +217,7 @@ _bpftool()
     done
     cur=${words[cword]}
     prev=${words[cword - 1]}
+    pprev=${words[cword - 2]}
 
     local object=${words[1]} command=${words[2]}
 
@@ -607,6 +608,51 @@ _bpftool()
                     ;;
             esac
             ;;
+        btf)
+            local PROG_TYPE='id pinned tag'
+            local MAP_TYPE='id pinned'
+            case $command in
+                dump)
+                    case $prev in
+                        $command)
+                            COMPREPLY+=( $( compgen -W "id map prog file" -- \
+                                "$cur" ) )
+                            return 0
+                            ;;
+                        prog)
+                            COMPREPLY=( $( compgen -W "$PROG_TYPE" -- "$cur" ) )
+                            return 0
+                            ;;
+                        map)
+                            COMPREPLY=( $( compgen -W "$MAP_TYPE" -- "$cur" ) )
+                            return 0
+                            ;;
+                        id)
+                            case $pprev in
+                                prog)
+                                    _bpftool_get_prog_ids
+                                    ;;
+                                map)
+                                    _bpftool_get_map_ids
+                                    ;;
+                            esac
+                            return 0
+                            ;;
+                        *)
+                            if [[ $cword == 6 ]] && [[ ${words[3]} == "map" ]]; then
+                                 COMPREPLY+=( $( compgen -W 'key value kv all' -- \
+                                     "$cur" ) )
+                            fi
+                            return 0
+                            ;;
+                    esac
+                    ;;
+                *)
+                    [[ $prev == $object ]] && \
+                        COMPREPLY=( $( compgen -W 'dump help' -- "$cur" ) )
+                    ;;
+            esac
+            ;;
         cgroup)
             case $command in
                 show|list)
-- 
2.17.1

