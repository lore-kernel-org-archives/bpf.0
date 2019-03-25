Return-Path: <SRS0=sqwL=R4=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEA86C43381
	for <bpf@archiver.kernel.org>; Mon, 25 Mar 2019 02:57:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99E9220830
	for <bpf@archiver.kernel.org>; Mon, 25 Mar 2019 02:57:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553482678;
	bh=TwTQrKsDxGbduqObvhKdoV+gOZs1scK40gvR6WFbpH4=;
	h=From:To:CC:Subject:Date:List-ID:From;
	b=rRQiNJdCv76A5vuS+Fd4JeJEQ4lyJBgpvTwaq7W+byzo2A3hWMgaCcoSZxQJeCAZg
	 MAN27oPCiTqlNlW3S5pJf/eqXZMeJQXqemMaZxDq0DHa3lcIW2Z691JX/EhCpulEIU
	 wJA0pS8S3V7ltpEwmw8aGOW/Kd2LfO74xPh7dKdw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729298AbfCYC56 convert rfc822-to-8bit (ORCPT
        <rfc822;bpf@archiver.kernel.org>); Sun, 24 Mar 2019 22:57:58 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:43064 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729261AbfCYC56 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sun, 24 Mar 2019 22:57:58 -0400
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2P2qNa6024910
        for <bpf@vger.kernel.org>; Sun, 24 Mar 2019 19:57:56 -0700
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2regbds14w-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Sun, 24 Mar 2019 19:57:56 -0700
Received: from mx-out.facebook.com (2620:10d:c081:10::13) by
 mail.thefacebook.com (2620:10d:c081:35::127) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1713.5;
 Sun, 24 Mar 2019 19:57:56 -0700
Received: by devbig007.ftw2.facebook.com (Postfix, from userid 572438)
        id B6753760CA5; Sun, 24 Mar 2019 19:57:55 -0700 (PDT)
Smtp-Origin-Hostprefix: devbig
From:   Alexei Starovoitov <ast@kernel.org>
Smtp-Origin-Hostname: devbig007.ftw2.facebook.com
To:     <davem@davemloft.net>
CC:     <daniel@iogearbox.net>, <netdev@vger.kernel.org>,
        <bpf@vger.kernel.org>, <kernel-team@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: pull-request: bpf 2019-03-24
Date:   Sun, 24 Mar 2019 19:57:55 -0700
Message-ID: <20190325025755.1757841-1-ast@kernel.org>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-25_01:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi David,

The following pull-request contains BPF updates for your *net* tree.

The main changes are:

1) libbpf verision fix up from Daniel.

2) fix liveness propagation from Jakub.

3) fix verbose print of refcounted regs from Martin.

4) fix for large map allocations from Martynas.

5) fix use after free in sanitize_ptr_alu from Xu.

Please consider pulling these changes from:

  git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git

Thanks a lot!

----------------------------------------------------------------

The following changes since commit ea239314fe42ace880bdd834256834679346c80e:

  tipc: allow service ranges to be connect()'ed on RDM/DGRAM (2019-03-17 21:32:11 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git 

for you to fetch changes up to a7d6ac3761d34bfd4294d7843714c91c600738cf:

  Merge branch 'libbpf-fixup' (2019-03-24 19:49:05 -0700)

----------------------------------------------------------------
Alexei Starovoitov (1):
      Merge branch 'libbpf-fixup'

Daniel Borkmann (2):
      bpf, libbpf: fix version info and add it to shared object
      bpf, libbpf: clarify bump in libbpf version info

Jakub Kicinski (1):
      bpf: verifier: propagate liveness on all frames

Martin KaFai Lau (1):
      bpf: Only print ref_obj_id for refcounted reg

Martynas Pumputis (1):
      bpf: Try harder when allocating memory for large maps

Xu Yu (1):
      bpf: do not restore dst_reg when cur_state is freed

 kernel/bpf/syscall.c                         | 22 ++++++++++-----
 kernel/bpf/verifier.c                        | 35 +++++++++++++++--------
 tools/lib/bpf/Makefile                       | 42 ++++++++++++++++++----------
 tools/lib/bpf/README.rst                     |  1 +
 tools/testing/selftests/bpf/verifier/calls.c | 25 +++++++++++++++++
 5 files changed, 92 insertions(+), 33 deletions(-)
