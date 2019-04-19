Return-Path: <SRS0=ErZJ=SV=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9205C282DF
	for <bpf@archiver.kernel.org>; Fri, 19 Apr 2019 18:24:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7796C20652
	for <bpf@archiver.kernel.org>; Fri, 19 Apr 2019 18:24:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555698276;
	bh=FW32HnFNlnPxVBsIj85M3ajruzhCc6NMImzWIVvehYQ=;
	h=From:To:CC:Subject:Date:List-ID:From;
	b=SJ/uHfPvTj2aZsE6sOGpDUYEElQPFftIA0lUc6yqnCcQzRyy61DvbytmRdTGBpiZq
	 Q4j52VBmEHiOg6bHVJmZFwTd2/d7o6YrrajpDVW0H9smOFwufsrU+CRkQR7B171sNB
	 MAHo6+rcCKgbATpu+gxwAhx0hJXFxV/YYHl+TPT0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727033AbfDSSYf convert rfc822-to-8bit (ORCPT
        <rfc822;bpf@archiver.kernel.org>); Fri, 19 Apr 2019 14:24:35 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:37724 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727100AbfDSSYb (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 19 Apr 2019 14:24:31 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3JEj86M023535
        for <bpf@vger.kernel.org>; Fri, 19 Apr 2019 07:45:29 -0700
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2rxyd0tv1c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 19 Apr 2019 07:45:29 -0700
Received: from mx-out.facebook.com (2620:10d:c081:10::13) by
 mail.thefacebook.com (2620:10d:c081:35::127) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1713.5;
 Fri, 19 Apr 2019 07:44:56 -0700
Received: by devbig007.ftw2.facebook.com (Postfix, from userid 572438)
        id 77A577605DE; Fri, 19 Apr 2019 07:44:55 -0700 (PDT)
Smtp-Origin-Hostprefix: devbig
From:   Alexei Starovoitov <ast@kernel.org>
Smtp-Origin-Hostname: devbig007.ftw2.facebook.com
To:     <davem@davemloft.net>
CC:     <daniel@iogearbox.net>, <netdev@vger.kernel.org>,
        <bpf@vger.kernel.org>, <kernel-team@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH bpf-next 0/2] bpf: parallel verification
Date:   Fri, 19 Apr 2019 07:44:53 -0700
Message-ID: <20190419144455.853134-1-ast@kernel.org>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-19_08:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Allow the bpf verifier to run in parallel for root.

Alexei Starovoitov (2):
  bpf: remove global variables
  bpf: drop bpf_verifier_lock

 include/linux/bpf_verifier.h |  5 +++++
 kernel/bpf/verifier.c        | 33 ++++++++++++++++++---------------
 2 files changed, 23 insertions(+), 15 deletions(-)

-- 
2.20.0

