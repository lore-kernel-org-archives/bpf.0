Return-Path: <SRS0=vk/n=RD=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3116BC43381
	for <bpf@archiver.kernel.org>; Thu, 28 Feb 2019 23:31:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E75B720830
	for <bpf@archiver.kernel.org>; Thu, 28 Feb 2019 23:31:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="c3jY1F3c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730852AbfB1Xbb (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 28 Feb 2019 18:31:31 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:37332 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726631AbfB1Xbb (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 28 Feb 2019 18:31:31 -0500
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.27/8.16.0.27) with SMTP id x1SNSZwb002203
        for <bpf@vger.kernel.org>; Thu, 28 Feb 2019 15:31:29 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=dpZLcbOpJtqNjue0D0FFGgsQK5vt4wX6LcRJXPB4jsU=;
 b=c3jY1F3c1D/7l+kIFzup8OWo5jjxYBXMmHrLgygLTgda1lffwWlOPlaayq/gPCTjZao4
 YQ3bnpODn4IYu9hAh/TA8WZyPDFvHfT4X36crSb7DB91TsazWwZsGuNYcqnwWCBzlPcn
 aJ3fAtThGM8l4oOcv+avikNYG/LeonmdJqc= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by m0089730.ppops.net with ESMTP id 2qxrh085ca-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 28 Feb 2019 15:31:29 -0800
Received: from mx-out.facebook.com (2620:10d:c0a1:3::13) by
 mail.thefacebook.com (2620:10d:c021:18::171) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1713.5;
 Thu, 28 Feb 2019 15:31:27 -0800
Received: by devvm7221.prn2.facebook.com (Postfix, from userid 137359)
        id CB9C2C155DDC; Thu, 28 Feb 2019 15:31:26 -0800 (PST)
Smtp-Origin-Hostprefix: devvm
From:   Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Hostname: devvm7221.prn2.facebook.com
To:     <andrii.nakryiko@gmail.com>, <kernel-team@fb.com>, <ast@fb.com>,
        <acme@kernel.org>, <netdev@vger.kernel.org>, <bpf@vger.kernel.org>,
        <daniel@iogearbox.net>, <songliubraving@fb.com>
CC:     Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Cluster: prn2c23
Subject: [PATCH v2 bpf-next 2/5] libbpf: fix formatting for btf_ext__get_raw_data
Date:   Thu, 28 Feb 2019 15:31:22 -0800
Message-ID: <20190228233125.1013080-3-andriin@fb.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190228233125.1013080-1-andriin@fb.com>
References: <20190228233125.1013080-1-andriin@fb.com>
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-28_15:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Fix invalid formatting of pointer arg.

Signed-off-by: Andrii Nakryiko <andriin@fb.com>
Acked-by: Song Liu <songliubraving@fb.com>
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

