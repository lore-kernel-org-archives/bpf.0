Return-Path: <SRS0=rqwV=64=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48AB1C433DF
	for <bpf@archiver.kernel.org>; Thu, 14 May 2020 05:51:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 291B3206D4
	for <bpf@archiver.kernel.org>; Thu, 14 May 2020 05:51:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="NsETeR/N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725938AbgENFvv (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 14 May 2020 01:51:51 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:30660 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725794AbgENFvv (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 14 May 2020 01:51:51 -0400
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04E5ol6o024593
        for <bpf@vger.kernel.org>; Wed, 13 May 2020 22:51:50 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=M1q3eFU6/zlynsuFeMnyvS+5DWFbPkf6FSm+T/f8oW0=;
 b=NsETeR/N58k20MCP7LVLlQxuH1hn/pQ2kUGwmNBi3IO2LL/Hdj6IhDcC4/Rdb5G4bj2A
 y/RzYV37+W1CTJQ4Z1juxGy/wk4lR21vXWGnLNaYrh9GcBcxjbIb4ieuiehI6qdUsxkw
 cycE9V4+DktUg1/zuRV7SvZUmUlq0OK8U68= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3100x61fmv-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 13 May 2020 22:51:50 -0700
Received: from intmgw005.03.ash8.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1847.3; Wed, 13 May 2020 22:51:46 -0700
Received: by devbig012.ftw2.facebook.com (Postfix, from userid 137359)
        id DD3B32EC3946; Wed, 13 May 2020 22:51:39 -0700 (PDT)
Smtp-Origin-Hostprefix: devbig
From:   Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Hostname: devbig012.ftw2.facebook.com
To:     <bpf@vger.kernel.org>, <netdev@vger.kernel.org>, <ast@fb.com>,
        <daniel@iogearbox.net>
CC:     <andrii.nakryiko@gmail.com>, <kernel-team@fb.com>,
        Andrii Nakryiko <andriin@fb.com>, Yonghong Song <yhs@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH v2 bpf-next] bpf: fix bpf_iter's task iterator logic
Date:   Wed, 13 May 2020 22:51:37 -0700
Message-ID: <20200514055137.1564581-1-andriin@fb.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.676
 definitions=2020-05-13_09:2020-05-13,2020-05-13 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 mlxlogscore=908 spamscore=0 clxscore=1015 cotscore=-2147483648
 malwarescore=0 impostorscore=0 bulkscore=0 adultscore=0 priorityscore=1501
 phishscore=0 mlxscore=0 suspectscore=8 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2005140052
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

task_seq_get_next might stop prematurely if get_pid_task() fails to get
task_struct. Failure to do so doesn't mean that there are no more tasks w=
ith
higher pids. Procfs's iteration algorithm (see next_tgid in fs/proc/base.=
c)
does a retry in such case. After this fix, instead of stopping prematurel=
y
after about 300 tasks on my server, bpf_iter program now returns >4000, w=
hich
sounds much closer to reality.

Cc: Yonghong Song <yhs@fb.com>
Fixes: eaaacd23910f ("bpf: Add task and task/file iterator targets")
Acked-by: Yonghong Song <yhs@fb.com>
Signed-off-by: Andrii Nakryiko <andriin@fb.com>
---
 kernel/bpf/task_iter.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/task_iter.c b/kernel/bpf/task_iter.c
index a9b7264dda08..4dbf2b6035f8 100644
--- a/kernel/bpf/task_iter.c
+++ b/kernel/bpf/task_iter.c
@@ -27,9 +27,15 @@ static struct task_struct *task_seq_get_next(struct pi=
d_namespace *ns,
 	struct pid *pid;
=20
 	rcu_read_lock();
+retry:
 	pid =3D idr_get_next(&ns->idr, tid);
-	if (pid)
+	if (pid) {
 		task =3D get_pid_task(pid, PIDTYPE_PID);
+		if (!task) {
+			++*tid;
+			goto retry;
+		}
+	}
 	rcu_read_unlock();
=20
 	return task;
--=20
2.24.1

