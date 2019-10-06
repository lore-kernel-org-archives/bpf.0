Return-Path: <SRS0=V9G1=X7=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E21D9ECE58D
	for <bpf@archiver.kernel.org>; Sun,  6 Oct 2019 05:43:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA71120867
	for <bpf@archiver.kernel.org>; Sun,  6 Oct 2019 05:43:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="VIViYHCp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726078AbfJFFn6 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Sun, 6 Oct 2019 01:43:58 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:56032 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726080AbfJFFn5 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sun, 6 Oct 2019 01:43:57 -0400
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x965cN7t015556
        for <bpf@vger.kernel.org>; Sat, 5 Oct 2019 22:43:56 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=facebook;
 bh=F6XEcCx54nN02iU/twLWVkZjPFKgPi9SNSNxCDFLMOM=;
 b=VIViYHCp06z2N49VqFYx9lLgAXqZknj1kTqL2uyMb7lDJTQRGQYpwHTx3mj5Ji1jWeLh
 mqvyTvEouPk4amlvfTR7rNLFtNO3ynbTu+6gmuac/wDHSt9wdU4YiUIyIbkkw5qeE2TR
 j8TLpJoBkfV8SGKMyqQRmk8f15vf0k79aNQ= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2ves0gk3sc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Sat, 05 Oct 2019 22:43:56 -0700
Received: from 2401:db00:30:600c:face:0:39:0 (2620:10d:c081:10::13) by
 mail.thefacebook.com (2620:10d:c081:35::127) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1713.5;
 Sat, 5 Oct 2019 22:43:55 -0700
Received: by dev101.prn2.facebook.com (Postfix, from userid 137359)
        id A2DEA8618A5; Sat,  5 Oct 2019 22:43:54 -0700 (PDT)
Smtp-Origin-Hostprefix: dev
From:   Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Hostname: dev101.prn2.facebook.com
To:     <bpf@vger.kernel.org>, <netdev@vger.kernel.org>, <ast@fb.com>,
        <daniel@iogearbox.net>, <quentin.monnet@netronome.com>
CC:     <andrii.nakryiko@gmail.com>, <kernel-team@fb.com>,
        Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Cluster: prn2c23
Subject: [PATCH v3 bpf-next 0/3] Auto-generate list of BPF helpers
Date:   Sat, 5 Oct 2019 22:43:47 -0700
Message-ID: <20191006054350.3014517-1-andriin@fb.com>
X-Mailer: git-send-email 2.17.1
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-06_02:2019-10-03,2019-10-06 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 bulkscore=0 clxscore=1015 impostorscore=0 malwarescore=0 suspectscore=9
 mlxscore=0 spamscore=0 priorityscore=1501 phishscore=0 adultscore=0
 mlxlogscore=710 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1910060058
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This patch set adds ability to auto-generate list of BPF helper definitions.
It relies on existing scripts/bpf_helpers_doc.py and include/uapi/linux/bpf.h
having a well-defined set of comments. bpf_helper_defs.h contains all BPF
helper signatures which stay in sync with latest bpf.h UAPI. This
auto-generated header is included from bpf_helpers.h, while all previously
hand-written BPF helper definitions are simultaneously removed in patch #3.
The end result is less manually maintained and redundant boilerplate code,
while also more consistent and well-documented set of BPF helpers. Generated
helper definitions are completely independent from a specific bpf.h on
a target system, because it doesn't use BPF_FUNC_xxx enums.

v2->v3:
- delete bpf_helper_defs.h properly (Alexei);

v1->v2:
- add bpf_helper_defs.h to .gitignore and `make clean` (Alexei).

Andrii Nakryiko (3):
  uapi/bpf: fix helper docs
  scripts/bpf: teach bpf_helpers_doc.py to dump BPF helper definitions
  libbpf: auto-generate list of BPF helper definitions

 include/uapi/linux/bpf.h       |  32 ++--
 scripts/bpf_helpers_doc.py     | 155 ++++++++++++++++++-
 tools/include/uapi/linux/bpf.h |  32 ++--
 tools/lib/bpf/.gitignore       |   1 +
 tools/lib/bpf/Makefile         |  10 +-
 tools/lib/bpf/bpf_helpers.h    | 264 +--------------------------------
 6 files changed, 196 insertions(+), 298 deletions(-)

-- 
2.17.1

