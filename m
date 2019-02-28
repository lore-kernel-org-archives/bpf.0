Return-Path: <SRS0=vk/n=RD=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BB2BC43381
	for <bpf@archiver.kernel.org>; Thu, 28 Feb 2019 23:31:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0664420830
	for <bpf@archiver.kernel.org>; Thu, 28 Feb 2019 23:31:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="L+I6hXW5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732089AbfB1Xbi (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 28 Feb 2019 18:31:38 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:39800 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731528AbfB1Xbh (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 28 Feb 2019 18:31:37 -0500
Received: from pps.filterd (m0044008.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1SNTImH009607
        for <bpf@vger.kernel.org>; Thu, 28 Feb 2019 15:31:36 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=facebook;
 bh=1e7x68CGLqhX03yQcKk/7eyg9sz/q/hmhpbn8rw2Kyc=;
 b=L+I6hXW5HhoPjxOGV8uPYXpmiLyQ2F62qQRdlKJ6tCiQ2G8AM4F5HuzYO581MomkB8Ni
 8OoyHUqbYZaUttVKJSuZFS1gT+sga1ZIlBCRjZJSLSn7VxaCe1TDBtix61y9rJALnovL
 f0aceH95++PoQJMEVp8rs5wpRurxwGnZH/A= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2qxsa0g0jf-20
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 28 Feb 2019 15:31:36 -0800
Received: from mx-out.facebook.com (2620:10d:c081:10::13) by
 mail.thefacebook.com (2620:10d:c081:35::126) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1531.3;
 Thu, 28 Feb 2019 15:31:27 -0800
Received: by devvm7221.prn2.facebook.com (Postfix, from userid 137359)
        id C358EC155DD8; Thu, 28 Feb 2019 15:31:26 -0800 (PST)
Smtp-Origin-Hostprefix: devvm
From:   Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Hostname: devvm7221.prn2.facebook.com
To:     <andrii.nakryiko@gmail.com>, <kernel-team@fb.com>, <ast@fb.com>,
        <acme@kernel.org>, <netdev@vger.kernel.org>, <bpf@vger.kernel.org>,
        <daniel@iogearbox.net>, <songliubraving@fb.com>
CC:     Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Cluster: prn2c23
Subject: [PATCH v2 bpf-next 0/5] btf_dedup algorithm and test fixes
Date:   Thu, 28 Feb 2019 15:31:20 -0800
Message-ID: <20190228233125.1013080-1-andriin@fb.com>
X-Mailer: git-send-email 2.17.1
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-28_15:,,
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

v1->v2:
- remove "Fixes" from formatting change patch
- extract roundup_pow2_max func for dedup table size
- btf_equal_struct -> btf_shallow_equal_struct
- explain in comment why we can't rely on just btf_dedup_is_equiv

Andrii Nakryiko (5):
  selftests/bpf: fix btf_dedup testing code
  libbpf: fix formatting for btf_ext__get_raw_data
  btf: allow to customize dedup hash table size
  btf: fix bug with resolving STRUCT/UNION into corresponding FWD
  selftests/bpf: add btf_dedup test of FWD/STRUCT resolution

 tools/lib/bpf/btf.c                    | 73 +++++++++++++++++++-------
 tools/lib/bpf/btf.h                    |  3 +-
 tools/testing/selftests/bpf/.gitignore |  1 +
 tools/testing/selftests/bpf/test_btf.c | 49 ++++++++++++++++-
 4 files changed, 103 insertions(+), 23 deletions(-)

-- 
2.17.1

