Return-Path: <SRS0=adOE=RE=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88434C43381
	for <bpf@archiver.kernel.org>; Fri,  1 Mar 2019 01:37:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 526B92085A
	for <bpf@archiver.kernel.org>; Fri,  1 Mar 2019 01:37:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="aLcCc0AC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387439AbfCABhX (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 28 Feb 2019 20:37:23 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:48524 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387414AbfCABhX (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 28 Feb 2019 20:37:23 -0500
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x211XUtc020349
        for <bpf@vger.kernel.org>; Thu, 28 Feb 2019 17:37:22 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=CSItEOvkoc/dog7TlQ+iYKD3toHID7DjBq6JoErf/D0=;
 b=aLcCc0AC+vinqN+0mApC8cCvXQwF6tkU98Y/lCj6FtNGS1VysXZgFH8tkRdMsGo2dLGP
 3wxj+nD3EEeHxA7k9CBMt6pTNE2+FuSfsJLOTj/UpsYwhKDL7OZff1VK75AicTYrVDGl
 zx3Btn3bH3rLFqjI4NPKtiTVK/jUxGohez0= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2qxtp7r36w-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 28 Feb 2019 17:37:22 -0800
Received: from mx-out.facebook.com (2620:10d:c0a1:3::13) by
 mail.thefacebook.com (2620:10d:c021:18::172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1713.5;
 Thu, 28 Feb 2019 17:37:20 -0800
Received: by devvm7221.prn2.facebook.com (Postfix, from userid 137359)
        id 30CBCC16CA33; Thu, 28 Feb 2019 17:37:19 -0800 (PST)
Smtp-Origin-Hostprefix: devvm
From:   Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Hostname: devvm7221.prn2.facebook.com
To:     <andrii.nakryiko@gmail.com>, <ast@fb.com>, <yhs@fb.com>,
        <netdev@vger.kernel.org>, <bpf@vger.kernel.org>,
        <daniel@iogearbox.net>, <songliubraving@fb.com>
CC:     Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Cluster: prn2c23
Subject: [PATCH bpf-next 1/4] bpf: formatting fixes in syscall.c
Date:   Thu, 28 Feb 2019 17:37:13 -0800
Message-ID: <20190301013716.1370014-2-andriin@fb.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190301013716.1370014-1-andriin@fb.com>
References: <20190301013716.1370014-1-andriin@fb.com>
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-01_01:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Fix few formatting errors.

Signed-off-by: Andrii Nakryiko <andriin@fb.com>
---
 kernel/bpf/syscall.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 174581dfe225..5272ba491e00 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -214,6 +214,7 @@ static int bpf_map_init_memlock(struct bpf_map *map)
 static void bpf_map_release_memlock(struct bpf_map *map)
 {
 	struct user_struct *user = map->user;
+
 	bpf_uncharge_memlock(user, map->pages);
 	free_uid(user);
 }
@@ -299,7 +300,7 @@ static void bpf_map_put_uref(struct bpf_map *map)
 }
 
 /* decrement map refcnt and schedule it for freeing via workqueue
- * (unrelying map implementation ops->map_free() might sleep)
+ * (underlying map implementation ops->map_free() might sleep)
  */
 static void __bpf_map_put(struct bpf_map *map, bool do_idr_lock)
 {
@@ -1414,7 +1415,7 @@ struct bpf_prog *bpf_prog_inc_not_zero(struct bpf_prog *prog)
 EXPORT_SYMBOL_GPL(bpf_prog_inc_not_zero);
 
 bool bpf_prog_get_ok(struct bpf_prog *prog,
-			    enum bpf_prog_type *attach_type, bool attach_drv)
+		     enum bpf_prog_type *attach_type, bool attach_drv)
 {
 	/* not an attachment, just a refcount inc, always allow */
 	if (!attach_type)
-- 
2.17.1

