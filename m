Return-Path: <SRS0=He8s=BM=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20E53C433E1
	for <bpf@archiver.kernel.org>; Sun,  2 Aug 2020 04:21:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 006A12076B
	for <bpf@archiver.kernel.org>; Sun,  2 Aug 2020 04:21:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="fQveanxA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725882AbgHBEVf (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Sun, 2 Aug 2020 00:21:35 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:10974 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725798AbgHBEVf (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sun, 2 Aug 2020 00:21:35 -0400
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0724LXWQ022139
        for <bpf@vger.kernel.org>; Sat, 1 Aug 2020 21:21:34 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=+VwgnoEZnHcd7VOrmuSP8pCJgGsBj1iLnRcMu+39Beo=;
 b=fQveanxAncNMv3LuVhnBpFYcfIFeuSUZmeqfXQctSQmdwoMHB8ExvyQfeECVgJIW0X6d
 fD9wJhD51I/W0i+8d52KNwqImn3pSWkYZIs+Epf5SVDG4DJwUWTvInRXgXmzih4+hZVI
 kXuNC69QcKOdl3WOjKDpwITDz0w6L0HOHmk= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 32n81ja38y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Sat, 01 Aug 2020 21:21:34 -0700
Received: from intmgw002.03.ash8.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Sat, 1 Aug 2020 21:21:33 -0700
Received: by devbig003.ftw2.facebook.com (Postfix, from userid 128203)
        id 2C2603705190; Sat,  1 Aug 2020 21:21:26 -0700 (PDT)
Smtp-Origin-Hostprefix: devbig
From:   Yonghong Song <yhs@fb.com>
Smtp-Origin-Hostname: devbig003.ftw2.facebook.com
To:     <bpf@vger.kernel.org>, <netdev@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH bpf-next 0/2] bpf: change uapi for bpf iterator map elements
Date:   Sat, 1 Aug 2020 21:21:26 -0700
Message-ID: <20200802042126.2119783-1-yhs@fb.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-02_01:2020-07-31,2020-08-02 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 adultscore=0
 impostorscore=0 spamscore=0 suspectscore=8 lowpriorityscore=0 phishscore=0
 bulkscore=0 malwarescore=0 mlxscore=0 priorityscore=1501 mlxlogscore=663
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008020033
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Andrii raised a concern that current uapi for bpf iterator map
element is a little restrictive and not suitable for future potential
complex customization. This is a valid suggestion, considering people
may indeed add more complex custimization to the iterator, e.g.,
cgroup_id + user_id, etc. for task or task_file. Another example might
be map_id plus additional control so that the bpf iterator may bail
out a bucket earlier if a bucket has too many elements which may hold
lock too long and impact other parts of systems.

Patch #1 modified uapi with kernel changes. Patch #2
adjusted libbpf api accordingly.

Yonghong Song (2):
  bpf: change uapi for bpf iterator map elements
  libbpf: support new uapi for map element bpf iterator

 include/linux/bpf.h            | 10 ++++---
 include/uapi/linux/bpf.h       | 15 +++++-----
 kernel/bpf/bpf_iter.c          | 52 +++++++++++++++-------------------
 kernel/bpf/map_iter.c          | 37 ++++++++++++++++++------
 kernel/bpf/syscall.c           |  2 +-
 net/core/bpf_sk_storage.c      | 37 ++++++++++++++++++------
 tools/include/uapi/linux/bpf.h | 15 +++++-----
 tools/lib/bpf/bpf.c            |  4 ++-
 tools/lib/bpf/bpf.h            |  5 ++--
 tools/lib/bpf/libbpf.c         |  7 +++--
 10 files changed, 115 insertions(+), 69 deletions(-)

--=20
2.24.1

