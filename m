Return-Path: <SRS0=aAlx=V4=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FFE7C32750
	for <bpf@archiver.kernel.org>; Wed, 31 Jul 2019 01:38:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D5892067D
	for <bpf@archiver.kernel.org>; Wed, 31 Jul 2019 01:38:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564537113;
	bh=xFcKgHdbL21g6Azc/avb/LGDtycoeec/jN/G2G4Co6Q=;
	h=From:To:CC:Subject:Date:List-ID:From;
	b=FHdpAJ5JNEIJTApts3bcRGDji+lX9ezwdo2VxDh/6l9euLek4FdgO7XxmctDE+aj7
	 PlAGJj6Fjx76AKf2UvoGShqg5+Idk4ia0sQsdaxHsefdBoJrg2sCdFaNAyma9oNRvZ
	 8wHjg13pckpSbehfbNrFYfQ4ZKNs2qtz7EVVvt/Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726136AbfGaBic convert rfc822-to-8bit (ORCPT
        <rfc822;bpf@archiver.kernel.org>); Tue, 30 Jul 2019 21:38:32 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:3632 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726508AbfGaBic (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 30 Jul 2019 21:38:32 -0400
Received: from pps.filterd (m0001255.ppops.net [127.0.0.1])
        by mx0b-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6V1WEtq000878
        for <bpf@vger.kernel.org>; Tue, 30 Jul 2019 18:38:31 -0700
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by mx0b-00082601.pphosted.com with ESMTP id 2u2uy0s36w-6
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 30 Jul 2019 18:38:31 -0700
Received: from mx-out.facebook.com (2620:10d:c081:10::13) by
 mail.thefacebook.com (2620:10d:c081:35::127) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1713.5;
 Tue, 30 Jul 2019 18:38:30 -0700
Received: by devbig007.ftw2.facebook.com (Postfix, from userid 572438)
        id B7640760C3C; Tue, 30 Jul 2019 18:38:27 -0700 (PDT)
Smtp-Origin-Hostprefix: devbig
From:   Alexei Starovoitov <ast@kernel.org>
Smtp-Origin-Hostname: devbig007.ftw2.facebook.com
To:     <davem@davemloft.net>
CC:     <daniel@iogearbox.net>, <netdev@vger.kernel.org>,
        <bpf@vger.kernel.org>, <kernel-team@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH bpf 0/2] bpf: fix bug in x64 JIT
Date:   Tue, 30 Jul 2019 18:38:25 -0700
Message-ID: <20190731013827.2445262-1-ast@kernel.org>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-31_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=416 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1907310013
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Fix bug in computation of the jump offset to 1st instruction in BPF JIT
and add 2 tests.

Alexei Starovoitov (2):
  bpf: fix x64 JIT code generation for jmp to 1st insn
  selftests/bpf: tests for jmp to 1st insn

 arch/x86/net/bpf_jit_comp.c                   |  7 +++--
 tools/testing/selftests/bpf/verifier/loops1.c | 28 +++++++++++++++++++
 2 files changed, 32 insertions(+), 3 deletions(-)

-- 
2.20.0

