Return-Path: <SRS0=P9GS=RC=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5848C43381
	for <bpf@archiver.kernel.org>; Wed, 27 Feb 2019 22:47:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E50A213A2
	for <bpf@archiver.kernel.org>; Wed, 27 Feb 2019 22:47:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="XBoTc1HZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729412AbfB0Wqy (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 27 Feb 2019 17:46:54 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:40150 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730284AbfB0Wqx (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 27 Feb 2019 17:46:53 -0500
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.27/8.16.0.27) with SMTP id x1RMbOtb005758
        for <bpf@vger.kernel.org>; Wed, 27 Feb 2019 14:46:50 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=facebook;
 bh=EnqBYrKAbCQ3FbGFtNLPuue/nErobZeuXsfYAfoNtI0=;
 b=XBoTc1HZ/5O8Mp6QyLkugB2S1RBY2jwzKWhVgay2QVpZFpr9LrchHVSwsY4J0/EfexXc
 VFll6Y5L1/9NBoIVnHvGZEYIDcsJ0OjwodpYT2dh9XcKcaFb/fau5ONE7SAdWbbnzzVK
 c1xsccFKL1L8ymhKCrnOXSku2lqM/yljvEg= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by m0001303.ppops.net with ESMTP id 2qx25v89r7-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 27 Feb 2019 14:46:50 -0800
Received: from mx-out.facebook.com (2620:10d:c0a1:3::13) by
 mail.thefacebook.com (2620:10d:c021:18::171) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1531.3;
 Wed, 27 Feb 2019 14:46:49 -0800
Received: by devvm7221.prn2.facebook.com (Postfix, from userid 137359)
        id 8E65AC07CCCC; Wed, 27 Feb 2019 14:46:47 -0800 (PST)
Smtp-Origin-Hostprefix: devvm
From:   Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Hostname: devvm7221.prn2.facebook.com
To:     <andrii.nakryiko@gmail.com>, <kernel-team@fb.com>, <ast@fb.com>,
        <acme@kernel.org>, <netdev@vger.kernel.org>, <bpf@vger.kernel.org>,
        <daniel@iogearbox.net>
CC:     Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Cluster: prn2c23
Subject: [PATCH bpf-next 0/5] btf_dedup algorithm and test fixes
Date:   Wed, 27 Feb 2019 14:46:36 -0800
Message-ID: <20190227224642.1069138-1-andriin@fb.com>
X-Mailer: git-send-email 2.17.1
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-27_15:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This patchset fixes a bug in btf_dedup() algorithm, which under specific hash
collision causes infinite loop. It also exposes ability to tune BTF
deduplication table size, with double purpose of allowing applications to
adjust size according to the size of BTF data, as well as allowing a simple way
to force hash collisions by setting table size to 1.

- Patch #1 fixes bug in btf_dedup testing code that's checking strings
- Patch #2 fixes pointer arg formatting in btf.h
- Patch #3 adds option to specify custom dedup table size
- Patch #4 fixes aforementioned bug in btf_dedup
- Patch #5 adds test that validates the fix

Andrii Nakryiko (5):
  selftests/bpf: fix btf_dedup testing code
  libbpf: fix formatting for btf_ext__get_raw_data
  btf: allow to customize dedup hash table size
  btf: fix bug with resolving STRUCT/UNION into corresponding FWD
  selftests/bpf: add btf_dedup test of FWD/STRUCT resolution

 tools/lib/bpf/btf.c                    | 49 ++++++++++++++++----------
 tools/lib/bpf/btf.h                    |  3 +-
 tools/testing/selftests/bpf/.gitignore |  1 +
 tools/testing/selftests/bpf/test_btf.c | 49 ++++++++++++++++++++++++--
 4 files changed, 81 insertions(+), 21 deletions(-)

-- 
2.17.1

