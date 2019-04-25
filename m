Return-Path: <SRS0=aERf=S3=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64257C43218
	for <bpf@archiver.kernel.org>; Thu, 25 Apr 2019 22:30:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 804E02084F
	for <bpf@archiver.kernel.org>; Thu, 25 Apr 2019 22:30:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="isound/d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727312AbfDYWaX (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 25 Apr 2019 18:30:23 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:58532 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729013AbfDYWaX (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 25 Apr 2019 18:30:23 -0400
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3PMSnMi020852
        for <bpf@vger.kernel.org>; Thu, 25 Apr 2019 15:30:22 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : subject :
 date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=XtkT+BBsm1NdSHseiqpl4P2KsqFAljrftHk0sLGWz5I=;
 b=isound/df3Yd43JmEDhqxxhP0CWauJyG4scuKC4zlSGA76+4qQi4vBPL+pyt7LddMrb1
 RIMhG+BWDrmq6iwkjeNhgE2nFZ4bNCQdmqYCUJBQGZcgGMoGia0P36/4ukxG4gW0r5MJ
 aZmjbDTmdgthgYSGI00l7/djym//kqCF1JY= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2s3jt40ptb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 25 Apr 2019 15:30:22 -0700
Received: from mx-out.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::d) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 25 Apr 2019 15:30:21 -0700
Received: by dev101.prn2.facebook.com (Postfix, from userid 137359)
        id 176EA8615AE; Thu, 25 Apr 2019 15:30:20 -0700 (PDT)
Smtp-Origin-Hostprefix: dev
From:   Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Hostname: dev101.prn2.facebook.com
To:     <andrii.nakryiko@gmail.com>, <netdev@vger.kernel.org>,
        <bpf@vger.kernel.org>
Smtp-Origin-Cluster: prn2c23
Subject: [PATCH v4 bpf-next 4/4] bpftool: fix indendation in bash-completion/bpftool
Date:   Thu, 25 Apr 2019 15:30:11 -0700
Message-ID: <20190425223011.284686-5-andriin@fb.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190425223011.284686-1-andriin@fb.com>
References: <20190425223011.284686-1-andriin@fb.com>
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-25_18:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=840 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904250138
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Fix misaligned default case branch for `prog dump` sub-command.

Reported-by: Quentin Monnet <quentin.monnet@netronome.com>
Cc: Yonghong Song <yhs@fb.com>
Reviewed-by: Quentin Monnet <quentin.monnet@netronome.com>
Signed-off-by: Andrii Nakryiko <andriin@fb.com>
---
 tools/bpf/bpftool/bash-completion/bpftool | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/tools/bpf/bpftool/bash-completion/bpftool b/tools/bpf/bpftool/bash-completion/bpftool
index bca91d04ed35..50e402a5a9c8 100644
--- a/tools/bpf/bpftool/bash-completion/bpftool
+++ b/tools/bpf/bpftool/bash-completion/bpftool
@@ -273,17 +273,17 @@ _bpftool()
                                 "$cur" ) )
                             return 0
                             ;;
-                    *)
-                        _bpftool_once_attr 'file'
-                        if _bpftool_search_list 'xlated'; then
-                            COMPREPLY+=( $( compgen -W 'opcodes visual linum' -- \
-                                "$cur" ) )
-                        else
-                            COMPREPLY+=( $( compgen -W 'opcodes linum' -- \
-                                "$cur" ) )
-                        fi
-                        return 0
-                        ;;
+                        *)
+                            _bpftool_once_attr 'file'
+                            if _bpftool_search_list 'xlated'; then
+                                COMPREPLY+=( $( compgen -W 'opcodes visual linum' -- \
+                                    "$cur" ) )
+                            else
+                                COMPREPLY+=( $( compgen -W 'opcodes linum' -- \
+                                    "$cur" ) )
+                            fi
+                            return 0
+                            ;;
                     esac
                     ;;
                 pin)
-- 
2.17.1

