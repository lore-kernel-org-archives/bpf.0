Return-Path: <SRS0=alw5=CD=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0119C433DF
	for <bpf@archiver.kernel.org>; Tue, 25 Aug 2020 06:46:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B51802076C
	for <bpf@archiver.kernel.org>; Tue, 25 Aug 2020 06:46:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="jEqi5DsP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729154AbgHYGqP (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 25 Aug 2020 02:46:15 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:46248 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729131AbgHYGqO (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 25 Aug 2020 02:46:14 -0400
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07P6UXLJ028996
        for <bpf@vger.kernel.org>; Mon, 24 Aug 2020 23:46:13 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=8IvJ8myDiS/W7/y3K44ky1vAdlqQRlcWWA+0jBzbJxM=;
 b=jEqi5DsPvwWM1qnY3w7qGNw64XQ4Om2ThJnzGDozxpaZjn1AgUvMMcxBfIVhRgOXSlGF
 puCwh8/lFuJZeHC4HYgt5LqpmFPeD6Zm9ag4y+Dv8jfsslLLrksagUESWaiKh1EgNohY
 WBbFG1dTrxAtf4fTJTIY45XpvV5I0VuS/u0= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 333juu16ck-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 24 Aug 2020 23:46:13 -0700
Received: from intmgw002.08.frc2.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Mon, 24 Aug 2020 23:46:12 -0700
Received: by devbig003.ftw2.facebook.com (Postfix, from userid 128203)
        id 26E2E370546C; Mon, 24 Aug 2020 23:46:08 -0700 (PDT)
Smtp-Origin-Hostprefix: devbig
From:   Yonghong Song <yhs@fb.com>
Smtp-Origin-Hostname: devbig003.ftw2.facebook.com
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH bpf-next 0/2] fix a verifier failure with xor
Date:   Mon, 24 Aug 2020 23:46:08 -0700
Message-ID: <20200825064608.2017878-1-yhs@fb.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-24_12:2020-08-24,2020-08-24 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 adultscore=0
 priorityscore=1501 spamscore=0 bulkscore=0 phishscore=0 mlxlogscore=488
 clxscore=1015 impostorscore=0 malwarescore=0 suspectscore=13
 lowpriorityscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2006250000 definitions=main-2008250049
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The bpf selftest test_progs/test_sk_assign failed with llvm11 and llvm12.
The reason is that the verifier did not handle xor operation and generate
very conservative register bound. Patch #1 tries to fix the verifier
issue and Patch #2 added additional tests in selftest test_verifier.

Yonghong Song (2):
  bpf: fix a verifier failure with xor
  selftests/bpf: add verifier tests for xor operation

 kernel/bpf/verifier.c                         |  66 ++++++++
 tools/testing/selftests/bpf/verifier/bounds.c | 146 ++++++++++++++++++
 2 files changed, 212 insertions(+)

--=20
2.24.1

