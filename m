Return-Path: <SRS0=xWwI=DV=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36B69C433DF
	for <bpf@archiver.kernel.org>; Wed, 14 Oct 2020 04:36:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E273F2222C
	for <bpf@archiver.kernel.org>; Wed, 14 Oct 2020 04:36:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="aFeEuhWh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730017AbgJNEgy (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 14 Oct 2020 00:36:54 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:19812 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729995AbgJNEgy (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 14 Oct 2020 00:36:54 -0400
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 09E4ZM1l011016
        for <bpf@vger.kernel.org>; Tue, 13 Oct 2020 21:36:53 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type :
 content-transfer-encoding; s=facebook;
 bh=sl7Keq768JmYFP2QGaRO4xIW+BR0M1wIdYM0fJxUwXE=;
 b=aFeEuhWhXweCDqnRWk9q5mMw5Vmj7Wl/9zKjNPKtt9umKDdv39fEYy/lbgZn/c7lwg6B
 HgI8eZsGZ7MbNSz77b/+gTlrR64rbsTiSsuRO4Gpz69W9NxJPMLIbI/FPcGHHkXejHZj
 iakMx35SwnAUPpUWBjDsFHZK7a/e/Kc6WxI= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 345ff5k721-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 13 Oct 2020 21:36:53 -0700
Received: from intmgw003.03.ash8.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 13 Oct 2020 21:36:52 -0700
Received: by devbig006.ftw2.facebook.com (Postfix, from userid 4523)
        id 662C862E1AE9; Tue, 13 Oct 2020 21:36:41 -0700 (PDT)
From:   Song Liu <songliubraving@fb.com>
To:     <netdev@vger.kernel.org>, <bpf@vger.kernel.org>
CC:     <kernel-team@fb.com>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <john.fastabend@gmail.com>, <kpsingh@chromium.org>,
        Song Liu <songliubraving@fb.com>
Subject: [PATCH bpf-next] selftests/bpf: fix compilation error in progs/profiler.inc.h
Date:   Tue, 13 Oct 2020 21:36:38 -0700
Message-ID: <20201014043638.3770558-1-songliubraving@fb.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
X-FB-Internal: Safe
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-10-14_02:2020-10-14,2020-10-14 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 malwarescore=0 suspectscore=0 bulkscore=0 mlxscore=0 spamscore=0
 impostorscore=0 priorityscore=1501 phishscore=0 adultscore=0
 mlxlogscore=999 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2010140031
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Fix the following error when compiling selftests/bpf

progs/profiler.inc.h:246:5: error: redefinition of 'pids_cgrp_id' as diff=
erent kind of symbol

pids_cgrp_id is used in cgroup code, and included in vmlinux.h. Fix the
error by renaming pids_cgrp_id as pids_cgroup_id.

Fixes: 03d4d13fab3f ("selftests/bpf: Add profiler test")
Signed-off-by: Song Liu <songliubraving@fb.com>
---
 tools/testing/selftests/bpf/progs/profiler.inc.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/profiler.inc.h b/tools/tes=
ting/selftests/bpf/progs/profiler.inc.h
index 00578311a4233..b554c1e40b9fb 100644
--- a/tools/testing/selftests/bpf/progs/profiler.inc.h
+++ b/tools/testing/selftests/bpf/progs/profiler.inc.h
@@ -243,7 +243,7 @@ static ino_t get_inode_from_kernfs(struct kernfs_node=
* node)
 	}
 }
=20
-int pids_cgrp_id =3D 1;
+int pids_cgroup_id =3D 1;
=20
 static INLINE void* populate_cgroup_info(struct cgroup_data_t* cgroup_da=
ta,
 					 struct task_struct* task,
@@ -262,7 +262,7 @@ static INLINE void* populate_cgroup_info(struct cgrou=
p_data_t* cgroup_data,
 				BPF_CORE_READ(task, cgroups, subsys[i]);
 			if (subsys !=3D NULL) {
 				int subsys_id =3D BPF_CORE_READ(subsys, ss, id);
-				if (subsys_id =3D=3D pids_cgrp_id) {
+				if (subsys_id =3D=3D pids_cgroup_id) {
 					proc_kernfs =3D BPF_CORE_READ(subsys, cgroup, kn);
 					root_kernfs =3D BPF_CORE_READ(subsys, ss, root, kf_root, kn);
 					break;
--=20
2.24.1

