Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32754C433F5
	for <bpf@archiver.kernel.org>; Fri, 29 Oct 2021 17:02:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 14C5A60E8B
	for <bpf@archiver.kernel.org>; Fri, 29 Oct 2021 17:02:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229732AbhJ2REp (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 29 Oct 2021 13:04:45 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:28490 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229868AbhJ2REp (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 29 Oct 2021 13:04:45 -0400
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19TGFFCo032360
        for <bpf@vger.kernel.org>; Fri, 29 Oct 2021 10:02:15 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=ec/puNsJDo6OfQmPivD6IDtSsr46Ape2LdIhgDWPYyQ=;
 b=mulSx3EOn8nrS1Z6MWWSRHqkQynL81+A/x+4pKr9UY0XoS49x07XMXfaHeiTDPwdzVPv
 LV0CWzsXl4/nCO1wzXcM5ZDA5KjTQyJ/NQHooPiUctXdRbJTtjb4g7OMXUHIaG6OsIq1
 5WKQEMA/vQ0gHv39FC/mnkQuwsbTagd0Tnw= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3c0edjkbau-6
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 29 Oct 2021 10:02:15 -0700
Received: from intmgw001.38.frc1.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:11d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Fri, 29 Oct 2021 10:02:12 -0700
Received: by devbig612.frc2.facebook.com (Postfix, from userid 115148)
        id DE3614346FCB; Fri, 29 Oct 2021 10:02:11 -0700 (PDT)
From:   Joanne Koong <joannekoong@fb.com>
To:     <bpf@vger.kernel.org>
CC:     <andrii@kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <kafai@fb.com>, <Kernel-team@fb.com>,
        Joanne Koong <joannekoong@fb.com>
Subject: [PATCH bpf-next 0/3] "map_extra" and bloom filter fixups
Date:   Fri, 29 Oct 2021 10:01:23 -0700
Message-ID: <20211029170126.4189338-1-joannekoong@fb.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-ORIG-GUID: 2JaCTjxmfEaXvnT-ABJjTmmWR7-X9za0
X-Proofpoint-GUID: 2JaCTjxmfEaXvnT-ABJjTmmWR7-X9za0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-29_04,2021-10-29_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 clxscore=1015
 impostorscore=0 mlxscore=0 phishscore=0 priorityscore=1501 spamscore=0
 lowpriorityscore=0 malwarescore=0 suspectscore=0 adultscore=0
 mlxlogscore=657 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2110150000 definitions=main-2110290095
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

There are 3 patches in this patchset:

1/3 - Bloom filter naming fixups (kernel/bpf/bloom_filter.c)

2/3 - Add alignment padding for map_extra, rearrange fields in
bpf_map struct to consolidate holes

3/3 - Bloom filter tests (prog_tests/bloom_filter_map):
Add test for successful userspace calls, some refactoring to
use bpf_create_map instead of bpf_create_map_xattr

Joanne Koong (3):
  bpf: Bloom filter map naming fixups
  bpf: Add alignment padding for "map_extra" + consolidate holes
  selftests/bpf: Add bloom map success test for userspace calls

 include/linux/bpf.h                           |  6 +--
 include/uapi/linux/bpf.h                      |  1 +
 kernel/bpf/bloom_filter.c                     | 49 +++++++++--------
 tools/include/uapi/linux/bpf.h                |  1 +
 .../bpf/prog_tests/bloom_filter_map.c         | 53 ++++++++++++-------
 5 files changed, 64 insertions(+), 46 deletions(-)

--=20
2.30.2

