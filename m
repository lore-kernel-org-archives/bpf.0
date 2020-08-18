Return-Path: <SRS0=j30r=B4=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E1B3C433DF
	for <bpf@archiver.kernel.org>; Tue, 18 Aug 2020 22:23:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E2B4E20738
	for <bpf@archiver.kernel.org>; Tue, 18 Aug 2020 22:23:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="l1a2le90"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726863AbgHRWXS (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 18 Aug 2020 18:23:18 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:45262 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726810AbgHRWXO (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 18 Aug 2020 18:23:14 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07IMG8IX018226
        for <bpf@vger.kernel.org>; Tue, 18 Aug 2020 15:23:14 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=9c3ZuDwr2uOpTm5OWCQEezdAmZ5DrDsJbhRbj1zx6Fk=;
 b=l1a2le90xC/nQ0FXLfoLJcItpSIZDp5BH89uO2fEwrc8sE9FkUDHs+MjubNz0k3LA8My
 1NqFlHfAG1uZKcjHjCfXX3pdpRkFXiSJ85Kd/qljV1tMHocAGyE3bniZiyGNBhGgInok
 ezP6ycPnohbqA3lY2p1jt1ZfuRGPwW+HBKw= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3304prne5s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 18 Aug 2020 15:23:14 -0700
Received: from intmgw005.03.ash8.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:11d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 18 Aug 2020 15:23:13 -0700
Received: by devbig003.ftw2.facebook.com (Postfix, from userid 128203)
        id 7B9ED37050C9; Tue, 18 Aug 2020 15:23:09 -0700 (PDT)
Smtp-Origin-Hostprefix: devbig
From:   Yonghong Song <yhs@fb.com>
Smtp-Origin-Hostname: devbig003.ftw2.facebook.com
To:     <bpf@vger.kernel.org>, <netdev@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH bpf v2 0/3] bpf: two fixes for bpf iterators
Date:   Tue, 18 Aug 2020 15:23:09 -0700
Message-ID: <20200818222309.2181236-1-yhs@fb.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-18_16:2020-08-18,2020-08-18 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0 malwarescore=0
 bulkscore=0 priorityscore=1501 adultscore=0 spamscore=0 impostorscore=0
 suspectscore=8 clxscore=1015 mlxlogscore=499 phishscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008180160
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Patch #1 fixed a rcu stall warning when traversing large number
of tasks/files without overflowing seq_file buffer. The method
is to control the number of visited objects in bpf_seq_read()
so all bpf iterators will benefit.

Patch #2 calculated tid properly in a namespace in order to avoid
visiting the name task multiple times.

Patch #3 handled read() error code EAGAIN properly in bpftool
bpf_iter userspace code to collect pids. The change is needed
due to Patch #1.

Yonghong Song (3):
  bpf: fix a rcu_sched stall issue with bpf task/task_file iterator
  bpf: avoid visit same object multiple times
  bpftool: handle EAGAIN error code properly in pids collection

 kernel/bpf/bpf_iter.c    | 15 ++++++++++++++-
 kernel/bpf/task_iter.c   |  3 ++-
 tools/bpf/bpftool/pids.c |  2 ++
 3 files changed, 18 insertions(+), 2 deletions(-)

--=20
2.24.1

