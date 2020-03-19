Return-Path: <SRS0=cKI0=5E=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B9A7C4332B
	for <bpf@archiver.kernel.org>; Thu, 19 Mar 2020 23:50:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA38520753
	for <bpf@archiver.kernel.org>; Thu, 19 Mar 2020 23:50:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="YvzeVMG8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726663AbgCSXuA (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 19 Mar 2020 19:50:00 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:2686 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726827AbgCSXt7 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 19 Mar 2020 19:49:59 -0400
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02JNjHY8025255
        for <bpf@vger.kernel.org>; Thu, 19 Mar 2020 16:49:58 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=facebook;
 bh=c8biSNUc3qCdbHNV0/3rTooJ2yYM9OQBX8C2WXCyeuA=;
 b=YvzeVMG8B4KV94ZicBYEFNKg3P12PsUdcTJ55M8pE6UiZGB1JOCJNVBKpUBGTI6Yxuwg
 WJ+/MhpOg3SepXAoLTC3iJFEwMTHU57ec9TlxG2zS/HAMJd788/0y3WY0EPgBWIqxPaY
 k7tJoTIIrsPDjsHQxWcbsx06uF5vk7tEuxQ= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 2yvg258rnu-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 19 Mar 2020 16:49:58 -0700
Received: from intmgw002.08.frc2.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:11d::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1847.3; Thu, 19 Mar 2020 16:49:57 -0700
Received: by devbig005.ftw2.facebook.com (Postfix, from userid 6611)
        id D47492942DAE; Thu, 19 Mar 2020 16:49:55 -0700 (PDT)
Smtp-Origin-Hostprefix: devbig
From:   Martin KaFai Lau <kafai@fb.com>
Smtp-Origin-Hostname: devbig005.ftw2.facebook.com
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>,
        <netdev@vger.kernel.org>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH bpf-next 0/2] bpf: Add bpf_sk_storage support to bpf_tcp_ca
Date:   Thu, 19 Mar 2020 16:49:55 -0700
Message-ID: <20200319234955.2933540-1-kafai@fb.com>
X-Mailer: git-send-email 2.17.1
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.645
 definitions=2020-03-19_10:2020-03-19,2020-03-19 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxlogscore=754
 impostorscore=0 suspectscore=13 adultscore=0 malwarescore=0 clxscore=1015
 spamscore=0 phishscore=0 mlxscore=0 priorityscore=1501 bulkscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003190095
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This set adds bpf_sk_storage support to bpf_tcp_ca.
That will allow bpf-tcp-cc to share sk's private data with other
bpf_progs and also allow bpf-tcp-cc to use extra private
storage if the existing icsk_ca_priv is not enough.

Martin KaFai Lau (2):
  bpf: Add bpf_sk_storage support to bpf_tcp_ca
  bpf: Add tests for bpf_sk_storage to bpf_tcp_ca

 net/ipv4/bpf_tcp_ca.c                         | 33 +++++++++++++++++++
 .../selftests/bpf/prog_tests/bpf_tcp_ca.c     | 28 ++++++++++++++--
 tools/testing/selftests/bpf/progs/bpf_dctcp.c | 16 +++++++++
 3 files changed, 74 insertions(+), 3 deletions(-)

-- 
2.17.1

