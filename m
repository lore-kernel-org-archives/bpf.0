Return-Path: <SRS0=qP+h=5D=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4203C2BB1D
	for <bpf@archiver.kernel.org>; Wed, 18 Mar 2020 03:15:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A28D20752
	for <bpf@archiver.kernel.org>; Wed, 18 Mar 2020 03:15:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="lPlRBCG3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726713AbgCRDO7 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 17 Mar 2020 23:14:59 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:23772 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726597AbgCRDO7 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 17 Mar 2020 23:14:59 -0400
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02I3EuNd016397
        for <bpf@vger.kernel.org>; Tue, 17 Mar 2020 20:14:58 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=facebook;
 bh=+kFPsMVhi9HZlxqWgOCcpftHZOADrXWFHmYOJVT+9RM=;
 b=lPlRBCG3Has7Mn+YxVISrLO8HmF4p8rHKHoGGmOYTXb8yo0nIgzrsU8av50DnrllD1tk
 LAZcSEXudRBGbtBT5048zw8OnevV9wM2DQ9VHMsoCkKoWxfzR7QBhhQz72gfRAy51Qak
 2rFtI135r8oYAmq+0igyGVUZ0Td44CuLdLY= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 2yua0wra2u-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 17 Mar 2020 20:14:58 -0700
Received: from intmgw004.08.frc2.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c085:21d::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1847.3; Tue, 17 Mar 2020 20:14:35 -0700
Received: by devbig005.ftw2.facebook.com (Postfix, from userid 6611)
        id 713F7294307C; Tue, 17 Mar 2020 20:14:31 -0700 (PDT)
Smtp-Origin-Hostprefix: devbig
From:   Martin KaFai Lau <kafai@fb.com>
Smtp-Origin-Hostname: devbig005.ftw2.facebook.com
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>,
        <netdev@vger.kernel.org>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH v3 bpf-next 0/4] bpftool: Add struct_ops support
Date:   Tue, 17 Mar 2020 20:14:31 -0700
Message-ID: <20200318031431.1256036-1-kafai@fb.com>
X-Mailer: git-send-email 2.17.1
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.645
 definitions=2020-03-17_10:2020-03-17,2020-03-17 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxlogscore=420
 priorityscore=1501 impostorscore=0 bulkscore=0 adultscore=0
 lowpriorityscore=0 phishscore=0 malwarescore=0 spamscore=0 clxscore=1015
 suspectscore=13 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003180016
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This set adds "struct_ops" support to bpftool.

The first two patches improve the btf_dumper in bpftool.
Patch 1: print the enum's name (if it is found) instead of the
         enum's value.
Patch 2: print a char[] as a string if all characters are printable.

"struct_ops" stores the prog_id in a func ptr.
Instead of printing a prog_id,
patch 3 adds an option to btf_dumper to allow a func ptr's value
to be printed with the full func_proto info and the prog_name.

Patch 4 implements the "struct_ops" bpftool command.

v3:
- Check for "case 1:" in patch 1 (Andrii)

v2:
- Typo fixes in comment and doc in patch 4 (Quentin)
- Link to a few other man pages in doc in patch 4 (Quentin)
- Alphabet ordering in include files in patch 4 (Quentin)
- Use GET_ARG() in patch 4 (Quentin)

Martin KaFai Lau (4):
  bpftool: Print the enum's name instead of value
  bpftool: Print as a string for char array
  bpftool: Translate prog_id to its bpf prog_name
  bpftool: Add struct_ops support

 .../Documentation/bpftool-struct_ops.rst      | 116 ++++
 tools/bpf/bpftool/bash-completion/bpftool     |  28 +
 tools/bpf/bpftool/btf_dumper.c                | 198 +++++-
 tools/bpf/bpftool/main.c                      |   3 +-
 tools/bpf/bpftool/main.h                      |   2 +
 tools/bpf/bpftool/struct_ops.c                | 596 ++++++++++++++++++
 6 files changed, 927 insertions(+), 16 deletions(-)
 create mode 100644 tools/bpf/bpftool/Documentation/bpftool-struct_ops.rst
 create mode 100644 tools/bpf/bpftool/struct_ops.c

-- 
2.17.1

