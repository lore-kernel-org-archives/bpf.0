Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCF30C4338F
	for <bpf@archiver.kernel.org>; Tue, 17 Aug 2021 04:57:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A172E60F5C
	for <bpf@archiver.kernel.org>; Tue, 17 Aug 2021 04:57:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231616AbhHQE6C (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 17 Aug 2021 00:58:02 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:9978 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230272AbhHQE6B (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 17 Aug 2021 00:58:01 -0400
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17H4rTBx013888
        for <bpf@vger.kernel.org>; Mon, 16 Aug 2021 21:57:29 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=ss1OsyKI7qUuy/ZT+Lqv720iHtRVu01ZfbN9u/Og1Tg=;
 b=bmqMktKxoBNBR7nRDJYgdrj+expzi5hpsSHiedM6DOKfWHz59WE/pOx/mq5vX9vSrvUE
 757v2n2rSasPQpZR1ig0d8hzvkjjnORvPsA0qxHgdtzr4kxVCHDdk/swDbRrWDlBrOut
 cjYUQpSKoHmcPSAzNrvNMjnSptIFFyvaguk= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3afrcbn6n7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 16 Aug 2021 21:57:29 -0700
Received: from intmgw002.46.prn1.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 16 Aug 2021 21:57:27 -0700
Received: by devvm2661.vll0.facebook.com (Postfix, from userid 200310)
        id 9B83D22A3B09; Mon, 16 Aug 2021 21:57:14 -0700 (PDT)
From:   Yucong Sun <fallentree@fb.com>
To:     <andrii@kernel.org>
CC:     <sunyucong@gmail.com>, <bpf@vger.kernel.org>,
        Yucong Sun <fallentree@fb.com>
Subject: [PATCH v1 bpf-next] selftests/bpf: Add exponential backoff to map_delete_retriable in test_maps
Date:   Mon, 16 Aug 2021 21:57:13 -0700
Message-ID: <20210817045713.3307985-1-fallentree@fb.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-GUID: oK7Bo0VhNodkYxR1LpXjAUZ6Hesy1_8y
X-Proofpoint-ORIG-GUID: oK7Bo0VhNodkYxR1LpXjAUZ6Hesy1_8y
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-17_01:2021-08-16,2021-08-17 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxlogscore=891
 suspectscore=0 lowpriorityscore=0 mlxscore=0 spamscore=0 clxscore=1015
 impostorscore=0 priorityscore=1501 bulkscore=0 phishscore=0 malwarescore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108170030
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Using a fixed delay of 1 microsecond has proven flaky in slow CPU environ=
ment,
e.g. Github Actions CI system. This patch adds exponential backoff with a=
 cap
of 50ms to reduce the flakiness of the test. Initial delay is chosen at r=
andom
in the range [0ms, 5ms).

Signed-off-by: Yucong Sun <fallentree@fb.com>
---
 tools/testing/selftests/bpf/test_maps.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/test_maps.c b/tools/testing/self=
tests/bpf/test_maps.c
index 2caf58b40d40..340695d5d652 100644
--- a/tools/testing/selftests/bpf/test_maps.c
+++ b/tools/testing/selftests/bpf/test_maps.c
@@ -1420,11 +1420,16 @@ static int map_update_retriable(int map_fd, const=
 void *key, const void *value,
=20
 static int map_delete_retriable(int map_fd, const void *key, int attempt=
s)
 {
+	int delay =3D rand() % MIN_DELAY_RANGE_US;
+
 	while (bpf_map_delete_elem(map_fd, key)) {
 		if (!attempts || (errno !=3D EAGAIN && errno !=3D EBUSY))
 			return -errno;
=20
-		usleep(1);
+		if (delay <=3D MAX_DELAY_US / 2)
+			delay *=3D 2;
+
+		usleep(delay);
 		attempts--;
 	}
=20
--=20
2.30.2

