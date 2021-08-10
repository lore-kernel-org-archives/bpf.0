Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A03AC4320E
	for <bpf@archiver.kernel.org>; Tue, 10 Aug 2021 21:21:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 18E796101E
	for <bpf@archiver.kernel.org>; Tue, 10 Aug 2021 21:21:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234498AbhHJVVk (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 10 Aug 2021 17:21:40 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:62992 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234454AbhHJVVj (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 10 Aug 2021 17:21:39 -0400
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17ALF2AC001977
        for <bpf@vger.kernel.org>; Tue, 10 Aug 2021 14:21:16 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=iS7jCUSOQEmlmjxx1joWqESS5L44ayce3o3iearh/0A=;
 b=e8GAj/28sKRNBurZLaxoqzEbEeUx/c3suSVfu+7vG9VTbfw62/150uVX5Fwpqsw+5yzE
 xg71gvUOWhDShyHUcaVoGTcmfdqJCPhzeNWa1BQbDT1zu5gj49+XepLWkEqaJGkS8BYr
 ZBSEFmSN0ryBHkMpX161Sfb3ZJlYsFU/mtQ= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3abyc88vkj-6
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 10 Aug 2021 14:21:16 -0700
Received: from intmgw001.38.frc1.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:11d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 10 Aug 2021 14:21:14 -0700
Received: by devvm2661.vll0.facebook.com (Postfix, from userid 200310)
        id 1FAB41EB0E0C; Tue, 10 Aug 2021 14:21:08 -0700 (PDT)
From:   Yucong Sun <fallentree@fb.com>
To:     <andrii@kernel.org>
CC:     <sunyucong@gmail.com>, <bpf@vger.kernel.org>,
        <daniel@iogearbox.net>, Yucong Sun <fallentree@fb.com>
Subject: [PATCH v3 bpf-next 0/4] selftests/bpf: Improve the usability of test_progs
Date:   Tue, 10 Aug 2021 14:21:03 -0700
Message-ID: <20210810212107.2237868-1-fallentree@fb.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-GUID: 4M4R4rG-1T106yQc1AbHb-FPhntIOQLs
X-Proofpoint-ORIG-GUID: 4M4R4rG-1T106yQc1AbHb-FPhntIOQLs
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-10_08:2021-08-10,2021-08-10 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 phishscore=0
 impostorscore=0 malwarescore=0 bulkscore=0 adultscore=0 lowpriorityscore=0
 mlxlogscore=765 suspectscore=0 priorityscore=1501 clxscore=1015 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108100141
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This short series adds two new "-a", "-d" switch to test_progs,
supporting exact string match, as well as '*' wildchar. It also cleans
up the output to make it possible to generate allowlist/denylist using
grep.

Yucong Sun (4):
  selftests/bpf: skip loading bpf_testmod when using -l to list tests.
  selftests/bpf: correctly display subtest skip status
  selftests/bpf: Support glob matching for test selector.
  selftests/bpf: also print test name in subtest status message

 tools/testing/selftests/bpf/test_progs.c | 100 +++++++++++++++++------
 tools/testing/selftests/bpf/test_progs.h |   1 +
 2 files changed, 78 insertions(+), 23 deletions(-)

--=20
2.30.2

