Return-Path: <SRS0=8uh4=SB=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFD7AC43381
	for <bpf@archiver.kernel.org>; Sat, 30 Mar 2019 00:16:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93D9221773
	for <bpf@archiver.kernel.org>; Sat, 30 Mar 2019 00:16:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553904992;
	bh=gcNf7cReQS13xZeanAvZxeqLsy34o7xNPFGpbq3iooU=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-ID:From;
	b=x9qgitEPR0bkYB00DSk9NFSkoz7+0vZd+YIW0np73oTg1AFDebB1y/07F1lLV38Rj
	 5V8vZRHTYfO0VB7lPWHrE84UI2ueVzDlO1yVFUhN5F+hFNvGpOysmPptsiZ3io4lCq
	 PXpEEab72JTaEw+sCiCA97RieqGNRR8FZN6htvZo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730316AbfC3AQc convert rfc822-to-8bit (ORCPT
        <rfc822;bpf@archiver.kernel.org>); Fri, 29 Mar 2019 20:16:32 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:43996 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730305AbfC3AQa (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 29 Mar 2019 20:16:30 -0400
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.27/8.16.0.27) with SMTP id x2U06JQA024534
        for <bpf@vger.kernel.org>; Fri, 29 Mar 2019 17:16:29 -0700
Received: from mail.thefacebook.com ([199.201.64.23])
        by m0001303.ppops.net with ESMTP id 2rhwc4g2eb-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 29 Mar 2019 17:16:29 -0700
Received: from mx-out.facebook.com (2620:10d:c081:10::13) by
 mail.thefacebook.com (2620:10d:c081:35::130) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1713.5;
 Fri, 29 Mar 2019 17:16:27 -0700
Received: by devbig007.ftw2.facebook.com (Postfix, from userid 572438)
        id 156A2760BC0; Fri, 29 Mar 2019 17:16:23 -0700 (PDT)
Smtp-Origin-Hostprefix: devbig
From:   Alexei Starovoitov <ast@kernel.org>
Smtp-Origin-Hostname: devbig007.ftw2.facebook.com
To:     <davem@davemloft.net>
CC:     <daniel@iogearbox.net>, <jakub.kicinski@netronome.com>,
        <jannh@google.com>, <netdev@vger.kernel.org>,
        <bpf@vger.kernel.org>, <kernel-team@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH bpf-next 5/7] bpf: increase verifier log limit
Date:   Fri, 29 Mar 2019 17:16:10 -0700
Message-ID: <20190330001612.2354959-6-ast@kernel.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20190330001612.2354959-1-ast@kernel.org>
References: <20190330001612.2354959-1-ast@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-29_14:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The existing 16Mbyte verifier log limit is not enough for log_level=2
even for small programs. Increase it to 1Gbyte.
Note it's not a kernel memory limit.
It's an amount of memory user space provides to store
the verifier log. The kernel populates it 1k at a time.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/verifier.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 76089a094147..3722fb0bc7bc 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -7969,7 +7969,7 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr,
 
 		ret = -EINVAL;
 		/* log attributes have to be sane */
-		if (log->len_total < 128 || log->len_total > UINT_MAX >> 8 ||
+		if (log->len_total < 128 || log->len_total > UINT_MAX >> 2 ||
 		    !log->level || !log->ubuf || log->level & ~BPF_LOG_MASK)
 			goto err_unlock;
 	}
-- 
2.20.0

