Return-Path: <SRS0=8K48=Z2=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E384C43603
	for <bpf@archiver.kernel.org>; Wed,  4 Dec 2019 07:01:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 688BD2084B
	for <bpf@archiver.kernel.org>; Wed,  4 Dec 2019 07:01:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="DSm7owkc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727320AbfLDHBB (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 4 Dec 2019 02:01:01 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:52458 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727332AbfLDHA5 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 4 Dec 2019 02:00:57 -0500
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xB470blU026935
        for <bpf@vger.kernel.org>; Tue, 3 Dec 2019 23:00:56 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=qoQnl4Q8PMXkMLEQ3ky0X4fTwA8dHghjtxQU5dM5zG4=;
 b=DSm7owkcPwJKu/cqfCYMnY4VxwlrnkJMTdegxy5fKuqXP8obMs/kcWUrbxU8RH22pAAl
 Q1ImJYVWWjR1VsdDfBS7zYz4B/EaV7MZ0cU1UTeJPtywtRmsdzDFBiIm2/aSHFJBhhEe
 emSubVRoBPjuUQvHA/VF07hz8EBDfkcbL/g= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2wnsxpm7n0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 03 Dec 2019 23:00:56 -0800
Received: from 2401:db00:30:600c:face:0:39:0 (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 3 Dec 2019 23:00:55 -0800
Received: by devbig012.ftw2.facebook.com (Postfix, from userid 137359)
        id CD0F12EC1853; Tue,  3 Dec 2019 23:00:53 -0800 (PST)
Smtp-Origin-Hostprefix: devbig
From:   Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Hostname: devbig012.ftw2.facebook.com
To:     <bpf@vger.kernel.org>, <netdev@vger.kernel.org>, <ast@fb.com>,
        <daniel@iogearbox.net>
CC:     <andrii.nakryiko@gmail.com>, <kernel-team@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        Quentin Monnet <quentin.monnet@netronome.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [RFC PATCH bpf-next 16/16] bpftool: add `gen skeleton` BASH completions
Date:   Tue, 3 Dec 2019 23:00:15 -0800
Message-ID: <20191204070015.3523523-17-andriin@fb.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191204070015.3523523-1-andriin@fb.com>
References: <20191204070015.3523523-1-andriin@fb.com>
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-04_01:2019-12-04,2019-12-03 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 malwarescore=0
 adultscore=0 impostorscore=0 bulkscore=0 phishscore=0 suspectscore=8
 lowpriorityscore=0 mlxlogscore=897 mlxscore=0 spamscore=0 clxscore=1015
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1912040051
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add BASH completions for gen sub-command.

Cc: Quentin Monnet <quentin.monnet@netronome.com>
Signed-off-by: Andrii Nakryiko <andriin@fb.com>
---
 tools/bpf/bpftool/bash-completion/bpftool | 11 +++++++++++
 tools/bpf/bpftool/main.c                  |  2 +-
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/tools/bpf/bpftool/bash-completion/bpftool b/tools/bpf/bpftool/bash-completion/bpftool
index 70493a6da206..986519cc58d1 100644
--- a/tools/bpf/bpftool/bash-completion/bpftool
+++ b/tools/bpf/bpftool/bash-completion/bpftool
@@ -716,6 +716,17 @@ _bpftool()
                     ;;
             esac
             ;;
+        gen)
+            case $command in
+                skeleton)
+                    _filedir
+		    ;;
+                *)
+                    [[ $prev == $object ]] && \
+                        COMPREPLY=( $( compgen -W 'skeleton help' -- "$cur" ) )
+                    ;;
+            esac
+            ;;
         cgroup)
             case $command in
                 show|list|tree)
diff --git a/tools/bpf/bpftool/main.c b/tools/bpf/bpftool/main.c
index 758b294e8a7d..1fe91c558508 100644
--- a/tools/bpf/bpftool/main.c
+++ b/tools/bpf/bpftool/main.c
@@ -58,7 +58,7 @@ static int do_help(int argc, char **argv)
 		"       %s batch file FILE\n"
 		"       %s version\n"
 		"\n"
-		"       OBJECT := { prog | map | cgroup | perf | net | feature | btf }\n"
+		"       OBJECT := { prog | map | cgroup | perf | net | feature | btf | gen }\n"
 		"       " HELP_SPEC_OPTIONS "\n"
 		"",
 		bin_name, bin_name, bin_name);
-- 
2.17.1

