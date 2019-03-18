Return-Path: <SRS0=JidB=RV=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 421EBC43381
	for <bpf@archiver.kernel.org>; Mon, 18 Mar 2019 17:37:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1298120989
	for <bpf@archiver.kernel.org>; Mon, 18 Mar 2019 17:37:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="cCT+FMvf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727127AbfCRRhP (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 18 Mar 2019 13:37:15 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:52030 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726513AbfCRRhP (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 18 Mar 2019 13:37:15 -0400
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.27/8.16.0.27) with SMTP id x2IHXNRY019687
        for <bpf@vger.kernel.org>; Mon, 18 Mar 2019 10:37:14 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=facebook;
 bh=e/RSEc06gHBdfA7eD81fCsQseZoQrCmuBDdTTkNTdFo=;
 b=cCT+FMvfbJHKVAqFsxMbH6g7vgS/UJR1skSojLDA7tCR85n0862IIWu2Y/i/gSf7nXil
 TR5N2zHOeJwjg39KZchpfun5NcrYzna5G5lOmpGHC6CdaV2OLufb3P5RREqjd9FKxSCc
 B/9CvTJi0Ht2FkP4MvAoI8T8r3uy6nEfg74= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by m0089730.ppops.net with ESMTP id 2raemsraba-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 18 Mar 2019 10:37:14 -0700
Received: from mx-out.facebook.com (2620:10d:c0a1:3::13) by
 mail.thefacebook.com (2620:10d:c021:18::171) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1713.5;
 Mon, 18 Mar 2019 10:37:13 -0700
Received: by devbig005.ftw2.facebook.com (Postfix, from userid 6611)
        id 3496929413C4; Mon, 18 Mar 2019 10:37:13 -0700 (PDT)
Smtp-Origin-Hostprefix: devbig
From:   Martin KaFai Lau <kafai@fb.com>
Smtp-Origin-Hostname: devbig005.ftw2.facebook.com
To:     <bpf@vger.kernel.org>, <netdev@vger.kernel.org>
CC:     Alexei Starovoitov <ast@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>,
        Naresh Kamboju <naresh.kamboju@linaro.org>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH bpf] bpf: Only print ref_obj_id for refcounted reg
Date:   Mon, 18 Mar 2019 10:37:13 -0700
Message-ID: <20190318173713.1413282-1-kafai@fb.com>
X-Mailer: git-send-email 2.17.1
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-18_11:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Naresh reported that test_align fails because of the mismatch at the
verbose printout of the register states.  The reason is due to the newly
added ref_obj_id.

ref_obj_id is only useful for refcounted reg.  Thus, this patch fixes it
by only printing ref_obj_id for refcounted reg.  While at it, it also uses
comma instead of space to separate between "id" and "ref_obj_id".

Fixes: 1b986589680a ("bpf: Fix bpf_tcp_sock and bpf_sk_fullsock issue related to bpf_sk_release")
Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
Signed-off-by: Martin KaFai Lau <kafai@fb.com>
---
 kernel/bpf/verifier.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 86f9cd5d1c4e..5aa810882583 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -352,6 +352,14 @@ static bool reg_may_point_to_spin_lock(const struct bpf_reg_state *reg)
 		map_value_has_spin_lock(reg->map_ptr);
 }
 
+static bool reg_type_may_be_refcounted_or_null(enum bpf_reg_type type)
+{
+	return type == PTR_TO_SOCKET ||
+		type == PTR_TO_SOCKET_OR_NULL ||
+		type == PTR_TO_TCP_SOCK ||
+		type == PTR_TO_TCP_SOCK_OR_NULL;
+}
+
 static bool arg_type_may_be_refcounted(enum bpf_arg_type type)
 {
 	return type == ARG_PTR_TO_SOCK_COMMON;
@@ -451,8 +459,9 @@ static void print_verifier_state(struct bpf_verifier_env *env,
 			if (t == PTR_TO_STACK)
 				verbose(env, ",call_%d", func(env, reg)->callsite);
 		} else {
-			verbose(env, "(id=%d ref_obj_id=%d", reg->id,
-				reg->ref_obj_id);
+			verbose(env, "(id=%d", reg->id);
+			if (reg_type_may_be_refcounted_or_null(t))
+				verbose(env, ",ref_obj_id=%d", reg->ref_obj_id);
 			if (t != SCALAR_VALUE)
 				verbose(env, ",off=%d", reg->off);
 			if (type_is_pkt_pointer(t))
-- 
2.17.1

