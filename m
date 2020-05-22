Return-Path: <SRS0=QYON=7E=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85078C433E0
	for <bpf@archiver.kernel.org>; Fri, 22 May 2020 02:23:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E4B92078B
	for <bpf@archiver.kernel.org>; Fri, 22 May 2020 02:23:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="JagpSwMn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727063AbgEVCXk (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 21 May 2020 22:23:40 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:50316 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727024AbgEVCXk (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 21 May 2020 22:23:40 -0400
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04M2LMsQ003724
        for <bpf@vger.kernel.org>; Thu, 21 May 2020 19:23:39 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=wrNTn2OkIgYH7F4VTgfk8wvs6/Asl3XeMbbeQ3RGdvg=;
 b=JagpSwMn9PeAyv24uIeAo7NbD50pH2YvTLBznlNXF40dCOetYpBpr3Y6pDTY0P0/7sJ1
 JDD+oPo/eQd7RU2Yds4ea/4A41QJa4HcM1HskWvcxxai84a83fxNv6G84a7v9HKV6gIt
 NOceMN69ngUxayOsneVoMs/AFi1hHMF8S58= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3152xu2nd0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 21 May 2020 19:23:39 -0700
Received: from intmgw001.03.ash8.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c085:11d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 21 May 2020 19:23:39 -0700
Received: by devbig005.ftw2.facebook.com (Postfix, from userid 6611)
        id A784B29455B1; Thu, 21 May 2020 19:23:36 -0700 (PDT)
Smtp-Origin-Hostprefix: devbig
From:   Martin KaFai Lau <kafai@fb.com>
Smtp-Origin-Hostname: devbig005.ftw2.facebook.com
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>,
        <netdev@vger.kernel.org>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH v2 bpf-next 0/3] bpf: Allow inner map with different max_entries
Date:   Thu, 21 May 2020 19:23:36 -0700
Message-ID: <20200522022336.899416-1-kafai@fb.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.676
 definitions=2020-05-21_16:2020-05-21,2020-05-21 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 suspectscore=13
 cotscore=-2147483648 priorityscore=1501 mlxscore=0 malwarescore=0
 adultscore=0 mlxlogscore=432 lowpriorityscore=0 phishscore=0 clxscore=1015
 bulkscore=0 spamscore=0 impostorscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005220017
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

People has a use case that starts with a smaller inner map first and then
replaces it with a larger inner map later when it is needed.

This series allows the outer map to be updated with inner map in differen=
t
size as long as it is safe (meaning the max_entries is not used in the
verification time during prog load).

Please see individual patch for details.

v2:
- New BPF_MAP_TYPE_FL to minimize code churns (Alexei)
- s/capabilities/properties/ (Andrii)
- Describe WHY in commit log (Andrii)

Martin KaFai Lau (3):
  bpf: Consolidate inner-map-compatible properties into bpf_types.h
  bpf: Relax the max_entries check for inner map
  bpf: selftests: Add test for different inner map size

 include/linux/bpf.h                           | 20 ++++++++++--
 include/linux/bpf_types.h                     | 25 +++++++++++----
 kernel/bpf/btf.c                              |  4 +--
 kernel/bpf/map_in_map.c                       | 12 +++----
 kernel/bpf/syscall.c                          | 25 +++++++++++----
 kernel/bpf/verifier.c                         |  4 +--
 .../selftests/bpf/prog_tests/btf_map_in_map.c | 12 +++++++
 .../selftests/bpf/progs/test_btf_map_in_map.c | 31 +++++++++++++++++++
 8 files changed, 107 insertions(+), 26 deletions(-)

--=20
2.24.1

