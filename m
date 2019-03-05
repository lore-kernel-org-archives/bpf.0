Return-Path: <SRS0=GR7L=RI=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57703C43381
	for <bpf@archiver.kernel.org>; Tue,  5 Mar 2019 17:43:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DC30208E4
	for <bpf@archiver.kernel.org>; Tue,  5 Mar 2019 17:43:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="b3A8vKmF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729168AbfCERn4 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 5 Mar 2019 12:43:56 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:37340 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729166AbfCERn4 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 5 Mar 2019 12:43:56 -0500
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.27/8.16.0.27) with SMTP id x25HdE9h018080
        for <bpf@vger.kernel.org>; Tue, 5 Mar 2019 09:43:55 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=facebook;
 bh=ZL5RRZw96G4dPX6lfmcwmMVpCpZ/aehWCayD5hq9oAw=;
 b=b3A8vKmFFavHlO9UR+13ChKl7LjwDWYgZrZWim5y7jmtOON0kDW2DigdQhkNtUvh+zd2
 JEoB9EkxE71ZErrBoQga4CH2Hj6CCKkNJf+da2E5Mlq6UecHG3t7GWchnSgkpSL6iaY7
 iU0veWp9V4iTSdm9zmESNsaK7E18vBfTJGU= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by m0089730.ppops.net with ESMTP id 2r1vtkr711-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 05 Mar 2019 09:43:55 -0800
Received: from mx-out.facebook.com (2620:10d:c0a1:3::13) by
 mail.thefacebook.com (2620:10d:c021:18::174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1713.5;
 Tue, 5 Mar 2019 09:43:54 -0800
Received: by dev101.prn2.facebook.com (Postfix, from userid 137359)
        id D18D4861475; Tue,  5 Mar 2019 09:43:52 -0800 (PST)
Smtp-Origin-Hostprefix: dev
From:   Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Hostname: dev101.prn2.facebook.com
To:     <andrii.nakryiko@gmail.com>, <acme@kernel.org>,
        <dwarves@vger.kernel.org>, <bpf@vger.kernel.org>, <ast@fb.com>,
        <yhs@fb.com>
CC:     Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Cluster: prn2c23
Subject: [PATCH] libbpf: update reference to bring in btf_dedup fixes
Date:   Tue, 5 Mar 2019 09:43:51 -0800
Message-ID: <20190305174351.2995025-1-andriin@fb.com>
X-Mailer: git-send-email 2.17.1
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-05_09:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Latest version of libbpf has btf_dedup() fixes preventing it from stucking
in a loop on allyesconfig kernels.

Signed-off-by: Andrii Nakryiko <andriin@fb.com>
---
 lib/bpf | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bpf b/lib/bpf
index d5fa415..8c18b03 160000
--- a/lib/bpf
+++ b/lib/bpf
@@ -1 +1 @@
-Subproject commit d5fa4150f0c3a36e3ce458e1301531bd2edbf74d
+Subproject commit 8c18b03ae3e7e9f0a83df8cdaf4717b91bc9466c
-- 
2.17.1

