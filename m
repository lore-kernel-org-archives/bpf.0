Return-Path: <SRS0=E2Hj=CT=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 342CDC433E2
	for <bpf@archiver.kernel.org>; Thu, 10 Sep 2020 22:53:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D8DB6208FE
	for <bpf@archiver.kernel.org>; Thu, 10 Sep 2020 22:52:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="pbvZNl8v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725385AbgIJWw5 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 10 Sep 2020 18:52:57 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:39794 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725497AbgIJWww (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 10 Sep 2020 18:52:52 -0400
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.42/8.16.0.42) with SMTP id 08AMlgio030610
        for <bpf@vger.kernel.org>; Thu, 10 Sep 2020 15:52:50 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=Tkj11c3eG/WxbgYHibOAwXdS4x/vdvYRGmRn4MTjy7Q=;
 b=pbvZNl8v7niXBDjSsmQlygBfYZsQjFxHs23Nd2l3eICkUEZNfqXDaioeTVgnDQ08OIi4
 hmIBXxEsbYdBlr9wyP7lYS+Fuy29CfMXEK8ugCcYQbZTfUXdT1Pz5t7+zo3CZ0MLudU5
 PA8wlHQvhUzSm6mt88zwteAudA7t1wd0uk8= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0001303.ppops.net with ESMTP id 33exvj198u-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 10 Sep 2020 15:52:50 -0700
Received: from intmgw002.08.frc2.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 10 Sep 2020 15:52:49 -0700
Received: by devbig012.ftw2.facebook.com (Postfix, from userid 137359)
        id 1FAA62EC6C39; Thu, 10 Sep 2020 15:52:48 -0700 (PDT)
From:   Andrii Nakryiko <andriin@fb.com>
To:     <bpf@vger.kernel.org>, <netdev@vger.kernel.org>, <ast@fb.com>,
        <daniel@iogearbox.net>
CC:     <andrii.nakryiko@gmail.com>, <kernel-team@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Subject: [PATCH bpf] docs/bpf: fix ringbuf documentation
Date:   Thu, 10 Sep 2020 15:52:45 -0700
Message-ID: <20200910225245.2896991-1-andriin@fb.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-10_10:2020-09-10,2020-09-10 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0
 lowpriorityscore=0 priorityscore=1501 suspectscore=8 clxscore=1015
 adultscore=0 impostorscore=0 spamscore=0 malwarescore=0 bulkscore=0
 mlxlogscore=951 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2006250000 definitions=main-2009100199
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Remove link to litmus tests that didn't make it to upstream. Fix ringbuf
benchmark link.

I wasn't able to test this with `make htmldocs`, unfortunately, because o=
f
Sphinx dependencies. But bench_ringbufs.c path is certainly correct now.

Reported-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Fixes: 97abb2b39682 ("docs/bpf: Add BPF ring buffer design notes")
Signed-off-by: Andrii Nakryiko <andriin@fb.com>
---
 Documentation/bpf/ringbuf.rst | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/Documentation/bpf/ringbuf.rst b/Documentation/bpf/ringbuf.rs=
t
index 75f943f0009d..4d4f3bcb1477 100644
--- a/Documentation/bpf/ringbuf.rst
+++ b/Documentation/bpf/ringbuf.rst
@@ -182,9 +182,6 @@ in the order of reservations, but only after all prev=
ious records where
 already committed. It is thus possible for slow producers to temporarily=
 hold
 off submitted records, that were reserved later.
=20
-Reservation/commit/consumer protocol is verified by litmus tests in
-Documentation/litmus_tests/bpf-rb/_.
-
 One interesting implementation bit, that significantly simplifies (and t=
hus
 speeds up as well) implementation of both producers and consumers is how=
 data
 area is mapped twice contiguously back-to-back in the virtual memory. Th=
is
@@ -200,7 +197,7 @@ a self-pacing notifications of new data being availab=
ility.
 being available after commit only if consumer has already caught up righ=
t up to
 the record being committed. If not, consumer still has to catch up and t=
hus
 will see new data anyways without needing an extra poll notification.
-Benchmarks (see tools/testing/selftests/bpf/benchs/bench_ringbuf.c_) sho=
w that
+Benchmarks (see tools/testing/selftests/bpf/benchs/bench_ringbufs.c_) sh=
ow that
 this allows to achieve a very high throughput without having to resort t=
o
 tricks like "notify only every Nth sample", which are necessary with per=
f
 buffer. For extreme cases, when BPF program wants more manual control of
--=20
2.24.1

