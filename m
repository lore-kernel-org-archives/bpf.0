Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6922BC4332F
	for <bpf@archiver.kernel.org>; Thu, 10 Nov 2022 18:02:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231718AbiKJSCr (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 10 Nov 2022 13:02:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231761AbiKJSCW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 10 Nov 2022 13:02:22 -0500
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 534624D5C9
        for <bpf@vger.kernel.org>; Thu, 10 Nov 2022 10:02:03 -0800 (PST)
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.17.1.5/8.17.1.5) with ESMTP id 2AAELOsN025954
        for <bpf@vger.kernel.org>; Thu, 10 Nov 2022 10:02:02 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=NKQB4Ev1rEtTcyg271Lvtr5zhSjiWNaEOiL1osiMzvk=;
 b=FTI9n76qnNKG04ssAYJh9uRAaV4uuev9t53RWuHmHlkLcSpm/Tlsdhk0moQb3zmF3gDW
 YjktD1+uvUQLWOgRFhj/lthw7PTfjxeJdQQ0Pq+m911pxKNF/p3+pzD6iK1iJN0VtVzQ
 xwtbvpfUfGBDWSxFPRbQ90ztN10vWSPWeGA= 
Received: from maileast.thefacebook.com ([163.114.130.3])
        by m0001303.ppops.net (PPS) with ESMTPS id 3krca3brq6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 10 Nov 2022 10:02:02 -0800
Received: from twshared14438.02.ash8.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 10 Nov 2022 10:02:01 -0800
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
        id 1C6B211F22DFB; Thu, 10 Nov 2022 10:01:51 -0800 (PST)
From:   Yonghong Song <yhs@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>,
        Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next v4 5/7] bpf: Enable sleeptable support for cgrp local storage
Date:   Thu, 10 Nov 2022 10:01:51 -0800
Message-ID: <20221110180151.915563-1-yhs@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221110180124.913882-1-yhs@fb.com>
References: <20221110180124.913882-1-yhs@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: IKmqYS9ra0iULwMVa7jFQuO9c-YYaKtC
X-Proofpoint-ORIG-GUID: IKmqYS9ra0iULwMVa7jFQuO9c-YYaKtC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-10_12,2022-11-09_01,2022-06-22_01
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

With proper bpf_rcu_read_lock() support, sleepable support for cgrp local
storage can be enabled as typical use case task->cgroups->dfl_cgrp
can be protected with bpf_rcu_read_lock().

Signed-off-by: Yonghong Song <yhs@fb.com>
---
 kernel/bpf/verifier.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 2aa140dceb9a..92cd1cf64026 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -12958,10 +12958,11 @@ static int check_map_prog_compatibility(struct =
bpf_verifier_env *env,
 		case BPF_MAP_TYPE_INODE_STORAGE:
 		case BPF_MAP_TYPE_SK_STORAGE:
 		case BPF_MAP_TYPE_TASK_STORAGE:
+		case BPF_MAP_TYPE_CGRP_STORAGE:
 			break;
 		default:
 			verbose(env,
-				"Sleepable programs can only use array, hash, and ringbuf maps\n");
+				"Sleepable programs can only use array, hash, ringbuf and local stor=
age maps\n");
 			return -EINVAL;
 		}
=20
--=20
2.30.2

