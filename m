Return-Path: <SRS0=P9GS=RC=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E456BC43381
	for <bpf@archiver.kernel.org>; Wed, 27 Feb 2019 22:47:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7EA6213A2
	for <bpf@archiver.kernel.org>; Wed, 27 Feb 2019 22:47:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="dlT77PTD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730254AbfB0Wqy (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 27 Feb 2019 17:46:54 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:33202 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730102AbfB0Wqx (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 27 Feb 2019 17:46:53 -0500
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1RMcuZX005773
        for <bpf@vger.kernel.org>; Wed, 27 Feb 2019 14:46:51 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=sFH4MoFp3GxAhDbV2cYE2ivPv+x1a5PpUyPPmIJ1L4g=;
 b=dlT77PTDxKxd0CHfL/iU7N5pWWgNUx/Xe7WeGksJtjTo+rDnuJzFFwvJgPVo5aM9gEiO
 vI2zSHA3FEeP5CX4fMA/pvOxgKXm4sUO6+1KkftqSuo4Xggqg69+OAfHlvP40BObkoYH
 C/MmYL5tYcVgAgYHij7pbprcrO0HkcoqVZc= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2qx2ywg4kw-16
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 27 Feb 2019 14:46:51 -0800
Received: from mx-out.facebook.com (2620:10d:c0a1:3::13) by
 mail.thefacebook.com (2620:10d:c021:18::175) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1531.3;
 Wed, 27 Feb 2019 14:46:48 -0800
Received: by devvm7221.prn2.facebook.com (Postfix, from userid 137359)
        id 94AD9C07CCD0; Wed, 27 Feb 2019 14:46:47 -0800 (PST)
Smtp-Origin-Hostprefix: devvm
From:   Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Hostname: devvm7221.prn2.facebook.com
To:     <andrii.nakryiko@gmail.com>, <kernel-team@fb.com>, <ast@fb.com>,
        <acme@kernel.org>, <netdev@vger.kernel.org>, <bpf@vger.kernel.org>,
        <daniel@iogearbox.net>
CC:     Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Cluster: prn2c23
Subject: [PATCH bpf-next 2/5] libbpf: fix formatting for btf_ext__get_raw_data
Date:   Wed, 27 Feb 2019 14:46:38 -0800
Message-ID: <20190227224642.1069138-3-andriin@fb.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190227224642.1069138-1-andriin@fb.com>
References: <20190227224642.1069138-1-andriin@fb.com>
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-27_15:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Fix invalid formatting of pointer arg.

Fixes: ae4ab4b4117d ("btf: expose API to work with raw btf_ext data")
Signed-off-by: Andrii Nakryiko <andriin@fb.com>
---
 tools/lib/bpf/btf.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/lib/bpf/btf.h b/tools/lib/bpf/btf.h
index 94bbc249b0f1..b60bb7cf5fff 100644
--- a/tools/lib/bpf/btf.h
+++ b/tools/lib/bpf/btf.h
@@ -76,7 +76,7 @@ LIBBPF_API int btf__get_map_kv_tids(const struct btf *btf, const char *map_name,
 
 LIBBPF_API struct btf_ext *btf_ext__new(__u8 *data, __u32 size);
 LIBBPF_API void btf_ext__free(struct btf_ext *btf_ext);
-LIBBPF_API const void *btf_ext__get_raw_data(const struct btf_ext* btf_ext,
+LIBBPF_API const void *btf_ext__get_raw_data(const struct btf_ext *btf_ext,
 					     __u32 *size);
 LIBBPF_API int btf_ext__reloc_func_info(const struct btf *btf,
 					const struct btf_ext *btf_ext,
-- 
2.17.1

