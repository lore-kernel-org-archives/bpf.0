Return-Path: <SRS0=PNb+=DG=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFDD0C4727C
	for <bpf@archiver.kernel.org>; Tue, 29 Sep 2020 22:50:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C8A62075A
	for <bpf@archiver.kernel.org>; Tue, 29 Sep 2020 22:50:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="N+QCM+e8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728384AbgI2WuZ (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 29 Sep 2020 18:50:25 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:53670 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728192AbgI2WuY (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 29 Sep 2020 18:50:24 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08TMo9l2019370
        for <bpf@vger.kernel.org>; Tue, 29 Sep 2020 15:50:24 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=yeIlLcPVe73ANCroUFPRO6l+RyUYuFYQQpuTnrOuYEs=;
 b=N+QCM+e8S36WAu7lubtYsPf6iR+s9EONLOsRK36e1L7ucqijHV4dNPCm4lyk+ZLbc2v4
 tU4bzQiEScKNPaWgXgzLWfiqxQZeKjSyRi55MDjnOnVAAFfzYT45aByhqsoZJQKGK//a
 neDQsp5icMDqA76s7MWWEnke51OG9TwM1jM= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 33v6v42hc4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 29 Sep 2020 15:50:24 -0700
Received: from intmgw003.08.frc2.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c085:21d::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 29 Sep 2020 15:50:23 -0700
Received: by devbig006.ftw2.facebook.com (Postfix, from userid 4523)
        id 71E5B62E56DB; Tue, 29 Sep 2020 15:50:22 -0700 (PDT)
From:   Song Liu <songliubraving@fb.com>
To:     <netdev@vger.kernel.org>, <bpf@vger.kernel.org>
CC:     <kernel-team@fb.com>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <john.fastabend@gmail.com>, <kpsingh@chromium.org>,
        Song Liu <songliubraving@fb.com>
Subject: [PATCH bpf-next] bpf: fix raw_tp test run in preempt kernel
Date:   Tue, 29 Sep 2020 15:50:13 -0700
Message-ID: <20200929225013.930-1-songliubraving@fb.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-29_14:2020-09-29,2020-09-29 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 adultscore=0
 malwarescore=0 mlxscore=0 impostorscore=0 spamscore=0 bulkscore=0
 clxscore=1015 lowpriorityscore=0 mlxlogscore=768 phishscore=0
 suspectscore=0 priorityscore=1501 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2006250000 definitions=main-2009290194
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

In preempt kernel, BPF_PROG_TEST_RUN on raw_tp triggers:

[   35.874974] BUG: using smp_processor_id() in preemptible [00000000]
code: new_name/87
[   35.893983] caller is bpf_prog_test_run_raw_tp+0xd4/0x1b0
[   35.900124] CPU: 1 PID: 87 Comm: new_name Not tainted 5.9.0-rc6-g615bd=
02bf #1
[   35.907358] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
BIOS 1.10.2-1ubuntu1 04/01/2014
[   35.916941] Call Trace:
[   35.919660]  dump_stack+0x77/0x9b
[   35.923273]  check_preemption_disabled+0xb4/0xc0
[   35.928376]  bpf_prog_test_run_raw_tp+0xd4/0x1b0
[   35.933872]  ? selinux_bpf+0xd/0x70
[   35.937532]  __do_sys_bpf+0x6bb/0x21e0
[   35.941570]  ? find_held_lock+0x2d/0x90
[   35.945687]  ? vfs_write+0x150/0x220
[   35.949586]  do_syscall_64+0x2d/0x40
[   35.953443]  entry_SYSCALL_64_after_hwframe+0x44/0xa9

Fix this by calling migrate_disable() before smp_processor_id().

Fixes: 1b4d60ec162f ("bpf: Enable BPF_PROG_TEST_RUN for raw_tracepoint")
Reported-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Song Liu <songliubraving@fb.com>
---
 net/bpf/test_run.c | 20 ++++++++------------
 1 file changed, 8 insertions(+), 12 deletions(-)

diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
index fde5db93507c4..3ea05a5daf544 100644
--- a/net/bpf/test_run.c
+++ b/net/bpf/test_run.c
@@ -251,11 +251,7 @@ __bpf_prog_test_run_raw_tp(void *data)
 {
 	struct bpf_raw_tp_test_run_info *info =3D data;
=20
-	rcu_read_lock();
-	migrate_disable();
 	info->retval =3D BPF_PROG_RUN(info->prog, info->ctx);
-	migrate_enable();
-	rcu_read_unlock();
 }
=20
 int bpf_prog_test_run_raw_tp(struct bpf_prog *prog,
@@ -293,27 +289,27 @@ int bpf_prog_test_run_raw_tp(struct bpf_prog *prog,
=20
 	info.prog =3D prog;
=20
+	rcu_read_lock();
+	migrate_disable();
 	if ((kattr->test.flags & BPF_F_TEST_RUN_ON_CPU) =3D=3D 0 ||
 	    cpu =3D=3D smp_processor_id()) {
 		__bpf_prog_test_run_raw_tp(&info);
-	} else {
+	} else if (cpu >=3D nr_cpu_ids || !cpu_online(cpu)) {
 		/* smp_call_function_single() also checks cpu_online()
 		 * after csd_lock(). However, since cpu is from user
 		 * space, let's do an extra quick check to filter out
 		 * invalid value before smp_call_function_single().
 		 */
-		if (cpu >=3D nr_cpu_ids || !cpu_online(cpu)) {
 		err =3D -ENXIO;
-			goto out;
-		}
-
+	} else {
 		err =3D smp_call_function_single(cpu, __bpf_prog_test_run_raw_tp,
 					       &info, 1);
-		if (err)
-			goto out;
 	}
+	migrate_enable();
+	rcu_read_unlock();
=20
-	if (copy_to_user(&uattr->test.retval, &info.retval, sizeof(u32)))
+	if (err =3D=3D 0 &&
+	    copy_to_user(&uattr->test.retval, &info.retval, sizeof(u32)))
 		err =3D -EFAULT;
=20
 out:
--=20
2.24.1

