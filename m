Return-Path: <SRS0=Ijne=BG=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AACD1C433EC
	for <bpf@archiver.kernel.org>; Mon, 27 Jul 2020 18:48:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 83F3D2078E
	for <bpf@archiver.kernel.org>; Mon, 27 Jul 2020 18:48:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="AgOe/Fie"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731657AbgG0SpV (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 27 Jul 2020 14:45:21 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:18152 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728921AbgG0SpS (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 27 Jul 2020 14:45:18 -0400
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06RIiSwh009961
        for <bpf@vger.kernel.org>; Mon, 27 Jul 2020 11:45:16 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=KNw+zApORd76q39nK/G4/4vz38ZsJWmmo71aihi3HP0=;
 b=AgOe/FiemErPvuWwGFjRWDoaZ+hfOAuiE611dB/HhWSWccdndulkAPEM4kCrU1eDAUiV
 KJZdRz1f6rTrH/DJpgdbRiSlsgGQBueMVEVjYIhZnLGaHVUwUvWVtK0ys0HG5fNaOCcG
 RDy1fAiHOyqp/UdtsKv70Ijx6b3oYDNkmhY= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 32gj8kga43-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 27 Jul 2020 11:45:16 -0700
Received: from intmgw001.06.prn3.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Mon, 27 Jul 2020 11:45:15 -0700
Received: by devvm1096.prn0.facebook.com (Postfix, from userid 111017)
        id 9D9F61DAFE79; Mon, 27 Jul 2020 11:45:10 -0700 (PDT)
Smtp-Origin-Hostprefix: devvm
From:   Roman Gushchin <guro@fb.com>
Smtp-Origin-Hostname: devvm1096.prn0.facebook.com
To:     <bpf@vger.kernel.org>
CC:     <netdev@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>,
        <linux-kernel@vger.kernel.org>, Roman Gushchin <guro@fb.com>
Smtp-Origin-Cluster: prn0c01
Subject: [PATCH bpf-next v2 04/35] bpf: refine memcg-based memory accounting for cpumap maps
Date:   Mon, 27 Jul 2020 11:44:35 -0700
Message-ID: <20200727184506.2279656-5-guro@fb.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200727184506.2279656-1-guro@fb.com>
References: <20200727184506.2279656-1-guro@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-27_13:2020-07-27,2020-07-27 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 adultscore=0
 mlxlogscore=949 spamscore=0 impostorscore=0 malwarescore=0 suspectscore=13
 bulkscore=0 priorityscore=1501 clxscore=1015 phishscore=0 mlxscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007270127
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Include metadata and percpu data into the memcg-based memory accounting.

Signed-off-by: Roman Gushchin <guro@fb.com>
---
 kernel/bpf/cpumap.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/cpumap.c b/kernel/bpf/cpumap.c
index f1c46529929b..74ae9fcbe82e 100644
--- a/kernel/bpf/cpumap.c
+++ b/kernel/bpf/cpumap.c
@@ -99,7 +99,7 @@ static struct bpf_map *cpu_map_alloc(union bpf_attr *at=
tr)
 	    attr->map_flags & ~BPF_F_NUMA_NODE)
 		return ERR_PTR(-EINVAL);
=20
-	cmap =3D kzalloc(sizeof(*cmap), GFP_USER);
+	cmap =3D kzalloc(sizeof(*cmap), GFP_USER | __GFP_ACCOUNT);
 	if (!cmap)
 		return ERR_PTR(-ENOMEM);
=20
@@ -418,7 +418,7 @@ static struct bpf_cpu_map_entry *
 __cpu_map_entry_alloc(struct bpf_cpumap_val *value, u32 cpu, int map_id)
 {
 	int numa, err, i, fd =3D value->bpf_prog.fd;
-	gfp_t gfp =3D GFP_KERNEL | __GFP_NOWARN;
+	gfp_t gfp =3D GFP_KERNEL_ACCOUNT | __GFP_NOWARN;
 	struct bpf_cpu_map_entry *rcpu;
 	struct xdp_bulk_queue *bq;
=20
--=20
2.26.2

