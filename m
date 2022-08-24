Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32B74C6498F
	for <bpf@archiver.kernel.org>; Wed, 24 Aug 2022 22:30:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229787AbiHXWaQ (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 24 Aug 2022 18:30:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229799AbiHXWaN (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 24 Aug 2022 18:30:13 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FF7F7648
        for <bpf@vger.kernel.org>; Wed, 24 Aug 2022 15:30:12 -0700 (PDT)
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.17.1.5/8.17.1.5) with ESMTP id 27OMHD8f017597
        for <bpf@vger.kernel.org>; Wed, 24 Aug 2022 15:30:11 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=Se4D6fYi5b+SEChDE8lSEIia0gEu3V+oHv1Vt4KSp/U=;
 b=PxXC+zVL+xesf6k6KpTFa08HsgpQetYnQ2tbWFgEtVjlHRcfFNv6Zbi/F8zcq3siMKhS
 gIJTzOVH2WV9obcDo9d3paNFRARwLQj9LI3KatMa4sYdiLE7qGFgpLSnfS9X+pZtENVX
 ya/7Zay7H5P+wcqOPV7gA3GpcPpCrAEc2Ik= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0089730.ppops.net (PPS) with ESMTPS id 3j4x1yvjdp-19
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 24 Aug 2022 15:30:11 -0700
Received: from twshared32421.14.frc2.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::e) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 24 Aug 2022 15:30:08 -0700
Received: by devbig933.frc1.facebook.com (Postfix, from userid 6611)
        id 80248871C97A; Wed, 24 Aug 2022 15:26:52 -0700 (PDT)
From:   Martin KaFai Lau <kafai@fb.com>
To:     <bpf@vger.kernel.org>, <netdev@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        David Miller <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>, <kernel-team@fb.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Stanislav Fomichev <sdf@google.com>
Subject: [PATCH bpf-next 08/17] net: Remove unused flags argument from do_ipv6_getsockopt
Date:   Wed, 24 Aug 2022 15:26:52 -0700
Message-ID: <20220824222652.1921006-1-kafai@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220824222601.1916776-1-kafai@fb.com>
References: <20220824222601.1916776-1-kafai@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: 1z9iQQea01Q8J5V8DirxumgBIlvMOwwE
X-Proofpoint-ORIG-GUID: 1z9iQQea01Q8J5V8DirxumgBIlvMOwwE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-24_14,2022-08-22_02,2022-06-22_01
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The 'unsigned int flags' argument is always 0, so it can be removed.

Signed-off-by: Martin KaFai Lau <kafai@fb.com>
---
 net/ipv6/ipv6_sockglue.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/ipv6/ipv6_sockglue.c b/net/ipv6/ipv6_sockglue.c
index a4535bdbd310..2894271c2c08 100644
--- a/net/ipv6/ipv6_sockglue.c
+++ b/net/ipv6/ipv6_sockglue.c
@@ -1133,7 +1133,7 @@ static int compat_ipv6_get_msfilter(struct sock *sk=
, void __user *optval,
 }
=20
 static int do_ipv6_getsockopt(struct sock *sk, int level, int optname,
-		    char __user *optval, int __user *optlen, unsigned int flags)
+		    char __user *optval, int __user *optlen)
 {
 	struct ipv6_pinfo *np =3D inet6_sk(sk);
 	int len;
@@ -1168,7 +1168,7 @@ static int do_ipv6_getsockopt(struct sock *sk, int =
level, int optname,
=20
 		msg.msg_control_user =3D optval;
 		msg.msg_controllen =3D len;
-		msg.msg_flags =3D flags;
+		msg.msg_flags =3D 0;
 		msg.msg_control_is_user =3D true;
=20
 		lock_sock(sk);
@@ -1492,7 +1492,7 @@ int ipv6_getsockopt(struct sock *sk, int level, int=
 optname,
 	if (level !=3D SOL_IPV6)
 		return -ENOPROTOOPT;
=20
-	err =3D do_ipv6_getsockopt(sk, level, optname, optval, optlen, 0);
+	err =3D do_ipv6_getsockopt(sk, level, optname, optval, optlen);
 #ifdef CONFIG_NETFILTER
 	/* we need to exclude all possible ENOPROTOOPTs except default case */
 	if (err =3D=3D -ENOPROTOOPT && optname !=3D IPV6_2292PKTOPTIONS) {
--=20
2.30.2

