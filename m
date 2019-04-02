Return-Path: <SRS0=V8Hm=SE=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B04E3C43381
	for <bpf@archiver.kernel.org>; Tue,  2 Apr 2019 04:28:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D265206B8
	for <bpf@archiver.kernel.org>; Tue,  2 Apr 2019 04:28:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554179288;
	bh=bVIkH8E49BBwXe5AxlBupS5ccEcE2Hv4xO0mdmP7Zbo=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-ID:From;
	b=vV0HzxU1+C+ZDtUqklhi70IuJw80oiEoF0KUZytU5WzMr+Jzt8bQ9VCLJ9Nlzx0b/
	 sItWJ4ln84idsLMAqSe4EWlMkLLOWw/eS+cqZ9+ZBYic328Kp/UjEygPgsKO38yarq
	 dsCzLqb2IzM5OxAeyaivJ/y3hNUIh87EzaqPXx6M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728859AbfDBE2I convert rfc822-to-8bit (ORCPT
        <rfc822;bpf@archiver.kernel.org>); Tue, 2 Apr 2019 00:28:08 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:48562 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728824AbfDBE2H (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 2 Apr 2019 00:28:07 -0400
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x324RmOi022633
        for <bpf@vger.kernel.org>; Mon, 1 Apr 2019 21:28:06 -0700
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2rky2587ry-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 01 Apr 2019 21:28:06 -0700
Received: from mx-out.facebook.com (2620:10d:c0a1:3::13) by
 mail.thefacebook.com (2620:10d:c021:18::176) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1713.5;
 Mon, 1 Apr 2019 21:28:05 -0700
Received: by devbig007.ftw2.facebook.com (Postfix, from userid 572438)
        id D87FD760E11; Mon,  1 Apr 2019 21:28:03 -0700 (PDT)
Smtp-Origin-Hostprefix: devbig
From:   Alexei Starovoitov <ast@kernel.org>
Smtp-Origin-Hostname: devbig007.ftw2.facebook.com
To:     <davem@davemloft.net>
CC:     <daniel@iogearbox.net>, <jakub.kicinski@netronome.com>,
        <jannh@google.com>, <netdev@vger.kernel.org>,
        <bpf@vger.kernel.org>, <kernel-team@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH v2 bpf-next 07/10] bpf: increase verifier log limit
Date:   Mon, 1 Apr 2019 21:27:46 -0700
Message-ID: <20190402042749.3670015-8-ast@kernel.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20190402042749.3670015-1-ast@kernel.org>
References: <20190402042749.3670015-1-ast@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-02_02:,,
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
Reviewed-by: Jakub Kicinski <jakub.kicinski@netronome.com>
---
 kernel/bpf/verifier.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index b631e89e7a51..bb27b675923c 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -7974,7 +7974,7 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr,
 
 		ret = -EINVAL;
 		/* log attributes have to be sane */
-		if (log->len_total < 128 || log->len_total > UINT_MAX >> 8 ||
+		if (log->len_total < 128 || log->len_total > UINT_MAX >> 2 ||
 		    !log->level || !log->ubuf || log->level & ~BPF_LOG_MASK)
 			goto err_unlock;
 	}
-- 
2.20.0

