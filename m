Return-Path: <SRS0=G0Da=A2=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD977C433E5
	for <bpf@archiver.kernel.org>; Wed, 15 Jul 2020 19:52:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BDC382065F
	for <bpf@archiver.kernel.org>; Wed, 15 Jul 2020 19:52:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="M8u32IFf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727853AbgGOTvy (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 15 Jul 2020 15:51:54 -0400
Received: from forwardcorp1o.mail.yandex.net ([95.108.205.193]:53772 "EHLO
        forwardcorp1o.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727772AbgGOTvx (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 15 Jul 2020 15:51:53 -0400
Received: from sas1-ec30c78b6c5b.qloud-c.yandex.net (sas1-ec30c78b6c5b.qloud-c.yandex.net [IPv6:2a02:6b8:c14:2704:0:640:ec30:c78b])
        by forwardcorp1o.mail.yandex.net (Yandex) with ESMTP id AA0E62E15A2;
        Wed, 15 Jul 2020 22:51:46 +0300 (MSK)
Received: from sas2-32987e004045.qloud-c.yandex.net (sas2-32987e004045.qloud-c.yandex.net [2a02:6b8:c08:b889:0:640:3298:7e00])
        by sas1-ec30c78b6c5b.qloud-c.yandex.net (mxbackcorp/Yandex) with ESMTP id ygtTt1OuJS-pjsitabv;
        Wed, 15 Jul 2020 22:51:46 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1594842706; bh=RqA/HLcXXgTxGuzX8fzlAU37sCNS2YzPNEWNreLozuU=;
        h=In-Reply-To:Message-Id:References:Date:Subject:To:From:Cc;
        b=M8u32IFfIhlf7mQol6zyT5CN4tNb0WHOrt4KkpYpRItay8ms4THitW451kqyNU1IV
         yZswZp5klceFOYzebyBTmhw203JRMNz/xXw/6UrHxHm2dijhwgYRheT9QmhzHKI7w7
         5Ffh4pbrOTG0rBA8gIRx3tV9nzkoDAkp0yVEICeQ=
Authentication-Results: sas1-ec30c78b6c5b.qloud-c.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from 37.9.121.196-vpn.dhcp.yndx.net (37.9.121.196-vpn.dhcp.yndx.net [37.9.121.196])
        by sas2-32987e004045.qloud-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id kLmvqU3zdD-pjiKcoAL;
        Wed, 15 Jul 2020 22:51:45 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
From:   Dmitry Yakunin <zeil@yandex-team.ru>
To:     alexei.starovoitov@gmail.com, daniel@iogearbox.net,
        netdev@vger.kernel.org, bpf@vger.kernel.org
Cc:     sdf@google.com
Subject: [PATCH bpf-next v3 1/4] bpf: setup socket family and addresses in bpf_prog_test_run_skb
Date:   Wed, 15 Jul 2020 22:51:29 +0300
Message-Id: <20200715195132.4286-2-zeil@yandex-team.ru>
In-Reply-To: <20200715195132.4286-1-zeil@yandex-team.ru>
References: <20200715195132.4286-1-zeil@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Now it's impossible to test all branches of cgroup_skb bpf program which
accesses skb->family and skb->{local,remote}_ip{4,6} fields because they
are zeroed during socket allocation. This commit fills socket family and
addresses from related fields in constructed skb.

v2:
  - fix build without CONFIG_IPV6 (kernel test robot <lkp@intel.com>)

Signed-off-by: Dmitry Yakunin <zeil@yandex-team.ru>
---
 net/bpf/test_run.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
index bfd4ccd..0c3283d 100644
--- a/net/bpf/test_run.c
+++ b/net/bpf/test_run.c
@@ -432,6 +432,23 @@ int bpf_prog_test_run_skb(struct bpf_prog *prog, const union bpf_attr *kattr,
 	skb->protocol = eth_type_trans(skb, current->nsproxy->net_ns->loopback_dev);
 	skb_reset_network_header(skb);
 
+	switch (skb->protocol) {
+	case htons(ETH_P_IP):
+		sk->sk_family = AF_INET;
+		sk->sk_rcv_saddr = ip_hdr(skb)->saddr;
+		sk->sk_daddr = ip_hdr(skb)->daddr;
+		break;
+#if IS_ENABLED(CONFIG_IPV6)
+	case htons(ETH_P_IPV6):
+		sk->sk_family = AF_INET6;
+		sk->sk_v6_rcv_saddr = ipv6_hdr(skb)->saddr;
+		sk->sk_v6_daddr = ipv6_hdr(skb)->daddr;
+		break;
+#endif
+	default:
+		break;
+	}
+
 	if (is_l2)
 		__skb_push(skb, hh_len);
 	if (is_direct_pkt_access)
-- 
2.7.4

