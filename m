Return-Path: <SRS0=hCIb=TV=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC8B3C18E7C
	for <bpf@archiver.kernel.org>; Tue, 21 May 2019 23:09:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 983112184B
	for <bpf@archiver.kernel.org>; Tue, 21 May 2019 23:09:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558480185;
	bh=zCgeQi+Bw/cLD/xVeAmXvNO9VK4RusyR8PvHvLDg7vg=;
	h=From:To:CC:Subject:Date:List-ID:From;
	b=MCquSoPpU9GqYrYd8BLzmZrYiqZnZN0Suv2nTk2dpG1DOyZgq3zDhEZ7F6ooCxXDN
	 tYByi+M1FTxaR4MVJReboRkfiEViWuJ2Ncxa/HvbX/jXdjuIcXjmBs+MdIKmJ2H72j
	 tzi5/p38icPqRQad23L8jlL+ecMkcO+2j/In5XXc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726271AbfEUXJo convert rfc822-to-8bit (ORCPT
        <rfc822;bpf@archiver.kernel.org>); Tue, 21 May 2019 19:09:44 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:48872 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726434AbfEUXJo (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 21 May 2019 19:09:44 -0400
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4LN874R017707
        for <bpf@vger.kernel.org>; Tue, 21 May 2019 16:09:43 -0700
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2smdjru1p1-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 21 May 2019 16:09:43 -0700
Received: from mx-out.facebook.com (2620:10d:c081:10::13) by
 mail.thefacebook.com (2620:10d:c081:35::125) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1713.5;
 Tue, 21 May 2019 16:09:41 -0700
Received: by devbig007.ftw2.facebook.com (Postfix, from userid 572438)
        id B75E5760B85; Tue, 21 May 2019 16:09:39 -0700 (PDT)
Smtp-Origin-Hostprefix: devbig
From:   Alexei Starovoitov <ast@kernel.org>
Smtp-Origin-Hostname: devbig007.ftw2.facebook.com
To:     <davem@davemloft.net>
CC:     <daniel@iogearbox.net>, <netdev@vger.kernel.org>,
        <bpf@vger.kernel.org>, <kernel-team@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH bpf-next 0/3] bpf: increase jmp sequence limit
Date:   Tue, 21 May 2019 16:09:36 -0700
Message-ID: <20190521230939.2149151-1-ast@kernel.org>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-21_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=609 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905210144
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Patch 1 - jmp sequence limit
Patch 2 - improve existing tests
Patch 3 - add pyperf-based realistic bpf program that takes advantage
of higher limit and use it as a stress test

Alexei Starovoitov (3):
  bpf: bump jmp sequence limit
  selftests/bpf: adjust verifier scale test
  selftests/bpf: add pyperf scale test

 kernel/bpf/verifier.c                         |   7 +-
 .../bpf/prog_tests/bpf_verif_scale.c          |  31 +-
 tools/testing/selftests/bpf/progs/pyperf.h    | 268 ++++++++++++++++++
 tools/testing/selftests/bpf/progs/pyperf100.c |   4 +
 tools/testing/selftests/bpf/progs/pyperf180.c |   4 +
 tools/testing/selftests/bpf/progs/pyperf50.c  |   4 +
 tools/testing/selftests/bpf/test_verifier.c   |  31 +-
 7 files changed, 319 insertions(+), 30 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/pyperf.h
 create mode 100644 tools/testing/selftests/bpf/progs/pyperf100.c
 create mode 100644 tools/testing/selftests/bpf/progs/pyperf180.c
 create mode 100644 tools/testing/selftests/bpf/progs/pyperf50.c

-- 
2.20.0

