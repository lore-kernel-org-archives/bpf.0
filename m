Return-Path: <SRS0=He8s=BM=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D42A4C433E0
	for <bpf@archiver.kernel.org>; Sun,  2 Aug 2020 01:33:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A8EA720789
	for <bpf@archiver.kernel.org>; Sun,  2 Aug 2020 01:33:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="MAVeXzu0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727058AbgHBBdJ (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Sat, 1 Aug 2020 21:33:09 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:7332 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727794AbgHBBdI (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sat, 1 Aug 2020 21:33:08 -0400
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0721X80h000643
        for <bpf@vger.kernel.org>; Sat, 1 Aug 2020 18:33:08 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=WAggz1fU5MIx6n6t+uOJUiZQ+L8/i+pibaoJqrV74Y8=;
 b=MAVeXzu0S/V+MlfpN7K9NC907y6zf41+hvEYgttiZ0c2tt8JFX8n2XdO1U768N14sbAB
 tpW6O8fifDEVcy0W/5uEtFl0b7xPLl6Oum9X9CIKONVrf9oEUmb5C3FlWdEIlpY23GCG
 KC9mbQ0E1hydnfBE3fQV79Y2BXswbbwAD78= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 32n7u5st1f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Sat, 01 Aug 2020 18:33:08 -0700
Received: from intmgw003.08.frc2.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Sat, 1 Aug 2020 18:32:28 -0700
Received: by devbig012.ftw2.facebook.com (Postfix, from userid 137359)
        id CC6B72EC50C3; Sat,  1 Aug 2020 18:32:20 -0700 (PDT)
Smtp-Origin-Hostprefix: devbig
From:   Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Hostname: devbig012.ftw2.facebook.com
To:     <bpf@vger.kernel.org>, <netdev@vger.kernel.org>, <ast@fb.com>,
        <daniel@iogearbox.net>
CC:     <andrii.nakryiko@gmail.com>, <kernel-team@fb.com>,
        Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH bpf-next 0/3] Add generic and raw BTF parsing APIs to libbpf
Date:   Sat, 1 Aug 2020 18:32:16 -0700
Message-ID: <20200802013219.864880-1-andriin@fb.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-02_01:2020-07-31,2020-08-02 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 spamscore=0 clxscore=1015
 impostorscore=0 phishscore=0 mlxscore=0 adultscore=0 priorityscore=1501
 bulkscore=0 suspectscore=8 mlxlogscore=806 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008020010
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

It's pretty common for applications to want to parse raw (binary) BTF dat=
a
from file, as opposed to parsing it from ELF sections. It's also pretty c=
ommon
for tools to not care whether given file is ELF or raw BTF format. This p=
atch
series exposes internal raw BTF parsing API and adds generic variant of B=
TF
parsing, which will efficiently determine the format of a given fail and =
will
parse BTF appropriately.

Patches #2 and #3 removes re-implementations of such APIs from bpftool an=
d
resolve_btfids tools.

Andrii Nakryiko (3):
  libbpf: add btf__parse_raw() and generic btf__parse() APIs
  tools/bpftool: use libbpf's btf__parse() API for parsing BTF from file
  tools/resolve_btfids: use libbpf's btf__parse() API

 tools/bpf/bpftool/btf.c             |  54 +------------
 tools/bpf/resolve_btfids/.gitignore |   4 +
 tools/bpf/resolve_btfids/main.c     |  58 +-------------
 tools/lib/bpf/btf.c                 | 114 +++++++++++++++++++---------
 tools/lib/bpf/btf.h                 |   5 +-
 tools/lib/bpf/libbpf.map            |   2 +
 6 files changed, 89 insertions(+), 148 deletions(-)
 create mode 100644 tools/bpf/resolve_btfids/.gitignore

--=20
2.24.1

