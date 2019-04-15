Return-Path: <SRS0=RZwz=SR=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FC9EC10F0E
	for <bpf@archiver.kernel.org>; Mon, 15 Apr 2019 23:48:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E631A20675
	for <bpf@archiver.kernel.org>; Mon, 15 Apr 2019 23:48:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727012AbfDOXsN (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 15 Apr 2019 19:48:13 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:43828 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727201AbfDOXsN (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 15 Apr 2019 19:48:13 -0400
Received: from pps.filterd (m0001255.ppops.net [127.0.0.1])
        by mx0b-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3FNkTsn014025
        for <bpf@vger.kernel.org>; Mon, 15 Apr 2019 16:48:12 -0700
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by mx0b-00082601.pphosted.com with ESMTP id 2rvuaat1vv-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 15 Apr 2019 16:48:12 -0700
Received: from mx-out.facebook.com (2620:10d:c081:10::13) by
 mail.thefacebook.com (2620:10d:c081:35::127) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1713.5;
 Mon, 15 Apr 2019 16:48:10 -0700
Received: by dev101.prn2.facebook.com (Postfix, from userid 137359)
        id 45C7A86177B; Mon, 15 Apr 2019 16:48:10 -0700 (PDT)
Smtp-Origin-Hostprefix: dev
From:   <andrii.nakryiko@gmail.com>
Smtp-Origin-Hostname: dev101.prn2.facebook.com
To:     <andrii.nakryiko@gmail.com>, <netdev@vger.kernel.org>,
        <bpf@vger.kernel.org>, <kernel-team@fb.com>
CC:     Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Cluster: prn2c23
Subject: [PATCH bpf-next 0/2] add btf_dedup() support for VAR and DATASEC
Date:   Mon, 15 Apr 2019 16:48:06 -0700
Message-ID: <20190415234808.2225360-1-andrii.nakryiko@gmail.com>
X-Mailer: git-send-email 2.17.1
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-15_08:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Andrii Nakryiko <andriin@fb.com>

This patchset adds support for new BTF_KIND_VAR and BTF_KIND_DATASEC BTF types
in btf_dedup() algorithm. VAR and DATASEC are not deduplicated and are always
considered to be unique, but they require referenced type IDs adjustment.

Patch #1 adds VAR/DATASEC pass-through support to btf_dedup().
Patch #2 adds a test validating all the type ID adjustments are correct.

Andrii Nakryiko (2):
  btf: add support for VAR and DATASEC in btf_dedup()
  selftests/btf: add VAR and DATASEC case for dedup tests

 tools/lib/bpf/btf.c                    | 29 +++++++++++++--
 tools/testing/selftests/bpf/test_btf.c | 49 ++++++++++++++++++++++++++
 2 files changed, 76 insertions(+), 2 deletions(-)

-- 
2.17.1

