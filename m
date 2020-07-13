Return-Path: <SRS0=NpDT=AY=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32CDBC433E8
	for <bpf@archiver.kernel.org>; Mon, 13 Jul 2020 05:13:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 10B1820724
	for <bpf@archiver.kernel.org>; Mon, 13 Jul 2020 05:13:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="qdrHf7Ww"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728974AbgGMFM6 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 13 Jul 2020 01:12:58 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:60754 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728952AbgGMFM5 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 13 Jul 2020 01:12:57 -0400
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06D5BgW0032693
        for <bpf@vger.kernel.org>; Sun, 12 Jul 2020 22:12:56 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=Cp68a6sxp6nDfKPzm02M6qmdMMqx2lvKAxWO81zldS8=;
 b=qdrHf7Wwf8bHuqkwg8yNPbc0vK6P8YNcgnfh3XqhazlLIBp+J/Guu9KOuNCdtPBUtUO4
 XZZY1mf+/SEMAdlk2jJHV08m68DjNhaZ3/+k2O30Su4CAcWTq+ALxOK8ETxD/nW6lSDH
 SA/p7v26CpSV0m3HKzb6/aIc1dNRbUYm7/Q= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3288hks9hh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Sun, 12 Jul 2020 22:12:56 -0700
Received: from intmgw002.08.frc2.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:21d::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Sun, 12 Jul 2020 22:12:56 -0700
Received: by devbig012.ftw2.facebook.com (Postfix, from userid 137359)
        id 0DA942EC3F93; Sun, 12 Jul 2020 22:12:49 -0700 (PDT)
Smtp-Origin-Hostprefix: devbig
From:   Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Hostname: devbig012.ftw2.facebook.com
To:     <bpf@vger.kernel.org>, <netdev@vger.kernel.org>, <ast@fb.com>,
        <daniel@iogearbox.net>
CC:     <andrii.nakryiko@gmail.com>, <kernel-team@fb.com>,
        Andrii Nakryiko <andriin@fb.com>, Andrey Ignatov <rdna@fb.com>,
        Takshak Chahande <ctakshak@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH bpf-next 4/7] bpf: implement BPF XDP link-specific introspection APIs
Date:   Sun, 12 Jul 2020 22:12:27 -0700
Message-ID: <20200713051230.3250515-5-andriin@fb.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200713051230.3250515-1-andriin@fb.com>
References: <20200713051230.3250515-1-andriin@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-13_03:2020-07-10,2020-07-13 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 bulkscore=0
 mlxlogscore=907 suspectscore=8 phishscore=0 priorityscore=1501 mlxscore=0
 lowpriorityscore=0 malwarescore=0 spamscore=0 impostorscore=0 adultscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007130038
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Implement XDP link-specific show_fdinfo and link_info to emit ifindex.

Signed-off-by: Andrii Nakryiko <andriin@fb.com>
---
 include/uapi/linux/bpf.h |  3 +++
 net/core/dev.c           | 31 +++++++++++++++++++++++++++++++
 2 files changed, 34 insertions(+)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 41eba148217b..533eb4fe4e03 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -3985,6 +3985,9 @@ struct bpf_link_info {
 			__u32 netns_ino;
 			__u32 attach_type;
 		} netns;
+		struct {
+			__u32 ifindex;
+		} xdp;
 	};
 } __attribute__((aligned(8)));
=20
diff --git a/net/core/dev.c b/net/core/dev.c
index 025687120442..a9c634be8dd7 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -8973,6 +8973,35 @@ static void bpf_xdp_link_dealloc(struct bpf_link *=
link)
 	kfree(xdp_link);
 }
=20
+static void bpf_xdp_link_show_fdinfo(const struct bpf_link *link,
+				     struct seq_file *seq)
+{
+	struct bpf_xdp_link *xdp_link =3D container_of(link, struct bpf_xdp_lin=
k, link);
+	u32 ifindex =3D 0;
+
+	rtnl_lock();
+	if (xdp_link->dev)
+		ifindex =3D xdp_link->dev->ifindex;
+	rtnl_unlock();
+
+	seq_printf(seq, "ifindex:\t%u\n", ifindex);
+}
+
+static int bpf_xdp_link_fill_link_info(const struct bpf_link *link,
+				       struct bpf_link_info *info)
+{
+	struct bpf_xdp_link *xdp_link =3D container_of(link, struct bpf_xdp_lin=
k, link);
+	u32 ifindex =3D 0;
+
+	rtnl_lock();
+	if (xdp_link->dev)
+		ifindex =3D xdp_link->dev->ifindex;
+	rtnl_unlock();
+
+	info->xdp.ifindex =3D ifindex;
+	return 0;
+}
+
 static int bpf_xdp_link_update(struct bpf_link *link, struct bpf_prog *n=
ew_prog,
 			       struct bpf_prog *old_prog)
 {
@@ -9018,6 +9047,8 @@ static int bpf_xdp_link_update(struct bpf_link *lin=
k, struct bpf_prog *new_prog,
 static const struct bpf_link_ops bpf_xdp_link_lops =3D {
 	.release =3D bpf_xdp_link_release,
 	.dealloc =3D bpf_xdp_link_dealloc,
+	.show_fdinfo =3D bpf_xdp_link_show_fdinfo,
+	.fill_link_info =3D bpf_xdp_link_fill_link_info,
 	.update_prog =3D bpf_xdp_link_update,
 };
=20
--=20
2.24.1

