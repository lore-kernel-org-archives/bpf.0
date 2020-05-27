Return-Path: <SRS0=ObQj=7J=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F16AC433E0
	for <bpf@archiver.kernel.org>; Wed, 27 May 2020 20:00:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 675E320835
	for <bpf@archiver.kernel.org>; Wed, 27 May 2020 20:00:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="r5wb0IwK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728019AbgE0UAK (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 27 May 2020 16:00:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727899AbgE0UAJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 27 May 2020 16:00:09 -0400
Received: from forwardcorp1p.mail.yandex.net (forwardcorp1p.mail.yandex.net [IPv6:2a02:6b8:0:1472:2741:0:8b6:217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76615C05BD1E;
        Wed, 27 May 2020 13:00:09 -0700 (PDT)
Received: from mxbackcorp2j.mail.yandex.net (mxbackcorp2j.mail.yandex.net [IPv6:2a02:6b8:0:1619::119])
        by forwardcorp1p.mail.yandex.net (Yandex) with ESMTP id 5B5DA2E12EE;
        Wed, 27 May 2020 23:00:07 +0300 (MSK)
Received: from vla1-81430ab5870b.qloud-c.yandex.net (vla1-81430ab5870b.qloud-c.yandex.net [2a02:6b8:c0d:35a1:0:640:8143:ab5])
        by mxbackcorp2j.mail.yandex.net (mxbackcorp/Yandex) with ESMTP id 1xIuqmhcc7-03fatEW3;
        Wed, 27 May 2020 23:00:07 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1590609607; bh=uSK+OBDgw29F63KnYsd7s3gqiYFBGfZuRwqWVCvZ3gU=;
        h=In-Reply-To:Message-Id:References:Date:Subject:To:From:Cc;
        b=r5wb0IwKapaDLrMtxrQhuiTqY1UM8u/+gODDfdpMsG7cRiNg9HORNQqjj01sSd5aT
         zxEDLW9I3L88eKbzxQsciWy+eQ2V2xzPoYLkbUJemiQdgpCEqftEde9ke0L5ek4CEA
         aPK7+9gMp5oa+pM7Fer1Y6qDbEC97JC0elGaXEzY=
Authentication-Results: mxbackcorp2j.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from 178.154.179.134-vpn.dhcp.yndx.net (178.154.179.134-vpn.dhcp.yndx.net [178.154.179.134])
        by vla1-81430ab5870b.qloud-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id p1CLlcPIkt-03W0tHJ8;
        Wed, 27 May 2020 23:00:03 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
From:   Dmitry Yakunin <zeil@yandex-team.ru>
To:     davem@davemloft.net, brakmo@fb.com, eric.dumazet@gmail.com
Cc:     kafai@fb.com, bpf@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH bpf-next v2 3/3] bpf: add SO_KEEPALIVE and related options to bpf_setsockopt
Date:   Wed, 27 May 2020 22:58:49 +0300
Message-Id: <20200527195849.97118-3-zeil@yandex-team.ru>
In-Reply-To: <20200527195849.97118-1-zeil@yandex-team.ru>
References: <20200527195849.97118-1-zeil@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This patch adds support of SO_KEEPALIVE flag and TCP related options
to bpf_setsockopt() routine. This is helpful if we want to enable or tune
TCP keepalive for applications which don't do it in the userspace code.

Signed-off-by: Dmitry Yakunin <zeil@yandex-team.ru>
Acked-by: Martin KaFai Lau <kafai@fb.com>
---
 net/core/filter.c | 39 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 38 insertions(+), 1 deletion(-)

diff --git a/net/core/filter.c b/net/core/filter.c
index a6fc234..f125f9d 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -4248,8 +4248,8 @@ static const struct bpf_func_proto bpf_get_socket_uid_proto = {
 static int _bpf_setsockopt(struct sock *sk, int level, int optname,
 			   char *optval, int optlen, u32 flags)
 {
+	int val, valbool;
 	int ret = 0;
-	int val;
 
 	if (!sk_fullsock(sk))
 		return -EINVAL;
@@ -4260,6 +4260,7 @@ static int _bpf_setsockopt(struct sock *sk, int level, int optname,
 		if (optlen != sizeof(int))
 			return -EINVAL;
 		val = *((int *)optval);
+		valbool = val ? 1 : 0;
 
 		/* Only some socketops are supported */
 		switch (optname) {
@@ -4298,6 +4299,11 @@ static int _bpf_setsockopt(struct sock *sk, int level, int optname,
 				sk_dst_reset(sk);
 			}
 			break;
+		case SO_KEEPALIVE:
+			if (sk->sk_prot->keepalive)
+				sk->sk_prot->keepalive(sk, valbool);
+			sock_valbool_flag(sk, SOCK_KEEPOPEN, valbool);
+			break;
 		default:
 			ret = -EINVAL;
 		}
@@ -4358,6 +4364,7 @@ static int _bpf_setsockopt(struct sock *sk, int level, int optname,
 			ret = tcp_set_congestion_control(sk, name, false,
 							 reinit, true);
 		} else {
+			struct inet_connection_sock *icsk = inet_csk(sk);
 			struct tcp_sock *tp = tcp_sk(sk);
 
 			if (optlen != sizeof(int))
@@ -4386,6 +4393,36 @@ static int _bpf_setsockopt(struct sock *sk, int level, int optname,
 				else
 					tp->save_syn = val;
 				break;
+			case TCP_KEEPIDLE:
+				if (val < 1 || val > MAX_TCP_KEEPIDLE)
+					ret = -EINVAL;
+				else
+					keepalive_time_set(sk, val);
+				break;
+			case TCP_KEEPINTVL:
+				if (val < 1 || val > MAX_TCP_KEEPINTVL)
+					ret = -EINVAL;
+				else
+					tp->keepalive_intvl = val * HZ;
+				break;
+			case TCP_KEEPCNT:
+				if (val < 1 || val > MAX_TCP_KEEPCNT)
+					ret = -EINVAL;
+				else
+					tp->keepalive_probes = val;
+				break;
+			case TCP_SYNCNT:
+				if (val < 1 || val > MAX_TCP_SYNCNT)
+					ret = -EINVAL;
+				else
+					icsk->icsk_syn_retries = val;
+				break;
+			case TCP_USER_TIMEOUT:
+				if (val < 0)
+					ret = -EINVAL;
+				else
+					icsk->icsk_user_timeout = val;
+				break;
 			default:
 				ret = -EINVAL;
 			}
-- 
2.7.4

