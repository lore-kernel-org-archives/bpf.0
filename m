Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3810BC433F5
	for <bpf@archiver.kernel.org>; Tue, 21 Sep 2021 21:01:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2047561165
	for <bpf@archiver.kernel.org>; Tue, 21 Sep 2021 21:01:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233629AbhIUVCu convert rfc822-to-8bit (ORCPT
        <rfc822;bpf@archiver.kernel.org>); Tue, 21 Sep 2021 17:02:50 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:42482 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S231592AbhIUVCt (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 21 Sep 2021 17:02:49 -0400
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.1.2/8.16.1.2) with SMTP id 18LH9ilh008435
        for <bpf@vger.kernel.org>; Tue, 21 Sep 2021 14:01:20 -0700
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0089730.ppops.net with ESMTP id 3b7gfcu0h8-8
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 21 Sep 2021 14:01:20 -0700
Received: from intmgw002.46.prn1.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:21d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Tue, 21 Sep 2021 14:00:39 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 1F8BE49ACEFB; Tue, 21 Sep 2021 14:00:38 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>
Subject: [PATCH v2 bpf-next 0/4] libbpf: add legacy uprobe support
Date:   Tue, 21 Sep 2021 14:00:32 -0700
Message-ID: <20210921210036.1545557-1-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-GUID: F2tLXBkNhYZCbdXTOD5-9nooI18aulD6
X-Proofpoint-ORIG-GUID: F2tLXBkNhYZCbdXTOD5-9nooI18aulD6
Content-Transfer-Encoding: 8BIT
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-21_06,2021-09-20_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 clxscore=1015 spamscore=0
 impostorscore=0 bulkscore=0 suspectscore=0 priorityscore=1501
 mlxlogscore=787 phishscore=0 malwarescore=0 mlxscore=0 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109030001 definitions=main-2109210125
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Implement libbpf support for attaching uprobes/uretprobes using legacy
tracefs interfaces. This is a logical complement to recently landed legacy
kprobe support ([0]). This patch refactors existing legacy kprobe code to be more
uniform with uprobe code as well, making the logic easier to compare and
follow.

This patch set also fixes two bugs recently found by Coverity in legacy kprobe
handling code, and thus subsumes previously submitted two patches ([1]):
original patch #1 is kept as is, while original patch #2 was dropped because
patch #3 of the current series refactors and fixes affected code.

  [0] https://patchwork.kernel.org/project/netdevbpf/patch/20210912064844.3181742-1-rafaeldtinoco@gmail.com/
  [1] https://patchwork.kernel.org/project/netdevbpf/list/?series=549977&state=*

v1->v2:
  - drop 'legacy = true' debug left-over and explain legacy check (Alexei).

Andrii Nakryiko (4):
  libbpf: fix memory leak in legacy kprobe attach logic
  selftests/bpf: adopt attach_probe selftest to work on old kernels
  libbpf: refactor and simplify legacy kprobe code
  libbpf: add legacy uprobe attaching support

 tools/lib/bpf/libbpf.c                        | 297 +++++++++++++-----
 tools/lib/bpf/libbpf.h                        |   2 +-
 .../selftests/bpf/prog_tests/attach_probe.c   |  24 +-
 3 files changed, 236 insertions(+), 87 deletions(-)

-- 
2.30.2

