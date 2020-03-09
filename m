Return-Path: <SRS0=BaJ4=42=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1861EC10F25
	for <bpf@archiver.kernel.org>; Mon,  9 Mar 2020 22:28:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E57652465A
	for <bpf@archiver.kernel.org>; Mon,  9 Mar 2020 22:28:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="KQMjU8dN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727218AbgCIW2D (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 9 Mar 2020 18:28:03 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:21084 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726656AbgCIW2D (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 9 Mar 2020 18:28:03 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 029MPKwR001923
        for <bpf@vger.kernel.org>; Mon, 9 Mar 2020 15:28:02 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=facebook;
 bh=VYktTU8k6TcxjlEF1sxonSr85v9yaegrXx4kZns5tUw=;
 b=KQMjU8dNAO8USBUhVaRdOU8SGCtoYw5FedvaZozRzt5AtWuy/m5UAjh+pj6OboZXmT3T
 VNaLJAr+R3VBN43W9SpYz+U60CG6m6sEE9S6q5C2aN0xguvaISAoUfLgMcpVgGGagMEl
 +M7S1fbUuLqmbXjxCxdiOOrnCUkVDCycoDM= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 2ymv2vf4ef-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 09 Mar 2020 15:28:02 -0700
Received: from intmgw002.08.frc2.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:11d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1847.3; Mon, 9 Mar 2020 15:28:01 -0700
Received: by devbig012.ftw2.facebook.com (Postfix, from userid 137359)
        id 67FFB2EC2A95; Mon,  9 Mar 2020 15:27:58 -0700 (PDT)
Smtp-Origin-Hostprefix: devbig
From:   Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Hostname: devbig012.ftw2.facebook.com
To:     <bpf@vger.kernel.org>, <netdev@vger.kernel.org>, <ast@fb.com>,
        <daniel@iogearbox.net>
CC:     <andrii.nakryiko@gmail.com>, <kernel-team@fb.com>,
        Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH bpf-next] bpf: initialize storage pointers to NULL to prevent freeing garbage pointer
Date:   Mon, 9 Mar 2020 15:27:55 -0700
Message-ID: <20200309222756.1018737-1-andriin@fb.com>
X-Mailer: git-send-email 2.17.1
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-03-09_11:2020-03-09,2020-03-09 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 malwarescore=0
 suspectscore=25 impostorscore=0 lowpriorityscore=0 phishscore=0
 adultscore=0 mlxscore=0 bulkscore=0 mlxlogscore=705 spamscore=0
 clxscore=1015 priorityscore=1501 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2001150001 definitions=main-2003090135
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Local storage array isn't initialized, so if cgroup storage allocation fails
for BPF_CGROUP_STORAGE_SHARED, error handling code will attempt to free
uninitialized pointer for BPF_CGROUP_STORAGE_PERCPI storage type. Avoid this
by always initializing storage pointers to NULLs.

Fixes: 8bad74f9840f ("bpf: extend cgroup bpf core to allow multiple cgroup storage types")
Signed-off-by: Andrii Nakryiko <andriin@fb.com>
---
 kernel/bpf/cgroup.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
index 9a500fadbef5..b2bc4c335bb1 100644
--- a/kernel/bpf/cgroup.c
+++ b/kernel/bpf/cgroup.c
@@ -302,8 +302,8 @@ int __cgroup_bpf_attach(struct cgroup *cgrp, struct bpf_prog *prog,
 	u32 saved_flags = (flags & (BPF_F_ALLOW_OVERRIDE | BPF_F_ALLOW_MULTI));
 	struct list_head *progs = &cgrp->bpf.progs[type];
 	struct bpf_prog *old_prog = NULL;
-	struct bpf_cgroup_storage *storage[MAX_BPF_CGROUP_STORAGE_TYPE],
-		*old_storage[MAX_BPF_CGROUP_STORAGE_TYPE] = {NULL};
+	struct bpf_cgroup_storage *storage[MAX_BPF_CGROUP_STORAGE_TYPE] = {};
+	struct bpf_cgroup_storage *old_storage[MAX_BPF_CGROUP_STORAGE_TYPE] = {};
 	struct bpf_prog_list *pl, *replace_pl = NULL;
 	enum bpf_cgroup_storage_type stype;
 	int err;
-- 
2.17.1

