Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58012C71155
	for <bpf@archiver.kernel.org>; Tue,  1 Dec 2020 00:04:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 043032086A
	for <bpf@archiver.kernel.org>; Tue,  1 Dec 2020 00:04:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="RFdk9rzx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730969AbgLAAE2 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 30 Nov 2020 19:04:28 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:19916 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730832AbgLAAE2 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 30 Nov 2020 19:04:28 -0500
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0B101o7x006920
        for <bpf@vger.kernel.org>; Mon, 30 Nov 2020 16:03:47 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=w5sEoSNi/hOic74AF7SaCo6Z2BfWFRfKgWDRCUfDgzU=;
 b=RFdk9rzxagSnHbPh9q9KIyZCG+KnxDfML/jy4Mp1bnDXEGiEyzW0r3UgEpxSY03Y+5yF
 nDJXsbm9NZtk9xQT3g37F2OyHGXqyNf1hOl90jyMKVxGjELW9mtuB3NYMr2+RCuZIRf3
 LOU34DKN3aTKQZIKoOqI6Iwlm1P9t44CoXU= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 354hsyep4c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 30 Nov 2020 16:03:45 -0800
Received: from intmgw004.08.frc2.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Mon, 30 Nov 2020 16:03:44 -0800
Received: by devvm3178.ftw3.facebook.com (Postfix, from userid 201728)
        id 121BC4752A005; Mon, 30 Nov 2020 16:03:39 -0800 (PST)
From:   Prankur gupta <prankgup@fb.com>
To:     <bpf@vger.kernel.org>
CC:     <kernel-team@fb.com>, <netdev@vger.kernel.org>
Subject: [PATCH bpf-next 0/2] Add support to set window_clamp from bpf setsockops
Date:   Mon, 30 Nov 2020 16:03:37 -0800
Message-ID: <20201201000339.3310760-1-prankgup@fb.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-30_12:2020-11-30,2020-11-30 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 clxscore=1015
 adultscore=0 priorityscore=1501 impostorscore=0 mlxscore=0 spamscore=0
 bulkscore=0 lowpriorityscore=0 suspectscore=13 mlxlogscore=962
 phishscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2011300150
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This patch contains support to set tcp window_field field from bpf setsoc=
kops.

Prankur gupta (2):
  bpf: Adds support for setting window clamp
  selftests/bpf: Add Userspace tests for TCP_WINDOW_CLAMP

 net/core/filter.c                             |  8 +++++
 tools/testing/selftests/bpf/bpf_tcp_helpers.h |  1 +
 .../selftests/bpf/prog_tests/tcpbpf_user.c    |  4 +++
 .../selftests/bpf/progs/test_tcpbpf_kern.c    | 33 +++++++++++++++++++
 tools/testing/selftests/bpf/test_tcpbpf.h     |  2 ++
 5 files changed, 48 insertions(+)

--=20
2.24.1

