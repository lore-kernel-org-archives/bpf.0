Return-Path: <SRS0=adOE=RE=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C035C10F06
	for <bpf@archiver.kernel.org>; Fri,  1 Mar 2019 01:37:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 496B02085A
	for <bpf@archiver.kernel.org>; Fri,  1 Mar 2019 01:37:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="S6m/Kc6V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387403AbfCABhV (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 28 Feb 2019 20:37:21 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:44900 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728438AbfCABhV (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 28 Feb 2019 20:37:21 -0500
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x211Yono032318
        for <bpf@vger.kernel.org>; Thu, 28 Feb 2019 17:37:20 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=facebook;
 bh=/tP93KPijyHbAiqVq8qivdYvM58XtIcK0aYgSQuuKM8=;
 b=S6m/Kc6VdmmRGN2lOWndoB2wHklruWINHMthu23P6EjNmvfdoLA5tRLF8AtRbACajAP+
 NN43DBwbWMwzHqy8pHRJ4qv9LQ+kwFfvWykbxEcHFwz04HBvL+s/B+/bZwVxx6b4aDVg
 g9L/knlyF1RkqOYbclJT3fsUFFA0QLMXK9U= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2qxqw2gmcy-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 28 Feb 2019 17:37:20 -0800
Received: from mx-out.facebook.com (2620:10d:c081:10::13) by
 mail.thefacebook.com (2620:10d:c081:35::130) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1531.3;
 Thu, 28 Feb 2019 17:37:19 -0800
Received: by devvm7221.prn2.facebook.com (Postfix, from userid 137359)
        id 2DC34C16CA31; Thu, 28 Feb 2019 17:37:19 -0800 (PST)
Smtp-Origin-Hostprefix: devvm
From:   Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Hostname: devvm7221.prn2.facebook.com
To:     <andrii.nakryiko@gmail.com>, <ast@fb.com>, <yhs@fb.com>,
        <netdev@vger.kernel.org>, <bpf@vger.kernel.org>,
        <daniel@iogearbox.net>, <songliubraving@fb.com>
CC:     Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Cluster: prn2c23
Subject: [PATCH bpf-next 0/4] Formatting and typo fixes in kernel/bpf
Date:   Thu, 28 Feb 2019 17:37:12 -0800
Message-ID: <20190301013716.1370014-1-andriin@fb.com>
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

Few formatting fixes, as well as some comments clean up.

Andrii Nakryiko (4):
  bpf: formatting fixes in syscall.c
  bpf/verifier: fix code formatting
  bpf/verifier: typo fixes and reflow verifier overview comment
  bpf/verifier: fix minor typos in comments

 kernel/bpf/syscall.c  |   5 +-
 kernel/bpf/verifier.c | 169 +++++++++++++++++++++---------------------
 2 files changed, 87 insertions(+), 87 deletions(-)

-- 
2.17.1

