Return-Path: <SRS0=j30r=B4=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0498AC433E3
	for <bpf@archiver.kernel.org>; Tue, 18 Aug 2020 16:24:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D15462076E
	for <bpf@archiver.kernel.org>; Tue, 18 Aug 2020 16:24:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="i1S3IDsT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726739AbgHRQYd (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 18 Aug 2020 12:24:33 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:37952 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726713AbgHRQYU (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 18 Aug 2020 12:24:20 -0400
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07IGNSMR011420
        for <bpf@vger.kernel.org>; Tue, 18 Aug 2020 09:24:19 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=uivpPlGrhYZz9V9w7N8wqLijUdhA/Lsu7oxgPtK9cK0=;
 b=i1S3IDsT1J/YvpfgmXO+kaXMd1qeD7Zg8CG3g7FAnNEhPMhQZArcKpqCc7c/linxzK9R
 K8B+3u2h6TdZ3Q3UIviD3pPYL9dF2uHl2uquBqaQF9KJtIOrgtIEUNsnxAse26c/NlD4
 VqAHx67G9BeLtJ0A8rkJSNlL9kQlG0CaJ8Y= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3304p7unr9-8
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 18 Aug 2020 09:24:19 -0700
Received: from intmgw005.03.ash8.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:21d::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 18 Aug 2020 09:24:13 -0700
Received: by devbig003.ftw2.facebook.com (Postfix, from userid 128203)
        id A3EAB37036A5; Tue, 18 Aug 2020 09:24:09 -0700 (PDT)
Smtp-Origin-Hostprefix: devbig
From:   Yonghong Song <yhs@fb.com>
Smtp-Origin-Hostname: devbig003.ftw2.facebook.com
To:     <bpf@vger.kernel.org>, <netdev@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>,
        Rik van Riel <riel@surriel.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH bpf 2/2] bpf: avoid visit same object multiple times
Date:   Tue, 18 Aug 2020 09:24:09 -0700
Message-ID: <20200818162409.837005-1-yhs@fb.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200818162408.836759-1-yhs@fb.com>
References: <20200818162408.836759-1-yhs@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-18_11:2020-08-18,2020-08-18 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 suspectscore=8
 adultscore=0 priorityscore=1501 malwarescore=0 mlxlogscore=787
 clxscore=1015 spamscore=0 bulkscore=0 mlxscore=0 lowpriorityscore=0
 phishscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2006250000 definitions=main-2008180116
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Currently when traversing all tasks, the next tid
is always increased by one. This may result in
visiting the same task multiple times in a
pid namespace.

This patch fixed the issue by seting the next
tid as pid_nr_ns(pid, ns) + 1, similar to
funciton next_tgid().

Cc: Rik van Riel <riel@surriel.com>
Signed-off-by: Yonghong Song <yhs@fb.com>
---
 kernel/bpf/task_iter.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/task_iter.c b/kernel/bpf/task_iter.c
index 885b14cab2c0..d6e1a141ea5c 100644
--- a/kernel/bpf/task_iter.c
+++ b/kernel/bpf/task_iter.c
@@ -31,8 +31,9 @@ static struct task_struct *task_seq_get_next(struct pid=
_namespace *ns,
=20
 	rcu_read_lock();
 retry:
-	pid =3D idr_get_next(&ns->idr, tid);
+	pid =3D find_ge_pid(*tid, ns);
 	if (pid) {
+		*tid =3D pid_nr_ns(pid, ns);
 		task =3D get_pid_task(pid, PIDTYPE_PID);
 		if (!task) {
 			++*tid;
--=20
2.24.1

