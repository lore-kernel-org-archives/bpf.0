Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED75EC19F28
	for <bpf@archiver.kernel.org>; Wed, 27 Jul 2022 06:09:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230187AbiG0GJr (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 27 Jul 2022 02:09:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230250AbiG0GJn (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 27 Jul 2022 02:09:43 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1AA4402C1
        for <bpf@vger.kernel.org>; Tue, 26 Jul 2022 23:09:42 -0700 (PDT)
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26QND9Dl029540
        for <bpf@vger.kernel.org>; Tue, 26 Jul 2022 23:09:42 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=t2qYenmu3xZuB5RYl+s2v8VQSwmD4QgYS86NCfp4PNw=;
 b=QEMTcEcjfuEtHNovDewxYFaN55wllugJZlI6YWDQH9XvjOlFVi0CBWsObPVXW9oBo5gB
 3DQH7g8mHqwvwMPDVzVxVGqpBZwktFdaohSpp4Xi8WbkTik6jfsToqVLBHp13zNtFznE
 piKLKOzzGNNuoEg7q8xbOAj1gGFtTsZjjXo= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3hj1ust335-8
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 26 Jul 2022 23:09:42 -0700
Received: from twshared20276.35.frc1.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Tue, 26 Jul 2022 23:09:32 -0700
Received: by devbig933.frc1.facebook.com (Postfix, from userid 6611)
        id 13DD3757CC9E; Tue, 26 Jul 2022 23:09:28 -0700 (PDT)
From:   Martin KaFai Lau <kafai@fb.com>
To:     <bpf@vger.kernel.org>, <netdev@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        David Miller <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>, <kernel-team@fb.com>,
        Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH bpf-next 05/14] bpf: net: Avoid do_ip_setsockopt() taking sk lock when called from bpf
Date:   Tue, 26 Jul 2022 23:09:28 -0700
Message-ID: <20220727060928.2374257-1-kafai@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220727060856.2370358-1-kafai@fb.com>
References: <20220727060856.2370358-1-kafai@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: ZkVqeuNzE_-ypMPkvndsJDxpHrk92qCW
X-Proofpoint-ORIG-GUID: ZkVqeuNzE_-ypMPkvndsJDxpHrk92qCW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-26_07,2022-07-26_01,2022-06-22_01
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Similar to the earlier patch that avoids sock_setsockopt() from
taking sk lock when called from bpf.  This patch changes
do_ip_setsockopt() to use the {lock,release}_sock_sockopt().

Signed-off-by: Martin KaFai Lau <kafai@fb.com>
---
 net/ipv4/ip_sockglue.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/ipv4/ip_sockglue.c b/net/ipv4/ip_sockglue.c
index a8a323ecbb54..8271ad565a3a 100644
--- a/net/ipv4/ip_sockglue.c
+++ b/net/ipv4/ip_sockglue.c
@@ -944,7 +944,7 @@ static int do_ip_setsockopt(struct sock *sk, int leve=
l, int optname,
 	err =3D 0;
 	if (needs_rtnl)
 		rtnl_lock();
-	lock_sock(sk);
+	lock_sock_sockopt(sk, optval);
=20
 	switch (optname) {
 	case IP_OPTIONS:
@@ -1368,13 +1368,13 @@ static int do_ip_setsockopt(struct sock *sk, int =
level, int optname,
 		err =3D -ENOPROTOOPT;
 		break;
 	}
-	release_sock(sk);
+	release_sock_sockopt(sk, optval);
 	if (needs_rtnl)
 		rtnl_unlock();
 	return err;
=20
 e_inval:
-	release_sock(sk);
+	release_sock_sockopt(sk, optval);
 	if (needs_rtnl)
 		rtnl_unlock();
 	return -EINVAL;
--=20
2.30.2

