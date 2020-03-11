Return-Path: <SRS0=y2jO=44=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45CD6C0044D
	for <bpf@archiver.kernel.org>; Wed, 11 Mar 2020 22:19:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 316FB2074D
	for <bpf@archiver.kernel.org>; Wed, 11 Mar 2020 22:19:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="c5inGZEn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729848AbgCKWTV (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 11 Mar 2020 18:19:21 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:10148 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729991AbgCKWTV (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 11 Mar 2020 18:19:21 -0400
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.42/8.16.0.42) with SMTP id 02BMJD3g005871
        for <bpf@vger.kernel.org>; Wed, 11 Mar 2020 15:19:19 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=facebook;
 bh=voGMUPiM6dI/NAH5P1Z0ewWY24B56X13JJDunnFmec0=;
 b=c5inGZEnJbuVQz/B9p5EQDxhGjawWxoCbWNHD2wRVhQ1eSS2FmuKaLNu/FgdjmPcoyul
 LZn8KBzgdSqMj6M8ULkXh+YnLDme03yhO4uu1EXoQ05x51mtfl4SKbLkDJccu9HtLOj0
 Cm526YqzOFPtaUlob1Fg7ns13/2eE+bROKc= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0001303.ppops.net with ESMTP id 2ypkv9dhup-15
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 11 Mar 2020 15:19:19 -0700
Received: from intmgw001.03.ash8.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1847.3; Wed, 11 Mar 2020 15:18:50 -0700
Received: by devbig006.ftw2.facebook.com (Postfix, from userid 4523)
        id C206E62E2936; Wed, 11 Mar 2020 15:18:46 -0700 (PDT)
Smtp-Origin-Hostprefix: devbig
From:   Song Liu <songliubraving@fb.com>
Smtp-Origin-Hostname: devbig006.ftw2.facebook.com
To:     <netdev@vger.kernel.org>, <bpf@vger.kernel.org>
CC:     <john.fastabend@gmail.com>, <quentin@isovalent.com>,
        <kernel-team@fb.com>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <arnaldo.melo@gmail.com>, <jolsa@kernel.org>,
        Song Liu <songliubraving@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH v2 bpf-next 0/3] Fixes for bpftool-prog-profile
Date:   Wed, 11 Mar 2020 15:18:41 -0700
Message-ID: <20200311221844.3089820-1-songliubraving@fb.com>
X-Mailer: git-send-email 2.17.1
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-03-11_11:2020-03-11,2020-03-11 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 priorityscore=1501 malwarescore=0 bulkscore=0 suspectscore=0 mlxscore=0
 adultscore=0 clxscore=1015 phishscore=0 spamscore=0 mlxlogscore=754
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2003110125
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

1. Fix build for older clang;
2. Fix skeleton's dependency on libbpf;
3. Add files to .gitignore.

Changes v1 => v2:
1. Rewrite patch 1 with real feature detection (Quentin, Alexei).
2. Add files to .gitignore (Andrii).

Song Liu (3):
  bpftool: only build bpftool-prog-profile if supported by clang
  bpftool: skeleton should depend on libbpf
  bpftool: add _bpftool and profiler.skel.h to .gitignore

 tools/bpf/bpftool/.gitignore                    |  2 ++
 tools/bpf/bpftool/Makefile                      | 17 ++++++++++++-----
 tools/bpf/bpftool/prog.c                        |  2 ++
 tools/build/feature/Makefile                    |  9 ++++++++-
 tools/build/feature/test-clang-bpf-global-var.c |  4 ++++
 5 files changed, 28 insertions(+), 6 deletions(-)
 create mode 100644 tools/build/feature/test-clang-bpf-global-var.c

--
2.17.1
