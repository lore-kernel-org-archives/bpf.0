Return-Path: <SRS0=dL5Z=63=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DB1DC2D0F8
	for <bpf@archiver.kernel.org>; Wed, 13 May 2020 00:03:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF37F20769
	for <bpf@archiver.kernel.org>; Wed, 13 May 2020 00:03:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="RRIcdNtY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731660AbgEMAD4 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 12 May 2020 20:03:56 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:54628 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726031AbgEMAD4 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 12 May 2020 20:03:56 -0400
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04CNx0Hi003126
        for <bpf@vger.kernel.org>; Tue, 12 May 2020 17:03:55 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=1Dy/w0LZ09e4o5GXTIrVCcurRl/hC/lPBPvloGzOB6g=;
 b=RRIcdNtYIhoG7UJ8UOxQ4OSuFCqF6X3Zp5WVra9LBOfYIj0oj335TiEv3kArvy+/XxBo
 KWGcsMWpIb2UU1yLIX5BoS1D8nn0K7BvD1sHFPAPeYQ7a/pNKuDRzZUY5I/JDr4qdxGs
 lfdG7TtjFNiElYbLHLpe5agd08ANp+UHzUI= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3100x21pb6-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 12 May 2020 17:03:55 -0700
Received: from intmgw001.06.prn3.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:21d::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1847.3; Tue, 12 May 2020 17:03:53 -0700
Received: by dev082.prn2.facebook.com (Postfix, from userid 572249)
        id 55721370093A; Tue, 12 May 2020 17:03:51 -0700 (PDT)
Smtp-Origin-Hostprefix: dev
From:   Andrey Ignatov <rdna@fb.com>
Smtp-Origin-Hostname: dev082.prn2.facebook.com
To:     <bpf@vger.kernel.org>
CC:     Andrey Ignatov <rdna@fb.com>, <ast@kernel.org>,
        <daniel@iogearbox.net>, <kernel-team@fb.com>
Smtp-Origin-Cluster: prn2c23
Subject: [PATCH bpf-next 0/5] bpf: sk lookup, cgroup id helpers in cgroup skb
Date:   Tue, 12 May 2020 17:03:10 -0700
Message-ID: <cover.1589327873.git.rdna@fb.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.676
 definitions=2020-05-12_08:2020-05-11,2020-05-12 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 adultscore=0 spamscore=0
 clxscore=1015 priorityscore=1501 suspectscore=13 phishscore=0
 malwarescore=0 mlxscore=0 bulkscore=0 mlxlogscore=876 cotscore=-2147483648
 lowpriorityscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2005120180
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This patch set allows a bunch of existing sk lookup and skb cgroup id
helpers, and adds two new bpf_sk_{,ancestor_}cgroup_id helpers to be used
in cgroup skb programs.

It fills the gap to cover a use-case to apply intra-host cgroup-bpf netwo=
rk
policy based on a source cgroup a packet comes from.

For example, there can be multiple containers A, B, C running on a host.
Every such container runs in its own cgroup that can have multiple
sub-cgroups. But all these containers can share some IP addresses.

At the same time container A wants to have a policy for a server S runnin=
g
in it so that only clients from this same container can connect to S, but
not from other containers (such as B, C). Source IP address can't be used
to decide whether to allow or deny a packet, but it looks reasonable to
filter by cgroup id.

The patch set allows to implement the following policy:
* when an ingress packet comes to container's cgroup, lookup peer (client=
)
  socket this packet comes from;
* having peer socket, get its cgroup id;
* compare peer cgroup id with self cgroup id and allow packet only if the=
y
  match, i.e. it comes from same cgroup;
* the "sub-cgroup" part of the story can be addressed by getting not dire=
ct
  cgroup id of the peer socket, but ancestor cgroup id on specified level=
,
  similar to existing "ancestor" flavors of cgroup id helpers.

A newly introduced selftest implements such a policy in its basic form to
provide a better idea on the use-case.

Patch 1 allows existing sk lookup helpers in cgroup skb.
Patch 2 allows skb_ancestor_cgroup_id in cgrou skb.
Patch 3 introduces two new helpers to get cgroup id of socket.
Patch 4 extends network helpers to use them in the next patch.
Patch 5 adds selftest / example of use-case.


Andrey Ignatov (5):
  bpf: Allow sk lookup helpers in cgroup skb
  bpf: Allow skb_ancestor_cgroup_id helper in cgroup skb
  bpf: Introduce bpf_sk_{,ancestor_}cgroup_id helpers
  selftests/bpf: Add connect_fd_to_fd, connect_wait net helpers
  selftests/bpf: Test for sk helpers in cgroup skb

 include/uapi/linux/bpf.h                      |  35 ++++-
 net/core/filter.c                             |  70 ++++++++--
 tools/include/uapi/linux/bpf.h                |  35 ++++-
 tools/testing/selftests/bpf/network_helpers.c |  66 ++++++++--
 tools/testing/selftests/bpf/network_helpers.h |   2 +
 .../bpf/prog_tests/cgroup_skb_sk_lookup.c     | 121 ++++++++++++++++++
 .../bpf/progs/cgroup_skb_sk_lookup_kern.c     | 105 +++++++++++++++
 7 files changed, 411 insertions(+), 23 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/cgroup_skb_sk_=
lookup.c
 create mode 100644 tools/testing/selftests/bpf/progs/cgroup_skb_sk_looku=
p_kern.c

--=20
2.24.1

