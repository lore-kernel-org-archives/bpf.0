Return-Path: <SRS0=PQF5=6N=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 365BEC83007
	for <bpf@archiver.kernel.org>; Wed, 29 Apr 2020 01:21:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0647620731
	for <bpf@archiver.kernel.org>; Wed, 29 Apr 2020 01:21:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="JWBUUkcJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726451AbgD2BVb (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 28 Apr 2020 21:21:31 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:16830 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726355AbgD2BVa (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 28 Apr 2020 21:21:30 -0400
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.42/8.16.0.42) with SMTP id 03T1JgY7002383
        for <bpf@vger.kernel.org>; Tue, 28 Apr 2020 18:21:29 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=MFUNWFXTDtKydgExxdShP51rLeiWG+IvQkJdWM9J5wA=;
 b=JWBUUkcJPVgvMnnLmPLn4sMKCyjB2pbKtTXbxw0HOZG9K0oRUvetKyrFcWYWbJ5JAY0z
 VvNAGwPVZsHnDO8Zd4IleiOY9CI5IzhYdd9tmkTOHPToOHkyeVxGVjj8faQ00GtdodYp
 No/gVwCZ3JaIS3bv42Cbii0TPDqdLUyxYaE= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0089730.ppops.net with ESMTP id 30ntjvw7wv-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 28 Apr 2020 18:21:29 -0700
Received: from intmgw005.03.ash8.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:21d::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1847.3; Tue, 28 Apr 2020 18:21:28 -0700
Received: by devbig012.ftw2.facebook.com (Postfix, from userid 137359)
        id ECB0C2EC30E4; Tue, 28 Apr 2020 18:21:25 -0700 (PDT)
Smtp-Origin-Hostprefix: devbig
From:   Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Hostname: devbig012.ftw2.facebook.com
To:     <bpf@vger.kernel.org>, <netdev@vger.kernel.org>, <ast@fb.com>,
        <daniel@iogearbox.net>
CC:     <andrii.nakryiko@gmail.com>, <kernel-team@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        Song Liu <songliubraving@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH v2 bpf-next 06/11] selftests/bpf: fix memory leak in extract_build_id()
Date:   Tue, 28 Apr 2020 18:21:06 -0700
Message-ID: <20200429012111.277390-7-andriin@fb.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200429012111.277390-1-andriin@fb.com>
References: <20200429012111.277390-1-andriin@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-28_15:2020-04-28,2020-04-28 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 bulkscore=0
 priorityscore=1501 impostorscore=0 malwarescore=0 mlxscore=0
 suspectscore=25 phishscore=0 mlxlogscore=926 lowpriorityscore=0
 adultscore=0 spamscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2003020000 definitions=main-2004290008
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

getline() allocates string, which has to be freed.

Cc: Song Liu <songliubraving@fb.com>
Fixes: 81f77fd0deeb ("bpf: add selftest for stackmap with BPF_F_STACK_BUI=
LD_ID")
Signed-off-by: Andrii Nakryiko <andriin@fb.com>
---
 tools/testing/selftests/bpf/test_progs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/bpf/test_progs.c b/tools/testing/sel=
ftests/bpf/test_progs.c
index 86d0020c9eec..93970ec1c9e9 100644
--- a/tools/testing/selftests/bpf/test_progs.c
+++ b/tools/testing/selftests/bpf/test_progs.c
@@ -351,6 +351,7 @@ int extract_build_id(char *build_id, size_t size)
 		len =3D size;
 	memcpy(build_id, line, len);
 	build_id[len] =3D '\0';
+	free(line);
 	return 0;
 err:
 	fclose(fp);
--=20
2.24.1

