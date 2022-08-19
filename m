Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37C39C32771
	for <bpf@archiver.kernel.org>; Fri, 19 Aug 2022 19:22:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351290AbiHSTWU (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 19 Aug 2022 15:22:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351278AbiHSTWF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 19 Aug 2022 15:22:05 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 493241155BB
        for <bpf@vger.kernel.org>; Fri, 19 Aug 2022 12:22:01 -0700 (PDT)
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27JEtp42030322
        for <bpf@vger.kernel.org>; Fri, 19 Aug 2022 12:22:00 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=hS2bjinWyu0onqCtvolwD7uEYB6y2Um7dQVHAfs2k4U=;
 b=dyU7u8Pnj/Hl4Mk2EcuaLVSLbdlYGjrHT1Z+ilIbq49Tp8E+5QNKakgohPo5t+CrdHbT
 rfIt3EEtKtyjR9wXx1jmRZCtVTPTL6/rFoVLgz3Uov/PWzg7eX+MYMvK0R2oP8AndzW+
 sRgldS1wMD7A6D+nxsA1yfmp1ppQzLpFYSo= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3j2cq7tf41-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 19 Aug 2022 12:22:00 -0700
Received: from ash-exhub102.TheFacebook.com (2620:10d:c0a8:82::f) by
 ash-exhub104.TheFacebook.com (2620:10d:c0a8:82::d) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 19 Aug 2022 12:21:59 -0700
Received: from twshared14818.18.frc3.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 19 Aug 2022 12:21:59 -0700
Received: by devbig933.frc1.facebook.com (Postfix, from userid 6611)
        id 7EE7383F94B5; Fri, 19 Aug 2022 12:21:55 -0700 (PDT)
From:   Martin KaFai Lau <kafai@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>
Subject: [PATCH bpf-next] selftest/bpf: Add setget_sockopt to DENYLIST.s390x
Date:   Fri, 19 Aug 2022 12:21:55 -0700
Message-ID: <20220819192155.91713-1-kafai@fb.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: eyJv4hvWajRDm3ioi-CeMJVcvB9us4Mj
X-Proofpoint-ORIG-GUID: eyJv4hvWajRDm3ioi-CeMJVcvB9us4Mj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-19_10,2022-08-18_01,2022-06-22_01
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Trampoline is not supported in s390.

Fixes: 31123c0360e0 ("selftests/bpf: bpf_setsockopt tests")
Signed-off-by: Martin KaFai Lau <kafai@fb.com>
---
 tools/testing/selftests/bpf/DENYLIST.s390x | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/bpf/DENYLIST.s390x b/tools/testing/s=
elftests/bpf/DENYLIST.s390x
index 9d8de15e725e..a708c3dcc154 100644
--- a/tools/testing/selftests/bpf/DENYLIST.s390x
+++ b/tools/testing/selftests/bpf/DENYLIST.s390x
@@ -65,3 +65,4 @@ send_signal                              # intermittent=
ly fails to receive signa
 select_reuseport                         # intermittently fails on new s=
390x setup
 xdp_synproxy                             # JIT does not support calling =
kernel function                                (kfunc)
 unpriv_bpf_disabled                      # fentry
+setget_sockopt                           # attach unexpected error: -524=
                                               (trampoline)
--=20
2.30.2

