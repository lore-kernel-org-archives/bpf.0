Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97A05C6379D
	for <bpf@archiver.kernel.org>; Tue, 17 Nov 2020 03:43:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B376246B3
	for <bpf@archiver.kernel.org>; Tue, 17 Nov 2020 03:43:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="FZ3Cxt3P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727158AbgKQDm2 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 16 Nov 2020 22:42:28 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:18178 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727167AbgKQDlU (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 16 Nov 2020 22:41:20 -0500
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0AH3f11q007663
        for <bpf@vger.kernel.org>; Mon, 16 Nov 2020 19:41:20 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=M+0ILuiaD6+1fkeZ4SUYhsSshDmJ3vpGG9x3Lp/tMEM=;
 b=FZ3Cxt3Pa084GSQRqiF5iIZ1IPvGZ7Mb4zLNWq5/zXAgJ7bPE0GRN5psiYDrvfxCzaBG
 d1MmWo8rSgLszWEScGAW60cq9rAGUizW0+gw5IGWgM8kyoEBlh2d5Si0MxL23AlQO7qF
 AD8+Up/UW4Ub0kP707lhrfO1h2FoZBcHh0U= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 34tykx8txv-9
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 16 Nov 2020 19:41:20 -0800
Received: from intmgw003.06.prn3.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Mon, 16 Nov 2020 19:41:13 -0800
Received: by devvm3388.prn0.facebook.com (Postfix, from userid 111017)
        id 87804C63A8B; Mon, 16 Nov 2020 19:41:10 -0800 (PST)
From:   Roman Gushchin <guro@fb.com>
To:     <bpf@vger.kernel.org>
CC:     <ast@kernel.org>, <daniel@iogearbox.net>, <netdev@vger.kernel.org>,
        <andrii@kernel.org>, <akpm@linux-foundation.org>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <kernel-team@fb.com>
Subject: [PATCH bpf-next v6 26/34] bpf: eliminate rlimit-based memory accounting for reuseport_array maps
Date:   Mon, 16 Nov 2020 19:41:00 -0800
Message-ID: <20201117034108.1186569-27-guro@fb.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20201117034108.1186569-1-guro@fb.com>
References: <20201117034108.1186569-1-guro@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-17_01:2020-11-13,2020-11-17 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 suspectscore=38 bulkscore=0 adultscore=0 clxscore=1015 phishscore=0
 impostorscore=0 mlxscore=0 mlxlogscore=754 spamscore=0 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011170027
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Do not use rlimit-based memory accounting for reuseport_array maps.
It has been replaced with the memcg-based memory accounting.

Signed-off-by: Roman Gushchin <guro@fb.com>
Acked-by: Song Liu <songliubraving@fb.com>
---
 kernel/bpf/reuseport_array.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/kernel/bpf/reuseport_array.c b/kernel/bpf/reuseport_array.c
index a55cd542f2ce..4838922f723d 100644
--- a/kernel/bpf/reuseport_array.c
+++ b/kernel/bpf/reuseport_array.c
@@ -150,9 +150,8 @@ static void reuseport_array_free(struct bpf_map *map)
=20
 static struct bpf_map *reuseport_array_alloc(union bpf_attr *attr)
 {
-	int err, numa_node =3D bpf_map_attr_numa_node(attr);
+	int numa_node =3D bpf_map_attr_numa_node(attr);
 	struct reuseport_array *array;
-	struct bpf_map_memory mem;
 	u64 array_size;
=20
 	if (!bpf_capable())
@@ -161,20 +160,13 @@ static struct bpf_map *reuseport_array_alloc(union =
bpf_attr *attr)
 	array_size =3D sizeof(*array);
 	array_size +=3D (u64)attr->max_entries * sizeof(struct sock *);
=20
-	err =3D bpf_map_charge_init(&mem, array_size);
-	if (err)
-		return ERR_PTR(err);
-
 	/* allocate all map elements and zero-initialize them */
 	array =3D bpf_map_area_alloc(array_size, numa_node);
-	if (!array) {
-		bpf_map_charge_finish(&mem);
+	if (!array)
 		return ERR_PTR(-ENOMEM);
-	}
=20
 	/* copy mandatory map attributes */
 	bpf_map_init_from_attr(&array->map, attr);
-	bpf_map_charge_move(&array->map.memory, &mem);
=20
 	return &array->map;
 }
--=20
2.26.2

