Return-Path: <SRS0=AFkz=DO=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B13E3C41604
	for <bpf@archiver.kernel.org>; Wed,  7 Oct 2020 06:29:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 514EA21548
	for <bpf@archiver.kernel.org>; Wed,  7 Oct 2020 06:29:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="goXrvAP+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726562AbgJGG3o (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 7 Oct 2020 02:29:44 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:50824 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726564AbgJGG3o (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 7 Oct 2020 02:29:44 -0400
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.42/8.16.0.42) with SMTP id 0976OvdM020862
        for <bpf@vger.kernel.org>; Tue, 6 Oct 2020 23:29:43 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=facebook; bh=sLui42BnNkRqlJsx4joO6DBykPUYfOkBZnRIOo3kdh4=;
 b=goXrvAP+C/nImLe4CqZjozlQKXeRDU+GxemkbfY+DbDirkCGsia3ajxZPYRgy/moQuqp
 qTlIfT4/YEjsggarh6QrlfP2vK5Wc5t8tf6CvqhPJBzjNlSm4IPPMNq5ApIARfD4Rilr
 DKLSO/jngrmTxwEaRaOCBy8kZDKwZ/OG8A8= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0089730.ppops.net with ESMTP id 33xmt09jar-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 06 Oct 2020 23:29:42 -0700
Received: from intmgw001.08.frc2.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 6 Oct 2020 23:29:41 -0700
Received: by devbig003.ftw2.facebook.com (Postfix, from userid 128203)
        id 6F2B537058FB; Tue,  6 Oct 2020 23:29:33 -0700 (PDT)
From:   Yonghong Song <yhs@fb.com>
To:     <bpf@vger.kernel.org>, <netdev@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>,
        Song Liu <songliubraving@fb.com>
Subject: [PATCH bpf-next] bpf: fix build failure for kernel/trace/bpf_trace.c with CONFIG_NET=n
Date:   Tue, 6 Oct 2020 23:29:33 -0700
Message-ID: <20201007062933.3425899-1-yhs@fb.com>
X-Mailer: git-send-email 2.24.1
X-FB-Internal: Safe
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-10-07_04:2020-10-06,2020-10-07 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 malwarescore=0
 suspectscore=0 impostorscore=0 mlxscore=0 spamscore=0 adultscore=0
 clxscore=1015 phishscore=0 bulkscore=0 lowpriorityscore=0
 priorityscore=1501 mlxlogscore=636 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2006250000 definitions=main-2010070042
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

When CONFIG_NET is not defined, I hit the following build error:
    kernel/trace/bpf_trace.o:(.rodata+0x110): undefined reference to `bpf_p=
rog_test_run_raw_tp'

Commit 1b4d60ec162f ("bpf: Enable BPF_PROG_TEST_RUN for raw_tracepoint")
added test_run support for raw_tracepoint in /kernel/trace/bpf_trace.c.
But the test_run function bpf_prog_test_run_raw_tp is defined in
net/bpf/test_run.c, only available with CONFIG_NET=3Dy.

Adding a CONFIG_NET guard for
    .test_run =3D bpf_prog_test_run_raw_tp;
fixed the above build issue.

Fixes: 1b4d60ec162f ("bpf: Enable BPF_PROG_TEST_RUN for raw_tracepoint")
Cc: Song Liu <songliubraving@fb.com>
Signed-off-by: Yonghong Song <yhs@fb.com>
---
 kernel/trace/bpf_trace.c | 2 ++
 1 file changed, 2 insertions(+)

Note: I found the above issue when I reviewed the following patch:
      https://lore.kernel.org/bpf/fcf3f659-027e-517f-086d-deb3ad33d953@fb.c=
om/T

diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index a136a6a63a71..a2a4535b6277 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -1780,7 +1780,9 @@ const struct bpf_verifier_ops raw_tracepoint_verifier=
_ops =3D {
 };
=20
 const struct bpf_prog_ops raw_tracepoint_prog_ops =3D {
+#ifdef CONFIG_NET
 	.test_run =3D bpf_prog_test_run_raw_tp,
+#endif
 };
=20
 const struct bpf_verifier_ops tracing_verifier_ops =3D {
--=20
2.24.1

