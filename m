Return-Path: <SRS0=Nq9f=3D=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28099C33CB3
	for <bpf@archiver.kernel.org>; Tue, 14 Jan 2020 22:44:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E499D24673
	for <bpf@archiver.kernel.org>; Tue, 14 Jan 2020 22:44:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="OGcajhWN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728795AbgANWoG (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 14 Jan 2020 17:44:06 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:37522 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728827AbgANWoE (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 14 Jan 2020 17:44:04 -0500
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00EMhsT8020064
        for <bpf@vger.kernel.org>; Tue, 14 Jan 2020 14:44:03 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=facebook;
 bh=Jv/VhNZ8ABSGPShN5dnCdYgIamQhgkzjl0EizyqxjPQ=;
 b=OGcajhWNxzJNIlV8uzOAbd/8nYkr9ywYZVpHbHD8AlYNwFHOgE+okJPBkGwnoW91TaJf
 EpDJ23aj+fn1gotBfP4Y/jnirm92e7b2vnhdhzY96BBUWY/BgsMy7rSpAYw0Atrc2OzX
 oiv2yNAtcRcCJNQFb3+94kwo6yEegQ63ikA= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2xhd7r35c4-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 14 Jan 2020 14:44:03 -0800
Received: from intmgw001.06.prn3.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::d) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 14 Jan 2020 14:44:02 -0800
Received: by devbig005.ftw2.facebook.com (Postfix, from userid 6611)
        id EAED629438DC; Tue, 14 Jan 2020 14:43:58 -0800 (PST)
Smtp-Origin-Hostprefix: devbig
From:   Martin KaFai Lau <kafai@fb.com>
Smtp-Origin-Hostname: devbig005.ftw2.facebook.com
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        David Miller <davem@davemloft.net>, <kernel-team@fb.com>,
        <netdev@vger.kernel.org>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH bpf-next 0/5] bpftool: Support dumping a map with btf_vmlinux_value_type_id
Date:   Tue, 14 Jan 2020 14:43:58 -0800
Message-ID: <20200114224358.3027079-1-kafai@fb.com>
X-Mailer: git-send-email 2.17.1
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-14_06:2020-01-14,2020-01-14 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 suspectscore=13
 impostorscore=0 adultscore=0 malwarescore=0 mlxscore=0 phishscore=0
 spamscore=0 mlxlogscore=536 lowpriorityscore=0 clxscore=1015 bulkscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-2001140175
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

When a map is storing a kernel's struct, its
map_info->btf_vmlinux_value_type_id is set.  The first map type
supporting it is BPF_MAP_TYPE_STRUCT_OPS.

This series adds support to dump this kind of map with BTF.
The first two patches are bug fixes which only applicable to
in bpf-next.

Please see individual patches for details.

Martin KaFai Lau (5):
  bpftool: Fix a leak of btf object
  bpftool: Fix missing BTF output for json during map dump
  libbpf: Expose bpf_find_kernel_btf to libbpf_internal.h
  bpftool: Add struct_ops map name
  bpftool: Support dumping a map with btf_vmlinux_value_type_id

 tools/bpf/bpftool/map.c         | 84 ++++++++++++++++++---------------
 tools/lib/bpf/libbpf.c          |  3 +-
 tools/lib/bpf/libbpf_internal.h |  1 +
 3 files changed, 49 insertions(+), 39 deletions(-)

-- 
2.17.1

