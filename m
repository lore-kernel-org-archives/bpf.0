Return-Path: <SRS0=V8Hm=SE=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5172C4360F
	for <bpf@archiver.kernel.org>; Tue,  2 Apr 2019 04:28:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2629206B8
	for <bpf@archiver.kernel.org>; Tue,  2 Apr 2019 04:28:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554179280;
	bh=6OxfhUdzNbFq/NNCDxt9PIvjUX4E8NSzavuvun4zzUo=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-ID:From;
	b=eV7ZhqCb/oDiHfTMn+gIjNKRYxCcDI/i8xnTOKoOi2ds0DCourD/iFKJLQinf/rrG
	 IFwZ4TbutOZT2ZXgAZcfyOzPIDKBeHg7GAzJb7JumTODmTe4UwIvazxGFL7EJz3SbK
	 uBdZW456DfduYQreI9Weqw2cPItxA2rWKr23ji64=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727447AbfDBE17 convert rfc822-to-8bit (ORCPT
        <rfc822;bpf@archiver.kernel.org>); Tue, 2 Apr 2019 00:27:59 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:40032 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728655AbfDBE16 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 2 Apr 2019 00:27:58 -0400
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.27/8.16.0.27) with SMTP id x324R4QV020328
        for <bpf@vger.kernel.org>; Mon, 1 Apr 2019 21:27:57 -0700
Received: from maileast.thefacebook.com ([199.201.65.23])
        by m0001303.ppops.net with ESMTP id 2rkug60v3j-6
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 01 Apr 2019 21:27:57 -0700
Received: from mx-out.facebook.com (2620:10d:c0a1:3::13) by
 mail.thefacebook.com (2620:10d:c021:18::176) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1713.5;
 Mon, 1 Apr 2019 21:27:56 -0700
Received: by devbig007.ftw2.facebook.com (Postfix, from userid 572438)
        id AD004760E11; Mon,  1 Apr 2019 21:27:55 -0700 (PDT)
Smtp-Origin-Hostprefix: devbig
From:   Alexei Starovoitov <ast@kernel.org>
Smtp-Origin-Hostname: devbig007.ftw2.facebook.com
To:     <davem@davemloft.net>
CC:     <daniel@iogearbox.net>, <jakub.kicinski@netronome.com>,
        <jannh@google.com>, <netdev@vger.kernel.org>,
        <bpf@vger.kernel.org>, <kernel-team@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH v2 bpf-next 03/10] bpf: improve verification speed by not remarking live_read
Date:   Mon, 1 Apr 2019 21:27:42 -0700
Message-ID: <20190402042749.3670015-4-ast@kernel.org>
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

With large verifier speed improvement brought by the previous patch
mark_reg_read() becomes the hottest function during verification.
On a typical program it consumes 40% of cpu.
mark_reg_read() walks parentage chain of registers to mark parents as LIVE_READ.
Once the register is marked there is no need to remark it again in the future.
Hence stop walking the chain once first LIVE_READ is seen.
This optimization drops mark_reg_read() time from 40% of cpu to <1%
and overall 2x improvement of verification speed.
For some programs the longest_mark_read_walk counter improves from ~500 to ~5

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Reviewed-by: Jakub Kicinski <jakub.kicinski@netronome.com>
Reviewed-by: Edward Cree <ecree@solarflare.com>
---
 kernel/bpf/verifier.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index a636db4a7a4e..94cf6efc5df6 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -1151,6 +1151,15 @@ static int mark_reg_read(struct bpf_verifier_env *env,
 				parent->var_off.value, parent->off);
 			return -EFAULT;
 		}
+		if (parent->live & REG_LIVE_READ)
+			/* The parentage chain never changes and
+			 * this parent was already marked as LIVE_READ.
+			 * There is no need to keep walking the chain again and
+			 * keep re-marking all parents as LIVE_READ.
+			 * This case happens when the same register is read
+			 * multiple times without writes into it in-between.
+			 */
+			break;
 		/* ... then we depend on parent's value */
 		parent->live |= REG_LIVE_READ;
 		state = parent;
-- 
2.20.0

