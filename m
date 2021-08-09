Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D1B3C4338F
	for <bpf@archiver.kernel.org>; Mon,  9 Aug 2021 23:51:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6944960FE3
	for <bpf@archiver.kernel.org>; Mon,  9 Aug 2021 23:51:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236222AbhHIXwF (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 9 Aug 2021 19:52:05 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:62190 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231127AbhHIXwF (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 9 Aug 2021 19:52:05 -0400
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 179Nj8uQ001903
        for <bpf@vger.kernel.org>; Mon, 9 Aug 2021 16:51:44 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=facebook; bh=Am9GUSatF/8VImIYK70oMCJKUgwCIZDd6DHex3eONoo=;
 b=bIUOagKcjqvxQ6fU8NTlWO5iyB+zNKezkUNXqwIPLpe4cc03kRAeeigpYz0QOBsj+XXe
 bKveKnIMRrjxnzCi5L0YwCJQphd099gvPAtC3rWN/u+RuuW62nC+hp7jSxcHmRrasRuo
 P2uY35NiFcnIgDTU0cC2XycKC8IomvXTT3s= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3ab7pp2jf3-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 09 Aug 2021 16:51:44 -0700
Received: from intmgw006.03.ash8.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 9 Aug 2021 16:51:41 -0700
Received: by devbig003.ftw2.facebook.com (Postfix, from userid 128203)
        id 5EC3C5D47B02; Mon,  9 Aug 2021 16:51:41 -0700 (PDT)
From:   Yonghong Song <yhs@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>
Subject: [PATCH bpf v3 0/2] bpf: fix a couple of issues with syscall program
Date:   Mon, 9 Aug 2021 16:51:41 -0700
Message-ID: <20210809235141.1663247-1-yhs@fb.com>
X-Mailer: git-send-email 2.30.2
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-ORIG-GUID: 0RdM6FPTzC_wLD8Y5umGI5jmK3Mskdh6
X-Proofpoint-GUID: 0RdM6FPTzC_wLD8Y5umGI5jmK3Mskdh6
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-09_09:2021-08-06,2021-08-09 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 suspectscore=0
 spamscore=0 lowpriorityscore=0 priorityscore=1501 mlxscore=0 adultscore=0
 bulkscore=0 impostorscore=0 malwarescore=0 phishscore=0 clxscore=1015
 mlxlogscore=555 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108090167
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

syzbot ([1]) reported a rcu warning for syscall program when
bpf_get_current_cgroup_id() is called in the program. The
bpf_get_current_cgroup_id() helper expects cgroup related
mutex or rcu_read_lock(). The sleepable program cannot be
protected with rcu read_lock, hence the warning.

To fix the problem, Patch 1 added rcu_read_lock() in
affected helpers, and Patch 2 added missing
bpf_read_lock_trace() for syscall type of bpf programs.

 [1] https://lore.kernel.org/bpf/0000000000006d5cab05c7d9bb87@google.com/

Changelog:
  v2 -> v3:
    - use rcu_read_lock() protection for
      bpf_get_current_[ancestor_]cgroup_id() helper.
  v1 -> v2:
    - use bpf_read_lock_trace() instead of bpf_read_lock() for
      bpf_prog_run_pin_on_cpu().
    - disallow bpf_get_current_[ancestor_]cgroup_id() helper.

Yonghong Song (2):
  bpf: add rcu read_lock in bpf_get_current_[ancestor_]cgroup_id()
    helpers
  bpf: add missing bpf_read_[un]lock_trace() for syscall program

 kernel/bpf/helpers.c | 12 ++++++++++--
 net/bpf/test_run.c   |  4 ++++
 2 files changed, 14 insertions(+), 2 deletions(-)

--=20
2.30.2

