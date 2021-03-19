Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 079F0C433E1
	for <bpf@archiver.kernel.org>; Fri, 19 Mar 2021 20:59:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD23661987
	for <bpf@archiver.kernel.org>; Fri, 19 Mar 2021 20:59:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230281AbhCSU7V convert rfc822-to-8bit (ORCPT
        <rfc822;bpf@archiver.kernel.org>); Fri, 19 Mar 2021 16:59:21 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:46680 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230226AbhCSU7O (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 19 Mar 2021 16:59:14 -0400
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 12JKuEoa005018
        for <bpf@vger.kernel.org>; Fri, 19 Mar 2021 13:59:13 -0700
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 37bs1wd1ua-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 19 Mar 2021 13:59:13 -0700
Received: from intmgw001.25.frc3.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:11d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 19 Mar 2021 13:59:12 -0700
Received: by devbig012.ftw2.facebook.com (Postfix, from userid 137359)
        id E28F52ED268B; Fri, 19 Mar 2021 13:59:10 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <netdev@vger.kernel.org>, <ast@fb.com>,
        <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>
Subject: [PATCH bpf-next 0/3] Handle no-BTF object files better
Date:   Fri, 19 Mar 2021 13:59:06 -0700
Message-ID: <20210319205909.1748642-1-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-19_12:2021-03-19,2021-03-19 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 phishscore=0 spamscore=0 priorityscore=1501 adultscore=0 clxscore=1034
 malwarescore=0 impostorscore=0 mlxscore=0 suspectscore=0 mlxlogscore=999
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103190143
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Fix two issues caused by BPF object files with missing BTF type information:
  1. BPF skeleton generated for BPF object files that use global variables but
     are compiled without BTF won't compile.
  2. BPF static linker will crash attempting to fix up BTF for input object
     file with no BTF.

This patch set also extends static linking selftest to validate correct
handling of both conditions now. For that, selftests Makefile is enhanced to
allow selecting whether a given BPF object file should be compiled with BTF or
not, based on naming convention (.nobtf.c suffix).

Andrii Nakryiko (3):
  bpftool: improve skeleton generation for objects without BTF
  libbpf: skip BTF fixup if object file has no BTF
  selftests/bpf: allow compiling BPF objects without BTF

 tools/bpf/bpftool/gen.c                       | 81 +++++++++++++++----
 tools/lib/bpf/linker.c                        |  3 +
 tools/testing/selftests/bpf/Makefile          | 21 +++--
 .../selftests/bpf/prog_tests/static_linked.c  |  6 +-
 .../bpf/progs/test_static_linked3.nobtf.c     | 36 +++++++++
 5 files changed, 123 insertions(+), 24 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/test_static_linked3.nobtf.c

-- 
2.30.2

