Return-Path: <SRS0=nHBb=2F=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5D25C43603
	for <bpf@archiver.kernel.org>; Sun, 15 Dec 2019 07:08:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73BD52253D
	for <bpf@archiver.kernel.org>; Sun, 15 Dec 2019 07:08:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="eCgWoUjP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725861AbfLOHIu (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Sun, 15 Dec 2019 02:08:50 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:57120 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725827AbfLOHIu (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sun, 15 Dec 2019 02:08:50 -0500
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xBF753qO031158
        for <bpf@vger.kernel.org>; Sat, 14 Dec 2019 23:08:49 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=facebook;
 bh=kHZMS/PwvMTKOTlmmhL8ngUxDS3HYRtf2MSxDrn7VaE=;
 b=eCgWoUjPOiRHVCNo+XbjEcG3kAUKTCRC1fRHAx9YwGmyqSJ0uAiDAZRSJJAWlxvxX3KB
 Nb2lDUx9v4lW+pWPg3wbewoKMriXHmpd3aF6bfinWvbF7K5lbKk89DAuTlHB7mEaJbEa
 UNH5rv+jjWgHv6vGJbGUsVplRpOYUmiKw10= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2wvxbvag6y-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Sat, 14 Dec 2019 23:08:49 -0800
Received: from intmgw004.05.ash5.facebook.com (2620:10d:c081:10::13) by
 mail.thefacebook.com (2620:10d:c081:35::128) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1713.5;
 Sat, 14 Dec 2019 23:08:47 -0800
Received: by devbig012.ftw2.facebook.com (Postfix, from userid 137359)
        id 042182EC1683; Sat, 14 Dec 2019 23:08:46 -0800 (PST)
Smtp-Origin-Hostprefix: devbig
From:   Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Hostname: devbig012.ftw2.facebook.com
To:     <bpf@vger.kernel.org>, <netdev@vger.kernel.org>, <ast@fb.com>,
        <daniel@iogearbox.net>
CC:     <andrii.nakryiko@gmail.com>, <kernel-team@fb.com>,
        Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH bpf-next 0/2] CO-RE relocation support for flexible arrays
Date:   Sat, 14 Dec 2019 23:08:42 -0800
Message-ID: <20191215070844.1014385-1-andriin@fb.com>
X-Mailer: git-send-email 2.17.1
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-15_01:2019-12-13,2019-12-15 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 bulkscore=0 phishscore=0
 malwarescore=0 suspectscore=8 lowpriorityscore=0 mlxlogscore=595
 mlxscore=0 spamscore=0 adultscore=0 clxscore=1015 priorityscore=1501
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1912150066
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add support for flexible array accesses in a relocatable manner in BPF CO-RE.
It's a typical pattern in C, and kernel in particular, to provide
a fixed-length struct with zero-sized or dimensionless array at the end. In
such cases variable-sized array contents follows immediately after the end of
a struct. This patch set adds support for such access pattern by allowing
accesses to such arrays.

Patch #1 adds libbpf support. Patch #2 adds few test cases for validation.

Andrii Nakryiko (2):
  libbpf: support flexible arrays in CO-RE
  selftests/bpf: add flexible array relocation tests

 tools/lib/bpf/libbpf.c                        | 34 +++++++++++++---
 .../selftests/bpf/prog_tests/core_reloc.c     |  4 ++
 ...f__core_reloc_arrays___equiv_zero_sz_arr.c |  3 ++
 ..._core_reloc_arrays___err_bad_zero_sz_arr.c |  3 ++
 .../btf__core_reloc_arrays___fixed_arr.c      |  3 ++
 .../selftests/bpf/progs/core_reloc_types.h    | 39 +++++++++++++++++++
 .../bpf/progs/test_core_reloc_arrays.c        |  8 ++--
 7 files changed, 85 insertions(+), 9 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/btf__core_reloc_arrays___equiv_zero_sz_arr.c
 create mode 100644 tools/testing/selftests/bpf/progs/btf__core_reloc_arrays___err_bad_zero_sz_arr.c
 create mode 100644 tools/testing/selftests/bpf/progs/btf__core_reloc_arrays___fixed_arr.c

-- 
2.17.1

