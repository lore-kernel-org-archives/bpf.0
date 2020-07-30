Return-Path: <SRS0=uBQJ=BJ=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99393C433DF
	for <bpf@archiver.kernel.org>; Thu, 30 Jul 2020 21:25:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7588120838
	for <bpf@archiver.kernel.org>; Thu, 30 Jul 2020 21:25:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="SiIagKog"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730720AbgG3VZM (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 30 Jul 2020 17:25:12 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:36086 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730730AbgG3VXX (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 30 Jul 2020 17:23:23 -0400
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06ULGMpu006660
        for <bpf@vger.kernel.org>; Thu, 30 Jul 2020 14:23:23 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=HmEMMOl2X9iRm4zfLXbqxhHSMwZOVTaYZPNN8g7Tjq8=;
 b=SiIagKogqeJQAakpHoMleHMIi6Nt4ZokRy668GJeguzY5kgfSg8KTE5gsvszfZDQFr0o
 ejIexeY0w+fy90pSu3xenjNlARx5qyOAKH2v+go1csr0UtcVtwg9ibC5Yn0VOmTx0mCR
 IsdWJDu3rIluoRx6MVeq5rhPIm9S5sAuhUc= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 32jk9ddb0k-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 30 Jul 2020 14:23:23 -0700
Received: from intmgw003.06.prn3.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::d) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 30 Jul 2020 14:23:21 -0700
Received: by devvm1096.prn0.facebook.com (Postfix, from userid 111017)
        id 9A5BF20B009E; Thu, 30 Jul 2020 14:23:12 -0700 (PDT)
Smtp-Origin-Hostprefix: devvm
From:   Roman Gushchin <guro@fb.com>
Smtp-Origin-Hostname: devvm1096.prn0.facebook.com
To:     <bpf@vger.kernel.org>
CC:     <netdev@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>,
        <linux-kernel@vger.kernel.org>, Roman Gushchin <guro@fb.com>,
        Song Liu <songliubraving@fb.com>
Smtp-Origin-Cluster: prn0c01
Subject: [PATCH bpf-next v3 02/29] bpf: memcg-based memory accounting for bpf maps
Date:   Thu, 30 Jul 2020 14:22:43 -0700
Message-ID: <20200730212310.2609108-3-guro@fb.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200730212310.2609108-1-guro@fb.com>
References: <20200730212310.2609108-1-guro@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-30_15:2020-07-30,2020-07-30 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 clxscore=1015 impostorscore=0 malwarescore=0 mlxscore=0 mlxlogscore=734
 suspectscore=13 adultscore=0 priorityscore=1501 phishscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007300150
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This patch enables memcg-based memory accounting for memory allocated
by __bpf_map_area_alloc(), which is used by most map types for
large allocations.

Following patches in the series will refine the accounting for
some map types.

Signed-off-by: Roman Gushchin <guro@fb.com>
Acked-by: Song Liu <songliubraving@fb.com>
---
 kernel/bpf/syscall.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index cd3d599e9e90..a53e7aff3efc 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -275,7 +275,7 @@ static void *__bpf_map_area_alloc(u64 size, int numa_=
node, bool mmapable)
 	 * __GFP_RETRY_MAYFAIL to avoid such situations.
 	 */
=20
-	const gfp_t gfp =3D __GFP_NOWARN | __GFP_ZERO;
+	const gfp_t gfp =3D __GFP_NOWARN | __GFP_ZERO | __GFP_ACCOUNT;
 	unsigned int flags =3D 0;
 	unsigned long align =3D 1;
 	void *area;
--=20
2.26.2

