Return-Path: <SRS0=Nq9f=3D=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8516AC33CB2
	for <bpf@archiver.kernel.org>; Tue, 14 Jan 2020 22:44:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57F3924658
	for <bpf@archiver.kernel.org>; Tue, 14 Jan 2020 22:44:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="caQzMZ1r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728901AbgANWog (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 14 Jan 2020 17:44:36 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:37668 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728656AbgANWof (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 14 Jan 2020 17:44:35 -0500
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00EMiVBN013930
        for <bpf@vger.kernel.org>; Tue, 14 Jan 2020 14:44:34 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=GEVp/+/62LS/bb1ZozULgnaOZTQXXrPuUWpbugBkFGk=;
 b=caQzMZ1rtgr8l0gHkXusdubqUyw+6+q/1BSSUywU+1JKVn3fAnSbi9bAmwLZb2S8Q18U
 Ap+MXZRpLoMxKkMGSWogJ4kD9C2fmkVeXRtWTysxUZ7N2edVarXZn5lbwjeg/QwXoyCT
 +GVP4xQoHl2OBdLjlp74Lq9++06+A08PdQg= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2xhbr73n2b-7
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 14 Jan 2020 14:44:34 -0800
Received: from intmgw004.06.prn3.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 14 Jan 2020 14:44:25 -0800
Received: by devbig005.ftw2.facebook.com (Postfix, from userid 6611)
        id 9122F29438DC; Tue, 14 Jan 2020 14:44:19 -0800 (PST)
Smtp-Origin-Hostprefix: devbig
From:   Martin KaFai Lau <kafai@fb.com>
Smtp-Origin-Hostname: devbig005.ftw2.facebook.com
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        David Miller <davem@davemloft.net>, <kernel-team@fb.com>,
        <netdev@vger.kernel.org>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH bpf-next 4/5] bpftool: Add struct_ops map name
Date:   Tue, 14 Jan 2020 14:44:19 -0800
Message-ID: <20200114224419.3028615-1-kafai@fb.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200114224358.3027079-1-kafai@fb.com>
References: <20200114224358.3027079-1-kafai@fb.com>
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-14_06:2020-01-14,2020-01-14 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 phishscore=0 adultscore=0
 mlxscore=0 bulkscore=0 spamscore=0 lowpriorityscore=0 malwarescore=0
 mlxlogscore=756 priorityscore=1501 clxscore=1015 suspectscore=13
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-2001140175
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This patch adds BPF_MAP_TYPE_STRUCT_OPS to "struct_ops" name mapping
so that "bpftool map show" can print the "struct_ops" map type
properly.

[root@arch-fb-vm1 bpf]# ~/devshare/fb-kernel/linux/tools/bpf/bpftool/bpftool map show id 8
8: struct_ops  name dctcp  flags 0x0
	key 4B  value 256B  max_entries 1  memlock 4096B
	btf_id 7

Signed-off-by: Martin KaFai Lau <kafai@fb.com>
---
 tools/bpf/bpftool/map.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/bpf/bpftool/map.c b/tools/bpf/bpftool/map.c
index 45c1eda6512c..4c5b15d736b6 100644
--- a/tools/bpf/bpftool/map.c
+++ b/tools/bpf/bpftool/map.c
@@ -48,6 +48,7 @@ const char * const map_type_name[] = {
 	[BPF_MAP_TYPE_QUEUE]			= "queue",
 	[BPF_MAP_TYPE_STACK]			= "stack",
 	[BPF_MAP_TYPE_SK_STORAGE]		= "sk_storage",
+	[BPF_MAP_TYPE_STRUCT_OPS]		= "struct_ops",
 };
 
 const size_t map_type_name_size = ARRAY_SIZE(map_type_name);
-- 
2.17.1

