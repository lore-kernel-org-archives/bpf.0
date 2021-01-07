Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E171C433E6
	for <bpf@archiver.kernel.org>; Thu,  7 Jan 2021 04:21:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 210E623101
	for <bpf@archiver.kernel.org>; Thu,  7 Jan 2021 04:21:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726731AbhAGEVW (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 6 Jan 2021 23:21:22 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:38918 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725803AbhAGEVW (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 6 Jan 2021 23:21:22 -0500
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.43/8.16.0.43) with SMTP id 1074DlZE017503
        for <bpf@vger.kernel.org>; Wed, 6 Jan 2021 20:20:41 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=Ab9J2wMYMy/0mqayQ1lc5G3wJt9DAVtxCQNRrMnYl50=;
 b=EbajjjB+daidRJkMohqoaAtR7hbcASYsPQ2P06MhtwutE6vdQyoVxZMDOf8fMeEX/lbi
 mQiwLIH8WlKfCP3IDXgWcpQtEiniGHQoaZsB6R4QGo6l7G15Hj113YoGkSxt5TIxF8jW
 T4Wib7NLT4z/hbEhki0abaxR1h7JgWbVdMo= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0089730.ppops.net with ESMTP id 35wpuxryk3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 06 Jan 2021 20:20:41 -0800
Received: from intmgw003.08.frc2.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c085:11d::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 6 Jan 2021 20:20:40 -0800
Received: by devbig006.ftw2.facebook.com (Postfix, from userid 4523)
        id 9565D62E0579; Wed,  6 Jan 2021 20:18:11 -0800 (PST)
From:   Song Liu <songliubraving@fb.com>
To:     <bpf@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-mm@kvack.org>
CC:     <ast@kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>,
        <john.fastabend@gmail.com>, <kpsingh@chromium.org>,
        <kernel-team@fb.com>, <akpm@linux-foundation.org>,
        Song Liu <songliubraving@fb.com>
Subject: [PATCH v3 bpf-next 0/4] introduce bpf_iter for task_vma
Date:   Wed, 6 Jan 2021 20:17:57 -0800
Message-ID: <20210107041801.2003241-1-songliubraving@fb.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-07_02:2021-01-06,2021-01-07 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 malwarescore=0
 priorityscore=1501 clxscore=1015 mlxlogscore=959 adultscore=0 spamscore=0
 impostorscore=0 suspectscore=0 phishscore=0 lowpriorityscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101070023
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This set introduces bpf_iter for task_vma, which can be used to generate
information similar to /proc/pid/maps. Patch 4/4 adds an example that
mimics /proc/pid/maps.

Current /proc/<pid>/maps and /proc/<pid>/smaps provide information of
vma's of a process. However, these information are not flexible enough to
cover all use cases. For example, if a vma cover mixed 2MB pages and 4kB
pages (x86_64), there is no easy way to tell which address ranges are
backed by 2MB pages. task_vma solves the problem by enabling the user to
generate customize information based on the vma (and vma->vm_mm,
vma->vm_file, etc.).

Changes v2 =3D> v3:
  1. Rewrite 1/4 so that we hold mmap_lock while calling BPF program. Thi=
s
     enables the BPF program to access the real vma with BTF. (Alexei)
  2. Fix the logic when the control is returned to user space. (Yonghong)
  3. Revise commit log and cover letter. (Yonghong)

Changes v1 =3D> v2:
  1. Small fixes in task_iter.c and the selftests. (Yonghong)

Song Liu (4):
  bpf: introduce task_vma bpf_iter
  bpf: allow bpf_d_path in sleepable bpf_iter program
  libbpf: introduce section "iter.s/" for sleepable bpf_iter program
  selftests/bpf: add test for bpf_iter_task_vma

 kernel/bpf/task_iter.c                        | 212 +++++++++++++++++-
 kernel/trace/bpf_trace.c                      |   5 +
 tools/lib/bpf/libbpf.c                        |   5 +
 .../selftests/bpf/prog_tests/bpf_iter.c       | 114 +++++++++-
 tools/testing/selftests/bpf/progs/bpf_iter.h  |   8 +
 .../selftests/bpf/progs/bpf_iter_task_vma.c   |  58 +++++
 6 files changed, 391 insertions(+), 11 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/bpf_iter_task_vma.c

--
2.24.1
