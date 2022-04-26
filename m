Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52AFFC433EF
	for <bpf@archiver.kernel.org>; Tue, 26 Apr 2022 00:45:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240384AbiDZAsc convert rfc822-to-8bit (ORCPT
        <rfc822;bpf@archiver.kernel.org>); Mon, 25 Apr 2022 20:48:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240359AbiDZAsb (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 25 Apr 2022 20:48:31 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCFFCDF7D
        for <bpf@vger.kernel.org>; Mon, 25 Apr 2022 17:45:25 -0700 (PDT)
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23Q0igQM015536
        for <bpf@vger.kernel.org>; Mon, 25 Apr 2022 17:45:24 -0700
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3fp6f98079-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 25 Apr 2022 17:45:24 -0700
Received: from twshared16308.14.prn3.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 25 Apr 2022 17:45:22 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id DF8C118FD8EC5; Mon, 25 Apr 2022 17:45:19 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>
Subject: [PATCH bpf-next 02/10] libbpf: drop unhelpful "program too large" guess
Date:   Mon, 25 Apr 2022 17:45:03 -0700
Message-ID: <20220426004511.2691730-3-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220426004511.2691730-1-andrii@kernel.org>
References: <20220426004511.2691730-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: x0-ajtv90pD_-y9_A5pEhIB27frLrddZ
X-Proofpoint-GUID: x0-ajtv90pD_-y9_A5pEhIB27frLrddZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-25_10,2022-04-25_03,2022-02-23_01
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

libbpf pretends it knows actual limit of BPF program instructions based
on UAPI headers it compiled with. There is neither any guarantee that
UAPI headers match host kernel, nor BPF verifier actually uses
BPF_MAXINSNS constant anymore. Just drop unhelpful "guess", BPF verifier
will emit actual reason for failure in its logs anyways.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/libbpf.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 873a29ce7781..5f2750af0e27 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -6828,10 +6828,6 @@ static int bpf_object_load_prog_instance(struct bpf_object *obj, struct bpf_prog
 		pr_warn("prog '%s': -- BEGIN PROG LOAD LOG --\n%s-- END PROG LOAD LOG --\n",
 			prog->name, log_buf);
 	}
-	if (insns_cnt >= BPF_MAXINSNS) {
-		pr_warn("prog '%s': program too large (%d insns), at most %d insns\n",
-			prog->name, insns_cnt, BPF_MAXINSNS);
-	}
 
 out:
 	if (own_log_buf)
-- 
2.30.2

