Return-Path: <SRS0=ACkJ=6I=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF9BBC55186
	for <bpf@archiver.kernel.org>; Fri, 24 Apr 2020 05:20:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C4DE20767
	for <bpf@archiver.kernel.org>; Fri, 24 Apr 2020 05:20:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="bkbdsMW9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726072AbgDXFU4 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 24 Apr 2020 01:20:56 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:56154 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725919AbgDXFUz (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 24 Apr 2020 01:20:55 -0400
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03O5JP79012432
        for <bpf@vger.kernel.org>; Thu, 23 Apr 2020 22:20:54 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=ikO0forPp7t8DcwlBPkaLeVSS6Obv2yCRfcHPNoff/0=;
 b=bkbdsMW976Io1VNZbrbtb+Bnde5m9xVokqOxSpzlZAHFu4kJSx4H8bZq26j6LyYuqnUt
 tUKddeio/KbiguOZls6WP9m/i4+41mEiMITcZ0y/lJdLbhc+bMLZPEFJt/D0kLOKI4Sb
 tkuRw95y7ULsIdzElEK+urWvSZPQp2y0ZGQ= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 30jq4jkxdx-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 23 Apr 2020 22:20:54 -0700
Received: from intmgw004.08.frc2.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:11d::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1847.3; Thu, 23 Apr 2020 22:20:53 -0700
Received: by devbig012.ftw2.facebook.com (Postfix, from userid 137359)
        id AB0B12EC37B0; Thu, 23 Apr 2020 22:20:46 -0700 (PDT)
Smtp-Origin-Hostprefix: devbig
From:   Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Hostname: devbig012.ftw2.facebook.com
To:     <bpf@vger.kernel.org>, <netdev@vger.kernel.org>, <ast@fb.com>,
        <daniel@iogearbox.net>
CC:     <andrii.nakryiko@gmail.com>, <kernel-team@fb.com>,
        Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH v2 bpf] bpf: fix leak in LINK_UPDATE and enforce empty old_prog_fd
Date:   Thu, 23 Apr 2020 22:20:44 -0700
Message-ID: <20200424052045.4002963-1-andriin@fb.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-24_01:2020-04-23,2020-04-24 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxlogscore=842
 malwarescore=0 priorityscore=1501 bulkscore=0 phishscore=0 mlxscore=0
 lowpriorityscore=0 adultscore=0 suspectscore=8 spamscore=0 clxscore=1015
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004240038
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Fix bug of not putting bpf_link in LINK_UPDATE command.
Also enforce zeroed old_prog_fd if no BPF_F_REPLACE flag is specified.

Signed-off-by: Andrii Nakryiko <andriin@fb.com>
---
This version will merge with no conflicts with the upcoming LINK_UPDATE
refactoring patch (part of bpf_link observability patch set).

 kernel/bpf/syscall.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index d85f37239540..bca58c235ac0 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -3628,8 +3628,10 @@ static int link_update(union bpf_attr *attr)
 		return PTR_ERR(link);
=20
 	new_prog =3D bpf_prog_get(attr->link_update.new_prog_fd);
-	if (IS_ERR(new_prog))
-		return PTR_ERR(new_prog);
+	if (IS_ERR(new_prog)) {
+		ret =3D PTR_ERR(new_prog);
+		goto out_put_link;
+	}
=20
 	if (flags & BPF_F_REPLACE) {
 		old_prog =3D bpf_prog_get(attr->link_update.old_prog_fd);
@@ -3638,6 +3640,9 @@ static int link_update(union bpf_attr *attr)
 			old_prog =3D NULL;
 			goto out_put_progs;
 		}
+	} else if (attr->link_update.old_prog_fd) {
+		ret =3D -EINVAL;
+		goto out_put_progs;
 	}
=20
 #ifdef CONFIG_CGROUP_BPF
@@ -3653,6 +3658,8 @@ static int link_update(union bpf_attr *attr)
 		bpf_prog_put(old_prog);
 	if (ret)
 		bpf_prog_put(new_prog);
+out_put_link:
+	bpf_link_put(link);
 	return ret;
 }
=20
--=20
2.24.1

