Return-Path: <SRS0=adOE=RE=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35EB5C43381
	for <bpf@archiver.kernel.org>; Fri,  1 Mar 2019 01:12:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9EA22087E
	for <bpf@archiver.kernel.org>; Fri,  1 Mar 2019 01:12:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="FfVUSNHI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728164AbfCABM1 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 28 Feb 2019 20:12:27 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:33070 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727005AbfCABM1 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 28 Feb 2019 20:12:27 -0500
Received: from pps.filterd (m0044008.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x210x3bO015688
        for <bpf@vger.kernel.org>; Thu, 28 Feb 2019 17:12:26 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=facebook;
 bh=8txS0RO+eBIf3qV2C17zMerL0ZBEHVCw4h2k93uNAHg=;
 b=FfVUSNHI46ArCGVfgbbVkzUOLpueOTwBOc/XrLJ335icl/gufLygaSyabQfnkQOR4O5N
 rUe1AoBIITKhI0zg1NCDCEUbyIFExu0fROThU2Y0rZouYJ9pepgbvXIOpkmyMzPfiPvt
 kK38tVOBdehUrKyluQIB2RQrTPbMz4m/ZEE= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2qxsa0g96s-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 28 Feb 2019 17:12:26 -0800
Received: from mx-out.facebook.com (2620:10d:c081:10::13) by
 mail.thefacebook.com (2620:10d:c081:35::128) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1531.3;
 Thu, 28 Feb 2019 17:12:25 -0800
Received: by devvm7221.prn2.facebook.com (Postfix, from userid 137359)
        id 70319C16801E; Thu, 28 Feb 2019 17:12:25 -0800 (PST)
Smtp-Origin-Hostprefix: devvm
From:   Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Hostname: devvm7221.prn2.facebook.com
To:     <andrii.nakryiko@gmail.com>, <ast@fb.com>, <yhs@fb.com>,
        <netdev@vger.kernel.org>, <bpf@vger.kernel.org>,
        <daniel@iogearbox.net>, <songliubraving@fb.com>
CC:     Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Cluster: prn2c23
Subject: [PATCH v2 bpf-next 0/3] bpf docs typo, wording and formatting fixes
Date:   Thu, 28 Feb 2019 17:12:18 -0800
Message-ID: <20190301011221.1290474-1-andriin@fb.com>
X-Mailer: git-send-email 2.17.1
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-01_01:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

A bunch of BPF-related docs typo, wording and formatting fixes.

v1->v2:
- split off non-documentation changes into separate patchset

Andrii Nakryiko (3):
  docs/btf: fix typos, improve wording
  docs/btf: reflow text to fill up to 78 characters
  docs/bpf: minor casing/punctuation fixes

 Documentation/bpf/bpf_design_QA.rst |  24 +--
 Documentation/bpf/btf.rst           | 316 +++++++++++++---------------
 Documentation/networking/filter.txt |   2 +-
 3 files changed, 160 insertions(+), 182 deletions(-)

-- 
2.17.1

