Return-Path: <SRS0=NbGg=EL=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FB31C00A89
	for <bpf@archiver.kernel.org>; Thu,  5 Nov 2020 04:51:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CDA132083B
	for <bpf@archiver.kernel.org>; Thu,  5 Nov 2020 04:51:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1604551911;
	bh=VkEvlf0Q+ZBzq/DfhYKOnqOcRHlM3EBi9TH3e1k1Ggg=;
	h=From:To:CC:Subject:Date:List-ID:From;
	b=tN6/BNkFXDq6IIog9MCXOyueuK1f4+Yvi2zozZLlJY6TKGadV2M8Zpwz/m4VeGOz0
	 IAMQlwXlQNet1P71+IvwDtSpcdgBTAdzxIv2Gc0D0+GN6os1H3WC1iWQmfMqffM6yo
	 pzncmvDTQJKy8ZiGW5mUAN6K+gGewLlOiBCia0tM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727986AbgKEEvv convert rfc822-to-8bit (ORCPT
        <rfc822;bpf@archiver.kernel.org>); Wed, 4 Nov 2020 23:51:51 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:61658 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728301AbgKEEvu (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 4 Nov 2020 23:51:50 -0500
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.42/8.16.0.42) with SMTP id 0A54nbBx025218
        for <bpf@vger.kernel.org>; Wed, 4 Nov 2020 20:51:49 -0800
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0089730.ppops.net with ESMTP id 34m5r116f8-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 04 Nov 2020 20:51:49 -0800
Received: from intmgw005.03.ash8.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:11d::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 4 Nov 2020 20:51:48 -0800
Received: by devbig012.ftw2.facebook.com (Postfix, from userid 137359)
        id B1D192EC8E08; Wed,  4 Nov 2020 20:51:46 -0800 (PST)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <netdev@vger.kernel.org>, <ast@fb.com>,
        <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [RFC PATCH bpf-next 0/5] Integrate kernel module BTF support
Date:   Wed, 4 Nov 2020 20:51:35 -0800
Message-ID: <20201105045140.2589346-1-andrii@kernel.org>
X-Mailer: git-send-email 2.24.1
X-FB-Internal: Safe
Content-Type: text/plain
Content-Transfer-Encoding: 8BIT
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-05_01:2020-11-05,2020-11-05 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 spamscore=0 adultscore=0
 priorityscore=1501 lowpriorityscore=0 mlxlogscore=999 bulkscore=0
 malwarescore=0 phishscore=0 mlxscore=0 clxscore=1015 impostorscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011050035
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This patch set adds BTF generation for kernel modules using a compact split BTF
approach. Respective patches have all the details.

New Kconfig CONFIG_DEBUG_INTO_BTF_MODULES is added, which is defaulted to y,
but is conditional on pahole v1.19 version, which is going to have a support
for --btf_base flag, providing ability to generate deduplicated split BTF.

This patch set implements in-kernel support for split BTF loading and
validation. It also extends GET_OBJ_INFO API for BTFs to return BTF's module
name and a flag whether BTF itself is in-kernel or user-provided. vmlinux BTF
is also exposed to user-space through the same BTF object iteration APIs.

Follow up patch set will utilize the fact that vmlinux and module BTFs now
have ID associated with them to provide ability to attach BPF fentry/fexit/etc
programs to functions defined in kernel modules.

bpftool is also extended to show module/vmlinux BTF's name.

This patch set is posted as an RFC because it depends on two not yet landed
set of patches:
  - libbpf split BTF support ([0]);
  - pahole's support for split BTF generation and deduplication ([1]).

  [0] https://patchwork.kernel.org/project/netdevbpf/list/?series=377859&state=*
  [1] https://lore.kernel.org/dwarves/20201105043936.2555804-1-andrii@kernel.org/T/#u

Cc: Arnaldo Carvalho de Melo <acme@redhat.com>

Andrii Nakryiko (5):
  bpf: add in-kernel split BTF support
  bpf: assign ID to vmlinux BTF and return extra info for BTF in
    GET_OBJ_INFO
  kbuild: Add CONFIG_DEBUG_INFO_BTF_MODULES option or module BTFs
  bpf: load and verify kernel module BTFs
  tools/bpftool: add support for in-kernel and named BTF in `btf show`

 include/linux/bpf.h            |   2 +
 include/linux/module.h         |   4 +
 include/uapi/linux/bpf.h       |   3 +
 kernel/bpf/btf.c               | 411 ++++++++++++++++++++++++++++-----
 kernel/bpf/sysfs_btf.c         |   2 +-
 kernel/module.c                |  32 +++
 lib/Kconfig.debug              |  10 +
 scripts/Makefile.modfinal      |  20 +-
 tools/bpf/bpftool/btf.c        |  30 ++-
 tools/include/uapi/linux/bpf.h |   3 +
 10 files changed, 460 insertions(+), 57 deletions(-)

-- 
2.24.1

