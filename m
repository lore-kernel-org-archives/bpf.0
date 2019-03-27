Return-Path: <SRS0=YLVI=R6=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C3DEC43381
	for <bpf@archiver.kernel.org>; Wed, 27 Mar 2019 05:00:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E92CE2082F
	for <bpf@archiver.kernel.org>; Wed, 27 Mar 2019 05:00:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732570AbfC0FAO (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 27 Mar 2019 01:00:14 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:56370 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726810AbfC0FAO (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 27 Mar 2019 01:00:14 -0400
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2R4wviQ010955
        for <bpf@vger.kernel.org>; Tue, 26 Mar 2019 22:00:13 -0700
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2rft66a4dq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 26 Mar 2019 22:00:13 -0700
Received: from mx-out.facebook.com (2620:10d:c081:10::13) by
 mail.thefacebook.com (2620:10d:c081:35::126) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1713.5;
 Tue, 26 Mar 2019 22:00:12 -0700
Received: by dev101.prn2.facebook.com (Postfix, from userid 137359)
        id 5B83C8614AD; Tue, 26 Mar 2019 22:00:12 -0700 (PDT)
Smtp-Origin-Hostprefix: dev
From:   <andrii.nakryiko@gmail.com>
Smtp-Origin-Hostname: dev101.prn2.facebook.com
To:     <andrii.nakryiko@gmail.com>, <ast@fb.com>, <yhs@fb.com>,
        <bpf@vger.kernel.org>, <netdev@vger.kernel.org>, <acme@kernel.org>,
        <kernel-team@fb.com>, <daniel@iogearbox.net>
CC:     Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Cluster: prn2c23
Subject: [PATCH bpf 0/2] fix btf_dedup()'s type graph equivalence check
Date:   Tue, 26 Mar 2019 22:00:05 -0700
Message-ID: <20190327050007.2419746-1-andrii.nakryiko@gmail.com>
X-Mailer: git-send-email 2.17.1
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-27_03:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Andrii Nakryiko <andriin@fb.com>

This patch set fixes bug in btf_dedup_is_equiv() check mishandling equivalence
comparison between VOID kind in candidate type graph versus anonymous non-VOID
kind in canonical type graph.

Patch #1 fixes bug, by comparing candidate and canonical kinds for equality,
before proceeding to kind-specific checks.
Patch #2 adds a test case testing this specific scenario.

Andrii Nakryiko (2):
  libbpf: fix btf_dedup equivalence check handling of different kinds
  selftests/bpf: add btf_dedup test for VOID equivalence check

 tools/lib/bpf/btf.c                    |  3 ++
 tools/testing/selftests/bpf/test_btf.c | 47 ++++++++++++++++++++++++++
 2 files changed, 50 insertions(+)

-- 
2.17.1

