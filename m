Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1714BC433EF
	for <bpf@archiver.kernel.org>; Fri, 25 Mar 2022 22:23:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233732AbiCYWZM convert rfc822-to-8bit (ORCPT
        <rfc822;bpf@archiver.kernel.org>); Fri, 25 Mar 2022 18:25:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233713AbiCYWZM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 25 Mar 2022 18:25:12 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E2B225592
        for <bpf@vger.kernel.org>; Fri, 25 Mar 2022 15:23:37 -0700 (PDT)
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 22PHONvM010140
        for <bpf@vger.kernel.org>; Fri, 25 Mar 2022 15:23:36 -0700
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3f1hjut8x5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 25 Mar 2022 15:23:36 -0700
Received: from twshared6447.05.prn5.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:11d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Fri, 25 Mar 2022 15:23:35 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 4274214D3EC37; Fri, 25 Mar 2022 15:23:19 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>
Subject: [PATCH bpf-next] selftests/bpf: fix selftest after random:urandom_read tracepoint removal
Date:   Fri, 25 Mar 2022 15:23:14 -0700
Message-ID: <20220325222314.3838278-1-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: tylbW1Hah9wVybgBnto22nwQV07mpMqx
X-Proofpoint-GUID: tylbW1Hah9wVybgBnto22nwQV07mpMqx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-25_08,2022-03-24_01,2022-02-23_01
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

14c174633f34 ("random: remove unused tracepoints") removed all the
tracepoints from drivers/char/random.c, one of which,
random:urandom_read, was used by stacktrace_build_id selftest to trigger
stack trace capture from two different kernel code paths.

Fix breakage by switching to kprobing chacha_block_generic() function which
is also called in both code paths that selftest uses for triggering.

Suggested-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/testing/selftests/bpf/progs/test_stacktrace_build_id.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/progs/test_stacktrace_build_id.c b/tools/testing/selftests/bpf/progs/test_stacktrace_build_id.c
index 36a707e7c7a7..698fef6d90bc 100644
--- a/tools/testing/selftests/bpf/progs/test_stacktrace_build_id.c
+++ b/tools/testing/selftests/bpf/progs/test_stacktrace_build_id.c
@@ -47,7 +47,7 @@ struct random_urandom_args {
 	int input_left;
 };
 
-SEC("tracepoint/random/urandom_read")
+SEC("kprobe/chacha_block_generic")
 int oncpu(struct random_urandom_args *args)
 {
 	__u32 max_len = sizeof(struct bpf_stack_build_id)
-- 
2.30.2

