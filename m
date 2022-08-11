Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03822C00140
	for <bpf@archiver.kernel.org>; Thu, 11 Aug 2022 00:17:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233356AbiHKAR0 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 10 Aug 2022 20:17:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233152AbiHKARZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 10 Aug 2022 20:17:25 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 239B186C25
        for <bpf@vger.kernel.org>; Wed, 10 Aug 2022 17:17:24 -0700 (PDT)
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27AGuRsA003159
        for <bpf@vger.kernel.org>; Wed, 10 Aug 2022 17:17:24 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=facebook; bh=ZPeIHR5s8FStqzUPjcpW9mxU1B1TVsgFBS1wMmo+J0I=;
 b=Ck7BM3ArdiBe2kER/J/M9oIChD2/zr702nHHsy7qJvRmYkK9JhRJYMhh2ISoqTUbCCaD
 TE4Wv41D5Hbt4jLiqOvPW1/2s1sKM0HXVfMeanrSQTins2KRgrx3ZqaQ131kM4HlxNy5
 2W7dDLnJHNUJb7ZqTmEZQxpQWmU/jQSOvR0= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3hvdb6d82f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 10 Aug 2022 17:17:24 -0700
Received: from twshared7570.37.frc1.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c085:11d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Wed, 10 Aug 2022 17:17:22 -0700
Received: by devbig931.frc1.facebook.com (Postfix, from userid 460691)
        id 1CF49683D651; Wed, 10 Aug 2022 17:17:19 -0700 (PDT)
From:   Kui-Feng Lee <kuifeng@fb.com>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <andrii@kernel.org>, <kernel-team@fb.com>, <yhs@fb.com>
CC:     Kui-Feng Lee <kuifeng@fb.com>
Subject: [PATCH bpf-next v5 0/3] Parameterize task iterators.
Date:   Wed, 10 Aug 2022 17:16:51 -0700
Message-ID: <20220811001654.1316689-1-kuifeng@fb.com>
X-Mailer: git-send-email 2.30.2
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: mMLiKoRGZKSuYU0UqbgAqbpzKttK5_tT
X-Proofpoint-GUID: mMLiKoRGZKSuYU0UqbgAqbpzKttK5_tT
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-10_16,2022-08-10_01,2022-06-22_01
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Allow creating an iterator that loops through resources of one task/thread.

People could only create iterators to loop through all resources of
files, vma, and tasks in the system, even though they were interested in on=
ly the
resources of a specific task or process.  Passing the addintional
parameters, people can now create an iterator to go through all
resources or only the resources of a task.

Major Changes:

 - Add new parameters in bpf_iter_link_info to indicate to go through
   all tasks or to go through a specific task.

 - Change the implementations of BPF iterators of vma, files, and
   tasks to allow going through only the resources of a specific task.

 - Provide the arguments of parameterized task iterators in
   bpf_link_info.

Differences from v4:

 - Remove 'type' from bpf_iter_link_info and bpf_link_info.

v4: https://lore.kernel.org/bpf/20220809195429.1043220-1-kuifeng@fb.com/
v3: https://lore.kernel.org/bpf/20220809063501.667610-1-kuifeng@fb.com/
v2: https://lore.kernel.org/bpf/20220801232649.2306614-1-kuifeng@fb.com/
v1: https://lore.kernel.org/bpf/20220726051713.840431-1-kuifeng@fb.com/

Kui-Feng Lee (3):
  bpf: Parameterize task iterators.
  bpf: Handle bpf_link_info for the parameterized task BPF iterators.
  selftests/bpf: Test parameterized task BPF iterators.

 include/linux/bpf.h                           |  29 +++
 include/uapi/linux/bpf.h                      |  12 ++
 kernel/bpf/task_iter.c                        | 144 ++++++++++---
 tools/include/uapi/linux/bpf.h                |  12 ++
 .../selftests/bpf/prog_tests/bpf_iter.c       | 204 ++++++++++++++++--
 .../selftests/bpf/prog_tests/btf_dump.c       |   2 +-
 .../selftests/bpf/progs/bpf_iter_task.c       |   9 +
 .../selftests/bpf/progs/bpf_iter_task_file.c  |   7 +
 .../selftests/bpf/progs/bpf_iter_task_vma.c   |   6 +-
 9 files changed, 376 insertions(+), 49 deletions(-)

--=20
2.30.2

