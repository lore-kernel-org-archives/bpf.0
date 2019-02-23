Return-Path: <SRS0=Kw1S=Q6=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9575EC43381
	for <bpf@archiver.kernel.org>; Sat, 23 Feb 2019 17:44:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AB16206BA
	for <bpf@archiver.kernel.org>; Sat, 23 Feb 2019 17:44:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550943879;
	bh=IoOlFonDNCcdXF/mlInNV2tBGmyj2O5lAR+6tB3dQmU=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-ID:From;
	b=MF1fLt/hhjsUTMlMBHIPZ/PLBGTeNmsjSfOpy7PkECEgIJglYSBscGCBYsTEOBgVg
	 U7+2E2alTo+X2E24fA5zdICGiHcSi6F7bC8BwNdj4gxKszYtU57hVa3wG+Lg+TnDkA
	 zOwWhe9b7Ghd2IY47rqVfWBOcLyt1m58vfNe/EsI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726466AbfBWRog convert rfc822-to-8bit (ORCPT
        <rfc822;bpf@archiver.kernel.org>); Sat, 23 Feb 2019 12:44:36 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:39402 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726234AbfBWRog (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sat, 23 Feb 2019 12:44:36 -0500
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1NHcHXP002917
        for <bpf@vger.kernel.org>; Sat, 23 Feb 2019 09:44:35 -0800
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2qu4vsrq24-9
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Sat, 23 Feb 2019 09:44:35 -0800
Received: from mx-out.facebook.com (2620:10d:c081:10::13) by
 mail.thefacebook.com (2620:10d:c081:35::129) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1531.3;
 Sat, 23 Feb 2019 09:44:32 -0800
Received: by devbig007.ftw2.facebook.com (Postfix, from userid 572438)
        id 0FC8B760812; Sat, 23 Feb 2019 09:44:29 -0800 (PST)
Smtp-Origin-Hostprefix: devbig
From:   Alexei Starovoitov <ast@kernel.org>
Smtp-Origin-Hostname: devbig007.ftw2.facebook.com
To:     <davem@davemloft.net>
CC:     <daniel@iogearbox.net>, <edumazet@google.com>,
        <netdev@vger.kernel.org>, <bpf@vger.kernel.org>,
        <kernel-team@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH v2 bpf-next 3/4] tools/bpf: sync bpf.h into tools
Date:   Sat, 23 Feb 2019 09:44:21 -0800
Message-ID: <20190223174422.663270-4-ast@kernel.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20190223174422.663270-1-ast@kernel.org>
References: <20190223174422.663270-1-ast@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-23_11:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

sync bpf.h into tools directory

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 tools/include/uapi/linux/bpf.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index bcdd2474eee7..d2cb85d85b39 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -2813,6 +2813,8 @@ struct bpf_prog_info {
 	__u32 jited_line_info_rec_size;
 	__u32 nr_prog_tags;
 	__aligned_u64 prog_tags;
+	__u64 runtime;
+	__u64 runcnt;
 } __attribute__((aligned(8)));
 
 struct bpf_map_info {
-- 
2.20.0

